Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29BD276B96B
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Aug 2023 18:08:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232495AbjHAQIM (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 1 Aug 2023 12:08:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232752AbjHAQIL (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 1 Aug 2023 12:08:11 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0A46FF
        for <linux-kselftest@vger.kernel.org>; Tue,  1 Aug 2023 09:07:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690906047;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=yWOPkGc2VQ+gyDNVe+LM0eiFFyEn/D0a9ZnSdC5vf9I=;
        b=BDUGVodQtVryaNFPBqIQHVHNGSrDaV1qZLRVL3AUx9M48tb1/RLuh/T16BgmKQnW2NlCdz
        CS2VNlaoFD38lPoRWH0idIfyv5lqd2/9y/2BQLMWwM0gi/iZobolsGLohddgJlhzrlciGm
        LH8TnEBZWkzfZMRHnzHGRP74OGVO2wg=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-28-EywGKrlcNmyhsH-sCwaeBA-1; Tue, 01 Aug 2023 12:07:24 -0400
X-MC-Unique: EywGKrlcNmyhsH-sCwaeBA-1
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-76cb9958d60so38541585a.0
        for <linux-kselftest@vger.kernel.org>; Tue, 01 Aug 2023 09:07:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690906044; x=1691510844;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yWOPkGc2VQ+gyDNVe+LM0eiFFyEn/D0a9ZnSdC5vf9I=;
        b=K+U1e/Uqw47Xc8DiSkdr5IEQVMg/q0IcZU1tat7L4FURD0exfi6iasqHzgPyT9qxIv
         zEJdSeg5DclyRbyirN5AoPjMizi/5dwU6tUvB3CFSkjvxsaf+ar59faXuK9h/tGJdq4w
         bbE59mfnkZX9NXskCRUtL8LaHxsl0NmFgjlDu5jnlPgJmQuItP07iuX266goKE6VOW8f
         7esdUcsZuq0GA5yhKaG+D6MtsTOmdfnIM4KKfCQZLw4L1nybwSPI/3R4UXHc65kMoEKW
         eSzK2lmQh8xT9EhTUfRsQgay0z9I7A/C00Bficl1P1gRUKL607QTopN5SjdcjayUlqPH
         ZeUQ==
X-Gm-Message-State: ABy/qLb4hEvC5TPOIu90M5w2C3C1Wju7jj8rxg7bsh1fw7p0E3sLQcKf
        yh2WQdeHiSOAXR/BZ+fi+HFitGxL4RkebbUafcvh/vtk4yn/eHgvvy8GdlXbpUN3G01AZjKUzxj
        m0G4/dPs/YlpoDSO1t6LBy5LQlfMi
X-Received: by 2002:a05:620a:461f:b0:767:170d:887a with SMTP id br31-20020a05620a461f00b00767170d887amr11729620qkb.2.1690906043921;
        Tue, 01 Aug 2023 09:07:23 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHqB7mU+Qbt0x6u8wDG4VYEiiNsMIxzWprLKmcc5Zc3mCLE/Anc8W8CylOrTkOpU586dh/Caw==
X-Received: by 2002:a05:620a:461f:b0:767:170d:887a with SMTP id br31-20020a05620a461f00b00767170d887amr11729595qkb.2.1690906043654;
        Tue, 01 Aug 2023 09:07:23 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com. [99.254.144.39])
        by smtp.gmail.com with ESMTPSA id z5-20020a05620a100500b00767cf5d3faasm4237042qkj.86.2023.08.01.09.07.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Aug 2023 09:07:23 -0700 (PDT)
Date:   Tue, 1 Aug 2023 12:07:20 -0400
From:   Peter Xu <peterx@redhat.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, kvm@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        liubo <liubo254@huawei.com>,
        Matthew Wilcox <willy@infradead.org>,
        Hugh Dickins <hughd@google.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        John Hubbard <jhubbard@nvidia.com>,
        Mel Gorman <mgorman@suse.de>, Shuah Khan <shuah@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v2 6/8] mm/huge_memory: remove stale NUMA hinting comment
 from follow_trans_huge_pmd()
Message-ID: <ZMktuATuYhHdAW6M@x1n>
References: <20230801124844.278698-1-david@redhat.com>
 <20230801124844.278698-7-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230801124844.278698-7-david@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Aug 01, 2023 at 02:48:42PM +0200, David Hildenbrand wrote:
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index 2cd3e5502180..0b709d2c46c6 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -1467,7 +1467,6 @@ struct page *follow_trans_huge_pmd(struct vm_area_struct *vma,
>  	if ((flags & FOLL_DUMP) && is_huge_zero_pmd(*pmd))
>  		return ERR_PTR(-EFAULT);
>  
> -	/* Full NUMA hinting faults to serialise migration in fault paths */
>  	if (pmd_protnone(*pmd) && !gup_can_follow_protnone(vma, flags))
>  		return NULL;

Perhaps squashing into patch 1?  Thanks,

-- 
Peter Xu

