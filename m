Return-Path: <linux-kselftest+bounces-9860-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 679FD8C1699
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 May 2024 22:14:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7FE591C21A01
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 May 2024 20:14:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DF4613D50C;
	Thu,  9 May 2024 20:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="A3GL6N16"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4931F126F05
	for <linux-kselftest@vger.kernel.org>; Thu,  9 May 2024 20:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715284960; cv=none; b=g3jECjxYAWenvGKjThRjIKK6hQEG+/905RS+248lAa115fLxDPTAn7DRGoeD7iK0lYO3BnFbtiaBuAILlxn+hU5Yxxyevk/8Qcffcz3LUiU2idotXCs6Qiv+kQzgYMDdCh5Oqkv1I145VKv2qdep/pOIMiVsuHtJSkNjzGTgBMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715284960; c=relaxed/simple;
	bh=/9vwnuAyvi91y2uSnuLiMaiQd5Ahh45VY/a5f9GscLE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=rVbFIl5rd129gww9y1EN8VHYwWBcFBvIcB8ON4Fv4is4o11Bn1vgzMj4CLXovoU7As5WUt6TuS6fhdoG85UoEGdLx/1BTw9dnVXr10zSAWca1H0z4dBTh6FjBCrWj3f2KrUqdKOHl72ffX3mg0nKtv7LrgzOIwkLFlWXIvpXy4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=A3GL6N16; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-6ece5eeb7c0so1082749b3a.2
        for <linux-kselftest@vger.kernel.org>; Thu, 09 May 2024 13:02:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715284958; x=1715889758; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=DPiHkbkAxiDemq7vdknRjzinKT3RlTMEgeWMqs4n0oo=;
        b=A3GL6N16+6PTVDRkJAsRs1xnvxyzm9jwDfimhXYAcEfdmTQ/+dpDYyjeU9P2UR37ot
         tIaZFB9br+vm4WEWTzXQ9aISYYJUb5bgfiS4nK6OnCWtXwQRhpfrJYDae5DFFP4j0Rqy
         XhXO8VYbNkmRIq//3QGaC7S5axh+jZOCPIiGL8CWvNzPgAiRshPGpIp2XhAxMauoqFo8
         KY7Dr2EnAP/LO/UPE4sXqaPadHx2VGiua+Nbk0QAGp4CZ8P5sBWSzvh2l8/RKD06Jm5g
         TVNPPiguYIgT0MrRAytTu+0yk5HGzLyHECxHjDltiKr+qVmqCJ8kU4CmKM8Qjt7NjuwK
         E6NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715284958; x=1715889758;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DPiHkbkAxiDemq7vdknRjzinKT3RlTMEgeWMqs4n0oo=;
        b=ZpPl1u8rhlmLBGeVgiRZtWilRU9SrOlluMkC0tfveUWtlrv1ESh1OkXe2QyMM8XLa1
         J6vsha8LpTCkVCQlkJlMvt29RV6FRVUk4vaIY1bg/K/TL5OZNhmNS3ColUTgEPwArLG6
         s1q5ESuPbCXrqcr8vFWz/1hodAbEauwjAk5uT2RfCnjR0piPc1vpkx5msCN4dq0t/lpf
         sMVNzJfcg3/e2kLzc0BmhHjPIrQSUekyd4dy1HA2ItpqWzCQp2+oq68D0W2+jWwmy/j6
         pmwGgkN0ow6t255fu8dGfSRkp+/22/mmcmtwKnEf3XXli5fUzuBkLzQemxYqGCf4ZpZD
         CC1w==
X-Forwarded-Encrypted: i=1; AJvYcCXTbFuIQHO6EAVlW3fsz2GBixOnD4Qjj5ekCYt1NsvY1EihAX5VL6Xqw9NqfaLs2EgybUD6+DsMa4dCIejZCLE09bkCxrGH/Kk0+ktOV+DO
X-Gm-Message-State: AOJu0Yywy64LfPgmkC2GpgsuLuig3eLjmnNOp5Om4NuutTIBM2afK+5C
	NX/EnQ/9ir+3mHfGcauU1dSpu0UVuCDAQF2p0C71UH2/Spx7SQgS9ELG1aGPv8sT0+1EbizkWCq
	eag==
