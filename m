Return-Path: <linux-kselftest+bounces-16485-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 43CFF961E6E
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 Aug 2024 07:49:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC76D1F24F7D
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 Aug 2024 05:49:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEC80155741;
	Wed, 28 Aug 2024 05:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="uPSWccwN"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 110F1152DE7
	for <linux-kselftest@vger.kernel.org>; Wed, 28 Aug 2024 05:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724824172; cv=none; b=iINOozvRKqNktCvoH95ph4X+HbueqOSj29vcCoKO0wtFdXfargjspXRmwFejLSc14cE5ENi8B4vn6jblw144MYEt21D9nfvb0868/7uDx8ee4y7DUYw4WEcK7Igf27TcbOS69q2MCsuhG857xINnZI6bWJZDE278wAcnyFuvzjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724824172; c=relaxed/simple;
	bh=tmMz4K99F0U2eFjTmXZPsRyQ5BJlKhVYtlPfqgJsjxI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=liP8RdDmM+/A7htsCt+QNxDGNS5fs8d5gG6l0gtwWAKnSpPVLAo5TYaRGfEwPfp7sbGrgMjSLBeq2LhZiTIW+KMkvkRHQudmouHU6VazILXgWGnh1uN4W2IModley/WdpBrOuSDm6vSLjBeQNdU3PmYg8cwJtq4z9LUszX6ioVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=uPSWccwN; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-201fbd0d7c2so52360445ad.0
        for <linux-kselftest@vger.kernel.org>; Tue, 27 Aug 2024 22:49:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1724824169; x=1725428969; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=s842qMNTVJPdnaHjTgUH53HGzrqC8L35w1DIbWpmxjE=;
        b=uPSWccwN0oX/n0Z/VeS93spms/XoVMTiQapMYeLnBgsrjI2xCPvyf1Xq7GrjhViAQg
         RkwgtFTSPM0T0o9OWWmD0YltQkzqsW5NIXm6PjUNzkW1Jy646jk2Wxylt8VJx+oKK9//
         ObrCiJVKcIDJJl+gyODP8c7S5x82ANYMHUM9zcjVK/j7AhKkYzOdTjt2B6msrJF1eZfX
         nlSVKc9s7SU7JLvJox5c7gUi1Z0d3V+thq4E9Q78+06nZeuq9EzciIpP1m6vRqi99xYA
         U3cy9vafLbn5vFV2zH7IChQdjM1iiK2AWU8BsG/5QTIuPnx1kFmp0dYVBVgu4JBOE/Du
         M7MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724824169; x=1725428969;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s842qMNTVJPdnaHjTgUH53HGzrqC8L35w1DIbWpmxjE=;
        b=bwq/BK8RvLr3yOV15TtTk1pm/DPEszegPmGu5gs4DWdncMHM04i+0AYXJ0mtN5Deix
         QpiIecQMLCwsSHz0+WQqWFbvoDgVgtwsVxt/doua4Nqe3OFIVr1B8qzJpKCvSY6wTAjL
         eo14KvEo8K1pquLiqKTHSbxtCZ2z3ajKEXq67dEBJsAqsJB+mvuYpG0Bqcft9uBtfbWv
         3y+Ael4YYrVvQADqbcQxWFYo0jk0O/cGjE3bChq1iNKUkvhLyiO/nkPHI1RtsaH1EGDj
         dQoSL+3leirx/YE7VdVGCdNxdtkHTOb8zwvOlp197AmRR2BINNQMmX/4ahbQjZvUgfHU
         IKLA==
X-Forwarded-Encrypted: i=1; AJvYcCXFD5owcCGmh2tdZWp+H/V+xsKY6aqeLIVXGvJhLJgoogWBZ5bhMavpz5HdrSeCpteI66EM2bkQDIRTXlO46gk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMZ5NTDLeGS0UcKtkGMzeHy0fqpbjOyp74PJzhxFp0wzHDzA7S
	8KSvCIW5QIIJoQEqrVTV1kcagoalAr0Vc/X8Qbqm0XRGX0LblOS1KBlm1gXanls=
X-Google-Smtp-Source: AGHT+IE7iBIF/ncsUM+UTT7p6QlENkfnsLUglL71vzMDiTXQo3W/0gxhDidIM3IPRiHs8W/EU5lCPQ==
X-Received: by 2002:a17:902:ce83:b0:1fd:92a7:6ccc with SMTP id d9443c01a7336-204f9ba22b4mr11347335ad.30.1724824169192;
        Tue, 27 Aug 2024 22:49:29 -0700 (PDT)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-203855df0c4sm92092495ad.157.2024.08.27.22.49.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2024 22:49:28 -0700 (PDT)
