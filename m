Return-Path: <linux-kselftest+bounces-34722-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F518AD5878
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Jun 2025 16:21:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ACDF13A4E23
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Jun 2025 14:20:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68D512C0303;
	Wed, 11 Jun 2025 14:19:19 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81020272E7C;
	Wed, 11 Jun 2025 14:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749651559; cv=none; b=EzUZtcfU45jJobiiT9R3ouMoWQKwm4eySmBSif7PQwQMpqY9HBi/9OzZUTYXRgQFYYIvZ+zlVtHDOXwvbSVqcQf3jf/0sIkw4UUDcMIP0RlwLu3VkijcbT4YOP2MSoJrWCLAiMrw2xbeOaQehVZfxK7/hqTTYkzefUvU36ZSKEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749651559; c=relaxed/simple;
	bh=EdA74/+V2zz2asOoQAH6QfMca+RqGWUEWsqPEKaI6bc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mSFYFiGeQk1ctoBmPYY9qt2k/zP0VElIe4DfuF20WQsntCV/Fmg53nIxnQSP9c5nkr9n2WTmfTu2uhm9xHvQCze2BNHrNMVMeewEM/BuWTZ5Bx+RVi8m3fLIdsWf+qMtoTuaAgO6lBLMyi8PkiCw4ohkXaD/jzEbunz9fwxj52c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-607cf70b00aso7656313a12.2;
        Wed, 11 Jun 2025 07:19:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749651556; x=1750256356;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TQ0YLkP+R6uUe1ptSrDSo+/Jx3Q/UQ8OAewlKbpdVaw=;
        b=W1VnvHBHTIBPgTB4kyNDjs8t31FXOSTw2/21le8J3JINXe+/X5Kcm0uDNj/QBmE3Pg
         zOr3uj7g+TKptLNXhnoyl9sj1WhR6KwWA+9c+lavTTEI2g4M9JtQDMADBOubXeUSFlID
         0UDnZ+mxhqmJt/QMgMUFFclC5sUR7vJ7pAb/xq4agH4VAw6hsiStrDnUNqckteYkTEYZ
         2cGNSxxNtcdGbOgXpMT9kFsSILU4HiGwk5LusxwIr+n1Fl0G3SNlV46E3i3g6kYG1f+a
         kIxyHPyY534Xs8Dq7FutiW0kvNHB2UkAfUzI5/4iP/kNC7aRqtOD+eYBaeuRrLw2pcbj
         2S/w==
X-Forwarded-Encrypted: i=1; AJvYcCVX9l8bhoLWdwKqIzCgKxDTVM4eUxQJJ7vvSiVvMweSLs/Q0isZQriiq1Ugqn14P0mWJ/IkijkXC8YKqfA=@vger.kernel.org, AJvYcCXzWchfpSUivBQB14iv9+tv1FgyuCv7gqASIZaBl2gUCnqRoXZ1g/VAhGLzRHM1c0G5Amvn5sVPurz0+ANYvapK@vger.kernel.org
X-Gm-Message-State: AOJu0Yxo/YOZf5ywWL4znN2z+pPMmCZ4yK0VQG6PaEV1mIi6XDensvPF
	Fv4bGfyVtvQv/WIlWmKWR/mOxNgEsff3BKuddmG8eA04coxDfUS/Sjoi
X-Gm-Gg: ASbGncvN+boC3hUI+yUNwY3fATF2124DqiVc64iwM6gVCadhf9P44tZpUOWspchoftx
	rJ9VyZCb+xiziCVxNXuAJ/NFPAjbuECMTAgBjfurejQvbAzsGqqLPS4LzTqRezjdTppRsjiMkip
	syj55DCn54HOMAi/5iA6vEpxuHhfdpfDOWNf6OvjXCzrbwWto7KbWGNMGemkBzMSFYVASOVFUow
	dfJ3e6NwaPS+vgs3VIDmGzCQ/EZ0WJTjdkMX1GBU21OR3ykwU4ne2svVBq5Mhsbe/sA8ldmk61o
	dLLJsPprG1DtuKDM2CoprNMrmt8R+9895mnebDeQeygCeq9m84EY
X-Google-Smtp-Source: AGHT+IF07su2dp6sPs/dNAXxWpm5VPq+/wBVQDjmDG/s/wUGdmtqkVBr8Cff6TAXYAX9QWWABCFLtw==
X-Received: by 2002:a17:907:9803:b0:ad8:9e80:6bc3 with SMTP id a640c23a62f3a-ade893db0e9mr348809866b.1.1749651555664;
        Wed, 11 Jun 2025 07:19:15 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:2::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ade399c1887sm772487166b.93.2025.06.11.07.19.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jun 2025 07:19:15 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
Date: Wed, 11 Jun 2025 07:18:55 -0700
Subject: [PATCH net-next v2 6/7] netconsole: improve code style in parser
 function
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250611-rework-v2-6-ab1d92b458ca@debian.org>
References: <20250611-rework-v2-0-ab1d92b458ca@debian.org>
In-Reply-To: <20250611-rework-v2-0-ab1d92b458ca@debian.org>
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Breno Leitao <leitao@debian.org>, 
 kernel-team@meta.com
