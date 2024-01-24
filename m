Return-Path: <linux-kselftest+bounces-3487-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A176A83B34D
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Jan 2024 21:51:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 42A861F236D3
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Jan 2024 20:51:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1878F1350C2;
	Wed, 24 Jan 2024 20:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openbsd.org header.i=@openbsd.org header.b="43WCwO/h"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from cvs.openbsd.org (cvs.openbsd.org [199.185.137.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BB101292FB;
	Wed, 24 Jan 2024 20:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.185.137.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706129500; cv=none; b=eQveOtboNHq2NuaL6TiyOT+yltgJhFDBmngOR+JPxNLRGNszWSaH2nacBFuju6AYdTgCzueyUf6oLorj5ef/zDHaDlbUlTTXnj4hA4GnGaMieSpxPq4x5rd/P0xJ957HXWjii2WW02viIVAwNwvxVnMTuhap9XyYKYxpUZKiesU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706129500; c=relaxed/simple;
	bh=Z6R0DSevUsWp/ES4X1fSbzidtHovZqFHyGVCe23vpOQ=;
	h=From:To:Subject:In-reply-to:References:MIME-Version:Content-Type:
	 Date:Message-ID; b=UWOGTIGDuwxKQhU7FmA8qIGThVbVZZQB+b1Dioa5wxtFuqFXoiV2QURFpdP2/DRTp6z954bOnc6uvJFDldwQam3k1n+unHNCC1ibULcIp4ZN4qRPIJakRQDYYtgUP5uNBxreg61HBJ+KXJChqWqDgf8VoZ/zLJYwV0nHlySytVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=openbsd.org; spf=pass smtp.mailfrom=openbsd.org; dkim=pass (2048-bit key) header.d=openbsd.org header.i=@openbsd.org header.b=43WCwO/h; arc=none smtp.client-ip=199.185.137.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=openbsd.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openbsd.org
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; s=selector1; bh=Z6R0DSevUs
	Wp/ES4X1fSbzidtHovZqFHyGVCe23vpOQ=; h=date:references:in-reply-to:
	subject:to:from; d=openbsd.org; b=43WCwO/hWJyeW7jniZUXpoRulSjG7aM+cwLo
	LzWTShoquiNAk1T+jrBK6SMcVIbDB+V51FxS9Zuoa7yiu+uJnEuLsJ/yl3R4QijJGWRmA+
	MuBAO63A7qp4qRUizMMMzUN6XAGwCoXnwb0F5rMrZ4VU9kSXuZdV+Jj/ccK03N0lH3Umrl
	MN7q+ffha9DN63HMmBAKUyeVOvCqaJdaDlJ+terJSrnNEtPcy/81YKlwfVbfv9eMhcxKAo
	9EwcDoScJoOvaPYrzj+sXkmj/yw3YsTkr8zdGWgUHmkb4NzKMV5P7efFXj4UsndWP7FpdP
	viVTF2l2zifSmurxqYEMPZ+8LQ==
Received: from cvs.openbsd.org (localhost [127.0.0.1])
	by cvs.openbsd.org (OpenSMTPD) with ESMTP id 302f01a8;
	Wed, 24 Jan 2024 13:51:37 -0700 (MST)
From: "Theo de Raadt" <deraadt@openbsd.org>
To: "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
    Jeff Xu <jeffxu@chromium.org>, akpm@linux-foundation.org,
    keescook@chromium.org, jannh@google.com, sroettger@google.com,
    willy@infradead.org, gregkh@linuxfoundation.org,
    torvalds@linux-foundation.org, usama.anjum@collabora.com,
    rdunlap@infradead.org, jeffxu@google.com, jorgelo@chromium.org,
    groeck@chromium.org, linux-kernel@vger.kernel.org,
    linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
    pedro.falcato@gmail.com, dave.hansen@intel.com,
    linux-hardening@vger.kernel.org
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
                  Jeff Xu <jeffxu@chromium.org>,
                  akpm@linux-foundation.org, keescook@chromium.org,
                  jannh@google.com, sroettger@google.com,
                  willy@infradead.org, gregkh@linuxfoundation.org,
                  torvalds@linux-foundation.org,
                  usama.anjum@collabora.com, rdunlap@infradead.org,
                  jeffxu@google.com, jorgelo@chromium.org,
                  groeck@chromium.org, linux-kernel@vger.kernel.org,
                  linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
                  pedro.falcato@gmail.com, dave.hansen@intel.com,
                  linux-hardening@vger.kernel.org
Subject: Re: [PATCH v7 2/4] mseal: add mseal syscall
In-reply-to: <98656.1706128621@cvs.openbsd.org>
References: <20240122152905.2220849-1-jeffxu@chromium.org> <20240122152905.2220849-3-jeffxu@chromium.org> <20240123181457.idckaydk7dt7q2qy@revolver> <CABi2SkX=wKnHmooxXzBnJxxmtfSjvfgYabN1Wh1LxFYjtFoFaQ@mail.gmail.com> <20240124200628.ti327diy7arb7byb@revolver> <98656.1706128621@cvs.openbsd.org>
Comments: In-reply-to "Theo de Raadt" <deraadt@openbsd.org>
   message dated "Wed, 24 Jan 2024 13:37:01 -0700."
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <38861.1706129497.1@cvs.openbsd.org>
Date: Wed, 24 Jan 2024 13:51:37 -0700
Message-ID: <82138.1706129497@cvs.openbsd.org>

Theo de Raadt <deraadt@openbsd.org> wrote:

> This discussion about the malloc heap is ridiculous.  Obviously it is
> programmer error to lock the permissions on memory you will free for
> reuse.  But you can't fix this problem with malloc(), without breaking
> other extremely common circumstances where the allocation of memory
> and PERMANENT-USE-WITHOUT-RELEASE of such memory are seperated over a
> memory boundary, unless you start telling all open source library authors

  ^^^^^^^^^^^^^^^ library boundary, sorry

> to always use MAP_SEALABLE in their mmap() calls.

Example:

1. libcrypto (or some other library) has some ways to allocate memory and
   provide it to an application.
2. Even if this is using malloc(), heap allocations over a pagesize are
   page-aligned, so even then following assumptions are sound.
3. I have an application which uses that memory, but will never release the memory
   until program termination
4. The library interface is public and used by many programs, so the library
   author has a choice of using MAP_SEALABLE or not using MAP_SEALABLE

Due to your choice, my application cannot make lock the memory permissions
unless that library author chooses MAP_SEALABLE

If they choose to use MAP_SEALABLE, all programs get this memory you consider
less safe.

Exactly what is being gained here?






