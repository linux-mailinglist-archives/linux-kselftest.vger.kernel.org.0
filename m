Return-Path: <linux-kselftest+bounces-39142-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 098F3B28A7F
	for <lists+linux-kselftest@lfdr.de>; Sat, 16 Aug 2025 06:10:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 71E137BB9F6
	for <lists+linux-kselftest@lfdr.de>; Sat, 16 Aug 2025 04:08:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D31D41D5CFB;
	Sat, 16 Aug 2025 04:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NrK2LwHo"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D5A07483;
	Sat, 16 Aug 2025 04:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755317421; cv=none; b=rQhVBtqs0n8ovKEWjl6L0mMXSGIY5u2zKKev87tk0yq5bU5U885b8L0gIBoJ0uvMQbLEo8aLfUv6J6a+O7T9FLXgLrls0Tr2grDtNN/0RTKGJAZ2xCe+qYTB+y8PeIOiyHrBVcEYJRNW5Lou+yqASWXCyayEl5YfLpJq/f2x6/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755317421; c=relaxed/simple;
	bh=/c3aNzjOgzXJdrd/tUcCte5n93leNqn/o0rqKcxvA70=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=a4myMYUlWKTKbo5YERe2ISOH7Sun2ljILl062gzo7qErgPQhmliFYjo3HVRozeRHUC3YGHenThzTklqGz/oEoP3WzrqTF7g2gRrwCnh1fmxoTlT177V4lVLdLmqMAnZV4ME5iFAqdBNKlm7JJ0XKTJa3Rq2UIpv9IWAasHJ6q2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NrK2LwHo; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2430c3684d1so27911725ad.0;
        Fri, 15 Aug 2025 21:10:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755317420; x=1755922220; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZgmrZyNxf9Lsu54SjKCiJtIUKWyFnhsglXuJqcWDIus=;
        b=NrK2LwHo28FAbBP1kvt84jC+/TG6MCyYsHmF7G6QhMP1hpGfT4z0HW80w5Nh2Eeivq
         ZF2KKD0nGqBAgI5eR1+uzhA4RuNMfpe+V4hC6B1g3GTaTWxBtl26tFSPhwJYLyVebpe/
         yiqCywXtMWykaRPF6/3wbVe83kBBMj6/gBClqWfLbOGcVsybNVnd0jBxvCbDTw3R9bHN
         MlTZGaG98piLyEpx+pvCwlCrJ1CRQffiC8bfp/8lhTsDRBFv6vdaeA2bAQavWF/m9LkI
         256DqhsbbM4Y78Aye1MyBYq3jZcwI9mNoTtJ4Hu5e8Y4CpPFVDuvYmwGADq81G/joBju
         hLgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755317420; x=1755922220;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZgmrZyNxf9Lsu54SjKCiJtIUKWyFnhsglXuJqcWDIus=;
        b=NTrKdLE8VonsbGA4VntbDeO8l7GPbMFd8yLfTnMw2sHee3aFjw96AkkS6OdjSuDOdA
         3QtnP7f1DJNP6Ea90UuDL/2NwxfVDw69Pz/goFDf3zvlgVkCXOpSO5vOQMJ43MbEDbOu
         vRSGOONkb/6IqAfARI9Jbc/EMVVL21lPMwAEVzoP56MS0mfljAY5wbB6Le8aB0C4v12P
         WNHlkRQ1vDhDRHRdvFeuO4V3CgxJ6NhvCjjevcfNy4/r1MoZwOOi82tUbZ1j73i3YL8C
         lo8zu2PTIL/EVPf16JIDB5iWnSsK413OLrb7vzdRXj1FP3rhZMgaiKukZhlxbOv8RpQ7
         Z7UQ==
X-Forwarded-Encrypted: i=1; AJvYcCVgYHwKzI8uN6GSkwAPte49W5Ck1ab/xcJi2P3k252TUvlU82/AFMQ9pu76upwIh9WL0sPCaz5OeoYiu4g=@vger.kernel.org, AJvYcCXG+2XOZhGM1nx8nIaMIzhrzU1EfAk3zcKeRX53mGFWalOJza0GV/7VfBxfo9QBL0pTnqIqOuqkGKtmdArroo4x@vger.kernel.org
X-Gm-Message-State: AOJu0YwSxMpUu/+AHqec35ZNAqaiVJthPjSyn5Di7X6n7D7ACFQzge9y
	fwPP1CIZOpwDdnciByY58loZ3b6qvc4+kcJRzJPF/SjqQ+vNy//09YX5O/YB2jQt
X-Gm-Gg: ASbGnctaadHusryolUq6+zxT2PnhmrBixlRLZWeXlkYdoaQE4/9n4MwaXVIfLucD1EN
	0tX4ztWvAPyvmUF9GhkosWElYhPpGCPhZAVnkcZMZocT3V49i1LvEECThfuMJMCTEiC6rFgq9Z/
	siHRnNPin4kXOQEpz5M6w9i4W7hniy3wflfgnPdudmSl/ldAooyMqzP0IPSBgdStRXLWMaitKFQ
	AcXtUiXTj0D+eZVjrsCyJosdAemGI70w0zyXv0eXaKjfc0Oq2UC2c5LF0TLYdsm5hqFVkgZj/Q4
	Ks3k9UMq04TJp/rLyyrF8i1Nx0ZyQxdQ0E6fMBfwKaoiG6yySey2470J8bcgt6b5j+/IQ6RUhp8
	QDcQIwIAaKkNUHXY5DiLOazY5sQ==
X-Google-Smtp-Source: AGHT+IGjAe97d4G7wjQcmf5PK9qwQ+YnFzo0vcsTuTa1kbZBxViRv8DPWyTH8/SgX+MWNFi7sQ465Q==
X-Received: by 2002:a17:902:e751:b0:23f:f39b:eae4 with SMTP id d9443c01a7336-2446bd131c7mr73257325ad.9.1755317419719;
        Fri, 15 Aug 2025 21:10:19 -0700 (PDT)
Received: from gmail.com ([157.50.43.60])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2446d54e2a3sm26096095ad.125.2025.08.15.21.10.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Aug 2025 21:10:19 -0700 (PDT)
From: hariconscious@gmail.com
To: shuah@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Cc: HariKrishna <hariconscious@gmail.com>
Subject: [PATCH] kselftest/media_tests : fixed typo errors
Date: Sat, 16 Aug 2025 09:40:12 +0530
Message-ID: <20250816041012.851-1-hariconscious@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: HariKrishna <hariconscious@gmail.com>

fixed typo error

Signed-off-by: HariKrishna <hariconscious@gmail.com>
---
 tools/testing/selftests/media_tests/media_device_test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/media_tests/media_device_test.c b/tools/testing/selftests/media_tests/media_device_test.c
index 4b9953359e40..5710532ac379 100644
--- a/tools/testing/selftests/media_tests/media_device_test.c
+++ b/tools/testing/selftests/media_tests/media_device_test.c
@@ -71,7 +71,7 @@ int main(int argc, char **argv)
 	if (getuid() != 0)
 		ksft_exit_skip("Please run the test as root - Exiting.\n");
 
-	/* Generate random number of interations */
+	/* Generate random number of iterations */
 	srand((unsigned int) time(NULL));
 	count = rand();
 
-- 
2.43.0


