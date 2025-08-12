Return-Path: <linux-kselftest+bounces-38763-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D5DAAB2206B
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Aug 2025 10:13:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D83CB1AA075A
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Aug 2025 08:13:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89E922E040B;
	Tue, 12 Aug 2025 08:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b="fr4C/d8R"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CECA12E03F3
	for <linux-kselftest@vger.kernel.org>; Tue, 12 Aug 2025 08:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754986370; cv=none; b=vApr6PfbUszviUUoyg/Ogmb7icGralv5dHmilnR1r19f7KLwS0YQ6R2DqZGkTkPUPTukxaOi1Ixpnd7KOkA+/R+Kvuwc0YLeEWkOIuZOfKj6Ja0XP3iWS8CZdbhUjWMrmQZdXJlSSkqXtWVv5eLl84sVQcvh9NP9kBStSBgE7Pk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754986370; c=relaxed/simple;
	bh=CygRsQzHeViey1sMjJDwpFXY4aVKiZK+tOw7A+FX4l8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=CXXfjgcN2/0YUL61D/WiIkIzrfOqlEZnK8ZZ6jCP2Ikw6b9RlaEW828QUxTDWyjQGV2LEXtFki1CtYcHHDASIT8PVrWhUQkOb2tBzmQ2Xfy0V1UQunDXnilIu+G7vXxkASTXfDZkc9SQvV+lyMfW2+08/e7Sjc4WvXhO0isS5ao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b=fr4C/d8R; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-b42254ea4d5so3390186a12.1
        for <linux-kselftest@vger.kernel.org>; Tue, 12 Aug 2025 01:12:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc.com; s=google; t=1754986368; x=1755591168; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yw0gy+knuGeGzY6jivnMfN7pV1rj29Xt61Zw/czzFhY=;
        b=fr4C/d8RLCc0CMHwfJZv6LvJklQavbucFxaJCgqT7qlE4LXKxTl07jDR9jvSGtb7K1
         bZbtX/HMjJArZVYyipvQyoYuSXIXPeHwnmQPeZdx04vBgKeuZG3Nt/uIquaqtQfhZ6Ih
         GU3US8LOGZzMIKdrzjoiz9yzYtC/8Y1Wx+4hMd1GDwa8dwe+Jxpf2ji70xi7RbvQGm9Y
         Huksal7Btyag7SvXiaiXYSgVJOyg0/49GOfShTI1+lBn1eKQVe9FhEDNGxZdGRMJgFcN
         iu63glRCKjqu4Xx8bW3Txa+vckwg5PQwaqAu2YpSpTiY6QHCU/iYeqc37Womf8QHsEc7
         kD/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754986368; x=1755591168;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yw0gy+knuGeGzY6jivnMfN7pV1rj29Xt61Zw/czzFhY=;
        b=dbdCsbAI/wwaUONGBIkOHrwrkehY0JRAPRv6QTyFFwJn1wMRr2kmcIT7ZbQyJ+jNVI
         fiyxATiO01Kz30lNEngljWncBW92wduYHzbZHO7D/AAXXOEur0Ila1FkNq91MX2DHRbu
         GYIk1lithAH8lQQx2GFwhYeT4hzg7+Tzv7tWWWF3GpamfC+q4nrrWPVXqerrkInB6NCc
         w7BRmj31frqTGZAvVOeT/6nTbncwXesCFCQh+nKRGuSIXr9QiqP5n4BOMjoib1BgpfZZ
         4wUGdrvkiPdCz/1H/HqsWL+pznqnNwq2uR7rHnCJanCuGKICu/LU6mdMvdNt2JOf4F98
         mXgw==
X-Forwarded-Encrypted: i=1; AJvYcCVAB9I7/RK6oiLNVn5/nZ8U+VUz1EA5JJvg4V/QOtX0rw0YZ56mCBTidwXpLPaAJAXEOp/uO3JtseYlFwHJhII=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPumblppJzEb42WqLonKt4lEnlI364/O+C/+CtrXZyy0s6vY1N
	ZpF59lTSuNiVAeuoiRgomI47pWW0IFMwwmFRhr0FonUW0fctivlsoOe1EojxiAcLGzE=
