Return-Path: <linux-kselftest+bounces-29245-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A7567A659B1
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Mar 2025 18:08:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D617A7ABC1F
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Mar 2025 17:07:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E8BE1ADC8F;
	Mon, 17 Mar 2025 17:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="G9r4nN38"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F1DF195808
	for <linux-kselftest@vger.kernel.org>; Mon, 17 Mar 2025 17:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742231292; cv=none; b=lsIhs0OKj/iNL3hA2SgrdND3q0Pt5F5AVj/8oSTCu85zJiczz6aI0dCDTwmXhltWan04L6bOLEmNb9oyYBJFubLNJaB/Yuf1mvRhdX3euqxrfqOP6Nkv/GCwV+uajy4wq/t4kIt2sd0LAjK+JSA7Y2l/PUfAC2KKXeKddAQ9X9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742231292; c=relaxed/simple;
	bh=EqhrCUXSdf6zw+zQLcTnzOZbj5bYjW5BfE2OxtlTOLE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=azBy+BjQT5GOSr2gN/HNdKJRowHZyUU0DldYoFju2W6tewmGvh4yyt+depNsWyAybmGmSbrEq6rnwAquHNUBblw9oDheIMdvyw2jBMfqarSBSgth349W+mCpL1RopAEZhjJBullh7u8tNEz1YarSBl7fSWveFiVzqc0jzCG1fuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=G9r4nN38; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4394a823036so22832065e9.0
        for <linux-kselftest@vger.kernel.org>; Mon, 17 Mar 2025 10:08:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1742231289; x=1742836089; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xMypehTPr85TSV6ycxYis0bFMGhRtQvpG8E21HWF2pk=;
        b=G9r4nN38XyH2HTtuBkVy9W+NwDz8Moo4aI4gGr+EwLsKq9NWxXkoYdQ9ubj4p5jFR9
         xe1kaDy58L2wL0ItOboKlW9kEIKc63BTQBcyKin+WJl/61p8w9QXJqJaREw4yv7XGf64
         xHqKGDaai+CyTVAOqD2Yh3URz1TITAzSfRn3eI2zrw4UyIVafIBi9hZOSgyfoT0Kk9JC
         xd9tvfVbZUu+8bM0foI7EsfzUIcddT1VcjI8HYvuxKbNWo0k6GhuK+IXNegiOImnCaBH
         qtL1yFi+1QxvIqRqJmc5h9Lr3749QGvWMym2uKi6Ne5EVrtEv5/oU3mVVYSlHlVUwe36
         9x9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742231289; x=1742836089;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xMypehTPr85TSV6ycxYis0bFMGhRtQvpG8E21HWF2pk=;
        b=HrFMwRO1/AzpyFyyy83JttwFmqg/pdownRnrAqY5M857IB6wUzoBj+HLwRiIAatT3p
         htuQa+Pt486LPP2poLS9fnK0oPBs6fBnxx83XP/zai0E2nvUzE9z85iMNBpV7SpkLisY
         MhFvHzxhhkFonQPTy7X/vEWIjNWYXQEbsnc0qGiwSAMZvpHHxPsqgD5A/VknbgEAU2Xl
         3lTYjxckgaYKn+/Ag0qhFpATqbADU3c6bTaifHZ3F5DQNVeueW1tDbczhfHKE9CMu5yM
         SsO0UC6I4HhJaCfZKZtyBKpcLP8Gu/15VuOaUeP6OeopC44LMPn5wo0rBxKSN9/UAzpp
         4qkA==
X-Forwarded-Encrypted: i=1; AJvYcCWr4133eYelGV4Hx+YoeHJ7fuHifrBIWap1elBy34idSf09aLx/LiSqh4gDVQvxCDa70ZJre4ULHuEibbAJwHw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxauA5pCVfDemHnnO103TNk1sQ2y5Fl90G5ohF1cGuAmJyPKL81
	/2moQyyQ77UHKshbLsIMPm2zdb3vCmIeSsg+yFeI27RvT+uT06ZL0C84UelkVOg=
