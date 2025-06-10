Return-Path: <linux-kselftest+bounces-34603-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A84A5AD3CD8
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Jun 2025 17:24:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C23A16A783
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Jun 2025 15:22:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AF8424678D;
	Tue, 10 Jun 2025 15:18:36 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A6AA246770;
	Tue, 10 Jun 2025 15:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749568716; cv=none; b=IsuzybRcfFr1mKdfHVkCuSI5Zr0wIy3qzuOYByJZf7o1uh0Yx71x98uAaNYbD8oP83NEaTFV1frl/l1+IAd/fw0ZuRFGqbdk2HkeOyrw7TVtwuv/WuXULhp5l+Gcz7cZxoHfZOqtnYC+AYdAtCpErCEL//CRPReysu0OBNnFkZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749568716; c=relaxed/simple;
	bh=EFQnMbuoE7wGo8TFaGGcNNF0Xsjmk7DiwkC5gz6Bm6o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qAVuXU6O7EoguTGOzYu5SAB7hSGQjrihmRTXdCq7LK7XJLTngcPBhCqFQLkG775CqAgJU5sbpmwI0y2JpXCLFBgpz5yZEhYPVTWd5Rs5dYXM2ykfFmVY9GJX8VoKjaWdwkAfvf+gOgYwmU5x/Fu7TmwWOxXjVeqP8U5sOQFI/xI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-60780d74c8cso6997349a12.2;
        Tue, 10 Jun 2025 08:18:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749568713; x=1750173513;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MFOyEeCTQwX/1iCWq4y06MO74LLbRFJPgwC7bFpkrFw=;
        b=Ly9MS9PQFGcs/lPO9ywn8yc3HD9JXCHkxkrfscrNffqXryXe1LBIkoLtLAD0Nz3WuK
         uZ4MHv5i+3QL2akfvSLzIsi3JL5OkgLSdjCaXzG3emroPCxGaJKkrZ5kK+MrKh4PJsnk
         eM72eAcvSemURfSpNpcRc5hOgLAjtUqFUGjXfWsysXlz42kGxgEiDLj5cRY/kwBy8LCq
         Qz+2lRMkd++LbtXA6pk9eS+XC0opMeeIuWJ4o3WaR378b7jwVSR121ukeuB7XWBrISmx
         erKWXlQpDda4sV0G4UptKZZixqhclLGB6+P40Z6BGKVjus4IUzPnImCdhDSy8neq6qXj
         G5Ng==
X-Forwarded-Encrypted: i=1; AJvYcCUnq0vPcsYqfNXVD23Qy8dXJ3bCdILfFbhvBjVM23FyHpiXRJ5zpm5TI3acefxU/js1si0IP9W1mUjv2oM=@vger.kernel.org, AJvYcCXfgNghS2sfHRTOLZ3Piyg7PjaB32nIsr6TvVoVvrvOXkV3nzJ3hR6LlWFMalI22eNvbp9Bpm4n4/Fx4SKXMIvZ@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8JxsKxQOuxO7RAHfmJRQE22qyi3eKX6z/m8bim0XlI12PDPP1
	Io1QQrW9N2Z5ssDn9zY4kMPF3NusxVtz9g+l/HujSzsqXsykWaiDxAf/
X-Gm-Gg: ASbGncuNdYfi/FcOua5xW/0h0Q99ZOt+3hvbQiO8wkn1pxNO6ucWucD/hh3GzFFSl9b
	2b4pVL4Dt7z7dhTkCo4sXCyiAlEZoSQSqSui1IM923XsrAvlfg3x+B7PQ+zoIsv5qaVHJoWNOud
	mtNZd2q2OHsbqZTieXy8SMClbxn7UZFIslYh7b1GQf5HVRk56ZISmYSk9PWlJnMvBmo343dQBKt
	8SWU+8Nmy4n9REc9IJIoHz9oXifgWAfB4XMVl3GzntSg8gCR8RtHiMIwwG03hCqSZlnA5hg9gxi
	qQRE2d5T6vr1EZ0Z9/XP6sMUbtjvUGcXaqApaB0JLoExz01dXr+nTQ==
X-Google-Smtp-Source: AGHT+IHlrZMS4vkl2I6tfIJnHV3TX6eJQigH+Q4Qbu7WiRpFW30GdN/QKBdmn1yS98LHb8s7NYcg0Q==
X-Received: by 2002:a17:907:60d0:b0:ad8:50c3:3359 with SMTP id a640c23a62f3a-ade1a8da8ecmr1492684166b.9.1749568712542;
        Tue, 10 Jun 2025 08:18:32 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:73::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ade1dc7b252sm728930466b.159.2025.06.10.08.18.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jun 2025 08:18:32 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
