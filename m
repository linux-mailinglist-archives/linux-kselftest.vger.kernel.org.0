Return-Path: <linux-kselftest+bounces-5632-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FDB886C8E0
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 Feb 2024 13:10:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E1A501F22FCE
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 Feb 2024 12:10:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4CA27CF1C;
	Thu, 29 Feb 2024 12:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="d5v9QSPE"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out203-205-221-242.mail.qq.com (out203-205-221-242.mail.qq.com [203.205.221.242])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8A207C6F6;
	Thu, 29 Feb 2024 12:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.242
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709208645; cv=none; b=rsPLKRrEtBKA2aKDGEKcSfEpIuUyV6Aec9Jh/gDPua5q6kiygNMLD8OShK7Ut21UiDd23zHYXA6/NNp2gTdRvvHir8KYaxEzBPGUk5UbH4Wkxwt4vkPK6huOMx1HSuUxNbRVeicY7s4FgRlwDz0UzNPxlSmu8BRi2uqp/FzB0aE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709208645; c=relaxed/simple;
	bh=GjZu7M2FGwc+Hi/c/R1k6nT9nTfZTaYpiLyQ0ozy8CM=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=nU9bjm0uL42yrDGzPImceW3JF5kyTMBq4PnWJeAfh8hbSsgE0j5NIpLavCnPBymPk4ko7MTLxZ0HWxGc9D8D+Acunv+Iisrk8MMIa4WP8OcqLNTlZnZ+egn52Pqm7lrAMILaxru1xUyLulcUXAFlkPcm+AmE/BVb7N6dH7MsM50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cyyself.name; spf=none smtp.mailfrom=cyyself.name; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=d5v9QSPE; arc=none smtp.client-ip=203.205.221.242
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cyyself.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=cyyself.name
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1709208634; bh=FXLGu9tMm3TBy8l3UYEso98K6Li1B3GrMam+HnDFMzg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=d5v9QSPEyEZTpth4ZJJYpv5M9SezOZsW1CDhrG2mqXuwbU+WbMO1rNoEObKbDcONs
	 cQG8fvllsRuUkoY6hV80ssZq6M4IW++OpxxTS1NW0QyxXAndGpginqJ/pik6oQ3wuV
	 JLqSJXoQ5wDeGeCgJN1NhOoZkcoHUB8XfPCKPEWQ=
Received: from localhost.localdomain ([2001:da8:c800:d084:427:1102:8aff:8b6e])
	by newxmesmtplogicsvrszb9-1.qq.com (NewEsmtp) with SMTP
	id 283B6817; Thu, 29 Feb 2024 20:10:03 +0800
X-QQ-mid: xmsmtpt1709208603tcjm8z9wa
Message-ID: <tencent_3E8D4B7CAE824BDA238EA2B821310F21EE08@qq.com>
X-QQ-XMAILINFO: OATpkVjS499u19AglRscYPH4jyzJB+Vl8Fnt0SaLDIolkFrK9wPPPy0jK+e7cO
	 Ht3l64KsXh/Qll1xXkeRBT+W4Zmuz4GGc1jxddbiJA6iJD5p7nB2X85F1dXA4jTu2iaM/Rbqif2t
	 upImo5lLq5wHcftQLQepl6hLI3t/CdtvR26+UW8W8COiGWbcTERgB8KrFSkv8lMdMPXkJO4hz0RK
	 WNqvq1J8brOOVQ65AgGgtusp3vSoY+QuyNB9pZFKP+A7tGlqBX6xy0OP6BTXsALE4AMR5Mff16OL
	 cPIhvjyJvR2q1HbHcoSeB6yWtRekGj/6nLvN7vM0mhr8ZbBTPuPSEeJfu8ipqf+3RZ4RB6dT5sug
	 s7YQfmuPKsEXEvIh+aN5Ct5NjRwFTV3GWAQXLfgVmShKi3lbn0QqZNdHe5dsLc+B4Sp/a71Ya6en
	 WkHVt8v3HG+vpoeqVR1ySdYieuQEXrmryVuRWaWWsviqEzWx56/jTGILpvYOMPs6CdnySWgAAuiY
	 xCuzZPEREmGsLkARwLy5zgsPb/TaDj4Le9F/X75IeNsnoKSBBJRdBjomvV7Gc8FNTrZJd+lJISU/
	 qiGxO9WreS+EZe6gh7Us27BEmq96DXElSo6Ysd+mBZw730A20dO/6ZAUmRVt0/jok8VUskE9xS8C
	 BNh/ojbk/+OpeWSwUFNK2T+lndMhAelXvhQomyChV8Iwxjj+Szuvx2l+XoM+I58NP7PL56+El3+K
	 cPdC6TIkqhQfZqankMrfm+WrfZF9jlaMns1HtyDoqqandsHlugDFZ1mzcelBseHQDXEqEEFnx996
	 hZECdOD/DHaAYY0/uHdwgDM0iFjpgYJpPbJ/NPJ7E2pKFiarAF0/DnetYAbdYRgH3kB53lXPVrMk
	 xjaUG9sPizVOtTFChkom/HA7+5r/xkJZA+Xt4AKz4/WFw6JQXfnTlFiSs21pWs+uGd0BWDWT//Ae
	 3zZxZJUrmiM1HD7R2ng6R43PhVTm/K9iApYrQdafTQHQGthGLXb1n7M9iegdXc0XF+Ie0EdqFQtp
	 HKvpSw1lp9WcRue8QlEKNlloIuotM4WRHVz055rwDcpDbqld5tAgrjraCD+q5ufZNfK32a8/SUxO
	 YgY/XV
