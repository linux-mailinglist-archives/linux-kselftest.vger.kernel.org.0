Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D16158AB90
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Aug 2022 15:26:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240820AbiHEN0L (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 5 Aug 2022 09:26:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240757AbiHEN0K (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 5 Aug 2022 09:26:10 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2298625C5F
        for <linux-kselftest@vger.kernel.org>; Fri,  5 Aug 2022 06:26:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1659705968;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mJBXhzmt1GniFe2smeou8x6jmkkaotxI6ROvs4HpGEk=;
        b=bpkEz2iOjvmYkH6VqnaDfNHgqGT0ELkwEQZ5jkL78af+dgRHHpcOoV2AW8YnkXOv88YBxe
        pow/GbzO5yzeeGp0L+WWtlFxnAPz5tYfNIF5Zj0kRdan0EV2SfzYBgl1LHxlv+mF8DOQFj
        5xAP6JdktNElst8eIPeD5hyZxMDL9xA=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-567-b8mrfW6RMUC0NGIKEBJXow-1; Fri, 05 Aug 2022 09:26:07 -0400
X-MC-Unique: b8mrfW6RMUC0NGIKEBJXow-1
Received: by mail-wm1-f71.google.com with SMTP id d10-20020a05600c34ca00b003a4f0932ec3so4225373wmq.0
        for <linux-kselftest@vger.kernel.org>; Fri, 05 Aug 2022 06:26:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc;
        bh=mJBXhzmt1GniFe2smeou8x6jmkkaotxI6ROvs4HpGEk=;
        b=sQ0MdSkTI9hCnyfhravMsvAHU0nnJ96QTMmCvtUqrtnwmHpgJrbr5oAZWF007Q4EZw
         ahgl7VdbjE4AM3whZLVHmQ4kH1BiU8oJ9jLvLSMtvp9/0RjNCJJ9P9jOfU2XHos7sniw
         8Njsoo9CZqoyqX3DKlTAqrXkk4rr/LLL4giSqIBR/xUXGCBF1g5H4g1UdQLVZPZiDXZs
         S8+2YGBc+Jc4IkakLDg/SZi6VGICfgo+3wsDPq9gwlj8Lsk6gOubgrbEv+5eO34x/ZMM
         pAU3mQ44On32fF09S/PSGabOXrVs9NFjBvefFEIZGYmGJ9fhKkVMBJ2EZJkqdhnOkupb
         5P7g==
X-Gm-Message-State: ACgBeo2GjFkv5Ac8YSSMfdBWTHqQ/G051Ch5N6xAlepL+kR4n4PNcDIW
        Tn1LkgARxJtJfF+nU9f8kdosIEigGwzehpJnXH2pbJbLLkAiDl/twHhPZT0//rufGS7fy/PSmAk
        dpkAI6BXR5rIshVjRza0jxnmi43Fj
X-Received: by 2002:a5d:588f:0:b0:220:761a:6894 with SMTP id n15-20020a5d588f000000b00220761a6894mr4409182wrf.406.1659705965747;
        Fri, 05 Aug 2022 06:26:05 -0700 (PDT)
X-Google-Smtp-Source: AA6agR6ajxOjPYt9fURAvT4aPqpXXmNPivXi3/PkheqDod4RApDXYAPhtZxZHk1xvMFDF/irKdR08g==
X-Received: by 2002:a5d:588f:0:b0:220:761a:6894 with SMTP id n15-20020a5d588f000000b00220761a6894mr4409161wrf.406.1659705965445;
        Fri, 05 Aug 2022 06:26:05 -0700 (PDT)
Received: from ?IPV6:2003:cb:c706:fb00:f5c3:24b2:3d03:9d52? (p200300cbc706fb00f5c324b23d039d52.dip0.t-ipconnect.de. [2003:cb:c706:fb00:f5c3:24b2:3d03:9d52])
        by smtp.gmail.com with ESMTPSA id o6-20020a05600c4fc600b003a32490c95dsm9887725wmq.35.2022.08.05.06.26.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Aug 2022 06:26:05 -0700 (PDT)
Message-ID: <a34d88b9-a4b9-cb9e-91d9-c5a89449fcd5@redhat.com>
Date:   Fri, 5 Aug 2022 15:26:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v7 04/14] mm/shmem: Support memfile_notifier
Content-Language: en-US
To:     Chao Peng <chao.p.peng@linux.intel.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-doc@vger.kernel.org, qemu-devel@nongnu.org,
        linux-kselftest@vger.kernel.org
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>,
        Hugh Dickins <hughd@google.com>,
        Jeff Layton <jlayton@kernel.org>,
        "J . Bruce Fields" <bfields@fieldses.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>, Mike Rapoport <rppt@kernel.org>,
        Steven Price <steven.price@arm.com>,
        "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
        Vlastimil Babka <vbabka@suse.cz>,
        Vishal Annapurve <vannapurve@google.com>,
        Yu Zhang <yu.c.zhang@linux.intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        luto@kernel.org, jun.nakajima@intel.com, dave.hansen@intel.com,
        ak@linux.intel.com, aarcange@redhat.com, ddutile@redhat.com,
        dhildenb@redhat.com, Quentin Perret <qperret@google.com>,
        Michael Roth <michael.roth@amd.com>, mhocko@suse.com,
        Muchun Song <songmuchun@bytedance.com>
References: <20220706082016.2603916-1-chao.p.peng@linux.intel.com>
 <20220706082016.2603916-5-chao.p.peng@linux.intel.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20220706082016.2603916-5-chao.p.peng@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 06.07.22 10:20, Chao Peng wrote:
> From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
> 
> Implement shmem as a memfile_notifier backing store. Essentially it
> interacts with the memfile_notifier feature flags for userspace
> access/page migration/page reclaiming and implements the necessary
> memfile_backing_store callbacks.
> 
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Signed-off-by: Chao Peng <chao.p.peng@linux.intel.com>
> ---

[...]

> +#ifdef CONFIG_MEMFILE_NOTIFIER
> +static struct memfile_node *shmem_lookup_memfile_node(struct file *file)
> +{
> +	struct inode *inode = file_inode(file);
> +
> +	if (!shmem_mapping(inode->i_mapping))
> +		return NULL;
> +
> +	return  &SHMEM_I(inode)->memfile_node;
> +}
> +
> +
> +static int shmem_get_pfn(struct file *file, pgoff_t offset, pfn_t *pfn,
> +			 int *order)
> +{
> +	struct page *page;
> +	int ret;
> +
> +	ret = shmem_getpage(file_inode(file), offset, &page, SGP_WRITE);
> +	if (ret)
> +		return ret;
> +
> +	unlock_page(page);
> +	*pfn = page_to_pfn_t(page);
> +	*order = thp_order(compound_head(page));
> +	return 0;
> +}
> +
> +static void shmem_put_pfn(pfn_t pfn)
> +{
> +	struct page *page = pfn_t_to_page(pfn);
> +
> +	if (!page)
> +		return;
> +
> +	put_page(page);


Why do we export shmem_get_pfn/shmem_put_pfn and not simply

get_folio()

and let the caller deal with putting the folio? What's the reason to

a) Operate on PFNs and not folios
b) Have these get/put semantics?

> +}
> +
> +static struct memfile_backing_store shmem_backing_store = {
> +	.lookup_memfile_node = shmem_lookup_memfile_node,
> +	.get_pfn = shmem_get_pfn,
> +	.put_pfn = shmem_put_pfn,
> +};
> +#endif /* CONFIG_MEMFILE_NOTIFIER */
> +
>  void __init shmem_init(void)
>  {
>  	int error;
> @@ -3956,6 +4059,10 @@ void __init shmem_init(void)
>  	else
>  		shmem_huge = SHMEM_HUGE_NEVER; /* just in case it was patched */
>  #endif
> +
> +#ifdef CONFIG_MEMFILE_NOTIFIER
> +	memfile_register_backing_store(&shmem_backing_store);

Can we instead prove a dummy function that does nothing without
CONFIG_MEMFILE_NOTIFIER?

> +#endif
>  	return;
>  
>  out1:


-- 
Thanks,

David / dhildenb

