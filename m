Return-Path: <linux-kselftest+bounces-49515-lists+linux-kselftest=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gFCcJBCtb2nxEwAAu9opvQ
	(envelope-from <linux-kselftest+bounces-49515-lists+linux-kselftest=lfdr.de@vger.kernel.org>)
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 Jan 2026 17:28:00 +0100
X-Original-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 6333847812
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 Jan 2026 17:28:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id E07C87015F7
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 Jan 2026 14:19:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42F7744CF24;
	Tue, 20 Jan 2026 14:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rtlQ7SdG";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="QDVif8ks"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C28D639E6D5;
	Tue, 20 Jan 2026 14:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768918244; cv=none; b=bmiKENZ+csedBIR54RWw5frnTqJ9zSifYSbcwYnMkrFyVXxJy6avqf7zurp2Y8YSBIshrLvXbOQiK8IVR/RRA9ZZOV8gENq6hVoS/Qzt0gWWJ5I9HJ4tG3bCIxhUDXP0wprNwojtc6c3HpWyrinrjEHI+ZC7JpKUjKZmo+Okv4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768918244; c=relaxed/simple;
	bh=ZqrmLjkMijbcJc3IQS7wKin/D1t2uoZP1sLY/xgFZdI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eZxjNdWciwL0ICfC+c9uVm9YtOliNhr6j/KywUV2g8pQM+FOqdKmSyZdHDNJSoqR3mOFV3XnMNdZz32/TD3uw11kUv0pSCrSSCEQXU+cPqxop5msJfcCda2hJFuMS73rEcsAfjj+3zVAG915RH2vNMcvGzOYKIFeT7/WjHa9460=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=rtlQ7SdG; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=QDVif8ks; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1768918239;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qWWbJ6p/llOOq5uee8jczRuLvKm3RcJ6H6cwpERIvT8=;
	b=rtlQ7SdGTkp2BTbujdjmEMG4e8L4Y54KOJneDOwznalZgT0PCYNs3Y7xdC4GP1s42jFqvs
	OYVawGSSlmqmXaIvnte9k+7J1aO6Qc47KMMsNqYUKbHgxQy4q1vr/1B+opOMeHb13i+/Cf
	57oGOwhSZP2sR5+qi6Hgy2dsGiAEvuERgBSDCO7W+Ar0fGc6BNFyE+ouDiRNAx5LGInA8U
	jBl9fC39QCqOOM2R8VcWrmIjz0j+XlXhpttFqtZXNU47Dvj7WLfTsYSpjvZpCml4rWwxE7
	CTwlIaeVPVDGIfl05o6I1wzXGuzcXRh19tkbc4sQ4pL5yeFeZXsY8dbo0dJTAA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1768918239;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qWWbJ6p/llOOq5uee8jczRuLvKm3RcJ6H6cwpERIvT8=;
	b=QDVif8kseiztc2+rY9NVDDg7G+ZgDVwdgyTTLRKXpOMyi8AOJaTvACt3+qnfEDXcNeaEU6
	k8z+R2493jKfd/CQ==
Date: Tue, 20 Jan 2026 15:10:31 +0100
Subject: [PATCH net-next v2 1/4] selftests: net: Move some UAPI header
 inclusions after libc ones
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260120-uapi-sockaddr-v2-1-63c319111cf6@linutronix.de>
References: <20260120-uapi-sockaddr-v2-0-63c319111cf6@linutronix.de>
In-Reply-To: <20260120-uapi-sockaddr-v2-0-63c319111cf6@linutronix.de>
To: Eric Dumazet <edumazet@google.com>, 
 Kuniyuki Iwashima <kuniyu@google.com>, Paolo Abeni <pabeni@redhat.com>, 
 Willem de Bruijn <willemb@google.com>, 
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
 Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>, 
 Matthieu Baerts <matttbe@kernel.org>, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, 
 =?utf-8?q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>, 
 =?utf-8?q?G=C3=BCnther_Noack?= <gnoack@google.com>, 
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
 Jesper Dangaard Brouer <hawk@kernel.org>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Stanislav Fomichev <sdf@fomichev.me>, Andrii Nakryiko <andrii@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
 Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-api@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, 
 linux-kselftest@vger.kernel.org, mptcp@lists.linux.dev, 
 linux-security-module@vger.kernel.org, bpf@vger.kernel.org, 
 libc-alpha@sourceware.org, Carlos O'Donell <carlos@redhat.com>, 
 Adhemerval Zanella <adhemerval.zanella@linaro.org>, 
 Rich Felker <dalias@libc.org>, klibc@zytor.com, 
 Florian Weimer <fweimer@redhat.com>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1768918237; l=6177;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=ZqrmLjkMijbcJc3IQS7wKin/D1t2uoZP1sLY/xgFZdI=;
 b=ckR5DvB2GszhHGd1qq5KB7GFMoHcqBtMFjspRoVG+3U1BvA4ONTzZ+DkdODqiPl1YQjsYLnrJ
 xEOvtkyVbdVB683EKZ0pv2XTMRcvDWNfqC1o0UKdWbg5B2QzJsgEYxc
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=
X-Spamd-Result: default: False [-0.46 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-49515-lists,linux-kselftest=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[google.com,redhat.com,davemloft.net,kernel.org,digikod.net,iogearbox.net,gmail.com,fomichev.me,linux.dev];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCPT_COUNT_TWELVE(0.00)[41];
	MIME_TRACE(0.00)[0:+];
	DMARC_POLICY_ALLOW(0.00)[linutronix.de,none];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[thomas.weissschuh@linutronix.de,linux-kselftest@vger.kernel.org];
	DKIM_TRACE(0.00)[linutronix.de:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:7979, ipnet:213.196.21.0/24, country:US];
	TAGGED_RCPT(0.00)[linux-kselftest];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo]
