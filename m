Return-Path: <linux-kselftest+bounces-34898-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BF173AD8A89
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Jun 2025 13:33:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1CAEC189EBDF
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Jun 2025 11:33:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D83782E6D23;
	Fri, 13 Jun 2025 11:32:03 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E56FA2E62B2;
	Fri, 13 Jun 2025 11:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749814323; cv=none; b=rq4YZU2XRSQhzN6U7Hpb0OfWXgE/r0M/xipHxRaOE/wk+CuJteGfAgLTuDxX3v6vnI2s4kxS9X5zCtsIteRSp+sxirHtM/K5kLuPEf4JEpIZSdd9a3gp6T3pWjHvWqnRXPPrM1feCxen/WghTObce0ELBXmwqIHQAz7GCEZFV4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749814323; c=relaxed/simple;
	bh=v2AyUbx52O1gs/YWNE9pnzapy576jxcuy3r269njaSs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AGdX+T3GKPjzRvX0oxFIZWlbpdcx2pyCp4fYPBsIH1EiCTS3ICi7ej60caD3WsYQUG3dX1vyegL8VQzI8y+DUEG3bYicffIRyAcFWiVUURa6mumFt4E8j984TxqgbzyBTUUy8PGESHqpsoLp+zXnCkxwyQev/DzLDb3t5/NSMTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-60794c43101so3252999a12.1;
        Fri, 13 Jun 2025 04:32:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749814320; x=1750419120;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VhEBmrSyNjBmM6vK3z4Rkzv0tIsdnlSn/AelZ3lrD8Y=;
        b=pPAdZlf7i9hD7bVipdyez+OuTQ711kvHHNFsOj/IIMKjMAoV+0EEL32XiaJTv4P7SG
         uTMN8sLR8f+hgoPPrMNNol/S8WkPkcZ9NqSj8r/re+DF/fpGAZyTHMGn/nrPhY+0k3zv
         cQ88iYw2EEsPgUKoaZVMqDOXIG7LY3O9zVsO/r03AaCtrGQbdyZeOO8qulhNKvKMKTiY
         atH0aC/AZ4ln/D4o5h8uui2q0TqKsIuqF43mWg5sEoP2HNdyDOFKJgz2yfJx+oOJK87a
         jgx22yZuX7mrKEATGJnmYTcUT0daA/39nqNrv/5/0k7X+tFAvPMDHwmhYCXypi5i1wS3
         YBtA==
X-Forwarded-Encrypted: i=1; AJvYcCWd8q3x20nWuIEcMvCckleaRqLnTsLtkz14F4Rs7ONLTPnWvVP/lNjTiMW5MTQFu1FqAb7nkzeUbjCKNJw=@vger.kernel.org, AJvYcCXrW/LiwnI4tzKFIp8W/IToNK1CXJ06PbCU6BJVMErhNojEo35apt+ayDQZzEmBOtncPsI4pKq0tXMU27X6uKvQ@vger.kernel.org
X-Gm-Message-State: AOJu0Yzz/X2yZu+6ryNEBto5+TiKfFHES8pf34tgLJ9jiLkkPNppz4EH
	7BOgWOnZJmuBwIeatA6N62atH6X/CU2rtOARQYjgl4Q6YnE6Ma2GMMv4pEiT6g==
X-Gm-Gg: ASbGncsfh3cDriREymGbX/VYnsxxNtS9LorarJosNbgi3wDIUU9+GAp/HvSM68TY5kz
	LeB/Y+V5liUZcCKVsOUWwAJiTlgedaH2IfQEUBFCdFtomnJHJt2WpkOByKHhyJ5w2Aj3nnKygc7
	CHcM/SrKabX/MLCXBFmsRg1K+D2TPP8wQITmSWLy4540JXddi+TvEt7DejY/sSyYppQteClCY5B
	cGW+yzUXeuodUH3/tZuQL2OoSVDGcijYE3aYTHsFqnjW7NoeoGMOqr9PmhbGzWBk4pQOXeBhKm9
	UDVJYXok6zvHQuU+W8U5oX0L/o2irOqocQx05WmaIs2UZkwsGgGp
X-Google-Smtp-Source: AGHT+IGH29MsGdsyDdX2Z8TNZrZNaJjZsWSLiareYRl29R+I89Y9mWSZZ5fiCjbE615gBy3lWvD7EQ==
X-Received: by 2002:a05:6402:51d3:b0:608:48fc:ff73 with SMTP id 4fb4d7f45d1cf-608b4a15e54mr2305491a12.26.1749814319839;
        Fri, 13 Jun 2025 04:31:59 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:5::])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-608b4a5ac30sm1094772a12.47.2025.06.13.04.31.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jun 2025 04:31:59 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
