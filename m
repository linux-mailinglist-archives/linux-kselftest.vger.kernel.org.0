Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91A2A47849C
	for <lists+linux-kselftest@lfdr.de>; Fri, 17 Dec 2021 06:42:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233018AbhLQFms (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 17 Dec 2021 00:42:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233015AbhLQFmr (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 17 Dec 2021 00:42:47 -0500
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7212EC06173F
        for <linux-kselftest@vger.kernel.org>; Thu, 16 Dec 2021 21:42:47 -0800 (PST)
Received: by mail-yb1-xb2f.google.com with SMTP id v64so3291094ybi.5
        for <linux-kselftest@vger.kernel.org>; Thu, 16 Dec 2021 21:42:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atishpatra.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NSzRgyKxQMByJDnhlFllsd6YBcOS/JIx8Ap+A3lLZVg=;
        b=IRPPeiVShrf2EHVF/zr+4wNVsvaB3yZ09DlCKxTDHT/IYnuRNWSJspvOYQqf6SQW32
         TergXgX2aWeH6nRMclgctg1HXcpL4ABn2DGUFSWbhgYU3MPCf13INK4Q9x9DYFFf+H4S
         pYuqEWXwrJ4PkMuareW6NigdpZhNmcTCB9e0w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NSzRgyKxQMByJDnhlFllsd6YBcOS/JIx8Ap+A3lLZVg=;
        b=nZYv+mhIGH2/oA5dasIzzR8l1VHF0MZraOtlGYCAqKqBP9OjqQgI10APMUxmTtaXfW
         +XVCh8Qj4prSwVvGhBzg0z24LNUbd+VU6u2Js2OXd2q11Dv4NL1zY/vAwYGBzbrpBqrq
         mD/OBVhslHf/+gFh69EAJPxyyF/RIAAVXOYk/we2nyjtoO2Y3uMdfCbkf4m3VZDxWQfR
         FYfn7LYt5EYEEW/Ij+Wilyv14zcQ2JijDPTr0+Xm4GA1KxYF94LusXso2E7TwSneOSwP
         yrw6Kr7Q/KDMw6rrwD+yjWiSzMWigVg3BIx4J7oX/ZJPBIMOApeSn2S4wNt0YSVqSE5q
         nH+w==
X-Gm-Message-State: AOAM533E8jk8ire2w6eaiRBTw42S7/SKa5e1aha+qwMVXJLShEvQN8hy
        5c1TpGhGQVIPIVQ1uf9eqKgIIH/C1SDyzWAYK/WQ
X-Google-Smtp-Source: ABdhPJzmQEGSsZWBthsTvOSELeG8VS6EgUDmAeiuIV8vOPQMT9GShkXgjRb8/dyL69PldIEwTWjMSAxbclT2NqOHX4w=
X-Received: by 2002:a05:6902:568:: with SMTP id a8mr2394655ybt.472.1639719766471;
 Thu, 16 Dec 2021 21:42:46 -0800 (PST)
MIME-Version: 1.0
References: <20211129075451.418122-1-anup.patel@wdc.com> <20211129075451.418122-2-anup.patel@wdc.com>
In-Reply-To: <20211129075451.418122-2-anup.patel@wdc.com>
From:   Atish Patra <atishp@atishpatra.org>
Date:   Thu, 16 Dec 2021 21:42:35 -0800
Message-ID: <CAOnJCU+=SfN0e-prQsrR8BHfcs7hP9Ab61cnD-yOEZZQ2Gh9cA@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] RISC-V: KVM: Forward SBI experimental and vendor extensions
To:     Anup Patel <anup.patel@wdc.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        Anup Patel <anup@brainfault.org>,
        KVM General <kvm@vger.kernel.org>,
        kvm-riscv@lists.infradead.org,
        linux-riscv <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Nov 29, 2021 at 12:10 AM Anup Patel <anup.patel@wdc.com> wrote:
>
> The SBI experimental extension space is for temporary (or experimental)
> stuff whereas SBI vendor extension space is for hardware vendor specific
> stuff. Both these SBI extension spaces won't be standardized by the SBI
> specification so let's blindly forward such SBI calls to the userspace.
>
> Signed-off-by: Anup Patel <anup.patel@wdc.com>
> ---
>  arch/riscv/kvm/vcpu_sbi.c      |  4 ++++
>  arch/riscv/kvm/vcpu_sbi_base.c | 27 +++++++++++++++++++++++++++
>  2 files changed, 31 insertions(+)
>
> diff --git a/arch/riscv/kvm/vcpu_sbi.c b/arch/riscv/kvm/vcpu_sbi.c
> index f62d25bc9733..78aa3db76225 100644
> --- a/arch/riscv/kvm/vcpu_sbi.c
> +++ b/arch/riscv/kvm/vcpu_sbi.c
> @@ -46,6 +46,8 @@ extern const struct kvm_vcpu_sbi_extension vcpu_sbi_ext_time;
>  extern const struct kvm_vcpu_sbi_extension vcpu_sbi_ext_ipi;
>  extern const struct kvm_vcpu_sbi_extension vcpu_sbi_ext_rfence;
>  extern const struct kvm_vcpu_sbi_extension vcpu_sbi_ext_hsm;
> +extern const struct kvm_vcpu_sbi_extension vcpu_sbi_ext_experimental;
> +extern const struct kvm_vcpu_sbi_extension vcpu_sbi_ext_vendor;
>
>  static const struct kvm_vcpu_sbi_extension *sbi_ext[] = {
>         &vcpu_sbi_ext_v01,
> @@ -54,6 +56,8 @@ static const struct kvm_vcpu_sbi_extension *sbi_ext[] = {
>         &vcpu_sbi_ext_ipi,
>         &vcpu_sbi_ext_rfence,
>         &vcpu_sbi_ext_hsm,
> +       &vcpu_sbi_ext_experimental,
> +       &vcpu_sbi_ext_vendor,
>  };
>
>  void kvm_riscv_vcpu_sbi_forward(struct kvm_vcpu *vcpu, struct kvm_run *run)
> diff --git a/arch/riscv/kvm/vcpu_sbi_base.c b/arch/riscv/kvm/vcpu_sbi_base.c
> index 641015549d12..ac0537d479d8 100644
> --- a/arch/riscv/kvm/vcpu_sbi_base.c
> +++ b/arch/riscv/kvm/vcpu_sbi_base.c
> @@ -68,3 +68,30 @@ const struct kvm_vcpu_sbi_extension vcpu_sbi_ext_base = {
>         .extid_end = SBI_EXT_BASE,
>         .handler = kvm_sbi_ext_base_handler,
>  };
> +
> +static int kvm_sbi_ext_forward_handler(struct kvm_vcpu *vcpu,
> +                                       struct kvm_run *run,
> +                                       unsigned long *out_val,
> +                                       struct kvm_cpu_trap *utrap,
> +                                       bool *exit)
> +{
> +       /*
> +        * Both SBI experimental and vendor extensions are
> +        * unconditionally forwarded to userspace.
> +        */
> +       kvm_riscv_vcpu_sbi_forward(vcpu, run);
> +       *exit = true;
> +       return 0;
> +}
> +
> +const struct kvm_vcpu_sbi_extension vcpu_sbi_ext_experimental = {
> +       .extid_start = SBI_EXT_EXPERIMENTAL_START,
> +       .extid_end = SBI_EXT_EXPERIMENTAL_END,
> +       .handler = kvm_sbi_ext_forward_handler,
> +};
> +
> +const struct kvm_vcpu_sbi_extension vcpu_sbi_ext_vendor = {
> +       .extid_start = SBI_EXT_VENDOR_START,
> +       .extid_end = SBI_EXT_VENDOR_END,
> +       .handler = kvm_sbi_ext_forward_handler,
> +};
> --
> 2.25.1
>

Reviewed-by: Atish Patra <atishp@rivosinc.com>

--
Regards,
Atish

-- 
Regards,
Atish
