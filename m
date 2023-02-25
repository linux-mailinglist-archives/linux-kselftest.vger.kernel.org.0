Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FE5D6A261A
	for <lists+linux-kselftest@lfdr.de>; Sat, 25 Feb 2023 02:09:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229604AbjBYBJb (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 24 Feb 2023 20:09:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbjBYBJb (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 24 Feb 2023 20:09:31 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A448E2D14F
        for <linux-kselftest@vger.kernel.org>; Fri, 24 Feb 2023 17:09:29 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id 6-20020a17090a190600b00237c5b6ecd7so68590pjg.4
        for <linux-kselftest@vger.kernel.org>; Fri, 24 Feb 2023 17:09:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3jQNgmxspEfBmeQNH+ZPGvDx1V4wYSa4DmNt6455Jdw=;
        b=Pt228mgSte20iA0MsRnaWu+0ibP2IcUQdf1gZzVaT+4P+KeITDZVXeyzwYAJpp8blH
         yBu9lm0R53H4AeUeuEpPRREhVBXNGFFVzAkUwHZjGQB+MrrYsn4UNhogoL/ZdpoW/bxg
         4UAWDqSKFAHlb+w/ATfBHHc8SYJp5ErOh5yZsbEoDbcqs40eBQuK85KpqsV8vfdX+y0t
         cv0jwnprU7vWqOOEQ/ETYhX6ZV3zlIlwramQLBfYZjA7bzZ7yIL/tFAyrJuDPvxrwOYa
         fy7WY7uHRLhyOW/RIibEkgRVRZllOzO3XPlpU2MV2oykUYmD9Pm55K/o9LchvflGa7Uq
         jcsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3jQNgmxspEfBmeQNH+ZPGvDx1V4wYSa4DmNt6455Jdw=;
        b=J5uY9YbzltnhmnNuH1ZWUEBDONDY5smw5caYcz6xPgByQH3Wmj8R7bqHqSFG+VIymn
         kz+cRpVU5npWY7PRJCVJXodPvlC0VzihTNq92Q0q8+urRbxKHIU2qCCW/rzM/VoebPrF
         jFWXofwqcFynM2w0z5Xdmn/nzvrnu87tDo2mObjG42pdbUm6VPbeqOj8sTKGhK0CSQKL
         HmXsv6bZJv7z4vSMXvfywmfZqWJdy3nK9ISWEuQxD/P0Zmlx7LmOoh9mHr9HQVVOIvpZ
         eWHC6B0iiYffNu0lRqCjFSQkZOxzP2Mj3wbWPrDeq+ZRwaZxH2Tz1znc4FDb3QWQ/n/A
         W4hQ==
X-Gm-Message-State: AO0yUKVZPNR2CFULfEneg5qdZDbzU4VILCg5PqYVsSTwuSRjsS9CFffu
        lM3Y06Ph7MdQxH0Csqp4G2PUAQ==
X-Google-Smtp-Source: AK7set9uUvKBjU2onvFrucnnLWXdEOl/7jmN5ocuy7gAmEPQ95OEkcR42Wj3s9YiIWnYf6ZvsmYq9w==
X-Received: by 2002:a05:6a20:9c:b0:ad:def6:af3 with SMTP id 28-20020a056a20009c00b000addef60af3mr8264378pzg.57.1677287368799;
        Fri, 24 Feb 2023 17:09:28 -0800 (PST)
Received: from google.com (77.62.105.34.bc.googleusercontent.com. [34.105.62.77])
        by smtp.gmail.com with ESMTPSA id g2-20020a62e302000000b00593e84f2d08sm159873pfh.52.2023.02.24.17.09.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Feb 2023 17:09:28 -0800 (PST)
Date:   Sat, 25 Feb 2023 01:09:24 +0000
From:   Mingwei Zhang <mizhang@google.com>
To:     "Chang S. Bae" <chang.seok.bae@intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Jim Mattson <jmattson@google.com>,
        Venkatesh Srinivas <venkateshs@google.com>,
        Aaron Lewis <aaronlewis@google.com>,
        Chao Gao <chao.gao@intel.com>
Subject: Re: [PATCH v3 01/13] x86/fpu/xstate: Avoid getting xstate address of
 init_fpstate if fpstate contains the component
Message-ID: <Y/lfxHXVdqeFadGD@google.com>
References: <20230221163655.920289-1-mizhang@google.com>
 <20230221163655.920289-2-mizhang@google.com>
 <e91b9172-8a2e-e299-a84f-1e9331c51cb7@intel.com>
 <87ilfum6xh.ffs@tglx>
 <CAL715WKLQxxeyFqiKbKsUmQ8bZf2f=rwADyKj1ftgROA+dhpXg@mail.gmail.com>
 <ea9d7394-73dd-23c0-ea05-d0ec4fcebb55@intel.com>
 <Y/lOlBWTNgROPl0P@google.com>
 <691106c3-b339-578b-6e43-77f737f127f9@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <691106c3-b339-578b-6e43-77f737f127f9@intel.com>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Feb 24, 2023, Chang S. Bae wrote:
> On 2/24/2023 3:56 PM, Mingwei Zhang wrote:
> > On Wed, Feb 22, 2023, Chang S. Bae wrote:
> > > 
> > >          /*
> > > -        * The ptrace buffer is in non-compacted XSAVE format.  In
> > > -        * non-compacted format disabled features still occupy state space,
> > > -        * but there is no state to copy from in the compacted
> > > -        * init_fpstate. The gap tracking will zero these states.
> > > +        * Indicate which states to copy from fpstate. When not present in
> > > +        * fpstate, those extended states are either initialized or
> > > +        * disabled. They are also known to have an all zeros init state.
> > > +        * Thus, remove them from 'mask' to zero those features in the user
> > > +        * buffer instead of retrieving them from init_fpstate.
> > >           */
> > > -       mask = fpstate->user_xfeatures;
> > 
> > Do we need to change this line and the comments? I don't see any of
> > these was relevant to this issue. The original code semantic is to
> > traverse all user_xfeatures, if it is available in fpstate, copy it from
> > there; otherwise, copy it from init_fpstate. We do not assume the
> > component in init_fpstate (but not in fpstate) are all zeros, do we? If
> > it is safe to assume that, then it might be ok. But at least in this
> > patch, I want to keep the original semantics as is without the
> > assumption.
> 
> Here it has [1]:
> 
> 	 *
> 	 * XSAVE could be used, but that would require to reshuffle the
> 	 * data when XSAVEC/S is available because XSAVEC/S uses xstate
> 	 * compaction. But doing so is a pointless exercise because most
> 	 * components have an all zeros init state except for the legacy
> 	 * ones (FP and SSE). Those can be saved with FXSAVE into the
> 	 * legacy area. Adding new features requires to ensure that init
> 	 * state is all zeroes or if not to add the necessary handling
> 	 * here.
> 	 */
> 	fxsave(&init_fpstate.regs.fxsave);

ah, I see.
> 
> Thus, init_fpstate has zeros for those extended states. Then, copying from
> init_fpstate is the same as membuf_zero() by the gap tracking. But, we have
> two ways to do the same thing here.
> 
> So I think it works that simply copying the state from fpstate only for
> those present there, then letting the gap tracking zero out for the rest of
> the userspace buffer for features that are either disabled or initialized.
> 
> Then, we can remove accessing init_fpstate in the copy loop and which is the
> source of the problem. So I think this line change is relevant and also
> makes the code simple.
> 
> I guess I'm fine if you don't want to do this. Then, let me follow up with
> something like this at first. Something like yours could be a fallback
> option for other good reasons, otherwise.

hmm. I see. But this is still because of the software implementation.
What if there is a new hardware component that requires a non-zero init
state.

For instance, in the past, we had PKRU component, whose init value is
0x555...54. Of course, that is a bad example because now we kick it out
of the XSAVE/XRSTOR and special handling that, but there is no guarantee
that in the future we will never need a non-zero init state.

So, I will send out my fix and let you, Thomas and potentially other
folks to decide what is the best option. Overall, I get your point.

Thanks
-Mingwei
>
> Thanks,
> Chang
> 
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/x86/kernel/fpu/xstate.c#n386
> 
> 
