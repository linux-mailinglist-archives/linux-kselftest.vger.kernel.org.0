Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A96C5F63B7
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Oct 2022 11:35:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231479AbiJFJfs (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 6 Oct 2022 05:35:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231409AbiJFJfq (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 6 Oct 2022 05:35:46 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B82CC925BA
        for <linux-kselftest@vger.kernel.org>; Thu,  6 Oct 2022 02:35:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1665048944;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=go40zFr/9iiDvA5R+CukTDIZOFWbDoEwVAldJ/dw7HA=;
        b=XWh202Jg/I6xdfwtwuCNKvDUTahsIPJAnpEUfbvBPBiG8dNChrrKJb0Ps84g/AhEPEfLmU
        t5cHwZSSd0g1Iury2zbtIsKOwEAgnGS9QWSavGVPoVRl+fxhyXe8TRV3vcUNKzXY1wmAbh
        r6Nx3KexQlbB84gXR8HnKJRpTlVMxDo=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-299-73sFcgI8MnmB0mgHV35Plw-1; Thu, 06 Oct 2022 05:35:41 -0400
X-MC-Unique: 73sFcgI8MnmB0mgHV35Plw-1
Received: by mail-wm1-f70.google.com with SMTP id 18-20020a05600c229200b003c1cb5820bbso372011wmf.2
        for <linux-kselftest@vger.kernel.org>; Thu, 06 Oct 2022 02:35:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:organization:from
         :references:cc:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=go40zFr/9iiDvA5R+CukTDIZOFWbDoEwVAldJ/dw7HA=;
        b=oWFNjEqQ6M2exEDzQmAt7JYrzvAMzzTAe34CqHsOCA+rIv4GBd1Kz9Wb2YwLzMN4xr
         q6/zOBX5Wj0WU2l44+85MG5C6S2WpCjVzbFEMKvniCphtQFYWD/ABNVyQh/R2mz87BDS
         +BzuyEewAmzgmfFo5+Bho052VJ7fiP1AGlhn6vjiT/xPRVWOgHEeB2Uao2xfJd8MB1Bp
         SUR1HsJpGx4xd8Pef3UdZ7Bnf4LTqxT403zEdb6yvCluJeBe75tLfDKRoRj8qbdhjTTt
         /1FKgtK1vTIDq1u/58BuY66dbPwlANJsq85k1Bs1nXls0rAtoq7mt4eUNHj7qeGOKaiG
         gtbg==
X-Gm-Message-State: ACrzQf0zla/fiEv7EwN1jbyEv5NRGyP0IRvF23DBrM8TdMkTstvMZVW+
        frbUWtEOZL9uvdSSOEb0oeunlt7bs45Cv+cGLpCegg90Rp+lyLbZdvEvPPuEBFmMNfk31Ly05dm
        KvjbMSdGap0MbxkAnbMz7hPIV1kp0
X-Received: by 2002:adf:f501:0:b0:22c:cbea:240a with SMTP id q1-20020adff501000000b0022ccbea240amr2539245wro.78.1665048940462;
        Thu, 06 Oct 2022 02:35:40 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM6FbNUZUTcpyWNZ14N4SZRoLrItztcXYWPLFvPsaCMZQ09OI7Y6HnjjTpPj6olm9G3I9db3vg==
X-Received: by 2002:adf:f501:0:b0:22c:cbea:240a with SMTP id q1-20020adff501000000b0022ccbea240amr2539227wro.78.1665048940201;
        Thu, 06 Oct 2022 02:35:40 -0700 (PDT)
Received: from ?IPV6:2003:cb:c705:3700:aed2:a0f8:c270:7f30? (p200300cbc7053700aed2a0f8c2707f30.dip0.t-ipconnect.de. [2003:cb:c705:3700:aed2:a0f8:c270:7f30])
        by smtp.gmail.com with ESMTPSA id d10-20020a5d6dca000000b0022917d58603sm17203084wrz.32.2022.10.06.02.35.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Oct 2022 02:35:39 -0700 (PDT)
Message-ID: <274c790a-04c7-078a-19be-851066dc21bb@redhat.com>
Date:   Thu, 6 Oct 2022 11:35:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Content-Language: en-US
To:     Peter Xu <peterx@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>, Hugh Dickins <hughd@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Andrea Arcangeli <aarcange@redhat.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Jason Gunthorpe <jgg@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>
References: <20220930141931.174362-1-david@redhat.com>
 <20220930141931.174362-6-david@redhat.com> <Yz3sIY5Njzda3XSA@x1n>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH v1 5/7] mm/pagewalk: add walk_page_range_vma()
In-Reply-To: <Yz3sIY5Njzda3XSA@x1n>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 05.10.22 22:42, Peter Xu wrote:
> On Fri, Sep 30, 2022 at 04:19:29PM +0200, David Hildenbrand wrote:
>> +int walk_page_range_vma(struct vm_area_struct *vma, unsigned long start,
>> +			unsigned long end, const struct mm_walk_ops *ops,
>> +			void *private)
>> +{
>> +	struct mm_walk walk = {
>> +		.ops		= ops,
>> +		.mm		= vma->vm_mm,
>> +		.vma		= vma,
>> +		.private	= private,
>> +	};
>> +	int err;
>> +
>> +	if (start >= end || !walk.mm)
>> +		return -EINVAL;
>> +	if (start < vma->vm_start || end > vma->vm_end)
>> +		return -EINVAL;
>> +
>> +	mmap_assert_locked(walk.mm);
>> +
>> +	err = walk_page_test(start, end, &walk);
> 
> According to test_walk():
> 
>   * @test_walk:		caller specific callback function to determine whether
>   *			we walk over the current vma or not. Returning 0 means
>   *			"do page table walk over the current vma", returning
>   *			a negative value means "abort current page table walk
>   *			right now" and returning 1 means "skip the current vma"
> 
> Since this helper has vma passed in, not sure whether this is needed at
> all?

I kept it because walk_page_vma() similarly has it -- walk_page_vma() 
walks the whole VMA range.

I do agree that it's kind of weird to have it like that. All users of 
walk_page_vma() don't use it, so we can just get rid of it there as 
well. Might make the walk slightly faster.

> 
> walk_page_vma_range() sounds slightly better to me as it does look more
> like an extension of walk_page_vma(), rather than sister version of
> walk_page_range_novma() (which works for "no backing VMA" case).  But no
> strong opinion.
> 

I matched that to walk_page_range_novma(). Now we have

walk_page_range
walk_page_vma
walk_page_range_novma
walk_page_range_vma


-- 
Thanks,

David / dhildenb

