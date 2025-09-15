Return-Path: <linux-kselftest+bounces-41531-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD8D5B5879F
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Sep 2025 00:39:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 074B37A20AC
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Sep 2025 22:37:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 060F72D1F7C;
	Mon, 15 Sep 2025 22:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="W8GTES4x"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54A582C236D;
	Mon, 15 Sep 2025 22:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757975952; cv=none; b=IG71b3uc4hyc908tuM4whW5u1qXhbc7RIGCizXTfiYTE37qOrKT9tcvp5Exw2BbeO8sqRGibUYmAxBNypqTom7zV7A/Ksg7B9PKDjUVkxFq7bQ7Bua6ZtLn5SFqlf9N3M7SqyiaepZwvUForGUZZ+GhgBES44j3ODhyYsmIxvzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757975952; c=relaxed/simple;
	bh=BfYxjkEzZZCLOYG+UFuReQwEDFeE8IVlt+mRJjbmVrA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=HZY1oyqMo+MI3e9aKJBA7QAPWsb0bzG4rcQJmqcpSChrUckqv1JLRYusfqcsCbODJNSyoMmGs1LKc2e8NSOE/DwwgNypGbbFu7bLXucMVYD9PGxtPlmBbkxBKfPXXKFts/j9UFx8gAfi8qb2F6dFt0keuxqXxtar2jueISiCu/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=W8GTES4x; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 74BCB40B03
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1757975950; bh=4Nh9YPajpzLkLNtov0lA1KMD/BkPyBkqgsXpZ3McHVM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=W8GTES4xWoBx2OrfPfrQJu3grT8gHU5iYD5t+TK2UoDH598lLADT30pTACZmhGNBK
	 GShI0VMfHp0OQIIYCBOI7lHYhdFP47VA+mjQ4j7Ew27oe5rWOqYyPW/cLmGaXcXghu
	 d9RUr918h66cM2CcVCTdv8NoqjzJSRPXs7zDy6rw0urFrrZioFw7yCNSvxqhUWlXp7
	 +Au/Ib+tYcIjZtYSC3URmsA1wWemVHTfoeW9cBs59RPuY84G712tfAsQYi4l72mi6/
	 jmGFOq2DNKOP1yGtIeDyVXECig2whGbJPtL0VHIHp1lx6ZL9cyhVewbCg7znloPx2J
	 Xp1QtPGoXjAJg==
Received: from localhost (unknown [IPv6:2601:280:4600:2da9::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 74BCB40B03;
	Mon, 15 Sep 2025 22:39:10 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Gabriele Paoloni <gpaoloni@redhat.com>, shuah@kernel.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, gregkh@linuxfoundation.org
Cc: linux-mm@kvack.org, safety-architecture@lists.elisa.tech,
 acarmina@redhat.com, kstewart@linuxfoundation.org, chuckwolber@gmail.com,
 Gabriele Paoloni <gpaoloni@redhat.com>
Subject: Re: [RFC v2 PATCH 2/3] /dev/mem: Add initial documentation of
 memory_open() and mem_fops
In-Reply-To: <20250910170000.6475-3-gpaoloni@redhat.com>
References: <20250910170000.6475-1-gpaoloni@redhat.com>
 <20250910170000.6475-3-gpaoloni@redhat.com>
Date: Mon, 15 Sep 2025 16:39:09 -0600
Message-ID: <874it3gx2q.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Gabriele Paoloni <gpaoloni@redhat.com> writes:

> This patch proposes initial kernel-doc documentation for memory_open()
> and most of the functions in the mem_fops structure.
> The format used for the specifications follows the guidelines
> defined in Documentation/doc-guide/code-specifications.rst

I'll repeat my obnoxious question from the first patch: what does that
buy for us?

> Signed-off-by: Gabriele Paoloni <gpaoloni@redhat.com>
> ---
>  drivers/char/mem.c | 231 +++++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 225 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/char/mem.c b/drivers/char/mem.c
> index 48839958b0b1..e69c164e9465 100644
> --- a/drivers/char/mem.c
> +++ b/drivers/char/mem.c
> @@ -75,9 +75,54 @@ static inline bool should_stop_iteration(void)
>  	return signal_pending(current);
>  }
>  
> -/*
> - * This funcion reads the *physical* memory. The f_pos points directly to the
> - * memory location.
> +/**
> + * read_mem - read from physical memory (/dev/mem).
> + * @file: struct file associated with /dev/mem.
> + * @buf: user-space buffer to copy data to.
> + * @count: number of bytes to read.
> + * @ppos: pointer to the current file position, representing the physical
> + *        address to read from.
> + *
> + * This function checks if the requested physical memory range is valid
> + * and accessible by the user, then it copies data to the input
> + * user-space buffer up to the requested number of bytes.
> + *
> + * Function's expectations:
> + *
> + * 1. This function shall check if the value pointed by ppos exceeds the
> + *    maximum addressable physical address;
> + *
> + * 2. This function shall check if the physical address range to be read
> + *    is valid (i.e. it falls within a memory block and if it can be mapped
> + *    to the kernel address space);
> + *
> + * 3. For each memory page falling in the requested physical range
> + *    [ppos, ppos + count - 1]:
> + *   3.1. this function shall check if user space access is allowed (if
> + *        config STRICT_DEVMEM is not set, access is always granted);
> + *
> + *   3.2. if access is allowed, the memory content from the page range falling
> + *        within the requested physical range shall be copied to the user space
> + *        buffer;
> + *
> + *   3.3. zeros shall be copied to the user space buffer (for the page range
> + *        falling within the requested physical range):
> + *     3.3.1. if access to the memory page is restricted or,
> + *     3.2.2. if the current page is page 0 on HW architectures where page 0 is
> + *            not mapped.
> + *
> + * 4. The file position '*ppos' shall be advanced by the number of bytes
> + *    successfully copied to user space (including zeros).

My kneejerk first reaction is: you are repeating the code of the
function in a different language.  If we are not convinced that the code
is correct, how can we be more confident that this set of specifications
is correct?  And again, what will consume this text?  How does going
through this effort get us to a better kernel?

Despite having been to a couple of your talks, I'm not fully
understanding how this comes together; people who haven't been to the
talks are not going to have an easier time getting the full picture.

Thanks,

jon