X-Google-Smtp-Source: AGHT+IGoK8O3he9Tolhv65HCy5YUInUJLazil2ujEfyYVh+VJPWDieG1i2TzTgKR1zjjwuDOnft4JUJqf8c=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a05:6a00:4b56:b0:6f4:9fc7:d21e with SMTP id
 d2e1a72fcca58-6f4e03d2940mr7848b3a.5.1715284957597; Thu, 09 May 2024 13:02:37
 -0700 (PDT)
Date: Thu,  9 May 2024 19:58:29 +0000
In-Reply-To: <20240509200022.253089-1-edliaw@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240509200022.253089-1-edliaw@google.com>
X-Mailer: git-send-email 2.45.0.118.g7fe29c98d7-goog
Message-ID: <20240509200022.253089-38-edliaw@google.com>
Subject: [PATCH v3 37/68] selftests/net: Drop define _GNU_SOURCE
From: Edward Liaw <edliaw@google.com>
To: shuah@kernel.org, "=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?=" <mic@digikod.net>, 
	"=?UTF-8?q?G=C3=BCnther=20Noack?=" <gnoack@google.com>, Christian Brauner <brauner@kernel.org>, 
	Richard Cochran <richardcochran@gmail.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, 
	Steffen Klassert <steffen.klassert@secunet.com>, Herbert Xu <herbert@gondor.apana.org.au>, 
	"=?UTF-8?q?Andreas=20F=C3=A4rber?=" <afaerber@suse.de>, Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
	Matthieu Baerts <matttbe@kernel.org>, Mat Martineau <martineau@kernel.org>, 
	Geliang Tang <geliang@kernel.org>, Pablo Neira Ayuso <pablo@netfilter.org>, 
	Jozsef Kadlecsik <kadlec@netfilter.org>, Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
	Andrew Morton <akpm@linux-foundation.org>, 
	Muhammad Usama Anjum <usama.anjum@collabora.com>, Edward Liaw <edliaw@google.com>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	kernel-team@android.com, linux-security-module@vger.kernel.org, 
	netdev@vger.kernel.org, linux-riscv@lists.infradead.org, bpf@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-actions@lists.infradead.org, 
	mptcp@lists.linux.dev, netfilter-devel@vger.kernel.org, 
	coreteam@netfilter.org
Content-Type: text/plain; charset="UTF-8"

_GNU_SOURCE is provided by lib.mk, so it should be dropped to prevent
redefinition warnings.

