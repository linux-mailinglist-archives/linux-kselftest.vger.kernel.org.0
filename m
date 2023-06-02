Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F4F27207EB
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 Jun 2023 18:48:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236880AbjFBQsY (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 2 Jun 2023 12:48:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236866AbjFBQsW (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 2 Jun 2023 12:48:22 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35C9A1AB
        for <linux-kselftest@vger.kernel.org>; Fri,  2 Jun 2023 09:47:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685724454;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Dm8pZyID0DwwOZmALxTgNoRgAXLQPRwJQSjRfV59sYQ=;
        b=RYVWbkOqHAT5FLqLHpJpgXMWm6VrZ4kIqqzpL86IxeGQozPvZsoKvWVZbgofruKsdqhh+p
        txSdllpLzDjpErJbkxxYs0XFxf4hM8NAe2tzzG6OFtZGq7SqpaPwPK9WrtOHDSddsFYxoL
        RuaxtikXXXslhiaiVUWtu+gO7NctjT0=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-22-HSjGGqvwPFmFubVPd5gRbw-1; Fri, 02 Jun 2023 12:47:32 -0400
X-MC-Unique: HSjGGqvwPFmFubVPd5gRbw-1
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-62849c5e9f0so2445476d6.1
        for <linux-kselftest@vger.kernel.org>; Fri, 02 Jun 2023 09:47:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685724452; x=1688316452;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Dm8pZyID0DwwOZmALxTgNoRgAXLQPRwJQSjRfV59sYQ=;
        b=C/b7KURPu8xdW54f/o8xCR/mNfb1+dy3WjAvrAWMSeORKNdyeoF9fBMIvq0xWQycyD
         4vAyfcR9Oks/mIAUWrG6Yx57QIaIhPXbgzBOKqoMW9CA/8DcRtzzP2rIDcwgEWCJBgxt
         NwuPh7wg8SWVfxSFfRUh3pFemE8U8ZA71WhL5W807YT54uPlJ9adDVLFlcRediJs3mm2
         I0vboQIf7TnyrKMSuuaxjIdGkgKiB7QjJWRJvDkwsC7eEAx8AKZCPjyKqoyLdRQzIh9s
         tXBujA4QMf7KIW7GbW46sVG2EYeBFTm2Kw6wQw8H2zNfQBQXX3Bg4KHEvDPylYLlsvhR
         mXXw==
X-Gm-Message-State: AC+VfDyqM+s+j4dmVuUtY+JrUYxuRpAEOufJ8UxX7PtLWFvywAz0sUjE
        zyRfLULld9ilZHTau3Swv/5/txp4jwqN9T8LRiCfQm8qn9dFMDVCRcTQC53+2sVZnoiwnQJqk1B
        SU2HBSC/+IhFnwBHZBRQ6trNWxRmY
X-Received: by 2002:a05:6214:5014:b0:628:7a68:2642 with SMTP id jo20-20020a056214501400b006287a682642mr3689013qvb.3.1685724452236;
        Fri, 02 Jun 2023 09:47:32 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ54KeNLZV0UMqQZP4PlWtn06PwaLBFJmlpLuCSXJewKcqJipYhNs9jEzcrf2f96OkjZJioGrw==
X-Received: by 2002:a05:6214:5014:b0:628:7a68:2642 with SMTP id jo20-20020a056214501400b006287a682642mr3688973qvb.3.1685724451847;
        Fri, 02 Jun 2023 09:47:31 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com. [99.254.144.39])
        by smtp.gmail.com with ESMTPSA id mx11-20020a0562142e0b00b005fe4a301350sm1027353qvb.48.2023.06.02.09.47.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jun 2023 09:47:31 -0700 (PDT)
Date:   Fri, 2 Jun 2023 12:47:28 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc:     David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        =?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <emmir@google.com>,
        Andrei Vagin <avagin@gmail.com>,
        Danylo Mocherniuk <mdanylo@google.com>,
        Paul Gofman <pgofman@codeweavers.com>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Mike Rapoport <rppt@kernel.org>, Nadav Amit <namit@vmware.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Shuah Khan <shuah@kernel.org>,
        Christian Brauner <brauner@kernel.org>,
        Yang Shi <shy828301@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Yun Zhou <yun.zhou@windriver.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Alex Sierra <alex.sierra@amd.com>,
        Matthew Wilcox <willy@infradead.org>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        Greg KH <gregkh@linuxfoundation.org>, kernel@collabora.com
Subject: Re: [PATCH v16 2/5] fs/proc/task_mmu: Implement IOCTL to get and
 optionally clear info about PTEs
Message-ID: <ZHodIFQesrCA53To@x1n>
References: <20230525085517.281529-1-usama.anjum@collabora.com>
 <20230525085517.281529-3-usama.anjum@collabora.com>
 <ZHfAOAKj1ZQJ+zSy@x1n>
 <aeaaa33e-4d23-fd3a-1357-4751007aa3bd@collabora.com>
 <ZHj7jmJ5fKla1Rax@x1n>
 <3589803d-5594-71de-d078-ad4499f233b6@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3589803d-5594-71de-d078-ad4499f233b6@collabora.com>
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Jun 02, 2023 at 04:18:38PM +0500, Muhammad Usama Anjum wrote:
> On 6/2/23 1:11 AM, Peter Xu wrote:
> > On Thu, Jun 01, 2023 at 01:16:14PM +0500, Muhammad Usama Anjum wrote:
> >> On 6/1/23 2:46 AM, Peter Xu wrote:
> >>> Muhammad,
> >>>
> >>> Sorry, I probably can only review the non-interface part, and leave the
> >>> interface/buffer handling, etc. review for others and real potential users
> >>> of it..
> >> Thank you so much for the review. I think mostly we should be okay with
> >> interface as everybody has been making suggestions over the past revisions.
> >>
> >>>
> >>> On Thu, May 25, 2023 at 01:55:14PM +0500, Muhammad Usama Anjum wrote:
> >>>> +static inline void make_uffd_wp_huge_pte(struct vm_area_struct *vma,
> >>>> +					 unsigned long addr, pte_t *ptep,
> >>>> +					 pte_t ptent)
> >>>> +{
> >>>> +	pte_t old_pte;
> >>>> +
> >>>> +	if (!huge_pte_none(ptent)) {
> >>>> +		old_pte = huge_ptep_modify_prot_start(vma, addr, ptep);
> >>>> +		ptent = huge_pte_mkuffd_wp(old_pte);
> >>>> +		ptep_modify_prot_commit(vma, addr, ptep, old_pte, ptent);
> >>>
> >>> huge_ptep_modify_prot_start()?
> >> Sorry, I didn't realized that huge_ptep_modify_prot_start() is different
> >> from its pte version.
> > 
> > Here I meant huge_ptep_modify_prot_commit()..
> I'll update.
> 
> > 
> >>
> >>>
> >>> The other thing is what if it's a pte marker already?  What if a hugetlb
> >>> migration entry?  Please check hugetlb_change_protection().
> >> I've updated it in more better way. Please let me know what do you think
> >> about the following:
> >>
> >> static inline void make_uffd_wp_huge_pte(struct vm_area_struct *vma,
> >> 					 unsigned long addr, pte_t *ptep,
> >> 					 pte_t ptent)
> >> {
> >> 	if (is_hugetlb_entry_hwpoisoned(ptent) || is_pte_marker(ptent))
> >> 		return;
> >>
> >> 	if (is_hugetlb_entry_migration(ptent))
> >> 		set_huge_pte_at(vma->vm_mm, addr, ptep,
> >> 				pte_swp_mkuffd_wp(ptent));
> >> 	else if (!huge_pte_none(ptent))
> >> 		ptep_modify_prot_commit(vma, addr, ptep, ptent,
> >> 					huge_pte_mkuffd_wp(ptent));
> >> 	else
> >> 		set_huge_pte_at(vma->vm_mm, addr, ptep,
> >> 				make_pte_marker(PTE_MARKER_UFFD_WP));
> >> }
> > 
> > the is_pte_marker() check can be extended to double check
> > pte_marker_uffd_wp() bit, but shouldn't matter a lot since besides the
> > uffd-wp bit currently we only support swapin error which should sigbus when
> > accessed, so no point in tracking anyway.
> Yeah, we are good with what we have as even if more bits are supported in
> pte markers, this function is only reached when UNPOPULATED + ASYNC WP are
> enabled. So no other bit would be set on the marker.

I think we don't know?  swapin error bit can be set there afaiu, if someone
swapoff -a and found a swap device broken for some swapped out ptes.

But again I think that's fine for now.

> 
> > 
> >>
> >> As we always set UNPOPULATED, so markers are always set on none ptes
> >> initially. Is it possible that a none pte becomes present, then swapped and
> >> finally none again? So I'll do the following addition for make_uffd_wp_pte():
> >>
> >> --- a/fs/proc/task_mmu.c
> >> +++ b/fs/proc/task_mmu.c
> >> @@ -1800,6 +1800,9 @@ static inline void make_uffd_wp_pte(struct
> >> vm_area_struct *vma,
> >>  	} else if (is_swap_pte(ptent)) {
> >>  		ptent = pte_swp_mkuffd_wp(ptent);
> >>  		set_pte_at(vma->vm_mm, addr, pte, ptent);
> >> +	} else {
> >> +		set_pte_at(vma->vm_mm, addr, pte,
> >> +			   make_pte_marker(PTE_MARKER_UFFD_WP));
> >>  	}
> >>  }
> > 
> > Makes sense, you can leverage userfaultfd_wp_use_markers() here, and you
> > should probably keep the protocol (only set the marker when WP_UNPOPULATED
> > for anon).
> This function is only reachable when UNPOPULATED + Async WP are set. So we
> don't need to use userfaultfd_wp_use_markers().

I don't remember where you explicitly checked that to make sure it'll
always be the case, but if you do it'll still be nice if you can add a
comment right above here explaining.

Or, maybe you can still use userfaultfd_wp_use_markers() here, then you can
just WARN_ON_ONCE() on it, which looks even better?

[...]

> > Hmm, is it a bug for pagemap?  pagemapread.buffer should be linear to the
> > address range to be scanned to me.  If it skips some unstable pmd without
> > filling in anything it seems everything later will be shifted with
> > PMD_SIZE..  I had a feeling that it should set walk->action==ACTION_AGAIN
> > before return.
> I don't think this is a bug if this is how it was implemented in the first
> place. In this task_mmu.c file, we can find several examples of the same
> pattern that error isn't returned if pmd_trans_unstable() succeeds.

I don't see why multiple same usages mean it's correct.. maybe they're all
buggy?

I can post a patch for this to collect opinions to see if I missed
something. I'd suggest you figure out what's the right thing to do for the
new interface and make it right from the start, no matter how it was
implemented elsewhere.

Thanks,

-- 
Peter Xu

