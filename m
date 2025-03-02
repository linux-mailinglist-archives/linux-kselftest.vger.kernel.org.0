Return-Path: <linux-kselftest+bounces-27985-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D65EA4B4C8
	for <lists+linux-kselftest@lfdr.de>; Sun,  2 Mar 2025 21:59:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D81316CAC3
	for <lists+linux-kselftest@lfdr.de>; Sun,  2 Mar 2025 20:59:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBCFC1EDA28;
	Sun,  2 Mar 2025 20:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CfPV4G2P"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BE591EBFE8;
	Sun,  2 Mar 2025 20:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740949177; cv=none; b=pWGpTFU92WmlPfjuFQ5LzpeFPYsnzeRLnsvjkCfvJw1wjXy/63TLN5rmiP7zXR28qqGAc3xzXHiL4bL/Cv8/iEc4DGCkUW8po2VEB+kJMIdbLbli6xoaBRK+/shtbgtZK5kPQ0CX/U/GvO3aFQ7sXwOIY0JfbWi8fGNITqsIsec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740949177; c=relaxed/simple;
	bh=nMJx/gHRTSel/0/CtwFcnOKi858uPn+zaI9V5bzetoA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hss9J34dKD21wT0YamPCaVCPU6ZZrAP79sfeczcwtpMhqIKHuBpBmHF8Xz7Uk/J42/8/dbLrviM7l+q3Rf5bFQ9OWm+m4YMuX7Qiegq8JEgQhPtQykT1JlT5Xjc53mhCdowlmLywXu2QXSpAa0KUQ9H6xskiA+jeUCP+Dsy2vOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CfPV4G2P; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-223480ea43aso93908385ad.1;
        Sun, 02 Mar 2025 12:59:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740949176; x=1741553976; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oLAfH53hs5jp0gxzd2G1OwbKb9lMqq5E163TbqHM+EI=;
        b=CfPV4G2PZDcHeQyI56RxiiedAyGP+LeL08sWPi2IhJe/wV/NHxALn0/e5rhDMr1aCZ
         ZXV19KESycMkGJM63+2EPA14axYL/vWWa0Ytq2igqLzjLPbTbKX/lIeN1amaYejMXgzY
         OEqSwVuGdY4w7fUkE0tutTPh5rae5ipBWJyG8qbP5JLPZ55tXUnH3infB5J6DwJMvFYu
         VEJcNb/gNYSYk8K+lluG1f91lYRbW/NNnlN+Ck1HVM97opuOzQokYGJ5HMFAyyBfacLM
         98iCNCsaGH05xbNpEeY8T70f4Lr0YQcIZ81YE0f8jkgFDgX1Rk4Cnx/U6kKtSuZM5att
         2kFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740949176; x=1741553976;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oLAfH53hs5jp0gxzd2G1OwbKb9lMqq5E163TbqHM+EI=;
        b=UpscU0DPocuX0WinJjY/XoSBYIcX5peBk9BmnrX3aR8W5w0Vm0Cjn8BSaZcJa6PDNS
         a765uAa88JiXnEJootW7dimHixUVmLCLHktINweLVNQbD/MMpTZw/9Jk7ht/gRXQSG/T
         8MrU1z8E8ZMss9F43G83IKC725ks6ogUL1Sx6cVE7NHWpCako5pYTWkKD4pDrTgHAiUk
         WHnapm15PgpQ/S8xHxe3qM5te8qtaT5VB9yBy24D1N1+UQJbjHrKn2WFPiC8a54K68cu
         hGnv8b7Nt3+8mTekSIexQJ6WsX2oMalaAIXocZHuXi1uqkF7JEq6fFBVSZcU/5dCw1jE
         q6JA==
X-Forwarded-Encrypted: i=1; AJvYcCXnMu7GjTK4b1jfcuX/3VG7wwaEk3yh3Ny5MSxPR9nKT1vKYu6Rm0eQLv2PjhFQskfPNhw42XeKYEzD+UM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8oug/Vm4P7ToJpWmCPZ+b1P7Jb1JIRRJi8+cr/oTp0iMvuOVX
	Wan58DK3s/iVRQGhl1NbUpFd7Ff4Dy5PRgPLgrk6Jj4r7WVlQYOT
X-Gm-Gg: ASbGncu0fiBDg73HxljnRSy2Hzlbzw27Q11VUNXPA2KOqWGul63g9UxKoaeM2xWHB40
	ceSmBM4A8sQoaVKtDrN0rz42pzSHKcUmJY8PMQsPWSFi9cge8TuOL4DvSdNdrk51M2AF7qMGZZ0
	fc3SaLOm9yJLSy2wqsB5RM2IZMrwI8FjaPhPbgdtZTASykY9UK681eHLHMDaaoz9icJV1jxfX0W
	TnHj+i4C3XgM/EjBQEuKA0KHSrdY8hqLLZSen7sGEWfvUwfo2IESHqFVQZkVmBs4ujOqjaK/l00
	teMQmwX38pHzUKTqJKKo1O5DPxDLUoSDDEW5lT91OTi1UMU71d1w92okDTIjMXi18ws=
X-Google-Smtp-Source: AGHT+IFLB7V5LzppL2vua7asJk+tAyW2RgHS2kb65+CgOu+6mCkMlrCs/WyGM3GjW3RMGGhS1bebPw==
X-Received: by 2002:a05:6a21:6b18:b0:1ee:e0d4:5914 with SMTP id adf61e73a8af0-1f2f4ccb309mr18375615637.11.1740949175645;
        Sun, 02 Mar 2025 12:59:35 -0800 (PST)
Received: from fedora.am.students.amrita.edu ([175.184.253.10])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-aee7dec3e05sm6827947a12.49.2025.03.02.12.59.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Mar 2025 12:59:35 -0800 (PST)
From: Siddharth Menon <simeddon@gmail.com>
To: shuah@kernel.org,
	brauner@kernel.org
Cc: linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Siddharth Menon <simeddon@gmail.com>
Subject: [PATCH 1/2] selftests/pidfd: Fix missing header
Date: Mon,  3 Mar 2025 02:22:45 +0530
Message-ID: <20250302205859.14782-2-simeddon@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250302205859.14782-1-simeddon@gmail.com>
References: <20250302205859.14782-1-simeddon@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix compilation errors caused by the missing sys/mount.h header
---
 tools/testing/selftests/pidfd/pidfd_fdinfo_test.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/pidfd/pidfd_fdinfo_test.c b/tools/testing/selftests/pidfd/pidfd_fdinfo_test.c
index f062a986e382..f718aac75068 100644
--- a/tools/testing/selftests/pidfd/pidfd_fdinfo_test.c
+++ b/tools/testing/selftests/pidfd/pidfd_fdinfo_test.c
@@ -13,6 +13,7 @@
 #include <syscall.h>
 #include <sys/wait.h>
 #include <sys/mman.h>
+#include <sys/mount.h>
 
 #include "pidfd.h"
 #include "../kselftest.h"
-- 
2.48.1