X-Rspamd-Queue-Id: 6333847812
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Interleaving inclusions of UAPI headers and libc headers is problematic.
Both sets of headers define conflicting symbols. To enable their
coexistence a compatibility-mechanism is in place.

An upcoming change will define 'struct sockaddr' from linux/socket.h.
However sys/socket.h from libc does not yet handle this case and a
symbol conflict will arise.

Furthermore libc-compat.h evaluates the state of the libc
inclusions only once, at the point it is included first. If another
problematic header from libc is included later, symbol conflicts arise.
This will trigger other duplicate definitions when linux/libc-compat.h
is added to linux/socket.h

Move the inclusion of UAPI headers after the inclusion of the glibc
ones, so the libc-compat.h continues to work correctly.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 tools/testing/selftests/net/af_unix/diag_uid.c     |  9 +++++----
 tools/testing/selftests/net/busy_poller.c          |  3 ++-
 tools/testing/selftests/net/mptcp/mptcp_diag.c     | 11 ++++++-----
 tools/testing/selftests/net/nettest.c              |  4 ++--
 tools/testing/selftests/net/tcp_ao/icmps-discard.c |  6 +++---
 tools/testing/selftests/net/tcp_ao/lib/netlink.c   |  9 +++++----
 tools/testing/selftests/net/tun.c                  |  5 +++--
 7 files changed, 26 insertions(+), 21 deletions(-)

diff --git a/tools/testing/selftests/net/af_unix/diag_uid.c b/tools/testing/selftests/net/af_unix/diag_uid.c
index da7d50cedee6..05456a205325 100644
--- a/tools/testing/selftests/net/af_unix/diag_uid.c
+++ b/tools/testing/selftests/net/af_unix/diag_uid.c
@@ -5,15 +5,16 @@
 #include <sched.h>
 
 #include <unistd.h>
-#include <linux/netlink.h>
-#include <linux/rtnetlink.h>
-#include <linux/sock_diag.h>
-#include <linux/unix_diag.h>
 #include <sys/socket.h>
 #include <sys/stat.h>
 #include <sys/types.h>
 #include <sys/un.h>
 
+#include <linux/netlink.h>
+#include <linux/rtnetlink.h>
+#include <linux/sock_diag.h>
+#include <linux/unix_diag.h>
+
 #include "kselftest_harness.h"
 
 FIXTURE(diag_uid)
diff --git a/tools/testing/selftests/net/busy_poller.c b/tools/testing/selftests/net/busy_poller.c
index 3a81f9c94795..34bd8d28808a 100644
--- a/tools/testing/selftests/net/busy_poller.c
+++ b/tools/testing/selftests/net/busy_poller.c
@@ -9,7 +9,6 @@
 #include <stdio.h>
 #include <string.h>
 #include <unistd.h>
-#include <ynl.h>
 
 #include <arpa/inet.h>
 #include <netinet/in.h>
@@ -19,6 +18,8 @@
 #include <sys/socket.h>
 #include <sys/types.h>
 
+#include <ynl.h>
+
 #include <linux/genetlink.h>
 #include <linux/netlink.h>
 
