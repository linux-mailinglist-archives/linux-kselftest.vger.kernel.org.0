Return-Path: <linux-kselftest+bounces-14146-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2519693B060
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Jul 2024 13:34:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 422AE1C21A53
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Jul 2024 11:34:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 643C0158A0D;
	Wed, 24 Jul 2024 11:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="MAAVyHx1"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mailtransmit05.runbox.com (mailtransmit05.runbox.com [185.226.149.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FDF2481CD;
	Wed, 24 Jul 2024 11:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721820833; cv=none; b=WgghMcIJR8RVnKOsdf58gMI9DmShPDMjvjuVbLgEGXEYysKVVRUtYqH4ekv184Y/WzbaKE4yXm9xW1CX8C83HUv+Wt1hXJTND6xm+6Pl1Cz2jQn9I17HAd7XRFo3VqaXeHlOQTFp69zTRnjvv6S/fG+DZJ1i1QlbhKfrJa0Dv8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721820833; c=relaxed/simple;
	bh=9a0B1YLrXAy39ost5A6ykX9fbJmNaQuU/WftjtzHLY4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CuYPmMSSbodLdAdtjcG8+dmBUAQ2+jmncpvPy1UIW84/CIaiC0wAZ4gyzQvVDFReZmDrRHMx2KOGdlxqJOoJieVepu3Ch2Ic8RrrH5m4jfb2CagQOITKwpofDmvm2GXqlxeEG/C1N1vLgoxKozBCXuY0AvfmTAAhWofi2V8hTe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=MAAVyHx1; arc=none smtp.client-ip=185.226.149.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
	by mailtransmit05.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1sWaFf-006K1w-7t; Wed, 24 Jul 2024 13:33:47 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector1; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From;
	bh=aPCCK4a08qwMdUmZK9x3aqxUfF/E+H/LkihvqFGOkBU=; b=MAAVyHx1UrtrxCRBzIHQ7n4LWV
	u8yS4Fx2/baxm0henqxVcrptSeMUBtGavoIff/pkAsthvn+tc4qObAQaI9qrsvdYX97bjLmD5SgLF
	e5Q9FHxnzl8v1qh5W8y3+WY1fRr8775tOaIYb4fiJmnPswjPygf43gDEkWn98ZtHcuSZsElmxfZvk
	3p4w6HbY0hMN1ICaUsBJNDa8F7OutUMPvGryqJCFDi3a+6d1JhCzquCMBt0KQcUHW278OjBjul7X6
	Q6elnVxhhusGjNRMEILmhDOuSqDzbQ3NA/OvdeHlL4EUrHmCmCVgjIA9ACNZAmbZZmOuPeXACcHBv
	seU9g5ww==;
Received: from [10.9.9.74] (helo=submission03.runbox)
	by mailtransmit02.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1sWaFd-0003y8-Bq; Wed, 24 Jul 2024 13:33:47 +0200
Received: by submission03.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1sWaFP-00EK6H-I7; Wed, 24 Jul 2024 13:33:31 +0200
From: Michal Luczaj <mhal@rbox.co>
Date: Wed, 24 Jul 2024 13:32:42 +0200
Subject: [PATCH bpf 6/6] selftest/bpf: Introduce __attribute__((cleanup))
 in create_pair()
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240724-sockmap-selftest-fixes-v1-6-46165d224712@rbox.co>
References: <20240724-sockmap-selftest-fixes-v1-0-46165d224712@rbox.co>
In-Reply-To: <20240724-sockmap-selftest-fixes-v1-0-46165d224712@rbox.co>
To: Andrii Nakryiko <andrii@kernel.org>, 
 Eduard Zingerman <eddyz87@gmail.com>, Mykola Lysenko <mykolal@fb.com>, 
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, 
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
 Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>, 
 Jakub Sitnicki <jakub@cloudflare.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Michal Luczaj <mhal@rbox.co>
X-Mailer: b4 0.14.0

Rewrite function to have (unneeded) socket descriptors automatically
close()d when leaving the scope. Make sure the "ownership" of fds is
correctly passed via take_fd(); i.e. descriptor returned to caller will
remain valid.

Suggested-by: Jakub Sitnicki <jakub@cloudflare.com>
Signed-off-by: Michal Luczaj <mhal@rbox.co>
---
 .../selftests/bpf/prog_tests/sockmap_helpers.h     | 57 ++++++++++++----------
 1 file changed, 32 insertions(+), 25 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/sockmap_helpers.h b/tools/testing/selftests/bpf/prog_tests/sockmap_helpers.h
index ead8ea4fd0da..2e0f9fe459be 100644
--- a/tools/testing/selftests/bpf/prog_tests/sockmap_helpers.h
+++ b/tools/testing/selftests/bpf/prog_tests/sockmap_helpers.h
@@ -182,6 +182,21 @@
 		__ret;                                                         \
 	})
 
