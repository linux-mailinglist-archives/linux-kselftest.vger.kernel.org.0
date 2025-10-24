Return-Path: <linux-kselftest+bounces-43988-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A755C06FAE
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Oct 2025 17:31:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 53AAE3A93AE
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Oct 2025 15:27:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF48631E101;
	Fri, 24 Oct 2025 15:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iXlFFD0e"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87B28190477;
	Fri, 24 Oct 2025 15:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761319629; cv=none; b=CLtJjxp9xGPRc7ZtKcii606/d/hm9u/Damka2jM0u0OIB6FYntHZ/C2xPTja30TaZaVzvvTlD3QwOHJLl7wTUIYhRRAynuYYdWTGWCHQaDKJKJ0z6z/WAP2xNGyQG+2wmCtz6yKGm2t7upCU7afye9EDgHI0Om1jMScuOxBBioo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761319629; c=relaxed/simple;
	bh=K35xa85qxRDW/MqsnDVqFDx99T314O0XzeWHcoAYEJk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=twNjsXU5sDPPJzyhkwN9RmT5jxyCe5jpuHZ2bTzojh3j+5wmaOKC6NDS1fbj9Sxm9/Wcy+nu6/r2nITm2mOn7iZYT0diesFbKmYAOuBjDIlsQ1q8H1JHIuHQggcXnHa+sH7bwNFFCZb1csPfi6PfV9m/oLGESDIRUSpHwG6zBzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iXlFFD0e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3851C4CEF1;
	Fri, 24 Oct 2025 15:27:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761319625;
	bh=K35xa85qxRDW/MqsnDVqFDx99T314O0XzeWHcoAYEJk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=iXlFFD0esb38BGOypXdbuN+zB460cx6lQVQFOcp9+fqpdgc8/BzklLxqU0tUV1aqy
	 xL0aS899x16VLYZJfBFr2VEl7oKFu03ulyUpav6KPwvjZpIpFY5QHFecc734nfoVIp
	 +a3Bsr/6OFS340EhY15i9rgeogQdPodkMZtl0tezVqIibjM5wXKFIswHM7L+GxX2TS
	 /YrHZLhO7wsFMWhFiALPyUvgGb6ZvIpMHjdYsOoO4LmOhYpOZERLrDFmm7wFw5CfBd
	 66c/kloCqTYt33leVGEgrhBe0oAa0en0zTrue6n5wWhhUcUaXoQhYabx/5qG9pa2DE
	 Cu8VJX1e0vQqg==
From: Pratyush Yadav <pratyush@kernel.org>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: Mike Rapoport <rppt@kernel.org>,  Pratyush Yadav <pratyush@kernel.org>,
  akpm@linux-foundation.org,  brauner@kernel.org,  corbet@lwn.net,
  graf@amazon.com,  jgg@ziepe.ca,  linux-kernel@vger.kernel.org,
  linux-kselftest@vger.kernel.org,  linux-mm@kvack.org,
  masahiroy@kernel.org,  ojeda@kernel.org,  rdunlap@infradead.org,
  tj@kernel.org
Subject: Re: [PATCHv7 5/7] kho: don't unpreserve memory during abort
In-Reply-To: <CA+CK2bAvKrfuOXTa-RWtcuSR8rkPMhurwCn41NcUm44_vT63rA@mail.gmail.com>
	(Pasha Tatashin's message of "Fri, 24 Oct 2025 09:28:33 -0400")
References: <20251022005719.3670224-1-pasha.tatashin@soleen.com>
	<20251022005719.3670224-6-pasha.tatashin@soleen.com>
	<mafs0a51jfar1.fsf@kernel.org> <aPnXVmD3cNmYNRF_@kernel.org>
	<CA+CK2bAvKrfuOXTa-RWtcuSR8rkPMhurwCn41NcUm44_vT63rA@mail.gmail.com>
Date: Fri, 24 Oct 2025 17:27:01 +0200
Message-ID: <mafs0wm4ke2wq.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 24 2025, Pasha Tatashin wrote:

> On Thu, Oct 23, 2025 at 3:21=E2=80=AFAM Mike Rapoport <rppt@kernel.org> w=
rote:
>>
>> On Wed, Oct 22, 2025 at 01:15:30PM +0200, Pratyush Yadav wrote:
>> > On Tue, Oct 21 2025, Pasha Tatashin wrote:
>> >
>> > > KHO allows clients to preserve memory regions at any point before the
>> > > KHO state is finalized. The finalization process itself involves KHO
>> > > performing its own actions, such as serializing the overall
>> > > preserved memory map.
>> > >
>> > > If this finalization process is aborted, the current implementation
>> > > destroys KHO's internal memory tracking structures
>> > > (`kho_out.ser.track.orders`). This behavior effectively unpreserves
>> > > all memory from KHO's perspective, regardless of whether those
>> > > preservations were made by clients before the finalization attempt
>> > > or by KHO itself during finalization.
>> > >
>> > > This premature unpreservation is incorrect. An abort of the
>> > > finalization process should only undo actions taken by KHO as part of
>> > > that specific finalization attempt. Individual memory regions
>> > > preserved by clients prior to finalization should remain preserved,
>> > > as their lifecycle is managed by the clients themselves. These
>> > > clients might still need to call kho_unpreserve_folio() or
>> > > kho_unpreserve_phys() based on their own logic, even after a KHO
>> > > finalization attempt is aborted.
>> >
>> > I think you also need to update test_kho and reserve_mem to do this
>> > since right now they assume all memory gets unpreserved on failure.
>>
>> I agree.
>
> Hm, this makes no sense to me. So, KHO tried to finalize (i.e.,
> convert xarray to sparse bitmap) and failed (e.g. due to OOM) or
> aborted, so we aborted the finalization. But the preserved memory
> stays preserved, and if user/caller retries finalization and it
> succeeds, the preserved memory will still be passed to the next
> kernel. Why would reserve_mem and test_kho depend on whether KHO
> finalization succeeded or was canceled? It is possible that user
> cancel only to add something else to preservation.

On mainline, the reserve_mem kho_preserve_pages() calls come from the
notifier chain. Any failure on the notifier chain causes an abort and
thus automatically unpreserves all pages that were preserved.

	static int reserve_mem_kho_finalize(struct kho_serialization *ser)
	{
		int err =3D 0, i;
=09
		for (i =3D 0; i < reserved_mem_count; i++) {
                	[...]
			err |=3D kho_preserve_pages(page, nr_pages);
		}
=09
		err |=3D kho_preserve_folio(page_folio(kho_fdt));
		err |=3D kho_add_subtree(ser, MEMBLOCK_KHO_FDT, page_to_virt(kho_fdt));
=09
		return notifier_from_errno(err);
	}

If any of the kho_preserve_pages() fails, the notifier block will fail,
cause an abort, and eventually all memory will be unpreserved.

Now that there is no notifier, and thus no abort, the pages must be
unpreserved explicitly before returning.

Similarly, for test_kho, kho_test_notifier() calls kho_preserve_folio()
and expects the abort to clean things up.

Side note: test_kho also preserves folios from kho_test_save_data() and
doesn't clean them up on error, but that is a separate problem that this
series doesn't have to solve.

I think patch 3/7 is the one that actually causes this problem since it
gets rid of the notifier. This is the wrong patch to complain about this
but somehow I thought this is the one that triggers it.

--=20
Regards,
Pratyush Yadav