Fixes: 809216233555 ("selftests/harness: remove use of LINE_MAX")
Signed-off-by: Edward Liaw <edliaw@google.com>
---
 tools/testing/selftests/net/af_unix/diag_uid.c               | 2 --
 tools/testing/selftests/net/af_unix/scm_pidfd.c              | 1 -
 tools/testing/selftests/net/af_unix/scm_rights.c             | 1 -
 tools/testing/selftests/net/af_unix/unix_connect.c           | 2 --
 tools/testing/selftests/net/csum.c                           | 3 ---
 tools/testing/selftests/net/gro.c                            | 3 ---
 tools/testing/selftests/net/ip_defrag.c                      | 3 ---
 tools/testing/selftests/net/ipsec.c                          | 3 ---
 tools/testing/selftests/net/ipv6_flowlabel.c                 | 3 ---
 tools/testing/selftests/net/ipv6_flowlabel_mgr.c             | 3 ---
 tools/testing/selftests/net/mptcp/mptcp_connect.c            | 3 ---
 tools/testing/selftests/net/mptcp/mptcp_inq.c                | 3 ---
 tools/testing/selftests/net/mptcp/mptcp_sockopt.c            | 3 ---
 tools/testing/selftests/net/msg_zerocopy.c                   | 3 ---
 tools/testing/selftests/net/netfilter/audit_logread.c        | 2 --
 tools/testing/selftests/net/netfilter/conntrack_dump_flush.c | 3 ---
 tools/testing/selftests/net/nettest.c                        | 2 --
 tools/testing/selftests/net/psock_fanout.c                   | 3 ---
 tools/testing/selftests/net/psock_snd.c                      | 3 ---
 tools/testing/selftests/net/reuseport_addr_any.c             | 3 ---
 tools/testing/selftests/net/reuseport_bpf_cpu.c              | 3 ---
 tools/testing/selftests/net/reuseport_bpf_numa.c             | 3 ---
 tools/testing/selftests/net/reuseport_dualstack.c            | 3 ---
 tools/testing/selftests/net/so_incoming_cpu.c                | 1 -
 tools/testing/selftests/net/so_netns_cookie.c                | 1 -
 tools/testing/selftests/net/so_txtime.c                      | 3 ---
 tools/testing/selftests/net/tap.c                            | 3 ---
 tools/testing/selftests/net/tcp_fastopen_backup_key.c        | 1 -
 tools/testing/selftests/net/tcp_inq.c                        | 2 --
 tools/testing/selftests/net/tcp_mmap.c                       | 1 -
 tools/testing/selftests/net/tls.c                            | 3 ---
 tools/testing/selftests/net/toeplitz.c                       | 3 ---
 tools/testing/selftests/net/tun.c                            | 3 ---
 tools/testing/selftests/net/txring_overwrite.c               | 3 ---
 tools/testing/selftests/net/txtimestamp.c                    | 3 ---
 tools/testing/selftests/net/udpgso.c                         | 3 ---
 tools/testing/selftests/net/udpgso_bench_rx.c                | 3 ---
 tools/testing/selftests/net/udpgso_bench_tx.c                | 3 ---
 38 files changed, 97 deletions(-)

diff --git a/tools/testing/selftests/net/af_unix/diag_uid.c b/tools/testing/selftests/net/af_unix/diag_uid.c
index 79a3dd75590e..279d0c5f70d3 100644
--- a/tools/testing/selftests/net/af_unix/diag_uid.c
+++ b/tools/testing/selftests/net/af_unix/diag_uid.c
@@ -1,7 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
 /* Copyright Amazon.com Inc. or its affiliates. */
-
-#define _GNU_SOURCE
 #include <sched.h>
 
 #include <unistd.h>
diff --git a/tools/testing/selftests/net/af_unix/scm_pidfd.c b/tools/testing/selftests/net/af_unix/scm_pidfd.c
index 7e534594167e..2986b8cd0418 100644
--- a/tools/testing/selftests/net/af_unix/scm_pidfd.c
+++ b/tools/testing/selftests/net/af_unix/scm_pidfd.c
@@ -1,5 +1,4 @@
 // SPDX-License-Identifier: GPL-2.0 OR MIT
-#define _GNU_SOURCE
 #include <error.h>
 #include <limits.h>
 #include <stddef.h>
diff --git a/tools/testing/selftests/net/af_unix/scm_rights.c b/tools/testing/selftests/net/af_unix/scm_rights.c
index bab606c9f1eb..146a8d7a8cd9 100644
--- a/tools/testing/selftests/net/af_unix/scm_rights.c
+++ b/tools/testing/selftests/net/af_unix/scm_rights.c
@@ -1,6 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
 /* Copyright Amazon.com Inc. or its affiliates. */
-#define _GNU_SOURCE
 #include <sched.h>
 
 #include <stdio.h>
diff --git a/tools/testing/selftests/net/af_unix/unix_connect.c b/tools/testing/selftests/net/af_unix/unix_connect.c
index d799fd8f5c7c..34e816862cc7 100644
--- a/tools/testing/selftests/net/af_unix/unix_connect.c
+++ b/tools/testing/selftests/net/af_unix/unix_connect.c
@@ -1,6 +1,4 @@
 // SPDX-License-Identifier: GPL-2.0
