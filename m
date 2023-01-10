Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE9FD664C01
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Jan 2023 20:09:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239565AbjAJTIu (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 10 Jan 2023 14:08:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239764AbjAJTIQ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 10 Jan 2023 14:08:16 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A9B62DF1
        for <linux-kselftest@vger.kernel.org>; Tue, 10 Jan 2023 11:07:20 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id 17so14251009pll.0
        for <linux-kselftest@vger.kernel.org>; Tue, 10 Jan 2023 11:07:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=P1yZ2rNXY9+OCT2MctvfeqyzaEmRMSdK9cnP/qUD3es=;
        b=HulWpN3OqpO54u6cPuVDdQltxY/fxlzGQnBNBhw9p/WwPEBiviSDJ+JEav0A4p0BDi
         nQClbKn2krzf5xzUUul+xfQ8+E1acsIqjE6fn5x3WvfOD+FBBySt0bobCk8SE4P1QA3v
         3KIrMOnr1JuzERZButT5IVawEs1vynARr/7ba+m78yiqXzdckTfhlP731gneYD7nyujQ
         paJALe1Nyup2BVE5u8lyjJ4J8N6Co38Yz/vlve8RoldnjQ2zltx+NygJ8UqCyheJkI8f
         zVLNU/dttLt1LZsEOxDgd9Ha/N5pZTykObvqt+m8SFb27i765m8hmcimiImBfGOWVGH5
         xzQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=P1yZ2rNXY9+OCT2MctvfeqyzaEmRMSdK9cnP/qUD3es=;
        b=Zq91UvfQY/VWRZbIjr8REBIHZkX35hA9/WLveSZoOSUPVlXX6unoSXrwfgukbApB4y
         0bYz4HT//jNNn7HGxc35eWvi5Lde0sLpEz58qMHxhVCmnq3FwuRf8IW2ZWcsS24bT0L9
         JL0isJ7S2pS/JZuajjTt2/fH90IohHwPuRNVp3wXxdA90DHzl42Mg1lnvhFObYiP2c/+
         qpp9W+NQ5ucUU0Zb0pCU5cEMG/NusGtM0JVgfm26PHYEu+GiK4k0OnJruXAj2b3gxD4T
         rmXh+adqbmZOpAyS+3LxO0z9GFoiZltI5iTTc8OyQ1fXhe0Kes01v3hZ/KcBkFqVh8yv
         dhrw==
X-Gm-Message-State: AFqh2kobEDlG9q9elcxn/HzaPFjK9/4zkHzb+NZW4ItYjkfdEvU4eD/F
        9CTQdP3nn57Hiu1Cs4ykQdzCQA==
X-Google-Smtp-Source: AMrXdXvPJCjnKjpu/C3fOnUqxkmb0rowb3o4CPE21MAZXvaWlO9x+E+NcO57ODSh2Du+60yMYtseqQ==
X-Received: by 2002:a05:6a20:1394:b0:b5:a970:8d5a with SMTP id w20-20020a056a20139400b000b5a9708d5amr152380pzh.0.1673377639322;
        Tue, 10 Jan 2023 11:07:19 -0800 (PST)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id r4-20020aa79624000000b0056bd1bf4243sm8484018pfg.53.2023.01.10.11.07.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jan 2023 11:07:18 -0800 (PST)
Date:   Tue, 10 Jan 2023 19:07:15 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Emanuele Giuseppe Esposito <eesposit@redhat.com>,
        Maxim Levitsky <mlevitsk@redhat.com>, kvm@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, Shuah Khan <shuah@kernel.org>,
        Gautam Menghani <gautammenghani201@gmail.com>,
        Zeng Guang <guang.zeng@intel.com>,
        Krish Sadhukhan <krish.sadhukhan@oracle.com>,
        Jim Mattson <jmattson@google.com>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [RFC PATCH 1/2] KVM: x86: update APIC_ID also when disabling
 x2APIC in kvm_lapic_set_baseg
Message-ID: <Y723YwUj/0+U++jI@google.com>
References: <20230109130605.2013555-1-eesposit@redhat.com>
 <20230109130605.2013555-2-eesposit@redhat.com>
 <c61ce1a6393a108c76e53cb99249aba5ab318e07.camel@redhat.com>
 <Y7w/bYP4VGqoVcjH@google.com>
 <5664d006-9452-2033-5605-48aa0ee77ca8@redhat.com>
 <fa0758f5-abd1-ad09-3878-adf296c7aac5@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <fa0758f5-abd1-ad09-3878-adf296c7aac5@redhat.com>
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

On Tue, Jan 10, 2023, Paolo Bonzini wrote:
> On 1/10/23 13:16, Emanuele Giuseppe Esposito wrote:
> > I think the test in patch 2 I wrote gives a better idea on what I am
> > trying to fix:

Tests and descriptions of expected s vs. actual behavior explain what _you_ think
should happen, but don't help explain what higher level bug is being fixed.  IIUC,
QEMU emulates RESET and expects the xAPIC ID to be re-initialized.  That's the
info that should be provided in the changelog since it ties KVM behavior to a
real world userspace emulating actual hardware behavior.

> > if we are transitioning from x2APIC to xAPIC (RESET I
> > would say, even though I am not sure if userspace really does it in the
> > way I do it in the test, ie through KVM_SET_MSRS), the APIC_ID is not
> > updated back in the right bits, and we can see that by querying the ID
> > with KVM_GET_LAPIC after disabling x2APIC.
> > 
> > Now, if the way I reproduce this issue is correct, it is indeed a bug
> > and needs to be fixed with the fix in patch 1 or something similar.
> > I think it won't really make any difference if instead following what
> > the doc says (x2APIC -> disabled -> xAPIC) we directly do x2APIC -> xAPIC.
> 
> Yes, the default value at reset is xAPIC mode, so a reset will do a
> KVM_SET_MSRS that clears X2APIC_ENABLE but leaves
> MSR_IA32_APICBASE_ENABLE set.
> 
> So, if I understand correctly...
> 
> > The test in patch 2 started being developed to test ef40757743b47 ("KVM:
> > x86: fix APICv/x2AVIC disabled when vm reboot by itself") even though I
> > honestly didn't really understand how to replicate that bug (see cover
> > letter) and instead I found this other possibility that still manages to
> > screw APIC_ID.
> 
> ... what you're saying is that there were two different bugs, but one
> fixing any one of them was enough to prevent the symptoms shown by
> commit ef40757743b47?  That is:
> 
> - the APICv inhibit was set by KVM_GET_LAPIC because it called
> kvm_lapic_xapic_id_updated(), and the call was unnecessary as fixed in
> commit ef40757743b47;
> 
> - however, there is no reason for the vCPU ID to be mismatched.  It
> happened because the code didn't handle the host-initiated x2APIC->xAPIC
> case and thus lacked a call to kvm_apic_set_xapic_id().
> 
> If so, I think the idea of the patch is fine.
> 
> Just one thing: your patch also changes the APIC_ID on the
> x2APIC->disabled transition, not just the "forbidden" (i.e. host-
> initiated only) x2APIC->xAPIC transition.  I think  this is okay too: the
> manual says:
>
>    10.4.3 Enabling or Disabling the Local APIC
> 
>    When IA32_APIC_BASE[11] is set to 0, prior initialization to the APIC
>    may be lost and the APIC may return to the state described in Section
>    10.4.7.1, “Local APIC State After Power-Up or Reset.”
> 
>    10.4.7.1 Local APIC State After Power-Up or Reset
> 
>    ... The local APIC ID register is set to a unique APIC ID. ...
> 
> (which must be an xAPIC ID) and this is what your patch does.

Ugh, couldn't find that yesterday.  It's actually irrelevant though, KVM already
stuffs the APIC ID when the APIC goes from DISABLED to ENABLED (xAPIC) since commit:

  49bd29ba1dbd ("KVM: x86: reset APIC ID when enabling LAPIC")

For giggles, and because I misread that like 5 times, I tested on hardware.  Intel
CPUs since at least Haswell make the APIC ID read-only, i.e. it's a moot point on
Intel these days.  But on AMD, the APIC ID is preserved across disabling => enabling
xAPIC.

> In fact perhaps you can change the code further to invoke
> kvm_lapic_reset() after static_branch_inc(&apic_hw_disabled.key)?  It's
> just a bit messy that you have a call back to kvm_lapic_set_base() in
> there, so perhaps something like this can help:

I'd rather not touch kvm_lapic_reset().  KVM doesn't emulate RESET, and I don't
want to make assumptions about why userspace is forcing x2APIC => xAPIC.  If
userspace wants to propery emulate RESET, it can use KVM_SET_LAPIC.

My preference is to do a light tweak on the original patch, with a rewritten
shortlog and changelog.  And because I spent way, way too much time digging into
this, I went a bit overboard...

From: Sean Christopherson <seanjc@google.com>
Date: Tue, 10 Jan 2023 10:40:33 -0800
Subject: [PATCH] KVM: x86: Reinitialize xAPIC ID when userspace forces x2APIC
 => xAPIC
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Reinitialize the xAPIC ID to the vCPU ID when userspace forces the APIC
to transition directly from x2APIC to xAPIC mode, e.g. to emulate RESET.
KVM already stuffs the xAPIC ID when the APIC is transitioned from
DISABLED to xAPIC (commit 49bd29ba1dbd ("KVM: x86: reset APIC ID when
enabling LAPIC")), i.e. userspace is conditioned to expect KVM to update
the xAPIC ID, but KVM doesn't handle the architecturally-impossible case
where userspace forces x2APIC=>xAPIC via KVM_SET_MSRS.

On its own, the "bug" is benign, as userspace emulation of RESET will also
stuff APIC registers via KVM_SET_LAPIC, i.e. will manually set the xAPIC
ID.  However, commit 3743c2f02517 ("KVM: x86: inhibit APICv/AVIC on
changes to APIC ID or APIC base") introduced a bug, fixed by commit
commit ef40757743b4 ("KVM: x86: fix APICv/x2AVIC disabled when vm reboot
by itself"), that caused KVM to fail to properly update the xAPIC ID when
handling KVM_SET_LAPIC.  Refresh the xAPIC ID even though it's not
strictly necessary so that KVM provides consistent behavior.

Note, KVM follows Intel architecture with regard to handling the xAPIC ID
and x2APIC IDs across mode transitions.  For the APIC DISABLED case
(commit 49bd29ba1dbd), Intel's SDM says the xAPIC ID _may_ be
reinitialized

    10.4.3 Enabling or Disabling the Local APIC

    When IA32_APIC_BASE[11] is set to 0, prior initialization to the APIC
    may be lost and the APIC may return to the state described in Section
    10.4.7.1, “Local APIC State After Power-Up or Reset.”

    10.4.7.1 Local APIC State After Power-Up or Reset

    ... The local APIC ID register is set to a unique APIC ID. ...

i.e. KVM's behavior is legal as per Intel's architecture.   In practice,
Intel's behavior is N/A as modern Intel CPUs (since at least Haswell) make
the xAPIC ID fully read-only.

And for xAPIC => x2APIC transitions (commit 257b9a5faab5 ("KVM: x86: use
correct APIC ID on x2APIC transition")), Intel's SDM says:

  Any APIC ID value written to the memory-mapped local APIC ID register
  is not preserved.

AMD's APM says nothing (that I could find) about the xAPIC ID when the
APIC is DISABLED, but testing on bare metal (Rome) shows that the xAPIC ID
is preserved when the APIC is DISABLED and re-enabled in xAPIC mode.  AMD
also preserves the xAPIC ID when the APIC is transitioned from xAPIC to
x2APIC, i.e. allows a backdoor write of the x2APIC ID, which is again not
emulated by KVM.

Reported-by: Emanuele Giuseppe Esposito <eesposit@redhat.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/lapic.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kvm/lapic.c b/arch/x86/kvm/lapic.c
index 80f92cbc4029..79141d76ad49 100644
--- a/arch/x86/kvm/lapic.c
+++ b/arch/x86/kvm/lapic.c
@@ -2485,8 +2485,12 @@ void kvm_lapic_set_base(struct kvm_vcpu *vcpu, u64 value)
 		}
 	}
 
-	if (((old_value ^ value) & X2APIC_ENABLE) && (value & X2APIC_ENABLE))
-		kvm_apic_set_x2apic_id(apic, vcpu->vcpu_id);
+	if ((old_value ^ value) & X2APIC_ENABLE) {
+		if (value & X2APIC_ENABLE)
+			kvm_apic_set_x2apic_id(apic, vcpu->vcpu_id);
+		else if (value & MSR_IA32_APICBASE_ENABLE)
+			kvm_apic_set_xapic_id(apic, vcpu->vcpu_id);
+	}
 
 	if ((old_value ^ value) & (MSR_IA32_APICBASE_ENABLE | X2APIC_ENABLE)) {
 		kvm_make_request(KVM_REQ_APICV_UPDATE, vcpu);

base-commit: 91dc252b0dbb6879e4067f614df1e397fec532a1
-- 

