Return-Path: <linux-kselftest+bounces-49514-lists+linux-kselftest=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eMNnFjS0b2nHMAAAu9opvQ
	(envelope-from <linux-kselftest+bounces-49514-lists+linux-kselftest=lfdr.de@vger.kernel.org>)
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 Jan 2026 17:58:28 +0100
X-Original-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E779848266
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 Jan 2026 17:58:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8D138942F6C
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 Jan 2026 14:19:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECE9143E4BD;
	Tue, 20 Jan 2026 14:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="o65XwdB9";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="DQr8iziB"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB61A43CEF2;
	Tue, 20 Jan 2026 14:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768918243; cv=none; b=TwZdg5gcWZ7dmZvb9PQNzX2vcouiifr4vCavuky4rhG/E4tk7KcZWvV4LFnKYt1Vxfanw2D0zzg4p2SgXdAhELI3PpK1r3PVpXXII1edgG+SlXPFe0CcA7PmW0gkTmvC8A1z/c8jzrrTBFqKjzvx3GIA4dxV26T4EwPi+W3XO7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768918243; c=relaxed/simple;
	bh=gEyQT5Kcy9TJYGJ474UFnWhLZFO3ndb9iMUj0fZR+P0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Xlt2yczCWbi91g8iT29njGEPyo2FNqNPFSFKNrhC/pKOkfiruxxw7/llfwrznt7K8MFrBOv39vvjE1QOoCKOs5RkU8QuTtZrhXa8LaB98uBrYTwtk4B1XpbBWpySERhV/ic5WZpr6Ua3R9pfaZ3i30pJYs2Of6HrYuD1UIF6PFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=o65XwdB9; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=DQr8iziB; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1768918240;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aaabGWtTucbZ8WjnJZ8jyHDns+gX0JvT/KU/uRiSp04=;
	b=o65XwdB9ZsuKO6X8SlMdGBWHV1er2KvM1zGyZ933WAAci29EnYDG1WDWVuH2jNRH32Re9T
	KU74HSp6R5wpyg1u4QNPRA360B9F54yXRotiEf1W3r4yzwU3CwNbKeqmMXMp7K1f4cA9nJ
	ov4BZJnvK7MDcS3MHbeXfOrxU4eCVtcbEl0Olz2lb18frkcnpYrMO2SJBSIRJYy0Y6YWAM
	b0obIzZN7nNA5d/rZU51OlzogHwEBhLFTujSrJtpPjxDsoG2W+mfwNd/hAnJYot6m+LHZP
	q43a/2ZcMgfVIvWeqP5T1YzGh4MvoTDOWOUwL4FsrOSgv/10CAOUAE6Rd1E2Mw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1768918240;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aaabGWtTucbZ8WjnJZ8jyHDns+gX0JvT/KU/uRiSp04=;
	b=DQr8iziBzPVx6w6Qd1ifMB+zNRKVJIcikpI/fhVtclnM2b47YnrFGAlzPBgRY/hbavkmlV
	94DIdcN9Fc7i0vAg==
Date: Tue, 20 Jan 2026 15:10:32 +0100
Subject: [PATCH net-next v2 2/4] selftests/landlock: Move some UAPI header
 inclusions after libc ones
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260120-uapi-sockaddr-v2-2-63c319111cf6@linutronix.de>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1768918237; l=1356;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=gEyQT5Kcy9TJYGJ474UFnWhLZFO3ndb9iMUj0fZR+P0=;
 b=vsXslEDMsuoiJY6VjPUQt3pMJ6PFOs4k30AXxu/bclwWz3MLbiSvMXmg37uv3pUcdncGpAGpm
 KLXGLl8k+XFDkstK9st5ouee/sbd/CM4+SAhGjnjJrFeZfhsM418+zy
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
	TAGGED_FROM(0.00)[bounces-49514-lists,linux-kselftest=lfdr.de];
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
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	TAGGED_RCPT(0.00)[linux-kselftest];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo,linutronix.de:email,linutronix.de:dkim,linutronix.de:mid]
X-Rspamd-Queue-Id: E779848266
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
 tools/testing/selftests/landlock/audit.h | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/landlock/audit.h b/tools/testing/selftests/landlock/audit.h
index 44eb433e9666..c12b16c690dc 100644
--- a/tools/testing/selftests/landlock/audit.h
+++ b/tools/testing/selftests/landlock/audit.h
@@ -7,9 +7,6 @@
 
 #define _GNU_SOURCE
 #include <errno.h>
-#include <linux/audit.h>
-#include <linux/limits.h>
-#include <linux/netlink.h>
 #include <regex.h>
 #include <stdbool.h>
 #include <stdint.h>
@@ -20,6 +17,10 @@
 #include <sys/time.h>
 #include <unistd.h>
 
+#include <linux/audit.h>
+#include <linux/limits.h>
+#include <linux/netlink.h>
+
 #include "kselftest.h"
 
 #ifndef ARRAY_SIZE

-- 
2.52.0