-
-#define _GNU_SOURCE
 #include <sched.h>
 
 #include <stddef.h>
diff --git a/tools/testing/selftests/net/csum.c b/tools/testing/selftests/net/csum.c
index b9f3fc3c3426..28f8241b8567 100644
--- a/tools/testing/selftests/net/csum.c
+++ b/tools/testing/selftests/net/csum.c
@@ -58,9 +58,6 @@
  * different seed for each run (and logs this for reproducibility). It
  * is advised to enable this for extra coverage in continuous testing.
  */
-
-#define _GNU_SOURCE
-
 #include <arpa/inet.h>
 #include <asm/byteorder.h>
 #include <errno.h>
diff --git a/tools/testing/selftests/net/gro.c b/tools/testing/selftests/net/gro.c
index 6038b96ecee8..dd370c88af1e 100644
--- a/tools/testing/selftests/net/gro.c
+++ b/tools/testing/selftests/net/gro.c
@@ -34,9 +34,6 @@
  * flakiness is to be expected.
  *
  */
-
-#define _GNU_SOURCE
-
 #include <arpa/inet.h>
 #include <errno.h>
 #include <error.h>
diff --git a/tools/testing/selftests/net/ip_defrag.c b/tools/testing/selftests/net/ip_defrag.c
index f9ed749fd8c7..80c9e567a3d8 100644
--- a/tools/testing/selftests/net/ip_defrag.c
+++ b/tools/testing/selftests/net/ip_defrag.c
@@ -1,7 +1,4 @@
 // SPDX-License-Identifier: GPL-2.0
-
-#define _GNU_SOURCE
-
 #include <arpa/inet.h>
 #include <errno.h>
 #include <error.h>
diff --git a/tools/testing/selftests/net/ipsec.c b/tools/testing/selftests/net/ipsec.c
index be4a30a0d02a..04aa06d26b09 100644
--- a/tools/testing/selftests/net/ipsec.c
+++ b/tools/testing/selftests/net/ipsec.c
@@ -3,9 +3,6 @@
  * ipsec.c - Check xfrm on veth inside a net-ns.
  * Copyright (c) 2018 Dmitry Safonov
  */
-
-#define _GNU_SOURCE
-
 #include <arpa/inet.h>
 #include <asm/types.h>
 #include <errno.h>
diff --git a/tools/testing/selftests/net/ipv6_flowlabel.c b/tools/testing/selftests/net/ipv6_flowlabel.c
index 708a9822259d..b7e0c3c02e20 100644
--- a/tools/testing/selftests/net/ipv6_flowlabel.c
+++ b/tools/testing/selftests/net/ipv6_flowlabel.c
@@ -1,8 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
 /* Test IPV6_FLOWINFO cmsg on send and recv */
-
-#define _GNU_SOURCE
-
 #include <arpa/inet.h>
 #include <asm/byteorder.h>
 #include <error.h>
diff --git a/tools/testing/selftests/net/ipv6_flowlabel_mgr.c b/tools/testing/selftests/net/ipv6_flowlabel_mgr.c
index af95b48acea9..ebd219ba386e 100644
--- a/tools/testing/selftests/net/ipv6_flowlabel_mgr.c
+++ b/tools/testing/selftests/net/ipv6_flowlabel_mgr.c
@@ -1,8 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
 /* Test IPV6_FLOWINFO_MGR */
-
-#define _GNU_SOURCE
-
 #include <arpa/inet.h>
 #include <error.h>
 #include <errno.h>
diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.c b/tools/testing/selftests/net/mptcp/mptcp_connect.c
index d2043ec3bf6d..ea93030ed3ec 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.c
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.c
@@ -1,7 +1,4 @@
 // SPDX-License-Identifier: GPL-2.0
