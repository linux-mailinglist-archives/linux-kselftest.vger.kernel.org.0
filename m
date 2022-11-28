Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA54D63AD8B
	for <lists+linux-kselftest@lfdr.de>; Mon, 28 Nov 2022 17:21:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232535AbiK1QVk (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 28 Nov 2022 11:21:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232414AbiK1QVj (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 28 Nov 2022 11:21:39 -0500
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 713D6B7E5
        for <linux-kselftest@vger.kernel.org>; Mon, 28 Nov 2022 08:21:38 -0800 (PST)
Received: by mail-pg1-x536.google.com with SMTP id v3so10378723pgh.4
        for <linux-kselftest@vger.kernel.org>; Mon, 28 Nov 2022 08:21:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3SPTNDjDD7p4251KmVbwYpNYSw/fK88RKLG3Fou2M/8=;
        b=NuoweXsJXULm6RYVG3ZIGJHN55oghx6QaI8q8AURyEnv34ek4WgY41IOyDfkZPpnZC
         nBaJGSJ8qmZrEuNTB0W7C4Vq80YpPPYPwpqdW5ttDkr4v7ZVRbxkQMBleEsCl2nQpwOo
         pR8KvmuWKBQCj3jRzTpXxPhCAOuIL3kxXShpCU33UaUEtFzjNAMyF4C+aQsn9m/EAybu
         HLgFFYN7ui+qzaSQuzUP4hPCrET6t+pAUSG4R3GW+jBVFlif8y5KOzQl4DGFr328/Jxw
         RdAwPXhBA2ECEq+0G9mzSv/DFbhio03EXsEwvDnyY4JqNVUqTtnEWuHuQKf81Is8GcDd
         A31Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3SPTNDjDD7p4251KmVbwYpNYSw/fK88RKLG3Fou2M/8=;
        b=Lf+oL8ka/xk/RUvTSNG3m7M51VWHOIA3Ww5Llowl2OsGYTumT5g0IKMtCDb62xVTQ2
         0wsmXJecy4YOah49NG0x8fsdwmEkglg+8T+ZztpxL5Un0l3NlCr8VfbMy73E76a8IPhs
         funK+k4oJc/DwAB7Fd5ZCPWQ6ft3hJ3ChhnbiHSG8qEBbhzhSYMRu7qKT/dPOy9RVRQp
         cJ5Q6xz1RWVXI5u/+M/YnNZZmUsPwVF569VH0m5CwYhNg4Zjpv+wj+DfU0wpj4Rxj8/w
         qYTY9+eatczY4wDAClYTvaJOoYB4sc0kYGjNHbo43NTiSTUImjm91ntAowQrJZMlYInY
         DlVA==
X-Gm-Message-State: ANoB5pnJibWuoORvTf/Fi1nW8u1XPRYuNGrAZ5OrMp1C7msV/MIvA2B4
        omF1++CP9nH9yAGCfcwqnFkM1mRPYDb+vg==
X-Google-Smtp-Source: AA0mqf5zzbD9A5lmapC2GGKQC+5jCoq1JklIaLBaA9YEUu7UbREHdvJi565q51PnekGCOUfMQIwUFw==
X-Received: by 2002:a62:ab11:0:b0:574:cea8:4480 with SMTP id p17-20020a62ab11000000b00574cea84480mr15301526pff.72.1669652497815;
        Mon, 28 Nov 2022 08:21:37 -0800 (PST)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id w8-20020a17090a1b8800b001f94d25bfabsm9799780pjc.28.2022.11.28.08.21.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Nov 2022 08:21:37 -0800 (PST)
Date:   Mon, 28 Nov 2022 16:21:33 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Marc Orr <marcorr@google.com>
Cc:     Chao Peng <chao.p.peng@linux.intel.com>,
        Vishal Annapurve <vannapurve@google.com>, x86@kernel.org,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, pbonzini@redhat.com,
        vkuznets@redhat.com, wanpengli@tencent.com, jmattson@google.com,
        joro@8bytes.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com,
        shuah@kernel.org, yang.zhong@intel.com, ricarkol@google.com,
        aaronlewis@google.com, wei.w.wang@intel.com,
        kirill.shutemov@linux.intel.com, corbet@lwn.net, hughd@google.com,
        jlayton@kernel.org, bfields@fieldses.org,
        akpm@linux-foundation.org, yu.c.zhang@linux.intel.com,
        jun.nakajima@intel.com, dave.hansen@intel.com,
        michael.roth@amd.com, qperret@google.com, steven.price@arm.com,
        ak@linux.intel.com, david@redhat.com, luto@kernel.org,
        vbabka@suse.cz, erdemaktas@google.com, pgonda@google.com,
        nikunj@amd.com, diviness@google.com, maz@kernel.org,
        dmatlack@google.com, axelrasmussen@google.com,
        maciej.szmigiero@oracle.com, mizhang@google.com,
        bgardon@google.com, ackerleytng@google.com
Subject: Re: [V1 PATCH 1/6] KVM: x86: Add support for testing private memory
Message-ID: <Y4TgDZPTXnnoTitB@google.com>
References: <20221111014244.1714148-1-vannapurve@google.com>
 <20221111014244.1714148-2-vannapurve@google.com>
 <20221122100705.GA619277@chaop.bj.intel.com>
 <Y30rqWwDRbH7nQaQ@google.com>
 <CAA03e5EXU-TpZP2tyjEjfAAr9aNNcgmgOX6Rqv7ng+4Xc9H5AQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAA03e5EXU-TpZP2tyjEjfAAr9aNNcgmgOX6Rqv7ng+4Xc9H5AQ@mail.gmail.com>
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

On Wed, Nov 23, 2022, Marc Orr wrote:
> On Tue, Nov 22, 2022 at 12:06 PM Sean Christopherson <seanjc@google.com> wrote:
> > > > @@ -221,6 +220,9 @@ struct kvm_page_fault {
> > > >     /* The memslot containing gfn. May be NULL. */
> > > >     struct kvm_memory_slot *slot;
> > > >
> > > > +   /* Derived from encryption bits of the faulting GPA for CVMs. */
> > > > +   bool is_private;
> > >
> > > Either we can wrap it with the CONFIG_HAVE_KVM_PRIVATE_MEM_TESTING or if
> > > it looks ugly I can remove the "const" in my code.
> >
> > Hmm, I think we can keep the const.  Similar to the bug in kvm_faultin_pfn()[*],
> > the kvm_slot_can_be_private() is bogus.  A fault should be considered private if
> > it's marked as private, whether or not userspace has configured the slot to be
> > private is irrelevant.  I.e. the xarray is the single source of truth, memslots
> > are just plumbing.
> 
> If we incorporate Sean's suggestion and use xarray as the single
> source of truth, then can we get rid of the
> HAVE_KVM_PRIVATE_MEM_TESTING config?

No, we still want the opt-in config.  

> Specifically, the self test can call the KVM_MEMORY_ENCRYPT_REG_REGION
> ioctl which will set the bits for the private FD within KVM's xarray.

Yes, but that should be disallowed for regular VMs without HAVE_KVM_PRIVATE_MEM_TESTING=y.

> (Maybe this was part of the point that Sean was making; but his
> feedback seemed focused on the discussion about keeping `is_private`
> const, whereas I've been staring at this trying to figure out if we
> can run the UPM selftests on a non-TDX/SNP VM WITHOUT a special
> test-only config. And Sean's idea seems to eliminate the need for the
> awkward CONFIG.)

"need" was always relative.  It's obviously possible to enable any code without a
Kconfig, the question is whether or not it's a good idea to do so.  In this case,
the answer is "no", because allowing private memory opens up a number a of code
paths and thus potential bugs.  And we need something for kvm_arch_has_private_mem()
because returning "true" unconditionally is not correct for regular VMs.
