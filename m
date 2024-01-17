Return-Path: <linux-kselftest+bounces-3141-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 45C48830264
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Jan 2024 10:35:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E3A6F28676A
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Jan 2024 09:35:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD91413FFA;
	Wed, 17 Jan 2024 09:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="hWuxp5vG"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12E101428D
	for <linux-kselftest@vger.kernel.org>; Wed, 17 Jan 2024 09:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705484096; cv=none; b=i2/SqHvaS+tWpo3maHyr4mGAGWoE92taFsFCewRB7WLFy0FF3CNIdhekHcl65Ut0SIWytCov0zBsHsWVaVfxEog58V5lobGrc4jTcT4tXdzQzvNR0BaIDy9VvK9ybh9zLNGrx4qOQfSXgwY3S4Um0IMLz5UklZ/yStEynf3i13c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705484096; c=relaxed/simple;
	bh=5h5jo0LDbjUDwc963EaETwiGZV4372iYktbYxO7wBYM=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding; b=iWhCjOg+01Y+0v1uc++7chDfTr9wfrlZZHmQpE5Ly/qvkFGMfI7saNbrdlb+k36Aqe1GpVY+eq+VlQ6qElweWJE8UPf5ikJ3CbCd4lwxlYRDy3Aag0KM1PyvJ/B/brtyRq6XnvacWYPdEu7SsCTptBVEN5uP2FLzYwJ1d66HQ54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=hWuxp5vG; arc=none smtp.client-ip=209.85.160.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-210a73a5932so113226fac.3
        for <linux-kselftest@vger.kernel.org>; Wed, 17 Jan 2024 01:34:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1705484094; x=1706088894; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aaqWkweUBCMsM9np/mXYoztcvXQRXft4e1IEJ/ozrjU=;
        b=hWuxp5vGVbqiSAe9z4n+r1gcgTdBJOsKcxGR1oxv7Ukr3gfVNx+OdqpeM7toaJsuA8
         pmVc69+23ouo0OnaJVS4WjXPmn1Y3dp1l1MXEqZH1bOyhQd4XilryHwL1OpYEkTdHs+C
         4IC6s7eaX9URzydCPvmwEKEhyQzP+rcD8Lspwub2vXyEmTIt6LqnHUD+6RTfZfTKjHgg
         L27c/7Iz9GfvGQ6qY9EAg1wZCR1bGmUNYeWRnbg2jUIgMFivGua4PSSdvHAfNFZOVM7d
         v0DAuF57YjZwlRoW5G2Zlv16bAXi25bp0pflrPrIUja01w3lMprD7HWrhwPW/RZELk7H
         QiyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705484094; x=1706088894;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aaqWkweUBCMsM9np/mXYoztcvXQRXft4e1IEJ/ozrjU=;
        b=fwqX1ZSlaJQoI4qyGUpcMSt+SWuLEcvnoiHu3w4dblc6h/8d2IAJejHv5PHW5NrCBA
         1aTcPHomsZLWEVxa+8Jo/uLZSB2DCSV5MnDRCsLNA906sviApip7ZotPCcGo2qH4GY3F
         35Fey7YnqJwbIK+Kj61OUTUb5f4QJgLuLvl6D5Mx1olrqQxPLPd2BQcpzbVn3MEjqc7x
         /vkebjtQ6SBBHc7zNCy1fwRE1pqEsBdEbVMvbN/5BJk2aed7yXhzpZi8uOozDNVE62YG
         eCKHJBhzdPklNmuPUCo8GRly11ZxUkW26B25xb43S751LNHDZ9PObn8wu4PgwUrbEuiB
         hxqg==
X-Gm-Message-State: AOJu0Yw0Q51YbRpoo4l5/TBJTyuPGtdS88U11viBox4U7Wyx6X9aCJhF
	74W82B7gQYDTqcYfRqyTooEJyzUfctQ3j3Fs0Gg9wARG7scgKA==
X-Google-Smtp-Source: AGHT+IGm/Gep62eql5SAVLRRUU3yliphqjo5z9Qaiuxv+5wKqX7+/u8z+fEIs7Mgr/WikI4re0xS1rdrLaLknoVLY5o=
X-Received: by 2002:a05:6870:148a:b0:206:9e36:cfed with SMTP id
 k10-20020a056870148a00b002069e36cfedmr12283657oab.62.1705484094068; Wed, 17
 Jan 2024 01:34:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240117082514.42967-1-cuiyunhui@bytedance.com> <20240117-274e425c51d0deaeca80857d@orel>