-
-#define _GNU_SOURCE
-
 #include <errno.h>
 #include <limits.h>
 #include <fcntl.h>
diff --git a/tools/testing/selftests/net/mptcp/mptcp_inq.c b/tools/testing/selftests/net/mptcp/mptcp_inq.c
index 218aac467321..c5bf873d76c2 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_inq.c
+++ b/tools/testing/selftests/net/mptcp/mptcp_inq.c
@@ -1,7 +1,4 @@
 // SPDX-License-Identifier: GPL-2.0
-
-#define _GNU_SOURCE
-
 #include <assert.h>
 #include <errno.h>
 #include <fcntl.h>
diff --git a/tools/testing/selftests/net/mptcp/mptcp_sockopt.c b/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
index 926b0be87c99..7203ca9900e9 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
+++ b/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
@@ -1,7 +1,4 @@
 // SPDX-License-Identifier: GPL-2.0
-
-#define _GNU_SOURCE
-
 #include <assert.h>
 #include <errno.h>
 #include <fcntl.h>
diff --git a/tools/testing/selftests/net/msg_zerocopy.c b/tools/testing/selftests/net/msg_zerocopy.c
index bdc03a2097e8..9278bf585c80 100644
--- a/tools/testing/selftests/net/msg_zerocopy.c
+++ b/tools/testing/selftests/net/msg_zerocopy.c
@@ -24,9 +24,6 @@
  * the kernel queues completions on the error queue for all zerocopy
  * transfers.
  */
-
-#define _GNU_SOURCE
-
 #include <arpa/inet.h>
 #include <error.h>
 #include <errno.h>
diff --git a/tools/testing/selftests/net/netfilter/audit_logread.c b/tools/testing/selftests/net/netfilter/audit_logread.c
index a0a880fc2d9d..0b3dddab1c52 100644
--- a/tools/testing/selftests/net/netfilter/audit_logread.c
+++ b/tools/testing/selftests/net/netfilter/audit_logread.c
@@ -1,6 +1,4 @@
 // SPDX-License-Identifier: GPL-2.0
-
-#define _GNU_SOURCE
 #include <errno.h>
 #include <fcntl.h>
 #include <poll.h>
diff --git a/tools/testing/selftests/net/netfilter/conntrack_dump_flush.c b/tools/testing/selftests/net/netfilter/conntrack_dump_flush.c
index bd9317bf5ada..fb6c5d1b6f63 100644
--- a/tools/testing/selftests/net/netfilter/conntrack_dump_flush.c
+++ b/tools/testing/selftests/net/netfilter/conntrack_dump_flush.c
@@ -1,7 +1,4 @@
 // SPDX-License-Identifier: GPL-2.0
-
-#define _GNU_SOURCE
-
 #include <time.h>
 #include <libmnl/libmnl.h>
 #include <netinet/ip.h>
diff --git a/tools/testing/selftests/net/nettest.c b/tools/testing/selftests/net/nettest.c
index cd8a58097448..88e1d3b2ddf1 100644
--- a/tools/testing/selftests/net/nettest.c
+++ b/tools/testing/selftests/net/nettest.c
@@ -3,8 +3,6 @@
  *
  * Copyright (c) 2013-2019 David Ahern <dsahern@gmail.com>. All rights reserved.
  */
-
-#define _GNU_SOURCE
 #include <features.h>
 #include <sys/types.h>
 #include <sys/ioctl.h>
diff --git a/tools/testing/selftests/net/psock_fanout.c b/tools/testing/selftests/net/psock_fanout.c
index 1a736f700be4..5b2d34440ae9 100644
--- a/tools/testing/selftests/net/psock_fanout.c
+++ b/tools/testing/selftests/net/psock_fanout.c
@@ -26,9 +26,6 @@
  * Todo:
  * - functionality: PACKET_FANOUT_FLAG_DEFRAG
  */
-
-#define _GNU_SOURCE		/* for sched_setaffinity */
-
 #include <arpa/inet.h>
 #include <errno.h>
 #include <fcntl.h>
