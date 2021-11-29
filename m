Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCF43460D61
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Nov 2021 04:42:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347803AbhK2Dpo (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 28 Nov 2021 22:45:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347219AbhK2Dno (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 28 Nov 2021 22:43:44 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3382BC06175B
        for <linux-kselftest@vger.kernel.org>; Sun, 28 Nov 2021 19:40:10 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id l16so33578683wrp.11
        for <linux-kselftest@vger.kernel.org>; Sun, 28 Nov 2021 19:40:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MWox7pMHyR0qcRdGS+0RZRCWvfw/dHAAH8xPTK+l3bg=;
        b=Xk+d+xhG4+Z7lzMNFQPU/ZRqqE2Q8Vku4rPID+rdJv5DwOS8XvIvjgfz0tJKLwGm+z
         b/URVPG9yvCfoXpJxi7nBFCEITlxA3qpPxsVoilHt0IeSzbPeVBXP60Caex28GxHOb8k
         gMT0lDAKzhCl+UL6QB8Fl4vqiR9vFAjNgvTPRM30cFs30fnxtn9EYkG3ony7zFw0w/qW
         bFHGact0uqCGI999gHsRBLtleAlwr/xPaaa525Gizp72gEpPEfLPVbOlcb1AqpJP5etE
         05toy7BXQGGXMuuD/8o9onenREXFlOVqEm9oxqLNcgKouOIMYTOY84mhRH8VgUe4NHVB
         YaAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MWox7pMHyR0qcRdGS+0RZRCWvfw/dHAAH8xPTK+l3bg=;
        b=k6J+OmHFKXUgGAenqZxFLWrDr5n2VLLUsezpGvzMEbLdga02emve241ZbmhDsNys3H
         maIrULeFRx1hb+LuhkuXdKeU3EGK1E7rXi4yFh8KJxlA8tDCU9NWI53dgFndVij26K4H
         bpGYe4dYgvpAUOiMbWqOXAuh1CzwoBzPLTDZSJPwV+IFqUiM85vcRsMTQ/+/KyDDs1VG
         QNJonz8JEpu+zbZyCKk5xLYzg1FD3akDzGcagjuFpkoxeJcvZ0XhrCmBpmP1vQO6uYcc
         Y7p281PD7VTYhETSI/AWYH4+TL9jZE6puUi44Dk8faTRaC2tUKuPie9uxkFc35egYHOe
         HEjA==
X-Gm-Message-State: AOAM5315BTVj83Ddzs23eqCvNev64rSnAgnu7o5+j4Ul3ZOZ0hEtPt47
        R7KbqZlB4Nn1JJPwIpULlhIr+Hh48wNXlwM4GEiV1A==
X-Google-Smtp-Source: ABdhPJwxTF4itSodvdNADBx2t3eVLv2fdXR7JyED2RU5O76/w+2bvnAc9HWZucJxJtZvwzvqgEAh8s66khCIOZboUzQ=
X-Received: by 2002:a5d:4f8d:: with SMTP id d13mr29221931wru.89.1638157208592;
 Sun, 28 Nov 2021 19:40:08 -0800 (PST)
MIME-Version: 1.0
References: <20211126154020.342924-1-anup.patel@wdc.com> <20211126154020.342924-2-anup.patel@wdc.com>
 <558e7e30-2d87-a19c-c85c-a2993a354074@redhat.com>
In-Reply-To: <558e7e30-2d87-a19c-c85c-a2993a354074@redhat.com>
From:   Anup Patel <anup@brainfault.org>
Date:   Mon, 29 Nov 2021 09:09:57 +0530
Message-ID: <CAAhSdy2mAHyA04nTOh_XM==moKv1UARpmqt2QhkQwFZo98kwtA@mail.gmail.com>
Subject: Re: [PATCH 1/4] RISC-V: KVM: Forward SBI experimental and vendor extensions
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Anup Patel <anup.patel@wdc.com>, Shuah Khan <shuah@kernel.org>,
        Atish Patra <atishp@atishpatra.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        KVM General <kvm@vger.kernel.org>,
        kvm-riscv@lists.infradead.org,
        linux-riscv <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Nov 26, 2021 at 9:42 PM Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> On 11/26/21 16:40, Anup Patel wrote:
> > +static int kvm_sbi_ext_expevend_handler(struct kvm_vcpu *vcpu,
> > +                                     struct kvm_run *run,
> > +                                     unsigned long *out_val,
> > +                                     struct kvm_cpu_trap *utrap,
> > +                                     bool *exit)
>
> Doesn't really matter what this is used for, it's a handler that
> forwards.  So you can name it kvm_sbi_ext_forward_handler.

Sure, I will rename this to kvm_sbi_ext_forward_handler()

Regards,
Anup

>
> Paolo
>
> > +{
> > +     /*
> > +      * Both SBI experimental and vendor extensions are
> > +      * unconditionally forwarded to userspace.
> > +      */
> > +     kvm_riscv_vcpu_sbi_forward(vcpu, run);
> > +     *exit = true;
> > +     return 0;
> > +}
> > +
>
