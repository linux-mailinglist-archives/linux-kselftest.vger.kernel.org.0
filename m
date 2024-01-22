Return-Path: <linux-kselftest+bounces-3328-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3497836C6F
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Jan 2024 18:05:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E3A481C26EF1
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Jan 2024 17:05:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 777C648CC5;
	Mon, 22 Jan 2024 15:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openbsd.org header.i=@openbsd.org header.b="n50s5fom"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from cvs.openbsd.org (cvs.openbsd.org [199.185.137.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94C103D99A;
	Mon, 22 Jan 2024 15:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.185.137.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705938588; cv=none; b=mKq12+Xz0r0n646R+6E9fkRAUFEZGX/XkeLWRTiJ8rAv+pSkg7dcW01j8G5uBxoSGCZrWoslGNUwhviqFoE2tGkoh989eErUlz0RjtJ0sbleQ1PY/nDkguU8Tsg9iZgCNNhRI46Hh4MZDDz5vt3ANL8qnHn6JFbeRrBGddGKZuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705938588; c=relaxed/simple;
	bh=k7nQjJCjWS7QC8MeL9YzD9PrLF0VGaGFHHqIeOBQKAw=;
	h=From:To:cc:Subject:In-reply-to:References:MIME-Version:
	 Content-Type:Date:Message-ID; b=fID1Qsy58uP+We1doNCzvyMNE8nLBvii1lY1y71/LYXY09S9l0eHsDV0Hh/JIDPoq7lTpUDfz24AaImDMF6t1z2jAoCDZQhXSRM/v7QvifxPoIZHjw4VxSEIZoQRv8L5F8Dq7x/A2vDZFFSeziZ+cZ4KVanUCi2VmATWh25bERo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=openbsd.org; spf=pass smtp.mailfrom=openbsd.org; dkim=pass (2048-bit key) header.d=openbsd.org header.i=@openbsd.org header.b=n50s5fom; arc=none smtp.client-ip=199.185.137.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=openbsd.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openbsd.org
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; s=selector1; bh=k7nQjJCjWS
	7QC8MeL9YzD9PrLF0VGaGFHHqIeOBQKAw=; h=date:references:in-reply-to:
	subject:cc:to:from; d=openbsd.org; b=n50s5fom6DQvnOuPAWppwTTuDx/Hdrg2M
	7/pKMQklBESCFMqVIrYmB+1FIBZ6frgkrGVkt3TVlG2/fCGGi1k0mvseFvgf3QQnRHxPQZ
	pNfYfeRwaX414VOclH4koqNNxL1KaQ3r9/E85ErVnankDhKWJlSfkYbxME23q59ndFBIRU
	FKde24hKJcx4S8gNnST4MkZcAyGU572VL3RobUJ5toxWWSu/Evt/C5N60lWHsq0IkCTWOe
	a/WwPvGsNQA/yKQK5RMPAAOpAiItgv+A1lV3KKffLznE2p1B7xSxuGwMKU+urD1vRqxMsH
	T3OFrVd320BK4OhFH394v9SNpAqsw==
Received: from cvs.openbsd.org (localhost [127.0.0.1])
	by cvs.openbsd.org (OpenSMTPD) with ESMTP id 2feb09e1;
	Mon, 22 Jan 2024 08:49:39 -0700 (MST)
From: "Theo de Raadt" <deraadt@openbsd.org>
To: jeffxu@chromium.org
cc: akpm@linux-foundation.org, keescook@chromium.org, jannh@google.com,
    sroettger@google.com, willy@infradead.org,
    gregkh@linuxfoundation.org, torvalds@linux-foundation.org,
    usama.anjum@collabora.com, rdunlap@infradead.org, jeffxu@google.com,
    jorgelo@chromium.org, groeck@chromium.org,
    linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
    linux-mm@kvack.org, pedro.falcato@gmail.com, dave.hansen@intel.com,
    linux-hardening@vger.kernel.org
Subject: Re: [PATCH v7 0/4] Introduce mseal()
In-reply-to: <20240122152905.2220849-1-jeffxu@chromium.org>
References: <20240122152905.2220849-1-jeffxu@chromium.org>
Comments: In-reply-to jeffxu@chromium.org
   message dated "Mon, 22 Jan 2024 15:28:46 +0000."
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <8627.1705938579.1@cvs.openbsd.org>
Date: Mon, 22 Jan 2024 08:49:39 -0700
Message-ID: <726.1705938579@cvs.openbsd.org>

Regarding these pieces

> The PROT_SEAL bit in prot field of mmap(). When present, it marks
> the map sealed since creation.

OpenBSD won't be doing this.  I had PROT_IMMUTABLE as a draft.  In my
research I found basically zero circumstances when you userland does
that.  The most common circumstance is you create a RW mapping, fill it,
and then change to a more restrictve mapping, and lock it.

There are a few regions in the addressspace that can be locked while RW.
For instance, the stack.  But the kernel does that, not userland.  I
found regions where the kernel wants to do this to the address space,
but there is no need to export useless functionality to userland.

OpenBSD now uses this for a high percent of the address space.  It might
be worth re-reading a description of the split of responsibility regarding
who locks different types of memory in a process;
- kernel (the majority, based upon what ELF layout tell us),
- shared library linker (the next majority, dealing with shared
  library mappings and left-overs not determinable at kernel time),
- libc (a small minority, mostly regarding forced mutable objects)
- and the applications themselves (only 1 application today)

    https://lwn.net/Articles/915662/

> The MAP_SEALABLE bit in the flags field of mmap(). When present, it marks
> the map as sealable. A map created without MAP_SEALABLE will not support
> sealing, i.e. mseal() will fail.

We definately won't be doing this.  We allow a process to lock any and all
it's memory that isn't locked already, even if it means it is shooting
itself in the foot.

I think you are going to severely hurt the power of this mechanism,
because you won't be able to lock memory that has been allocated by a
different callsite not under your source-code control which lacks the
MAP_SEALABLE flag.  (Which is extremely common with the system-parts of
a process, meaning not just libc but kernel allocated objects).

It may be fine inside a program like chrome, but I expect that flag to make
it harder to use in libc, and it will hinder adoption.