+#define take_fd(fd)                                                            \
+	({                                                                     \
+		__auto_type __val = (fd);                                      \
+		fd = -EBADF;                                                   \
+		__val;                                                         \
+	})
+
+static inline void close_fd(int *fd)
+{
+	if (*fd >= 0)
+		xclose(*fd);
+}
+
+#define __close_fd __attribute__((cleanup(close_fd)))
+
 static inline int poll_connect(int fd, unsigned int timeout_sec)
 {
 	struct timeval timeout = { .tv_sec = timeout_sec };
@@ -369,9 +384,10 @@ static inline int socket_loopback(int family, int sotype)
 
 static inline int create_pair(int family, int sotype, int *p0, int *p1)
 {
+	__close_fd int s, c = -1, p = -1;
 	struct sockaddr_storage addr;
 	socklen_t len = sizeof(addr);
-	int s, c, p, err;
+	int err;
 
 	s = socket_loopback(family, sotype);
 	if (s < 0)
@@ -379,25 +395,23 @@ static inline int create_pair(int family, int sotype, int *p0, int *p1)
 
 	err = xgetsockname(s, sockaddr(&addr), &len);
 	if (err)
-		goto close_s;
+		return err;
 
 	c = xsocket(family, sotype, 0);
-	if (c < 0) {
-		err = c;
-		goto close_s;
-	}
+	if (c < 0)
+		return c;
 
 	err = connect(c, sockaddr(&addr), len);
 	if (err) {
 		if (errno != EINPROGRESS) {
 			FAIL_ERRNO("connect");
-			goto close_c;
+			return err;
 		}
 
 		err = poll_connect(c, IO_TIMEOUT_SEC);
 		if (err) {
 			FAIL_ERRNO("poll_connect");
-			goto close_c;
+			return err;
 		}
 	}
 
@@ -405,36 +419,29 @@ static inline int create_pair(int family, int sotype, int *p0, int *p1)
 	case SOCK_DGRAM:
 		err = xgetsockname(c, sockaddr(&addr), &len);
 		if (err)
-			goto close_c;
+			return err;
 
 		err = xconnect(s, sockaddr(&addr), len);
-		if (!err) {
-			*p0 = s;
-			*p1 = c;
+		if (err)
 			return err;
-		}
+
+		*p0 = take_fd(s);
 		break;
 	case SOCK_STREAM:
 	case SOCK_SEQPACKET:
 		p = xaccept_nonblock(s, NULL, NULL);
-		if (p >= 0) {
-			*p0 = p;
-			*p1 = c;
-			goto close_s;
-		}
+		if (p < 0)
+			return p;
 
-		err = p;
+		*p0 = take_fd(p);
 		break;
 	default:
 		FAIL("Unsupported socket type %#x", sotype);
-		err = -EOPNOTSUPP;
+		return -EOPNOTSUPP;
 	}
 
-close_c:
-	close(c);
-close_s:
-	close(s);
-	return err;
+	*p1 = take_fd(c);
+	return 0;
 }
 
 static inline int create_socket_pairs(int family, int sotype, int *c0, int *c1,

-- 
2.45.2


