Return-Path: <linux-kselftest+bounces-48384-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BD6CCFC3CF
	for <lists+linux-kselftest@lfdr.de>; Wed, 07 Jan 2026 07:50:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2E3B23003840
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Jan 2026 06:49:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB3A026E6E8;
	Wed,  7 Jan 2026 06:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WeXifGa0"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 519263B7A8
	for <linux-kselftest@vger.kernel.org>; Wed,  7 Jan 2026 06:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767768586; cv=none; b=P7xpF1xtachcqs7Agwd807/xYhwiKBxMj145K9KdC64Lh1GbkvuMzrgGprU5ERB+3zYlDgrCv26e4tdoLQuIPosnyXcTFYEqdWPUGlXhEHIDq8zupIQutIEx9bvMjinipfIDYqTsM0U02dZ8gvNJbFS+P6Wd77CwI4VEm5RLNCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767768586; c=relaxed/simple;
	bh=7L1fp/yFv2n+QgakxNDrV8LOPjHs2ZknnnfG50O85ho=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LvaedBYDUyf/paPA1otQM5RLHm2glw+ruOloyeSyvKxDxQbSE9Cc3bjqIkx81OB3Mebnr53sgmL9lTI+k8pr5KkH2/PFj5JzxMtJwGNqHtoSQHcqlWJiPbLsV4d1YY8IHiKs/umUe96kL0460Sysw/TP/b7qcyAvYEWuXjXBcKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WeXifGa0; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-64ba9a00b5aso2403342a12.2
        for <linux-kselftest@vger.kernel.org>; Tue, 06 Jan 2026 22:49:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767768584; x=1768373384; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MruzDPuPyjqMG02vzzn+jTHVU5DsjGJw4xgCMw81cH0=;
        b=WeXifGa05B9hoeRVWU81e5B2eJBRzsFD6awYpZ2id66mvDqsIJxdTBoYOSUySaCAcS
         I4O2Up5EERtC9ElG8VbbkwWhRRuPbVspYuGon9wL31jp+9DCEYCd2tHBifsVkMVfPqh2
         8e8OrVagcfyTcgprJ4MzRlR/abWJJ2M/79RrDoR2k+r58ZGdo6qObYA/uBBDe5H7dT5i
         hWSwnoc9Y+liOwbyNub2PFAz/Ui/xQRX75MVVi1bicD2HImLHmZ4rdah6xysGp1Ki0Pj
         F5bfixpp759O6x/xqyeo833op6TcqAyfh4NRwy8TbTduS1fohM0dRjjFAe0aLnhY2OZY
         CTuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767768584; x=1768373384;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MruzDPuPyjqMG02vzzn+jTHVU5DsjGJw4xgCMw81cH0=;
        b=fIqX1eXJ4RiWtC3eqzVXiSnJp7S8GZxlrms12Vl8vpe8pZS1hTlePZ0DdoFQ9HUbEA
         d7Mdpa6vyRc64/kkYzMyLPXGHqkvCzPt8dGeBV0ng7t+w/dpdv7HYi9Zojun1fPlAcso
         NBCJXTNw/g03YMe+ToccFSNdLAuGf9NURpplsZ78JMyqHdA9x/Uul8gr8p+gy/fg9rD5
         YxjgcQmR307mRNbc8731FaAQI3A/bjB9LKcAxH/M1HjOxyRH2w3G2io/T09awApH9YVx
         quDXCVjGBeECS1J3CahKT00qvVrrgXUdT+W+GBO4/KnkVfkHWG7Rp5R/HqO14SYRnwM2
         hM7w==
X-Forwarded-Encrypted: i=1; AJvYcCWd5rCKZT8vf7kGeB59o8lUMYGcJMyrL1sk/mvtdXsGmgLwgn15+fRxbprJyaVbfBa/afQNxPzCQzHZHVrb380=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9YFBbocwR3KjH+ZzHzHPHSCPw5YtNK6cdhH3Dc2I3WvZVHOhl
	Zl+TJve2/bT+RJ9e19LwE5QxqshRcKpu8g4bUgOvL8Ks5mcXfarEsj890E9Ijj2yy7L0TeNQYb8
	SipOjr7pqaYWzHtHRrpc+1HIXUHgJmVg=
X-Gm-Gg: AY/fxX72OMV8gD727CpiB74tWcaKrq6WeRp+RXYkp2Th0mrnbI6wug0gIGafGYcV2JF
	fj1XN6ZL1CIdns+PQJUQ9MD564jzn6qGgA66Jo1mIH42W8DYgqy8DWvjZM37QCIpBe3At1OAXcv
	Hlk3bNOOsTX11wKpgfszysmCY4JEk5hBNBcISS4BmwrybR7N/d0//uUD3NnBVRjX93ad0QT2UT+
	+2FluV+gln3fJRVOpidj23EVGOQODU8S3lxayTTqd5ArHSAV8BHyCBZ5usajSEBWxTwlSDsd+ED
	Bvc=
