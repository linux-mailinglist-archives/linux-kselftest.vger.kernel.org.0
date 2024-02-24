Return-Path: <linux-kselftest+bounces-5409-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C82FB8623A8
	for <lists+linux-kselftest@lfdr.de>; Sat, 24 Feb 2024 10:07:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EAF171C21EDB
	for <lists+linux-kselftest@lfdr.de>; Sat, 24 Feb 2024 09:07:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C99483F9DF;
	Sat, 24 Feb 2024 09:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="A9oEuHl6"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0DB43C48F
	for <linux-kselftest@vger.kernel.org>; Sat, 24 Feb 2024 09:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708765498; cv=none; b=GeOV3GH8eESJYsyNoQU/jXs/XZaYCiVj82zi3Yiki9VdRVSHKUM6RFrMV0WrWfsjGudz1cVjYu0yT7qZoizpiOlEVV/rLPaA+4rLynEYOwX6G7HvWw5DEi64XfK8OjKbuX/D+gdLn0xkAW+Nz1mKJE9UihwVL3354FV9aVghPSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708765498; c=relaxed/simple;
	bh=4jErwg55G7DEzjwCRCrWJtVME975m5guzjG380jeS9k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JxAiknRUd8Cw+u3M44qBfKZP6v3hUFeH7kaukI4T8Q2YblW8QEvSb10SgiN4jJEYXX2WRpnUp31EnsNke5eqXcj4UftXmkGUDPWbOxfbFMgIkJSUeve8nCMg9wB8eHUKNo+LDu9qWN6MhsvScdpBO89TKeqV2V1yQAb4Zbb99sg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com; spf=pass smtp.mailfrom=arista.com; dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b=A9oEuHl6; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arista.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-412985a51ecso5467175e9.0
        for <linux-kselftest@vger.kernel.org>; Sat, 24 Feb 2024 01:04:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google; t=1708765495; x=1709370295; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rRIDgmvdBuy4FEMojsFBGRvXRNCtma2xryE9RPsDnfQ=;
        b=A9oEuHl6sjxlDeml6V8i/R62ztS4OWgUMKsJepuxR51nisyApnBYf9G+8kVEGU2pOf
         azqCend3/dTMws3379Zkgt7K7Ww0akbyABF5XffOUo0S1vxgC69JTSEaDqormuRexh5e
         XD3azSuERnJoLlWKygy3aVWyDxpFvlLHzEnAK1H9UoUmtXa6P1oKXwESPpWD5JiikbMQ
         GPMpjCtTNoVzmkNDfNwNv/gPvaq+mXhs92AI1cIoXqU745hLpqi1vdzagH6D5QkO3dcJ
         cnTpa5IqoytEWpJnUGoEhiU5UoHMBIWCQBW/QLQtqMGG7MhpHaOTIimtK4d3n4mOYzOc
         qLag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708765495; x=1709370295;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rRIDgmvdBuy4FEMojsFBGRvXRNCtma2xryE9RPsDnfQ=;
        b=ji3S+j7vYIeM8JONEwiXceDgQXsykW1xfhyhw+LlG2zK5vpxnIOV/Z/SmOmL7pgvjK
         ElT3OXAjYn9gpmplWDPxMcY511lRZcdLIMK67Pb67kDxZtlP07JGMab4tmifUt5RfJoZ
         euP2f54gIBGstqpQWkDsq5KuVKwl7Tc2hivCJvr0I8ZtDxSakUT0tKptJiWJhCwuiDZy
         /qKjxUvTALz/AADWMj9PuxK7FMXm5ekbhecIhAUCohrWtiLn3Yr7AHUgQ0PLJVjvUsBp
         4oR0ZO/4Tnz5eeJDUrCIg1JJTTz9AiAwp/Uez5wS23/I9t0ZpxQ4T7gnT2IgcB4swJTB
         TNkw==
X-Forwarded-Encrypted: i=1; AJvYcCU5GQ10kazFY7C2sngxt7hs/SezZrGWFISbKZAhScb/7bJskfQqKsUMeMi3Jdbvk3EAiknPHokqaP8UhV/nOVsK8kFkEl+IqKK8iiNEgqDa
X-Gm-Message-State: AOJu0Yw7WhzK95OD+ZnHjJEOLMf6XbSC4006RPyDPv/2oQIujta3p/Te
	KTYU9ChUeYxQWSsSi0YONvslRRPmFig02s+/PjApEb2c1Lor/2avpzjuN9Kaew==
X-Google-Smtp-Source: AGHT+IFSjDUOo1EgIt8K5PVSqhLCRMxukx8XXQRsDPkwIrrfKNDL4fqMJiZ+mpwLKC5uDF/T8yNpUg==
X-Received: by 2002:a05:600c:2e04:b0:410:a039:ed5d with SMTP id o4-20020a05600c2e0400b00410a039ed5dmr1673611wmf.33.1708765495316;
        Sat, 24 Feb 2024 01:04:55 -0800 (PST)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id m6-20020a7bce06000000b00410bca333b7sm5320593wmc.27.2024.02.24.01.04.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Feb 2024 01:04:54 -0800 (PST)
