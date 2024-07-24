Return-Path: <linux-kselftest+bounces-14176-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D9CF893B76F
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Jul 2024 21:17:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E84F1F2146A
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Jul 2024 19:17:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EEDA172777;
	Wed, 24 Jul 2024 19:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="P1B4ksn/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17E5116A95F
	for <linux-kselftest@vger.kernel.org>; Wed, 24 Jul 2024 19:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721848466; cv=none; b=JbrCCi/QLsbxZmWzPd26QGdEbnBzDL0wubgK6jUsyns0vyEc5UJht+LXIcsB9TWrsYOFPK8nQCBjMwh3bKTV/bO4mFKwGPL7aRlz1aqulfk4T2irf50Pbq5BzRCb2T+8wx4uKcSGINZ/CQvxQDhc/2ye+88bOeQ6BIBRnCu5teo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721848466; c=relaxed/simple;
	bh=2W48pS8YjVGGuKgFcdTY4JQ+czvhIHjQutLR0sMQn0M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=R3QYfLoJwNha8HsEZe2Ryf97L3vPSh0tp8Zw0yqWlOyBCW6xtG/7lSZFMPwtUVeIV8csKKJtdmHY5UZBxRkiVbNYNGDuK8N9IsGqA2dVH2Hna9lZsU0mfql7o1Auwq95Q19JaLXjmzZIgDlPMKi83YWHBeFeSxuMQRznygBGlH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=P1B4ksn/; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-71871d5e087so111833a12.1
        for <linux-kselftest@vger.kernel.org>; Wed, 24 Jul 2024 12:14:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1721848464; x=1722453264; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RFlUlKNClOcGHl95zNXTKC1SKxBdILei2erBqjtymyU=;
        b=P1B4ksn/y5+bNo9xFpeTekoZmAXntotE/Nljnm1Arz0ud9Yxrf3CrtY1OT52qOu1iY
         PrRTsjTPGb7+62KayOAfdBrB8/d5DqUDKFuvLVfqhCOUoB492dHaF6RsIqjrzOuAjZQP
         CEqwBr8DGsFLPSWrGStte9+lnnQPZEgYqMRClhmaEaS1XZu0/pAF2HD0sJYUBAN8df4x
         pz8YSgWahUR68s8kft16973Vq8VMdhyhwZt5HFazy8M/koVJMoX3yiHIY15nckXUGA3k
         Z1CGRbO5BxYVipN3ePIcmb7mmMG9Hmq0lV9bDKa/8axpc00HniIghSVqO9csmRTZabln
         gu7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721848464; x=1722453264;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RFlUlKNClOcGHl95zNXTKC1SKxBdILei2erBqjtymyU=;
        b=DbsbMtoUkR4i8g5JNisH6ccFSs6JOO3uCIuO35AtUbQci92jfjXbdqK0ARebWCS6EK
         H4IUqALwShFv9jq1cegPdUksEEm1a7OAh/7wxJWr1QY4vl6wp8DszIpWZuBfEGRRnKLO
         AKbJu9vrulUtqTkXQDdRN1UBwwb9kbEwTq6AXD9XkIPytAiltDL9b5+r/Mc+VthqUjhr
         u1s4OF4rAPEgfek7LHJwTaHvKw8Uki21CoMP3WRZBfDf7gls/483ODc1z/prSlA74wH0
         QqhNmVbQL06GRPSzxUe8iSSa/DmMTLOdF9uopqSmMKogdrBVzm8To01Ow2huixYURxJO
         EwIA==
X-Forwarded-Encrypted: i=1; AJvYcCWoRA+Ek8nGdGMDxT0okL7mgH5wsplMymqRGrpJJlkRaTmn9bSG5zvPnRBdRF3iz4Jj0VQ+PqYZhM6rHWTqIsHht0v+dDsUmZOx0xWeacLk
X-Gm-Message-State: AOJu0Yyj4eZY9fiJvEDEIlhLz+wik/xc6pTt7jvfDiKyzg3UXVlJKmGh
	UWThecLKfja3FCkAumHVInPwX94f+TYa7Nta1/DmpmAGBI59gGpU3WIdBDNJsIo=
