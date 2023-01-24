Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28372678C80
	for <lists+linux-kselftest@lfdr.de>; Tue, 24 Jan 2023 01:04:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232664AbjAXAEh (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 23 Jan 2023 19:04:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232632AbjAXAEe (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 23 Jan 2023 19:04:34 -0500
Received: from mail-vk1-xa2c.google.com (mail-vk1-xa2c.google.com [IPv6:2607:f8b0:4864:20::a2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A638448C
        for <linux-kselftest@vger.kernel.org>; Mon, 23 Jan 2023 16:04:29 -0800 (PST)
Received: by mail-vk1-xa2c.google.com with SMTP id q21so6848783vka.3
        for <linux-kselftest@vger.kernel.org>; Mon, 23 Jan 2023 16:04:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=l7mwajEm76YoiYSB/V9MrizwymViJaehFEWPplLW4cU=;
        b=GNGQnuNQKkQJgkDj3E9MuzhwJNzPRSgxVH+D81dgY+kINqbVVGvDlN1xoclVv69tV1
         st9cXbSUPSSi4W5iBbMdUUuUoww9j0MBskM1VgXs9dJxfqa9ZKyct9dqS27kA9hMD7yJ
         SUSvqaCdisIxxIODDiecgk2vBpQh3QGIMxEw4vjTDPcqfT29xgfyxvGm2aSPN2iH171K
         h7aKKcGDVMBOcH5QA7PJJYbG4JvCQcYqIwV46tcUbMVSeTuG9O2ELZIldFit3u2jGEpQ
         BL9/UGZniAt1gcJAWh9AzCngbiOCHWxfXEqQpeEC++OZOrzXF0pTDgbOByCEPHm6eVCb
         kJOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=l7mwajEm76YoiYSB/V9MrizwymViJaehFEWPplLW4cU=;
        b=RTbRcyMEkplI2n4mMFWZkoGKHHJX2YUneo4t+lZhfySUPZIt2dpCb0au+c1XQ+ylw/
         2/PQI2dsrgy/f3OexnrFny0l+qxs6fjDBXNe743PhE2RFVyerAJy9REzsEVSQMbdaM3b
         QTJgCSg5CN/YQRt5eOGeDDfchpQBOS2+YX6iMvKotnyP+s3m417OSPAkvUVj3+ffPU5A
         3Kh7EUJoPiI5q6/jsYiQoNFjvw8vKLWNumxRMg6buHWZDbcKI4t0xzVmTgxJRKBJHfjF
         tQUnBUUpvvssq/y96xL8HKNpI9FC5bE3tz6pXNEYkKNYZFRVqEa2Gf8SpQ7BTfmwLWg+
         HPfw==
X-Gm-Message-State: AFqh2krH7cmW0J9cbTnQCu7IhHU4GbCqm4ohKR/ABfqfzMjmJCXJAY3n
        4P/TNHgFdDo1Iew7UqBQoIrf4QgJUwzQpwQ9ftN4RA==
X-Google-Smtp-Source: AMrXdXsqjE43sQI2EnZqMzPo+vtzh0Jj20NAjdE6K8Pau0aUn2g/X5IAjPDDAbO+o5t96B3IIWd6G+e17iWq6svdSYQ=
X-Received: by 2002:a05:6122:219e:b0:3d5:dcb7:5f88 with SMTP id
 j30-20020a056122219e00b003d5dcb75f88mr3551142vkd.37.1674518668115; Mon, 23
 Jan 2023 16:04:28 -0800 (PST)
MIME-Version: 1.0
References: <20230121001542.2472357-1-ackerleytng@google.com>
 <20230121001542.2472357-9-ackerleytng@google.com> <Y8sxjppvEnm4IBWG@google.com>
 <CAAYXXYy7=ZTCZ1LQ3_Sy39ju_xG5++dTrxi+DKGcbpJ5VJ3OuQ@mail.gmail.com>
 <99a36eed-e4e5-60ec-0f88-a33d1842a0d6@maciej.szmigiero.name> <Y87XnYZx1qzZOLKR@google.com>
In-Reply-To: <Y87XnYZx1qzZOLKR@google.com>
From:   Erdem Aktas <erdemaktas@google.com>
Date:   Mon, 23 Jan 2023 16:04:16 -0800
Message-ID: <CAAYXXYyqDJx4=cSy3kp7vX4VF+5z_Rtm6wPM8_o9BmHkB_T-kg@mail.gmail.com>
Subject: Re: [RFC PATCH v3 08/31] KVM: selftests: Require GCC to realign
 stacks on function entry
To:     Sean Christopherson <seanjc@google.com>
Cc:     "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>,
        Ackerley Tng <ackerleytng@google.com>,
        linux-kselftest@vger.kernel.org, pbonzini@redhat.com,
        isaku.yamahata@intel.com, sagis@google.com, afranji@google.com,
        runanwang@google.com, shuah@kernel.org, drjones@redhat.com,
        maz@kernel.org, bgardon@google.com, jmattson@google.com,
        dmatlack@google.com, peterx@redhat.com, oupton@google.com,
        ricarkol@google.com, yang.zhong@intel.com, wei.w.wang@intel.com,
        xiaoyao.li@intel.com, pgonda@google.com, marcorr@google.com,
        eesposit@redhat.com, borntraeger@de.ibm.com, eric.auger@redhat.com,
        wangyanan55@huawei.com, aaronlewis@google.com, vkuznets@redhat.com,
        pshier@google.com, axelrasmussen@google.com,
        zhenzhong.duan@intel.com, like.xu@linux.intel.com,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
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

On Mon, Jan 23, 2023 at 10:53 AM Sean Christopherson <seanjc@google.com> wrote:
>
> On Mon, Jan 23, 2023, Maciej S. Szmigiero wrote:
> > On 23.01.2023 19:30, Erdem Aktas wrote:
> > > On Fri, Jan 20, 2023 at 4:28 PM Sean Christopherson <seanjc@google.com> wrote:
> > > >
> > > > On Sat, Jan 21, 2023, Ackerley Tng wrote:
> > > > > Some SSE instructions assume a 16-byte aligned stack, and GCC compiles
> > > > > assuming the stack is aligned:
> > > > > https://gcc.gnu.org/bugzilla/show_bug.cgi?id=40838. This combination
> > > > > results in a #GP in guests.
> > > > >
> > > > > Adding this compiler flag will generate an alternate prologue and
> > > > > epilogue to realign the runtime stack, which makes selftest code
> > > > > slower and bigger, but this is okay since we do not need selftest code
> > > > > to be extremely performant.
> > > >
> > > > Huh, I had completely forgotten that this is why SSE is problematic.  I ran into
> > > > this with the base UPM selftests and just disabled SSE.  /facepalm.
> > > >
> > > > We should figure out exactly what is causing a misaligned stack.  As you've noted,
> > > > the x86-64 ABI requires a 16-byte aligned RSP.  Unless I'm misreading vm_arch_vcpu_add(),
> > > > the starting stack should be page aligned, which means something is causing the
> > > > stack to become unaligned at runtime.  I'd rather hunt down that something than
> > > > paper over it by having the compiler force realignment.
> > >
> > > Is not it due to the 32bit execution part of the guest code at boot
> > > time. Any push/pop of 32bit registers might make it a 16-byte
> > > unaligned stack.
> >
> > 32-bit stack needs to be 16-byte aligned, too (at function call boundaries) -
> > see [1] chapter 2.2.2 "The Stack Frame"
>
> And this showing up in the non-TDX selftests rules that out as the sole problem;
> the selftests stuff 64-bit mode, i.e. don't have 32-bit boot code.

Thanks Maciej and Sean for the clarification. I was suspecting the
hand-coded assembly part that we have for TDX tests but  it being
happening in the non-TDX selftests disproves it.
