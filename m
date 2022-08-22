Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B27AA59CAFF
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Aug 2022 23:42:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238249AbiHVVmZ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 22 Aug 2022 17:42:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238228AbiHVVmX (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 22 Aug 2022 17:42:23 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A88CB564D2;
        Mon, 22 Aug 2022 14:42:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3ADABB81982;
        Mon, 22 Aug 2022 21:42:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6F27C433C1;
        Mon, 22 Aug 2022 21:42:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661204538;
        bh=m3afk3mljkvownoqx6MC00ioq6Fmulwr4fb2KxjYoHM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=PYqyst0c/Rsc+ShBpyzFzAilHnFn3hycljOEIChGLUbJhQIsLJgPvnhh+7FgjHZRU
         nslyP/dSlL0Q4A+e0GgacIWJ65CO0qqnm0LTOvPiQ8TkudfxcnVN7Ua24PBegg6/08
         HszYQM7XTYA8iW6ZSOlny9jOOPFo5Wwp/zXizabqwYB3BwNxV+lZwITw1jKtcYBT4t
         K+UqcBl3HhRozYVIOllwNBqIsXsg+n3ShVXuHmB+gre0VjUlYRbPe8vv6etglQy9wT
         ClUPKAQRNS3QYE4GHr4zqqZjEVzasMPBJR2JRO9XOZjlRZkmFm+XkGzo7tzSNDzzzZ
         FIUdpa3iZS+Pg==
Received: from sofa.misterjones.org ([185.219.108.64] helo=why.misterjones.org)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.95)
        (envelope-from <maz@kernel.org>)
        id 1oQFBY-004xE0-EA;
        Mon, 22 Aug 2022 22:42:16 +0100
Date:   Mon, 22 Aug 2022 22:42:15 +0100
Message-ID: <87fshovtu0.wl-maz@kernel.org>
From:   Marc Zyngier <maz@kernel.org>
To:     Gavin Shan <gshan@redhat.com>
Cc:     kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
        peterx@redhat.com, pbonzini@redhat.com, corbet@lwn.net,
        james.morse@arm.com, alexandru.elisei@arm.com,
        suzuki.poulose@arm.com, oliver.upton@linux.dev,
        catalin.marinas@arm.com, will@kernel.org, shuah@kernel.org,
        seanjc@google.com, drjones@redhat.com, dmatlack@google.com,
        bgardon@google.com, ricarkol@google.com, zhenyzha@redhat.com,
        shan.gavin@gmail.com
Subject: Re: [PATCH v1 1/5] KVM: arm64: Enable ring-based dirty memory tracking
In-Reply-To: <41fb5a1f-29a9-e6bb-9fab-4c83a2a8fce5@redhat.com>
References: <20220819005601.198436-1-gshan@redhat.com>
        <20220819005601.198436-2-gshan@redhat.com>
        <87lerkwtm5.wl-maz@kernel.org>
        <41fb5a1f-29a9-e6bb-9fab-4c83a2a8fce5@redhat.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) SEMI-EPG/1.14.7 (Harue)
 FLIM-LB/1.14.9 (=?UTF-8?B?R29qxY0=?=) APEL-LB/10.8 EasyPG/1.0.0 Emacs/27.1
 (x86_64-pc-linux-gnu) MULE/6.0 (HANACHIRUSATO)
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: gshan@redhat.com, kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, peterx@redhat.com, pbonzini@redhat.com, corbet@lwn.net, james.morse@arm.com, alexandru.elisei@arm.com, suzuki.poulose@arm.com, oliver.upton@linux.dev, catalin.marinas@arm.com, will@kernel.org, shuah@kernel.org, seanjc@google.com, drjones@redhat.com, dmatlack@google.com, bgardon@google.com, ricarkol@google.com, zhenyzha@redhat.com, shan.gavin@gmail.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Gavin,

