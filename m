Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A83F6D351C
	for <lists+linux-kselftest@lfdr.de>; Sun,  2 Apr 2023 02:48:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229997AbjDBAs4 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 1 Apr 2023 20:48:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230023AbjDBAsz (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 1 Apr 2023 20:48:55 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D61BE1A474;
        Sat,  1 Apr 2023 17:48:51 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id p3-20020a17090a74c300b0023f69bc7a68so27207862pjl.4;
        Sat, 01 Apr 2023 17:48:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680396531;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=769fy3W+8GF1XpGTcCE4kXG2vQJMw57gwKdzR53jc/c=;
        b=C35uFhqG5NtAn0jrZKb2bJbdHnL416S5yfJNjxHAS8JipuzCXAhfOW5vJ5+Fgqubm/
         ErFT/A7xVlMA69c9b12nKcITj5lIckjjGFJ2UyXMmPsPLG03oYBETVEvawTLpE1qXRmu
         b/RthQKCArEoLM+3obkXhXR+v09MZaQ3ihNVL3fo1AIWWRZndw7Uu+Hrku8YydhLbP7h
         OdBD+8ZoN/eXPC0FBdeCqyaufRAwnek4yswQBy+U8Uq560fETy9P7Rk49Bj3TNqalsro
         rW5qgaJZg/Mpbd8c01O79Fmoug62pr4IG9sP/PSKrk5fhOJJZC5TKYwXZRFch014v0hm
         karA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680396531;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=769fy3W+8GF1XpGTcCE4kXG2vQJMw57gwKdzR53jc/c=;
        b=sa5vvBz/fGWw+vEhskPJUgrHkXHh75STY5eCop86l7p+cOgvwmcXww5m4Tz19HCqtX
         /YMvqnruG5HO5en7M7+2ztdRk8hCx5a6fJJV8ObDq4flk4WZ/0+NuF1IXH6t0Wba+2c+
         6BtJmRUY5OJJS+z3KrfhkiHFjBqZGIwwWHwZfsACSZIRSfIF+O96qeYPkWKXacZbTF0p
         t1iUXcacDv1nFfzCtzW8nutn2KwNy6nsj1QUxRBoOO4Sh/OWstJ/oz3GuDKdHxI8mtH9
         cvRoKQf2Np5glRhLK4QtJdu672RF4ccDZ+uJGZAtYzdQyLhJy1zlAeob3UC5LzKAMjt1
         cx2Q==
X-Gm-Message-State: AAQBX9dflYHmA+Y7N+5dMJHeivHQ2So870Hztm7Zvpd4NKNBtAZG3inJ
        v+XvTL8N9wTtt11bsqdr9/KeKJL/l7z6BQ==
X-Google-Smtp-Source: AKy350YEF2WyrFngtQH+LlDrGaKYg9D/63daDsHWTW/ihmxZBdOCML6g/5Ytv7vhppScY3Ak8/flZg==
X-Received: by 2002:a17:902:e34c:b0:1a0:69ba:832e with SMTP id p12-20020a170902e34c00b001a069ba832emr26018065plc.0.1680396531251;
        Sat, 01 Apr 2023 17:48:51 -0700 (PDT)
Received: from localhost (121-44-67-49.tpgi.com.au. [121.44.67.49])
        by smtp.gmail.com with ESMTPSA id d19-20020a170902b71300b00198d7b52eefsm3900623pls.257.2023.04.01.17.48.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 01 Apr 2023 17:48:50 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Sun, 02 Apr 2023 10:48:45 +1000
Message-Id: <CRLUUQQWIY0E.6XPIKFXECRBG@bobo>
Cc:     "Paolo Bonzini" <pbonzini@redhat.com>,
        "Shuah Khan" <shuah@kernel.org>, <linuxppc-dev@lists.ozlabs.org>,
        <kvm@vger.kernel.org>, <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH 1/2] KVM: PPC: Add kvm selftests support for powerpc
From:   "Nicholas Piggin" <npiggin@gmail.com>
To:     "Sean Christopherson" <seanjc@google.com>
X-Mailer: aerc 0.13.0
References: <20230316031732.3591455-1-npiggin@gmail.com>
 <20230316031732.3591455-2-npiggin@gmail.com> <ZCSdWc9te0Noiwo3@google.com>
In-Reply-To: <ZCSdWc9te0Noiwo3@google.com>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hey thanks for the review. Points about formatting and style all
valid, I'll tidy those up. For the others,

