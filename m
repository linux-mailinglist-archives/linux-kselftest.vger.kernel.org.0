Return-Path: <linux-kselftest+bounces-29256-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC073A65A34
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Mar 2025 18:16:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A3303A4397
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Mar 2025 17:11:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30BFD2010FD;
	Mon, 17 Mar 2025 17:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="tHO/2EPG"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C59681F63F0
	for <linux-kselftest@vger.kernel.org>; Mon, 17 Mar 2025 17:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742231304; cv=none; b=SKdu3NNRq0/9eQ3Uu3TUqvLi5/TG2ZWuqjzZ3Y+j+mndc9TVP4rpoPapXeEkPFqLzLfWz/adKgeYM6OJNNAs8N1dCzcw5W5oAmmzR3JbGtk0celiHehsfcxghFx5Y7OFeYbwPSRFbIcIhyUeSD97hDzTZhALFo7vuycoV9CShGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742231304; c=relaxed/simple;
	bh=NrkciCzcfMsvIfgMNhHy3LIzh0NIZkRsvpzrJFbFJ/4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=s3dUGjUQ8kuDrDTGBqiuvFClx+q1CFSLp5tuUazXIuxQbklXdCcMELh8/+7o7wY9+1WkML5P0DvrXjIies9c/YGu/f/69YZfDn502ne+0Azofjqt5J9by+/Y3IPXN6Q6tCEvk+CgUHTyPuLZRoMYlinG2CRzoA8pVDhy1K/WeU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=tHO/2EPG; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4394036c0efso16188185e9.2
        for <linux-kselftest@vger.kernel.org>; Mon, 17 Mar 2025 10:08:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1742231300; x=1742836100; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K8U+T9Diad+CXpLV3u2uHxRVp5OvAkVUCVXAkQQVM7Y=;
        b=tHO/2EPGYoeUHl4RrmFGDy77abGJZlR4BpX/cXBzxheJJ3zHn8pJetgqKmvg7L101X
         BHuL94HBPfcS60utSgZOudJQ3G85MLcvB6lGapvIbEz6yaE4mkJPfrIqG/48gMGYdqyo
         l0EUM3aIGVoPO0xAULYa1wW5Oxcw7aZfxDgjd9VlloeG8G5lns4Ske6kYmEuDGn5+4gX
         1YcMGB4IJoKaveNqU36LoQPOY8LCjgLjcyUGxqlViAjySMi1jfwtOVrPfGhH0hnMLIPE
         l9WXxZx+Eg0e1iEOVw/CWzWgBxqAbFLF0WXtdvcJbv2lXWGhkvWiBHqcjNWoD6n8s1Vt
         R09A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742231300; x=1742836100;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K8U+T9Diad+CXpLV3u2uHxRVp5OvAkVUCVXAkQQVM7Y=;
        b=IFnPdOTRsc6GK60GXfVJpXOvXd2UqGAcMrYdgdrFc3hAXgAYDaSZFdVrFWaQIi63VD
         nUTd8tXSleexwZw3sEVp1fXJ+xmpRd0avyBavEaiopQ0G4VZIAQSqyrxtO5kDX6Zb+uj
         WtF2MG4UUiIc5axffq5EblnQldMZY1j9KkaEZvtkJFFbaGaWegp7sdrgy25fxMO0a8u+
         DfSHFz7lF+Bayycr10HozczUV1LoDJUrcdII2hd9NALJ1NxhUjFoF3+HQZhmXnuK1t+Q
         GfKAWOv6W043UvbODw41MskSlaZXHeDBrBn97eP+CwyejBJQQjf8QfOAKd7+uW64NeqG
         9IIw==
X-Forwarded-Encrypted: i=1; AJvYcCUa9DPuB5nzR6gqsHg8GUIBCDA4r0YZ8AqcZVy0asyuNEQBTHQA0q7rLIFvwJrWn+l5CPMlqJLbEiJf/1tIJ4w=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKPKiiPs6Hygs6tD0epdpJuglwIRLoR0FCBcmDHb7dmxMYXmcP
	2beufo23h1nkBcqx2JVAYk7pdQZN/mCabsHtarm3iVDlRzFpav03nxSFv66hoKA=
X-Gm-Gg: ASbGncsQgiFLpABSjlMoseWpY6hu4r1MgPnM0BGATUDqy2qa/tUChSVUbNbb8m4YfDO
	0lkQtMFoXH2tyV7e/pxRmPAS/QxRIo62yqN4JcrkLUmqdkkSHd2L7Sjn7aSv3Zxq2NVpKIIlzwM
	0lPEDB0+7f8FwsbHLPwvTN+TRgoamSTvxfU0KhOBCgS749p2vHSZyrWo6VlEkZr6udH2dLX+pS4
	cWBIRhMvcXafNDdkvV+nCV7FMrMolxQapZSLZCRuBzm9OEjLYsTEdiZOeWJ2+M31Rk3hlx2KEco
	q4mfJVICEqcWuO4pwdPLMyFiayi4hMzZZT1Xl7JsBZhLJQ==
X-Google-Smtp-Source: AGHT+IFmrC4L2BBEGglHCKwEAqKUy9nE7lsKyuSMTJqBTFYq88vyNhKpBkqIwmbEPtXGJrbb0KbkPQ==
X-Received: by 2002:a05:600c:4ed0:b0:43d:ed:acd5 with SMTP id 5b1f17b1804b1-43d2a2eca5bmr70290895e9.10.1742231300051;
        Mon, 17 Mar 2025 10:08:20 -0700 (PDT)
Received: from carbon-x1.. ([2a01:e0a:e17:9700:16d2:7456:6634:9626])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d23cddb2asm96014505e9.39.2025.03.17.10.08.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Mar 2025 10:08:19 -0700 (PDT)
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
Subject: [PATCH v4 12/18] riscv: misaligned: use get_user() instead of __get_user()
Date: Mon, 17 Mar 2025 18:06:18 +0100
Message-ID: <20250317170625.1142870-13-cleger@rivosinc.com>
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

Now that we can safely handle user memory accesses while in the
misaligned access handlers, use get_user() instead of __get_user() to
have user memory access checks.

Signed-off-by: Clément Léger <cleger@rivosinc.com>
---
 arch/riscv/kernel/traps_misaligned.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/riscv/kernel/traps_misaligned.c b/arch/riscv/kernel/traps_misaligned.c
index 0fb663ac200f..90466a171f58 100644
--- a/arch/riscv/kernel/traps_misaligned.c
+++ b/arch/riscv/kernel/traps_misaligned.c
@@ -269,7 +269,7 @@ static unsigned long get_f32_rs(unsigned long insn, u8 fp_reg_offset,
 	int __ret;					\
 							\
 	if (user_mode(regs)) {				\
-		__ret = __get_user(insn, (type __user *) insn_addr); \
+		__ret = get_user(insn, (type __user *) insn_addr); \
 	} else {					\
 		insn = *(type *)insn_addr;		\
 		__ret = 0;				\
-- 
2.47.2