From: Charlie Jenkins <charlie@rivosinc.com>
Date: Tue, 27 Aug 2024 22:49:07 -0700
Subject: [PATCH 01/16] mm: Add MAP_BELOW_HINT
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240827-patches-below_hint_mmap-v1-1-46ff2eb9022d@rivosinc.com>
References: <20240827-patches-below_hint_mmap-v1-0-46ff2eb9022d@rivosinc.com>
In-Reply-To: <20240827-patches-below_hint_mmap-v1-0-46ff2eb9022d@rivosinc.com>
To: Arnd Bergmann <arnd@arndb.de>, Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
 Christophe Leroy <christophe.leroy@csgroup.eu>, 
 Naveen N Rao <naveen@kernel.org>, Muchun Song <muchun.song@linux.dev>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
 Vlastimil Babka <vbabka@suse.cz>, 
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, 
 Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>, 
 Russell King <linux@armlinux.org.uk>, 
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, 
 Helge Deller <deller@gmx.de>, Alexander Gordeev <agordeev@linux.ibm.com>, 
 Gerald Schaefer <gerald.schaefer@linux.ibm.com>, 
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
 Christian Borntraeger <borntraeger@linux.ibm.com>, 
 Sven Schnelle <svens@linux.ibm.com>, 
 Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, 
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, 
 "David S. Miller" <davem@davemloft.net>, 
 Andreas Larsson <andreas@gaisler.com>, Shuah Khan <shuah@kernel.org>, 
 Alexandre Ghiti <alexghiti@rivosinc.com>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Palmer Dabbelt <palmer@rivosinc.com>, linux-riscv@lists.infradead.org, 
 linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org, 
 linux-mm@kvack.org, loongarch@lists.linux.dev, linux-mips@vger.kernel.org, 
 linux-parisc@vger.kernel.org, linux-s390@vger.kernel.org, 
 linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Charlie Jenkins <charlie@rivosinc.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1656; i=charlie@rivosinc.com;
 h=from:subject:message-id; bh=tmMz4K99F0U2eFjTmXZPsRyQ5BJlKhVYtlPfqgJsjxI=;
 b=owGbwMvMwCHWx5hUnlvL8Y3xtFoSQ9q5XbFSzP1yPpXBlYea467kRPvaspyLaj1+ty58k+rfy
 b+vtHB1lLIwiHEwyIopsvBca2BuvaNfdlS0bALMHFYmkCEMXJwCMBGZFoa/UreElT5ecG2dxnH1
 4+SJG05OW30u9uBl4X2J5vXXMs59v8LIcOvZs96dRZxGwS//rJlxOfEru+W5B7X39RYcjRI4YV7
 3gA8A
X-Developer-Key: i=charlie@rivosinc.com; a=openpgp;
 fpr=7D834FF11B1D8387E61C776FFB10D1F27D6B1354

Some applications rely on placing data in free bits addresses allocated
by mmap. Various architectures (eg. x86, arm64, powerpc) restrict the
address returned by mmap to be less than the maximum address space,
unless the hint address is greater than this value.

To make this behavior explicit and more versatile across all
architectures, define a mmap flag that allows users to define an
arbitrary upper limit on addresses returned by mmap.

Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
---
 include/uapi/asm-generic/mman-common.h       | 1 +
 tools/include/uapi/asm-generic/mman-common.h | 1 +
 2 files changed, 2 insertions(+)

diff --git a/include/uapi/asm-generic/mman-common.h b/include/uapi/asm-generic/mman-common.h
index 6ce1f1ceb432..03ac13d9aa37 100644
--- a/include/uapi/asm-generic/mman-common.h
+++ b/include/uapi/asm-generic/mman-common.h
@@ -32,6 +32,7 @@
 
 #define MAP_UNINITIALIZED 0x4000000	/* For anonymous mmap, memory could be
 					 * uninitialized */
+#define MAP_BELOW_HINT	  0x8000000	/* give out address that is below (inclusive) hint address */
 
 /*
  * Flags for mlock
diff --git a/tools/include/uapi/asm-generic/mman-common.h b/tools/include/uapi/asm-generic/mman-common.h
index 6ce1f1ceb432..03ac13d9aa37 100644
--- a/tools/include/uapi/asm-generic/mman-common.h
+++ b/tools/include/uapi/asm-generic/mman-common.h
@@ -32,6 +32,7 @@
 
 #define MAP_UNINITIALIZED 0x4000000	/* For anonymous mmap, memory could be
 					 * uninitialized */
+#define MAP_BELOW_HINT	  0x8000000	/* give out address that is below (inclusive) hint address */
 
 /*
  * Flags for mlock

-- 
2.45.0


