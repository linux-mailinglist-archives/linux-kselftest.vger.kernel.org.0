Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDEF46B0C45
	for <lists+linux-kselftest@lfdr.de>; Wed,  8 Mar 2023 16:14:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229462AbjCHPOS (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 8 Mar 2023 10:14:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230132AbjCHPOR (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 8 Mar 2023 10:14:17 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D91F98735B
        for <linux-kselftest@vger.kernel.org>; Wed,  8 Mar 2023 07:13:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678288409;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2BnqD+81nCal2yLTQN92JWzrb8KpwRfcqu8eYT7DAKQ=;
        b=UQ65BcTff3CXdpM9rDjyReRGdioW40y+xXQxoobhoJO+CmAc605SvGbAUPWjFIIFqm5bYd
        2sHhAG8h1g0vuXShX+DRtUFpAd4R1PIMj3VkehG8de6XbFmzr1YQWs2BdWvZ40fSw97DVi
        5Kk91BUNioJsgVx4J+nuWVm2ZvhalO4=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-675-ekSmWxL8NzWG_YMnmCQgww-1; Wed, 08 Mar 2023 10:13:21 -0500
X-MC-Unique: ekSmWxL8NzWG_YMnmCQgww-1
Received: by mail-qk1-f198.google.com with SMTP id d72-20020ae9ef4b000000b0072db6346c39so9520714qkg.16
        for <linux-kselftest@vger.kernel.org>; Wed, 08 Mar 2023 07:13:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678288097;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2BnqD+81nCal2yLTQN92JWzrb8KpwRfcqu8eYT7DAKQ=;
        b=ZH3HrgJoI7V87whSRR+SluCPKMcvp4MvyNUIsqeV5misSrInWyTscuXz6WE0BncJgA
         fUqAASToa0myuDQz++O74ptZxbvFSt5XJ9xPn4EhaWuzi+TSPSGl2Ni9Rp2p7h4RoFlI
         nfTRrNf0tAj6Tf02jF6cqMsnLaALbe2OTuDAL9dpjXb84mcDZHepak44vBSRvcRKbfQX
         hhoHmGJGkXBoMp87YpNEbBEtIT7P9TpwmwmN2Q4S5D5lWCz5yMHKK7YNP43mWKXTiWx5
         bFHUWlHhVUy8/CbmdWKEpgvZmCV1Rx/aomsQkOHliGmXUHRiSbS0F/05eQqhuCRHw+9C
         nI5w==
X-Gm-Message-State: AO0yUKVQ+A7TKM1lenvl2XQuIohF7DMYEReqnuuqIQ3aqzdFiWrX+t3I
        5D2Cz1x8JS/C+rgLxenG9O+DW68bIcEayYm6ExBLinn3yAy/WzcM0BpwgbDPsty9z1py3GTps/f
        mgk6t4tHBHdeFfuC4DFJ2kaN7qM0H
X-Received: by 2002:ac8:5a96:0:b0:3bf:cc1b:9512 with SMTP id c22-20020ac85a96000000b003bfcc1b9512mr5698876qtc.1.1678288097349;
        Wed, 08 Mar 2023 07:08:17 -0800 (PST)
X-Google-Smtp-Source: AK7set90507PYoUM+Jlyh4YHTT3wJEfvvW4+2hu/qzxxuItg/QPKpPxf3VHQA3LvpODkPX3Li/FGXQ==
X-Received: by 2002:ac8:5a96:0:b0:3bf:cc1b:9512 with SMTP id c22-20020ac85a96000000b003bfcc1b9512mr5698828qtc.1.1678288097053;
        Wed, 08 Mar 2023 07:08:17 -0800 (PST)
Received: from x1n (bras-base-aurron9127w-grc-56-70-30-145-63.dsl.bell.ca. [70.30.145.63])
        by smtp.gmail.com with ESMTPSA id b1-20020ac812c1000000b003bfa932525dsm11608784qtj.51.2023.03.08.07.08.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Mar 2023 07:08:16 -0800 (PST)
Date:   Wed, 8 Mar 2023 10:08:15 -0500
From:   Peter Xu <peterx@redhat.com>
To:     Nadav Amit <namit@vmware.com>
Cc:     Axel Rasmussen <axelrasmussen@google.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>, Jan Kara <jack@suse.cz>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Matthew Wilcox <willy@infradead.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@kernel.org>,
        Muchun Song <muchun.song@linux.dev>,
        Shuah Khan <shuah@kernel.org>,
        James Houghton <jthoughton@google.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH v3 2/5] mm: userfaultfd: don't pass around both mm and vma
Message-ID: <ZAik38rpBfa5Ctyg@x1n>
References: <20230306225024.264858-1-axelrasmussen@google.com>
 <20230306225024.264858-3-axelrasmussen@google.com>
 <ZAaNXTXs5ey4QYTl@x1n>
 <54D49E2C-F2EF-4C1E-AFE9-FD742CEA33EB@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <54D49E2C-F2EF-4C1E-AFE9-FD742CEA33EB@vmware.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Mar 07, 2023 at 01:44:05AM +0000, Nadav Amit wrote:
> 
> 
> > On Mar 6, 2023, at 5:03 PM, Peter Xu <peterx@redhat.com> wrote:
> > 
> > !! External Email
> > 
> > On Mon, Mar 06, 2023 at 02:50:21PM -0800, Axel Rasmussen wrote:
> >> Quite a few userfaultfd functions took both mm and vma pointers as
> >> arguments. Since the mm is trivially accessible via vma->vm_mm, there's
> >> no reason to pass both; it just needlessly extends the already long
> >> argument list.
> >> 
> >> Get rid of the mm pointer, where possible, to shorten the argument list.
> >> 
> >> Signed-off-by: Axel Rasmussen <axelrasmussen@google.com>
> > 
> > Acked-by: Peter Xu <peterx@redhat.com>
> > 
> > One nit below:
> > 
> >> @@ -6277,7 +6276,7 @@ int hugetlb_mfill_atomic_pte(struct mm_struct *dst_mm,
> >>              folio_in_pagecache = true;
> >>      }
> >> 
> >> -     ptl = huge_pte_lock(h, dst_mm, dst_pte);
> >> +     ptl = huge_pte_lock(h, dst_vma->vm_mm, dst_pte);
> >> 
> >>      ret = -EIO;
> >>      if (folio_test_hwpoison(folio))
> >> @@ -6319,9 +6318,9 @@ int hugetlb_mfill_atomic_pte(struct mm_struct *dst_mm,
> >>      if (wp_copy)
> >>              _dst_pte = huge_pte_mkuffd_wp(_dst_pte);
> >> 
> >> -     set_huge_pte_at(dst_mm, dst_addr, dst_pte, _dst_pte);
> >> +     set_huge_pte_at(dst_vma->vm_mm, dst_addr, dst_pte, _dst_pte);
> >> 
> >> -     hugetlb_count_add(pages_per_huge_page(h), dst_mm);
> >> +     hugetlb_count_add(pages_per_huge_page(h), dst_vma->vm_mm);
> > 
> > When vm_mm referenced multiple times (say, >=3?), let's still cache it in a
> > temp var?
> > 
> > I'm not sure whether compiler is smart enough to already do that with a
> > reg, even if so it may slightly improve readability too, imho, by avoiding
> > the multiple but same indirection for the reader.
> 
> I am not sure if you referred to this code specifically or in general.

In general.  IIRC there're more than one such case in this patch.

> I once looked into it, and the compiler is really stupid in this regard
> and super conservative when it comes to aliasing. Even if you use
> “restrict” keyword or “__pure” or “__const” function attributes, in
> certain cases (function calls to other compilation units, or inline
> assembly - I don’t remember) the compiler might ignore them. Worse, llvm
> and gcc are inconsistent.
> 
> From code-generated perspective, I did not see a clear cut that benefits
> caching over not. From performance perspective the impact is negligible. I
> mention all of that because I thought it matters too, but it mostly does
> not.
> 
> That’s all to say that in most cases, I think that whatever makes the code
> more readable should be preferred. I think that you are correct in saying
> that “caching” it will make the code more readable, but performance-wise
> it is probably meaningless.

Thanks for the knowledge.  I would suspect no matter how the output layout
of the compilers will be the difference will be small.  I prefer it more
for readability as you said but not strongly either way.

-- 
Peter Xu