X-Google-Smtp-Source: AGHT+IE0L0dz91okDpFVgmoSLSvgUbEJMqSFPJ0XA76IZlboi5kzsRGz9Y0ZVS4Z9LhoGM+6TQZj0w==
X-Received: by 2002:a05:6a21:3983:b0:1c3:fc87:3770 with SMTP id adf61e73a8af0-1c472ce5816mr1070905637.36.1721848464456;
        Wed, 24 Jul 2024 12:14:24 -0700 (PDT)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2cdb73edecesm2022359a91.32.2024.07.24.12.14.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jul 2024 12:14:23 -0700 (PDT)
From: Charlie Jenkins <charlie@rivosinc.com>
Date: Wed, 24 Jul 2024 12:14:02 -0700
Subject: [PATCH v7 11/13] riscv: hwprobe: Document thead vendor extensions
 and xtheadvector extension
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240724-xtheadvector-v7-11-b741910ada3e@rivosinc.com>
References: <20240724-xtheadvector-v7-0-b741910ada3e@rivosinc.com>
In-Reply-To: <20240724-xtheadvector-v7-0-b741910ada3e@rivosinc.com>
To: Conor Dooley <conor@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Jisheng Zhang <jszhang@kernel.org>, Chen-Yu Tsai <wens@csie.org>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Samuel Holland <samuel@sholland.org>, 
 Samuel Holland <samuel.holland@sifive.com>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>, 
 Guo Ren <guoren@kernel.org>, Evan Green <evan@rivosinc.com>, 
 Andy Chiu <andy.chiu@sifive.com>, Jessica Clarke <jrtc27@jrtc27.com>, 
 Andrew Jones <ajones@ventanamicro.com>
Cc: linux-riscv@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-sunxi@lists.linux.dev, 
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 Charlie Jenkins <charlie@rivosinc.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1721848437; l=1260;
 i=charlie@rivosinc.com; s=20231120; h=from:subject:message-id;
 bh=2W48pS8YjVGGuKgFcdTY4JQ+czvhIHjQutLR0sMQn0M=;
 b=of4BBZLZnpVGOBP7eX+ywM0MTSJgSJI9OT7n6xCj4kUhzVsYsjRs6A+6BfAF+cCfhBKnqjW0k
 cIac05GFBfxDNGR4geMLqiNV+3fp8t/Y4yl8dXtE7WppGiqLnJSBVfZ
X-Developer-Key: i=charlie@rivosinc.com; a=ed25519;
 pk=t4RSWpMV1q5lf/NWIeR9z58bcje60/dbtxxmoSfBEcs=

Document support for thead vendor extensions using the key
RISCV_HWPROBE_KEY_VENDOR_EXT_THEAD_0 and xtheadvector extension using
the key RISCV_HWPROBE_VENDOR_EXT_XTHEADVECTOR.

Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
Reviewed-by: Evan Green <evan@rivosinc.com>
---
 Documentation/arch/riscv/hwprobe.rst | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/Documentation/arch/riscv/hwprobe.rst b/Documentation/arch/riscv/hwprobe.rst
index 02eb4d98b7de..b48a06ef80e0 100644
--- a/Documentation/arch/riscv/hwprobe.rst
+++ b/Documentation/arch/riscv/hwprobe.rst
@@ -264,3 +264,13 @@ The following keys are defined:
 
 * :c:macro:`RISCV_HWPROBE_KEY_HIGHEST_VIRT_ADDRESS`: An unsigned long which
   represent the highest userspace virtual address usable.
+
+* :c:macro:`RISCV_HWPROBE_KEY_VENDOR_EXT_THEAD_0`: A bitmask containing the
+  thead vendor extensions that are compatible with the
+  :c:macro:`RISCV_HWPROBE_BASE_BEHAVIOR_IMA`: base system behavior.
+
+  * T-HEAD
+
+    * :c:macro:`RISCV_HWPROBE_VENDOR_EXT_XTHEADVECTOR`: The xtheadvector vendor
+        extension is supported in the T-Head ISA extensions spec starting from
+	commit a18c801634 ("Add T-Head VECTOR vendor extension. ").

-- 
2.44.0


