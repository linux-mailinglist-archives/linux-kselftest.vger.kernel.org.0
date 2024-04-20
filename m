Return-Path: <linux-kselftest+bounces-8560-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 104128ABD0E
	for <lists+linux-kselftest@lfdr.de>; Sat, 20 Apr 2024 22:24:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3330D1C2083B
	for <lists+linux-kselftest@lfdr.de>; Sat, 20 Apr 2024 20:24:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5584545BEC;
	Sat, 20 Apr 2024 20:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PjYpFJNQ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADB1A205E3F;
	Sat, 20 Apr 2024 20:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713644636; cv=none; b=OSd0UZBte0Y8gJpBvbDMoaHxrQIsZrPisKPPH0rSiPplzh0drBZiJyZXBrKuigcjICHTU9RgiRzfhg89ULUh9iigmWdsDI23C50CFVfdCDD5T06vNYp2L+ZdygSZ5Gv7DYSYNHmgIebp2KOkU1OnBXcJgwKShKJBdv8nMuVlrZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713644636; c=relaxed/simple;
	bh=dVTL3CYPvUbDlOAps+6/vXLbdL2oQK7QeqHfQacW3yU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ix+Wp2Z7OkKarMRozG4ZFi0xQt2cX290KBFN7pT3dOhOxHQTtabe6xfnU9Af+ncNq8l1E9er0duuYXC6reC/Q8Fa6lkmWLhDgPfRcTE0oIyVBQ8fusvRwFPzlAqPM2IaGprJw3UpOpctklBQIbJ6TiXRSZXNohjmYFepPZ/RERs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PjYpFJNQ; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2da0b3f7ad2so46228891fa.2;
        Sat, 20 Apr 2024 13:23:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713644633; x=1714249433; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pXCh1+s1/3qVr76q1hHeOvuKQc9BBgBYBSjuKquLboM=;
        b=PjYpFJNQJATgrW/vE3zkuA6LGI1LYPqouCoxZ2Kzd3hvr9nQY3WxZ00x+/TJN06nj6
         XMKgzwIikCY18w9Khh4aI3soBpiS4jRTjtvYWcVYpWjId8Z7wVQO4a3owg9Mcz8asgox
         s1J7hrMAX7CSPRcIsCPleA+fmj3yT/sjQPyuyQGzCiHDsmZuEbfYlTHExksC/+My4ica
         LLuYGvq1PPiqRwHNUBUVClHJw0qPF5eZSI2sU/iBTT5X42+7RFqTN7gzLi2/t9nhOxTB
         dSwa4vHnM4XP6AoCtjcpGpX/fL9F8rPUMrA6oXfoz0bjwAvXTY96knZTFJGPa3cXadt3
         0bvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713644633; x=1714249433;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pXCh1+s1/3qVr76q1hHeOvuKQc9BBgBYBSjuKquLboM=;
        b=t2mhR03SR2B8u1YlNOmwrLErcHbcGkcS3mWuK3gndFOwQe0LjEoDkBHhiBoLDugK5b
         14unPxdAgKt9jL02U6pCKLGRWlW0BgvpmDsWG0PdZSXaHAK08Phwv/FZAnREajtxn0Bo
         bONMkBUsF1UR75QLMHdE+A192qMWNmfIcHsFqO4NAOxoZuDgSDTlYe4/KXo/OJ1k8Dax
         j5FDDVyXOqwQHyMX3s9S+zxIla84mZy92JHqwkp0wCblnDLlfZQjUQStOadD1Xxy0yVC
         yMU4AUIMaQymNwYk8WsTJXjgxwv4VTTmlog3pQ03VolkY/W5viZv1DG4D7v52ymGZDbK
         NQEg==
X-Forwarded-Encrypted: i=1; AJvYcCVD4aReIjd7qUywRHA3yJAn1VtKa57o00wNUYJzsF3dIkwpjGzy+mB2JznFQGkjyzzwc9XwDN6UI7fLeHFu6TJkU2G5mN+NMu1I8QnN1ei1Aoq/lm0oA8nFqYdOCfsvu7dwk44Amr//ga1p/896
X-Gm-Message-State: AOJu0Yx7UzVOLMOBf4M490//JtqZMlO9FAU6Q0D8x36jv6Fqfxgfckpy
	Cc1/OjQyE9HRknPv+ZyKuaG9fw9mhoCLOBr7PHatsSglopghd133
X-Google-Smtp-Source: AGHT+IHruDMRhsy+BWmhGYXRPIblTAvszLS7UliuOasQEF9xUlUsGFISIUqo5qYHYgEGXeCwf/n90w==
X-Received: by 2002:a05:6512:143:b0:516:afeb:e27e with SMTP id m3-20020a056512014300b00516afebe27emr3221771lfo.29.1713644632468;
        Sat, 20 Apr 2024 13:23:52 -0700 (PDT)
Received: from localhost ([185.204.1.218])
        by smtp.gmail.com with ESMTPSA id c7-20020a197607000000b00516c51b3e29sm1236930lff.143.2024.04.20.13.23.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Apr 2024 13:23:51 -0700 (PDT)
From: Amer Al Shanawany <amer.shanawany@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Shuah Khan <shuah@kernel.org>,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Subject: [PATCH] selftests: mm: fix linker error for inline function
Date: Sat, 20 Apr 2024 22:23:46 +0200
Message-Id: <20240420202346.546444-1-amer.shanawany@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

add 'static' keyword to 'sys_mprotect()' to link properly, otherwise
the test won't build.

gcc (Ubuntu 12.3.0-1ubuntu1~22.04) 12.3.0

/usr/bin/ld: /tmp/cc7yeABp.o: in function `test_seal_elf':
seal_elf.c:(.text+0x7af): undefined reference to `sys_mprotect'
/usr/bin/ld: seal_elf.c:(.text+0x82c): undefined reference to
`sys_mprotect'
/usr/bin/ld: seal_elf.c:(.text+0xa4e): undefined reference to
`sys_mprotect'

Signed-off-by: Amer Al Shanawany <amer.shanawany@gmail.com>
---
 tools/testing/selftests/mm/seal_elf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/mm/seal_elf.c b/tools/testing/selftests/mm/seal_elf.c
index 7143dc4f1b10..f0cf96625e58 100644
--- a/tools/testing/selftests/mm/seal_elf.c
+++ b/tools/testing/selftests/mm/seal_elf.c
@@ -72,7 +72,7 @@ static void *sys_mmap(void *addr, unsigned long len, unsigned long prot,
 	return sret;
 }
 
-inline int sys_mprotect(void *ptr, size_t size, unsigned long prot)
+static inline int sys_mprotect(void *ptr, size_t size, unsigned long prot)
 {
 	int sret;
 
-- 
2.34.1


