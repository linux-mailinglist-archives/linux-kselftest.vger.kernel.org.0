Return-Path: <linux-kselftest+bounces-28917-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7219BA5F171
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Mar 2025 11:52:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 990CF17E2C1
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Mar 2025 10:52:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9270B267F55;
	Thu, 13 Mar 2025 10:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="bPWBE/FG"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90670267B05;
	Thu, 13 Mar 2025 10:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741862906; cv=none; b=JJd6VRSyoQW/VHbIawMgz8CeLgWHOHAb7ENq+HoxFbe2C0w/zTxb9pFJmuQbbyDO0DTe3+huUDM/iGthUczQl2542AhzHAt+PchgsdeF6B+YDBeQ/60u1MYMpTEdebQlb+yugJPKaBpu8Lue31nfYegko4LaDgWFD+dT/Ilm6Ng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741862906; c=relaxed/simple;
	bh=bn5FpKmiXbwrT2aMVsjwSzkfSMKma+UcIye4K/iLcoc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jySJDhoHUoeAJQggNV+SaHdgdqxPcIK743UNdq9eBAIaGLsKjSgfCzAR4IB3IgitG/VPSOzptf1V16/j+LxaW1zt/ez9TE9wZIMMQxPQpg5foiPAXRGtPBzxT+9T6ACKXn/Erw4HLWtEjyL1xL/Ob8M9BtYhVntjke3SU5BTjb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=bPWBE/FG; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 92A17441A1;
	Thu, 13 Mar 2025 10:48:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1741862900;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1R9vn1noreVtGY0NwYCvBtkPGgC6mo1F56uk2WvJ90Y=;
	b=bPWBE/FGkZ4KHCfIjZiMYJBmut2w/KXlzzKMqPozWa20QwdjpdXMrwN3W4thWwbjPvZNe/
	o9QaOLU7YCEuvziLYhZhPNFW9osgk/t697pKs6p6aXqV2uaDFTQ2ChPI19ejsvAi6+Psmo
	8H/8t2IqiaKj99TEbM875NAA189YWWj+/mJRt3sz/0LILvXvr2Gv4WaUmV5cHfTwEg+VSZ
	OnSYuT6ees/ny1J+ULe79ni859TPVqzcPhUrvCrTuCT4m6mUt2p9vZLa9rq5lAC46RX0Gj
	wxb2sP+S+2EGsGDU5Thp3WXaPY4zdr4wJbamBahWDhF8+oA8ysiR4D9MJJyd7A==
From: "Bastien Curutchet (eBPF Foundation)" <bastien.curutchet@bootlin.com>
Date: Thu, 13 Mar 2025 11:48:09 +0100
Subject: [PATCH 11/13] selftests/bpf: test_xsk: Make kselftest dependency
 optional
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250313-xsk-v1-11-7374729a93b9@bootlin.com>
References: <20250313-xsk-v1-0-7374729a93b9@bootlin.com>
In-Reply-To: <20250313-xsk-v1-0-7374729a93b9@bootlin.com>
To: =?utf-8?q?Bj=C3=B6rn_T=C3=B6pel?= <bjorn@kernel.org>, 
 Magnus Karlsson <magnus.karlsson@intel.com>, 
 Maciej Fijalkowski <maciej.fijalkowski@intel.com>, 
 Jonathan Lemon <jonathan.lemon@gmail.com>, 
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
 Andrii Nakryiko <andrii@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, 
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
 Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>, 
 Shuah Khan <shuah@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Jakub Kicinski <kuba@kernel.org>, Jesper Dangaard Brouer <hawk@kernel.org>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Alexis Lothore <alexis.lothore@bootlin.com>, netdev@vger.kernel.org, 
 bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 "Bastien Curutchet (eBPF Foundation)" <bastien.curutchet@bootlin.com>
