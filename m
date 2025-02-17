Return-Path: <linux-kselftest+bounces-26776-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45881A38312
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Feb 2025 13:38:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2ACBF7A1A63
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Feb 2025 12:37:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BF6B21A95D;
	Mon, 17 Feb 2025 12:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="eBgdJQEz"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39C711A5BA4;
	Mon, 17 Feb 2025 12:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739795866; cv=none; b=VDxBODCIUHeAVy/mqwpX3XKAJ3WVEOIhAhD7kV/yu5t/Qy+DKOY619s/OvPKqQ7zbYFqy1xOQsNd2dAvjHQ1GrD18q90THnVYsxporWBRITzU6L+JswKLFe7F6jkbA/7lK6os+HtWn/puHwIASesbJjEmDdcFkHNzciWW9jTGG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739795866; c=relaxed/simple;
	bh=mZzKihe2R4AeNltn5V5ya+wh7hY4j98NTVDIxiw5HPA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KbK6kvSw6N9h0tETb3c0lExD+v9tLBaaAmILNaeb3phWmjV0QPdONqcAPHE1QHX+nTUzADS9R0ObAMJu8iwoIqF0ioGKIamhqrr4MNkj0x3GxiK/HV07hdrdh2Mk0Kb7zgb7Fi67+NAHeVwgoeUhqR0nJw3me2HMlS/wo95155o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=eBgdJQEz; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 51CA8442DF;
	Mon, 17 Feb 2025 12:37:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1739795861;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6+tzLfaFZqkqHQMe4gTyO4D+W5I8sg9zaCereRpJS2A=;
	b=eBgdJQEzBthDRYbwStmJVO+wxfYFnnGavpQgDiKis0qd3QfD4EPlnNAuYQWubK832uyodd
	GOXZ+y3PVL0YoDgixgJtCIpLb2m2MwAtLmgKoWG5p045ikdaMwINhKYloU3p+0HjB2tlhw
	rTJtq7G8FuVqGK0jfqgYpbdOt6P6uakKeAj+udypIt9hz1Doi2To33YMei9UotIKaJGQEA
	GL9r/HdiAIPzpV+T233TqZp1ZB7GgGGBHiHGs2rl6UrQYVqT+LRCrrShts0zMhrVEIj3A7
	jrJK5d24N1nWlxgJTC1lHaxzOYUs3RbfBj71i8XtTT8bZUwRd9UJqtvVD+UdGg==
From: "Bastien Curutchet (eBPF Foundation)" <bastien.curutchet@bootlin.com>
Date: Mon, 17 Feb 2025 13:37:38 +0100
Subject: [PATCH bpf-next 1/3] selftests/bpf: tc_helpers: Add
 create_and_open_tid_ns()
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250217-tc_links-v1-1-27f7965e3dcd@bootlin.com>
References: <20250217-tc_links-v1-0-27f7965e3dcd@bootlin.com>
In-Reply-To: <20250217-tc_links-v1-0-27f7965e3dcd@bootlin.com>
To: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, 
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
 Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>, 
 Shuah Khan <shuah@kernel.org>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Alexis Lothore <alexis.lothore@bootlin.com>, bpf@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 "Bastien Curutchet (eBPF Foundation)" <bastien.curutchet@bootlin.com>
X-Mailer: b4 0.14.2
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdehkeegvdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpedfuegrshhtihgvnhcuvehurhhuthgthhgvthculdgvuefrhfcuhfhouhhnuggrthhiohhnmddfuceosggrshhtihgvnhdrtghurhhuthgthhgvthessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepgeefudfhuedttdeiffetffeljeffkeevveeiuddtgeejleeftdejgedtjedttdfhnecukfhppeeltddrkeelrdduieefrdduvdejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepledtrdekledrudeifedruddvjedphhgvlhhopegludelvddrudeikedrtddrudegngdpmhgrihhlfhhrohhmpegsrghsthhivghnrdgtuhhruhhttghhvghtsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopedvtddprhgtphhtthhopehshhhurghhsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehsohhngheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprghstheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhhohhhnrdhfrghsthgrsggvnhgusehgmhgrihhlrdgtohhmpdhrtghpthhtoheprghnughri
 hhisehkvghrnhgvlhdrohhrghdprhgtphhtthhopehsughfsehfohhmihgthhgvvhdrmhgvpdhrtghpthhtohephihonhhghhhonhhgrdhsohhngheslhhinhhugidruggvvhdprhgtphhtthhopegvugguhiiikeejsehgmhgrihhlrdgtohhm
X-GND-Sasl: bastien.curutchet@bootlin.com

Add a create_and_open_tid_ns() helper that creates a new network
namespace and open it.

Use the append_tid() helper to ensure the uniqueness of the namespace
name.

Signed-off-by: Bastien Curutchet (eBPF Foundation) <bastien.curutchet@bootlin.com>
---
 tools/testing/selftests/bpf/prog_tests/tc_helpers.h | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/tc_helpers.h b/tools/testing/selftests/bpf/prog_tests/tc_helpers.h
index 924d0e25320c71691998d6fce4d0aae367457862..8689ecd88fa89f4e622729d4f1b6d33c25fa89d8 100644
--- a/tools/testing/selftests/bpf/prog_tests/tc_helpers.h
+++ b/tools/testing/selftests/bpf/prog_tests/tc_helpers.h
@@ -3,6 +3,7 @@
 #ifndef TC_HELPERS
 #define TC_HELPERS
 #include <test_progs.h>
+#include "network_helpers.h"
 
 #ifndef loopback
 # define loopback 1
@@ -75,4 +76,15 @@ static inline void tc_skel_reset_all_seen(struct test_tc_link *skel)
 	memset(skel->bss, 0, sizeof(*skel->bss));
 }
 
+static inline struct netns_obj *create_and_open_tid_ns(char *ns_name, size_t sz)
+{
+	if (!ns_name)
+		return NULL;
+
+	if (append_tid(ns_name, sz))
+		return NULL;
+
+	return netns_new(ns_name, true);
+}
+
 #endif /* TC_HELPERS */

-- 
2.48.1


