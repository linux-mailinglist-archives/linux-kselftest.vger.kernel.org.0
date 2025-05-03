Return-Path: <linux-kselftest+bounces-32277-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 03D52AA8286
	for <lists+linux-kselftest@lfdr.de>; Sat,  3 May 2025 22:02:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B1231B6101D
	for <lists+linux-kselftest@lfdr.de>; Sat,  3 May 2025 20:02:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 232CE27EC6A;
	Sat,  3 May 2025 19:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BlaE5EW6"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B34F28150E;
	Sat,  3 May 2025 19:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746302394; cv=none; b=ENUh1l+fZB9FjhCliT5ERrGCHf/SCqHoNiUipf0hWZy4OKut5Vvsxq1PTLGJWCB2HShH2c1iKy3pmtatZ9cKsdRmHo8qbdS+yethcGE+ev+w9T6dR2jH3hc4085A5KT17yzUbXfV0ud5neWms/UgFhEiDcy+3nMnp1KvOhfev4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746302394; c=relaxed/simple;
	bh=gU74hqXq8gUI3W0CQRs8UPvO2W64+odu6oE3qMydXNk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ieRUFJlpMWnWaAFOGlRKpXsvet8XJO/EwE9LP9iPmoZrOWezt2gYN33Pp87KjCEZjt7id+OKaXZ5VTJY7gGLx5XEDvCmcDV86/mkULeMlR2Nu3t9+CFssnXOnzdbGwt7WGOiH0FZuQm+pWlfjsX5zLW3ER9Nk08zHR3OUnyctEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BlaE5EW6; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-6e8f254b875so35064616d6.1;
        Sat, 03 May 2025 12:59:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746302391; x=1746907191; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=s1mbnIenwaAh9cJypd/Gpwl4cnjxkwwDmZM+HdWEs+o=;
        b=BlaE5EW6vP4bghJ4kPIskJEblK3Y6NUcPyukaGs24D3f7rxNOmfCntYulieXAPWzZC
         DAJVHq8HEZI7/6fYzmR8ol0LKToxweJ57oK7uCwedBrp0rl2/Lm5LSNeJITP76/QaiJa
         sbfqcGLg8uGYXWNbhB4CwqTikDwxF4790DananL+V02hLuLzwsElkmyMmOpzcbwar/U7
         lA+vW+bR+y8JUo7/vUQOeC3khT1LeLADQcgXBUyIb7QkrnnPWZkzl7766OEe9vlzthJk
         MxSc7SlVGAWJfLrGgjOQvfBjSJPEJegsxVsESzYklZQBUFKYFvto8uns8rbHG13bFGAc
         yitw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746302391; x=1746907191;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=s1mbnIenwaAh9cJypd/Gpwl4cnjxkwwDmZM+HdWEs+o=;
        b=ppbPOCq7hUBFAphm/MeEwAzLJN+71BjvPCeFjVpyL4iTRvsaFfzRvaMuquSuvMRzXp
         jNuN6TeWFYE/K5Ws7LKftgmOItuqDsq5o+0l9hiC/Oj13QZXib2MJ252y3DNIBHzpFDo
         lKT/pV5usAAR8JdHQuoXArdWRt4Tdnfg75WiBdna3C7p0ISxdpfokVspxvxvlLvwGPHZ
         qhbKDIBLIp0pLPlqcKGR4odhJGZ6eqPUoJaSpAfav+rnmlPX+/hbSH7pRn0QAtpYPaVw
         x2Ri5oxHMFvRhDeI21G1RgYG2K38e5La1t4XxW5ZhmI4HW/Wj9GPHMWlFEHbgA3V3XBG
         M5eA==
X-Forwarded-Encrypted: i=1; AJvYcCVgQKZcCJy7SeMFjrAGHd7z2d7TAMLXALba3Si42ZqbKXpN7wxc7ELSl7V7pPu3uWVmXSNt5QXQUAw+awQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxS6Ckl4apP5xHmmI5OBX5Ro08Maf168Hbkg+7ltEGbwBusvyog
	e7bED5HQ9DENe/D2XYUq/pePCATMErKHQi9uz6JVZ8DBk5cFcldi
X-Gm-Gg: ASbGncuufeUFWSAK2InMLG8F/1VpL7WrPDfy9D1y6s1uEZPca4XyaOEXPWvLumAMuxG
	wZ5Cc1Sc4svE58uTH78y4SHqj50aGF2BQ96pkQJdeiqvYH4o9vlpjpSeE0uopFAGD3zBf1ASBcD
	FndzZhXBpSRdH5c7znxkGR+PzlcQI/WXTz/1a4Y8AmVFOfsikKV3OVW1w4a3oFJ4WuF4gla0v0p
	fb8JUDJxhgsCf9LAmgC9QpW9v+XTC2DtigGfdvKfvKnRefEWWDw8ReI9PHi79pGuYO9kiNReNEV
	537/p6zPJvzP2b12RM4PwlXvnZygx4oMq8o2csTBo5rz7ipkCDMxs1NtBCZC9hgxu/xnbkUx
X-Google-Smtp-Source: AGHT+IEcjJdx+HiU3ArdgIRP5VndtHr6Bi6xFwtCX+gArCzOlQZ9wL3L1AhJJLgejhW51g3y+bWe0w==
X-Received: by 2002:a05:6214:404:b0:6f4:c8c9:c4fb with SMTP id 6a1803df08f44-6f5237552e3mr47167386d6.11.1746302391081;
        Sat, 03 May 2025 12:59:51 -0700 (PDT)
Received: from c65201v1.fyre.ibm.com ([129.41.87.7])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6f50f3b03ddsm35310866d6.7.2025.05.03.12.59.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 May 2025 12:59:50 -0700 (PDT)
From: Chelsy Ratnawat <chelsyratnawat2001@gmail.com>
To: shuah@kernel.org,
	brauner@kernel.org
Cc: linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Chelsy Ratnawat <chelsyratnawat2001@gmail.com>
Subject: [PATCH] selftests/filesystems: Fix typo in file_stressor.c
Date: Sat,  3 May 2025 12:59:11 -0700
Message-ID: <20250503195911.426158-1-chelsyratnawat2001@gmail.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Change spelling from rougly to roughly.

Signed-off-by: Chelsy Ratnawat <chelsyratnawat2001@gmail.com>
---
 tools/testing/selftests/filesystems/file_stressor.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/filesystems/file_stressor.c b/tools/testing/selftests/filesystems/file_stressor.c
index 1136f93a9977..01dd89f8e52f 100644
--- a/tools/testing/selftests/filesystems/file_stressor.c
+++ b/tools/testing/selftests/filesystems/file_stressor.c
@@ -156,7 +156,7 @@ TEST_F_TIMEOUT(file_stressor, slab_typesafe_by_rcu, 900 * 2)
 			ssize_t nr_read;
 
 			/*
-			 * Concurrently read /proc/<pid>/fd/ which rougly does:
+			 * Concurrently read /proc/<pid>/fd/ which roughly does:
 			 *
 			 * f = fget_task_next(p, &fd);
 			 * if (!f)
-- 
2.43.5


