Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F142F6B1A86
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 Mar 2023 05:59:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229525AbjCIE7O (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 8 Mar 2023 23:59:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbjCIE7N (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 8 Mar 2023 23:59:13 -0500
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 871635D8B0
        for <linux-kselftest@vger.kernel.org>; Wed,  8 Mar 2023 20:59:12 -0800 (PST)
Received: by mail-qt1-x82c.google.com with SMTP id l18so893423qtp.1
        for <linux-kselftest@vger.kernel.org>; Wed, 08 Mar 2023 20:59:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20210112.gappssmtp.com; s=20210112; t=1678337951;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=u7Q758EVgylTs75aXHGbh2DNnGqg/9Af+1g3WINt/FU=;
        b=3ync1xHxY/YBYVd3IxyroCZqUb/GWTTYzZ8PELadIq/fDhfg2coxb7kzHgPX5H2uPP
         97pkKNtMLAIOTy7KS4xl8BRtfUTfXZGTeXaz1eBkHfQ3hxiYVeZapniGPMiCkLtQU+UI
         4tnBNI9JVwxGld8T5h4FbOXrAb6MEZNKErtmlCLZ8E70PlymYUVVc0NsaHhvuScDNh1v
         Vrh+7q08WKE5N2tu3HCooIUlv4S+HbzlXxPH9sgA/QXQqTGHU3pP30GAG8Zj9Un8j7Ok
         IFsGCaZxpEkqJyH3FoaLxlQuiLQCVIevF1e8yH5CK5GwI+Jdv0siKEat2sGj4lVTA1kd
         uetA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678337951;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u7Q758EVgylTs75aXHGbh2DNnGqg/9Af+1g3WINt/FU=;
        b=MGHJfRIKQU0s9zXRIAMA3ovqxwN96VyDMRjdvUJlr/mDkgALoaFuuAwX8VJGSwRBwz
         KCffW5xcHndskdismTsBXiXTC8avRRgZ5DMsyic/jTd0iyRziTZPBMTktV49PePlUuhf
         U7maC+SVz+WtTpBdIeUNutUDi5HZSvEC1PvdAg/Bh09LRFhLAYnacFVFuY4jEAoB/ENm
         eFKln3cz4s0NFSr5f6Vk2PkqMy2Z6n0T4ZYq9NsTUnOcojjNZPWRDYwUjsQnJ332nuB9
         gB+E/4UvVWqAXdfzB2HyRZra2NBkAfbj8N8zBE1N/nBjA9Ur2MsvUTlS4g0H5EG2iCV1
         Ltxg==
X-Gm-Message-State: AO0yUKW3cUsWmp6cHlrnE2R2Y5RetANRehAZ3d3w8pigoJkEPokJuZ5M
        sl4Q8AbsG7wqwUWP7fQj20pM9w==
X-Google-Smtp-Source: AK7set8HRIUSrbF4IGC24O6vqnaFTBCTpfvzE95pYf2T5AMVM0aMH3GWnuSEGSNHcoiK/ACjtMjm7w==
X-Received: by 2002:a05:622a:170b:b0:3b8:58d0:b4e4 with SMTP id h11-20020a05622a170b00b003b858d0b4e4mr2431886qtk.33.1678337951507;
        Wed, 08 Mar 2023 20:59:11 -0800 (PST)
Received: from localhost ([2620:10d:c091:400::5:d32c])
        by smtp.gmail.com with ESMTPSA id e8-20020ac80108000000b003b9a6d54b6csm12913588qtg.59.2023.03.08.20.59.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Mar 2023 20:59:11 -0800 (PST)
Date:   Wed, 8 Mar 2023 23:59:10 -0500
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Stefan Roesch <shr@devkernel.io>
Cc:     kernel-team@fb.com, linux-mm@kvack.org, riel@surriel.com,
        mhocko@suse.com, david@redhat.com, linux-kselftest@vger.kernel.org,
        linux-doc@vger.kernel.org, akpm@linux-foundation.org
Subject: Re: [PATCH v3 1/3] mm: add new api to enable ksm per process
Message-ID: <20230309045910.GD476158@cmpxchg.org>
References: <20230224044000.3084046-1-shr@devkernel.io>
 <20230224044000.3084046-2-shr@devkernel.io>
 <20230308164746.GA473363@cmpxchg.org>
 <qvqwbkl2zxui.fsf@dev0134.prn3.facebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <qvqwbkl2zxui.fsf@dev0134.prn3.facebook.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Mar 08, 2023 at 02:16:36PM -0800, Stefan Roesch wrote:
> Johannes Weiner <hannes@cmpxchg.org> writes:
> > On Thu, Feb 23, 2023 at 08:39:58PM -0800, Stefan Roesch wrote:
> >> @@ -2405,8 +2417,20 @@ static struct ksm_rmap_item *scan_get_next_rmap_item(struct page **page)
> >>  		goto no_vmas;
> >>
> >>  	for_each_vma(vmi, vma) {
> >> -		if (!(vma->vm_flags & VM_MERGEABLE))
> >> +		if (!vma_ksm_mergeable(vma))
> >>  			continue;
> >> +		if (!(vma->vm_flags & VM_MERGEABLE)) {
> >
> > IMO, the helper obscures the interaction between the vma flag and the
> > per-process flag here. How about:
> >
> > 		if (!(vma->vm_flags & VM_MERGEABLE)) {
> > 			if (!test_bit(MMF_VM_MERGE_ANY, &vma->vm_mm->flags))
> > 				continue;
> >
> > 			/*
> > 			 * With per-process merging enabled, have the MM scan
> > 			 * enroll any existing and new VMAs on the fly.
> > 			 *
> > 			ksm_madvise();
> > 		}
> >
> >> +			unsigned long flags = vma->vm_flags;
> >> +
> >> +			/* madvise failed, use next vma */
> >> +			if (ksm_madvise(vma, vma->vm_start, vma->vm_end, MADV_MERGEABLE, &flags))
> >> +				continue;
> >> +			/* vma, not supported as being mergeable */
> >> +			if (!(flags & VM_MERGEABLE))
> >> +				continue;
> >> +
> >> +			vm_flags_set(vma, VM_MERGEABLE);
> >
> > I don't understand the local flags. Can't it pass &vma->vm_flags to
> > ksm_madvise()? It'll set VM_MERGEABLE on success. And you know it
> > wasn't set before because the whole thing is inside the !set
> > branch. The return value doesn't seem super useful, it's only the flag
> > setting that matters:
> >
> > 			ksm_madvise(vma, vma->vm_start, vma->vm_end, MADV_MERGEABLE, &vma->vm_flags);
> > 			/* madvise can fail, and will skip special vmas (pfnmaps and such) */
> > 			if (!(vma->vm_flags & VM_MERGEABLE))
> > 				continue;
> >
> 
> vm_flags is defined as const. I cannot pass it directly inside the
> function, this is the reason, I'm using a local variable for it.

Oops, good catch.

However, while looking at the flag helpers, I'm also realizing that
modifications requires the mmap_sem in write mode, which this code
doesn't. This function might potentially scan the entire process
address space, so you can't just change the lock mode, either.

Staring more at this, do you actually need to set VM_MERGEABLE on the
individual vmas? There are only a few places that check VM_MERGEABLE,
and AFAICS they can all just check for MMF_VM_MERGE_ANY also.

You'd need to factor out the vma compatibility checks from
ksm_madvise(), and skip over special vmas during the mm scan. But
those tests are all stable under the read lock, so that's fine.

The other thing ksm_madvise() does is ksm_enter() - but that's
obviously not needed from inside the loop over ksm_enter'd mms. :)