diff --git a/tools/testing/selftests/net/psock_snd.c b/tools/testing/selftests/net/psock_snd.c
index edf1e6f80d41..2f29b513e18f 100644
--- a/tools/testing/selftests/net/psock_snd.c
+++ b/tools/testing/selftests/net/psock_snd.c
@@ -1,7 +1,4 @@
 // SPDX-License-Identifier: GPL-2.0
-
-#define _GNU_SOURCE
-
 #include <arpa/inet.h>
 #include <errno.h>
 #include <error.h>
diff --git a/tools/testing/selftests/net/reuseport_addr_any.c b/tools/testing/selftests/net/reuseport_addr_any.c
index b8475cb29be7..9ee6ece52865 100644
--- a/tools/testing/selftests/net/reuseport_addr_any.c
+++ b/tools/testing/selftests/net/reuseport_addr_any.c
@@ -3,9 +3,6 @@
 /* Test that sockets listening on a specific address are preferred
  * over sockets listening on addr_any.
  */
-
-#define _GNU_SOURCE
-
 #include <arpa/inet.h>
 #include <errno.h>
 #include <error.h>
diff --git a/tools/testing/selftests/net/reuseport_bpf_cpu.c b/tools/testing/selftests/net/reuseport_bpf_cpu.c
index 2d646174729f..e93e38cfb2a8 100644
--- a/tools/testing/selftests/net/reuseport_bpf_cpu.c
+++ b/tools/testing/selftests/net/reuseport_bpf_cpu.c
@@ -11,9 +11,6 @@
  * This entire process is done for several different core id permutations
  * and for each IPv4/IPv6 and TCP/UDP combination.
  */
-
-#define _GNU_SOURCE
-
 #include <arpa/inet.h>
 #include <errno.h>
 #include <error.h>
diff --git a/tools/testing/selftests/net/reuseport_bpf_numa.c b/tools/testing/selftests/net/reuseport_bpf_numa.c
index c9ba36aa688e..502fdb9ce770 100644
--- a/tools/testing/selftests/net/reuseport_bpf_numa.c
+++ b/tools/testing/selftests/net/reuseport_bpf_numa.c
@@ -3,9 +3,6 @@
  * Test functionality of BPF filters with SO_REUSEPORT. Same test as
  * in reuseport_bpf_cpu, only as one socket per NUMA node.
  */
-
-#define _GNU_SOURCE
-
 #include <arpa/inet.h>
 #include <errno.h>
 #include <error.h>
diff --git a/tools/testing/selftests/net/reuseport_dualstack.c b/tools/testing/selftests/net/reuseport_dualstack.c
index fb7a59ed759e..d3c3d3f39f8f 100644
--- a/tools/testing/selftests/net/reuseport_dualstack.c
+++ b/tools/testing/selftests/net/reuseport_dualstack.c
@@ -10,9 +10,6 @@
  * This test creates these mixed AF_INET/AF_INET6 sockets and asserts the
  * AF_INET preference for v4 packets.
  */
-
-#define _GNU_SOURCE
-
 #include <arpa/inet.h>
 #include <errno.h>
 #include <error.h>
diff --git a/tools/testing/selftests/net/so_incoming_cpu.c b/tools/testing/selftests/net/so_incoming_cpu.c
index e9fa14e10732..95bd0cdc3253 100644
--- a/tools/testing/selftests/net/so_incoming_cpu.c
+++ b/tools/testing/selftests/net/so_incoming_cpu.c
@@ -1,6 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
 /* Copyright Amazon.com Inc. or its affiliates. */
-#define _GNU_SOURCE
 #include <sched.h>
 
 #include <fcntl.h>
diff --git a/tools/testing/selftests/net/so_netns_cookie.c b/tools/testing/selftests/net/so_netns_cookie.c
index b39e87e967cd..18532d564f79 100644
--- a/tools/testing/selftests/net/so_netns_cookie.c
+++ b/tools/testing/selftests/net/so_netns_cookie.c
@@ -1,5 +1,4 @@
 // SPDX-License-Identifier: GPL-2.0