X-Gm-Gg: ASbGncu/tC88zino/eO68EpE1h2wsxm0ujApSTyxU6ISXjlYEL51oaN3HiUzaO/RF2d
	0HZTnsECbJr3BFIGEdATOTkyMxtlB7GFlcutrJPrATAJ6zpt6jeTKvUrubdbHsLzk+fCuEefgb4
	1lOcSBlWf48hgw9PX2Q96fInsc76Hl+ke6jFp0845vOkqYb+82nhT/7BHd8E87dVc/xn0aAQg0A
	Ta9PlDW3NXv+J71uAQK982IAX0fnOZjYugaC9+ioczr9XGCue+2Ag9pVJv7VqgVzsdSJpZ5T0VM
	WrosvfdnVHXJmzJtK6OkqKYIR62MgMwZdCbApu52wJefsw==
X-Google-Smtp-Source: AGHT+IHUEfWy8vRElctY1RJYRY/dHWRIdTIpUq+PBDo9gX+Yv3PK1rGyecjDgc1lfv0PGC4CYGx5Ng==
X-Received: by 2002:a05:600c:1392:b0:43c:f4b3:b0ad with SMTP id 5b1f17b1804b1-43d389d441dmr5431565e9.19.1742231288764;
        Mon, 17 Mar 2025 10:08:08 -0700 (PDT)
Received: from carbon-x1.. ([2a01:e0a:e17:9700:16d2:7456:6634:9626])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d23cddb2asm96014505e9.39.2025.03.17.10.08.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Mar 2025 10:08:08 -0700 (PDT)
From: =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>
To: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Anup Patel <anup@brainfault.org>,
	Atish Patra <atishp@atishpatra.org>,
	Shuah Khan <shuah@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	kvm@vger.kernel.org,
	kvm-riscv@lists.infradead.org,
	linux-kselftest@vger.kernel.org
Cc: =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>,
	Samuel Holland <samuel.holland@sifive.com>,
	Andrew Jones <ajones@ventanamicro.com>
Subject: [PATCH v4 02/18] riscv: sbi: add new SBI error mappings
Date: Mon, 17 Mar 2025 18:06:08 +0100
Message-ID: <20250317170625.1142870-3-cleger@rivosinc.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250317170625.1142870-1-cleger@rivosinc.com>
References: <20250317170625.1142870-1-cleger@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

A few new errors have been added with SBI V3.0, maps them as close as
possible to errno values.

Signed-off-by: Clément Léger <cleger@rivosinc.com>
---
 arch/riscv/include/asm/sbi.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/riscv/include/asm/sbi.h b/arch/riscv/include/asm/sbi.h
index bb077d0c912f..d11d22717b49 100644
--- a/arch/riscv/include/asm/sbi.h
+++ b/arch/riscv/include/asm/sbi.h
@@ -536,11 +536,20 @@ static inline int sbi_err_map_linux_errno(int err)
 	case SBI_SUCCESS:
 		return 0;
 	case SBI_ERR_DENIED:
+	case SBI_ERR_DENIED_LOCKED:
 		return -EPERM;
 	case SBI_ERR_INVALID_PARAM:
+	case SBI_ERR_INVALID_STATE:
+	case SBI_ERR_BAD_RANGE:
 		return -EINVAL;
 	case SBI_ERR_INVALID_ADDRESS:
 		return -EFAULT;
+	case SBI_ERR_NO_SHMEM:
+		return -ENOMEM;
+	case SBI_ERR_TIMEOUT:
+		return -ETIME;
+	case SBI_ERR_IO:
+		return -EIO;
 	case SBI_ERR_NOT_SUPPORTED:
 	case SBI_ERR_FAILURE:
 	default:
-- 
2.47.2