X-Mailer: b4 0.15-dev-42535
X-Developer-Signature: v=1; a=openpgp-sha256; l=2089; i=leitao@debian.org;
 h=from:subject:message-id; bh=EdA74/+V2zz2asOoQAH6QfMca+RqGWUEWsqPEKaI6bc=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBoSZBZWwKGd8sQ+x+DyIsXrnHQ35lo2Y+YeVH7m
 /inujdQ9QuJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaEmQWQAKCRA1o5Of/Hh3
 bVHzD/0V7QBMgOr8bZZqOnqpL2w2mWFIVvyZ/flWYE0fnW01Q3I6GgrETwhPj7zRbFwdZ+VDdru
 elEPxdWqnQkLHDYWj308kXAfNAa2Kmo6niknr+PuNg8BlhHPtwpqEuZ2iLoPpqkdZFHlsrPygiW
 sO7wGi7xsnkI0fxqW2gv2YA4Wn1Zua9xPDWcM7I974NdCORS57iDHDZb9jbevjKtY0M2wZi08qD
 63x8058Md4ku9/Rmx1Ab13nMdzNM6UPBzyZpknQ8g17DuZEmG4VPG6SYavPTX7FA2WRsc+LG7Ih
 LzUjwZjfRlf+U12XSLQN19AI0kwh600qVcZkth6LiRydrXYCFZIQ/BzDU8gmsiDdwHr0LXprdEV
 rdZLfNUeCH7DkKfHkBQFCCt3K/ke4Gz49EgfcxawQNZiL1uKYzbJidHg+8hIfma1jzpK8EDFxCX
 UZmD4GwSlK9BpWazKP/J1oPVuzlDQiLEZfIIoPGUHKxn3Qx0V5kXIYquV9doJUJ1wfpS1eNAifZ
 FiYq0qEKFhtQJtNquLPs54mzdrPkJRRojcKhh4E++gh2QpfCiPzVHNSauX4dTP5QQ1D4M80M4SZ
 MfUttiwuuoRS3upr2wFsy5UOfhSNvx2Ha/imbS+iIpBdz0nk9Fm6mMhcmc4JTNY4cajX7cQvHzt
 MFM9O4wbtVhdRrw==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

Split assignment from conditional checks and use preferred null pointer
check style (!delim instead of == NULL) in netconsole_parser_cmdline().
This improves code readability and follows kernel coding style
conventions.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 drivers/net/netconsole.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
index 7f1fed7871967..56d14294ddcaf 100644
--- a/drivers/net/netconsole.c
+++ b/drivers/net/netconsole.c
@@ -1705,7 +1705,8 @@ static int netconsole_parser_cmdline(struct netpoll *np, char *opt)
 	int ipv6;
 
 	if (*cur != '@') {
-		if ((delim = strchr(cur, '@')) == NULL)
+		delim = strchr(cur, '@');
+		if (!delim)
 			goto parse_failed;
 		*delim = 0;
 		if (kstrtou16(cur, 10, &np->local_port))
@@ -1716,7 +1717,8 @@ static int netconsole_parser_cmdline(struct netpoll *np, char *opt)
 
 	if (*cur != '/') {
 		ipversion_set = true;
-		if ((delim = strchr(cur, '/')) == NULL)
+		delim = strchr(cur, '/');
+		if (!delim)
 			goto parse_failed;
 		*delim = 0;
 		ipv6 = netpoll_parse_ip_addr(cur, &np->local_ip);
@@ -1730,7 +1732,8 @@ static int netconsole_parser_cmdline(struct netpoll *np, char *opt)
 
 	if (*cur != ',') {
 		/* parse out dev_name or dev_mac */
-		if ((delim = strchr(cur, ',')) == NULL)
+		delim = strchr(cur, ',');
+		if (!delim)
 			goto parse_failed;
 		*delim = 0;
 
@@ -1747,7 +1750,8 @@ static int netconsole_parser_cmdline(struct netpoll *np, char *opt)
 
 	if (*cur != '@') {
 		/* dst port */
-		if ((delim = strchr(cur, '@')) == NULL)
+		delim = strchr(cur, '@');
+		if (!delim)
 			goto parse_failed;
 		*delim = 0;
 		if (*cur == ' ' || *cur == '\t')
@@ -1759,7 +1763,8 @@ static int netconsole_parser_cmdline(struct netpoll *np, char *opt)
 	cur++;
 
 	/* dst ip */
-	if ((delim = strchr(cur, '/')) == NULL)
+	delim = strchr(cur, '/');
+	if (!delim)
 		goto parse_failed;
 	*delim = 0;
 	ipv6 = netpoll_parse_ip_addr(cur, &np->remote_ip);

-- 
2.47.1


