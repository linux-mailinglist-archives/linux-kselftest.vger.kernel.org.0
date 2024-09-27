Return-Path: <linux-kselftest+bounces-18513-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 77F35988B87
	for <lists+linux-kselftest@lfdr.de>; Fri, 27 Sep 2024 22:51:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A8D671C22B7C
	for <lists+linux-kselftest@lfdr.de>; Fri, 27 Sep 2024 20:51:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F4941C2DBB;
	Fri, 27 Sep 2024 20:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z8d70gWB"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B1D91C1AAA;
	Fri, 27 Sep 2024 20:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727470270; cv=none; b=cMHN+kd2H0MKrbWvrIK8lUu3AW8KOuhmwecZhJS0GIM6WnGMiZPAdFhavorgV06tYqs2eoLv0uep0RFBRkViH53vHBwNXCnTEufjgEB4DxA5NbNbI47DDaF1ool9/Bbli4OAnqGVvG2N1+8owIG1oLJt/AwuhOCf9pduP0Bnwfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727470270; c=relaxed/simple;
	bh=fv5Ohlk21LIsF20JuYNmFrvmslpVoam9RSrEzIPvyFI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Nln+UfwuE5f5/b7MGun4qbEdKACjJqykpDiPrjnAs1mjheDh1osYukerRliY6LUlPNX+P1dSZxMs8dQPxOqXsfPTS/Pn9CmHof5J8Mz0VCPA3wOaj5pxO0FYt+JsieCzEi05ULJIx3xElMuC3dQzQ8vkrNV1vHd1Lg4p7hnlCWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z8d70gWB; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2068acc8a4fso24365155ad.1;
        Fri, 27 Sep 2024 13:51:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727470268; x=1728075068; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=shLDirPvQHu0zX2krQXjYGhHMytzkPRkdTMRivfTN8M=;
        b=Z8d70gWBCVUQYacppnGuM6YPaPABI25s4y8o3uZ0F54L6hbNNVJM9g24TPQd8511qz
         7Vu3jcVBjxWnaLke1EH9LAJwhitWBxFLIsmCnMeLsDFl3SArlWV1xiYhR3sqRBWzvnSC
         8rhDSVyvIrudCG9pw6ptKSRG5pmjCWd1W//lxtFjQUmykL1IPiWeVVc3K2EURbA7LFlV
         r+S06uZYlrYd24yHqiHLVU4n8l2nugWXS0Ab/r1yrJ6XxGCuFYgGxJU8QiYdroPpI9Kg
         4lBcF0WWkZZURqQEZXdr8zNSVo5wgMj1yy8SR+WrVrqUgJPfmFbFHDs3Ls2fuAOyHHXL
         HdBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727470268; x=1728075068;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=shLDirPvQHu0zX2krQXjYGhHMytzkPRkdTMRivfTN8M=;
        b=k1Mf7gV8QmjeH6iVuXmFrS6GHe0WaodcmVZuXF7CWPMqmGsirjxqi6vye5G7kS7Yzg
         pUiH6cNJgE4ztmOH0KVzUERPJXXVXVdYNp3Uef0ZCz8++nJiEbgAA1JlURr0eeL0JFwV
         oeEtMuLaSopMVV4Q4CpP2lLVxa76hurQrskBLI7L+MMYgtrlJG+BQy+dzUOZpOWrR7sb
         oFoLgan0SmLljcNuPB47egEBWk+g14SKN8O8+t+x3trK9shrmMycg2f01rDZEE7S1kht
         DxVZkR33zR9lkxcmpDfs3cbqq4meOhikrr9bgLLNrKallE8HC3A/O0gbKRBM/llFzESv
         PdOQ==
