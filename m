Return-Path: <linux-kselftest+bounces-3781-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A0C5843284
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 Jan 2024 02:07:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E386B1F26EBA
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 Jan 2024 01:07:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D4134C90;
	Wed, 31 Jan 2024 01:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="Yu4dJrGi"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E407D1865
	for <linux-kselftest@vger.kernel.org>; Wed, 31 Jan 2024 01:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706663230; cv=none; b=cidmBHQ5CTJhE4MScYSVxQGtHDtqB+ogjZhYD2gWlo9rlz1yg8w5EiKwzq0k9xbLcluAwNU5GOv76EBaVnfFo76tkT2yVVU18HcccPRa0Zzj/Tl5vZ0acC5/6PUeCCcKk0h+xQhYBW62KPVql4q2S9NpBwMhlWf7E5GCZtcVTt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706663230; c=relaxed/simple;
	bh=2lxtSNzBMdkYqwC90W41TvLPqjzE8CkjIf8iMq/P7L4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=U2224qoxsb8OVoG5dk9xFQTg783CsxhAjZJqB8MS82MToJAvoHbLyQ87ypaAzU1JrPYnxgik0uvL8myPbse2DUAmwsu1rD62tnQ9dd/BGVEDp9U03PQWe9PmgFsy56MIlj2wPk6bqrAKb9XQics7KaIf1pRzI/eXWp/YIYnqT0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=Yu4dJrGi; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1d780a392fdso33961345ad.3
        for <linux-kselftest@vger.kernel.org>; Tue, 30 Jan 2024 17:07:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1706663228; x=1707268028; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GGh1y1t0UhB5LcXiFRn0m1YgEny22RmTe/CDN12WiLQ=;
        b=Yu4dJrGi0IiDCFrpiqOLpDobeO92AFXkezCwPWsw/oaztxOemXJY57rq0+tk6HeDWn
         SMvK/q+uW8H416VONvYwknTIiUxb0L5Qo9OiGr8lO9mbrg6SjjZI11XDWqgoqLBPZOJk
         Y0j/tlIPvwlzRjCUi7biS6r2pECwzg3YEeYZelC1RW6rG0p87fpYpfd8qKKcccHKl/7P
         CvBiJ2CdsTudiTl3Z4M+QRRtB+EIXCAzmX8shU8OEka5yt3oTfpBC6KZj5ZWUyfshFlu
         ppMexHdpGFXYccRrCFTH5kfjt9sE2sX7hgORhXC8DyRjnI2tc3dfAaf/OH1wx6q6kRxG
         NvQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706663228; x=1707268028;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GGh1y1t0UhB5LcXiFRn0m1YgEny22RmTe/CDN12WiLQ=;
        b=ixVV1mbqEll04vPR2pdwrNayEJUsVYNiqbA/Ble/Rnm6Yf8tvWfrITUMGcWyYrk/8m
         U8K4Rlfu1xkzQJM6zhoD6UEaG+AGJTJ87tSynlhpWE4E3RJlKbkfW+zfEj23ehlExQvQ
         5xzek7tFA9ftWxOrnd81wq6J3CGOns0CAFi8qYLD/r3wLJfJD5SIFZkmt4bsMwPRg+C4
         G8QsSFktmJdSGl+ivp/qqH2bLcLSle7WS3S6/lL9ycphMbgv4XkSCzPNWjhWG/kbgDE3
         kkRLORCTte2nzuTLg5xdErhuQg4jDvjDuXzWsXYQFENpXnZZ8j9FKtYBmvu8GINJ9MBA
         vekw==
X-Gm-Message-State: AOJu0Ywy2sKlhH2aYn1Cz5bVzWMnEhJCH7n4To+rZwEiHyCK8ybVgxtM
	vjNjerIw6zk6rU11NjK8BVR9dkJAKrfkp2N+lGNOGiMBFdOqrpNRP2aKObKuxsg=
