Return-Path: <linux-kselftest+bounces-14522-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 11C92942B7F
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 Jul 2024 12:03:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 931391F21C1C
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 Jul 2024 10:03:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 415561AED20;
	Wed, 31 Jul 2024 10:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="QXb43YOr"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mailtransmit04.runbox.com (mailtransmit04.runbox.com [185.226.149.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 723BC1AE855
	for <linux-kselftest@vger.kernel.org>; Wed, 31 Jul 2024 10:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722420126; cv=none; b=s/YjvzTQoqZ1xtgTU3oxsclkvwWE0U2rsP74aTT7SeZJHFsu8I/2b1JtuwcN0pra4xk/TCAYJwtmQeGoQ4rHPSGzFfumar0Z5taoA6ACRJyvJFUjO+MrD8J3YG697pWH7kqUNbZ3LC+Aq5qOwA8neDAxbTir3JTG3zIqP1RBd8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722420126; c=relaxed/simple;
	bh=cIHRCPINAGwohd4j/ay/oQgmDm4KB5WKpbwZbkjZn5c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VwCEZKw6s6EbiAwAT1CRRGWZJacnE+3fBWjPvPd+Wd/mOOlzdd6lJE2JqHy8B9UXreUDnSWKXOunuR3avMYCTRMgzAfuZ8bSNnrT+6tpzMRO8hpgZ17Ucf8ICQZCVCjzLAb7dgSsjOlH6jh+Wtr7aA675oDmN+Mh7q2H2dMmPzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=QXb43YOr; arc=none smtp.client-ip=185.226.149.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
	by mailtransmit04.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1sZ69b-009FCu-44; Wed, 31 Jul 2024 12:01:55 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector1; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From;
	bh=9RxA/NP3STRlcbTPKTngN1kPcAxK6yro35/CQTJa0Hk=; b=QXb43YOrnnX3BoyH8iku/zhLKp
	xIJ9iY5PedpWQEg/edRGXDuHC1A6zXXP3ZvHz7CkSZFX8TBirx2Z18gKQXpMQDJD9ddFXOn17ge7M
	FWmnTjyUUR8w2e3sLczIX3zL7u6d+z34FDbIzpEgJi1oOLnZxXEOSOWnbqL3WBF5kRcNNRCd/wcAl
	HnEbthDrJ/d5qddBnngFafngRoPtuWEUXINxfiO6sANAqN2EdFsdr7SP+3StDFkMWC3Qq47yDnk7C
	J9OCW594H8qXF0h2Rb1ES72TghZYRwiJNF4Bo36LETujg/dr5INa9WvlMR/eVQGX8KUuLx1hVl8jj
	PtVT35PA==;
Received: from [10.9.9.73] (helo=submission02.runbox)
	by mailtransmit02.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1sZ69a-000227-EY; Wed, 31 Jul 2024 12:01:54 +0200
Received: by submission02.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1sZ69J-006dO6-L2; Wed, 31 Jul 2024 12:01:37 +0200
From: Michal Luczaj <mhal@rbox.co>
Date: Wed, 31 Jul 2024 12:01:31 +0200
Subject: [PATCH bpf-next v2 6/6] selftests/bpf: Introduce
 __attribute__((cleanup)) in create_pair()
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240731-selftest-sockmap-fixes-v2-6-08a0c73abed2@rbox.co>
References: <20240731-selftest-sockmap-fixes-v2-0-08a0c73abed2@rbox.co>
In-Reply-To: <20240731-selftest-sockmap-fixes-v2-0-08a0c73abed2@rbox.co>
To: Andrii Nakryiko <andrii@kernel.org>, 
 Eduard Zingerman <eddyz87@gmail.com>, Mykola Lysenko <mykolal@fb.com>, 
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, 
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
 Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>, 
 Jakub Sitnicki <jakub@cloudflare.com>
Cc: bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Michal Luczaj <mhal@rbox.co>
X-Mailer: b4 0.14.1

Rewrite function to have (unneeded) socket descriptors automatically
close()d when leaving the scope. Make sure the "ownership" of fds is
correctly passed via take_fd(); i.e. descriptor returned to caller will
remain valid.

Suggested-by: Jakub Sitnicki <jakub@cloudflare.com>
Signed-off-by: Michal Luczaj <mhal@rbox.co>
---
 .../selftests/bpf/prog_tests/sockmap_helpers.h     | 61 +++++++++++++---------
 1 file changed, 36 insertions(+), 25 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/sockmap_helpers.h b/tools/testing/selftests/bpf/prog_tests/sockmap_helpers.h
index ead8ea4fd0da..38e35c72bdaa 100644
--- a/tools/testing/selftests/bpf/prog_tests/sockmap_helpers.h
+++ b/tools/testing/selftests/bpf/prog_tests/sockmap_helpers.h
@@ -17,6 +17,17 @@
 
 #define __always_unused	__attribute__((__unused__))
 
+/* include/linux/cleanup.h */
+#define __get_and_null(p, nullvalue)                                           \
+	({                                                                     \
+		__auto_type __ptr = &(p);                                      \
+		__auto_type __val = *__ptr;                                    \
+		*__ptr = nullvalue;                                            \
+		__val;                                                         \
+	})
+
+#define take_fd(fd) __get_and_null(fd, -EBADF)
+
 #define _FAIL(errnum, fmt...)                                                  \
 	({                                                                     \
 		error_at_line(0, (errnum), __func__, __LINE__, fmt);           \
@@ -182,6 +193,14 @@
 		__ret;                                                         \
 	})
 
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
@@ -369,9 +388,10 @@ static inline int socket_loopback(int family, int sotype)
 
 static inline int create_pair(int family, int sotype, int *p0, int *p1)
 {
+	__close_fd int s, c = -1, p = -1;
 	struct sockaddr_storage addr;
 	socklen_t len = sizeof(addr);
-	int s, c, p, err;
+	int err;
 
 	s = socket_loopback(family, sotype);
 	if (s < 0)
@@ -379,25 +399,23 @@ static inline int create_pair(int family, int sotype, int *p0, int *p1)
 
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
 
@@ -405,36 +423,29 @@ static inline int create_pair(int family, int sotype, int *p0, int *p1)
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