-#define _GNU_SOURCE
 #include <sched.h>
 #include <unistd.h>
 #include <stdio.h>
diff --git a/tools/testing/selftests/net/so_txtime.c b/tools/testing/selftests/net/so_txtime.c
index 8457b7ccbc09..011a24af9786 100644
--- a/tools/testing/selftests/net/so_txtime.c
+++ b/tools/testing/selftests/net/so_txtime.c
@@ -9,9 +9,6 @@
  * the expected stream. Sender will read transmit timestamps from the error
  * queue. The streams can differ due to out-of-order delivery and drops.
  */
-
-#define _GNU_SOURCE
-
 #include <arpa/inet.h>
 #include <error.h>
 #include <errno.h>
diff --git a/tools/testing/selftests/net/tap.c b/tools/testing/selftests/net/tap.c
index 247c3b3ac1c9..fa78b92d9740 100644
--- a/tools/testing/selftests/net/tap.c
+++ b/tools/testing/selftests/net/tap.c
@@ -1,7 +1,4 @@
 // SPDX-License-Identifier: GPL-2.0
-
-#define _GNU_SOURCE
-
 #include <errno.h>
 #include <fcntl.h>
 #include <stdio.h>
diff --git a/tools/testing/selftests/net/tcp_fastopen_backup_key.c b/tools/testing/selftests/net/tcp_fastopen_backup_key.c
index c1cb0c75156a..d30f89bb944c 100644
--- a/tools/testing/selftests/net/tcp_fastopen_backup_key.c
+++ b/tools/testing/selftests/net/tcp_fastopen_backup_key.c
@@ -12,7 +12,6 @@
  * there are no cases in which a cookie is not accepted by verifying
  * that TcpExtTCPFastOpenPassiveFail remains 0.
  */
-#define _GNU_SOURCE
 #include <arpa/inet.h>
 #include <errno.h>
 #include <error.h>
diff --git a/tools/testing/selftests/net/tcp_inq.c b/tools/testing/selftests/net/tcp_inq.c
index bd6a9c7a3e8a..71ee145f151e 100644
--- a/tools/testing/selftests/net/tcp_inq.c
+++ b/tools/testing/selftests/net/tcp_inq.c
@@ -5,8 +5,6 @@
  *
  * Simple example on how to use TCP_INQ and TCP_CM_INQ.
  */
-#define _GNU_SOURCE
-
 #include <error.h>
 #include <netinet/in.h>
 #include <netinet/tcp.h>
