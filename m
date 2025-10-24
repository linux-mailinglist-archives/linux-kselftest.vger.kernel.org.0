Return-Path: <linux-kselftest+bounces-43973-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3650FC05620
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Oct 2025 11:39:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id DDF85357553
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Oct 2025 09:39:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 142B630BB88;
	Fri, 24 Oct 2025 09:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XcyYBwp8"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E13B8308F24;
	Fri, 24 Oct 2025 09:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761298771; cv=none; b=SYBz+KmZfi87BV0Ij8awjUQ8/hLTyTrLoV7DuW+ITAvs/6Y3grdyq3nCBFrIFxKNCFeKBR3NVSTsvNHBJmyIRIOdVLnnlHwIxaQ0+15eBVMsYGOauPzUGAegzy2XDKc+DyA2YPli6FTuvQLAuR9k4oRXuE103SKiiDBsQh8VVj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761298771; c=relaxed/simple;
	bh=fjCbW0elSEHQWPF0dVcB3J2ybhy2ZJN8ePhdt//vJOM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=U2l2JOJZ4MApmnJe2b9kcng/RuuxE/UO5Ls2mOzDOEn+PHqwr8CP3yZvEOqzsSaYceTQSjmyZrwRBmoOdcOP6RBS5IHXEWOLZ+iuwmZ5yHScnXwUxhHwkn7nZTinQndDvWUf/pWaO1vjumn3X85Vk3AvwFl/KYzqdFmPtq0NTHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XcyYBwp8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A5C4C4CEF1;
	Fri, 24 Oct 2025 09:39:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761298770;
	bh=fjCbW0elSEHQWPF0dVcB3J2ybhy2ZJN8ePhdt//vJOM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=XcyYBwp8EdP2kgPUzAYLtk96bUgcbjjFzbgrm7EAOb2CjTE2KEg1B/IoZ6OGbWm/K
	 bTSrIwYU9xYxFUITdqJyahmV5b3ZbmEBr2/w8LAtLRLjuYn0DkdWiIdFI/SuMyFfO6
	 Pis2cs6EN1+Rw80L0AUJsZRp5L/2KdV1TX/2+8kWsMmn7gN4+pS+zfTQRv8qSeksNz
	 s54IqIs3lctyACsVOmfuSUCcYgtwfQPXjk9yRn4TqODj/nkJQ87+eX8qvluwnOg1Mg
	 XsamiEJS2eBhw7ZBwKq7a7ThAF61W4k5JDaRbik6zVfWzPRY4+2RLUCivmPFvni9ro
	 Zpqhsbuh0/Lfg==
From: Pratyush Yadav <pratyush@kernel.org>
To: Mike Rapoport <rppt@kernel.org>
Cc: Pratyush Yadav <pratyush@kernel.org>,  Pasha Tatashin
 <pasha.tatashin@soleen.com>,  akpm@linux-foundation.org,
  brauner@kernel.org,  corbet@lwn.net,  graf@amazon.com,  jgg@ziepe.ca,
  linux-kernel@vger.kernel.org,  linux-kselftest@vger.kernel.org,
  linux-mm@kvack.org,  masahiroy@kernel.org,  ojeda@kernel.org,
  rdunlap@infradead.org,  tj@kernel.org
Subject: Re: [PATCHv7 3/7] kho: drop notifiers
In-Reply-To: <aPsZzxmGjrJSzB4q@kernel.org> (Mike Rapoport's message of "Fri,
	24 Oct 2025 09:16:47 +0300")
References: <20251022005719.3670224-1-pasha.tatashin@soleen.com>
	<20251022005719.3670224-4-pasha.tatashin@soleen.com>
	<mafs0ikg7fbez.fsf@kernel.org> <aPsZzxmGjrJSzB4q@kernel.org>
Date: Fri, 24 Oct 2025 11:39:26 +0200
Message-ID: <mafs01pmsfxkh.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Fri, Oct 24 2025, Mike Rapoport wrote:

> On Wed, Oct 22, 2025 at 01:01:08PM +0200, Pratyush Yadav wrote:
>> Hi Pasha,
>> 
>> On Tue, Oct 21 2025, Pasha Tatashin wrote:
>> 
>> > From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
>> >
>> > The KHO framework uses a notifier chain as the mechanism for clients to
>> > participate in the finalization process. While this works for a single,
>> > central state machine, it is too restrictive for kernel-internal
>> > components like pstore/reserve_mem or IMA. These components need a
>> > simpler, direct way to register their state for preservation (e.g.,
>> > during their initcall) without being part of a complex,
>> > shutdown-time notifier sequence. The notifier model forces all
>> > participants into a single finalization flow and makes direct
>> > preservation from an arbitrary context difficult.
>> > This patch refactors the client participation model by removing the
>> > notifier chain and introducing a direct API for managing FDT subtrees.
>> >
>> > The core kho_finalize() and kho_abort() state machine remains, but
>> > clients now register their data with KHO beforehand.
>> >
>
> ...
>
>> > @@ -1280,7 +1298,7 @@ static __init int kho_init(void)
>> >  	kho_enable = false;
>> >  	return err;
>> >  }
>> > -late_initcall(kho_init);
>> > +fs_initcall(kho_init);
>> 
>> Is this change related to this patch? Also, why fs_initcall?
>
> memblock registers sub-fdt in late_initcall(), so we should have the root
> fdt ready by then. 

I see. Should this be even earlier then? Other components might also
depend on KHO being initialized, and those might be at or before
fs_initcall.

For example, LUO does its init using early_initcall and uses KHO, even
before it is initialized [0]. This works because kho_retrieve_subtree()
only uses parts initialized very early in boot (the KHO FDT), but I
suppose we want to have a proper initialization order to not rely on
things that just happen to work until they don't.

Since kho_init() has a dependency on debugfs, which gets initialized in
core_initcall, I guess the earliest it can be is postcore_initcall. Or,
we split out the debugfs parts into a separate init function (they have
their own file anyway) and initialize "core KHO" in early_initcall? Then
LUO can be in core_initcall and all its users in later ones.

Thoughts?

[0] https://lore.kernel.org/lkml/20250929010321.3462457-9-pasha.tatashin@soleen.com/

-- 
Regards,
Pratyush Yadav

