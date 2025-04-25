Return-Path: <linux-kselftest+bounces-31640-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F219A9C8B0
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Apr 2025 14:13:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 200371BC0987
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Apr 2025 12:13:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25B1824E00D;
	Fri, 25 Apr 2025 12:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b="GR5yQyIm"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-io1-f47.google.com (mail-io1-f47.google.com [209.85.166.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C4AA2475F2
	for <linux-kselftest@vger.kernel.org>; Fri, 25 Apr 2025 12:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745583194; cv=none; b=OrW1eIGS24mxkbXzF84MiZ73eVmQ04aNvOrtZv0SteG5Y3xlOCqPGUmk0HCqLF5mN6m9r7v56g7sFs5gLniOhLB9JsY9J7o238XNMSFhWfXlnJbi/G7KCMfGXlGoQ+vPl5LqY6GJEn+MxQFjoFGPPHXvJy/8ix/tQ6zzFqPjM8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745583194; c=relaxed/simple;
	bh=TO4TWtY8D7glL8YObqyd/2VnZ5O36lHwKMRTnZkD/yM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Lrmo79Gd58vnWgxCCt7U6ukJRwbWAj0eFBqmy/0a8DpsY7ZZvDf1FaUvLVT6ykAcOuYSDtf8VeZTfZDBxWyBI7B0hMlMXwqSZoXFazIeG8JuonGzeTrW+sUnhPldQAUY1hTN77yTp37QnLuZlTzJWIgNNfb1dBsn/shUKmgQJs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org; spf=none smtp.mailfrom=brainfault.org; dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b=GR5yQyIm; arc=none smtp.client-ip=209.85.166.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=brainfault.org
Received: by mail-io1-f47.google.com with SMTP id ca18e2360f4ac-85ea482e3adso95635539f.0
        for <linux-kselftest@vger.kernel.org>; Fri, 25 Apr 2025 05:13:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20230601.gappssmtp.com; s=20230601; t=1745583190; x=1746187990; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7LVCfKKGZ+VAx31B/QvtWLC+cXlvT+nFAC3b1QAmkzg=;
        b=GR5yQyImlSNO8298jxLOwIgXn2myejKfXevKo3HM1M6hG0cciuw6ZWHyFQFcoL5wu/
         kWVXjMAKe2ZcQh6PZCYdFz/3cquw2kwkPWiWGZaQ9xP42dyRlDarsW3+SacUQ0wPqGxl
         b3TkxeQ1TrR++6mIEQbTJ7DPCKG+/G5Jd0mh4mhge7RxN9H0bzg8jKr4frCsshm2wdys
         V09mXtUuEvGGrHfXc0vCxjg9gfYZ+hUzNsRervMTm/RLafY8xEFW6ge7KTkIbyY9Gh5u
         KZzoomAz21PpMHhIZWR5Y3IM8vy1zOwPmnvZx0IWfLrr/D8Z/2+fvhJphx80yaOIjH5c
         fgNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745583190; x=1746187990;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7LVCfKKGZ+VAx31B/QvtWLC+cXlvT+nFAC3b1QAmkzg=;
        b=m0tZte/Plw7Rna1dUfmnHbVeLbQgWFL/Im7MkYdfpP6qVfBoF2lyh9ZggrLRxFoEwe
         maiTuDBCUcHw/lGAyBnF06VbgI2F6ZrI1YxcpCTjueDGrGtMoONYFKWa39owGJscx8R7
         d/l6kQWXfpULMZeJaPQY8Ta9r3B3cz4duedw3DkM6gGnLUd7hDlarLzbIF2SehKvsmmW
         EIdDLxI1ZXs58cEEywUMDsTzjFtXjOCOMHRdEqWBCl/8xjEM+TuzAGaMjEr+GR1B1zPc
         eIYCCkQFJ1OQ5rKGzN5JMuR7s8NWWkFjabVfzgLFVtt7jnNd4CA/LsvQzQcmFA1FCyFR
         qKGQ==
X-Forwarded-Encrypted: i=1; AJvYcCWc45s30+EpbOCtbnon8YnngVOAzemrlTI7Tqts8flT9s/AoAA3kHPcYSv5Hg0ONih5ZCacrJhB87KGMPN5K+M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+Iyw/QOGzhJekxpy+d0zifiDepfNSHzKdxVATsOnv1t29byv7
	pLMUh1xpsXge1ROCGXfpePPZsg5eHZCZ25AmTM4bhDCk4qddugrwUw5HpUc74wZwaSwFB0n/8N1
	k8169Nj1Bq2KwX6dR4Cz5XSspv98etZ3WLKItoQ==
X-Gm-Gg: ASbGncvy+VQ9UYIPAr7O4Wf+9yEBoIUh++5dgmclfbnq/i8NeDfDIGGkQ/PWYIRqVcb
	PSCZfWygzSl4lIgVYJv+M7cyB7lXEhicUCMl2jksuj/DkO/7NFUYFSKeChZTztTX7Pny6lVDwbr
	jqpsytldfBbgcVyO2eecr8Rok=
X-Google-Smtp-Source: AGHT+IEc4wQDIyAonXTkWsqY11L7QFIJfNSBIAH3ZY0qz8y4ByrVUK33TWmLeL/12iYhQYPbulWRTGy5kuvd1J/u8sE=
X-Received: by 2002:a05:6e02:2487:b0:3d9:2bfc:5767 with SMTP id
 e9e14a558f8ab-3d93b6cae6amr18674675ab.0.1745583189986; Fri, 25 Apr 2025
 05:13:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250324-kvm_selftest_improve-v1-0-583620219d4f@rivosinc.com> <20250324-kvm_selftest_improve-v1-2-583620219d4f@rivosinc.com>
In-Reply-To: <20250324-kvm_selftest_improve-v1-2-583620219d4f@rivosinc.com>
From: Anup Patel <anup@brainfault.org>
Date: Fri, 25 Apr 2025 17:42:58 +0530
X-Gm-Features: ATxdqUF3lkgMIhQKkdyVfB74UNuy_-e8DUJtUETJoF6k8Xhu-0BFfCT8lsZQsJA
Message-ID: <CAAhSdy0=c_dq7EpztQ9t83qbXBqD6E92xUadYvyv_kFj-Epw6Q@mail.gmail.com>
Subject: Re: [PATCH 2/3] KVM: riscv: selftests: Decode stval to identify exact
 exception type
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
> Currently, the sbi_pmu_test continues if the exception type is illegal
> instruction because access to hpmcounter will generate that. However, we
> may get illegal for other reasons as well which should result in test
> assertion.

"... However, illegal instruction exceptions may occur due to other
reasons which should result in test assertion."

>
> Use the stval to decode the exact type of instructions and which csrs are
> being accessed if it is csr access instructions. Assert in all cases
> except if it is a csr access instructions that access valid PMU related
> registers.
>
> Signed-off-by: Atish Patra <atishp@rivosinc.com>

Otherwise, LGTM.

Reviewed-by: Anup Patel <anup@brainfault.org>

Regards,
Anup

> ---
>  tools/testing/selftests/kvm/riscv/sbi_pmu_test.c | 32 ++++++++++++++++++=
++++++
>  1 file changed, 32 insertions(+)
>
> diff --git a/tools/testing/selftests/kvm/riscv/sbi_pmu_test.c b/tools/tes=
ting/selftests/kvm/riscv/sbi_pmu_test.c
> index 03406de4989d..11bde69b5238 100644
> --- a/tools/testing/selftests/kvm/riscv/sbi_pmu_test.c
> +++ b/tools/testing/selftests/kvm/riscv/sbi_pmu_test.c
> @@ -128,11 +128,43 @@ static void stop_counter(unsigned long counter, uns=
igned long stop_flags)
>                        "Unable to stop counter %ld error %ld\n", counter,=
 ret.error);
>  }
>
> +#define INSN_OPCODE_MASK       0x007c
> +#define INSN_OPCODE_SHIFT      2
> +#define INSN_OPCODE_SYSTEM     28
> +
> +#define INSN_MASK_FUNCT3       0x7000
> +#define INSN_SHIFT_FUNCT3      12
> +
> +#define INSN_CSR_MASK          0xfff00000
> +#define INSN_CSR_SHIFT         20
> +
> +#define GET_RM(insn)            (((insn) & INSN_MASK_FUNCT3) >> INSN_SHI=
FT_FUNCT3)
> +#define GET_CSR_NUM(insn)       (((insn) & INSN_CSR_MASK) >> INSN_CSR_SH=
IFT)
> +
>  static void guest_illegal_exception_handler(struct ex_regs *regs)
>  {
> +       unsigned long insn;
> +       int opcode, csr_num, funct3;
> +
>         __GUEST_ASSERT(regs->cause =3D=3D EXC_INST_ILLEGAL,
>                        "Unexpected exception handler %lx\n", regs->cause)=
;
>
> +       insn =3D regs->stval;
> +       opcode =3D (insn & INSN_OPCODE_MASK) >> INSN_OPCODE_SHIFT;
> +       __GUEST_ASSERT(opcode =3D=3D INSN_OPCODE_SYSTEM,
> +                      "Unexpected instruction with opcode 0x%x insn 0x%l=
x\n", opcode, insn);
> +
> +       csr_num =3D GET_CSR_NUM(insn);
> +       funct3 =3D GET_RM(insn);
> +       /* Validate if it is a CSR read/write operation */
> +       __GUEST_ASSERT(funct3 <=3D 7 && (funct3 !=3D 0 || funct3 !=3D 4),
> +                      "Unexpected system opcode with funct3 0x%x csr_num=
 0x%x\n",
> +                      funct3, csr_num);
> +
> +       /* Validate if it is a HPMCOUNTER CSR operation */
> +       __GUEST_ASSERT(csr_num =3D=3D CSR_CYCLE || csr_num <=3D CSR_HPMCO=
UNTER31,
> +                      "Unexpected csr_num 0x%x\n", csr_num);
> +
>         illegal_handler_invoked =3D true;
>         /* skip the trapping instruction */
>         regs->epc +=3D 4;
>
> --
> 2.43.0
>