X-QQ-XMRINFO: OD9hHCdaPRBwq3WW+NvGbIU=
From: Yangyu Chen <cyy@cyyself.name>
To: cyy@cyyself.name
Cc: alexghiti@rivosinc.com,
	andy.chiu@sifive.com,
	charlie@rivosinc.com,
	conor.dooley@microchip.com,
	guoren@kernel.org,
	jszhang@kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org,
	linux-riscv@lists.infradead.org,
	palmer@dabbelt.com,
	paul.walmsley@sifive.com
Subject: Re: [PATCH v2 0/3] RISC-V: mm: do not treat hint addr on mmap as the upper bound to search
Date: Thu, 29 Feb 2024 20:10:03 +0800
X-OQ-MSGID: <20240229121003.14374-1-cyy@cyyself.name>
X-Mailer: git-send-email 2.39.3 (Apple Git-145)
In-Reply-To: <tencent_B2D0435BC011135736262764B511994F4805@qq.com>
References: <tencent_B2D0435BC011135736262764B511994F4805@qq.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch has not been reviewed for more than a month. There is another patch that did the same fix but in another way and still has not been reviewed like this. I'm here to do a comparison of some choices briefly to let the maintainer understand the issues and the solutions. I think it's time to make a decision before the next Linux LTS v6.9. As a number of sv48 chips will be released this year.

Issues:

Since commit add2cc6b6515 ("RISC-V: mm: Restrict address space for sv39,sv48,sv57") from patch [1], userspace software cannot create virtual address memory mapping on the hint address if the address larger than (1<<38) on sv48, sv57 capable CPU using mmap without MAP_FIXED set. 

This is because since that commit, the hint address is treated as the upper bound to create the mapping when the hint address is larger than (1<<38).

Existing regression for userspace software since that commit:
- box64 [2]

Some choices are:

1. Do not change it

Con:

This behavior is not the same as x86, arm64, and powerpc when treating memory address space larger than 48-bit. On x86, arm64, and powerpc, if the hint address is larger than 48-bit, mmap will not limit the upper bound to use.

Also, these ISAs limit the mmap to 48-bit by default. However, RISC-V currently uses sv39 by default, which is not the same as the document and commit message.

2. Use my patch

which limits the upper bound of mmap to 47-bit by default, if the hint address is larger than (1<<47), then no limit.

Pros: Let the behavior of mmap align with x86, arm64, powerpc

Cons: A new regression for software that assumes mmap will not return an address larger than the hint address if the hint address is larger than (1<<38) as it has been documented on RISC-V since v6.6. However, there is no change in the widespread sv39 systems we use now.

3. Use Charlie's patch [3]

which adjusts the upper bound to hint address + size.

Pros: Still has upper-bound limit using hint address but allows userspace to create mapping on the hint address without MAP_FIXED set.

Cons: That patch will introduce a new regression even for the sv39 system when creating mmap with the same hint address more than one time if the hint address is less than round-gap.

4. Some new ideas currently are not on the mailing list

Hope this issue can be fixed before the Linux v6.9 release.

Thanks,
Yangyu Chen

[1] https://lore.kernel.org/linux-riscv/20230809232218.849726-2-charlie@rivosinc.com/
[2] https://github.com/ptitSeb/box64/commit/5b700cb6e6f397d2074c49659f7f9915f4a33c5f
[3] https://lore.kernel.org/linux-riscv/20240130-use_mmap_hint_address-v3-0-8a655cfa8bcb@rivosinc.com/


