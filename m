Return-Path: <linux-kselftest+bounces-40775-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2344AB4385F
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Sep 2025 12:17:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 786453BAAF9
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Sep 2025 10:15:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA848305E2C;
	Thu,  4 Sep 2025 10:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="TY+CDx6R"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 955152FC03D;
	Thu,  4 Sep 2025 10:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756980712; cv=none; b=iI0AX6hmXWAa1KWeCCZSvI36GHLEBXBdOZg/EK9HoNIAbqNolRfcSKAk5K3gSxvqcAvYl9OW39NuvIrKnDkRRX1j5f3itN5vqxxGGF0N7owUylqwN3ZHepA5VwQ8t57vFpD0odlXMYZ8dAavB+AB6Se8odtrOSGCT7pwR012rQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756980712; c=relaxed/simple;
	bh=VbBSHfB2zW+ctxCm4SGfQuzLRRhGKKeM2zk5FRtfr+A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uOVa7wKYWdPapgh/Y/uyEmZwQshi5Ga59AkBFaqc2Ya8Y5NPMwYMcbO9M3dQL7NK6Wcfg05NjyU+HEUVHNo3umxASKRnDfqveqJu3DgBoOnRvaT+66eo3h2H1muTwLMzuRzO17Dkj6ny/9gLYBeSnCwy46TQhV+f94S3cen/i74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=TY+CDx6R; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 575A74E40C74;
	Thu,  4 Sep 2025 10:11:49 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 2F0A1606BB;
	Thu,  4 Sep 2025 10:11:49 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 7EB581C22DA51;
	Thu,  4 Sep 2025 12:11:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1756980707; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=YPVmNS28+Y5CKNfxtUjWegH8ekwHCY/1iuM0MB/ADZg=;
	b=TY+CDx6R1/DAQC1/h04l3fCKwC2oiXOkSLs9/o5lSo8DxRDScZwMD8V4kTTXXddxYnf7Yk
	NYN4A0k4Jb5mLHIUTHnOOEYdH6tEl1s8oaN1WF8tE5Li0+/K5Z3zvkR6BhpxX/j2aNnhgS
	BTy5cAZP2J6h0g9Nbweap2beMLnlWxZqGyhEZ9NzIdF903t9KBKLOwG2DFpPSpkYUfDhGX
	xVN6OEE8geZlu8zbOy6LjGFEaaVmZCHax93IxRRSBxsTrTr8IZ3qNVeYm8MYP4CHov8Nae
	NFGkcX6zvvdkWAYj0rUYBzwmClT9IJDG/u2uC2CWSNPnSTSejBhBpw9HuQ1NSw==
From: "Bastien Curutchet (eBPF Foundation)" <bastien.curutchet@bootlin.com>
Date: Thu, 04 Sep 2025 12:10:27 +0200
Subject: [PATCH bpf-next v3 12/14] selftests/bpf: test_xsk: Move
 exit_with_error to xskxceiver.c
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250904-xsk-v3-12-ce382e331485@bootlin.com>
References: <20250904-xsk-v3-0-ce382e331485@bootlin.com>
In-Reply-To: <20250904-xsk-v3-0-ce382e331485@bootlin.com>
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
X-Last-TLS-Session-Version: TLSv1.3

exit_with_error() isn't called by test_xsk.c. It shouldn't be called
in the future either, since some resources need to be cleaned before
exiting when an error occurs.

Move the definition of exit_with_error() to xskxceiver.c, where it's
still used.

Signed-off-by: Bastien Curutchet (eBPF Foundation) <bastien.curutchet@bootlin.com>
---
 tools/testing/selftests/bpf/test_xsk.h   | 7 -------
 tools/testing/selftests/bpf/xskxceiver.c | 9 +++++++++
 2 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/bpf/test_xsk.h b/tools/testing/selftests/bpf/test_xsk.h
index f4e192264b140c21cc861192fd0df991c46afd24..b068b25ea5da728fad1e17b894d6a1b1c9794f74 100644
--- a/tools/testing/selftests/bpf/test_xsk.h
+++ b/tools/testing/selftests/bpf/test_xsk.h
@@ -34,13 +34,6 @@
 extern bool opt_verbose;
 #define print_verbose(x...) do { if (opt_verbose) ksft_print_msg(x); } while (0)
 
-static void __exit_with_error(int error, const char *file, const char *func, int line)
-{
-	ksft_test_result_fail("[%s:%s:%i]: ERROR: %d/\"%s\"\n", file, func, line, error,
-			      strerror(error));
-	ksft_exit_xfail();
-}
-#define exit_with_error(error) __exit_with_error(error, __FILE__, __func__, __LINE__)
 
 static inline u32 ceil_u32(u32 a, u32 b)
 {
diff --git a/tools/testing/selftests/bpf/xskxceiver.c b/tools/testing/selftests/bpf/xskxceiver.c
index 20ae62b7014427929e55e10b274757a95897ff1e..68aa3317dfc62cd4deac07f2d58fefd55770775f 100644
--- a/tools/testing/selftests/bpf/xskxceiver.c
+++ b/tools/testing/selftests/bpf/xskxceiver.c
@@ -107,6 +107,15 @@ static u32 opt_run_test = RUN_ALL_TESTS;
 
 void test__fail(void) { /* for network_helpers.c */ }
 
+static void __exit_with_error(int error, const char *file, const char *func, int line)
+{
+	ksft_test_result_fail("[%s:%s:%i]: ERROR: %d/\"%s\"\n", file, func, line,
+			      error, strerror(error));
+	ksft_exit_xfail();
+}
+
+#define exit_with_error(error) __exit_with_error(error, __FILE__, __func__, __LINE__)
+
 static bool ifobj_zc_avail(struct ifobject *ifobject)
 {
 	size_t umem_sz = DEFAULT_UMEM_BUFFERS * XSK_UMEM__DEFAULT_FRAME_SIZE;

-- 
2.50.1


