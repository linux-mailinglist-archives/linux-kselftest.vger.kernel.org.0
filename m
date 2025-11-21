Return-Path: <linux-kselftest+bounces-46246-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A266DC7A6E3
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Nov 2025 16:12:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 75F764EF9C6
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Nov 2025 15:01:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB4FB2D3731;
	Fri, 21 Nov 2025 15:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i1agepvm"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D849336D514
	for <linux-kselftest@vger.kernel.org>; Fri, 21 Nov 2025 15:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763737233; cv=none; b=OIIgPhp9yhfaODyb0UDkpmsoUku8QLRKxZGNqEuB532WZUcNJsYWtPraYkn7pMhVve6Twgsr3SjqEo1aFEH90hxf65v/X5R0QTgG80Dlp/Mk4R6rYPPG7pr/hJiQCKpxWrfwUGObo8TLhUcH+oKZ4R3gy5AvIRd0T2Pr9ajyoOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763737233; c=relaxed/simple;
	bh=tPo9szc/3/AwnPVWQuT0ceOIKU5O7fFK1Snwf0Sx4iw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=HYA8VlDPIBrJJTCkgibyq6B0T+0ofvqUK8noZBYDfJ507OTDWycJZjlbm5rWItKLfvovdUYlq89gym1I0wegsH83/zfgIfBUCjfBa5hFc/mhFwvnrbbsohhK6t/o5UzyhHzJDh/+S5am6vIOAAfNG74AT8E1lXkOale851gUnQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i1agepvm; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2956d816c10so25287175ad.1
        for <linux-kselftest@vger.kernel.org>; Fri, 21 Nov 2025 07:00:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763737231; x=1764342031; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IS6KghpVM4CDdXoCAN6CR1CtFYv1L4PoQrnM0I3bBQs=;
        b=i1agepvmk3PM8U8oPig8KBExZSaKMAirWE/qgAP0lFLZFI7rE4jDUCY+o9c+vu7idG
         Fi5GDitqay3yXijL4OkzN0HyTI8bQ5jcTDRjPRvhdJGmJed71FObVlln2CSHvgIA7u4I
         EA84BqEx2fX9S4dA0sKugux/E3t6C4x7KpwW3OmdjvSeVux64GiVzdzp8pwmnjLC1JpT
         hI0m9pQwLgWqxsXV1jBaslPCm1JPvSWr4KPYI08BxKiT63pICDYvHJCeUyyJVZNTYLdB
         H924JXHSb60y8W+M/x2FqmGzVyCscV3/QHjBGnYTnuSjjp5DEEHotRNHrJS+jd6MJeZi
         H1fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763737231; x=1764342031;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IS6KghpVM4CDdXoCAN6CR1CtFYv1L4PoQrnM0I3bBQs=;
        b=tdO5WJ+ezEcYa4EAev57btg5wx+VbLcM4kLbYl7icfotel0VjtDTMVckslnUK8IIUP
         GpsXuN/O4tRcq6r16XC/UpiEZCsgWFHGJhdqtN/Z6JC60WrMIBUz/vHxWFY5X1+EPkDO
         N5fmbyMljWxL5DxQP6a/Z79RNKIszzARJHzBzqUJIsEpao2NpLqq+cPA/ONAYoVBvT3b
         uZVZ+sE7AiCeuTQhNaPHEhTNfwNuEXl849S/aYh4z2hE5ewE8/LHYOCfoOzLBX8iXMGB
         2Ll96GaBKGq2LSQa6dNFLP4gdaiCyVSyqFtaKXonLxcxa9WlhNvTIYmufGnNi08EuDjX
         8fcQ==
X-Forwarded-Encrypted: i=1; AJvYcCWbM0PrC84sc6JGArnuzv7y0dRM+crJouHeoBedEKnrMV7k2NrUqClRK0uzYkMmqgMiJQhpGrT+N1hHmdyJZz4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXiYd683KiwHRhDB449bXLiM0ppjjq4Hpu7K1Vw5ysTiXV1uD0
	/gfZGroNmiUhT5SCJwDYuR9OvCR1cwZ/xozWi78u3VYINVbcG7Eqn8iw
X-Gm-Gg: ASbGnctB/ol9lwi9Tuz/qbEqKoRPoltIjH+avkvA99uUszx3c+W/AkAm5gkCvnQpCF2
	zCgwCd7o+ZP9k0VyLjRYdx2cx2zAJ7GkbIq/QhSDbUf2q39ZN9sE2tRSsPdcTy1YIZ3VhQOdAtr
	YDVR2KFe4xtBuVKOd0NBmEfsClhx2wsxOHX/Zq0JMe0R96q5Hd+3Bcmj86ACD8FTcSXy+ZhfqSm
	8/vmBuc0J3THuGGw55mFQgEJctPpXkLCDkL6QU1BgUaU+7FnX2XNMZk+ZINWG2qd6UY4aHEVNiP
	4ncuFPEdH4bLdIXV8OXnp0ECuGYWIfAAET1fLahQYd4RP493GmxbOs1rJ3WSzG453BDK8byWR/0
	McZI4byXPXBhe30orrjiUYEr5H1hODWZfARwRxlO2kL1HMNRSI1PKpP/o72KtE81dr4eCErw0Ur
	8KU54ctV0vbavuPLHRLiHqQkGSw68=