In-Reply-To: <20240117-274e425c51d0deaeca80857d@orel>
From: yunhui cui <cuiyunhui@bytedance.com>
Date: Wed, 17 Jan 2024 17:34:43 +0800
Message-ID: <CAEEQ3wmDyj9S6412b3FCVF6Wu+TRRZco11X5mdEiQ5E2s54sHQ@mail.gmail.com>
Subject: Re: [External] Re: [PATCH] RISC-V: selftests: fix cbo.c compilation error
To: Andrew Jones <ajones@ventanamicro.com>
Cc: shuah@kernel.org, paul.walmsley@sifive.com, palmer@dabbelt.com, 
	aou@eecs.berkeley.edu, xiao.w.wang@intel.com, linux-kselftest@vger.kernel.org, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	xuzhipeng.1973@bytedance.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi drew=EF=BC=8C

On Wed, Jan 17, 2024 at 5:16=E2=80=AFPM Andrew Jones <ajones@ventanamicro.c=
om> wrote:
>
> On Wed, Jan 17, 2024 at 04:25:14PM +0800, Yunhui Cui wrote:
> > When compiling with -O0, the following error will occur:
> > cbo.c: In function 'cbo_insn':
> > cbo.c:43:9: warning: 'asm' operand 1 probably does not match constraint=
s
> >    43 |         asm volatile(
> >       |         ^~~
> > cbo.c:43:9: warning: 'asm' operand 2 probably does not match constraint=
s
> > cbo.c:43:9: error: impossible constraint in 'asm'
> >
> > Add __attribute__((optimize("O"))) to fix.
> >
> > Fixes: a29e2a48afe3 ("RISC-V: selftests: Add CBO tests")
> > Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>
> > Suggested-by: Zhipeng Xu <xuzhipeng.1973@bytedance.com>
> > ---
> >  tools/testing/selftests/riscv/hwprobe/cbo.c | 11 ++++++-----
> >  1 file changed, 6 insertions(+), 5 deletions(-)
> >
> > diff --git a/tools/testing/selftests/riscv/hwprobe/cbo.c b/tools/testin=
g/selftests/riscv/hwprobe/cbo.c
> > index 50a2cc8aef38..ff1d8e843d70 100644
> > --- a/tools/testing/selftests/riscv/hwprobe/cbo.c
> > +++ b/tools/testing/selftests/riscv/hwprobe/cbo.c
> > @@ -36,7 +36,7 @@ static void sigill_handler(int sig, siginfo_t *info, =
void *context)
> >       regs[0] +=3D 4;
> >  }
> >
> > -static void cbo_insn(char *base, int fn)
> > +static __always_inline void cbo_insn(char *base, int fn)
> >  {
> >       uint32_t insn =3D MK_CBO(fn);
> >
> > @@ -47,10 +47,11 @@ static void cbo_insn(char *base, int fn)
> >       : : "r" (base), "i" (fn), "i" (insn) : "a0", "a1", "memory");
> >  }
> >
> > -static void cbo_inval(char *base) { cbo_insn(base, 0); }
> > -static void cbo_clean(char *base) { cbo_insn(base, 1); }
> > -static void cbo_flush(char *base) { cbo_insn(base, 2); }
> > -static void cbo_zero(char *base)  { cbo_insn(base, 4); }
> > +#define OPTIMIZE __attribute__((optimize("O")))
> > +OPTIMIZE static void cbo_inval(char *base) { cbo_insn(base, 0); }
> > +OPTIMIZE static void cbo_clean(char *base) { cbo_insn(base, 1); }
> > +OPTIMIZE static void cbo_flush(char *base) { cbo_insn(base, 2); }
> > +OPTIMIZE static void cbo_zero(char *base)  { cbo_insn(base, 4); }
> >
> >  static void test_no_zicbom(void *arg)
> >  {
> > --
> > 2.20.1
> >
>
> Hi Yunhui,
>
> Thanks for the bug report, but this isn't the right fix. The real problem
> is that I didn't ensure operands 1 and 2 match their constraints, just as
> the warning you discovered says. To do that, I should have made cbo_insn(=
)
> a macro and not used the local variable, i.e. ensure 'fn' and 'insn' are
> indeed constants derived from the 0,1,2,4 constants.
>
> I'll send a patch with your reported-by.
Okay, if you want to use macros to fix it, you can. thanks=EF=BC=81

Thanks=EF=BC=8C
Yunhui

