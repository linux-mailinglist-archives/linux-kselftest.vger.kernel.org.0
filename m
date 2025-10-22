Return-Path: <linux-kselftest+bounces-43781-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 45CD9BFDC4D
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 Oct 2025 20:07:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A02941A0493D
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 Oct 2025 18:08:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F84A2EB85C;
	Wed, 22 Oct 2025 18:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="rw6rB9Bf"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 036C235B131;
	Wed, 22 Oct 2025 18:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761156460; cv=none; b=DQco6zE+WA5B26NtHpvQG4rmQIcSX4R84t2uEhd34aqnVyWwrc72shjppQnKPMtWoQ1yuSAemtH61tsu/De2dya7rFEtMahJxQIETvem5YafACEJ/tSqhmnE2czkG05RmQ2VDLQAxVkJvEGmb1PkaFlr2ZFCLoiHL93Z0LMmJC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761156460; c=relaxed/simple;
	bh=KwClc8TIJ/aa8VXU6PCjh3jM6QsiqtI/B38/sCJKFuk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W0kdc9PASAXGgXQSuCsVLHPA79bDtT1CyeQUIvXFlGV9+ZiNEQty56qKrhOBzhrQzlipa5v/cc38ZOqihETg9moQ4SMRu4mv5asZE9ogHRSKJRA4UCpSpVp1/+DaS1grwd+yvSKOHdVRdhc6OcVfleF2PIPTRtFDmIh6IH7Me98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=rw6rB9Bf; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 22 Oct 2025 18:07:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1761156444;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nmt77XqLA4h4HOvjB7cOXuAgnisoHkJ4aQOvVV8s/M8=;
	b=rw6rB9Bfe8keztOgjubqLWih4+bcsU19/noPU5h+QOmbGbjPIY1SQzXgGgOTcIPl7WHDR7
	7ewGlSRgGhn+HGoHKu+MOAmDMx0SBANoxit54V2yE/nLf4MtUh2Mb9Ao/6OONevp4l1GDj
	Y/02wBa3rSWWC8RMQ+HdFtbtijCNYfE=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yosry Ahmed <yosry.ahmed@linux.dev>
To: Jim Mattson <jmattson@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>, 
	Sean Christopherson <seanjc@google.com>, Bibo Mao <maobibo@loongson.cn>, 
	Huacai Chen <chenhuacai@kernel.org>, Andrew Jones <ajones@ventanamicro.com>, 
	Claudio Imbrenda <imbrenda@linux.ibm.com>, "Pratik R. Sampat" <prsampat@amd.com>, 
	Kai Huang <kai.huang@intel.com>, Eric Auger <eric.auger@redhat.com>, linux-kernel@vger.kernel.org, 
	kvm@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 4/4] KVM: selftests: Add a VMX test for LA57 nested state
Message-ID: <w75tgbhxh2izz3fstjt7yx2m3ytybsx34goqzkjwg43zodkvqo@cxathxvemb4q>
References: <20250917215031.2567566-1-jmattson@google.com>
 <20250917215031.2567566-5-jmattson@google.com>
 <4owz4js4mvl4dohgkydcyrdhh2j2xblbwbo7zistocb4knjzdo@kvrzl7vmvg67>
 <CALMp9eRm+xH0b4TUMU3q8Wpo2uo6-OCaY7hD39dVeSm0fA+weA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALMp9eRm+xH0b4TUMU3q8Wpo2uo6-OCaY7hD39dVeSm0fA+weA@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT

