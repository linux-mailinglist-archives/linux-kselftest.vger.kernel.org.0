Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B7E459E8C9
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Aug 2022 19:15:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343981AbiHWRLv (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 23 Aug 2022 13:11:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344865AbiHWRLY (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 23 Aug 2022 13:11:24 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04AD5150155
        for <linux-kselftest@vger.kernel.org>; Tue, 23 Aug 2022 06:58:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1661263104;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YHVefDGXU83xWUJyLerizfLITJD1h0bvpZUJLhnlk24=;
        b=AXO1SNmNaxNAq3ngFOkjpwKd9OjFxUtQlCxgejQIg8YZhdDKJzOyAzsl0mGVGXKUuO3hpU
        dxBSGLCI7QSqq5QwrWgBYdTx5HvdDZpa7Fm4cD8qFL0wMh389YJCml7DFA11upm7Hy0FHT
        o9nsIdQoVq8WoDhDI1ANKETuLGKrX5A=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-263-Z_n2z4tfPQ6y6jKbggQFyQ-1; Tue, 23 Aug 2022 09:58:23 -0400
X-MC-Unique: Z_n2z4tfPQ6y6jKbggQFyQ-1
Received: by mail-qt1-f200.google.com with SMTP id cj19-20020a05622a259300b003446920ea91so10681894qtb.10
        for <linux-kselftest@vger.kernel.org>; Tue, 23 Aug 2022 06:58:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=YHVefDGXU83xWUJyLerizfLITJD1h0bvpZUJLhnlk24=;
        b=yzz6ZzFAuXWf+tixLZ607UhvXX33ytDUx0W2UiMDn3Lr+gIyfQ3uglEVRogmtBTl4u
         pGuLgumkCsDsHG1jqitoSHpCAKRArKqlPfedJWWNPxo0NZ4o4j/3LnPeb26J01vsdo3k
         LUYLj2JZi3wsS2nyQ1o9JPUzwbJemZHCAHtuUaw6n/b/61a5Vx338OzY1KU6zitQkW7p
         jUPbbCvpeKQpq1u90CtFi6nXp8U1qzV6wIILxyOR5VheYOStPG6B+efzlq/Kkri33feX
         3L3fazyHHwBMbIcOCEIjEy89niaXVenLqnjSAE9DTW+GcfkRstaicnj6DZKMFN0Pcu2x
         r/xA==
X-Gm-Message-State: ACgBeo12eWMN9rehBQpvjo7XLqoE1eYJir6d6LiPCgEAabftgBw2pcpQ
        LlIF+3w6yqtptXt2tkufl4mhzk3GcbImMl2FoYxBlByRMUsybfh8rWPxNU84gW+nm1RlKoZzhxc
        CcmbZPUxA4iEbrDTIh6nXdRppviuv
X-Received: by 2002:ac8:5b15:0:b0:343:6789:193a with SMTP id m21-20020ac85b15000000b003436789193amr19117263qtw.647.1661263102661;
        Tue, 23 Aug 2022 06:58:22 -0700 (PDT)
X-Google-Smtp-Source: AA6agR7gd2yWDFVr17SP2RU0l4eAn5No/A726n2hPHBkND28yI2ySau6/YWpTWAdi0/4trPHGWQO6g==
X-Received: by 2002:ac8:5b15:0:b0:343:6789:193a with SMTP id m21-20020ac85b15000000b003436789193amr19117247qtw.647.1661263102418;
        Tue, 23 Aug 2022 06:58:22 -0700 (PDT)
Received: from xz-m1.local (bras-base-aurron9127w-grc-35-70-27-3-10.dsl.bell.ca. [70.27.3.10])
        by smtp.gmail.com with ESMTPSA id g7-20020a05620a40c700b006a6ebde4799sm12544646qko.90.2022.08.23.06.58.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Aug 2022 06:58:21 -0700 (PDT)
Date:   Tue, 23 Aug 2022 09:58:19 -0400
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
Message-ID: <YwTc++Lz6lh3aR4F@xz-m1.local>
References: <20220819005601.198436-1-gshan@redhat.com>
 <20220819005601.198436-2-gshan@redhat.com>
 <87lerkwtm5.wl-maz@kernel.org>
 <41fb5a1f-29a9-e6bb-9fab-4c83a2a8fce5@redhat.com>
 <87fshovtu0.wl-maz@kernel.org>
 <171d0159-4698-354b-8b2f-49d920d03b1b@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <171d0159-4698-354b-8b2f-49d920d03b1b@redhat.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Aug 23, 2022 at 03:22:17PM +1000, Gavin Shan wrote:
> > diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
> > index 986cee6fbc7f..0b41feb6fb7d 100644
> > --- a/arch/arm64/kvm/arm.c
> > +++ b/arch/arm64/kvm/arm.c
> > @@ -747,6 +747,12 @@ static int check_vcpu_requests(struct kvm_vcpu *vcpu)
> >   		if (kvm_check_request(KVM_REQ_SUSPEND, vcpu))
> >   			return kvm_vcpu_suspend(vcpu);
> > +
> > +		if (kvm_check_request(KVM_REQ_RING_SOFT_FULL, vcpu)) {
> > +			vcpu->run->exit_reason = KVM_EXIT_DIRTY_RING_FULL;
> > +			trace_kvm_dirty_ring_exit(vcpu);
> > +			return 0;
> > +		}
> >   	}
> >   	return 1;
> > diff --git a/virt/kvm/dirty_ring.c b/virt/kvm/dirty_ring.c
> > index f4c2a6eb1666..08b2f01164fa 100644
> > --- a/virt/kvm/dirty_ring.c
> > +++ b/virt/kvm/dirty_ring.c
> > @@ -149,6 +149,7 @@ int kvm_dirty_ring_reset(struct kvm *kvm, struct kvm_dirty_ring *ring)
> >   void kvm_dirty_ring_push(struct kvm_dirty_ring *ring, u32 slot, u64 offset)
> >   {
> > +	struct kvm_vcpu *vcpu = container_of(ring, struct kvm_vcpu, dirty_ring);
> >   	struct kvm_dirty_gfn *entry;
> >   	/* It should never get full */
> > @@ -166,6 +167,9 @@ void kvm_dirty_ring_push(struct kvm_dirty_ring *ring, u32 slot, u64 offset)
> >   	kvm_dirty_gfn_set_dirtied(entry);
> >   	ring->dirty_index++;
> >   	trace_kvm_dirty_ring_push(ring, slot, offset);
> > +
> > +	if (kvm_dirty_ring_soft_full(vcpu))
> > +		kvm_make_request(KVM_REQ_RING_SOFT_FULL, vcpu);
> >   }
> >   struct page *kvm_dirty_ring_get_page(struct kvm_dirty_ring *ring, u32 offset)
> > 
> 
> Ok, thanks for the details, Marc. I will adopt your code in next revision :)

Note that there can be a slight difference with the old/new code, in that
an (especially malicious) userapp can logically ignore the DIRTY_RING_FULL
vmexit and keep kicking VCPU_RUN with the new code.

Unlike the old code, the 2nd/3rd/... KVM_RUN will still run in the new code
until the next dirty pfn being pushed to the ring, then it'll request ring
full exit again.

Each time it exits the ring grows 1.

At last iiuc it can easily hit the ring full and trigger the warning at the
entry of kvm_dirty_ring_push():

	/* It should never get full */
	WARN_ON_ONCE(kvm_dirty_ring_full(ring));

We did that because kvm_dirty_ring_push() was previously designed to not be
able to fail at all (e.g., in the old bitmap world we never will fail too).
We can't because we can't lose any dirty page or migration could silently
fail too (consider when we do user exit due to ring full and migration just
completed; there could be unsynced pages on src/dst).

So even though the old approach will need to read kvm->dirty_ring_size for
every entrance which is a pity, it will avoid issue above.

Side note: for x86 the dirty ring check was put at the entrance not because
it needs to be the highest priority - it should really be the same when
check kvm requests. It's just that it'll be the fastest way to fail
properly if needed before loading mmu, disabling preemption/irq, etc.

Thanks,

-- 
Peter Xu

