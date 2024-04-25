Return-Path: <linux-kselftest+bounces-8879-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CA968B293F
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Apr 2024 21:58:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CEA221C21441
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Apr 2024 19:58:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBF2D152166;
	Thu, 25 Apr 2024 19:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="Nweo078U"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2890915250B
	for <linux-kselftest@vger.kernel.org>; Thu, 25 Apr 2024 19:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714075127; cv=none; b=pmndl7mNmG9/tepzWhpAVEtAWXkpHscy2y9NpA5i1zv3suE0X57xk2djqhzK6linENROBMfQ1NFxJbI0bdTUuUgFsLKVZddSwVJdDWYCCXuXUvRvSCHlgpnJ5cjkUq2JkfztyVCMRgJeu3QKjXg15RNN55fPOVgU7VHGFjKexeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714075127; c=relaxed/simple;
	bh=nA0EButQZ1tC8ouxJfYydhjZwNEli15W2Azor/y6KZY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=KXW9KyV7SLXoNeZYffBlisybAy+Owzc0xUmHQL3YaMPcNULlvpeUKYBnKchMuvJVaMNGRfrLG+dtb3xEmaHEimZiazRWvOjrrtCvyuNdwcuaJlSI9aKjLEh1aNj514NOb3nDwXkG1qXFfoFHyxAYVjPRL5ky3ZYs8rL123d3YsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=Nweo078U; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1e4266673bbso12547425ad.2
        for <linux-kselftest@vger.kernel.org>; Thu, 25 Apr 2024 12:58:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1714075125; x=1714679925; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0NZH4f99IF0WKrj7O85gUWonm//e5lpeuhKVLijLk2E=;
        b=Nweo078UWkJl5uZKvMSdw6n6ypTywgu+XYsEchWDJMFyPBBD12I+49BpCTJJhWYdaP
         jhYnPXwcepEXQdwIL6NGBP8UoVo0D5FNV45BM+JhhwBr1cyuQhW15Q0vI/QkPisNvQMw
         33OfyaOrv6lsUcpT07u8WYda3C8CizTaLHtg00LODCCgA3kKyMsZYGz53GjK8sR8hM6R
         BCADOgAlUWaF9KHB1DDKZ6AVJbRyd8Fed6fsjtLGABfH9SJWtVuqoJj94uNgACvUKldx
         LgGHBFKP48e0IrnnDz6KNZkGoafmGoHzXHcBEsexxWqtYQwZ6EL0mHvP7kngS+zg8rgq
         IleA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714075125; x=1714679925;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0NZH4f99IF0WKrj7O85gUWonm//e5lpeuhKVLijLk2E=;
        b=uFD0fV7YMHy37F9MCnjuM0w3OS2YGfa3SWVobioiJ+20GuBkuY5fyQrFovPRJCSgZL
         2AwywbpG8Qb/j6woeinIPhFTQdEGZ3HQB7KZ+qrgeHt2ZRvTrwDaxaPCZWAM9EUHzORG
         v/ZS4I4JMeXhs80D7fcqtJmTaUtnDNwWmofakr/tuJfvJ1hIZAgsxRs20+XGSjI4xdVp
         yBDDerBb8lcRSvjdFbidLfrtSx8nTNgwLhD8ix/F/4bn9tLI9Ru+wNjLK7ZNSxgfnV2e
         533d0bpM+c06EfJ031HpEqVinU7FoBn6HlwPH+l1DkFlfVJ+Tfn6fMW/9vtksGmZD5lM
         JmuQ==
X-Gm-Message-State: AOJu0YxNMAhO19r2/Qpvq9vdEmDEiSVgK8vl+kS4zsOfANnzjV8zqZAW
	4HiDCvy31t+To6+tWoHz9uk8a5s2i3fgBD7jIxx7Id4onbnjQDsWC/PchRjFAPY=
X-Google-Smtp-Source: AGHT+IECF4sLhnfZeY8g6vk2fi/Z9puc/V7awMpO2ZhBa2zz101/n/Rq4S5Hho5iCaLR2kaBPAoHRQ==
X-Received: by 2002:a17:902:e54d:b0:1e4:6938:6fe3 with SMTP id n13-20020a170902e54d00b001e469386fe3mr719133plf.58.1714075125454;
        Thu, 25 Apr 2024 12:58:45 -0700 (PDT)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id p4-20020a170903248400b001dd88a5dc47sm14152176plw.290.2024.04.25.12.58.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Apr 2024 12:58:44 -0700 (PDT)
From: Charlie Jenkins <charlie@rivosinc.com>
Date: Thu, 25 Apr 2024 12:58:03 -0700
Subject: [PATCH] riscv: selftests: Add hwprobe binaries to .gitignore
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240425-gitignore_hwprobe_artifacts-v1-1-dfc5a20da469@rivosinc.com>
X-B4-Tracking: v=1; b=H4sIAMq1KmYC/x3MQQqAIBAAwK/EnhPM8lBfiQizVfeisUoF0d+Tj
 nOZBzIyYYapeYDxpEwpVnRtAzaY6FHQXg1KqkEOSgtPhXxMjGu4Dk4broYLOWNLFm6TTtm913K
 0UIeD0dH97/Pyvh9r8BpEbQAAAA==
To: Shuah Khan <shuah@kernel.org>, Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Andrew Jones <ajones@ventanamicro.com>
Cc: linux-kselftest@vger.kernel.org, linux-riscv@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Charlie Jenkins <charlie@rivosinc.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1714075124; l=933;
 i=charlie@rivosinc.com; s=20231120; h=from:subject:message-id;
 bh=nA0EButQZ1tC8ouxJfYydhjZwNEli15W2Azor/y6KZY=;
 b=EMBx4wRw1BijgV83w/DHcSmBFo1pgAnUefy+7FE1WoOwc0GghpU0GN3buJtNdf5uyLReFKFc8
 Ek2BHtYsvTBBwL2lzcL85G7/HKa4/x2hUALseg3IMLy0cbQDJ9zs7ic
X-Developer-Key: i=charlie@rivosinc.com; a=ed25519;
 pk=t4RSWpMV1q5lf/NWIeR9z58bcje60/dbtxxmoSfBEcs=

The cbo and which-cpu hwprobe selftests leave their artifacts in the
kernel tree and end up being tracked by git. Add the binaries to the
hwprobe selftest .gitignore so this no longer happens.

Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
Fixes: a29e2a48afe3 ("RISC-V: selftests: Add CBO tests")
Fixes: ef7d6abb2cf5 ("RISC-V: selftests: Add which-cpus hwprobe test")
---
 tools/testing/selftests/riscv/hwprobe/.gitignore | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/testing/selftests/riscv/hwprobe/.gitignore b/tools/testing/selftests/riscv/hwprobe/.gitignore
index 8113dc3bdd03..6e384e80ea1a 100644
--- a/tools/testing/selftests/riscv/hwprobe/.gitignore
+++ b/tools/testing/selftests/riscv/hwprobe/.gitignore
@@ -1 +1,3 @@
 hwprobe
+cbo
+which-cpus

---
base-commit: ed30a4a51bb196781c8058073ea720133a65596f
change-id: 20240425-gitignore_hwprobe_artifacts-fb0f2cd3509c
-- 
- Charlie


