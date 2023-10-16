Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D28417CB31A
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Oct 2023 21:02:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232934AbjJPTCx (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 16 Oct 2023 15:02:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232682AbjJPTCw (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 16 Oct 2023 15:02:52 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD221ED
        for <linux-kselftest@vger.kernel.org>; Mon, 16 Oct 2023 12:02:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1697482920;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tDzZCyb92Saip8aINQgR+oW9LAyO1JS7tLsuKgtSvHQ=;
        b=P1Wf7ZtoydmhBUgddJUfjh/eH/VNRLVuzybm+HwDO5CASrHL+Tf9BT2tbwHUuK+ohOIsVt
        DiRn+BDu94IdkUtCgOZlQ1E9mIPu2O51MrhRU0XXvt2b/6GrLVCTOkwuVkQt4XicDRrMMm
        qbUD/M7S/hGwoXeTz/IislDh4WkGSwM=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-113-S4zSTTZCPgmj4opM_OEQwg-1; Mon, 16 Oct 2023 15:01:52 -0400
X-MC-Unique: S4zSTTZCPgmj4opM_OEQwg-1
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-66cfa898cfeso9347866d6.0
        for <linux-kselftest@vger.kernel.org>; Mon, 16 Oct 2023 12:01:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697482912; x=1698087712;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tDzZCyb92Saip8aINQgR+oW9LAyO1JS7tLsuKgtSvHQ=;
        b=dYV2GuBZ/ofRSZmidDBeJZ3hGFPaB++HHso98+seiyemz26rL59wDGJ1WlLZ/H9UJ0
         NuAPr5o3x+CFpR9P66fgjEAVIIrlllETylaVm2ypTbERs5M04jJ7bEAvHNmysu/SILkY
         nCYoS0IWi3EMRYePciANA1gtnCCQujyEU3/M+Wmx6VnE6JTksbWL+wXbLkfkReltuy4L
         nBOsyKl7M4o2Y9GBRsWWekfYc3NKoIZbmrvPyCBLPzCYQGhaFfPjeW+fO02XBB6B8avW
         bir1rhIzZLD9tmc9hcZbDkD+eVJDTbxM/SoJKedgzLjsGcOV9WG6en4GIFG9ULJSfdGN
         /d8Q==
X-Gm-Message-State: AOJu0YwN3V9zQLvOWiEQ3HUZv6kge9iznGoCpLtgbGRKlL8/n7dnTf/t
        zslEW70/43LxbP/bHM30RbTZ00oQN0wXZ+Y7vp8aguszQ/UyucW+9Vup3kZ0oaSdQ2ox2647mqf
        sf4zvGulBFqnxqq0oNzOMqFufbLCg
X-Received: by 2002:a05:6214:4402:b0:66d:169a:a661 with SMTP id oj2-20020a056214440200b0066d169aa661mr280941qvb.4.1697482912163;
        Mon, 16 Oct 2023 12:01:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGaSTLfXG0qgNCf1woM/gq5yVis4/qLO5+vxP1c9wS8gvcjoEODN84qOJVNpOc27zPjV8adqQ==
X-Received: by 2002:a05:6214:4402:b0:66d:169a:a661 with SMTP id oj2-20020a056214440200b0066d169aa661mr280918qvb.4.1697482911788;
        Mon, 16 Oct 2023 12:01:51 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com. [99.254.144.39])
        by smtp.gmail.com with ESMTPSA id y19-20020a0cd993000000b0066cfd398ab5sm3594296qvj.146.2023.10.16.12.01.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Oct 2023 12:01:51 -0700 (PDT)
Date:   Mon, 16 Oct 2023 15:01:32 -0400
From:   Peter Xu <peterx@redhat.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     Lokesh Gidra <lokeshgidra@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        akpm@linux-foundation.org, viro@zeniv.linux.org.uk,
        brauner@kernel.org, shuah@kernel.org, aarcange@redhat.com,
        hughd@google.com, mhocko@suse.com, axelrasmussen@google.com,
        rppt@kernel.org, willy@infradead.org, Liam.Howlett@oracle.com,
        jannh@google.com, zhangpeng362@huawei.com, bgeffon@google.com,
        kaleshsingh@google.com, ngeoffray@google.com, jdduke@google.com,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        kernel-team@android.com
Subject: Re: [PATCH v3 2/3] userfaultfd: UFFDIO_MOVE uABI
Message-ID: <ZS2IjEP479WtVdMi@x1n>
References: <20231009064230.2952396-1-surenb@google.com>
 <20231009064230.2952396-3-surenb@google.com>
 <214b78ed-3842-5ba1-fa9c-9fa719fca129@redhat.com>
 <CAJuCfpHzSm+z9b6uxyYFeqr5b5=6LehE9O0g192DZdJnZqmQEw@mail.gmail.com>
 <478697aa-f55c-375a-6888-3abb343c6d9d@redhat.com>
 <CA+EESO5nvzka0KzFGzdGgiCWPLg7XD-8jA9=NTUOKFy-56orUg@mail.gmail.com>
 <ZShS3UT+cjJFmtEy@x1n>
 <205abf01-9699-ff1c-3e4e-621913ada64e@redhat.com>
 <ZSlragGjFEw9QS1Y@x1n>
 <12588295-2616-eb11-43d2-96a3c62bd181@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <12588295-2616-eb11-43d2-96a3c62bd181@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

David,

On Mon, Oct 16, 2023 at 08:01:10PM +0200, David Hildenbrand wrote:
> [...]
> 
> > > > Actually, even though I have no solid clue, but I had a feeling that there
> > > > can be some interesting way to leverage this across-mm movement, while
> > > > keeping things all safe (by e.g. elaborately requiring other proc to create
> > > > uffd and deliver to this proc).
> > > 
> > > Okay, but no real use cases yet.
> > 
> > I can provide a "not solid" example.  I didn't mention it because it's
> > really something that just popped into my mind when thinking cross-mm, so I
> > never discussed with anyone yet nor shared it anywhere.
> > 
> > Consider VM live upgrade in a generic form (e.g., no VFIO), we can do that
> > very efficiently with shmem or hugetlbfs, but not yet anonymous.  We can do
> > extremely efficient postcopy live upgrade now with anonymous if with REMAP.
> > 
> > Basically I see it a potential way of moving memory efficiently especially
> > with thp.
> 
> It's an interesting use case indeed. The questions would be if this is (a) a
> use case we want to support; (b) why we need to make that decision now and
> add that feature.

I would like to support that if nothing stops it from happening, but that's
what we're discussing though..

For (b), I wanted to avoid UFFD_FEATURE_MOVE_CROSS_MM feature flag just for
this, if they're already so close, not to mention current code already
contains cross-mm support.

If to support that live upgrade use case, I'd probably need to rework tlb
flushing too to do the batching (actually tlb flush is not even needed for
upgrade scenario..).  I'm not sure whether Lokesh's use case would move
large chunks, it'll be perfect if Suren did it altogether.  But that one is
much easier if transparent to userapps.  Cross-mm is not transparent and
need another feature knob, which I want to avoid if possible.

> 
> One question is if this kind of "moving memory between processes" really
> should be done, because intuitively SHMEM smells like the right thing to use
> here (two processes wanting to access the same memory).

That's the whole point, IMHO, where shmem cannot be used.  As you said, on
when someone cannot use file memory for some reason like ksm.

> 
> The downsides of shmem are lack of the shared zeropage and KSM. The shared
> zeropage is usually less of a concern for VMs, but KSM is. However, KSM will
> also disallow moving pages here. But all non-deduplicated ones could be
> moved.
> 
> [I wondered whether moving KSM pages (rmap items) could be done; probably in
> some limited form with some more added complexity]

Yeah we can leave that complexity for later when really needed.  Here
cross-mm support, OTOH, isn't making it so complicated, IMHO.

Btw, we don't even necessarily need to be able to migrate KSM pages for a
VM live upgrade use case: we can unmerge the pages, upgrade, and wait for
KSM to scan & merge again on the new binary / mmap.  Userspace can have
that control easily, afaiu, via existing madvise().

> 
> > 
> > > 
> > > > 
> > > > Considering Andrea's original version already contains those bits and all
> > > > above, I'd vote that we go ahead with supporting two MMs.
> > > 
> > > You can do nasty things with that, as it stands, on the upstream codebase.
> > > 
> > > If you pin the page in src_mm and move it to dst_mm, you successfully broke
> > > an invariant that "exclusive" means "no other references from other
> > > processes". That page is marked exclusive but it is, in fact, not exclusive.
> > 
> > It is still exclusive to the dst mm?  I see your point, but I think you're
> > taking exclusiveness altogether with pinning, and IMHO that may not be
> > always necessary?
> 
> That's the definition of PAE. See do_wp_page() on when we reset PAE: when
> there are no other references, which implies no other references from other
> processes. Maybe you have "currently exclusively mapped" in mind, which is
> what the mapcount can be used for.

Okay.

> 
> > 
> > > 
> > > Once you achieved that, you can easily have src_mm not have MMF_HAS_PINNED,
> > 
> > (I suppose you meant dst_mm here)
> 
> Yes.
> 
> > 
> > > so you can just COW-share that page. Now you successfully broke the
> > > invariant that COW-shared pages must not be pinned. And you can even trigger
> > > VM_BUG_ONs, like in sanity_check_pinned_pages().
> > 
> > Yeah, that's really unfortunate.  But frankly, I don't think it's the fault
> > of this new feature, but the rest.
> > 
> > Let's imagine if the MMF_HAS_PINNED wasn't proposed as a per-mm flag, but
> > per-vma, which I don't see why we can't because it's simply a hint so far.
> > Then if we apply the same rule here, UFFDIO_REMAP won't even work for
> > single-mm as long as cross-vma. Then UFFDIO_REMAP as a whole feature will
> > be NACKed simply because of this..
> 
> Because of gup-fast we likely won't see that happening. And if we would, it
> could be handled (src_mm has the flag set, set it on the destination if the
> page maybe pinned after hiding it from gup-fast; or simply always copy the
> flag if set on the src).
> 
> > 
> > And I don't think anyone can guarantee a per-vma MMF_HAS_PINNED can never
> > happen, or any further change to pinning solution that may affect this.  So
> > far it just looks unsafe to remap a pin page to me.
> 
> It may be questionable to allow remapping pinned pages.
> 
> > 
> > I don't have a good suggestion here if this is a risk.. I'd think it risky
> > then to do REMAP over pinned pages no matter cross-mm or single-mm.  It
> > means probably we just rule them out: folio_maybe_dma_pinned() may not even
> > be enough to be safe with fast-gup.  We may need page_needs_cow_for_dma()
> > with proper write_protect_seq no matter cross-mm or single-mm?
> 
> If you unmap and sync against GUP-fast, you can check after unmapping and
> remap and fail if it maybe pinned afterwards. Plus an early check upfront.
> 
> > 
> > > 
> > > Can it all be fixed? Sure, with more complexity. For something without clear
> > > motivation, I'll have to pass.
> > 
> > I think what you raised is a valid concern, but IMHO it's better fixed no
> > matter cross-mm or single-mm.  What do you think?
> 
> single-mm should at least not cause harm, but the semantics are
> questionable. cross-mm could, especially with malicious user space that
> wants to find ways of harming the kernel.

For kernel, I think we're discussing to see whether it's safe to do so from
kernel pov, e.g., whether to exclude pinned pages is part of that.

For the user app, the dest process has provided the uffd descriptor on its
own willingness, or be a child of the UFFDIO_MOVE issuer when used with
EVENT_FORK, I assume that's already some form of safety check because it
cannot be any process, but ones that are proactively in close cooperative
with the issuer process.

> 
> I'll note that mremap with pinned pages works.

But that's not "by design", am I right?  IOW, do we have any real pin user
that rely on mremap() allowing pages to be moved?

I don't see any word guarantee at least from man page that mremap() will
make sure the PFN won't change after the movement.. even though it seems to
be what happening now.

Neither do I think when designing MMF_HAS_PINNED we kept that in mind that
it won't be affected by someone mremap() pinned pages and we want to keep
it working..

All of it just seems to be an accident..

One step back, we're free to define UFFDIO_MOVE anyway, and we don't
necessarily need to always follow mremap().  E.g., mremap() also supports
ksm pages, but IIUC we already decide to not support that for now on
UFFDIO_MOVE.  UFFDIO_MOVE seems all fine to make it clear on failing at
pinned pages from the 1st day if that satisfies our goals, too.

> 
> > 
> > In general, pinning lose its whole point here to me for an userspace either
> > if it DONTNEEDs it or REMAP it.  What would be great to do here is we unpin
> > it upon DONTNEED/REMAP/whatever drops the page, because it loses its
> > coherency anyway, IMHO.
> 
> Further, moving a part of a THP would fail either way, because the pinned
> THP cannot get split.
> 
> -- 
> Cheers,
> 
> David / dhildenb
> 

Thanks,

-- 
Peter Xu

