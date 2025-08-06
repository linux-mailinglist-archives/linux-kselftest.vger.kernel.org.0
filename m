Return-Path: <linux-kselftest+bounces-38359-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DB33B1C207
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Aug 2025 10:20:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C458A16CF4B
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Aug 2025 08:20:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78EEC22156C;
	Wed,  6 Aug 2025 08:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MdsPfF2G"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D5AB1E32CF;
	Wed,  6 Aug 2025 08:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754468428; cv=none; b=E6O8AMDFdM/AjOXXG1661EIfTv2MJo6JGj527FG8BMYT8mHSfhPLcbQUuSW8QIYnnuDsQTzBD6eger2NTGXR7S7lCIZvOi1rsc7YnolQg5wspPCROAkFZRNGeJvCxi/U57xNH3ygV/bDL3s8UEaXhSvLx5ohBFJiXU4uR4JQl7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754468428; c=relaxed/simple;
	bh=2Zg3JIzvXIyqJnoZOSLrCALPdYrjS+32WFTDqn2TkLQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EDDtayuVDVvHJwquAKVowWjoCfV9eMMciBZxHJoV7smgysY3aqnkNGBdTt6GfKBFFWrwa1ZXsTMEPLilZR28IHVe4pUIdr38B+efWvFF5jwp5I1XWzwE8ihzYrJPGvXSq1g+kwu0lc4EglqONs0gCJrid3mXY3Kf5NnkHF4UUI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MdsPfF2G; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-b422b31b1c0so3958713a12.0;
        Wed, 06 Aug 2025 01:20:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754468426; x=1755073226; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tk74vFBOtgpOUaVzdQICrykdzva6RLuKYXQfB725rV0=;
        b=MdsPfF2Gw8ijIC1wEH/mHJtOPVG15vx7uB3KKUsdOspNeU/JhPKyFwDL5VR1SIN7N6
         Tao7+Udo84UBBDPT7flOScJ+9oB24wckomsN6aBuevQWVuABazk/Oay4PgyE89nP11nt
         GCUmP7abcmupvPrz1Y/kkIhzQlgIa2DcXXqnvuhU0z8IrcdhUs4NF3QhONyQLlD2TcAG
         TKOyrPS0zGmkIawqHcoRU0dbCjfZA5ZITwlC7uyng5xnfyrBdr9J1wU/ol/CzChDZ4OO
         ksBcgEnwo0uJ8JPHYF1ydjh/isvjcVm+cpwanGO6VTvcKu+czpgjuKOu8/2X+xYkghVw
         Jb2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754468426; x=1755073226;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tk74vFBOtgpOUaVzdQICrykdzva6RLuKYXQfB725rV0=;
        b=JjeHTtQoXIW+xOVdTK2XZo/kmuQYW/Y3ssXYUwZvO0yPPuKn8JCCyZNx+LnL3dJOEa
         8WRtoM6qxtsYZM3rvY4GTe/9oDHjpkpDmsIfGPIUUmUKPQUmoWWTe8eBg+a5mQgY+MSU
         f89CM4DwFRgXQySLhdZQg/iM8LSyutUYhLnvZVh8+khq92YPkKb73E1VBdKVylDlr1kR
         9M7ceBUhb7m5UlsKHK6d4vWrYWxkdF5tZIeaRykGwtkdK9yzPGXYeuvmHf5bDf6OYVeI
         D5MN9/jUUpvjX0hnJ4PxpywPrE1p1FBga6WHJU3IFlIFA9U1YTKOa8472vGVNouFYl3D
         LZhg==
