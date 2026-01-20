Return-Path: <linux-kselftest+bounces-49516-lists+linux-kselftest=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UDByOtymb2lDEgAAu9opvQ
	(envelope-from <linux-kselftest+bounces-49516-lists+linux-kselftest=lfdr.de@vger.kernel.org>)
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 Jan 2026 17:01:32 +0100
X-Original-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CFEF46F81
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 Jan 2026 17:01:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 175F470C5EB
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 Jan 2026 14:20:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C68ED44CF4E;
	Tue, 20 Jan 2026 14:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="QVf5JIqw";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="RJuRitW1"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AA82500940;
	Tue, 20 Jan 2026 14:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768918244; cv=none; b=FdvIoOgpHbdp57WsOJXCO//4rFWALMecvrYmpUj/GyVr3HBqMfwVSgpQ8wMcsBncuWqn490LLXIxa4t2kFvrQwY+VRMNg6YjprL+HF4ZDooG14hAD9x/Jgg7D+uQR8Gjw8APQE1tqUlxtQpNpBEU6IQV9qeJzDv8aD3edjSJQ8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768918244; c=relaxed/simple;
	bh=NL2NiPJiVOXGlDSPX/IXGVFv3gZqRodtnl63WyHlrT8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Xrm++7RxC0Em3RiWpH6rlu+9a9eX8ihfykwiaKmuG77ONR1fI4CZoZyVJYKqKlH7gtI5TWw6pNUQBOks4I+JgKkCWeuDKJykLXHp8KH7VAWvCi+zXDY0MQcAC8gYEnWR0+qD1d1K8VLzaRxkM4c/cVeAryGrsrgZQ1CJVz9SCYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=QVf5JIqw; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=RJuRitW1; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1768918240;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Nu42fbo/KTwWbTEJNSfohypBk88voIUWzFlL0jg8Asc=;
	b=QVf5JIqwol6mD0wSHtGINS/EN7+SG1TaEysglbq9pi9jkITL/Re6B8r9X9x+lyNMsRqpr+
	8XrMkTgdTEMUkLM7sG25qiqfsjXPXILaLxUPkLqs52GkMbuftElrt8h5Drpp8hcFEbZXPG
	/l0Ip8WnVMNiGYJW7keA34hVfcfLNEU/+kvuEEhZY8PIGxociJ7gyB7cQDJUbrn9MoK+LX
	uLuDbu849BBC73+/qR2YZyQtxWhx1C1CbOcSbukm0RFVtcDlZ2SDYlZ0kbhUQhjE+B1rEJ
	+8UInYr5n8/ESscYa9Cd16etJGdVkxKTNhXenTkKtKmmdrQWx9ps+uluO9a0gw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1768918240;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Nu42fbo/KTwWbTEJNSfohypBk88voIUWzFlL0jg8Asc=;
	b=RJuRitW17NsGCwZrxdyALTxa2Sop4NEm7M4/2D1lY0J5eoYWa1sEGUUHeaCOAJEb0w0nD3
	s37/9rX4lucFajCQ==
Date: Tue, 20 Jan 2026 15:10:33 +0100
Subject: [PATCH net-next v2 3/4] samples/bpf: Move some UAPI header
 inclusions after libc ones
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260120-uapi-sockaddr-v2-3-63c319111cf6@linutronix.de>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1768918237; l=4542;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=NL2NiPJiVOXGlDSPX/IXGVFv3gZqRodtnl63WyHlrT8=;
 b=eZBfbm8KV848zvW+Ku4Kfcq+zHdcVueYyOFWcMEHikDcFpOV2a627C4aKg6x8k5ZhHbg+N5yr
 +2ISIHCy3/1CwGRF/P2J+p4PIl3ac4MZGzF0g/1GdroJVysJyzTzpnF
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
	TAGGED_FROM(0.00)[bounces-49516-lists,linux-kselftest=lfdr.de];
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
	ASN(0.00)[asn:7979, ipnet:2a01:60a::/32, country:US];
	TAGGED_RCPT(0.00)[linux-kselftest];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo,linutronix.de:email,linutronix.de:dkim,linutronix.de:mid]
X-Rspamd-Queue-Id: 8CFEF46F81
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Interleaving inclusions of UAPI headers and libc headers is problematic.
Both sets of headers define conflicting symbols. To enable their
coexistence a compatibility-mechanism is in place.

An upcoming change will define 'struct sockaddr' from linux/socket.h.
However sys/socket.h from libc does not yet handle this case and a
symbol conflict will arise.

Move the inclusion of all UAPI headers after the inclusion of the glibc
ones, so the compatibility mechanism from the UAPI headers is used.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 samples/bpf/xdp_adjust_tail_user.c |  6 ++++--
 samples/bpf/xdp_fwd_user.c         |  7 ++++---
 samples/bpf/xdp_router_ipv4_user.c |  6 +++---
 samples/bpf/xdp_sample_user.c      | 15 ++++++++-------
 samples/bpf/xdp_tx_iptunnel_user.c |  4 ++--
 5 files changed, 21 insertions(+), 17 deletions(-)

