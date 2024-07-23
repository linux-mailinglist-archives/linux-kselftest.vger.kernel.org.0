Return-Path: <linux-kselftest+bounces-14114-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 111DA93A93C
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Jul 2024 00:24:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6BA3DB23294
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Jul 2024 22:24:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BA701487F6;
	Tue, 23 Jul 2024 22:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M0v9veyj"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 546D214831C;
	Tue, 23 Jul 2024 22:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721773408; cv=none; b=SVcLLAQbwZxJIUPPxv5nd7PlpmwMGP6Eg474pXQoR1gzf7yIzn0Ti/lrcJ1ru4H9O48q+iu9uYKCXgI9rxcELj0bDbE3jLfYbkJhy7yc8Zdru40a60HuawYH6B/mdSMrHEE7PJfhu6f5IhnxoWZqFuXIpKT5mpmw81FwDwtjchE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721773408; c=relaxed/simple;
	bh=bK0shGl2RZDG63euPAWvwcmVDmknniOqfLk8yYBn9AM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SBibm8tY7oRYgrOq1VudfJyLBpgsFrjqeqkZTSPP6RFRZp18c/+QeMpf0TzU+a7d5sh12iPZ7HLthpWO+3oTbjXNqe366zBnLs6y28k7tuBGVeI/najMS1hnpsTqopSJS2a+fxMLVW3IlJu9dSlAYuazrOJymAdX6qZGTMRr/rM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M0v9veyj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A4B8C4AF0A;
	Tue, 23 Jul 2024 22:23:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721773408;
	bh=bK0shGl2RZDG63euPAWvwcmVDmknniOqfLk8yYBn9AM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=M0v9veyjRExJZzVzmTao0Qv8qqkk8tkXCe1aezbXz8PFJJ1o6xXAtlaKWts/UTjuL
	 VR2eedLK+ptffihsxZJDLtql+wvFN72noUwm1WuoU7bj7XpXaWxWqk7e08cz9KaGqh
	 w6OK0ssdOseJcDt4J00+QWcOKRRJO8+EY5M7lMbCcFBEpLKOHuEdiVput3GqQczBbQ
	 /R0SGfLtJWkHJ6ooQtb1T64RwnkwtJS0SNHjCYzZzjKECIUxY2l91nRlMspr1e8nVP
	 +QJ87SRGibKK9FxDBnTvIVCOAMPrWg8QzPu2eGEf0HRrhRyMR3hVF7Nl8EzfMb34dr
	 KmNQvQhl+bAzA==
From: Geliang Tang <geliang@kernel.org>
To: Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Mykola Lysenko <mykolal@fb.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Shuah Khan <shuah@kernel.org>
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH bpf-next 12/15] selftests/bpf: Use make_sockaddr in sockmap_helpers
Date: Wed, 24 Jul 2024 06:22:18 +0800
Message-ID: <951ea44c8df0f6d8904317be8bec33db85e9a5de.1721771340.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1721771340.git.tanggeliang@kylinos.cn>
References: <cover.1721771340.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

AF_VSOCK is supported in make_sockaddr() now, use it to implement
init_addr_loopback() in sockmap_helpers.h. Then three local functions
init_addr_loopback4(), init_addr_loopback6() and init_addr_loopback_vsock()
can be dropped.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 .../bpf/prog_tests/sockmap_helpers.h          | 54 +------------------
 1 file changed, 2 insertions(+), 52 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/sockmap_helpers.h b/tools/testing/selftests/bpf/prog_tests/sockmap_helpers.h
index e880f97bc44d..0fe095497f34 100644
--- a/tools/testing/selftests/bpf/prog_tests/sockmap_helpers.h
+++ b/tools/testing/selftests/bpf/prog_tests/sockmap_helpers.h
@@ -1,17 +1,12 @@
 #ifndef __SOCKMAP_HELPERS__
 #define __SOCKMAP_HELPERS__
 
-#include <linux/vm_sockets.h>
+#include "network_helpers.h"
 
 #define IO_TIMEOUT_SEC 30
 #define MAX_STRERR_LEN 256
 #define MAX_TEST_NAME 80
 
-/* workaround for older vm_sockets.h */
-#ifndef VMADDR_CID_LOCAL
-#define VMADDR_CID_LOCAL 1
-#endif
-
 #define __always_unused	__attribute__((__unused__))
 
 #define _FAIL(errnum, fmt...)                                                  \
@@ -239,55 +234,10 @@ static inline int recv_timeout(int fd, void *buf, size_t len, int flags,
 	return recv(fd, buf, len, flags);
 }
 
-static inline void init_addr_loopback4(struct sockaddr_storage *ss,
-				       socklen_t *len)
-{
-	struct sockaddr_in *addr4 = memset(ss, 0, sizeof(*ss));
-
-	addr4->sin_family = AF_INET;
-	addr4->sin_port = 0;
-	addr4->sin_addr.s_addr = htonl(INADDR_LOOPBACK);
-	*len = sizeof(*addr4);
-}
-
-static inline void init_addr_loopback6(struct sockaddr_storage *ss,
-				       socklen_t *len)
-{
-	struct sockaddr_in6 *addr6 = memset(ss, 0, sizeof(*ss));
-
-	addr6->sin6_family = AF_INET6;
-	addr6->sin6_port = 0;
-	addr6->sin6_addr = in6addr_loopback;
-	*len = sizeof(*addr6);
-}
-
-static inline void init_addr_loopback_vsock(struct sockaddr_storage *ss,
-					    socklen_t *len)
-{
-	struct sockaddr_vm *addr = memset(ss, 0, sizeof(*ss));
-
-	addr->svm_family = AF_VSOCK;
-	addr->svm_port = VMADDR_PORT_ANY;
-	addr->svm_cid = VMADDR_CID_LOCAL;
-	*len = sizeof(*addr);
-}
-
 static inline void init_addr_loopback(int family, struct sockaddr_storage *ss,
 				      socklen_t *len)
 {
-	switch (family) {
-	case AF_INET:
-		init_addr_loopback4(ss, len);
-		return;
-	case AF_INET6:
-		init_addr_loopback6(ss, len);
-		return;
-	case AF_VSOCK:
-		init_addr_loopback_vsock(ss, len);
-		return;
-	default:
-		FAIL("unsupported address family %d", family);
-	}
+	make_sockaddr(family, loopback_addr_str(family), 0, ss, len);
 }
 
 static inline struct sockaddr *sockaddr(struct sockaddr_storage *ss)
-- 
2.43.0