diff --git a/tools/testing/selftests/net/mptcp/mptcp_diag.c b/tools/testing/selftests/net/mptcp/mptcp_diag.c
index 8e0b1b8d84b6..af25ebfd2915 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_diag.c
+++ b/tools/testing/selftests/net/mptcp/mptcp_diag.c
@@ -1,11 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 /* Copyright (c) 2025, Kylin Software */
 
-#include <linux/sock_diag.h>
-#include <linux/rtnetlink.h>
-#include <linux/inet_diag.h>
-#include <linux/netlink.h>
-#include <linux/compiler.h>
 #include <sys/socket.h>
 #include <netinet/in.h>
 #include <linux/tcp.h>
@@ -17,6 +12,12 @@
 #include <errno.h>
 #include <stdio.h>
 
+#include <linux/sock_diag.h>
+#include <linux/rtnetlink.h>
+#include <linux/inet_diag.h>
+#include <linux/netlink.h>
+#include <linux/compiler.h>
+
 #ifndef IPPROTO_MPTCP
 #define IPPROTO_MPTCP 262
 #endif
diff --git a/tools/testing/selftests/net/nettest.c b/tools/testing/selftests/net/nettest.c
index 1f5227f3d64d..71430403b50b 100644
--- a/tools/testing/selftests/net/nettest.c
+++ b/tools/testing/selftests/net/nettest.c
@@ -10,8 +10,6 @@
 #include <sys/ioctl.h>
 #include <sys/socket.h>
 #include <sys/wait.h>
-#include <linux/tcp.h>
-#include <linux/udp.h>
 #include <arpa/inet.h>
 #include <net/if.h>
 #include <netinet/in.h>
@@ -30,6 +28,8 @@
 #include <errno.h>
 #include <getopt.h>
 
+#include <linux/tcp.h>
+#include <linux/udp.h>
 #include <linux/xfrm.h>
 #include <linux/ipsec.h>
 #include <linux/pfkeyv2.h>
diff --git a/tools/testing/selftests/net/tcp_ao/icmps-discard.c b/tools/testing/selftests/net/tcp_ao/icmps-discard.c
index 85c1a1e958c6..451ba89914c9 100644
--- a/tools/testing/selftests/net/tcp_ao/icmps-discard.c
+++ b/tools/testing/selftests/net/tcp_ao/icmps-discard.c
@@ -16,12 +16,12 @@
  * Author: Dmitry Safonov <dima@arista.com>
  */
 #include <inttypes.h>
-#include <linux/icmp.h>
-#include <linux/icmpv6.h>
-#include <linux/ipv6.h>
 #include <netinet/in.h>
 #include <netinet/ip.h>
 #include <sys/socket.h>
+#include <linux/icmp.h>
+#include <linux/icmpv6.h>
+#include <linux/ipv6.h>
 #include "aolib.h"
 #include "../../../../include/linux/compiler.h"
 
diff --git a/tools/testing/selftests/net/tcp_ao/lib/netlink.c b/tools/testing/selftests/net/tcp_ao/lib/netlink.c
index 7f108493a29a..69a05820782a 100644
--- a/tools/testing/selftests/net/tcp_ao/lib/netlink.c
+++ b/tools/testing/selftests/net/tcp_ao/lib/netlink.c
@@ -1,14 +1,15 @@
 // SPDX-License-Identifier: GPL-2.0
 /* Original from tools/testing/selftests/net/ipsec.c */
-#include <linux/netlink.h>
-#include <linux/random.h>
-#include <linux/rtnetlink.h>
-#include <linux/veth.h>
 #include <net/if.h>
 #include <stdint.h>
 #include <string.h>
 #include <sys/socket.h>
 
+#include <linux/netlink.h>
+#include <linux/random.h>
+#include <linux/rtnetlink.h>
+#include <linux/veth.h>
+
 #include "aolib.h"
 
 #define MAX_PAYLOAD		2048
diff --git a/tools/testing/selftests/net/tun.c b/tools/testing/selftests/net/tun.c
index 0efc67b0357a..e6e4c52d538e 100644
--- a/tools/testing/selftests/net/tun.c
+++ b/tools/testing/selftests/net/tun.c
@@ -8,12 +8,13 @@
 #include <stdlib.h>
 #include <string.h>
 #include <unistd.h>
+#include <sys/ioctl.h>
+#include <sys/socket.h>
+
 #include <linux/if.h>
 #include <linux/if_tun.h>
 #include <linux/netlink.h>
 #include <linux/rtnetlink.h>
-#include <sys/ioctl.h>
-#include <sys/socket.h>
 
 #include "kselftest_harness.h"
 

-- 
2.52.0