diff --git a/samples/bpf/xdp_adjust_tail_user.c b/samples/bpf/xdp_adjust_tail_user.c
index e9426bd65420..32d00405debc 100644
--- a/samples/bpf/xdp_adjust_tail_user.c
+++ b/samples/bpf/xdp_adjust_tail_user.c
@@ -5,8 +5,6 @@
  * modify it under the terms of version 2 of the GNU General Public
  * License as published by the Free Software Foundation.
  */
-#include <linux/bpf.h>
-#include <linux/if_link.h>
 #include <assert.h>
 #include <errno.h>
 #include <signal.h>
@@ -18,9 +16,13 @@
 #include <netinet/ether.h>
 #include <unistd.h>
 #include <time.h>
+
 #include <bpf/bpf.h>
 #include <bpf/libbpf.h>
 
+#include <linux/bpf.h>
+#include <linux/if_link.h>
+
 #define STATS_INTERVAL_S 2U
 #define MAX_PCKT_SIZE 600
 
diff --git a/samples/bpf/xdp_fwd_user.c b/samples/bpf/xdp_fwd_user.c
index 193b3b79b31f..ca55f3eac12a 100644
--- a/samples/bpf/xdp_fwd_user.c
+++ b/samples/bpf/xdp_fwd_user.c
@@ -11,9 +11,6 @@
  * General Public License for more details.
  */
 
-#include <linux/bpf.h>
-#include <linux/if_link.h>
-#include <linux/limits.h>
 #include <net/if.h>
 #include <errno.h>
 #include <stdio.h>
@@ -27,6 +24,10 @@
 #include <bpf/libbpf.h>
 #include <bpf/bpf.h>
 
+#include <linux/bpf.h>
+#include <linux/if_link.h>
+#include <linux/limits.h>
+
 static __u32 xdp_flags = XDP_FLAGS_UPDATE_IF_NOEXIST;
 
 static int do_attach(int idx, int prog_fd, int map_fd, const char *name)
diff --git a/samples/bpf/xdp_router_ipv4_user.c b/samples/bpf/xdp_router_ipv4_user.c
index 266fdd0b025d..2abc7d294251 100644
--- a/samples/bpf/xdp_router_ipv4_user.c
+++ b/samples/bpf/xdp_router_ipv4_user.c
@@ -1,9 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /* Copyright (C) 2017 Cavium, Inc.
  */
-#include <linux/bpf.h>
-#include <linux/netlink.h>
-#include <linux/rtnetlink.h>
 #include <assert.h>
 #include <errno.h>
 #include <signal.h>
@@ -25,6 +22,9 @@
 #include <libgen.h>
 #include <getopt.h>
 #include <pthread.h>
+#include <linux/bpf.h>
+#include <linux/netlink.h>
+#include <linux/rtnetlink.h>
 #include "xdp_sample_user.h"
 #include "xdp_router_ipv4.skel.h"
 
diff --git a/samples/bpf/xdp_sample_user.c b/samples/bpf/xdp_sample_user.c
index 158682852162..d9aec2bd372c 100644
--- a/samples/bpf/xdp_sample_user.c
+++ b/samples/bpf/xdp_sample_user.c
@@ -7,13 +7,6 @@
 #include <errno.h>
 #include <fcntl.h>
 #include <getopt.h>
-#include <linux/ethtool.h>
-#include <linux/hashtable.h>
-#include <linux/if_link.h>
-#include <linux/jhash.h>
-#include <linux/limits.h>
-#include <linux/list.h>
-#include <linux/sockios.h>
 #include <locale.h>
 #include <math.h>
 #include <net/if.h>
@@ -32,6 +25,14 @@
 #include <time.h>
 #include <unistd.h>
 
+#include <linux/ethtool.h>
+#include <linux/hashtable.h>
+#include <linux/if_link.h>
+#include <linux/jhash.h>
+#include <linux/limits.h>
+#include <linux/list.h>
+#include <linux/sockios.h>
+
 #include "bpf_util.h"
 #include "xdp_sample_user.h"
 
diff --git a/samples/bpf/xdp_tx_iptunnel_user.c b/samples/bpf/xdp_tx_iptunnel_user.c
index 7e4b2f7108a6..e9503036d0a0 100644
--- a/samples/bpf/xdp_tx_iptunnel_user.c
+++ b/samples/bpf/xdp_tx_iptunnel_user.c
@@ -1,8 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /* Copyright (c) 2016 Facebook
  */
-#include <linux/bpf.h>
-#include <linux/if_link.h>
 #include <assert.h>
 #include <errno.h>
 #include <signal.h>
@@ -16,6 +14,8 @@
 #include <time.h>
 #include <bpf/libbpf.h>
 #include <bpf/bpf.h>
+#include <linux/bpf.h>
+#include <linux/if_link.h>
 #include "bpf_util.h"
 #include "xdp_tx_iptunnel_common.h"
 

-- 
2.52.0


