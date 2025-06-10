Return-Path: <linux-kselftest+bounces-34630-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C065EAD45E7
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Jun 2025 00:25:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 84B8B3A6D1B
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Jun 2025 22:25:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B1BB28D85F;
	Tue, 10 Jun 2025 22:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JJ7r/8ny"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 960F928C2CA
	for <linux-kselftest@vger.kernel.org>; Tue, 10 Jun 2025 22:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749594312; cv=none; b=IpvTnUjwJXD9yXOV1y4NllYA0472Oz45IDtJxHVeEAkpQuO0eiuG/VXLg/ITMEyjpzQNaxzC7swEQXq2+AhR8VvSGB775rZwfgqZHf867jNeolgPKAgEmEYJTytRbIXQsUIEsN6o4TLiA0UDmXBc1mYkQuxkLhOdEMLvP97qZS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749594312; c=relaxed/simple;
	bh=bjEQw4isrba+nP1ZYwzcYPZbVaYkMsqnYrte+EEhbmE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H+LXEGlmXqOoeskXr2Qy/0dytsVKNpfesSg9MwE6+M4AVKCixepGwxmqtFoFMDo7SUrvG/9B6Ugm3ibdmy+HAUxPbn71m0Otgjv0nbPbHjD45ykex0JBS4Dho9CdGY9PlCbHkrmgsCIUI5zRtcihj6PjZFnfb/F4DvVjdqU/Pa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JJ7r/8ny; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749594308;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jeldsOfLIW+0Hr4bYxPOhI4qHvZBHHNPgSq/+bzEbT4=;
	b=JJ7r/8nylq9p8XUPBIJoCglrzm6WhcrlLknWRuBFgxYtjwd79OegBviDQd/Lkt32xP6F5k
	uoPLlsLhVh8aVEoXgg78c8/GwWykxs4rAaEFhMciRGAAbNoiyzOTj85BNJqkrcfl5FF6X0
	w7ZWFklfpYdZarPspeiXybSvyxCwTCU=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-614-npCBY1AuOoyo-Vj4mdJvxw-1; Tue, 10 Jun 2025 18:25:07 -0400
X-MC-Unique: npCBY1AuOoyo-Vj4mdJvxw-1
X-Mimecast-MFC-AGG-ID: npCBY1AuOoyo-Vj4mdJvxw_1749594307
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4a38007c7bdso128899521cf.3
        for <linux-kselftest@vger.kernel.org>; Tue, 10 Jun 2025 15:25:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749594307; x=1750199107;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jeldsOfLIW+0Hr4bYxPOhI4qHvZBHHNPgSq/+bzEbT4=;
        b=NOfy7s8i+SHCr5LnQg5X8Rh0L7URzwpkrqT1qjTl5oplWoXoliaZ21oBrW7hgqm9Zj
         CdYyhS1pK3sjwN/1NkAIAw2/A7Y447xOQB/Jm/bNBnsyrsN2g+I46kBYAcKzddw+s+WT
         kDuu82SvJxBNk9WH55saHXMWTwhoSTK6x7C8OUAkvcRO9geYQZttJstzDTWrSzr4pF8U
         OUL6F8uqu+NrdZSEEuX6hC7c010pb+NF+TbtXJmQiQMHciCKgnwilzXKuCAvPE93YyGR
         iJUElWUXfbAlTYj9caJcD+9le+WxXohGFFEXLrhAiFbZ5U6I0rbf8bUhL84LoIZGFk9z
         leMw==
X-Forwarded-Encrypted: i=1; AJvYcCUsV09daeAE7/oiUPIYO4NN1sqoWExTQC1IZo7U5+KXyh37trlS3uzhsR7sq9JHT/c48kqV28p81ZjVV/PmCaM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9tBcnX9nsC3urtZMithhQT3OUCWzuz3ZQj/q2hrXC/gid+G0K
	iu6C9LKcXPquy6nEVYsELlZ9YNE4V+1xkJaf9Mc4aMbx5v2+HFhVNuAeRC+TcgL8qNxMmoqmvIx
	KVzI0OAdPQdIMn1UbydXpjxBooQz4frwqtmiTD92X60dIhr4YQcLdk0B/pHEJEEtrBnL9WQ==
X-Gm-Gg: ASbGncs2iUjuwAx+H6CaZxY6zJwAcnLylumK5YtD4vuF86P7CAxHSj04uvpaqMx343u
	iojRTYlVrEorHwbGG4VRDPoV4mZYF6mWsA7MiFDWfbTNwcDMCnozxPCLJw3u0XJTPvAJjHlwfSW
	lcwTqKMQW26MOLUT/Dn7uVg9FEwi188YTbev9ri5m6QZEgfYBb6O6u8eGo5QrFI6RkPiMicM7AF
	+tKD1h8tl9EBFcic6NtYHGW0JHgwUZEUhv0IYK5dfE36wsArWrsVPzcc/w5CjeokiUefx6BPyIP
	YtESzahbjjjVjg==
