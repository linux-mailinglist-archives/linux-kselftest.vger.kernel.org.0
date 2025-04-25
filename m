Return-Path: <linux-kselftest+bounces-31641-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BB782A9C8C1
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Apr 2025 14:16:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D41101BC0933
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Apr 2025 12:16:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF58623D2A1;
	Fri, 25 Apr 2025 12:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b="vzVhMsX8"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-il1-f173.google.com (mail-il1-f173.google.com [209.85.166.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E801723BCF1
	for <linux-kselftest@vger.kernel.org>; Fri, 25 Apr 2025 12:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745583383; cv=none; b=MrBvpqYTF+GeSUd/nosB4trWHD3noIQztOxVZ4XTyjMsmjRVhn8bYCDaN7c/uBggciobaqlUyIy6ntN+//lVGoG/K5RHPIkZgE5J7Ms783NZ5AVKKr342jeOGEYf6fVuSgu73kLahYmWHDBuvsPzwhRIQ0wtn/sHeCH/ilys/iw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745583383; c=relaxed/simple;
	bh=AGdsNfPOT4ZJ36IEZCGFqThGojslbdmK8SRR0ccO4M4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iCDBrRFOs0jKryAv3Ey5qhi8nKcUQZcO3z85udo/8gt8BhErG2Tur5x5070/KmWGQcxVB76hKmX4bRJMlk6mBb5Su+1qEtShm1EtarTkg3yNbEPDBsa966mVFKoVEhFkz6/9E7bg1ilT+P8+b4bFtC7jx5ogQGFWueYgolEGUiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org; spf=none smtp.mailfrom=brainfault.org; dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b=vzVhMsX8; arc=none smtp.client-ip=209.85.166.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=brainfault.org
Received: by mail-il1-f173.google.com with SMTP id e9e14a558f8ab-3d93deba52fso1152975ab.0
        for <linux-kselftest@vger.kernel.org>; Fri, 25 Apr 2025 05:16:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20230601.gappssmtp.com; s=20230601; t=1745583381; x=1746188181; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sR1QWT7RZw6vjjuErAm9wdIpbaItJ2RsLcPIqcHp4h8=;
        b=vzVhMsX8KKzNKROZCMAfudC9Ppa+2Ko9j1Qa7cq6qSqDOmYYL+YpMfDZZfPzuUtqAs
         7IkJdGQBp8IeloQ1HC85d/BE+2cZI97IMCOvcjQgwM6LOgmTgx3C62YI2pqIhyGvkR62
         cq1CQVCC20BzVdKXdsQ1cdrJwxtjHFtL0OpDXGwrphelFkhsvcbLOFHe8aYUytEnPMaf
         cS+9xFZ/qc+eYwUleGXMbtGotoFWOAXfxv82QonQAYGZkxWOovinPu/FqgQTPc70Zjw/
         B1ztEBs5GHpGs9TinciF4IyIcUXSnin6+umylixul00Bt+Epx7ZNcHzOrjdG1ZAFse5h
         +WbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745583381; x=1746188181;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sR1QWT7RZw6vjjuErAm9wdIpbaItJ2RsLcPIqcHp4h8=;
        b=F0nDnx0VN8qKVkKaPb4Np3eqo3Dq8+Rl2bsQx5OfFA9dnaAedA+G8AIA4qI4jxylaJ
         9f7MKGtCgTIoVf2ENnxx1CApsuQymK3obQ7N9Twpw9Tzc8hANyyTH0Hlr87tyJYy5FFI
         ffV9pFtwlQCJx7rNAD18HsFS+3e2ZBVfOUjYpXPYx8ojQVusZYmJOaug+h99AS4X1B1T
         HE6KbJ+cL8lEAQfEk50zwonMvrs2DJCXnyU3xEzh67erFAW7FCNlbAxUOYGYEsd/2x8a
         D4YXfOhOFYia5Ow70HFjh/VEWMd/nm/o5CiTpw0THs5D18RjL9v6yYwHFYi+GOUT77nz
         /VYw==
X-Forwarded-Encrypted: i=1; AJvYcCUU8WKJSuGhDh7UL9h469AesfBdlGpL2+4M7l36O3cF4TIjKCOZAStQJyagYhiaDr/2tUtH5usQfpNalYI1B90=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQjzmwu0k0/9a7vX6LTPfjMn1Kenq2K/N5k4k+/UX+bzmHwm8E
	crcuskClfGr8QxrabTgCBCyvbYe4OYw3KWE2uLmTA5oHGFAAUIEJhytx/o4shAcPHYgQZCUv5cc
	j0oMQOdk1JGoJrsNUssbDnfH7vRvZNQsA0VMx5g==
X-Gm-Gg: ASbGnctXw9/pBAqM9wdN62Btg3baHyPdR6k0hEgFovc6PYZVA+I+x6fb99cyzs0djvo
	BYW14KxED7VIkZyCpK2M7AfGcJc/VnYzenagvUQzGIQV5s3Lvny+54mWJ9O9yZR1LEPMgV3UAgw
	3QvrKo9FX83MKMN3TV00oJuVE=
X-Google-Smtp-Source: AGHT+IHUI0f5u3ysZDKjk7ru2v+4bEO8MrX1EvOnO6NfeJTcIQj/ItlgMUItxvWEQmMSKvrKfKiMcTX9TqwiJ6k+zKk=
X-Received: by 2002:a05:6e02:154b:b0:3cf:bac5:d90c with SMTP id
 e9e14a558f8ab-3d93b5713bamr16983295ab.18.1745583380884; Fri, 25 Apr 2025
 05:16:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250324-kvm_selftest_improve-v1-0-583620219d4f@rivosinc.com> <20250324-kvm_selftest_improve-v1-3-583620219d4f@rivosinc.com>
In-Reply-To: <20250324-kvm_selftest_improve-v1-3-583620219d4f@rivosinc.com>
From: Anup Patel <anup@brainfault.org>
Date: Fri, 25 Apr 2025 17:46:09 +0530
X-Gm-Features: ATxdqUHOv11PvgP9nPj69AiTxCtGGOn3N9GW7InbiMASP_G6lX5jdncyYKfQBj0
Message-ID: <CAAhSdy2YocSNuOVbfoh6juDrw48YhsugGoRS8yXHOREZY91BOQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] KVM: riscv: selftests: Add vector extension tests
To: Atish Patra <atishp@rivosinc.com>
Cc: Atish Patra <atishp@atishpatra.org>, Paolo Bonzini <pbonzini@redhat.com>, 
	Shuah Khan <shuah@kernel.org>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Alexandre Ghiti <alex@ghiti.fr>, kvm@vger.kernel.org, 
	kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 25, 2025 at 6:10=E2=80=AFAM Atish Patra <atishp@rivosinc.com> w=
rote:
>
> Add vector related tests with the ISA extension standard template.
> However, the vector registers are bit tricky as the register length is
> variable based on vlenb value of the system. That's why the macros are
> defined with a default and overidden with actual value at runtime.
>
> Signed-off-by: Atish Patra <atishp@rivosinc.com>

LGTM.

Reviewed-by: Anup Patel <anup@brainfault.org>

Regards,
Anup

> ---
>  tools/testing/selftests/kvm/riscv/get-reg-list.c | 111 +++++++++++++++++=
+++++-
>  1 file changed, 110 insertions(+), 1 deletion(-)
>
> diff --git a/tools/testing/selftests/kvm/riscv/get-reg-list.c b/tools/tes=
ting/selftests/kvm/riscv/get-reg-list.c
> index 8515921dfdbf..576ab8eb7368 100644
> --- a/tools/testing/selftests/kvm/riscv/get-reg-list.c
> +++ b/tools/testing/selftests/kvm/riscv/get-reg-list.c
> @@ -145,7 +145,9 @@ void finalize_vcpu(struct kvm_vcpu *vcpu, struct vcpu=
_reg_list *c)
>  {
>         unsigned long isa_ext_state[KVM_RISCV_ISA_EXT_MAX] =3D { 0 };
>         struct vcpu_reg_sublist *s;
> -       uint64_t feature;
> +       uint64_t feature =3D 0;
> +       u64 reg, size;
> +       unsigned long vlenb_reg;
>         int rc;
>
>         for (int i =3D 0; i < KVM_RISCV_ISA_EXT_MAX; i++)
> @@ -173,6 +175,23 @@ void finalize_vcpu(struct kvm_vcpu *vcpu, struct vcp=
u_reg_list *c)
>                 switch (s->feature_type) {
>                 case VCPU_FEATURE_ISA_EXT:
>                         feature =3D RISCV_ISA_EXT_REG(s->feature);
> +                       if (s->feature =3D=3D KVM_RISCV_ISA_EXT_V) {
> +                               /* Enable V extension so that we can get =
the vlenb register */
> +                               __vcpu_set_reg(vcpu, feature, 1);
> +                               /* Compute the correct vector register si=
ze */
> +                               rc =3D __vcpu_get_reg(vcpu, s->regs[4], &=
vlenb_reg);
> +                               if (rc < 0)
> +                               /* The vector test may fail if the defaul=
t reg size doesn't match */
> +                                       break;
> +                               size =3D __builtin_ctzl(vlenb_reg);
> +                               size <<=3D KVM_REG_SIZE_SHIFT;
> +                               for (int i =3D 0; i < 32; i++) {
> +                                       reg =3D KVM_REG_RISCV | KVM_REG_R=
ISCV_VECTOR | size |
> +                                             KVM_REG_RISCV_VECTOR_REG(i)=
;
> +                                       s->regs[5 + i] =3D reg;
> +                               }
> +                               __vcpu_set_reg(vcpu, feature, 0);
> +                       }
>                         break;
>                 case VCPU_FEATURE_SBI_EXT:
>                         feature =3D RISCV_SBI_EXT_REG(s->feature);
> @@ -408,6 +427,35 @@ static const char *fp_d_id_to_str(const char *prefix=
, __u64 id)
>         return strdup_printf("%lld /* UNKNOWN */", reg_off);
>  }
>
> +static const char *vector_id_to_str(const char *prefix, __u64 id)
> +{
> +       /* reg_off is the offset into struct __riscv_v_ext_state */
> +       __u64 reg_off =3D id & ~(REG_MASK | KVM_REG_RISCV_VECTOR);
> +       int reg_index =3D 0;
> +
> +       assert((id & KVM_REG_RISCV_TYPE_MASK) =3D=3D KVM_REG_RISCV_VECTOR=
);
> +
> +       if (reg_off >=3D KVM_REG_RISCV_VECTOR_REG(0))
> +               reg_index =3D reg_off -  KVM_REG_RISCV_VECTOR_REG(0);
> +       switch (reg_off) {
> +       case KVM_REG_RISCV_VECTOR_REG(0) ...
> +            KVM_REG_RISCV_VECTOR_REG(31):
> +               return strdup_printf("KVM_REG_RISCV_VECTOR_REG(%d)", reg_=
index);
> +       case KVM_REG_RISCV_VECTOR_CSR_REG(vstart):
> +               return "KVM_REG_RISCV_VECTOR_CSR_REG(vstart)";
> +       case KVM_REG_RISCV_VECTOR_CSR_REG(vl):
> +               return "KVM_REG_RISCV_VECTOR_CSR_REG(vl)";
> +       case KVM_REG_RISCV_VECTOR_CSR_REG(vtype):
> +               return "KVM_REG_RISCV_VECTOR_CSR_REG(vtype)";
> +       case KVM_REG_RISCV_VECTOR_CSR_REG(vcsr):
> +               return "KVM_RISCV_VCPU_VECTOR_CSR_REG(vcsr)";
> +       case KVM_REG_RISCV_VECTOR_CSR_REG(vlenb):
> +               return "KVM_REG_RISCV_VECTOR_CSR_REG(vlenb)";
> +       }
> +
> +       return strdup_printf("%lld /* UNKNOWN */", reg_off);
> +}
> +
>  #define KVM_ISA_EXT_ARR(ext)           \
>  [KVM_RISCV_ISA_EXT_##ext] =3D "KVM_REG_RISCV_ISA_SINGLE | KVM_RISCV_ISA_=
EXT_" #ext
>
> @@ -635,6 +683,9 @@ void print_reg(const char *prefix, __u64 id)
>         case KVM_REG_SIZE_U128:
>                 reg_size =3D "KVM_REG_SIZE_U128";
>                 break;
> +       case KVM_REG_SIZE_U256:
> +               reg_size =3D "KVM_REG_SIZE_U256";
> +               break;
>         default:
>                 printf("\tKVM_REG_RISCV | (%lld << KVM_REG_SIZE_SHIFT) | =
0x%llx /* UNKNOWN */,\n",
>                        (id & KVM_REG_SIZE_MASK) >> KVM_REG_SIZE_SHIFT, id=
 & ~REG_MASK);
> @@ -666,6 +717,10 @@ void print_reg(const char *prefix, __u64 id)
>                 printf("\tKVM_REG_RISCV | %s | KVM_REG_RISCV_FP_D | %s,\n=
",
>                                 reg_size, fp_d_id_to_str(prefix, id));
>                 break;
> +       case KVM_REG_RISCV_VECTOR:
> +               printf("\tKVM_REG_RISCV | %s | KVM_REG_RISCV_VECTOR | %s,=
\n",
> +                      reg_size, vector_id_to_str(prefix, id));
> +               break;
>         case KVM_REG_RISCV_ISA_EXT:
>                 printf("\tKVM_REG_RISCV | %s | KVM_REG_RISCV_ISA_EXT | %s=
,\n",
>                                 reg_size, isa_ext_id_to_str(prefix, id));
> @@ -870,6 +925,54 @@ static __u64 fp_d_regs[] =3D {
>         KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_ISA_EXT | KVM_=
REG_RISCV_ISA_SINGLE | KVM_RISCV_ISA_EXT_D,
>  };
>
> +/* Define a default vector registers with length. This will be overwritt=
en at runtime */
> +static __u64 vector_regs[] =3D {
> +       KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_VECTOR |
> +       KVM_REG_RISCV_VECTOR_CSR_REG(vstart),
> +       KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_VECTOR |
> +       KVM_REG_RISCV_VECTOR_CSR_REG(vl),
> +       KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_VECTOR |
> +       KVM_REG_RISCV_VECTOR_CSR_REG(vtype),
> +       KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_VECTOR |
> +       KVM_REG_RISCV_VECTOR_CSR_REG(vcsr),
> +       KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_VECTOR |
> +       KVM_REG_RISCV_VECTOR_CSR_REG(vlenb),
> +       KVM_REG_RISCV | KVM_REG_SIZE_U128 | KVM_REG_RISCV_VECTOR | KVM_RE=
G_RISCV_VECTOR_REG(0),
> +       KVM_REG_RISCV | KVM_REG_SIZE_U128 | KVM_REG_RISCV_VECTOR | KVM_RE=
G_RISCV_VECTOR_REG(1),
> +       KVM_REG_RISCV | KVM_REG_SIZE_U128 | KVM_REG_RISCV_VECTOR | KVM_RE=
G_RISCV_VECTOR_REG(2),
> +       KVM_REG_RISCV | KVM_REG_SIZE_U128 | KVM_REG_RISCV_VECTOR | KVM_RE=
G_RISCV_VECTOR_REG(3),
> +       KVM_REG_RISCV | KVM_REG_SIZE_U128 | KVM_REG_RISCV_VECTOR | KVM_RE=
G_RISCV_VECTOR_REG(4),
> +       KVM_REG_RISCV | KVM_REG_SIZE_U128 | KVM_REG_RISCV_VECTOR | KVM_RE=
G_RISCV_VECTOR_REG(5),
> +       KVM_REG_RISCV | KVM_REG_SIZE_U128 | KVM_REG_RISCV_VECTOR | KVM_RE=
G_RISCV_VECTOR_REG(6),
> +       KVM_REG_RISCV | KVM_REG_SIZE_U128 | KVM_REG_RISCV_VECTOR | KVM_RE=
G_RISCV_VECTOR_REG(7),
> +       KVM_REG_RISCV | KVM_REG_SIZE_U128 | KVM_REG_RISCV_VECTOR | KVM_RE=
G_RISCV_VECTOR_REG(8),
> +       KVM_REG_RISCV | KVM_REG_SIZE_U128 | KVM_REG_RISCV_VECTOR | KVM_RE=
G_RISCV_VECTOR_REG(9),
> +       KVM_REG_RISCV | KVM_REG_SIZE_U128 | KVM_REG_RISCV_VECTOR | KVM_RE=
G_RISCV_VECTOR_REG(10),
> +       KVM_REG_RISCV | KVM_REG_SIZE_U128 | KVM_REG_RISCV_VECTOR | KVM_RE=
G_RISCV_VECTOR_REG(11),
> +       KVM_REG_RISCV | KVM_REG_SIZE_U128 | KVM_REG_RISCV_VECTOR | KVM_RE=
G_RISCV_VECTOR_REG(12),
> +       KVM_REG_RISCV | KVM_REG_SIZE_U128 | KVM_REG_RISCV_VECTOR | KVM_RE=
G_RISCV_VECTOR_REG(13),
> +       KVM_REG_RISCV | KVM_REG_SIZE_U128 | KVM_REG_RISCV_VECTOR | KVM_RE=
G_RISCV_VECTOR_REG(14),
> +       KVM_REG_RISCV | KVM_REG_SIZE_U128 | KVM_REG_RISCV_VECTOR | KVM_RE=
G_RISCV_VECTOR_REG(15),
> +       KVM_REG_RISCV | KVM_REG_SIZE_U128 | KVM_REG_RISCV_VECTOR | KVM_RE=
G_RISCV_VECTOR_REG(16),
> +       KVM_REG_RISCV | KVM_REG_SIZE_U128 | KVM_REG_RISCV_VECTOR | KVM_RE=
G_RISCV_VECTOR_REG(17),
> +       KVM_REG_RISCV | KVM_REG_SIZE_U128 | KVM_REG_RISCV_VECTOR | KVM_RE=
G_RISCV_VECTOR_REG(18),
> +       KVM_REG_RISCV | KVM_REG_SIZE_U128 | KVM_REG_RISCV_VECTOR | KVM_RE=
G_RISCV_VECTOR_REG(19),
> +       KVM_REG_RISCV | KVM_REG_SIZE_U128 | KVM_REG_RISCV_VECTOR | KVM_RE=
G_RISCV_VECTOR_REG(20),
> +       KVM_REG_RISCV | KVM_REG_SIZE_U128 | KVM_REG_RISCV_VECTOR | KVM_RE=
G_RISCV_VECTOR_REG(21),
> +       KVM_REG_RISCV | KVM_REG_SIZE_U128 | KVM_REG_RISCV_VECTOR | KVM_RE=
G_RISCV_VECTOR_REG(22),
> +       KVM_REG_RISCV | KVM_REG_SIZE_U128 | KVM_REG_RISCV_VECTOR | KVM_RE=
G_RISCV_VECTOR_REG(23),
> +       KVM_REG_RISCV | KVM_REG_SIZE_U128 | KVM_REG_RISCV_VECTOR | KVM_RE=
G_RISCV_VECTOR_REG(24),
> +       KVM_REG_RISCV | KVM_REG_SIZE_U128 | KVM_REG_RISCV_VECTOR | KVM_RE=
G_RISCV_VECTOR_REG(25),
> +       KVM_REG_RISCV | KVM_REG_SIZE_U128 | KVM_REG_RISCV_VECTOR | KVM_RE=
G_RISCV_VECTOR_REG(26),
> +       KVM_REG_RISCV | KVM_REG_SIZE_U128 | KVM_REG_RISCV_VECTOR | KVM_RE=
G_RISCV_VECTOR_REG(27),
> +       KVM_REG_RISCV | KVM_REG_SIZE_U128 | KVM_REG_RISCV_VECTOR | KVM_RE=
G_RISCV_VECTOR_REG(28),
> +       KVM_REG_RISCV | KVM_REG_SIZE_U128 | KVM_REG_RISCV_VECTOR | KVM_RE=
G_RISCV_VECTOR_REG(29),
> +       KVM_REG_RISCV | KVM_REG_SIZE_U128 | KVM_REG_RISCV_VECTOR | KVM_RE=
G_RISCV_VECTOR_REG(30),
> +       KVM_REG_RISCV | KVM_REG_SIZE_U128 | KVM_REG_RISCV_VECTOR | KVM_RE=
G_RISCV_VECTOR_REG(31),
> +       KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_ISA_EXT | KVM_=
REG_RISCV_ISA_SINGLE |
> +       KVM_RISCV_ISA_EXT_V,
> +};
> +
>  #define SUBLIST_BASE \
>         {"base", .regs =3D base_regs, .regs_n =3D ARRAY_SIZE(base_regs), =
\
>          .skips_set =3D base_skips_set, .skips_set_n =3D ARRAY_SIZE(base_=
skips_set),}
> @@ -894,6 +997,10 @@ static __u64 fp_d_regs[] =3D {
>         {"fp_d", .feature =3D KVM_RISCV_ISA_EXT_D, .regs =3D fp_d_regs, \
>                 .regs_n =3D ARRAY_SIZE(fp_d_regs),}
>
> +#define SUBLIST_V \
> +       {"v", .feature =3D KVM_RISCV_ISA_EXT_V, .regs =3D vector_regs, \
> +               .regs_n =3D ARRAY_SIZE(vector_regs),}
> +
>  #define KVM_ISA_EXT_SIMPLE_CONFIG(ext, extu)                   \
>  static __u64 regs_##ext[] =3D {                                  \
>         KVM_REG_RISCV | KVM_REG_SIZE_ULONG |                    \
> @@ -962,6 +1069,7 @@ KVM_SBI_EXT_SIMPLE_CONFIG(susp, SUSP);
>  KVM_ISA_EXT_SUBLIST_CONFIG(aia, AIA);
>  KVM_ISA_EXT_SUBLIST_CONFIG(fp_f, FP_F);
>  KVM_ISA_EXT_SUBLIST_CONFIG(fp_d, FP_D);
> +KVM_ISA_EXT_SUBLIST_CONFIG(v, V);
>  KVM_ISA_EXT_SIMPLE_CONFIG(h, H);
>  KVM_ISA_EXT_SIMPLE_CONFIG(smnpm, SMNPM);
>  KVM_ISA_EXT_SUBLIST_CONFIG(smstateen, SMSTATEEN);
> @@ -1034,6 +1142,7 @@ struct vcpu_reg_list *vcpu_configs[] =3D {
>         &config_fp_f,
>         &config_fp_d,
>         &config_h,
> +       &config_v,
>         &config_smnpm,
>         &config_smstateen,
>         &config_sscofpmf,
>
> --
> 2.43.0
>

