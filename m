Return-Path: <linux-kselftest+bounces-44789-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EC3AAC34719
	for <lists+linux-kselftest@lfdr.de>; Wed, 05 Nov 2025 09:23:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E8051461F0D
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Nov 2025 08:23:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 373ED28C862;
	Wed,  5 Nov 2025 08:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Ymsd+JrQ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5638528000F;
	Wed,  5 Nov 2025 08:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762330984; cv=none; b=jxk69lcKAXkqrquiwS8v67T4H0/r0FCaYEf6mI2o9KhUO4VKv60A7m/eZo6TvBLh9mW0PVZ6ZCs0vKDqPrVUNEZ+zz0dMBlLv6KKbptAHbKT8qF/6h5vApc+1AuQmgkqtMgSx3O7eGRA1C7a5b9blmqM/BgBuOF4qUa/3lhvlus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762330984; c=relaxed/simple;
	bh=s9FOZHZQ0gEwjOw5MN7047kg7czzICVOZvrPjEPnDdY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=akYyRsZdyVMnfPNSILn3HYEULU9I2Kgysfiz7/g0XvLhKJPoP1Aaz6NZgv6yW/+QjkfRa3eDxBdPVSJ5OsV1cO9ge1JgJovGQ8Pn2L6/IXOwfFHabs+PdTsPAKq93pIAB2KjHuTGMgZL1uFNIFBpmJ/cnxGdbuSkHRw6T4/Z/9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Ymsd+JrQ; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id BA4204E4152D;
	Wed,  5 Nov 2025 08:23:00 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 90B9A60693;
	Wed,  5 Nov 2025 08:23:00 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 1B26F10B517EB;
	Wed,  5 Nov 2025 09:22:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1762330979; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=bfNLoThahEQND+oK8rEnCw7sjdDmfF2S825TIi1Qk88=;
	b=Ymsd+JrQHlSs+5ujzucb4JrT5xBrg7wF8dBe27+GO0Jakvn1dkByI+JaAfKjqYE+lHLCvJ
	V1pfXXXpjLVIuTL/XGale6u4Xzcfr7CL2jZneTY5L03NBcNewU3wFFQ/ZTzO2HFyl3/IdA
	Fr2HYhIvDbYZ47KkgzUJ/suYfs76Fz100WstjvDGdFjwJ2d9FUL3eTkmjwc5VQjAE9/DBY
	cMj/KCELlaMGSN6NwmSl0z6oPHu7txKk6ehN5Ec35RJ95jek/R6etyrSK2O4aNnYA1hkE7
	OvD7P7uVmbQc5582mLXghChaBM2lq+xiJ0UqGCWCXOUq4D2N6/S9on8Npxj9+g==
From: =?utf-8?q?Alexis_Lothor=C3=A9_=28eBPF_Foundation=29?= <alexis.lothore@bootlin.com>
Date: Wed, 05 Nov 2025 09:22:48 +0100
Subject: [PATCH bpf-next 1/2] selftests/bpf: systematically add
 SO_REUSEADDR in start_server_addr
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251105-start-server-soreuseaddr-v1-1-1bbd9c1f8d65@bootlin.com>
References: <20251105-start-server-soreuseaddr-v1-0-1bbd9c1f8d65@bootlin.com>
In-Reply-To: <20251105-start-server-soreuseaddr-v1-0-1bbd9c1f8d65@bootlin.com>
To: Andrii Nakryiko <andrii@kernel.org>, 
 Eduard Zingerman <eddyz87@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, 
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
 Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc: ebpf@linuxfoundation.org, 
 Bastien Curutchet <bastien.curutchet@bootlin.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, bpf@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Alexis_Lothor=C3=A9_=28eBPF_Foundation=29?= <alexis.lothore@bootlin.com>
X-Mailer: b4 0.14.3
X-Last-TLS-Session-Version: TLSv1.3

Some tests have to stop/start a server multiple time with the same
listening address. Doing so without SO_REUSADDR leads to failures due to
the socket still being in TIME_WAIT right after the first instance
stop/before the second instance start. Instead of letting each test
manually set SO_REUSEADDR on their servers, it can be done automatically
by start_server_addr for all tests (and without any major downside).

Enforce SO_REUSEADDR in start_server_addr for all tests.

Signed-off-by: Alexis Lothoré (eBPF Foundation) <alexis.lothore@bootlin.com>
---
 tools/testing/selftests/bpf/network_helpers.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/network_helpers.c b/tools/testing/selftests/bpf/network_helpers.c
index 8bb09167399a..e99b9c5e66a3 100644
--- a/tools/testing/selftests/bpf/network_helpers.c
+++ b/tools/testing/selftests/bpf/network_helpers.c
@@ -97,7 +97,8 @@ int settimeo(int fd, int timeout_ms)
 int start_server_addr(int type, const struct sockaddr_storage *addr, socklen_t addrlen,
 		      const struct network_helper_opts *opts)
 {
-	int fd;
+
+	int on = 1, fd;
 
 	if (!opts)
 		opts = &default_opts;
@@ -111,6 +112,12 @@ int start_server_addr(int type, const struct sockaddr_storage *addr, socklen_t a
 	if (settimeo(fd, opts->timeout_ms))
 		goto error_close;
 
+	if (type == SOCK_STREAM &&
+	    setsockopt(fd, SOL_SOCKET, SO_REUSEADDR, &on, sizeof(on))) {
+		log_err("Failed to enable SO_REUSEADDR");
+		goto error_close;
+	}
+
 	if (opts->post_socket_cb &&
 	    opts->post_socket_cb(fd, opts->cb_opts)) {
 		log_err("Failed to call post_socket_cb");

-- 
2.51.2