On Tue, Oct 21, 2025 at 04:40:14PM -0700, Jim Mattson wrote:
> On Mon, Oct 20, 2025 at 10:26 AM Yosry Ahmed <yosry.ahmed@linux.dev> wrote:
> >
> > On Wed, Sep 17, 2025 at 02:48:40PM -0700, Jim Mattson wrote:
> > > Add a selftest that verifies KVM's ability to save and restore
> > > nested state when the L1 guest is using 5-level paging and the L2
> > > guest is using 4-level paging. Specifically, canonicality tests of
> > > the VMCS12 host-state fields should accept 57-bit virtual addresses.
> > >
> > > Signed-off-by: Jim Mattson <jmattson@google.com>
> > > ---
> > > ...
> > > +void guest_code(struct vmx_pages *vmx_pages)
> > > +{
> > > +     if (vmx_pages)
> > > +             l1_guest_code(vmx_pages);
> >
> > I think none of the other tests do the NULL check. Seems like the test
> > will actually pass if we pass vmx_pages == NULL. I think it's better if
> > we let L1 crash if we mess up the setup.
> 
> I'll drop the check in the next version.
> 
> > > +
> > > +     GUEST_DONE();
> > > +}
> > > +
> > > +int main(int argc, char *argv[])
> > > +{
> > > +     vm_vaddr_t vmx_pages_gva = 0;
> > > +     struct kvm_vm *vm;
> > > +     struct kvm_vcpu *vcpu;
> > > +     struct kvm_x86_state *state;
> > > +     struct ucall uc;
> > > +     int stage;
> > > +
> > > +     TEST_REQUIRE(kvm_cpu_has(X86_FEATURE_VMX));
> > > +     TEST_REQUIRE(kvm_cpu_has(X86_FEATURE_LA57));
> > > +     TEST_REQUIRE(kvm_has_cap(KVM_CAP_NESTED_STATE));
> > > +
> > > +     vm = vm_create_shape_with_one_vcpu(VM_SHAPE(VM_MODE_PXXV57_4K), &vcpu,
> > > +                                        guest_code);
> > > +
> > > +     /*
> > > +      * L1 needs to read its own PML5 table to set up L2. Identity map
> > > +      * the PML5 table to facilitate this.
> > > +      */
> > > +     virt_map(vm, vm->pgd, vm->pgd, 1);
> > > +
> > > +     vcpu_alloc_vmx(vm, &vmx_pages_gva);
> > > +     vcpu_args_set(vcpu, 1, vmx_pages_gva);
> > > +
> > > +     for (stage = 1;; stage++) {
> > > +             vcpu_run(vcpu);
> > > +             TEST_ASSERT_KVM_EXIT_REASON(vcpu, KVM_EXIT_IO);
> > > +
> > > +             switch (get_ucall(vcpu, &uc)) {
> > > +             case UCALL_ABORT:
> > > +                     REPORT_GUEST_ASSERT(uc);
> > > +                     /* NOT REACHED */
> > > +             case UCALL_SYNC:
> > > +                     break;
> > > +             case UCALL_DONE:
> > > +                     goto done;
> > > +             default:
> > > +                     TEST_FAIL("Unknown ucall %lu", uc.cmd);
> > > +             }
> > > +
> > > +             TEST_ASSERT(uc.args[1] == stage,
> > > +                         "Expected stage %d, got stage %lu", stage, (ulong)uc.args[1]);
> > > +             if (stage == 1) {
> > > +                     pr_info("L2 is active; performing save/restore.\n");
> > > +                     state = vcpu_save_state(vcpu);
> > > +
> > > +                     kvm_vm_release(vm);
> > > +
> > > +                     /* Restore state in a new VM. */
> > > +                     vcpu = vm_recreate_with_one_vcpu(vm);
> > > +                     vcpu_load_state(vcpu, state);
> > > +                     kvm_x86_state_cleanup(state);
> >
> > It seems like we only load the vCPU state but we don't actually run it
> > after restoring the nested state. Should we have another stage and run
> > L2 again after the restore? What is the current failure mode without
> > 9245fd6b8531?
> 
> When everything works, we do actually run the vCPU again after
> restoring the nested state. L1 has to execute GUEST_DONE() to exit
> this loop.

Oh I missed the fact that the loop will keep going until GUEST_DONE(),
now it makes sense. I thought we're just checking that restoring the
state will fail.

> 
> Without commit 9245fd6b8531 ("KVM: x86: model canonical checks more
> precisely"), the test fails with:
> 
> KVM_SET_NESTED_STATE failed, rc: -1 errno: 22 (Invalid argument)

Right, this failure would happen even if we do not try to run the vCPU
again tho, which what I initially thought was the case. Sorry for the
noise.

> 
> (And, in that case, we do not re-enter the guest.)
> 
> 
> 
> > > +             }
> > > +     }
> > > +
> > > +done:
> > > +     kvm_vm_free(vm);
> > > +     return 0;
> > > +}
> > > --
> > > 2.51.0.470.ga7dc726c21-goog
> > >