Date: Fri, 13 Jun 2025 04:31:35 -0700
Subject: [PATCH net-next v3 6/8] netconsole: improve code style in parser
 function
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250613-rework-v3-6-0752bf2e6912@debian.org>
References: <20250613-rework-v3-0-0752bf2e6912@debian.org>
In-Reply-To: <20250613-rework-v3-0-0752bf2e6912@debian.org>
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Breno Leitao <leitao@debian.org>, 
 gustavold@gmail.com
X-Mailer: b4 0.15-dev-42535
X-Developer-Signature: v=1; a=openpgp-sha256; l=2089; i=leitao@debian.org;
 h=from:subject:message-id; bh=v2AyUbx52O1gs/YWNE9pnzapy576jxcuy3r269njaSs=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBoTAwlIooOP45UEY2HVSTsbcD8RnHx7dcZUWtxV
 gqFjDJ2xWeJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaEwMJQAKCRA1o5Of/Hh3
 bbdiEACS/g7tKfAyDBTbIj4y+smtuGhcwZyV0W/+GtbSa4/wWam6hfKrF0cQ4kHv6UH74HLEMJy
 eAY0RevLzAzHrmoEn27Cn3wBUu7z0fG0L7vNlzjyieukr/zrlNgRNi+pPzJew0let1KfUmWmwI8
 fs1URPU1inPRhNrEWfVUGQ1lZ1iCFqSyNKNqecmUooN6qzxODq19vGrzx/SMW4WfJcQH6qQBr9K
 JHj775AYiDXuA4Y9s1BCJKnDL4FWtvrpw7L58VyfpVShVy8AhtQl4YJ66O5BlsfRvhG9v5n5/eY
 MmQTJKL+KX2n754YoQG6pBaqKAhXF52hcq+h73nRidSAMfQAsBFoYx9tek58T6zc6k/CsH9IU9K
 dPDntS9YRs/izbYvYtURfgqAZM81SuG93KgdNC99FOpDeNbv51T2G3GVfYGWyOq9kFL4pbE6JS9
 WnUUZQRc2BHnriGHpx2fqkKW5njeltGIcf0whrB1A4WRWbdEIF2xn3XogdZv0jOnsRInaSHdsmW
 qT1Yh8fVNI7fHmsEQ0dsvo7o2yGGv2drILYL2SWQUCNvQiFsuHl+kAL5KfnC4RjY2cAAM/g77Tc
 WhuPT425pxp2MIw/nk3JBvJOmwJ7B05gsox5zu5en7mBHOy5HRXgpY+sDz6HnIJhkyvk4r/ult5
 p1JUexOnJo8eSrA==
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
index cc45ec18848c9..89afe127b46c9 100644
--- a/drivers/net/netconsole.c
+++ b/drivers/net/netconsole.c
@@ -1704,7 +1704,8 @@ static int netconsole_parser_cmdline(struct netpoll *np, char *opt)
 	int ipv6;
 
 	if (*cur != '@') {
-		if ((delim = strchr(cur, '@')) == NULL)
+		delim = strchr(cur, '@');
+		if (!delim)
 			goto parse_failed;
 		*delim = 0;
 		if (kstrtou16(cur, 10, &np->local_port))
@@ -1715,7 +1716,8 @@ static int netconsole_parser_cmdline(struct netpoll *np, char *opt)
 
 	if (*cur != '/') {
 		ipversion_set = true;
-		if ((delim = strchr(cur, '/')) == NULL)
+		delim = strchr(cur, '/');
+		if (!delim)
 			goto parse_failed;
 		*delim = 0;
 		ipv6 = netpoll_parse_ip_addr(cur, &np->local_ip);
@@ -1729,7 +1731,8 @@ static int netconsole_parser_cmdline(struct netpoll *np, char *opt)
 
 	if (*cur != ',') {
 		/* parse out dev_name or dev_mac */
-		if ((delim = strchr(cur, ',')) == NULL)
+		delim = strchr(cur, ',');
+		if (!delim)
 			goto parse_failed;
 		*delim = 0;
 
@@ -1746,7 +1749,8 @@ static int netconsole_parser_cmdline(struct netpoll *np, char *opt)
 
 	if (*cur != '@') {
 		/* dst port */
-		if ((delim = strchr(cur, '@')) == NULL)
+		delim = strchr(cur, '@');
+		if (!delim)
 			goto parse_failed;
 		*delim = 0;
 		if (*cur == ' ' || *cur == '\t')
@@ -1758,7 +1762,8 @@ static int netconsole_parser_cmdline(struct netpoll *np, char *opt)
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


