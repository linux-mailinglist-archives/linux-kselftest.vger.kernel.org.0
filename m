Return-Path: <linux-kselftest+bounces-40603-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F6AFB401AA
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Sep 2025 14:59:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D7E81736A6
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Sep 2025 12:57:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D00683054CA;
	Tue,  2 Sep 2025 12:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="PwQUaU6G"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22D3D30506B;
	Tue,  2 Sep 2025 12:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756817665; cv=none; b=kSt1ANTAIlY40H1HxNT0yByXod+5Nn3E//jG1miXM75R0P7RgM0ar2+F8P9TcLuItAr7SdzSqjdls8iCAOIFfXzr7KElXR9ChIC2WL8tZo1zF+NkvCU2YM2+37IjCXz8uSWdXumKTerhDG1fK8KMtab1KIUpo53QT0YAVy+seOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756817665; c=relaxed/simple;
	bh=VbBSHfB2zW+ctxCm4SGfQuzLRRhGKKeM2zk5FRtfr+A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AAphJMj49TXJCYNoQluqQ/diBMkJRFEvnl6Kw1u5iQ4/p/wCzNkQ3CLOdG4VHxCkPXbvLnazSj07fDmA1ih4lRp+jXS6GH1kxSx7+FwBg+tHMntkMm4YC+UGo6x2pQw48U8HJNWugXBPNlMXV3vWWM4XlHdxdoBkB8DzDC/0YEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=PwQUaU6G; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id CC698C8EC73;
	Tue,  2 Sep 2025 12:54:07 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id C091960695;
	Tue,  2 Sep 2025 12:54:22 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 859281C22D343;
	Tue,  2 Sep 2025 14:54:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1756817661; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=YPVmNS28+Y5CKNfxtUjWegH8ekwHCY/1iuM0MB/ADZg=;
	b=PwQUaU6GNRJ93rowbQqqxNxZGZ9gAKzhik7flfDJ7Q9adMNTW2pBHYMhYJ4QqFUsQJu6Zm
	0y8y67I6U3az8fA52XFk589ymYGTq158jg3Zuzj2kxtCqqsuj8BamQeBizgUbZpdxexVNc
	UjtdMZVNnnyemd7wh4QBQ9wgqjs1YEYHsw4FbjW4oJgKjpk7UQ9IwNrfXcPLxN8J3yQuJE
	cHyZ3PUQHdy8JP1oZvZyNhH9xreVW9yGS9laQoTTSl/5sgb4Zk5O1+ftnvDXwBV4quCAjZ
	WpBTsdtnZVxfW2nus5g6UN6IK6+qY6jTMOujJ3jSyJRqjuNdf8d5gq1q9S8OdQ==
From: "Bastien Curutchet (eBPF Foundation)" <bastien.curutchet@bootlin.com>
Date: Tue, 02 Sep 2025 14:50:02 +0200
Subject: [PATCH bpf-next v2 12/14] selftests/bpf: test_xsk: Move
 exit_with_error to xskxceiver.c
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250902-xsk-v2-12-17c6345d5215@bootlin.com>
References: <20250902-xsk-v2-0-17c6345d5215@bootlin.com>
In-Reply-To: <20250902-xsk-v2-0-17c6345d5215@bootlin.com>
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


