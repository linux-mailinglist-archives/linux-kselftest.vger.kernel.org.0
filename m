Return-Path: <linux-kselftest+bounces-3714-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C992884179C
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Jan 2024 01:38:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE1CC1C226BF
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Jan 2024 00:38:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 573EA364BA;
	Tue, 30 Jan 2024 00:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="PLaCqzj5"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 903D236118
	for <linux-kselftest@vger.kernel.org>; Tue, 30 Jan 2024 00:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706575029; cv=none; b=oZxjZudqAMyfEMnGer22ydKjSHzN+cEuqKzysWUVso6DpxfB6iZET97PRliivbBzwtnqewD26LJLEj1cGsQzaDZ/VtX/E3LG0Nm6VLTVNRkC82MozIKaU8gB2yYaQ7750DJK0/B6HUFjQD0O90UZt2gNSks74EctCd3nwP0TnuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706575029; c=relaxed/simple;
	bh=2lxtSNzBMdkYqwC90W41TvLPqjzE8CkjIf8iMq/P7L4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=d53mExzus5gUAIw3tDZJJlweJY8Z3YyZdZkJxAOw32Z2B0kWc+awIGWSk+TJv0aMvOR42zRz4PLUE8GdZY1KXSBrG76pOp2h2cLzIsfHnGBTKS1zMq9Hkkx6YojPM/cVJUYhKbLBr5Uf9f3mvJHhM8qr/vTS85hZbcCXukRk4Do=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=PLaCqzj5; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1d8d747a3bcso11783195ad.0
        for <linux-kselftest@vger.kernel.org>; Mon, 29 Jan 2024 16:37:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1706575027; x=1707179827; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GGh1y1t0UhB5LcXiFRn0m1YgEny22RmTe/CDN12WiLQ=;
        b=PLaCqzj5KKS80QsD9xfutVJAfGZdQuCFzhm9Gc2jtQ/2sWXLNdiEFBuaokF7WVBn6i
         54EIsCqvdaGz+fMdKrX6DJPDoqo2Zkckl9eW9ufk0FhmQPSZqkv8GlWA619Ztot1clUy
         wpDApZvJ5KTC+JYZ3ojBgowCahm4OKQaGYkkVoNdWYIk2+K+apfcEA15xLN3JA1MIRDF
         /Oiu6ftN4PCXxJC239+cbar7CCzHuTLhuEZOAmaHoGeuLSD1AJ97JQ/3/qFbGZbqCLd7
         PSB6A5gNa9bteCw3HZJVv+G8BsYWYSinfYEESfMO014wpz+9EWmDOtUJfxMxLq3Pk+8a
         n3vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706575027; x=1707179827;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GGh1y1t0UhB5LcXiFRn0m1YgEny22RmTe/CDN12WiLQ=;
        b=XgO/L86JFP+sgt4zqSE9AqHqIQaRCmpYOLDkZ31uo12E8sF0su0nvALahLZvJNOvBv
         9w/k3gONg1n+keLPcjfyPgL+klz3zNIk1LCmxb8U0n3ULZigta9SzJzgMwiApAsRsSvI
         ldxwIWvTqwABC89YwHyLdVh28WU5e9cTuDr+1VhvMGOCMNX6izrswRRHzitWgAP93Pm9
         md/rjypkaiUgAV8fuoGf2D1d6dFcD9DXYBREtn08X116brILmNse5r4w+D1ZuYiOGrdp
         yXH/OVmGxOhjbEu+6DXdBeVBTU9WjCjtGc1hU5okulOS7VGKABUMGEHkxRPEwnHdTJOB
         ioYQ==
X-Gm-Message-State: AOJu0YyTAs0P64m38H1LDCPdPa+ZEMktIwXmQ2eEyAHne1VyB+dqGUMT
	oK18wbtoU/1FThBfDr75f9dEvMvL9sD8+lC/WZjppuFpln0778CkvLlb5dhisG8=
X-Google-Smtp-Source: AGHT+IEZTlAiKexgxrGNCFYzK32fVsyUnQnSz1N1sNMTNGu+/cbpp6v2t6ZHXRA/nQr6fDW9mLkUwQ==
X-Received: by 2002:a17:902:aa85:b0:1d7:c27:2d3c with SMTP id d5-20020a170902aa8500b001d70c272d3cmr167643plr.6.1706575026971;
        Mon, 29 Jan 2024 16:37:06 -0800 (PST)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id jb9-20020a170903258900b001d8ca3f5e3fsm3406375plb.295.2024.01.29.16.37.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jan 2024 16:37:06 -0800 (PST)
From: Charlie Jenkins <charlie@rivosinc.com>
Date: Mon, 29 Jan 2024 16:37:02 -0800
Subject: [PATCH 3/3] docs: riscv: Define behavior of mmap
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240129-use_mmap_hint_address-v1-3-4c74da813ba1@rivosinc.com>
References: <20240129-use_mmap_hint_address-v1-0-4c74da813ba1@rivosinc.com>
In-Reply-To: <20240129-use_mmap_hint_address-v1-0-4c74da813ba1@rivosinc.com>
To: Alexandre Ghiti <alexghiti@rivosinc.com>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Shuah Khan <shuah@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
 Yangyu Chen <cyy@cyyself.name>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org, 
 Charlie Jenkins <charlie@rivosinc.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1706575021; l=1848;
 i=charlie@rivosinc.com; s=20231120; h=from:subject:message-id;
 bh=2lxtSNzBMdkYqwC90W41TvLPqjzE8CkjIf8iMq/P7L4=;
 b=QPhNUZqLeF06ra6K2PNPRoG2n2KtsSvNFDvTmTdvBMXOdHUuJmeRUi0njObakAeeuV1OfWo9q
 etNa+1gFzv1ASKXjUaBTpqtMsyWVZXNQhlsEPcntfZJU7CZKds0vnLR
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


