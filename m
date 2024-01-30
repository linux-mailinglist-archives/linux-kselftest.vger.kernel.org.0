Return-Path: <linux-kselftest+bounces-3711-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B4F6841794
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Jan 2024 01:37:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 101A61F23CDD
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Jan 2024 00:37:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8508D22083;
	Tue, 30 Jan 2024 00:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="G/NsDgZN"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E09A51A723
	for <linux-kselftest@vger.kernel.org>; Tue, 30 Jan 2024 00:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706575025; cv=none; b=h1yQ5BUZfpKg+ZTbxCSww64x5bYObrppKOBF4fi+9S4Y3c+dX/E8toWHARwtewPwwSAFxDJwGSRfP+4qYSdfVpmy3KrIDlhOZxbesamJZImiDsPcODXhKQVJmvRjs8/7eI6TL6Z/LulU9xkZmflAL3/mRTpqCSqyHMYiaMxCWKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706575025; c=relaxed/simple;
	bh=MBqHVwDGuAF644QBUmaFqas8tYpxSS6yi6tIOOSWm10=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=KHfHdwPB7LgPES7vC/Kx9bfcFo/W6gPNSGDM/4pcTagpfxgsT2YzosGBokfLLiURtURBlXp+JwFVkz41k+4J2PsZHDKnfXKHWdSl5qfUHwDhM+BekOLHY0jwQmj2HFGAB1YNs3uMB96nPKEsIxsQbwQ+4YRe49jQEX3MepVla00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=G/NsDgZN; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1d8a66a2976so31251485ad.2
        for <linux-kselftest@vger.kernel.org>; Mon, 29 Jan 2024 16:37:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1706575023; x=1707179823; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5TFMd8ZeRyjiOalUt16J2vr2THoaCcjjHoXH9jXrtYQ=;
        b=G/NsDgZNq30UuAi/oFkJjQ/haLvqpxbAHgp/v7ZLdS2+GxaIa3USkq5AVrWMjYllA0
         EAmATKC86nsdaZkyFQguS2RqjZ2pNXnZXolc8AcrA421uHxA5EUp9GH4dq4nWe/H27g2
         /rOVjxe/LoDakebx5aw9GXedxvIDYsCH81hPLGo9KkSqmV/U733Z3nP2QiAzDu44KjeI
         HAyGZxxcvMLQ6rTY2/BisqXw465METRfz/OFDOPP4IFF0wlpJz67Sc2r3dxXJzZ5BhnR
         s4yEX2xtt1Q004S5EH7Db+qlPzlnon77JaVOmpvI9FavYOTPVd92iOk2CpgvAidPJqaV
         LVHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706575023; x=1707179823;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5TFMd8ZeRyjiOalUt16J2vr2THoaCcjjHoXH9jXrtYQ=;
        b=dKFs7mcxPdMv28889OQKu4cc/SyIdAra8qhA/VW+3H4VWit4mTEz2rXxaEv9X+7UsR
         IDX5kreO/upd9HmM1l7SILWacwa8S1J7qB22oNAMQLELvalqP2tzMBZftGefhA17kOUN
         DQcIctRga0TflqX//nON2ZfE+AdIwmW5E5e5nlZ5OUDhFvD80n4WhxjxamfV/qAqSgym
         dlIhh4v/LN0SSln1TZDRI3NiUvhiYm99IaqhcqcpDLxon5TponAzbz0UWR50qvD+NKzj
         5LvtDNe2MuyKDepGStuHGNkMa7bmSDoWKn7JxvwZ3riGHcpxc5ygIzkRmsCR+ANdDt3h
         n6Aw==
X-Gm-Message-State: AOJu0YwdAXs9PMnDiWAen3v1UKp3EIvvCCm12Jsy6noszh0P01EVcKtD
	/6QBMidvog8onxGuBFqurkUjEbeP0trCCShCV4/hQTphI18WMiC7yLQTsQNHt2FRdIuMPvpvo7s
	A
X-Google-Smtp-Source: AGHT+IHouZt2X6rfsHSDuKVQG7Dio6bVc//7RWirBkJAX25H0ZFFwPSk8rVRv3/4TN3qfd8Wnl5X5w==
X-Received: by 2002:a17:902:784e:b0:1d7:8cae:a5dc with SMTP id e14-20020a170902784e00b001d78caea5dcmr5649574pln.62.1706575023239;
        Mon, 29 Jan 2024 16:37:03 -0800 (PST)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id jb9-20020a170903258900b001d8ca3f5e3fsm3406375plb.295.2024.01.29.16.37.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jan 2024 16:37:02 -0800 (PST)
From: Charlie Jenkins <charlie@rivosinc.com>
Subject: [PATCH 0/3] riscv: mm: Use hint address in mmap if available
Date: Mon, 29 Jan 2024 16:36:59 -0800
Message-Id: <20240129-use_mmap_hint_address-v1-0-4c74da813ba1@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKtEuGUC/3WNQQ6CMBBFr0JmbQ3TYBVX3sMQAmUqs6AlHWw0h
 LtbiVuX7yX//RWEIpPAtVghUmLh4DPgoQA7dv5BiofMoEtdlYi1egq109TN7ch+abthiCSiXO2
 qHnvjTg4hb+dIjl97995kHlmWEN/7TcKv/RW1/lNMqFAZY3u6nF1VG7pFTkHY26MNEzTbtn0AV
 UJcAr0AAAA=
To: Alexandre Ghiti <alexghiti@rivosinc.com>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Shuah Khan <shuah@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
 Yangyu Chen <cyy@cyyself.name>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org, 
 Charlie Jenkins <charlie@rivosinc.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1706575021; l=1216;
 i=charlie@rivosinc.com; s=20231120; h=from:subject:message-id;
 bh=MBqHVwDGuAF644QBUmaFqas8tYpxSS6yi6tIOOSWm10=;
 b=SN9b/QxznrtxHxm3ihKTSgB4jNcs+2+HV3KevBEHBaKKAz4WEk+1+qsuWzkp9ngsCRMawSo8o
 YPZH/hcRVIDBnn80q9dZ2Jvt9xuRib+yzFFyol5U3cR2ZUpagkqq9Ib
X-Developer-Key: i=charlie@rivosinc.com; a=ed25519;
 pk=t4RSWpMV1q5lf/NWIeR9z58bcje60/dbtxxmoSfBEcs=

On riscv, mmap currently returns an address from the largest address
space that can fit entirely inside of the hint address. This makes it
such that the hint address is almost never returned. This patch raises
the mappable area up to and including the hint address. This allows mmap
to often return the hint address, which allows a performance improvement
over searching for a valid address as well as making the behavior more
similar to other architectures.

Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
---
Charlie Jenkins (3):
      riscv: mm: Use hint address in mmap if available
      selftests: riscv: Generalize mm selftests
      docs: riscv: Define behavior of mmap

 Documentation/arch/riscv/vm-layout.rst           | 16 ++--
 arch/riscv/include/asm/processor.h               | 21 ++----
 tools/testing/selftests/riscv/mm/mmap_bottomup.c | 20 +----
 tools/testing/selftests/riscv/mm/mmap_default.c  | 20 +----
 tools/testing/selftests/riscv/mm/mmap_test.h     | 93 +++++++++++++-----------
 5 files changed, 66 insertions(+), 104 deletions(-)
---
base-commit: 556e2d17cae620d549c5474b1ece053430cd50bc
change-id: 20240119-use_mmap_hint_address-f9f4b1b6f5f1
-- 
- Charlie