X-Mailer: b4 0.14.2
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduvdejjeehucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomhepfdeurghsthhivghnucevuhhruhhttghhvghtucdlvgeurffhucfhohhunhgurghtihhonhdmfdcuoegsrghsthhivghnrdgtuhhruhhttghhvghtsegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeegfeduhfeutddtieffteffleejffekveeviedutdegjeelfedtjeegtdejtddthfenucfkphepvdgrtddumegtsgduleemkedvheefmeguuddttdemfhelvgdumeeftgejudemjeeitdgtmedutggsrgenucevlhhushhtvghrufhiiigvpeeknecurfgrrhgrmhepihhnvghtpedvrgdtudemtggsudelmeekvdehfeemugdutddtmehflegvudemfegtjedumeejiedttgemudgtsggrpdhhvghlohepfhgvughorhgrrdhhohhmvgdpmhgrihhlfhhrohhmpegsrghsthhivghnrdgtuhhruhhttghhvghtsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopedvkedprhgtphhtthhopegvugguhiiikeejsehgmhgrihhlrdgtohhmpdhrtghpthhtoheprghlvgigihhsrdhlohhthhhorhgvsegsohhothhlihhnrdgtohhmpdhrtghpt
 hhtohepshhhuhgrhheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepmhihkhholhgrlhesfhgsrdgtohhmpdhrtghpthhtohephihonhhghhhonhhgrdhsohhngheslhhinhhugidruggvvhdprhgtphhtthhopehmrghgnhhushdrkhgrrhhlshhsohhnsehinhhtvghlrdgtohhmpdhrtghpthhtohepmhgrrhhtihhnrdhlrghusehlihhnuhigrdguvghvpdhrtghpthhtohepsggrshhtihgvnhdrtghurhhuthgthhgvthessghoohhtlhhinhdrtghomh
X-GND-Sasl: bastien.curutchet@bootlin.com

test_xsk.c uses the kselftest framework. This isn't compatible with the
test_progs framework.

Add a XSK_SELTFEST define that allows to enable/disable the kselftest
usage.

Signed-off-by: Bastien Curutchet (eBPF Foundation) <bastien.curutchet@bootlin.com>
---
 tools/testing/selftests/bpf/Makefile   |  2 +-
 tools/testing/selftests/bpf/test_xsk.h | 18 +++++++++++++++++-
 2 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index ca14999fe0d832b24536f3a4f956e987c3b53cd8..3cde86a6e9b1ca467de162e0ba9670ad2085b6a6 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -777,7 +777,7 @@ $(OUTPUT)/test_verifier: test_verifier.c verifier/tests.h $(BPFOBJ) | $(OUTPUT)
 EXTRA_SRC := $(TOOLSDIR)/lib/find_bit.c
 $(OUTPUT)/xskxceiver: $(EXTRA_SRC) test_xsk.c xskxceiver.c xskxceiver.h $(OUTPUT)/network_helpers.o $(OUTPUT)/xsk.o $(OUTPUT)/xsk_xdp_progs.skel.h $(BPFOBJ) | $(OUTPUT)
 	$(call msg,BINARY,,$@)
-	$(Q)$(CC) $(CFLAGS) $(filter %.a %.o %.c,$^) $(LDLIBS) -o $@
+	$(Q)$(CC) $(CFLAGS) -D XSK_KSELFTEST $(filter %.a %.o %.c,$^) $(LDLIBS) -o $@
 
 $(OUTPUT)/xdp_hw_metadata: xdp_hw_metadata.c $(OUTPUT)/network_helpers.o $(OUTPUT)/xsk.o $(OUTPUT)/xdp_hw_metadata.skel.h | $(OUTPUT)
 	$(call msg,BINARY,,$@)
diff --git a/tools/testing/selftests/bpf/test_xsk.h b/tools/testing/selftests/bpf/test_xsk.h
index 61246013816431dca2f84ce2fec44c5160adbdad..9653687087c122ec5fdb9f23e3343e37c82373f6 100644
--- a/tools/testing/selftests/bpf/test_xsk.h
+++ b/tools/testing/selftests/bpf/test_xsk.h
@@ -5,7 +5,6 @@
 #include <linux/ethtool.h>
 #include <linux/if_xdp.h>
 
-#include "../kselftest.h"
 #include "xsk.h"
 
 #ifndef SO_PREFER_BUSY_POLL
@@ -31,12 +30,29 @@
 #define SOCK_RECONF_CTR			10
 #define USLEEP_MAX			10000
 
+
+#ifdef XSK_KSELFTEST
+#include "../kselftest.h"
+
 static bool opt_verbose;
 #define print_msg(x...) ksft_print_msg(x)
 #define print_verbose(x...) do { if (opt_verbose) ksft_print_msg(x); } while (0)
 #define skip_reason(x...) ksft_test_result_skip(x)
 #define fail_reason(x...) ksft_test_result_fail(x)
 
+#else
+
+void xsk_log(const char *msg, ...);
+void xsk_verbose(const char *msg, ...);
+void xsk_skip(const char *msg);
+
+#define print_msg(x...) xsk_verbose(x)
+#define print_verbose(x...) xsk_verbose(x)
+#define skip_reason(x...) xsk_skip(x)
+#define fail_reason(x...) xsk_log(x)
+
+#endif
+
 static inline u32 ceil_u32(u32 a, u32 b)
 {
 	return (a + b - 1) / b;

-- 
2.48.1


