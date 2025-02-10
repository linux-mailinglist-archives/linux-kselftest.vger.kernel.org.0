Return-Path: <linux-kselftest+bounces-26255-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E76CA2FC4B
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Feb 2025 22:38:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5DD363A2D26
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Feb 2025 21:38:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E7FB254AF3;
	Mon, 10 Feb 2025 21:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="c2xebSJ3"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45C2825335E
	for <linux-kselftest@vger.kernel.org>; Mon, 10 Feb 2025 21:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739223379; cv=none; b=SKXhBuRrJ1O4/q82wnnfBnfF6kGl6fMZnUqhm5Tm+bOQL+QaRTK+XRmTDIj6B6Z7suCVqIVYYYfsa33p8LW+X1R98nHwQvvIxFbebij/2dNUJeEUY1G30T1YrwucWCXuHiEBmvFEAvDwGxdcQc9ThlE1947bjOKi98WKKitVlQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739223379; c=relaxed/simple;
	bh=/j+ybqZeARPGCTJZl7exA3+V1IjrXZaSqccG31t9K7Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cUq8l8cCeoDpVTF/I2vebJmyaEMO+aYPOkILF91PKhouZj/U8YhdSObKhdWI34Gf1u71TcJM1yWmklw2As/UxZcEO+jidGTtawtLCBBXwK7/shaNgncDecx//NAIwCTxRVLgHYyydNHoMCUHdItIc34bmS/Iy3ntgOkb4JxWNfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=c2xebSJ3; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-38dd0dc2226so2625152f8f.2
        for <linux-kselftest@vger.kernel.org>; Mon, 10 Feb 2025 13:36:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1739223375; x=1739828175; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=19zTUPAue8uF+l31WbsHm7jesitbh6CalqtCN/NDhL4=;
        b=c2xebSJ3LPiHXsGsSjuRfbMFxZxgU8LpqFgZqy0nvxgKR/gnvOAzSE+gHUULgsWAQQ
         2b1QVMZmDY3xhs7aZuNjCmXS+0eTbsC9RirfpCpY8+xOi/3oljycbnbjSVQNHq5SImVJ
         H5T3vlT9bVxrMNhoSbKwk86zOxLYGyDfH/CgMbU7RB1KJGrZYOpf2XEjLJ24GkfMQYnN
         dkZ9A6XqYFM/EqZWF7i01+Jm0OfgxDWblLaUe2OMVx3sMjcgUEhEbADzsDte5OMzpMbr
         Wa+UHEpkAQFwNVsAbYk0C7+7Mra+qHdS8pJSvlKyKzqLQZKqVPkflGAwASmuWRJQnOYY
         KJGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739223375; x=1739828175;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=19zTUPAue8uF+l31WbsHm7jesitbh6CalqtCN/NDhL4=;
        b=aMiQ/DqKAynZ/DKlHWxT67mua42h2B/sUu5Sybg2fGc3Tm+26SoFEJ1f+Wr7qUYRMf
         XnbPjTd9P60J6tcdu0AJppIJ2VrwD9cMyzDlNiPcaaKjQ3ebMgPpVvGftQprFLOwSjgQ
         CSD3cIl0fEudAe72tuG3wbQx9XVvd6xfPHypUORdcPZ6MBfQbCNaKbR0gqLYlpY6/yHc
         EpZdvdt7RMONPQ4DQQWYYqCplVLCWL7ixgDRSkjrokUYh1+ekbGxUMNvgEZRD4Jx7aUr
         Y0wihBVedz5lX1fXAmJGhR/q/Ko+jcVrru+FibpdhtVRqImQacCpRCra4MUUaoPuAd5k
         chLw==
X-Forwarded-Encrypted: i=1; AJvYcCVfh21vIsGxrSq1S96HGzVnBcxgqcBTVarnhEGbvSQerN+SxKBUEgEV0HJxpqghlxq6TwOqMVzx0VD6lVXGRN0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwwLffsIkiyhCbOSNZT7MA+u5io6iQ1CvZCtngNiiZ+RmQOZvug
	L7RxtWYWTKBDdlXyyY6xHyFVS1XPhJFeef4ER4MjB6FOPSXppzX5mRx73MbGt48=
X-Gm-Gg: ASbGncumk9SqTrhDKI2TOr+ZiYGbKPeQ4S8+Q551/I05B1utvYDK1TwuRyjZTFWW7Yh
	XiTgKLbbk/kvjz5fE41NDQWIQ3nT+hxnAnYyENE6kO/24aEZgKaf74dzlvqOR+dvCdP1WxdYsBe
	B7KkrE0P1CgUjHJmk86HTTSR7RcJm/9kDB5jxfNHJWwtRNHRB5foorG9Xuhj9i4XY78JYTrlQJJ
	j32GdVjBqVQZBWwqsyyqCu2LCRK6lTzEZnFbshFp4835+KyM5ngfcj5/Z89vr8Eoms+z5FJNnJO
	Fxs7z3YKOoIO/DBK
X-Google-Smtp-Source: AGHT+IH8mk3UTikqJq637e5ac58oAB2cwKutxDJwkgs3YdoxbObjCQef1GMenNM8qJokTGgudOE/eQ==
X-Received: by 2002:a5d:648d:0:b0:38d:d969:39b0 with SMTP id ffacd0b85a97d-38dd9693afbmr6558028f8f.2.1739223375424;
        Mon, 10 Feb 2025 13:36:15 -0800 (PST)
Received: from carbon-x1.. ([2a01:e0a:e17:9700:16d2:7456:6634:9626])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4394376118esm47541515e9.40.2025.02.10.13.36.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2025 13:36:14 -0800 (PST)
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
	Samuel Holland <samuel.holland@sifive.com>
Subject: [PATCH v2 09/15] riscv: misaligned: use get_user() instead of __get_user()
Date: Mon, 10 Feb 2025 22:35:42 +0100
Message-ID: <20250210213549.1867704-10-cleger@rivosinc.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250210213549.1867704-1-cleger@rivosinc.com>
References: <20250210213549.1867704-1-cleger@rivosinc.com>
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
index 1d523cf96ff0..e6685db58bd1 100644
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


