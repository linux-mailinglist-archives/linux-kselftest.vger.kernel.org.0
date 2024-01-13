Return-Path: <linux-kselftest+bounces-2946-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B21A782CDFB
	for <lists+linux-kselftest@lfdr.de>; Sat, 13 Jan 2024 18:33:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 30D1CB20F25
	for <lists+linux-kselftest@lfdr.de>; Sat, 13 Jan 2024 17:33:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 787BC5240;
	Sat, 13 Jan 2024 17:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="ukzssRAC"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out203-205-221-191.mail.qq.com (out203-205-221-191.mail.qq.com [203.205.221.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B7185663;
	Sat, 13 Jan 2024 17:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cyyself.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=cyyself.name
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1705166867; bh=9n72WKKKGYhqMdswP9Jj7VEaJwHs3IyzRS4xEll9rYI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ukzssRACnz3BFOQ4m0PrtOBC+c3ULmzJzKNt2HiTP2zC7dzmPLW+FHncUgy76IUE4
	 bBSFdgBVxfqt3ilig5ltgbGZKNlqBnwvrADPa0YP4lfB4HrJGDn5rUl3BbiJvb9e3P
	 f5Md6MBUvXZU9MQybaI0l9rZ76Crk8hUiMtlUkkE=
Received: from cyy-pc.lan ([218.70.255.58])
	by newxmesmtplogicsvrszc5-1.qq.com (NewEsmtp) with SMTP
	id 6B9BD474; Sun, 14 Jan 2024 01:26:57 +0800
X-QQ-mid: xmsmtpt1705166817tpw8s6zxo
Message-ID: <tencent_F9568C6D8872E30EDFAF20ADF686A31D6E06@qq.com>
X-QQ-XMAILINFO: MpYZqmNm/7vMFQChzuZcNMPEZCicAYxwA3bgPt5oBo3Izruh5SDSD1/vjfZIJe
	 7IBevBAJJvXhgU9B+SMnjtsigosK99wXz45XosSRmglerB4jvY07z2ypp/fWsmUwQLZ3rc4lgw08
	 0I7c4e9ssoe0Ldzh7aDfnOwg3ItEwflH/BF3rnY12bJD7xRo/M9ZSFqZABHgOKsvejN9E8BhUm2D
	 boo2oTfkaKEQcLeunqTCbSyoFYN07nmPJtRl8ODOOCFEIFDrcTWZHY0wX7tuAYx6PuS1SJSjXYS2
	 bOEVhUBovGWI01NTW0yrPLyhFe33CdafAdJAf1SrjfgmRNyBqHdsDLZz7UlH9vHjFxvMrmU3dy5N
	 45B3OLgeNOTV6WEfUAL3IRazwMFr8aKB9LH+gkUjByXzXtwcrFHxXmMsjpssUiAlF1duH66p4Avr
	 84W1XexcvjfBXHBgXn5BFW2+ogGmclzTetljdN04BAku6PGLStHt7Vs8LRhxh82ARYq6o+Md+kgL
	 NJxin6UVnpDBzYjg39bVX6PvJK3U699wPbe+uQtu79mMUgZ8WzO3iGxiOmirlrq0y8rVSXD7t5iM
	 GYsxJ8FGK+3+d6K/ILCMvSeHJKdwbCtWTtAdunvZubJwOzaynOeC1geHeMxH34ZZztsMnz79vLpe
	 YGChZ7mLTbp5fUDptY+VCdcdL4Fy7KWDgIBg7MTpy9RLjNazovEqG5960r71+VO+2pza3/A/dviG
	 n0++0sT/QAFpxAF7w8YGMItABROQoWSr+xES2srhGGf311gs4BzoOgOKZhvP5I3hexb4JG++/Bt2
	 OrIfwjVtIS7Tr5jYRQvXT+uKYpMsexCp3J8Xip53EB0io7BHq+H8zipn5FRMnuzONGJrAQAd9WC+
	 I81SztmB19m/xMFkY6qEQ5yrj6ENCd3r8gON2zNjMQDmvw7Tdjfni3yzimGkBOehL2PYtcjs/KFk
	 RJDRSTS7yAifSWQWUnc3KxIF9qzMRd
X-QQ-XMRINFO: NyFYKkN4Ny6FSmKK/uo/jdU=
From: Yangyu Chen <cyy@cyyself.name>
To: charlie@rivosinc.com
Cc: alexghiti@rivosinc.com,
	anup@brainfault.org,
	aou@eecs.berkeley.edu,
	conor@kernel.org,
	jrtc27@jrtc27.com,
	konstantin@linuxfoundation.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org,
	linux-riscv@lists.infradead.org,
	mick@ics.forth.gr,
	palmer@rivosinc.com,
	paul.walmsley@sifive.com,
	rdunlap@infradead.org
Subject: Re: [PATCH v10 0/4] RISC-V: mm: Make SV48 the default address space
Date: Sun, 14 Jan 2024 01:26:57 +0800
X-OQ-MSGID: <20240113172657.997104-1-cyy@cyyself.name>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20230809232218.849726-1-charlie@rivosinc.com>
References: <20230809232218.849726-1-charlie@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi, Charlie

Although this patchset has been merged I still have some questions about
this patchset. Because it breaks regular mmap if address >= 38 bits on
sv48 / sv57 capable systems like qemu. For example, If a userspace program
wants to mmap an anonymous page to addr=(1<<45) on an sv48 capable system,
it will fail and kernel will mmaped to another sv39 address since it does
not meet the requirement to use sv48 as you wrote:

>	else if ((((_addr) >= VA_USER_SV48)) && (VA_BITS >= VA_BITS_SV48)) \
>		mmap_end = VA_USER_SV48;			\
>	else							\
>		mmap_end = VA_USER_SV39;			\

Then, How can a userspace program create a mmap with a hint if the address
>= (1<<38) after your patch without MAP_FIXED? The only way to do this is
to pass a hint >= (1<<47) on mmap syscall then kernel will return a random
address in sv48 address space but the hint address gets lost. I think this
violate the principle of mmap syscall as kernel should take the hint and
attempt to create the mapping there.

I don't think patching in this way is right. However, if we only revert
this patch, some programs relying on mmap to return address with effective
bits <= 48 will still be an issue and it might expand to other ISAs if
they implement larger virtual address space like RISC-V sv57. A better way
to solve this might be adding a MAP_48BIT flag to mmap like MAP_32BIT has
been introduced for decades.

Thanks,
Yangyu Chen