X-Google-Smtp-Source: AGHT+IHFoy7IDjjbCiy/0djx9IzAwERFFsu1k9IqHQ+Nlpu4NrdOTHvguxg46wR7xi1KxvSEsoITEQ==
X-Received: by 2002:a17:90b:5112:b0:340:f05a:3eca with SMTP id 98e67ed59e1d1-34733f0c7c6mr3239695a91.20.1763737230816;
        Fri, 21 Nov 2025 07:00:30 -0800 (PST)
Received: from [192.168.15.94] ([2804:7f1:ebc3:6e1:12e1:8eff:fe46:88b8])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-345b03971fcsm6374313a91.5.2025.11.21.07.00.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Nov 2025 07:00:30 -0800 (PST)
From: Andre Carvalho <asantostc@gmail.com>
Date: Fri, 21 Nov 2025 15:00:22 +0000
Subject: [PATCH net-next] selftests: netconsole: ensure required log level
 is set on netcons_basic
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251121-netcons-basic-loglevel-v1-1-577f8586159c@gmail.com>
X-B4-Tracking: v=1; b=H4sIAIV+IGkC/x3MQQrCQAxG4auUrA00gSr1KuKiHX9rYJiRSSmF0
 rsbXL7F9w5yNIPTvTuoYTO3WiLk0lH6TGUB2yuatNdBRIUL1lSL8zy5Jc51ydiQ+TpCbzIk6XW
 kwN+Gt+3/8YPChNtXep7nD7YZq/RyAAAA
X-Change-ID: 20251121-netcons-basic-loglevel-69e2715c1029
To: Breno Leitao <leitao@debian.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Andre Carvalho <asantostc@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1763737225; l=1705;
 i=asantostc@gmail.com; s=20250807; h=from:subject:message-id;
 bh=tPo9szc/3/AwnPVWQuT0ceOIKU5O7fFK1Snwf0Sx4iw=;
 b=bvKQgKgxt3dwuSkdVUbu+seE8vvStciTZ3t95zOTJvzdjcn8IqvTyZDj0UOsBHrSpDiyChj2w
 jkJnXfYCn2PDuzRlLsTM8MA9xaLVmrft76wQ/d8fG/aoXS05UtRyNNC
X-Developer-Key: i=asantostc@gmail.com; a=ed25519;
 pk=eWre+RwFHCxkiaQrZLsjC67mZ/pZnzSM/f7/+yFXY4Q=

This commit ensures that the required log level is set at the start of
the test iteration.

Part of the cleanup performed at the end of each test iteration resets
the log level (do_cleanup in lib_netcons.sh) to the values defined at the
time test script started. This may cause further test iterations to fail
if the default values are not sufficient.

Signed-off-by: Andre Carvalho <asantostc@gmail.com>
---
 tools/testing/selftests/drivers/net/netcons_basic.sh | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/netcons_basic.sh b/tools/testing/selftests/drivers/net/netcons_basic.sh
index a3446b569976..2022f3061738 100755
--- a/tools/testing/selftests/drivers/net/netcons_basic.sh
+++ b/tools/testing/selftests/drivers/net/netcons_basic.sh
@@ -28,8 +28,6 @@ OUTPUT_FILE="/tmp/${TARGET}"
 
 # Check for basic system dependency and exit if not found
 check_for_dependencies
-# Set current loglevel to KERN_INFO(6), and default to KERN_NOTICE(5)
-echo "6 5" > /proc/sys/kernel/printk
 # Remove the namespace, interfaces and netconsole target on exit
 trap cleanup EXIT
 
@@ -39,6 +37,9 @@ do
 	for IP_VERSION in "ipv6" "ipv4"
 	do
 		echo "Running with target mode: ${FORMAT} (${IP_VERSION})"
+		# Set current loglevel to KERN_INFO(6), and default to
+		# KERN_NOTICE(5)
+		echo "6 5" > /proc/sys/kernel/printk
 		# Create one namespace and two interfaces
 		set_network "${IP_VERSION}"
 		# Create a dynamic target for netconsole

---
base-commit: e2c20036a8879476c88002730d8a27f4e3c32d4b
change-id: 20251121-netcons-basic-loglevel-69e2715c1029

Best regards,
-- 
Andre Carvalho <asantostc@gmail.com>


