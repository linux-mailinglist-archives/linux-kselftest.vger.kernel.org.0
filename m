Return-Path: <linux-kselftest+bounces-16663-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5208E963C8C
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 Aug 2024 09:17:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0948128278E
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 Aug 2024 07:17:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 658B6189B98;
	Thu, 29 Aug 2024 07:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="TjlS0Dp3"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 486391891B5
	for <linux-kselftest@vger.kernel.org>; Thu, 29 Aug 2024 07:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724915786; cv=none; b=BkzQWyqqVyeqyIMifGwSMJE4sLcgkdH3P9CS9wlaOVlt8A9/woYs5FMWCbwwBV0BzI33GI6zISDSDeK0cKzE57KtVPfpvvt+/dObQnZBv11u9Bd7uU75RsvxCJ/ZuUsdgKdusJK0fdm6UHwvvcz68aUaQQzB+pMsKb5kN6xLeE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724915786; c=relaxed/simple;
	bh=awlA0FQ8vwXq3Nn6i3BedGsUxTSd4n1W8+rk6Ti/shY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=t/S1qh86OevMVzteq77kWHbK7+b+oCpFJzfLcjJv/VYqFx+WKJFkqy45/q4Ls3hZ9tYVyq5Plz3Ff75Zy2Sy+f4VzPwqlR9QayLuIxJpbTOangL5CnWySzUVPVGpQKVT+V70oM7wPvrzNbufOghXTM1K6rIPCocDf+cTbJ2yYM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=TjlS0Dp3; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-715e64ea7d1so224752b3a.0
        for <linux-kselftest@vger.kernel.org>; Thu, 29 Aug 2024 00:16:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1724915783; x=1725520583; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eRZz0v4roamBPZuEY8lRo6reatKDFS+11+O4EIK+5eU=;
        b=TjlS0Dp3sIxhtH7AFdqO92T0ekVteFvdM+sCF5XyVv3XoycyrhONnJ5b6l4bIU+OXU
         +sM9soxzMteqCXnirEEXJSH9rVi3ilb/X8s8bRYA+g3lYee7AhNvl7VtDS6pnFaMhxTv
         0HSYtb06lIjFA3ce2rAstRVnUeVgtcdW+ZLvQoT8WeAljgbzOTABTuwyPcKoCY8Tvrp+
         ZKgYGOxjv5kvmn3JSuEi2pmb5ig94MwY0FU++0EWq+ww/K0g6vcSjogl5p2zAQLbxPYz
         k1m/GWaNu+Y8K7iyqjo91CJA67a0L83bX3b5HOFeosk1frp1SEtBuzxs/5nrEhHdyynv
         SYrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724915783; x=1725520583;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eRZz0v4roamBPZuEY8lRo6reatKDFS+11+O4EIK+5eU=;
        b=bbBo3nZqV3Z3Tkf6okRUp2uu4aHwUp8SJN4nhuBSpm0aekxVQcWYlhacIeO/Zy2pWo
         d9hDhTPAWDz7y3LNdzMgAukkONAgMtR5Z3XuUa12Wni81uEt8vkMkqGpEx6NQGZYr3ik
         Ua2LkAheH0cIwAGXIFcVR8JXI/YMBA5Sub7WaRK7lVVS1HYlvFmkz5blFH6AWTJSdDxi
         BQxudLXFSjv+5AjQszkVDB6AczfEQI8WX3Pj0s2bbw521zgDThsxwDmE6ECcqnWjDsGl
         qDzP41SPWche9amIS/+zRA+Rmu5lvy2y47vnbLilPujPl0RjLeZ0qzzo+JyjIR5ulHGu
         OCYA==
X-Forwarded-Encrypted: i=1; AJvYcCWfM+cpw6i6xKRiHkuH2cg1ITxGkf04jJTPSnWx42DEUbD6GA8F6pdjLhCYt6f7L/lJTNoSiJjHB6OLm2yTd7M=@vger.kernel.org
X-Gm-Message-State: AOJu0YyyPGRAy5ac84Vj6EyfUEMediOmMQnwu7fsDA0ONCDKezabHX0s
	7oouQgzJNLhG5LcZdVXOct1hUntkxllQnctCLFwa+X3IXktlDYoJAgR3WBHh5Og=
X-Google-Smtp-Source: AGHT+IESlo3+HNMz8Vyf9gnK2kr34iORO0t8ZckMgQQJOrmm4rJ0EngcQswLax6rU2xQbGZPh7/0eg==
X-Received: by 2002:a05:6a20:6f88:b0:1c4:7dbc:d21a with SMTP id adf61e73a8af0-1cce104dce4mr1887803637.32.1724915783368;
        Thu, 29 Aug 2024 00:16:23 -0700 (PDT)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7d22e9bef08sm581976a12.58.2024.08.29.00.16.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2024 00:16:22 -0700 (PDT)
