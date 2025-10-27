Return-Path: <linux-kselftest+bounces-44083-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CBD4C0C039
	for <lists+linux-kselftest@lfdr.de>; Mon, 27 Oct 2025 07:58:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 35A6B189CCC9
	for <lists+linux-kselftest@lfdr.de>; Mon, 27 Oct 2025 06:58:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D437127E06C;
	Mon, 27 Oct 2025 06:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WgYHd1gR"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9DDF28682;
	Mon, 27 Oct 2025 06:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761548298; cv=none; b=dK8wbTQ4j5UshwzjIs5dKKc12O7U/qC2LdQp1J+qzEJjRAVlQrBYgISsGks5Tjpy24C+ybmgqYthLnvds7ggkerFklPdS0CEkCLu3EizJg/RQ4YpSAueF1TB6qR7eRCdrxM8zqHIgujXUiv8aUtCx6KCRUBHIEUJcPNWz2ol3QM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761548298; c=relaxed/simple;
	bh=lbGgWupkovq81DImc+Wfj/Z+qTggpqUzQ5AribnsI4Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dV5ZvtJOA8Kthu4Uha+i/2ASB06y7EJlu2XZlqC0R4MpKloeESiBCGaP6bDtAnhOUDGRhVzqoODh5QzGmf+RdOth+TLqdqfjCsEkePOQaPCADpbt2g/rTl1PJFHJyUsMWQD3xc75sXmYsoIPEAhqHD3CN1JRaxwBL8CUTjxybls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WgYHd1gR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97AD3C4CEF1;
	Mon, 27 Oct 2025 06:58:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761548297;
	bh=lbGgWupkovq81DImc+Wfj/Z+qTggpqUzQ5AribnsI4Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WgYHd1gRoMxFqKfxyVNMKdMBnx9LTmiWGz9jsusgML8qyb1cDoittaMKbRXdbKibm
	 p3C6RKP/o0JYKQ2ITDj2QPCNF+39qqS3oj+PCGUyAR+Qa7GI0Pd45iPt0aSo3fcOZ1
	 bOEXHU78SCT2qDR5iScbhySSNt4n9IdSiyHghmqANQwbeVeQK9P9Smyu58ciepIfJR
	 nQLa6zLLFJMopTremXr7vWdGvhdPZL0ze/KJXCQz9zywcVPNoviWG+SMNVygDaaw96
	 Q8/6D7q2pMOfzkBj6yg1KTjt2J2zW9q4x1RKZ6mXMyH7ijGHy1jJOMEAUGEwZyNbxV
	 ohhV4WLdQZxlw==
Date: Mon, 27 Oct 2025 08:58:08 +0200
From: Mike Rapoport <rppt@kernel.org>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: akpm@linux-foundation.org, brauner@kernel.org, corbet@lwn.net,
	graf@amazon.com, jgg@ziepe.ca, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
	masahiroy@kernel.org, ojeda@kernel.org, pratyush@kernel.org,
	rdunlap@infradead.org, tj@kernel.org
Subject: Re: [PATCH v8 8/8] memblock: Unpreserve memory in case of error
Message-ID: <aP8YADj4ha3trjJn@kernel.org>
References: <20251024161002.747372-1-pasha.tatashin@soleen.com>
 <20251024161002.747372-9-pasha.tatashin@soleen.com>
 <aP5Mcr9WCt5CHon6@kernel.org>
 <CA+CK2bCUc5Q5PxCy3jGN9CC48Zz_evq51d7Hps7=r9g28z7tig@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+CK2bCUc5Q5PxCy3jGN9CC48Zz_evq51d7Hps7=r9g28z7tig@mail.gmail.com>

On Sun, Oct 26, 2025 at 01:41:30PM -0400, Pasha Tatashin wrote:
> On Sun, Oct 26, 2025 at 12:29 PM Mike Rapoport <rppt@kernel.org> wrote:
> >
> > > @@ -2462,12 +2463,14 @@ static int __init prepare_kho_fdt(void)
> > >
> > >       err |= fdt_begin_node(fdt, "");
> > >       err |= fdt_property_string(fdt, "compatible", MEMBLOCK_KHO_NODE_COMPATIBLE);
> > > -     for (i = 0; i < reserved_mem_count; i++) {
> > > +     for (i = 0; !err && i < reserved_mem_count; i++) {
> > >               struct reserve_mem_table *map = &reserved_mem_table[i];
> > >               struct page *page = phys_to_page(map->start);
> > >               unsigned int nr_pages = map->size >> PAGE_SHIFT;
> > >
> > > -             err |= kho_preserve_pages(page, nr_pages);
> > > +             err = kho_preserve_pages(page, nr_pages);
> > > +             if (err)
> > > +                     break;
> >
> > Please
> >
> >         goto err_unpreserve;
> 
> While we can do that, we loose some symmetry of not performing
> fdt_end_node() and fdt_finish() if fdt lib ever adds some debugging
> facility to make sure that open nodes/trees are properly clodes, this
> is going to flag that. I prefer my current implementation.

Why do we care about fdt that we are never going to use and that's freed a
few lines below?

> > >               err |= fdt_begin_node(fdt, map->name);
> > >               err |= fdt_property_string(fdt, "compatible", RESERVE_MEM_KHO_NODE_COMPATIBLE);
> > >               err |= fdt_property(fdt, "start", &map->start, sizeof(map->start));
> >
> >         if (err)
> >                 goto err_unpreserve;
> >
> > and drop !err from the loop condition.
> 
> That is going to miss one 'nr_preserved++' . We cannot do that, we
> could move it to the beginning of the loop, but I prefer keeping err
> right in the condition.
 
I very much dislike the error handling after this patch. From a single

	if (err)
		put_page()

it grew into a complex beast with special variables just for the sake of
it.

What I'd like to see is something like

err_unpreserve_fdt:
	kho_unpreserve_folio(page_folio(fdt_page));
err_unpreserve_mems:
	for (unsigned int i = 0; i < nr_preserved; i++) {
		/* unpreserve mem[i] */
	}
err_free_fdt:
	put_page(fdt_page);
	return err;

-- 
Sincerely yours,
Mike.