X-Forwarded-Encrypted: i=1; AJvYcCVTw14ZaFyqHFOaH6ehzj/hDtGsTXcxpQHgHqNqTeqYw+QkE8FH277G1Jpx7tJui7DhK5PqgPuwTM88LlIJ@vger.kernel.org, AJvYcCVclkGZMJdRJLbxYWJBjamWvVAeoLqRYPELsrPQVn8rRTzPAQqHsRB1J3nk6abYLWeHEjGjxUWt@vger.kernel.org, AJvYcCXA3cT2ZaAcS4G6ItVMODj2Jzk+QyJn+N0BHAa7BdNpfwfEeZG7OH/HNxMpifz9Q5B8AX0W2dk5mWd7mEPkBaoj@vger.kernel.org, AJvYcCXukTP614m60ry8PKzARo6enqm7KnaFjw+LjD2Yx7czqWj+2izE5HO31R74CkbVt2RyczM=@vger.kernel.org
X-Gm-Message-State: AOJu0YydTkXmN78/U1/WPoLbEcnzDebsKkqb08Rm+HKFAN01RrVdmmT+
	HROHSnXqlzS30ZOQMxTR6hOQPu7IC3aFKyc6vT905hgISGobFRsMXZnAxjKRRlPIvkWlFvpEeaw
	gJWbRSPXtDtWXUObfoITtcAWNVu0=
X-Google-Smtp-Source: AGHT+IFc1YB99jbzqgA1b3v/qMqek7DloIcwJTgr24Uxixyvc8uET1u/DUrw9pFeTRB5saCg2/+neLug3iuvpvUpUDM=
X-Received: by 2002:a17:90a:6d43:b0:2e0:8e36:132 with SMTP id
 98e67ed59e1d1-2e0b89ac7f4mr5057181a91.3.1727470267698; Fri, 27 Sep 2024
 13:51:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240927131355.350918-1-bjorn@kernel.org>
In-Reply-To: <20240927131355.350918-1-bjorn@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 27 Sep 2024 13:50:55 -0700
Message-ID: <CAEf4BzYCf2+8JkCjWZWGaNQcEc_=WO_emP2GPBQGZyrWm8APUg@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/2] libbpf: Add missing per-arch include path
To: =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
Cc: Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Mykola Lysenko <mykolal@fb.com>, bpf@vger.kernel.org, netdev@vger.kernel.org, 
	=?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@rivosinc.com>, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-riscv@lists.infradead.org, Charlie Jenkins <charlie@rivosinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 27, 2024 at 6:14=E2=80=AFAM Bj=C3=B6rn T=C3=B6pel <bjorn@kernel=
.org> wrote:
>
> From: Bj=C3=B6rn T=C3=B6pel <bjorn@rivosinc.com>
>
> libbpf does not include the per-arch tools include path, e.g.
> tools/arch/riscv/include. Some architectures depend those files to
> build properly.
>
> Include tools/arch/$(SUBARCH)/include in the libbpf build.
>
> Fixes: 6d74d178fe6e ("tools: Add riscv barrier implementation")
> Signed-off-by: Bj=C3=B6rn T=C3=B6pel <bjorn@rivosinc.com>
> ---
>  tools/lib/bpf/Makefile | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/tools/lib/bpf/Makefile b/tools/lib/bpf/Makefile
> index 1b22f0f37288..857a5f7b413d 100644
> --- a/tools/lib/bpf/Makefile
> +++ b/tools/lib/bpf/Makefile
> @@ -61,7 +61,8 @@ ifndef VERBOSE
>  endif
>
>  INCLUDES =3D -I$(or $(OUTPUT),.) \
> -          -I$(srctree)/tools/include -I$(srctree)/tools/include/uapi
> +          -I$(srctree)/tools/include -I$(srctree)/tools/include/uapi \
> +          -I$(srctree)/tools/arch/$(SRCARCH)/include
>
>  export prefix libdir src obj
>

Do you know what exactly is used from tools/arch/$(SRCARCH)/include
for (I assume) RISC-V? I'm asking because we'd need to make sure that
Github version of libbpf Makefile and include directory has all the
necessary pieces as well (so I'd appreciate if you could take a look
at that as well, if you haven't already).

>
> base-commit: db5ca265e3334b48c4e3fa07eef79e8bc578c430
> --
> 2.43.0
>