X-Forwarded-Encrypted: i=1; AJvYcCUKJtVy6mdkvV+pfdQ85A+CR7ZD/3URFTWxBdTiIXEXGyEuvUKRC7fYd9hPhqk40bj/PAKteOYn@vger.kernel.org, AJvYcCVBsrPKmXFCN25qU0IlfnevOnCkgs9xKbw1K9PpMGRGtx+gYV5keU6uiGt94ZDJPx6MaFjR8M73rszlsg5jZcUg@vger.kernel.org, AJvYcCW5GAPu/JBLT+NUb6l1aUfhlWsIiuW5eCniMe01Czan8Dl5x4shg8iCJV5npe/cQoFQP+oZDhaLcDTzZoA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxnlTquXe0xM3AOE8ZILCsQGlpfSbNdk7YMe9SMrcNCS3ffnJIM
	obtufF5oGnHnii+iiUB+N3hjUIKkLh6ks2SWFF0IOdaA8+8YqhcuG+jR
X-Gm-Gg: ASbGnctgGuubQpQ6x31VSVFCoIDmX+nv/K9hiYVn7Q60L5aDmj0QIeSTpocrVyfAoPm
	bBg0S3B4mFXd8HzLSJwI4MOp0NXnkTQsEAZKX/wMGTY/9K8XdKW/1KZ+eYNkwwsoEfHkjH1SK29
	PfYpvDQZfuQm3Eju9sAFEdgJ4kzs7/S6bBlxPTWoEIERxkka3HIz5Pj4Ax8TiLPa1ySXk3hHBPO
	lB/XoorQHfe3XNWpdvp4MoEW8Mey0kaIGopCmM//UcqM8hTHCk4ViigqRXX0A20J1kLK5VmAEKm
	oLRmqcDwEQR9Yhzu9EiRGkC2xTGZg+AV3jqRT6F4IOUBGGX9WvdsK1yMpsr4yETFo3a8Rs9RWCQ
	AKTu3Xh1nmUHyM19lZQEwCYtnLyn9u28eLX4dOxjYR9Lm9PaSoAjHNg==
X-Google-Smtp-Source: AGHT+IEReFrA9fu6w4gM/cP7i9PjlBPwmU6McdahgPWGATLeJixMmq/Kf/I51qnimVALN6oZwVx02A==
X-Received: by 2002:a17:90b:48d2:b0:31a:ab75:6e45 with SMTP id 98e67ed59e1d1-32166cb5d9amr2019526a91.28.1754468426250;
        Wed, 06 Aug 2025 01:20:26 -0700 (PDT)
Received: from manjaro.domain.name ([2401:4900:1c30:7b0d:6527:282d:9edd:5f40])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3216126c96esm2078947a91.22.2025.08.06.01.20.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Aug 2025 01:20:25 -0700 (PDT)
From: Pranav Tyagi <pranav.tyagi03@gmail.com>
To: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	shuah@kernel.org,
	dw@davidwei.uk,
	haiyuewa@163.com,
	axboe@kernel.dk,
	netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: linux-kernel-mentees@lists.linux.dev,
	Pranav Tyagi <pranav.tyagi03@gmail.com>
Subject: [PATCH] selftests/drivers/net: replace typeof() with __auto_type
Date: Wed,  6 Aug 2025 13:50:16 +0530
Message-ID: <20250806082016.14891-1-pranav.tyagi03@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace typeof() with __auto_type in iou-zcrx.c.
__auto_type was introduced in GCC 4.9 and reduces the compile time for
all compilers. No functional changes intended.

Signed-off-by: Pranav Tyagi <pranav.tyagi03@gmail.com>
---
 tools/testing/selftests/drivers/net/hw/iou-zcrx.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/hw/iou-zcrx.c b/tools/testing/selftests/drivers/net/hw/iou-zcrx.c
index 62456df947bc..85551594bf0f 100644
--- a/tools/testing/selftests/drivers/net/hw/iou-zcrx.c
+++ b/tools/testing/selftests/drivers/net/hw/iou-zcrx.c
@@ -42,8 +42,8 @@ static long page_size;
 #define SEND_SIZE (512 * 4096)
 #define min(a, b) \
 	({ \
-		typeof(a) _a = (a); \
-		typeof(b) _b = (b); \
+		__auto_type _a = (a); \
+		__auto_type _b = (b); \
 		_a < _b ? _a : _b; \
 	})
 #define min_t(t, a, b) \
-- 
2.49.0


