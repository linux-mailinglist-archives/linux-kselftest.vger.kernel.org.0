Return-Path: <linux-kselftest+bounces-39425-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 226D5B2EB2F
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Aug 2025 04:25:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 25AB63BBE58
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Aug 2025 02:25:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66AD9223338;
	Thu, 21 Aug 2025 02:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SrlQpNJH"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B58A623815B
	for <linux-kselftest@vger.kernel.org>; Thu, 21 Aug 2025 02:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755743099; cv=none; b=fRu2sA9znNgEY001eLNwUrvXxVwsBPntiaWF0jyoIJpeKQA9kdVlsRISLeeyJRM1lhhLyk/uaVs/IjdcgSVrmiJ7iROGy5gqtBsuvZALHTYJvgh2iG3VgdiMofhL0urvkZbn0tupy5nFTzr8+fmpYcBvQ1DrYO1oT+LOpbkZgiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755743099; c=relaxed/simple;
	bh=5FHeix+h50waBpLZg0UU+T7MJYeUzYcRDvTfh68lqc4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=l5akZUzeDzUQgb/9Q5zW3vIMzl714sEAE3FKzxgGodh/epBecm/qgkOXTU9pKqrEUtK3G/Ml/zQbZ2H7PnfWJfAMRuye+jEqKQZdp2ogmTb2VhlvpvR0gHogLZW1yz+Cx50wIUMetMw+2u5SL5sJOZaysPnU6+Z1dZ48c80RqBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SrlQpNJH; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-45b4d89217aso692475e9.2
        for <linux-kselftest@vger.kernel.org>; Wed, 20 Aug 2025 19:24:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755743096; x=1756347896; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=56Miz7sGVHk8hyKaMgRu1ihj9Wjsv8TO9+j390On2qk=;
        b=SrlQpNJHgDrqHHxsmu185GVunKhVQkNoQBNn9/OfDoLK0PFv94DhVZ6SsCaHKhzXrR
         AqHMl252FqV5ejd0Qc5CjmLrE7dvWSzORJmMoF475XGr1A6zqkUeUJOhuImrTSXRHc0P
         kSaGzJCkwnzNZ2kmgR/fhf8MlENf2vZz1rXjBiWrkiu+c333vsa3LK8EIopwcxfn20o6
         aouHVYxlm7xVMMguFx1zj6f0bNMUYF89oTdkr06f6yYnYS7NtSemMOLHKoSBg/aayRMM
         Ny0X7+j9uQNECMGieE46Oi5e7SnOQhzZuApUnbHPI2f77lyjlZbUS8Wjdaqwp6fm0ksd
         CNKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755743096; x=1756347896;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=56Miz7sGVHk8hyKaMgRu1ihj9Wjsv8TO9+j390On2qk=;
        b=IjNkJCMOOseOOg93sS0Gub/O0jvRIReHqIcEEoVHIr6q1M0YCOl7IHb30Mfdb8ikUk
         nUBc0e1NHQzJq59ki0QnFKdX9COpi5VAujH90eclgmb+aOeu92JLwq8wyjEnlkZijIE2
         6GOAtposQ57pzEVKhh6jP4LQ+mFzC722FqiheEFGxA10oFPZToHLKp3xC5jUkp+Yus88
         zZHQfvOb8OrmRSH6KOUTlIWPtw6VXtrVqYWEcpSCJe2Krnv6PQ5lIcTzqqG9v8VNAsA5
         kFfBAl4Tm5VQ2xqWOUT7IuoT9NgW3+ywi8Jj1wq1ZIadhUiGfYsdd9IOR7JDFlkhUEDH
         f4uQ==
X-Gm-Message-State: AOJu0Yx03KuhwwewsCrnYU2NbdrjybhXtHAAvR6YQkwzzrGYwy6wSc6p
	sZt91/Gl/0R24V1OUdVZdiX85OiurAOeU+nm4Oa5bnY6GK0yAOaPRhMt
X-Gm-Gg: ASbGncvuMhMP1BrnMbTtEZTlA4aGMdgDObykvanBWKYEoO1OPq5kOveflMESwK7MqX6
	ViS3zra4rAJ38K8l+GrzKMUAB7ImPcvFxLmj14e4RoJjLQc1o/FVYNA4JmP+ej/QtCItWC/maN1
	FZE4hi5QveWhFGcUOiFN2xRlCrCWTTVruDs3cPUu2sOTDZ8Iki7gIc1hPhaxxYgP4LhhuiIv/ez
	bmq2QQ7JtD1So04YFwSc/KmTHS4yO4+KhxOs7hvPSg8qDXiQSnPhYi9OFrnySGkN/F4+HGZCH5x
	DMZhLBLXXVMCCmjAy2JkxdZINj7n2SilnAjnaNhzs932jrqnMTIPdOAjAwTpipF1mB/sKifhSSB
	qaIzknIu8+qMouX1dQKrJ4+kRWDZA
X-Google-Smtp-Source: AGHT+IG66Y8wMZffzc027PK1PBRyJ/E61eghfLp5FhnZIERInjMx53nZPI6iCBRaDIl46UK0RxfA9A==
X-Received: by 2002:a05:600c:5493:b0:456:3b21:ad1e with SMTP id 5b1f17b1804b1-45b4d8313e6mr5114825e9.17.1755743095757;
        Wed, 20 Aug 2025 19:24:55 -0700 (PDT)
Received: from vivobook-s-14 ([2a0c:5a83:c402:7c00:6912:507:75de:71d0])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3c396bf0f0asm4166504f8f.28.2025.08.20.19.24.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Aug 2025 19:24:55 -0700 (PDT)
From: Emilio Perez <emiliopeju@gmail.com>
To: shuah@kernel.org
Cc: linux-kselftest@vger.kernel.org,
	skhan@linuxfoundation.org,
	Emilio Perez <emiliopeju@gmail.com>
Subject: [PATCH] selftests: capabilities: fix typo in test_execve
Date: Thu, 21 Aug 2025 02:24:45 +0000
Message-ID: <20250821022445.70042-1-emiliopeju@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix spelling mistake: eith -> with

Signed-off-by: Emilio Perez <emiliopeju@gmail.com>
---
 tools/testing/selftests/capabilities/test_execve.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/capabilities/test_execve.c b/tools/testing/selftests/capabilities/test_execve.c
index 47bad7ddc5bc..7dad748c9519 100644
--- a/tools/testing/selftests/capabilities/test_execve.c
+++ b/tools/testing/selftests/capabilities/test_execve.c
@@ -282,7 +282,7 @@ static int do_tests(int uid, const char *our_path)
 				"PR_CAP_AMBIENT_RAISE isn't supported\n");
 		else
 			ksft_test_result_fail(
-				"PR_CAP_AMBIENT_RAISE should have failed eith EPERM on a non-inheritable cap\n");
+				"PR_CAP_AMBIENT_RAISE should have failed with EPERM on a non-inheritable cap\n");
 		return 1;
 	}
 	ksft_test_result_pass(
-- 
2.50.1