From: Dmitry Safonov <dima@arista.com>
To: Eric Dumazet <edumazet@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	David Ahern <dsahern@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Dmitry Safonov <dima@arista.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Dmitry Safonov <0x7f454c46@gmail.com>
Subject: [PATCH net-next 08/10] selftests/net: Be consistnat in kconfig checks
Date: Sat, 24 Feb 2024 09:04:16 +0000
Message-ID: <20240224-tcp-ao-tracepoints-v1-8-15f31b7f30a7@arista.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240224-tcp-ao-tracepoints-v1-0-15f31b7f30a7@arista.com>
References: <20240224-tcp-ao-tracepoints-v1-0-15f31b7f30a7@arista.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.13-dev-b6b4b
X-Developer-Signature: v=1; a=ed25519-sha256; t=1708765347; l=2695; i=dima@arista.com; s=20231212; h=from:subject:message-id; bh=4jErwg55G7DEzjwCRCrWJtVME975m5guzjG380jeS9k=; b=afMpsCOt6xNpXARvG8bjI9wO61Dv76Tvjx05gMcpY6lZY365igt8bIUOsSzqko7QzMKAYLvny 2rTLQQQC9xyAQ3Viq8xdsZkk+BnMO5EjWEgG53r6fqakvaQFtEiZlQz
X-Developer-Key: i=dima@arista.com; a=ed25519; pk=hXINUhX25b0D/zWBKvd6zkvH7W2rcwh/CH6cjEa3OTk=
Content-Transfer-Encoding: 8bit

Most of the functions in tcp-ao lib/ return negative errno or -1 in case
of a failure. That creates inconsistencies in lib/kconfig, which saves
what was the error code. As well as the uninitialized kconfig value is
-1, which also may be the result of a check.

Define KCONFIG_UNKNOWN and save negative return code, rather than
libc-style errno.

Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 tools/testing/selftests/net/tcp_ao/lib/kconfig.c | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/tools/testing/selftests/net/tcp_ao/lib/kconfig.c b/tools/testing/selftests/net/tcp_ao/lib/kconfig.c
index f279ffc3843b..3bf4a7e4b3c9 100644
--- a/tools/testing/selftests/net/tcp_ao/lib/kconfig.c
+++ b/tools/testing/selftests/net/tcp_ao/lib/kconfig.c
@@ -6,7 +6,7 @@
 #include "aolib.h"
 
 struct kconfig_t {
-	int _errno;		/* the returned error if not supported */
+	int _error;		/* negative errno if not supported */
 	int (*check_kconfig)(int *error);
 };
 
@@ -62,7 +62,7 @@ static int has_tcp_ao(int *err)
 	memcpy(&tmp.addr, &addr, sizeof(addr));
 	*err = 0;
 	if (setsockopt(sk, IPPROTO_TCP, TCP_AO_ADD_KEY, &tmp, sizeof(tmp)) < 0) {
-		*err = errno;
+		*err = -errno;
 		if (errno != ENOPROTOOPT)
 			ret = -errno;
 	}
@@ -87,7 +87,7 @@ static int has_tcp_md5(int *err)
 	 */
 	*err = 0;
 	if (test_set_md5(sk, addr_any, 0, -1, DEFAULT_TEST_PASSWORD)) {
-		*err = errno;
+		*err = -errno;
 		if (errno != ENOPROTOOPT && errno == ENOMEM) {
 			test_print("setsockopt(TCP_MD5SIG_EXT): %m");
 			ret = -errno;
@@ -116,13 +116,14 @@ static int has_vrfs(int *err)
 	return ret;
 }
 
+#define KCONFIG_UNKNOWN			1
 static pthread_mutex_t kconfig_lock = PTHREAD_MUTEX_INITIALIZER;
 static struct kconfig_t kconfig[__KCONFIG_LAST__] = {
-	{ -1, has_net_ns },
-	{ -1, has_veth },
-	{ -1, has_tcp_ao },
-	{ -1, has_tcp_md5 },
-	{ -1, has_vrfs },
+	{ KCONFIG_UNKNOWN, has_net_ns },
+	{ KCONFIG_UNKNOWN, has_veth },
+	{ KCONFIG_UNKNOWN, has_tcp_ao },
+	{ KCONFIG_UNKNOWN, has_tcp_md5 },
+	{ KCONFIG_UNKNOWN, has_vrfs },
 };
 
 const char *tests_skip_reason[__KCONFIG_LAST__] = {
@@ -138,11 +139,11 @@ bool kernel_config_has(enum test_needs_kconfig k)
 	bool ret;
 
 	pthread_mutex_lock(&kconfig_lock);
-	if (kconfig[k]._errno == -1) {
-		if (kconfig[k].check_kconfig(&kconfig[k]._errno))
+	if (kconfig[k]._error == KCONFIG_UNKNOWN) {
+		if (kconfig[k].check_kconfig(&kconfig[k]._error))
 			test_error("Failed to initialize kconfig %u", k);
 	}
-	ret = kconfig[k]._errno == 0;
+	ret = kconfig[k]._error == 0;
 	pthread_mutex_unlock(&kconfig_lock);
 	return ret;
 }

-- 
2.43.0


