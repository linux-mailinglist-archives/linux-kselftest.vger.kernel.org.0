Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47F9C59C790
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Aug 2022 20:57:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237405AbiHVS4z (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 22 Aug 2022 14:56:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238370AbiHVS4H (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 22 Aug 2022 14:56:07 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F5AF193E0
        for <linux-kselftest@vger.kernel.org>; Mon, 22 Aug 2022 11:56:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1661194560;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6Sc/GFE/h4auZJmdG2OSNqDhNL2VL4Oyu1Hp2vRC3HE=;
        b=Nw83tg1/OYHthpzCVXPi7OuUSWE05fgMc+kx9OOP51J5BMydsfnfsLYY4AKv23jdOSKczs
        Tt5QyBR4QpD06R5zcxQq53A7+h2L1BFTE1D1AC0xBXZ9mH+BDRbJN5Y96f9Z4tZy1KAb7e
        mS1eYRvzOh0G2wMAHAUYV269KglW2lc=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-645-2d8Fl_E4M4WUs9eeAvHDsg-1; Mon, 22 Aug 2022 14:55:58 -0400
X-MC-Unique: 2d8Fl_E4M4WUs9eeAvHDsg-1
Received: by mail-qt1-f200.google.com with SMTP id bq11-20020a05622a1c0b00b003434f125b77so9070623qtb.20
        for <linux-kselftest@vger.kernel.org>; Mon, 22 Aug 2022 11:55:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=6Sc/GFE/h4auZJmdG2OSNqDhNL2VL4Oyu1Hp2vRC3HE=;
        b=NH2sKQcKrMtxPzuC2homF3XbxmLwFuj3oRZZWqrHeEBkPQL7vUG2IL3HSdZ4oSkyyy
         Z5QoRrd6Oe3QNN2/9LgU1Q26/KFXpVYrH111Vu69aE8JoF2gwy6uBvbNtlFSDTNPRTIo
         s32nqaQua/CZPn6tPaUvkBEOHI8DWge9Hf+AQ2c7gSxwFjD5+1ieS6hubrM2zwBtjrRp
         i7P8rI0vf784HLul+nOWOk41CRSEEb5AGbmMiKZsnBB2l5+Okz2zUIZ4qnjbUFws87hp
         OFYei0QPQ+N8L/PUG/MMaOGl9rPFjSCvysuGEe2Mh552qlqjMJcn2Nnq5qyu5daT7Sgv
         /DDA==
X-Gm-Message-State: ACgBeo12iYPyJuWF7KLILzTEOqRXyNa7+U3LatcUBWbEFEEh9Lie0Gax
        UYQDvNjyYscdLNk3FzPboB89t8256twdNqxW2XfQcZGDdrNHGLPENqGqfMVOKd6l6qGG9kQx8KT
        V6i2LRCmSOpPU9nS8OpJFp/Fpfpk3
X-Received: by 2002:a05:622a:451:b0:344:ad2f:692c with SMTP id o17-20020a05622a045100b00344ad2f692cmr9157264qtx.604.1661194558418;
        Mon, 22 Aug 2022 11:55:58 -0700 (PDT)
X-Google-Smtp-Source: AA6agR4SPwSXVCYhU6Mx1Y/ng2/oG6o7hMCWS3u5m4ddUxyWRbRC8YCvqK2IPkivSnUKC63Wynm2Tg==
X-Received: by 2002:a05:622a:451:b0:344:ad2f:692c with SMTP id o17-20020a05622a045100b00344ad2f692cmr9157248qtx.604.1661194558179;
        Mon, 22 Aug 2022 11:55:58 -0700 (PDT)
Received: from xz-m1.local (bras-base-aurron9127w-grc-35-70-27-3-10.dsl.bell.ca. [70.27.3.10])
        by smtp.gmail.com with ESMTPSA id n1-20020ac86741000000b0031eebfcb369sm9093468qtp.97.2022.08.22.11.55.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Aug 2022 11:55:57 -0700 (PDT)
Date:   Mon, 22 Aug 2022 14:55:55 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Gavin Shan <gshan@redhat.com>
Cc:     Marc Zyngier <maz@kernel.org>, kvmarm@lists.cs.columbia.edu,
        linux-arm-kernel@lists.infradead.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kselftest@vger.kernel.org, pbonzini@redhat.com,
        corbet@lwn.net, james.morse@arm.com, alexandru.elisei@arm.com,
        suzuki.poulose@arm.com, oliver.upton@linux.dev,
        catalin.marinas@arm.com, will@kernel.org, shuah@kernel.org,
        seanjc@google.com, drjones@redhat.com, dmatlack@google.com,
        bgardon@google.com, ricarkol@google.com, zhenyzha@redhat.com,
        shan.gavin@gmail.com
Subject: Re: [PATCH v1 1/5] KVM: arm64: Enable ring-based dirty memory
 tracking
Message-ID: <YwPRO0r2sfzcbgyz@xz-m1.local>
References: <20220819005601.198436-1-gshan@redhat.com>
 <20220819005601.198436-2-gshan@redhat.com>
 <87lerkwtm5.wl-maz@kernel.org>
 <41fb5a1f-29a9-e6bb-9fab-4c83a2a8fce5@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <41fb5a1f-29a9-e6bb-9fab-4c83a2a8fce5@redhat.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi, Gavin,

On Mon, Aug 22, 2022 at 11:58:20AM +1000, Gavin Shan wrote:
> > For context, the documentation says:
> > 
> > <quote>
> > - if KVM_CAP_DIRTY_LOG_RING is available, a number of pages at
> >    KVM_DIRTY_LOG_PAGE_OFFSET * PAGE_SIZE. [...]
> > </quote>
> > 
> > What is the reason for picking this particular value?
> > 
> 
> It's inherited from x86. I don't think it has to be this particular value.
> The value is used to distinguish the region's owners like kvm_run, KVM_PIO_PAGE_OFFSET,
> KVM_COALESCED_MMIO_PAGE_OFFSET, and KVM_DIRTY_LOG_PAGE_OFFSET.
> 
> How about to have 2 for KVM_DIRTY_LOG_PAGE_OFFSET in next revision?
> The virtual area is cheap, I guess it's also nice to use x86's
> pattern to have 64 for KVM_DIRTY_LOG_PAGE_OFFSET.
> 
>     #define KVM_COALESCED_MMIO_PAGE_OFFSET   1
>     #define KVM_DIRTY_LOG_PAGE_OFFSET        2

It was chosen not to be continuous of previous used offset because it'll be
the 1st vcpu region that can cover multiple & dynamic number of pages.  I
wanted to leave the 3-63 (x86 used offset 2 already) for small fields so
they can be continuous, which looks a little bit cleaner.

Currently how many pages it'll use depends on the size set by the user,
though there's a max size limited by KVM_DIRTY_RING_MAX_ENTRIES, which is a
maximum of 1MB memory.

So I think setting it to 2 is okay, as long as we keep the rest 1MB address
space for the per-vcpu ring structure, so any new vcpu fields (even if only
1 page will be needed) need to be after that maximum size of the ring.

Thanks,

-- 
Peter Xu