From: Charlie Jenkins <charlie@rivosinc.com>
Date: Thu, 29 Aug 2024 00:16:00 -0700
Subject: [PATCH RFC v2 3/4] mm: Support MAP_BELOW_HINT in
 vm_unmapped_area()
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240829-patches-below_hint_mmap-v2-3-638a28d9eae0@rivosinc.com>
References: <20240829-patches-below_hint_mmap-v2-0-638a28d9eae0@rivosinc.com>
In-Reply-To: <20240829-patches-below_hint_mmap-v2-0-638a28d9eae0@rivosinc.com>
To: Arnd Bergmann <arnd@arndb.de>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 Ivan Kokshaysky <ink@jurassic.park.msu.ru>, 
 Matt Turner <mattst88@gmail.com>, Vineet Gupta <vgupta@kernel.org>, 
 Russell King <linux@armlinux.org.uk>, Guo Ren <guoren@kernel.org>, 
 Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>, 
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, 
 Helge Deller <deller@gmx.de>, Michael Ellerman <mpe@ellerman.id.au>, 
 Nicholas Piggin <npiggin@gmail.com>, 
 Christophe Leroy <christophe.leroy@csgroup.eu>, 
 Naveen N Rao <naveen@kernel.org>, 
 Alexander Gordeev <agordeev@linux.ibm.com>, 
 Gerald Schaefer <gerald.schaefer@linux.ibm.com>, 
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
 Christian Borntraeger <borntraeger@linux.ibm.com>, 
 Sven Schnelle <svens@linux.ibm.com>, 
 Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, 
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, 
 "David S. Miller" <davem@davemloft.net>, 
 Andreas Larsson <andreas@gaisler.com>, Thomas Gleixner <tglx@linutronix.de>, 
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
 "H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>, 
 Peter Zijlstra <peterz@infradead.org>, Muchun Song <muchun.song@linux.dev>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
 Vlastimil Babka <vbabka@suse.cz>, 
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Shuah Khan <shuah@kernel.org>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-alpha@vger.kernel.org, linux-snps-arc@lists.infradead.org, 
 linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org, 
 loongarch@lists.linux.dev, linux-mips@vger.kernel.org, 
 linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
 linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, 
 sparclinux@vger.kernel.org, linux-mm@kvack.org, 
 linux-kselftest@vger.kernel.org, Charlie Jenkins <charlie@rivosinc.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=991; i=charlie@rivosinc.com;
 h=from:subject:message-id; bh=awlA0FQ8vwXq3Nn6i3BedGsUxTSd4n1W8+rk6Ti/shY=;
 b=owGbwMvMwCHWx5hUnlvL8Y3xtFoSQ9oFBUtNRaX7W4IPbnI+Ms3hivNnCcHEiLSn/wN2Mfr8Y
 bUwSP3TUcrCIMbBICumyMJzrYG59Y5+2VHRsgkwc1iZQIYwcHEKwES8tjMyvNn0V3yhfGTAnNVL
 rI6JakxSy1zhtaNTK7Nm7eOzb9jnWDIy3NjktX5Wn9/XRXLVu44d2/Xri3n+zz1GZcf0P1w88Pv
 nEX4A
X-Developer-Key: i=charlie@rivosinc.com; a=openpgp;
 fpr=7D834FF11B1D8387E61C776FFB10D1F27D6B1354

To ensure that all memory allocations comply with the new MAP_BELOW_HINT
flag, set the high_limit in vm_unmapped_area() to the hint address +
length at most. All callers to this function set the high_limit to
something reasonable, usually with space for a random offset and a gap
for the stack. To respect the provided high_limit, take the minimum of
hint+length and the given high_limit.

Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
---
 mm/mmap.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/mm/mmap.c b/mm/mmap.c
index 34ba0db23678..459ad380c673 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -1766,6 +1766,9 @@ unsigned long vm_unmapped_area(struct vm_unmapped_area_info *info)
 {
 	unsigned long addr;
 
+	if (info->hint != 0 && info->mmap_flags & MAP_BELOW_HINT)
+		info->high_limit = MIN(info->high_limit, info->hint + info->length);
+
 	if (info->flags & VM_UNMAPPED_AREA_TOPDOWN)
 		addr = unmapped_area_topdown(info);
 	else

-- 
2.45.0


