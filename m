Return-Path: <linux-kselftest+bounces-31334-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08A28A972AD
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Apr 2025 18:26:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3AD5F40344D
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Apr 2025 16:25:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F6B02957D9;
	Tue, 22 Apr 2025 16:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="Z91MF5N5"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 900412900BE
	for <linux-kselftest@vger.kernel.org>; Tue, 22 Apr 2025 16:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745339059; cv=none; b=ZmgCdy4p63IBb389M8okbHyax0ar8BxQNpmAbOQRdpX4cE/CfusT91CQOGxzVl7C4LBBRaq7PFRtKi6arLMMgjcLtLwpoeEzbsM0VnARUCXZWiH1yumxmr2AOr5/qHl/gtykyuCXLX109ngj0qI9Fly47YdDF0Ep1jSH0z/R2IQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745339059; c=relaxed/simple;
	bh=1SwPGQZnvxHgzAriM+OX/+KD6D61uAEZmkyHnr7YLVQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ReG/Od6MdlbuoTKDWmDHwwaYxvBNo/RqVVjCtqFcExDkiv559+bxW2gmUEFoDkewInLHPazCIka4lUWmpfcF3MXhujbSHQOiRdIunZr+IXfTY1kzluXl7T8+oOAZj+19lS8latiSL8eWLD2iLbh66W4VZuEDao91SILM9PIrEA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=Z91MF5N5; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-736b0c68092so4576887b3a.0
        for <linux-kselftest@vger.kernel.org>; Tue, 22 Apr 2025 09:24:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1745339055; x=1745943855; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G1WNhT7IxU5Eh/j55bJL3pNAqccf1l3Drk5qswQXMsw=;
        b=Z91MF5N5qnwNn4PTnURdJ3rXSMcQaoFNkSGb4AukfRhgTHVpyh6Lk2W1Dz2tDIbFzp
         OX+Y2gLGGpwLt2hcNOfik/zhb8Yr/SApgujMrwbpNgPJmuP4qunEu1dmi38CKxrFu1sg
         jOeYXdQMEs9SYUHVVcwyViF/Dhrvycr/e8AqaEYWSFhzl/oNXtdv/bjREqtrY7d7oPAb
         qHBuyv4+Hvkj6n0ct/Ecy5NWPOvdqTmEqyfYe6GETUvqmVuvoXWpLXEkQ0v355YSWvD2
         kOwOVyONvnf784zweqWMmk4uxrxhuFqEfhPvnWcJK3/oKuVO+rhtUP6URdZM6k+SyGvE
         utdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745339055; x=1745943855;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G1WNhT7IxU5Eh/j55bJL3pNAqccf1l3Drk5qswQXMsw=;
        b=SgOJv+FaxEZTlV5AgmyoRDuz/RJWCD1iPu9Krzz89Bni8/kK6tebnUR/8+HhKPgkTt
         sqU8/Gdd4R8pm7SBcIagB1xithl8IZwzG3rQHtv68N8FnQDrHx26nCn1GBFulmSu/I9J
         D1b4q07co4/v/2zNVqdZGb57H153dQ19VRjSTuBS+5f0jC0sCwvCXB9EOxW7kJZKuG4N
         SXnuq7/ln5aDtvRiBdK6ksE87ThjF6ZPk2peHaoiEyEPHLM/9qxjul8vUIbqrYPYo97u
         OA7OZ2FG0Pd1gYMZhB9WOMVuHowke3oFWc/2tgiIj1bni8PcYQnKz+vuVWqW9UfbENPc
         XYGA==
X-Forwarded-Encrypted: i=1; AJvYcCWIcBYiiKTtiKiwundR/RVcNUlIfIuGrSR0HilzsNR+40c6kPD92Nq5TW9vYBMo8qBvEQDW/qvzy6pyB/+Yh0E=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWd4VeQtECsYDJHZUVLojvg6mx0IUaToaiUypbrsSPS9YAcfrE
	h+Wj3DE9uUqTDkdQ6tKXMPjasojbdzTIPZscT55x/ihoL3SQV36trcfwJiAT76U=
X-Gm-Gg: ASbGncsVQiMduxSagLMgk/JOHVImos0tVYEB+d6MHo1Push3QgjrgQq4dLOalOCYPIl
	tLNZsPQQ0K1ywYsJY/jYhdhKhoGEV4VM5OqlHvlMo4zNnAsdIutK4yf2nJIpw7C+8mHYTkix2vA
	MaGoWs5UAWKEGoregf1GEkB0D62ewtNKJxxiBeEMAZ8CH+7pQytd/dQjT2Rqn/z0K25VFfk1OBg
	xdbytzdU1tw0GmBcvt3ItSD5AESbBGbrJuPqdtgnDZgJ/eOBAAAL8tu/UCRZMkAfLuY9b1aYWjE
	3IwmEBjoABBdjVSngya3wTA1e30iyiCjbacilHex/7XuhAa7jxV3
X-Google-Smtp-Source: AGHT+IH4yOfP0IqJKdZ6mYEYPFLQ595Vgf0k+QWsP9/Syy4+PU0hfb7Rc2GCNPIAlZUfc78JP644pQ==
X-Received: by 2002:a05:6a00:3911:b0:736:5753:12f7 with SMTP id d2e1a72fcca58-73dc145740amr23785110b3a.3.1745339054816;
        Tue, 22 Apr 2025 09:24:14 -0700 (PDT)
Received: from carbon-x1.. ([2a01:e0a:e17:9700:16d2:7456:6634:9626])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73dbf8e13e1sm8850825b3a.46.2025.04.22.09.24.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Apr 2025 09:24:14 -0700 (PDT)
From: =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>
To: linux-doc@vger.kernel.org (open list:DOCUMENTATION),
	linux-kernel@vger.kernel.org (open list),
	linux-riscv@lists.infradead.org (open list:RISC-V ARCHITECTURE),
	linux-kselftest@vger.kernel.org (open list:KERNEL SELFTEST FRAMEWORK)
Cc: =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Shuah Khan <shuah@kernel.org>,
	Andrew Jones <ajones@ventanamicro.com>,
	Samuel Holland <samuel.holland@sifive.com>,
	Alexandre Ghiti <alexghiti@rivosinc.com>
Subject: [PATCH v2 3/5] riscv: misaligned: use get_user() instead of __get_user()
Date: Tue, 22 Apr 2025 18:23:10 +0200
Message-ID: <20250422162324.956065-4-cleger@rivosinc.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250422162324.956065-1-cleger@rivosinc.com>
References: <20250422162324.956065-1-cleger@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Now that we can safely handle user memory accesses while in the
misaligned access handlers, use get_user() instead of __get_user() to
have user memory access checks.

Signed-off-by: Clément Léger <cleger@rivosinc.com>
Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>
---
 arch/riscv/kernel/traps_misaligned.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/riscv/kernel/traps_misaligned.c b/arch/riscv/kernel/traps_misaligned.c
index 4354c87c0376..97c674d7d34f 100644
--- a/arch/riscv/kernel/traps_misaligned.c
+++ b/arch/riscv/kernel/traps_misaligned.c
@@ -268,7 +268,7 @@ static unsigned long get_f32_rs(unsigned long insn, u8 fp_reg_offset,
 	int __ret;					\
 							\
 	if (user_mode(regs)) {				\
-		__ret = __get_user(insn, (type __user *) insn_addr); \
+		__ret = get_user(insn, (type __user *) insn_addr); \
 	} else {					\
 		insn = *(type *)insn_addr;		\
 		__ret = 0;				\
-- 
2.49.0