X-Received: by 2002:a05:622a:17cb:b0:477:ea0:1b27 with SMTP id d75a77b69052e-4a713c2b203mr19488511cf.26.1749594306761;
        Tue, 10 Jun 2025 15:25:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEh6veUjTr0aDX8Dk7lxqv8igglcGEC5XvjmK9Q5HpFTvrfcPRBsYoFnhvHMTj0/FgKtwRQ1A==
X-Received: by 2002:a05:622a:17cb:b0:477:ea0:1b27 with SMTP id d75a77b69052e-4a713c2b203mr19488271cf.26.1749594306427;
        Tue, 10 Jun 2025 15:25:06 -0700 (PDT)
Received: from x1.local ([85.131.185.92])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4a619866975sm78374471cf.68.2025.06.10.15.25.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jun 2025 15:25:05 -0700 (PDT)
Date: Tue, 10 Jun 2025 18:25:02 -0400
From: Peter Xu <peterx@redhat.com>
To: Nikita Kalyazin <kalyazin@amazon.com>
Cc: akpm@linux-foundation.org, pbonzini@redhat.com, shuah@kernel.org,
	viro@zeniv.linux.org.uk, brauner@kernel.org, muchun.song@linux.dev,
	hughd@google.com, kvm@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, jack@suse.cz,
	lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com,
	jannh@google.com, ryan.roberts@arm.com, david@redhat.com,
	jthoughton@google.com, graf@amazon.de, jgowans@amazon.com,
	roypat@amazon.co.uk, derekmn@amazon.com, nsaenz@amazon.es,
	xmarcalx@amazon.com
Subject: Re: [PATCH v3 4/6] KVM: guest_memfd: add support for userfaultfd
 minor
Message-ID: <aEiwvi-oqfTiyP3s@x1.local>
References: <20250404154352.23078-1-kalyazin@amazon.com>
 <20250404154352.23078-5-kalyazin@amazon.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250404154352.23078-5-kalyazin@amazon.com>

On Fri, Apr 04, 2025 at 03:43:50PM +0000, Nikita Kalyazin wrote:
> Add support for sending a pagefault event if userfaultfd is registered.
> Only page minor event is currently supported.
> 
> Signed-off-by: Nikita Kalyazin <kalyazin@amazon.com>
> ---
>  virt/kvm/guest_memfd.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
> index fbf89e643add..096d89e7282d 100644
> --- a/virt/kvm/guest_memfd.c
> +++ b/virt/kvm/guest_memfd.c
> @@ -4,6 +4,9 @@
>  #include <linux/kvm_host.h>
>  #include <linux/pagemap.h>
>  #include <linux/anon_inodes.h>
> +#ifdef CONFIG_KVM_PRIVATE_MEM
> +#include <linux/userfaultfd_k.h>
> +#endif /* CONFIG_KVM_PRIVATE_MEM */
>  
>  #include "kvm_mm.h"
>  
> @@ -380,6 +383,13 @@ static vm_fault_t kvm_gmem_fault(struct vm_fault *vmf)
>  		kvm_gmem_mark_prepared(folio);
>  	}
>  
> +	if (userfaultfd_minor(vmf->vma) &&
> +	    !(vmf->flags & FAULT_FLAG_USERFAULT_CONTINUE)) {
> +		folio_unlock(folio);
> +		filemap_invalidate_unlock_shared(inode->i_mapping);
> +		return handle_userfault(vmf, VM_UFFD_MINOR);
> +	}
> +

Hmm, does guest-memfd (when with your current approach) at least needs to
define the new can_userfault() hook?

Meanwhile, we have some hard-coded lines so far, like:

mfill_atomic():
	if (!vma_is_shmem(dst_vma) &&
	    uffd_flags_mode_is(flags, MFILL_ATOMIC_CONTINUE))
		goto out_unlock;

I thought it would fail guest-memfd already on a CONTINUE request, and it
doesn't seem to be touched yet in this series.

I'm not yet sure how the test worked out without hitting things like it.
Highly likely I missed something.  Some explanations would be welcomed.. 

Thanks,

>  	vmf->page = folio_file_page(folio, vmf->pgoff);
>  
>  out_folio:
> -- 
> 2.47.1
> 

-- 
Peter Xu


