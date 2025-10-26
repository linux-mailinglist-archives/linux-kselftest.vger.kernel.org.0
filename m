Return-Path: <linux-kselftest+bounces-44067-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A898AC0AD31
	for <lists+linux-kselftest@lfdr.de>; Sun, 26 Oct 2025 17:23:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E8BF03B341D
	for <lists+linux-kselftest@lfdr.de>; Sun, 26 Oct 2025 16:23:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A87E52080C8;
	Sun, 26 Oct 2025 16:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ED82mNNR"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E3361A3164;
	Sun, 26 Oct 2025 16:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761495824; cv=none; b=RCQc6o3SeqRA9A+lZYDWZWadOyZTWdwY64/SWoXO51Rxrq0wMtbzDLqHaDiWDkXncS2jPzjYyImQ01eOH/AXlCHQ6aC1h+20AObuiESmxkJSfMShCh6WlrFhWCRukgd7Piw1IFTbfTMiPH4gb5sBzEmn+WHlijI3dtU4hAR52vY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761495824; c=relaxed/simple;
	bh=IzIryL5ZzSIK5IAADXW8ppRRMG5QdtE1U1LqyYCn2mI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GANhOGJt9griFVbffuNzR5DdBE8vTso0Y/XdIklkqQO9syr5/mEjdZ50VYxy7fOKvnnL9rPh60Or5KpzwDeqCLAPwNsUKtS7UEKkBu2GxY5ZAqQG2zIVoTlsQCRx23yEQzv+Qu4NPUZlnLMyliZhxKCU7i9U06JH95QppsySZXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ED82mNNR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EC36C4CEE7;
	Sun, 26 Oct 2025 16:23:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761495824;
	bh=IzIryL5ZzSIK5IAADXW8ppRRMG5QdtE1U1LqyYCn2mI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ED82mNNRqJ3jL9ehZj1qNyPphPq68PfaTZpFEelfjITAU4qGtuUKf/8h/2qFQbOTb
	 z1KR9ENADYHkDYhyQE6kcTPvpTGMdCXLpadop2cSDHl4+GXDg4PBoicMiNEMm93lql
	 VoiWY85vHidBbxkYTZ70BhkP/e8UPe+czQAAmn+DX+aBVknZC79AHLEzoG9ha0j+am
	 SCP54gQMgxT+XKxQYhkvv9+OywRKrIOC1wzvIFNuysd/RhrPoFyZJm2dOHpUU+R+w8
	 WeoTskL6dViCKt7nP6rDJodk39ucVwwiAZWczO/dN0uXB6SZ4GcR2uXwwiAVO5IZ5L
	 DXoHwdlQ8sxxg==
Date: Sun, 26 Oct 2025 18:23:35 +0200
From: Mike Rapoport <rppt@kernel.org>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: akpm@linux-foundation.org, brauner@kernel.org, corbet@lwn.net,
	graf@amazon.com, jgg@ziepe.ca, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
	masahiroy@kernel.org, ojeda@kernel.org, pratyush@kernel.org,
	rdunlap@infradead.org, tj@kernel.org
Subject: Re: [PATCH v8 3/8] kho: drop notifiers
Message-ID: <aP5LB5NQ4lhhAA6Y@kernel.org>
References: <20251024161002.747372-1-pasha.tatashin@soleen.com>
 <20251024161002.747372-4-pasha.tatashin@soleen.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251024161002.747372-4-pasha.tatashin@soleen.com>

On Fri, Oct 24, 2025 at 12:09:57PM -0400, Pasha Tatashin wrote:
> From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
> 
> The KHO framework uses a notifier chain as the mechanism for clients to
> participate in the finalization process. While this works for a single,
> central state machine, it is too restrictive for kernel-internal
> components like pstore/reserve_mem or IMA. These components need a
> simpler, direct way to register their state for preservation (e.g.,
> during their initcall) without being part of a complex,
> shutdown-time notifier sequence. The notifier model forces all
> participants into a single finalization flow and makes direct
> preservation from an arbitrary context difficult.
> This patch refactors the client participation model by removing the
> notifier chain and introducing a direct API for managing FDT subtrees.
> 
> The core kho_finalize() and kho_abort() state machine remains, but
> clients now register their data with KHO beforehand.
> 
> Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> Co-developed-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> ---
>  include/linux/kexec_handover.h   |  28 +-----
>  kernel/kexec_handover.c          | 166 +++++++++++++++++--------------
>  kernel/kexec_handover_debugfs.c  |  17 ++--
>  kernel/kexec_handover_internal.h |   5 +-
>  lib/test_kho.c                   |  33 +-----
>  mm/memblock.c                    |  62 +++---------
>  6 files changed, 126 insertions(+), 185 deletions(-)