On Thu Mar 30, 2023 at 6:19 AM AEST, Sean Christopherson wrote:
> On Thu, Mar 16, 2023, Nicholas Piggin wrote:
> > +#ifdef __powerpc__
> > +		TEST_ASSERT(getpagesize() =3D=3D 64*1024,
>
> This can use SZ_64K (we really need to convert a bunch of open coded stuf=
f...)
>
> > +			    "KVM selftests requires 64K host page size\n");
>
> What is the actual requirement?  E.g. is it that the host and guest page =
sizes
> must match, or is that the selftest setup itself only supports 64KiB page=
s?  If
> it's the former, would it make sense to assert outside of the switch stat=
ement, e.g.
>
> diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/s=
elftests/kvm/lib/kvm_util.c
> index 298c4372fb1a..920813a71be0 100644
> --- a/tools/testing/selftests/kvm/lib/kvm_util.c
> +++ b/tools/testing/selftests/kvm/lib/kvm_util.c
> @@ -291,6 +291,10 @@ struct kvm_vm *____vm_create(enum vm_guest_mode mode=
)
>  #ifdef __aarch64__
>         if (vm->pa_bits !=3D 40)
>                 vm->type =3D KVM_VM_TYPE_ARM_IPA_SIZE(vm->pa_bits);
> +#endif
> +#ifdef __powerpc__
> +       TEST_ASSERT(getpagesize() =3D=3D vm->page_size, "blah blah blah")=
;
> +
>  #endif
> =20
>         vm_open(vm);
>
> If it's the latter (selftests limitation), can you add a comment explaini=
ng the
> limitation?

It's the selftests setup, requires both host and guest to be 64k page
size. I think it shouldn't be *too* hard to add any mix of 64k/4k, but
there are a few quirks like requiring pgd to have 64k size allocation.
64/64 is the most important for us, but it would be nice to get other
combos working soon if nothing else than because they don't get as much
testing in other ways.

I can add a comment.

> > +
> > +	/* If needed, create page table */
> > +	if (vm->pgd_created)
> > +		return;
>
> Heh, every arch has this.  Any objection to moving the check to virt_pgd_=
alloc()
> as a prep patch?

I have no objection, I can do that for the next spin.

> > +		"PTE not valid at level: %u gva: 0x%lx pte:0x%lx\n",
> > +		level, gva, pte);
> > +
> > +	return (pte & PTE_PAGE_MASK) + (gva & (vm->page_size - 1));
> > +}
> > +
> > +static void virt_arch_dump_pt(FILE *stream, struct kvm_vm *vm, vm_padd=
r_t pt, vm_vaddr_t va, int level, uint8_t indent)
>
> And here.  Actually, why bother with the helper?  There's one caller, and=
 that
> callers checks pgd_created, i.e. is already assuming its dumping only pag=
e tables.
> Ooh, nevermind, it's recursive.
>
> Can you drop "arch" from the name?  Selftests uses "arch" to tag function=
s that
> are provided by arch code for use in generic code.

Yeah agree, I'll drop that.

> > +			} else {
> > +				virt_arch_dump_pt(stream, vm, pte & PDE_PT_MASK, va, level + 1, in=
dent);
> > +			}
> > +		}
> > +		va +=3D pt_entry_coverage(vm, level);
>
> The shift is constant for vm+level, correct?  In that case, can't this be=
 written
> as
>
> 	for (idx =3D 0; idx < size; idx++, va +=3D va_coverage) {
>
> or even without a snapshot
>
> 	for (idx =3D 0; idx < size; idx++, va +=3D pt_entry_coverage(vm, level))=
 {
>
> That would allow
>
> 		if (!(pte & PTE_VALID)
> 			continue
>
> to reduce the indentation of the printing.

It is constant for a given (vm, level). Good thinking, that should work.

> > +	stack_vaddr =3D __vm_vaddr_alloc(vm, stack_size,
> > +				       DEFAULT_GUEST_STACK_VADDR_MIN,
> > +				       MEM_REGION_DATA);
> > +
> > +	vcpu =3D __vm_vcpu_add(vm, vcpu_id);
> > +
> > +	vcpu_enable_cap(vcpu, KVM_CAP_PPC_PAPR, 1);
> > +
> > +	/* Setup guest registers */
> > +	vcpu_regs_get(vcpu, &regs);
> > +	vcpu_get_reg(vcpu, KVM_REG_PPC_LPCR_64, &lpcr);
> > +
> > +	regs.pc =3D (uintptr_t)guest_code;
> > +	regs.gpr[12] =3D (uintptr_t)guest_code;
> > +	regs.msr =3D 0x8000000002103032ull;
> > +	regs.gpr[1] =3D stack_vaddr + stack_size - 256;
> > +
> > +	if (BYTE_ORDER =3D=3D LITTLE_ENDIAN) {
> > +		regs.msr |=3D 0x1; // LE
> > +		lpcr |=3D 0x0000000002000000; // ILE
>
> Would it be appropriate to add #defines to processor.h instead of open co=
ding the
> magic numbers?

Yes it would. I should have not been lazy about it from the start, will
fix.

(Other comments snipped but agreed for all)

Thanks,
Nick
