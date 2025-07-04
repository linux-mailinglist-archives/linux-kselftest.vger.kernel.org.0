Return-Path: <linux-kselftest+bounces-36494-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ACEDAF855E
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Jul 2025 03:58:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E633580684
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Jul 2025 01:58:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1D541D7E5C;
	Fri,  4 Jul 2025 01:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="E8s9xIPa"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9242B1D6DB6
	for <linux-kselftest@vger.kernel.org>; Fri,  4 Jul 2025 01:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751594321; cv=none; b=A09SgRzF7CbXCuEAXjZaoCNUg3iu9icF5VipQamnDXwdg8E/h6s1Y8npOBFZWZaF6WRuVC7ZDSex2CcP3vo9s2OmAsmFvMGBwVfryJJK95eoMPpbWGAf2eJUvHmwZ0sjD4MKAH9z+jZ1d6Eg3QglZHKpa3dBrCM1ogcvpR/tvV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751594321; c=relaxed/simple;
	bh=MEYakmUKLHnF3WCekXxwTM657RRlyZwoI6/HTrtAUdQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=MLuleEYdLYpq8nPU8//2wM7mcoSamTvU3XQiFW8KqZKFtSo08Cx3yWd51SKE3LjtTaoAbyQpTzRncKbW38l4/WrWdIG/wQHwLWQuSWGgr6yFd0Q7IxRorc9Y9O9PIl+WQ0WMqSF27q8pq+lTlmCq5r79ylFUqEURJOQSLOdbTJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=E8s9xIPa; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-6fd1b2a57a0so5497156d6.1
        for <linux-kselftest@vger.kernel.org>; Thu, 03 Jul 2025 18:58:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1751594318; x=1752199118; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QnLXVWExKoNZiJLIxtursHY+uAzhVs7mpFreujfZRkc=;
        b=E8s9xIPaszufggYHV2jiN0GUc++dd6QdoQzdYE/f6WMIvjo22mPILkUR8rNYPITyqI
         l7w+beXVgJvBwxRBQpFdQrl5eBKN8t9l7S7QH9/EOVg8wXR3BE1S7pslneppQqP2+Zyt
         BxVCi4LgBqaQWFrAyYMGKIPrDzxQ3W+2g98goZN5XXpGVNR1v97+gZrcCDDZTQM/t+xj
         /PMD2rBD1GanOh9+5U1ZW+MpxkO4JX4Mk/EVp3e9JGsIkQag0PiiRZOLbYY2O/PVVatG
         OTRo/JEsVZvykAnYEFfeeiuMaKkQ13/BmtdlAaLdvOmrb+27fczyj6P+NXl6ZQte9pb+
         v+uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751594318; x=1752199118;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QnLXVWExKoNZiJLIxtursHY+uAzhVs7mpFreujfZRkc=;
        b=a9b8wYj4V2cKKPDxJfDYIf0/OL8Wlm7OSZJdJ4w87mUdBl4CJtmwX1XHoEWwdEr2nF
         cAuZu5YAnNcnCu1VVGt29dvHNQ2m1Z2YGP7NevuS/tTIBzP5DogwA5lFEuRVFAlW6dl7
         lfPKdZqVS6qtF7QdZuKkJlCIcXyxv/bjoKqLobWXEeXTPry1KLIXOGqd4fgm0J6x2JAj
         VnEly4cAx4zRyDDDwHTqA47QdVJsZWpAc+eIxAX63TiuW7WFypALXnfQL0Reoy6Zlh4W
         uJgtq7dfNJnu5EyVGigoIDDpYWmosRRD83Bd7JZ9ukgzsjjV0zG4sa3yVlGgGx7Cjiu8
         JB4w==
X-Forwarded-Encrypted: i=1; AJvYcCUI8KPNZK55UC43Ko5kTXWkR4Na/32nu63d8/Ag9BzbScA/jWvRFLIrC1kde704MwxB5mmZBUGkCJS1YBIVXew=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7cOf7coFwst65CuWavmvnPuEgxkaPRUp+swBijWk7z4P/Nw9b
	DH0kD8jBeE4hJz7Kfv+tJ7FUHYlrPms7tuSRZZ5f3KE74sIoEhtRHtOy5r1ZH6zguue6HU3F1GF
	oaeCw
