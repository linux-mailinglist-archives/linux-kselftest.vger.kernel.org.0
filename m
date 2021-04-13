Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1595C35E786
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 Apr 2021 22:18:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348182AbhDMUSQ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 13 Apr 2021 16:18:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:33545 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238206AbhDMUSQ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 13 Apr 2021 16:18:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1618345075;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=F+gpcGbjpJnW75HsT83fn38nMLIN2HNyr9uneAl6PwM=;
        b=PFTzUEe7naAwv1tg/lw2jI+nZ29tD1Qv8kH/WNLzROftHVzCaQM3n/mg8j+3B3oIfJTiSH
        4tC9Ys090lFi25UN6GBpeuiqKIS+J0IyWbzKPraFlRb7/hJpaRGyxofSNGOn90AcI5SEov
        vhKGnGGXgqRPWYEykvJpx2teM8wBRyk=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-391-NLNomHI0N3KAvru7fmf1Rw-1; Tue, 13 Apr 2021 16:17:53 -0400
X-MC-Unique: NLNomHI0N3KAvru7fmf1Rw-1
Received: by mail-qv1-f71.google.com with SMTP id w12so1197592qvp.8
        for <linux-kselftest@vger.kernel.org>; Tue, 13 Apr 2021 13:17:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=F+gpcGbjpJnW75HsT83fn38nMLIN2HNyr9uneAl6PwM=;
        b=cl18eK9870jVdbZXZha9kdUWngGJqylVMgOzl8JlvSlWdvARf9t2gR+HptMA80SzNe
         zYi9woMkpIMK8sIvhm70fpBnaBWgbqv2t7L1MVhCPd8+AxlWAOxl3dUU4xUJs1TJ6n7d
         48fZ7kAGRxJQEFrSeICkYDu0ZOPIFw7hUj7mDbeHlW+SML8wWJJJO4cJUBm+ONpLJAn2
         7Q+rYm5u+UniPsYJOVTzU1E+MSFoQzfVtu7WsUqnSJUDnl4K8fv+QHobDN8UPE9amH0W
         89WWKyT+mDfEPHI4s9rajBQgAl1Khj8bT48tY9XBGXiqmru9DfEuneE2wQsZWaJ4szaZ
         u3Sw==
X-Gm-Message-State: AOAM530VQ9NNEUqXm8AbFrLF2SLoJ/DR3aoerJd9dl6MVgyqWFdSO/TZ
        ApojXttkQ7P/fOGPnlmYvXzxmQMhNU52yMR9MIBQHu9jAljaZrmBTngSR17TG9bQtntsIf60EPs
        2KSUkqnkiu3MRz/opVZVQzcVYQtW5
X-Received: by 2002:ac8:7fcd:: with SMTP id b13mr31785943qtk.68.1618345072905;
        Tue, 13 Apr 2021 13:17:52 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzm8QhI4YsPfqqtubp6A3TgshHmvxjOKTuerTRIoNikR75RHHmVPZbkbKxWJoODRS6zRKCi6Q==
X-Received: by 2002:ac8:7fcd:: with SMTP id b13mr31785923qtk.68.1618345072692;
        Tue, 13 Apr 2021 13:17:52 -0700 (PDT)
Received: from xz-x1 (bras-base-toroon474qw-grc-88-174-93-75-154.dsl.bell.ca. [174.93.75.154])
        by smtp.gmail.com with ESMTPSA id q67sm8814016qkb.89.2021.04.13.13.17.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Apr 2021 13:17:52 -0700 (PDT)
Date:   Tue, 13 Apr 2021 16:17:50 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Axel Rasmussen <axelrasmussen@google.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        Jerome Glisse <jglisse@redhat.com>,
        Joe Perches <joe@perches.com>,
        Lokesh Gidra <lokeshgidra@google.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Shaohua Li <shli@fb.com>, Shuah Khan <shuah@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Wang Qing <wangqing@vivo.com>, linux-api@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
        Brian Geffon <bgeffon@google.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        Mina Almasry <almasrymina@google.com>,
        Oliver Upton <oupton@google.com>
Subject: Re: [PATCH v2 6/9] userfaultfd/selftests: create alias mappings in
 the shmem test
Message-ID: <20210413201750.GF4440@xz-x1>
References: <20210413051721.2896915-1-axelrasmussen@google.com>
 <20210413051721.2896915-7-axelrasmussen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210413051721.2896915-7-axelrasmussen@google.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Apr 12, 2021 at 10:17:18PM -0700, Axel Rasmussen wrote:
>  static void shmem_allocate_area(void **alloc_area)
>  {
> -	unsigned long offset =
> -		alloc_area == (void **)&area_src ? 0 : nr_pages * page_size;
> +	void *area_alias = NULL;
> +	bool is_src = alloc_area == (void **)&area_src;
> +	unsigned long offset = is_src ? 0 : nr_pages * page_size;
>  
>  	*alloc_area = mmap(NULL, nr_pages * page_size, PROT_READ | PROT_WRITE,
>  			   MAP_SHARED, shm_fd, offset);
>  	if (*alloc_area == MAP_FAILED)
>  		err("mmap of memfd failed");
> +
> +	area_alias = mmap(NULL, nr_pages * page_size, PROT_READ | PROT_WRITE,
> +			  MAP_SHARED, shm_fd, offset);
> +	if (area_alias == MAP_FAILED)
> +		err("mmap of memfd alias failed");
> +
> +	if (is_src)
> +		area_src_alias = area_alias;
> +	else
> +		area_dst_alias = area_alias;
> +}

It would be nice if shmem_allocate_area() could merge with
hugetlb_allocate_area() somehow, but not that urgent.

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu

