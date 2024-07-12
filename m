Return-Path: <linux-kselftest+bounces-13699-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4DB8930255
	for <lists+linux-kselftest@lfdr.de>; Sat, 13 Jul 2024 01:17:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 63918B216FA
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Jul 2024 23:17:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32D26130A49;
	Fri, 12 Jul 2024 23:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=uci.edu header.i=@uci.edu header.b="P6bR8M6o"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C82E54594A
	for <linux-kselftest@vger.kernel.org>; Fri, 12 Jul 2024 23:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720826265; cv=none; b=IcaSvxBxYCgPBn0sbHeq2i7h1/Ful5vC3QWb7n70rZv+24CVdhx1+h3dOPaOSC9jHsWAah/6r4D1WqB1t3JXlUkRpsp+K3y0suVvXy7z6SkGqw7nPXYsgkx81P0wlufVG2mnxjq8CMu0vFsUvHXHBkxi+hVd2vaSO5p9pxQ525E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720826265; c=relaxed/simple;
	bh=QYgVRyzH8PcMNACMLIrauxK296Rh5jioM9J1lSlVUyk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=BvlranByWeHY07JqDSAIIpp0L90SgYF8RdxTX7LGYg6l2sXDA7EIUvCvQKbJYUmKYbyevuP0xuChko9c9UM2vOFgGZ6UwP0AN6wD2NQGxVsuvR3uuRH1ZKfymGEMlpQr0XpMa8pzYZeiE/o5m8fB6tCRGpwF8wUAWLoZntZJmbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uci.edu; spf=pass smtp.mailfrom=uci.edu; dkim=pass (2048-bit key) header.d=uci.edu header.i=@uci.edu header.b=P6bR8M6o; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uci.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uci.edu
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-70b12572bd8so2122891b3a.2
        for <linux-kselftest@vger.kernel.org>; Fri, 12 Jul 2024 16:17:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=uci.edu; s=google; t=1720826262; x=1721431062; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UZ/x0PvWt6cH5OnfaR+19VuRmz9ObiIe9IQ/Uhq9F24=;
        b=P6bR8M6of7AP2f1RHPwHJDWbjumG3sqdwQGNonMdF7BdNDWfC/Wbt2hXC4WaUWhQ49
         0qpK/k3Um6qlOuBFjB16hPu17XShjVpIteW/77o+aDfBKZC6/wGFT+5NkhmoyRomTmNv
         3Z4sOnTdET1yiaKZMyn2E4Q1C4Qz5VHJAfV5eYQinISOzXRp0HK/MbMV9cSUQn7gC5H3
         jxaT+T0uHaeQsfcB9pYiJZ2JSl9cxB8uLUVOhOw0wBlb5edtr72x7uqT0ruxr6RtIqEN
         71jOhjj/3IboJzebEWJl6caD51AullwwXV84bsfL1KFgZ88zCLeFF9avsfEpIOUM4Dmm
         iheQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720826262; x=1721431062;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UZ/x0PvWt6cH5OnfaR+19VuRmz9ObiIe9IQ/Uhq9F24=;
        b=CGpAyqhmY2OFQhJ0I/WP+06mSNc9aQjNlEV+sJLR1qNZtVCxY+CbYXpCgMK2ltqySH
         Pksg7htXcVJrxQu6CCompLCv2PSuaGSbQjWG58pw0jnjDvdd+bDVycgyBwQZjLafOYN3
         NndeGmSU0UJdlCD4/bAQEuCryX5QuDBQfKhjCBJRnep7vFuGH78szVwR8pCtnRfk81l4
         hOQWW25ayneTHpe5b7p702gRLdzIskYQunNxZSmV1XxT2nHoNRbwDXnX3lweAq0NTwaw
         emBpSHDCP/n/4u2fWNVz1A9KZwTNIa/B190Rz16TO2BXbvJh/4gDTlNhngQdg9gg6X9y
         ArMw==
X-Forwarded-Encrypted: i=1; AJvYcCUnNijwXalFjW1f5+G14Gc+EKIJsH9Xf2+yUXuPB9f4jf0iTOvOLdlD7aJcG8wb9voeh8tbRuxr8CGRDNWnO/YilKthSphqp0raFS/vOURD
X-Gm-Message-State: AOJu0Yyz7jDZmRm0ZhLFs74L/WosT5TL7YE9Lldb/g/AvkIkcv/cJpWx
	1esFqkYjZ9OVFOPhAToNmJQ5DYNj8ytizuUXk+Bg+QW9fCqyeTGXgYL/4e342/NRrVYCW3RkaSd
	IeEw=
X-Google-Smtp-Source: AGHT+IHLHwjE5E7P2KMkGKIVL/NKhjh2eaHWxkdiky4ouJUHcC8YM7Sv7rhWy/oTO/b5bjM+LvWERQ==
X-Received: by 2002:a05:6a00:3d08:b0:706:5dab:83c4 with SMTP id d2e1a72fcca58-70b43576a80mr13644912b3a.14.1720826262020;
        Fri, 12 Jul 2024 16:17:42 -0700 (PDT)
Received: from alpha.mshome.net (ip68-4-168-191.oc.oc.cox.net. [68.4.168.191])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-77d5f0ab0d8sm6292960a12.19.2024.07.12.16.17.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jul 2024 16:17:41 -0700 (PDT)
From: Remington Brasga <rbrasga@uci.edu>
To: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Shuah Khan <shuah@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kernel-mentees@lists.linuxfoundation.org,
	Remington Brasga <rbrasga@uci.edu>
Subject: [PATCH] kselftest: missing arg in ptrace.c
Date: Fri, 12 Jul 2024 23:17:30 +0000
Message-Id: <20240712231730.2794-1-rbrasga@uci.edu>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The string passed to ksft_test_result_skip is missing the `type_name`

Signed-off-by: Remington Brasga <rbrasga@uci.edu>
---
clang-tidy reported clang-diagnostic-format-insufficient-args warning
on this line, so I am fixing it.

 tools/testing/selftests/arm64/abi/ptrace.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/arm64/abi/ptrace.c b/tools/testing/selftests/arm64/abi/ptrace.c
index abe4d58d731d..6144f83f8ab4 100644
--- a/tools/testing/selftests/arm64/abi/ptrace.c
+++ b/tools/testing/selftests/arm64/abi/ptrace.c
@@ -156,7 +156,7 @@ static void test_hw_debug(pid_t child, int type, const char *type_name)
 		/* Zero is not currently architecturally valid */
 		ksft_test_result(arch, "%s_arch_set\n", type_name);
 	} else {
-		ksft_test_result_skip("%s_arch_set\n");
+		ksft_test_result_skip("%s_arch_set\n", type_name);
 	}
 }
 
-- 
2.34.1