diff --git a/tools/testing/selftests/net/tcp_mmap.c b/tools/testing/selftests/net/tcp_mmap.c
index 4fcce5150850..72d5f1207ee0 100644
--- a/tools/testing/selftests/net/tcp_mmap.c
+++ b/tools/testing/selftests/net/tcp_mmap.c
@@ -46,7 +46,6 @@
  * received 32768 MB (99.9939 % mmap'ed) in 7.43764 s, 36.9577 Gbit
  *   cpu usage user:0.035 sys:3.467, 106.873 usec per MB, 65530 c-switches
  */
-#define _GNU_SOURCE
 #include <pthread.h>
 #include <sys/types.h>
 #include <fcntl.h>
diff --git a/tools/testing/selftests/net/tls.c b/tools/testing/selftests/net/tls.c
index f27a12d2a2c9..6dbad97d1d0a 100644
--- a/tools/testing/selftests/net/tls.c
+++ b/tools/testing/selftests/net/tls.c
@@ -1,7 +1,4 @@
 // SPDX-License-Identifier: GPL-2.0
-
-#define _GNU_SOURCE
-
 #include <arpa/inet.h>
 #include <errno.h>
 #include <error.h>
diff --git a/tools/testing/selftests/net/toeplitz.c b/tools/testing/selftests/net/toeplitz.c
index 9ba03164d73a..e2d739892ce4 100644
--- a/tools/testing/selftests/net/toeplitz.c
+++ b/tools/testing/selftests/net/toeplitz.c
@@ -20,9 +20,6 @@
  * 5. Compute the cpu that RPS should select based on rx_hash and $rps_bitmap
  * 6. Compare the cpus from 4 and 5
  */
-
-#define _GNU_SOURCE
-
 #include <arpa/inet.h>
 #include <errno.h>
 #include <error.h>
diff --git a/tools/testing/selftests/net/tun.c b/tools/testing/selftests/net/tun.c
index fa83918b62d1..a64dcfb242c1 100644
--- a/tools/testing/selftests/net/tun.c
+++ b/tools/testing/selftests/net/tun.c
@@ -1,7 +1,4 @@
 // SPDX-License-Identifier: GPL-2.0
-
-#define _GNU_SOURCE
-
 #include <errno.h>
 #include <fcntl.h>
 #include <stdio.h>
diff --git a/tools/testing/selftests/net/txring_overwrite.c b/tools/testing/selftests/net/txring_overwrite.c
index 7d9ea039450a..96972e0110a0 100644
--- a/tools/testing/selftests/net/txring_overwrite.c
+++ b/tools/testing/selftests/net/txring_overwrite.c
@@ -4,9 +4,6 @@
  * Verify that consecutive sends over packet tx_ring are mirrored
  * with their original content intact.
  */
-
-#define _GNU_SOURCE
-
 #include <arpa/inet.h>
 #include <assert.h>
 #include <error.h>
diff --git a/tools/testing/selftests/net/txtimestamp.c b/tools/testing/selftests/net/txtimestamp.c
index ec60a16c9307..33dba9e90dea 100644
--- a/tools/testing/selftests/net/txtimestamp.c
+++ b/tools/testing/selftests/net/txtimestamp.c
@@ -16,9 +16,6 @@
  * This test requires a dummy TCP server.
  * A simple `nc6 [-u] -l -p $DESTPORT` will do
  */
-
-#define _GNU_SOURCE
-
 #include <arpa/inet.h>
 #include <asm/types.h>
 #include <error.h>
diff --git a/tools/testing/selftests/net/udpgso.c b/tools/testing/selftests/net/udpgso.c
index 85b3baa3f7f3..9dc1026a033a 100644
--- a/tools/testing/selftests/net/udpgso.c
+++ b/tools/testing/selftests/net/udpgso.c
@@ -1,7 +1,4 @@
 // SPDX-License-Identifier: GPL-2.0
-
-#define _GNU_SOURCE
-
 #include <stddef.h>
 #include <arpa/inet.h>
 #include <error.h>
diff --git a/tools/testing/selftests/net/udpgso_bench_rx.c b/tools/testing/selftests/net/udpgso_bench_rx.c
index 1cbadd267c96..999df1236320 100644
--- a/tools/testing/selftests/net/udpgso_bench_rx.c
+++ b/tools/testing/selftests/net/udpgso_bench_rx.c
@@ -1,7 +1,4 @@
 // SPDX-License-Identifier: GPL-2.0
-
-#define _GNU_SOURCE
-
 #include <arpa/inet.h>
 #include <error.h>
 #include <errno.h>
diff --git a/tools/testing/selftests/net/udpgso_bench_tx.c b/tools/testing/selftests/net/udpgso_bench_tx.c
index 477392715a9a..d7632993b354 100644
--- a/tools/testing/selftests/net/udpgso_bench_tx.c
+++ b/tools/testing/selftests/net/udpgso_bench_tx.c
@@ -1,7 +1,4 @@
 // SPDX-License-Identifier: GPL-2.0
-
-#define _GNU_SOURCE
-
 #include <arpa/inet.h>
 #include <errno.h>
 #include <error.h>
-- 
2.45.0.118.g7fe29c98d7-goog