X-Google-Smtp-Source: AGHT+IGXtnZX3Swzs9B+00UHoAzzviOLssA0wkACNyEJ5yFA3/knUSfykJRhk38tEfAOVp6ApFlsUl5OhL93K4wP718=
X-Received: by 2002:a17:907:72cf:b0:b73:9368:ad5e with SMTP id
 a640c23a62f3a-b8444f7084emr133346866b.34.1767768583459; Tue, 06 Jan 2026
 22:49:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251214163537.1054292-1-geomatsi@gmail.com> <20251214163537.1054292-3-geomatsi@gmail.com>
In-Reply-To: <20251214163537.1054292-3-geomatsi@gmail.com>
From: Andy Chiu <andybnac@gmail.com>
Date: Wed, 7 Jan 2026 00:49:31 -0600
X-Gm-Features: AQt7F2ozAc5Va5NPuQD8aSTCr0IKOoMt4EUoI_SUlzkZUzaEwNcuXeVhPJX-CK4
Message-ID: <CAFTtA3MdoL5XjcjTrNhZ27UXZe4Mxot-rttc8cQ-K=E-Mh164A@mail.gmail.com>
Subject: Re: [PATCH v5 2/9] riscv: vector: init vector context with proper vlenb
To: Sergey Matyukevich <geomatsi@gmail.com>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, Paul Walmsley <pjw@kernel.org>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Alexandre Ghiti <alex@ghiti.fr>, Oleg Nesterov <oleg@redhat.com>, 
	Shuah Khan <shuah@kernel.org>, Thomas Huth <thuth@redhat.com>, 
	Charlie Jenkins <charlie@rivosinc.com>, Samuel Holland <samuel.holland@sifive.com>, 
	Joel Granados <joel.granados@kernel.org>, Conor Dooley <conor.dooley@microchip.com>, 
	Yong-Xuan Wang <yongxuan.wang@sifive.com>, Heiko Stuebner <heiko@sntech.de>, Guo Ren <guoren@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Dec 14, 2025 at 10:35=E2=80=AFAM Sergey Matyukevich <geomatsi@gmail=
.com> wrote:
>
> The vstate in thread_struct is zeroed when the vector context is
> initialized. That includes read-only register vlenb, which holds
> the vector register length in bytes. Zeroed state persists until
> mstatus.VS becomes 'dirty' and a context switch saves the actual
> hardware values.
>
> This can expose the zero vlenb value to the user-space in early
> debug scenarios, e.g. when ptrace attaches to a traced process
> early, before any vector instruction except the first one was
> executed.
>
> Fix this by specifying proper vlenb on vector context init.
>
> Signed-off-by: Sergey Matyukevich <geomatsi@gmail.com>

Reviewed-by: Andy Chiu <andybnac@gmail.com>

> ---
>  arch/riscv/kernel/vector.c | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
>
> diff --git a/arch/riscv/kernel/vector.c b/arch/riscv/kernel/vector.c
> index 3ed071dab9d8..b112166d51e9 100644
> --- a/arch/riscv/kernel/vector.c
> +++ b/arch/riscv/kernel/vector.c
> @@ -111,8 +111,8 @@ bool insn_is_vector(u32 insn_buf)
>         return false;
>  }
>
> -static int riscv_v_thread_zalloc(struct kmem_cache *cache,
> -                                struct __riscv_v_ext_state *ctx)
> +static int riscv_v_thread_ctx_alloc(struct kmem_cache *cache,
> +                                   struct __riscv_v_ext_state *ctx)
>  {
>         void *datap;
>
> @@ -122,13 +122,15 @@ static int riscv_v_thread_zalloc(struct kmem_cache =
*cache,
>
>         ctx->datap =3D datap;
>         memset(ctx, 0, offsetof(struct __riscv_v_ext_state, datap));
> +       ctx->vlenb =3D riscv_v_vsize / 32;
> +
>         return 0;
>  }
>
>  void riscv_v_thread_alloc(struct task_struct *tsk)
>  {
>  #ifdef CONFIG_RISCV_ISA_V_PREEMPTIVE
> -       riscv_v_thread_zalloc(riscv_v_kernel_cachep, &tsk->thread.kernel_=
vstate);
> +       riscv_v_thread_ctx_alloc(riscv_v_kernel_cachep, &tsk->thread.kern=
el_vstate);
>  #endif
>  }
>
> @@ -214,12 +216,14 @@ bool riscv_v_first_use_handler(struct pt_regs *regs=
)
>          * context where VS has been off. So, try to allocate the user's =
V
>          * context and resume execution.
>          */
> -       if (riscv_v_thread_zalloc(riscv_v_user_cachep, &current->thread.v=
state)) {
> +       if (riscv_v_thread_ctx_alloc(riscv_v_user_cachep, &current->threa=
d.vstate)) {
>                 force_sig(SIGBUS);
>                 return true;
>         }
> +
>         riscv_v_vstate_on(regs);
>         riscv_v_vstate_set_restore(current, regs);
> +
>         return true;
>  }
>
> --
> 2.52.0
>