Date: Tue, 10 Jun 2025 08:18:18 -0700
Subject: [PATCH net-next 6/7] netconsole: improve code style in parser
 function
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250610-rework-v1-6-7cfde283f246@debian.org>
References: <20250610-rework-v1-0-7cfde283f246@debian.org>
In-Reply-To: <20250610-rework-v1-0-7cfde283f246@debian.org>
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Breno Leitao <leitao@debian.org>, 
 kernel-team@meta.com
X-Mailer: b4 0.15-dev-42535
X-Developer-Signature: v=1; a=openpgp-sha256; l=2089; i=leitao@debian.org;
 h=from:subject:message-id; bh=EFQnMbuoE7wGo8TFaGGcNNF0Xsjmk7DiwkC5gz6Bm6o=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBoSEy+Vvhsfjp96VTvHkkdYeA2w+WaqLInfIIfh
 WOjTbcE9CeJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaEhMvgAKCRA1o5Of/Hh3
 bWKeD/48dsHypmbqd/qrkPlpBLopWHhErhxInd8ABD7ly7MSggoCNyX0BLXgeLzQKpWeBw1XalT
 mOGJnkL1+Hu1Y/RsCNBZ25T3D9YVNODlGKzAG/LeN5RX9CwL3xwLd6cv6MmzU7P778ISs3fNnAT
 DORXM7xQNUyUxwQTE8uIOwUbaiSqLYhylnJKz5DadOB6mTmjeoMM0yR4YM1VW1djW9Gu53O2f16
 DMQDlpjVHZivGSPxVV4WGhQeVDm+WjIXNqHNMI+8Hhc53CitlmJjEGEDl+yTl6tUZ5TBGq/TMvu
 oiCF+gARpnzdQLTUNriLF8rw5i37yvOerepbIdGxljg7bwUEdsZgI7PH0nf+lozqV8rrGJoEKU8
 ErPML/Q5Us4N8Y7tSB/N8l6F/xW+r4VNuVHMlF9wqhXMz6WqRkjWRpF45L5tMZNaRyHrAM8uMcT
 mznoeLSzjWSGXSjfMBWCsjclo3s4+QRo4uOZhjG5CLElcWoMdXexwKt7jflQZ8j7D9m0rKjyPU6
 2cuk9Rv29+ZW1YiDPkDHdzAqMgLbMUzeAuF57+MxPnR7ORUtf5doEQIMv+iFB1sBJTIG9vj61BK
 JE14VsNV8kkbBgOoSCHVMolYjqI5KRaM9//YmMjj2dfbABV8gpqtuLzwCTxH8pxkKEm5ZKCTUDz
 oba3warVX6rLINA==
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
index 3406a5cbdc11a..2a13b6f16f082 100644
--- a/drivers/net/netconsole.c
+++ b/drivers/net/netconsole.c
@@ -1659,7 +1659,8 @@ static int netconsole_parser_cmdline(struct netpoll *np, char *opt)
 	int ipv6;
 
 	if (*cur != '@') {
-		if ((delim = strchr(cur, '@')) == NULL)
+		delim = strchr(cur, '@');
+		if (!delim)
 			goto parse_failed;
 		*delim = 0;
 		if (kstrtou16(cur, 10, &np->local_port))
@@ -1670,7 +1671,8 @@ static int netconsole_parser_cmdline(struct netpoll *np, char *opt)
 
 	if (*cur != '/') {
 		ipversion_set = true;
-		if ((delim = strchr(cur, '/')) == NULL)
+		delim = strchr(cur, '/');
+		if (!delim)
 			goto parse_failed;
 		*delim = 0;
 		ipv6 = netpoll_parse_ip_addr(cur, &np->local_ip);
@@ -1684,7 +1686,8 @@ static int netconsole_parser_cmdline(struct netpoll *np, char *opt)
 
 	if (*cur != ',') {
 		/* parse out dev_name or dev_mac */
-		if ((delim = strchr(cur, ',')) == NULL)
+		delim = strchr(cur, ',');
+		if (!delim)
 			goto parse_failed;
 		*delim = 0;
 
@@ -1701,7 +1704,8 @@ static int netconsole_parser_cmdline(struct netpoll *np, char *opt)
 
 	if (*cur != '@') {
 		/* dst port */
-		if ((delim = strchr(cur, '@')) == NULL)
+		delim = strchr(cur, '@');
+		if (!delim)
 			goto parse_failed;
 		*delim = 0;
 		if (*cur == ' ' || *cur == '\t')
@@ -1713,7 +1717,8 @@ static int netconsole_parser_cmdline(struct netpoll *np, char *opt)
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