> diff --git a/lib/test_kho.c b/lib/test_kho.c
> index 60cd899ea745..1c6c4ce83666 100644
> --- a/lib/test_kho.c
> +++ b/lib/test_kho.c
> @@ -120,6 +93,7 @@ static int kho_test_prepare_fdt(struct kho_test_state *state)
>  
>  	fdt = folio_address(state->fdt);
>  
> +	err |= kho_preserve_folio(state->fdt);

We should bail out here, no point creating an fdt if it won't be preserved.

>  	err |= fdt_create(fdt, fdt_size);
>  	err |= fdt_finish_reservemap(fdt);
>  
> @@ -131,6 +105,7 @@ static int kho_test_prepare_fdt(struct kho_test_state *state)
>  
>  	err |= fdt_finish(fdt);
>  
> +	err = kho_add_subtree(KHO_TEST_FDT, folio_address(state->fdt));
>  	if (err)
>  		folio_put(state->fdt);
>  
> @@ -203,7 +178,7 @@ static int kho_test_save(void)
>  	if (err)
>  		goto err_free_folios;
>  
> -	err = register_kho_notifier(&kho_test_nb);
> +	err = kho_add_subtree(KHO_TEST_FDT, folio_address(state->fdt));

This is the second time we add the same subtree, isn't it?

>  	if (err)
>  		goto err_free_fdt;
>  
> @@ -326,7 +301,7 @@ static void kho_test_cleanup(void)
>  
>  static void __exit kho_test_exit(void)
>  {
> -	unregister_kho_notifier(&kho_test_nb);
> +	kho_remove_subtree(folio_address(kho_test_state.fdt));
>  	kho_test_cleanup();
>  }
>  module_exit(kho_test_exit);
> diff --git a/mm/memblock.c b/mm/memblock.c
> index e23e16618e9b..e3bef9b35d63 100644
> --- a/mm/memblock.c
> +++ b/mm/memblock.c
>  static int __init prepare_kho_fdt(void)
>  {
>  	int err = 0, i;
> +	struct page *fdt_page;
>  	void *fdt;
>  
> -	kho_fdt = alloc_page(GFP_KERNEL);
> -	if (!kho_fdt)
> +	fdt_page = alloc_page(GFP_KERNEL);
> +	if (!fdt_page)
>  		return -ENOMEM;
>  
> -	fdt = page_to_virt(kho_fdt);
> +	fdt = page_to_virt(fdt_page);
>  
>  	err |= fdt_create(fdt, PAGE_SIZE);
>  	err |= fdt_finish_reservemap(fdt);
> @@ -2499,7 +2464,10 @@ static int __init prepare_kho_fdt(void)
>  	err |= fdt_property_string(fdt, "compatible", MEMBLOCK_KHO_NODE_COMPATIBLE);
>  	for (i = 0; i < reserved_mem_count; i++) {
>  		struct reserve_mem_table *map = &reserved_mem_table[i];
> +		struct page *page = phys_to_page(map->start);
> +		unsigned int nr_pages = map->size >> PAGE_SHIFT;
>  
> +		err |= kho_preserve_pages(page, nr_pages);
>  		err |= fdt_begin_node(fdt, map->name);
>  		err |= fdt_property_string(fdt, "compatible", RESERVE_MEM_KHO_NODE_COMPATIBLE);
>  		err |= fdt_property(fdt, "start", &map->start, sizeof(map->start));
> @@ -2507,13 +2475,16 @@ static int __init prepare_kho_fdt(void)
>  		err |= fdt_end_node(fdt);
>  	}
>  	err |= fdt_end_node(fdt);
> -
>  	err |= fdt_finish(fdt);
>  
> +	err |= kho_preserve_folio(page_folio(fdt_page));

When looking at the end result after patch 8 it becomes a total mess.
Let's move this right after the allocation and make it

	err = kho_preserve_folio(page_folio(fdt_page);
	if (err)
		goto err_free_fdt;

> +
> +	if (!err)
> +		err = kho_add_subtree(MEMBLOCK_KHO_FDT, fdt);

and replace this pattern with usual kernel

	if (err)
		goto err_free_fdt;

	err = kho_add_subtree(MEMBLOCK_KHO_FDT, fdt);
	if (err)
		goto err_free_fdt;

so that only fdt operations will be a part of 

	err |= fdt_<function> 

sequence.

>  	if (err) {
>  		pr_err("failed to prepare memblock FDT for KHO: %d\n", err);
> -		put_page(kho_fdt);
> -		kho_fdt = NULL;
> +		put_page(fdt_page);
>  	}
>  
>  	return err;
> @@ -2529,13 +2500,6 @@ static int __init reserve_mem_init(void)
>  	err = prepare_kho_fdt();
>  	if (err)
>  		return err;
> -
> -	err = register_kho_notifier(&reserve_mem_kho_nb);
> -	if (err) {
> -		put_page(kho_fdt);
> -		kho_fdt = NULL;
> -	}
> -
>  	return err;
>  }
>  late_initcall(reserve_mem_init);
> -- 
> 2.51.1.821.gb6fe4d2222-goog
> 
> 

-- 
Sincerely yours,
Mike.