On Mon, 22 Aug 2022 02:58:20 +0100,
Gavin Shan <gshan@redhat.com> wrote:
>=20
> Hi Marc,
>=20
> On 8/19/22 6:00 PM, Marc Zyngier wrote:
> > On Fri, 19 Aug 2022 01:55:57 +0100,
> > Gavin Shan <gshan@redhat.com> wrote:
> >>=20
> >> The ring-based dirty memory tracking has been available and enabled
> >> on x86 for a while. The feature is beneficial when the number of
> >> dirty pages is small in a checkpointing system or live migration
> >> scenario. More details can be found from fb04a1eddb1a ("KVM: X86:
> >> Implement ring-based dirty memory tracking").
> >>=20
> >> This enables the ring-based dirty memory tracking on ARM64. It's
> >> notable that no extra reserved ring entries are needed on ARM64
> >> because the huge pages are always split into base pages when page
> >> dirty tracking is enabled.
> >=20
> > Can you please elaborate on this? Adding a per-CPU ring of course
> > results in extra memory allocation, so there must be a subtle
> > x86-specific detail that I'm not aware of...
> >=20
>=20
> Sure. I guess it's helpful to explain how it works in next revision.
> Something like below:
>=20
> This enables the ring-based dirty memory tracking on ARM64. The feature
> is enabled by CONFIG_HAVE_KVM_DIRTY_RING, detected and enabled by
> CONFIG_HAVE_KVM_DIRTY_RING. A ring buffer is created on every vcpu and
> each entry is described by 'struct kvm_dirty_gfn'. The ring buffer is
> pushed by host when page becomes dirty and pulled by userspace. A vcpu
> exit is forced when the ring buffer becomes full. The ring buffers on
> all vcpus can be reset by ioctl command KVM_RESET_DIRTY_RINGS.
>=20
> Yes, I think so. Adding a per-CPU ring results in extra memory allocation.
> However, it's avoiding synchronization among multiple vcpus when dirty
> pages happen on multiple vcpus. More discussion can be found from [1]

Oh, I totally buy the relaxation of the synchronisation (though I
doubt this will have any visible effect until we have something like
Oliver's patches to allow parallel faulting).

But it is the "no extra reserved ring entries are needed on ARM64"
argument that I don't get yet.


>
> [1] https://patchwork.kernel.org/project/kvm/patch/BL2PR08MB4812F929A2760=
BC40EA757CF0630@BL2PR08MB481.namprd08.prod.outlook.com/
> (comment#8 from Radim Kr=C4=8Dm=C3=A1=C5=99 on May 3, 2016, 2:11 p.m. UTC)
>=20
>=20
> >>=20
> >> Signed-off-by: Gavin Shan <gshan@redhat.com>
> >> ---
> >>   Documentation/virt/kvm/api.rst    | 2 +-
> >>   arch/arm64/include/uapi/asm/kvm.h | 1 +
> >>   arch/arm64/kvm/Kconfig            | 1 +
> >>   arch/arm64/kvm/arm.c              | 8 ++++++++
> >>   4 files changed, 11 insertions(+), 1 deletion(-)
> >>=20
> >> diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/a=
pi.rst
> >> index abd7c32126ce..19fa1ac017ed 100644
> >> --- a/Documentation/virt/kvm/api.rst
> >> +++ b/Documentation/virt/kvm/api.rst
> >> @@ -8022,7 +8022,7 @@ regardless of what has actually been exposed thr=
ough the CPUID leaf.
> >>   8.29 KVM_CAP_DIRTY_LOG_RING
> >>   ---------------------------
> >>   -:Architectures: x86
> >> +:Architectures: x86, arm64
> >>   :Parameters: args[0] - size of the dirty log ring
> >>     KVM is capable of tracking dirty memory using ring buffers that
> >> are
> >> diff --git a/arch/arm64/include/uapi/asm/kvm.h b/arch/arm64/include/ua=
pi/asm/kvm.h
> >> index 3bb134355874..7e04b0b8d2b2 100644
> >> --- a/arch/arm64/include/uapi/asm/kvm.h
> >> +++ b/arch/arm64/include/uapi/asm/kvm.h
> >> @@ -43,6 +43,7 @@
> >>   #define __KVM_HAVE_VCPU_EVENTS
> >>     #define KVM_COALESCED_MMIO_PAGE_OFFSET 1
> >> +#define KVM_DIRTY_LOG_PAGE_OFFSET 64
> >=20
> > For context, the documentation says:
> >=20
> > <quote>
> > - if KVM_CAP_DIRTY_LOG_RING is available, a number of pages at
> >    KVM_DIRTY_LOG_PAGE_OFFSET * PAGE_SIZE. [...]
> > </quote>
> >=20
> > What is the reason for picking this particular value?
> >=20
>=20
> It's inherited from x86. I don't think it has to be this particular
> value.  The value is used to distinguish the region's owners like
> kvm_run, KVM_PIO_PAGE_OFFSET, KVM_COALESCED_MMIO_PAGE_OFFSET, and
> KVM_DIRTY_LOG_PAGE_OFFSET.
>=20
> How about to have 2 for KVM_DIRTY_LOG_PAGE_OFFSET in next revision?
> The virtual area is cheap, I guess it's also nice to use x86's
> pattern to have 64 for KVM_DIRTY_LOG_PAGE_OFFSET.
>=20
>     #define KVM_COALESCED_MMIO_PAGE_OFFSET   1
>     #define KVM_DIRTY_LOG_PAGE_OFFSET        2

Given that this is just an offset in the vcpu "file", I don't think it
matters that much. 64 definitely allows for some struct vcpu growth,
and it doesn't hurt to be compatible with x86 (for once...).

>=20
> >>     #define KVM_REG_SIZE(id)
> >> \
> >>   	(1U << (((id) & KVM_REG_SIZE_MASK) >> KVM_REG_SIZE_SHIFT))
> >> diff --git a/arch/arm64/kvm/Kconfig b/arch/arm64/kvm/Kconfig
> >> index 815cc118c675..0309b2d0f2da 100644
> >> --- a/arch/arm64/kvm/Kconfig
> >> +++ b/arch/arm64/kvm/Kconfig
> >> @@ -32,6 +32,7 @@ menuconfig KVM
> >>   	select KVM_VFIO
> >>   	select HAVE_KVM_EVENTFD
> >>   	select HAVE_KVM_IRQFD
> >> +	select HAVE_KVM_DIRTY_RING
> >>   	select HAVE_KVM_MSI
> >>   	select HAVE_KVM_IRQCHIP
> >>   	select HAVE_KVM_IRQ_ROUTING
> >> diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
> >> index 986cee6fbc7f..3de6b9b39db7 100644
> >> --- a/arch/arm64/kvm/arm.c
> >> +++ b/arch/arm64/kvm/arm.c
> >> @@ -866,6 +866,14 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu)
> >>   		if (!ret)
> >>   			ret =3D 1;
> >>   +		/* Force vcpu exit if its dirty ring is soft-full */
> >> +		if (unlikely(vcpu->kvm->dirty_ring_size &&
> >> +			     kvm_dirty_ring_soft_full(&vcpu->dirty_ring))) {
> >> +			vcpu->run->exit_reason =3D KVM_EXIT_DIRTY_RING_FULL;
> >> +			trace_kvm_dirty_ring_exit(vcpu);
> >> +			ret =3D 0;
> >> +		}
> >> +
> >=20
> > Why can't this be moved to kvm_vcpu_exit_request() instead? I would
> > also very much like the check to be made a common helper with x86.
> >=20
> > A seemingly approach would be to make this a request on dirty log
> > insertion, and avoid the whole "check the log size" on every run,
> > which adds pointless overhead to unsuspecting users (aka everyone).
> >=20
>=20
> I though of having the check in kvm_vcpu_exit_request(). The various
> exit reasons are prioritized. x86 gives KVM_EXIT_DIRTY_RING_FULL the
> highest priority and ARM64 is just to follow. I don't think it really
> matters. I will improve it accordingly in next revision:
>=20
> - Change kvm_dirty_ring_soft_full() to something as below in dirty_ring.c
>=20
>   bool kvm_dirty_ring_soft_full(struct kvm_vcpu *vcpu)
>   {
>        struct kvm *kvm =3D vcpu->vcpu;
>        struct kvm_dirty_ring *ring =3D &vcpu->dirty_ring;
>=20
>        if (unlikely(kvm->dirty_ring_size &&
>                     kvm_dirty_ring_used(ring) >=3D ring->soft_limit)) {
>            vcpu->run->exit_reason =3D KVM_EXIT_DIRTY_RING_FULL;
>            trace_kvm_dirty_ring_exit(vcpu);
>            return true;
>        }
>=20
>        return false;
>   }
>=20
> - Use the modified kvm_dirty_ring_soft_full() in kvm_vcpu_exit_request().
>=20
> Userspace needs KVM_EXIT_DIRTY_RING_FULL to collect the dirty log in time.
> Otherwise, the dirty log in the ring buffer will be overwritten. I'm not
> sure if anything else I missed?

I'm fine with the above, but what I really wanted is a request from
the dirty-ring insertion, instead of a check in kvm_vpcu_exit_request.
Something like this (which obviously doesn't compile, but you'll get
the idea):

diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
index 986cee6fbc7f..0b41feb6fb7d 100644
--- a/arch/arm64/kvm/arm.c
+++ b/arch/arm64/kvm/arm.c
@@ -747,6 +747,12 @@ static int check_vcpu_requests(struct kvm_vcpu *vcpu)
=20
 		if (kvm_check_request(KVM_REQ_SUSPEND, vcpu))
 			return kvm_vcpu_suspend(vcpu);
+
+		if (kvm_check_request(KVM_REQ_RING_SOFT_FULL, vcpu)) {
+			vcpu->run->exit_reason =3D KVM_EXIT_DIRTY_RING_FULL;
+			trace_kvm_dirty_ring_exit(vcpu);
+			return 0;
+		}
 	}
=20
 	return 1;
diff --git a/virt/kvm/dirty_ring.c b/virt/kvm/dirty_ring.c
index f4c2a6eb1666..08b2f01164fa 100644
--- a/virt/kvm/dirty_ring.c
+++ b/virt/kvm/dirty_ring.c
@@ -149,6 +149,7 @@ int kvm_dirty_ring_reset(struct kvm *kvm, struct kvm_di=
rty_ring *ring)
=20
 void kvm_dirty_ring_push(struct kvm_dirty_ring *ring, u32 slot, u64 offset)
 {
+	struct kvm_vcpu *vcpu =3D container_of(ring, struct kvm_vcpu, dirty_ring);
 	struct kvm_dirty_gfn *entry;
=20
 	/* It should never get full */
@@ -166,6 +167,9 @@ void kvm_dirty_ring_push(struct kvm_dirty_ring *ring, u=
32 slot, u64 offset)
 	kvm_dirty_gfn_set_dirtied(entry);
 	ring->dirty_index++;
 	trace_kvm_dirty_ring_push(ring, slot, offset);
+
+	if (kvm_dirty_ring_soft_full(vcpu))
+		kvm_make_request(KVM_REQ_RING_SOFT_FULL, vcpu);
 }
=20
 struct page *kvm_dirty_ring_get_page(struct kvm_dirty_ring *ring, u32 offs=
et)

Thanks,

	M.

--=20
Without deviation from the norm, progress is not possible.