X-Gm-Gg: ASbGncufzraouT0coH/VnMc/c1hUTB09tEAGTtLbldhEvsqfiopERVqTjxwjHpx6RLx
	vUn/+N0LTqd/ElHzWt8dO2uK15jUDbomNxlWKj9M99RSJDw4v2qjyZ84h5mQpFx8gyxH9A7QDSi
	ir2lxA9zA/ktQjtxluq7UafUT6e/fNM/gxUtqKO2SBV8wiRYGra4GR2bD5FhtGPrmE1OL3FPQmv
	D1YK9T7nc/gRmO+xIeZ1QvAE391IkQ2mWTU6865F3z+4sIO4coSs/iHEjrDpdF9Wd8soq30pQPO
	zUCU0lqT3EmtevsKFYWY7DId0JKxvzqm5i7uVJZASPY18nTCca9yliUwLpQDD39IqMNh/SkEVx4
	1tZlnj/5A1w==
X-Google-Smtp-Source: AGHT+IFjxkaBEImztNDgLRUCPF9Hxz9tbtkMiO4rL8Aov5ucKBXPKeNdTk/a5C14X/9WkJXb6dZhzw==
X-Received: by 2002:a05:6214:4291:b0:6e8:fcde:58d5 with SMTP id 6a1803df08f44-702c6dedfa8mr10308586d6.42.1751594318341;
        Thu, 03 Jul 2025 18:58:38 -0700 (PDT)
Received: from jesse-lt.ba.rivosinc.com ([96.224.57.66])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-702c4d601a7sm5842446d6.107.2025.07.03.18.58.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Jul 2025 18:58:38 -0700 (PDT)
From: Jesse Taube <jesse@rivosinc.com>
To: kvm@vger.kernel.org,
	kvm-riscv@lists.infradead.org,
	linux-kselftest@vger.kernel.org
Cc: =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>,
	Charlie Jenkins <charlie@rivosinc.com>,
	Jesse Taube <jesse@rivosinc.com>,
	Andrew Jones <andrew.jones@linux.dev>
Subject: [kvm-unit-tests PATCH] riscv: Use norvc over arch, -c
Date: Thu,  3 Jul 2025 18:58:37 -0700
Message-ID: <20250704015837.1700249-1-jesse@rivosinc.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The Linux kernel main tree uses "norvc" over
"arch, -c" change to match this.

GCC 15 started to add _zca_zcd to the assembler flags causing a bug
which made "arch, -c" generate a compressed instruction.

Link: https://sourceware.org/bugzilla/show_bug.cgi?id=33128
Cc: Clément Léger <cleger@rivosinc.com>
Signed-off-by: Jesse Taube <jesse@rivosinc.com>
---
 riscv/isa-dbltrp.c | 2 +-
 riscv/sbi-dbtr.c   | 2 +-
 riscv/sbi-fwft.c   | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/riscv/isa-dbltrp.c b/riscv/isa-dbltrp.c
index b7e21589..af12860c 100644
--- a/riscv/isa-dbltrp.c
+++ b/riscv/isa-dbltrp.c
@@ -26,7 +26,7 @@ do {										\
 	unsigned long value = 0;						\
 	asm volatile(								\
 	"	.option push\n"							\
-	"	.option arch,-c\n"						\
+	"	.option norvc\n"						\
 	"	sw %0, 0(%1)\n"							\
 	"	.option pop\n"							\
 	: : "r" (value), "r" (ptr) : "memory");					\
diff --git a/riscv/sbi-dbtr.c b/riscv/sbi-dbtr.c
index c4ccd81d..129f79b8 100644
--- a/riscv/sbi-dbtr.c
+++ b/riscv/sbi-dbtr.c
@@ -134,7 +134,7 @@ static __attribute__((naked)) void exec_call(void)
 {
 	/* skip over nop when triggered instead of ret. */
 	asm volatile (".option push\n"
-		      ".option arch, -c\n"
+		      ".option norvc\n"
 		      "nop\n"
 		      "ret\n"
 		      ".option pop\n");
diff --git a/riscv/sbi-fwft.c b/riscv/sbi-fwft.c
index 8920bcb5..fda7eb52 100644
--- a/riscv/sbi-fwft.c
+++ b/riscv/sbi-fwft.c
@@ -174,7 +174,7 @@ static void fwft_check_misaligned_exc_deleg(void)
 		 * Disable compression so the lw takes exactly 4 bytes and thus
 		 * can be skipped reliably from the exception handler.
 		 */
-		".option arch,-c\n"
+		".option norvc\n"
 		"lw %[val], 1(%[val_addr])\n"
 		".option pop\n"
 		: [val] "+r" (ret.value)
-- 
2.43.0


