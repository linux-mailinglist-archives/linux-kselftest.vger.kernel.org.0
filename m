Return-Path: <linux-kselftest+bounces-26977-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D319A3C2B3
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Feb 2025 15:53:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3F3E17A7AF9
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Feb 2025 14:52:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4976B1F30DD;
	Wed, 19 Feb 2025 14:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="nsNuFiOX"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D32A41E98E3;
	Wed, 19 Feb 2025 14:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739976787; cv=none; b=evxd8CnPDZa1gJDfSfu3rKqPVfPPEJn3oFeSu1wUCBLSuPqi14A1vpRbp1J+EwQjPEx1UPfsEPtJHMXwjQfXJjNGVaEX8Exx1qnT8u9cSPbEAFbqZNj5peSxkyepB5paN8Wtbz4Jpu2zxRb2DwNyogyOzQ21sDCRQjfGBVUrCyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739976787; c=relaxed/simple;
	bh=E3nXGd3Ov9CSjx2tN1OVXfhib1zGcaM89GvuctFuJNE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=leYGDpCNbFwfcr2IKUws9iiqSp9X3Rav15ytKTcc85qXx7SSr438oqALwe5JFxdE4nxZSMkOZupjtUAQcJqL5W2NlXZcizJg+uXypOQMiHEDUs9HpcyL3PE5ZA0qfyECZO+BNKGvIp7XFiYm6oQFzTxspAsL40j8CX5/R6oy+2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=nsNuFiOX; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 61FED204D5;
	Wed, 19 Feb 2025 14:53:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1739976783;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EjVOX0C05L2P05iVrfwGPzlMP0Umv5bwaDC8GO7iYCM=;
	b=nsNuFiOX8cV6+ZG1v68uN+y/kM3R7j6LNjyTkaxCO00qdrzpkdDnz6mh1Q1MKnCwQVX4su
	w6X+egngCZ+QFC8izY2zkQzvnnVEdQqGErh3ukWftx02CKZlE6eIjt348QNcrX6u6QpqCi
	4vT9pHF55daJP014d+JGBAkiF/WcJPK0GVjHT4wrxr3FQC5o47SQwX4PSdHEzgWr0DLaSa
	l5jg8l6jWOkmD5fMg0My6rLQAmZfrKd2G8bgHxlu+zP0OJlTVlyqYeI6ueQ6iq+4UHF541
	SpJrn97Cvn2q0tCEnXeM2GuzQt64uERVxp+wJ3awXINAZpj8XgB5YNxwX7Fzzw==
From: "Bastien Curutchet (eBPF Foundation)" <bastien.curutchet@bootlin.com>
Date: Wed, 19 Feb 2025 15:53:00 +0100
Subject: [PATCH bpf-next v2 1/4] selftests/bpf: ns_current_pid_tgid: Rename
 the test function
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250219-b4-tc_links-v2-1-14504db136b7@bootlin.com>
References: <20250219-b4-tc_links-v2-0-14504db136b7@bootlin.com>
In-Reply-To: <20250219-b4-tc_links-v2-0-14504db136b7@bootlin.com>
To: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, 
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
 Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>, 
 Shuah Khan <shuah@kernel.org>
Cc: Alexis Lothore <alexis.lothore@bootlin.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, bpf@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 "Bastien Curutchet (eBPF Foundation)" <bastien.curutchet@bootlin.com>
X-Mailer: b4 0.14.2
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeigeehgecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpedfuegrshhtihgvnhcuvehurhhuthgthhgvthculdgvuefrhfcuhfhouhhnuggrthhiohhnmddfuceosggrshhtihgvnhdrtghurhhuthgthhgvthessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepgeefudfhuedttdeiffetffeljeffkeevveeiuddtgeejleeftdejgedtjedttdfhnecukfhppeeltddrkeelrdduieefrdduvdejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepledtrdekledrudeifedruddvjedphhgvlhhopegludelvddrudeikedrtddrudegngdpmhgrihhlfhhrohhmpegsrghsthhivghnrdgtuhhruhhttghhvghtsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopedvtddprhgtphhtthhopegrnhgurhhiiheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohephhgrohhluhhosehgohhoghhlvgdrtghomhdprhgtphhtthhopegsphhfsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprghstheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohephihonhhghhhon
 hhgrdhsohhngheslhhinhhugidruggvvhdprhgtphhtthhopehthhhomhgrshdrphgvthgriiiiohhnihessghoohhtlhhinhdrtghomhdprhgtphhtthhopehsohhngheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhholhhsrgeskhgvrhhnvghlrdhorhhg
X-GND-Sasl: bastien.curutchet@bootlin.com

Next patch will add a new feature to test_prog to run tests in a
dedicated namespace if the test name starts with 'ns_'. Here the test
name already starts with 'ns_' and creates some namespaces which would
conflict with the new feature.

Rename the test to avoid this conflict.

Signed-off-by: Bastien Curutchet (eBPF Foundation) <bastien.curutchet@bootlin.com>
---
 tools/testing/selftests/bpf/prog_tests/ns_current_pid_tgid.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/ns_current_pid_tgid.c b/tools/testing/selftests/bpf/prog_tests/ns_current_pid_tgid.c
index 761ce24bce38fd97d29ab9faf513d47459299e4d..78020ece6a29c3bec4600f4fd6fe88fdbd2a768b 100644
--- a/tools/testing/selftests/bpf/prog_tests/ns_current_pid_tgid.c
+++ b/tools/testing/selftests/bpf/prog_tests/ns_current_pid_tgid.c
@@ -220,7 +220,7 @@ static void test_in_netns(int (*fn)(void *), void *arg)
 }
 
 /* TODO: use a different tracepoint */
-void serial_test_ns_current_pid_tgid(void)
+void serial_test_current_pid_tgid(void)
 {
 	if (test__start_subtest("root_ns_tp"))
 		test_current_pid_tgid_tp(NULL);

-- 
2.48.1