X-Google-Smtp-Source: AGHT+IEmbM/VilqQzN+bDSe1zgWZkRRaNPdWi6aSgLeBxKervvgWyww593Ha65RTd+Oj6JpwZn8mJA==
X-Received: by 2002:a17:902:ed94:b0:1d7:310e:1e0d with SMTP id e20-20020a170902ed9400b001d7310e1e0dmr263865plj.32.1706663228198;
        Tue, 30 Jan 2024 17:07:08 -0800 (PST)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id r12-20020a170903410c00b001d8d3c276c4sm4970822pld.35.2024.01.30.17.07.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jan 2024 17:07:07 -0800 (PST)
From: Charlie Jenkins <charlie@rivosinc.com>
Date: Tue, 30 Jan 2024 17:07:02 -0800
Subject: [PATCH v3 3/3] docs: riscv: Define behavior of mmap
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240130-use_mmap_hint_address-v3-3-8a655cfa8bcb@rivosinc.com>
References: <20240130-use_mmap_hint_address-v3-0-8a655cfa8bcb@rivosinc.com>
In-Reply-To: <20240130-use_mmap_hint_address-v3-0-8a655cfa8bcb@rivosinc.com>
To: Alexandre Ghiti <alexghiti@rivosinc.com>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Shuah Khan <shuah@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
 Yangyu Chen <cyy@cyyself.name>
Cc: linux-mm@kvack.org, linux-riscv@lists.infradead.org, 
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-doc@vger.kernel.org, Charlie Jenkins <charlie@rivosinc.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1706663222; l=1848;
 i=charlie@rivosinc.com; s=20231120; h=from:subject:message-id;
 bh=2lxtSNzBMdkYqwC90W41TvLPqjzE8CkjIf8iMq/P7L4=;
 b=VULcNJMPaGSSibunnHmdY8O6pSGdUfVoHdHqVkSZ/6IDh4hPdQyOg/2Va726eHw2pMLSxc0cG
 87Fixe/YDGPCXhl08WlTq3vxGBa82+KW2s0J79eiJ6OVp8GW8Fgr/ii
X-Developer-Key: i=charlie@rivosinc.com; a=ed25519;
 pk=t4RSWpMV1q5lf/NWIeR9z58bcje60/dbtxxmoSfBEcs=

Define mmap on riscv to not provide an address that uses more bits than
the hint address, if provided.

Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
---
 Documentation/arch/riscv/vm-layout.rst | 16 +++++-----------
 1 file changed, 5 insertions(+), 11 deletions(-)

diff --git a/Documentation/arch/riscv/vm-layout.rst b/Documentation/arch/riscv/vm-layout.rst
index 69ff6da1dbf8..e476b4386bd9 100644
--- a/Documentation/arch/riscv/vm-layout.rst
+++ b/Documentation/arch/riscv/vm-layout.rst
@@ -144,14 +144,8 @@ passing 0 into the hint address parameter of mmap. On CPUs with an address space
 smaller than sv48, the CPU maximum supported address space will be the default.
 
 Software can "opt-in" to receiving VAs from another VA space by providing
-a hint address to mmap. A hint address passed to mmap will cause the largest
-address space that fits entirely into the hint to be used, unless there is no
-space left in the address space. If there is no space available in the requested
-address space, an address in the next smallest available address space will be
-returned.
-
-For example, in order to obtain 48-bit VA space, a hint address greater than
-:code:`1 << 47` must be provided. Note that this is 47 due to sv48 userspace
-ending at :code:`1 << 47` and the addresses beyond this are reserved for the
-kernel. Similarly, to obtain 57-bit VA space addresses, a hint address greater
-than or equal to :code:`1 << 56` must be provided.
+a hint address to mmap. When a hint address is passed to mmap, the returned
+address will never use more bits than the hint address. For example, if a hint
+address of `1 << 40` is passed to mmap, a valid returned address will never use
+bits 41 through 63. If no mappable addresses are available in that range, mmap
+will return `MAP_FAILED`.

-- 
2.43.0


