Return-Path: <linux-kselftest+bounces-16129-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3209895C501
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 Aug 2024 07:49:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5BF4B1C24212
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 Aug 2024 05:49:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1382353E22;
	Fri, 23 Aug 2024 05:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NLKflgMl"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-vs1-f41.google.com (mail-vs1-f41.google.com [209.85.217.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 861A3481DA;
	Fri, 23 Aug 2024 05:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724392155; cv=none; b=gAo1LB5oE2MV+4uikpfnnaNEYR2FwAdLhsmjDpuLofxmcfd8mmnkqQToNk0OAWB+yvavSKU5KxQJqc+Dl9fk+0CxZBfxKR68oe/6ynqVfSzflO7P0vQFm5JKT8eKp/YXOwhrocSRum+68k9e+KrJua9HCv6a6sRs/khYdZdSBdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724392155; c=relaxed/simple;
	bh=yZ7oCN9ZyYk0NuKy1QwMa/Anh4jMqThaLPtQmNl0iME=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LgCRvnqwz+U6XOzT7UDNJjpOlS3K80iNX0IMs1Zul1yrz7+/kwkkvbsO/GTQgYQtJm9PhOmlUZSQPyy1I3lsF38tOwk4lT5Cv50sz0s3FJReUvjXRiYeekc88NyGRcLSI0hGbhu6rBeHXYwMGKuQ182Fw/jHEVYLh3EJkisvvZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NLKflgMl; arc=none smtp.client-ip=209.85.217.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f41.google.com with SMTP id ada2fe7eead31-498d1e97214so610793137.3;
        Thu, 22 Aug 2024 22:49:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724392152; x=1724996952; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cNGWVyqlCzwUHR7T184bYG1MtefuwlyUx60fBG5ahfI=;
        b=NLKflgMl91dAQ6FEB3TN4zLfybDK4tuHrR41mA8C17ONkohoH4FVj4hjgHdQy1r6TX
         Vjzrt87/YQu46GOEAniK3m6FpiBI43GlJIoLhWvYA/0qxfhN3Os9dQYz51n46W1eci7t
         XkeK3KlCwcjnZXKN9xKJh98tyLWq04e6cUQqLa+f4kkmS3gk8L7cAK9Rl8AgqoAB5Wtp
         OnXTtDm/KFOdazdfaw1lCTCO0xi+PFSzZDAMXw000HsXAB1VyojiAEj24zy+hPbrnc1c
         GbFvkGez4I8v6cLH0bG7DrQwWe9iRPYvRfyVcYUgTpUldXPPI9L84mFW+f0A0RzphQcZ
         OY8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724392152; x=1724996952;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cNGWVyqlCzwUHR7T184bYG1MtefuwlyUx60fBG5ahfI=;
        b=FiYfYbt/Wk3epdqu9npu69ZADNB7e3Ksyvfyu9eDhn4N0UtPEzkDfqltw2osMvzC4s
         UhHVnuUbbl2fGswEQhWngXSvW30FyMBvZx2USD2s2X+0IexuvxFpllzj/r7qCa0AyA4r
         D78fNV10Nlzrus4UuVWyhTlz4h5vHcMjlapfvgch58+ZIOSPuAexgq8TLZL5L1Pq+Dh9
         w8e0zWx6GmbSFDc8MrBk1naTGW0hT0V9wyoY4oxMtQI0sNEhvXds5GmdZEiu9HE265KQ
         euNdvQdT5ynYZFXM7Rp3k6Oz4cIiWUedcHobpHPVc/YJvM5yRvWEfvQvKeI+nV8xvCql
         VWjw==
X-Forwarded-Encrypted: i=1; AJvYcCUDgFDSFJOI+zvv7SjRr1KPPXYyg7aU8eNSggTQrgfMeBR0SoQKFdXoUGEwMan2ZAZTPeT0/yc2@vger.kernel.org, AJvYcCVeYXuSLHm3MzS2P4+icUtt8twlJjARpJ84LMXQ2VK3v8+UohuXX8s+R7sFMIr2272M4zs8KdbvdTJQ8ltJL+j9@vger.kernel.org, AJvYcCViKT1jQ941w4LiQEGWX0m0kQf65LlY6FIyc/s/BJM5qRkY9/mNSYhcHs5TGVgpQ8LRHnbNhaIH887VAkk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/V94GldxQtL+c3zBfc0otiTmURDVbIk3CJtG6AQqJaPBRxJro
	Cu7zjt82Xf+bTN1+b5QOJpadtwRors/58lj6p44l/V66Rbuc+2bE
X-Google-Smtp-Source: AGHT+IEmq7BUXInu3Pb+uzssm/FG+paLJwO1/tHIHLafGvotul5152ZbSkjsQHj/Wd0hBsc+k8pN4A==
X-Received: by 2002:a05:6102:441b:b0:498:ef8d:8368 with SMTP id ada2fe7eead31-498f4b38e79mr1676645137.13.1724392152362;
        Thu, 22 Aug 2024 22:49:12 -0700 (PDT)
Received: from localhost (57-135-107-183.static4.bluestreamfiber.net. [57.135.107.183])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-844ce572f4dsm367637241.27.2024.08.22.22.49.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Aug 2024 22:49:12 -0700 (PDT)
From: David Hunter <david.hunter.linux@gmail.com>
To: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>
Cc: David Hunter <david.hunter.linux@gmail.com>,
	netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Javier Carrasco <javier.carrasco.cruz@gmail.com>
Subject: [PATCH 1/1 V2] Selftests: net: Improve missing modules error message
Date: Fri, 23 Aug 2024 01:48:30 -0400
Message-ID: <20240823054833.144612-1-david.hunter.linux@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The error message descirbing the required modules is inaccurate.
Currently, only  "SKIP: Need act_mirred module" is printed when any of
the modules are missing. As a result, users might only include that
module; however, three modules are required.

Fix the error message to show any/all modules needed for the script file
to properly execute.

Signed-off-by: David Hunter <david.hunter.linux@gmail.com>
---
V1 --> V2 
	- included subject prefixes 
	- Split the patch into two separate patches (one for each issue)
	- fixed typos in message body
	- removed second, unnecessary for loop
---
 .../selftests/net/test_ingress_egress_chaining.sh     | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/test_ingress_egress_chaining.sh b/tools/testing/selftests/net/test_ingress_egress_chaining.sh
index 08adff6bb3b6..d4b97662849b 100644
--- a/tools/testing/selftests/net/test_ingress_egress_chaining.sh
+++ b/tools/testing/selftests/net/test_ingress_egress_chaining.sh
@@ -13,10 +13,19 @@ if [ "$(id -u)" -ne 0 ];then
 fi
 
 needed_mods="act_mirred cls_flower sch_ingress"
+mods_missing=""
+numb_mods_needed=0;
+
 for mod in $needed_mods; do
-	modinfo $mod &>/dev/null || { echo "SKIP: Need act_mirred module"; exit $ksft_skip; }
+	modinfo $mod &>/dev/null ||
+	{ mods_missing="$mods_missing$mod " ; numb_mods_needed=$(expr $numb_mods_needed + 1);}
 done
 
+if [[ $numb_mods_needed>0 ]]; then
+	echo "SKIP: $numb_mods_needed modules needed: $mods_missing" ; exit $ksft_skip;
+fi
+
+
 ns="ns$((RANDOM%899+100))"
 veth1="veth1$((RANDOM%899+100))"
 veth2="veth2$((RANDOM%899+100))"
-- 
2.43.0