X-Gm-Gg: ASbGncsCLMbsUV9oaXTisiMWKgY3elPdJ1R2kc8OlEqnfS1Xy7Q+nNmqle9ZCMVWx0N
	b8krqEu8eAgeBTv6K3huqPnxyLRoMeC+oNKq8LxGcpnRsHk51ASO3qwXJWMQBNTAtPhUyYaVFSu
	qA4nYGi2ZQbSIVch9T/Wqpgki3lJjRW8OC2K/zrfuyphhvvvb4nM50jR0O/3rTCZ+tUf4CFLOj4
	I3tpIzuIEolWW8Oml/PD6pkk/Ba0WxsUeDnVrbjJndxc+ycRTp7xZ8uAr9DgR6wCaD+8L7HIK5X
	Wyay8OWkJPWoalOo33IBHntC9ngYnl3yruiAtu9cIG6vr5qmGxRChg36/molFowOZzbInf+IcYO
	D+av9mxu67KngDoE9nlThBEJ5KKi0G7ep9gxdxG9MMs+oPn2KVecCa58rbPhQIVcYtbfF0A==
X-Google-Smtp-Source: AGHT+IGv0knKdRcpuo+yhVFvI7xkp6TkQ4XGBRBCTHxnRsgbNXwPcNcWPjfrvDLzGLuhSytlCrPZuQ==
X-Received: by 2002:a17:903:247:b0:240:3c0e:e8c3 with SMTP id d9443c01a7336-242c228e6femr208574645ad.51.1754986368009;
        Tue, 12 Aug 2025 01:12:48 -0700 (PDT)
Received: from alexghiti.eu.rivosinc.com (alexghiti.eu.rivosinc.com. [141.95.202.232])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241d1f0e83esm291171955ad.49.2025.08.12.01.12.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Aug 2025 01:12:47 -0700 (PDT)
From: Alexandre Ghiti <alexghiti@rivosinc.com>
Date: Tue, 12 Aug 2025 08:12:11 +0000
Subject: [PATCH] selftests/damon: fix damon selftests by installing
 _common.sh
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250812-alex-fixes_manual-v1-1-c4e99b1f80e4@rivosinc.com>
X-B4-Tracking: v=1; b=H4sIAFr3mmgC/x3L4QpAMBSG4VvR+W3FlsitSDrZN04x2iK13Lvl5
 9PbmygiCCL1RaKAW6IcPqMuC5pX9guU2GzSlW6qrtaKNzzKyYM47ewv3hTDGri2sbYzlL8z4O9
 5G8b3/QDygZf4YwAAAA==
X-Change-ID: 20250812-alex-fixes_manual-aed3ef75dd83
To: SeongJae Park <sj@kernel.org>, Shuah Khan <shuah@kernel.org>, 
 Andrew Morton <akpm@linux-foundation.org>, Enze Li <lienze@kylinos.cn>
Cc: damon@lists.linux.dev, linux-mm@kvack.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Alexandre Ghiti <alexghiti@rivosinc.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1133;
 i=alexghiti@rivosinc.com; h=from:subject:message-id;
 bh=CygRsQzHeViey1sMjJDwpFXY4aVKiZK+tOw7A+FX4l8=;
 b=owGbwMvMwCGWYr9pz6TW912Mp9WSGDJmfS9tPHdv2e/gSPnDbX98/P6y8smEhomFZkvN8NSNf
 JzmepKxo5SFQYyDQVZMkUXBPKGrxf5s/ew/l97DzGFlAhnCwMUpABMx2c7IcKJKMfDZyu7SW6eu
 i6sb2R6bxmCePlXJaktytu0G9uKKlYwM129NC3i4x4knS9vwc62dnPXFhi07dT7cYTz3Q6epca8
 aIwA=
X-Developer-Key: i=alexghiti@rivosinc.com; a=openpgp;
 fpr=DC049C97114ED82152FE79A783E4BA75438E93E3

_common.sh was recently introduced but is not installed and then
triggers an error when trying to run the damon selftests:

selftests: damon: sysfs.sh
./sysfs.sh: line 4: _common.sh: No such file or directory

Install this file to avoid this error.

Fixes: 511914506d19 ("selftests/damon: introduce _common.sh to host shared function")
Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
---
 tools/testing/selftests/damon/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/damon/Makefile b/tools/testing/selftests/damon/Makefile
index 5b230deb19e8ee6cee56eb8f18c35e12f331e8b7..ddc69e8bde2905ff1c461a08f2ad008e6b28ac87 100644
--- a/tools/testing/selftests/damon/Makefile
+++ b/tools/testing/selftests/damon/Makefile
@@ -4,6 +4,7 @@
 TEST_GEN_FILES += access_memory access_memory_even
 
 TEST_FILES = _damon_sysfs.py
+TEST_FILES += _common.sh
 
 # functionality tests
 TEST_PROGS += sysfs.sh

---
base-commit: 2754d549af31f8f029f02d02cd8e574676229b3d
change-id: 20250812-alex-fixes_manual-aed3ef75dd83

Best regards,
-- 
Alexandre Ghiti <alexghiti@rivosinc.com>


