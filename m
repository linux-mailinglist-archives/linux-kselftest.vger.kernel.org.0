Return-Path: <linux-kselftest+bounces-48031-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AFC0ECEC70B
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 Dec 2025 19:09:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 041DE30155FC
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 Dec 2025 18:09:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 625782F617F;
	Wed, 31 Dec 2025 18:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="eMIZNaZx"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 809C12F6187
	for <linux-kselftest@vger.kernel.org>; Wed, 31 Dec 2025 18:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767204573; cv=pass; b=mUlk8Wc+32BwXogguwp+JDWSUC+zAE2umeYe2VQwEBpH7J9WK+qBUfDu3tKDHYWNcsDQH4HR4Lt6bHId0a4MLRxNbaurozK4eLKZ6dXKtOU919rTNEULC+k0hb+uv35gHA88G86Dee6740e8gmBhYWpdMk8XV1j3NnaqeSabD2c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767204573; c=relaxed/simple;
	bh=Mtz2A8tWa233gsaBDZq5niJH69EnDrxIcs8csRo3gmI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WJ6SsIMQ7mvhl//Em21L/u1VR3RvjIJeqI7dS/p1Ti5TbzXuhBJa+30XZauCG9cVC2UBThc71bkYe/8ExRf30HxkKC1eI+jcbFkCz+4WJVVstzLpcc1bc1cHIEf/iD/hKQBSSHH0HtRGl5u27TppbJtmK2e4EVf5JUzJj8JcWY4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=eMIZNaZx; arc=pass smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-c2a00109fd8so253197a12.3
        for <linux-kselftest@vger.kernel.org>; Wed, 31 Dec 2025 10:09:31 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1767204571; cv=none;
        d=google.com; s=arc-20240605;
        b=T7JxGbRkjeS7O4+hMOpRm/swjk79Q1vDrY6izXaz+PPb6W/hbDy6cglzz6Jzspz93w
         AhoCABBrJyE+QwIwniRaYfhgB/KedJ/P1AB80oWM5QqatFC7Qql+s40qIHWfbOlIyrfD
         NTC/EjzHWJdIXCRML+g2zBqTVKll5qAWjvkPFsZROBikc4yIPXITqFY/AeNyX4QR8a0V
         jA9VBIXLCwa/XWFljU9In228f9q+z0QYJ6o+0DbASAVdjtwBdugCZ33fbsA7F21t8RH3
         vcxI0OZqrtyPlilfqtKTJM+z8NFswytQ+2j1HK4kF3SuqFaN/HFHlmDn7V1G30ZA9ydv
         GPyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=bIMPl7WzuufPEFhizw2OC5bzIw2A/w2Jw5N6sXr/zUI=;
        fh=YeKxLwTaCpKEgnCFdje3LsVVe7fAZpXDbEYa4SiY7Fk=;
        b=hMlAfxTgyai+TvRggogKxej0o5fSVkTJE9x98RvTx0Iz0UsNY7JQ/QNSQmieGGDwON
         5kYCe3xCp0CT+XHeRjcisaUlLdXssr+JvPXTwLRyEVGhbZ+C4TDRAms0shcFT8Sw42HN
         xl3oGnUT/mw5zU/hwH3pCRFCzAlzaaLDjRRhyuOXX5WgNgWKdL1NP6Ql7AT5uVTaBv8c
         pd7YTRn0TyGfB0vCeivYeaF6EFfVwJm5zM1VAWSRc24Mo2jn7f7zMsY4vuW+qmIjcxPk
         E0CUZESdfXhvyBabPLoMppNrsyWegea+EM0HW8/6aTTVGTj05jRdnbEZ8Pz0UQw1QRxP
         5dyQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1767204571; x=1767809371; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bIMPl7WzuufPEFhizw2OC5bzIw2A/w2Jw5N6sXr/zUI=;
        b=eMIZNaZxBhjFWbRV5ha9XKWe6+Thr83KYVjbX2EkOS0ijkIS/ouyjp0CtYoTRWnilM
         e58ePoaklivu0fQntxNqGZw9WUotToDYHEVdITkDaRpzEbVk0cI4e+0WXxKdC9aGjZJj
         JgFBFp0fhc6aUWuQCuIWhwiQ4wMayISpnxgDrXkOgMY16odAXqHr9AANLOBFS7j+6a5F
         fJO0q61tAgcea0PhgKSTCegLBw7cy5T1i8LarrJq8r33fGcLXBobunY3aVGko+6xOKhS
         RkYLDJqwAvKBEaH/S64IIxntuSDjfWqmS+f7PwuwiOI+FcPy3dSnealEdllqritOeNLy
         1TpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767204571; x=1767809371;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bIMPl7WzuufPEFhizw2OC5bzIw2A/w2Jw5N6sXr/zUI=;
        b=DIqpS5J6LdG4lDAIqjKbjfQgfCXYvKKI/i6ca9WUZ6ynt8r5fyb1DvN2KOEFam4oY4
         /GZxLEdDwJTUEpuIuksDA9B6M2825ywI51BriPfT1FZxcMGzl7ishQqT0gSCNFoWk5lB
         JqMQb4+3yLqT6ynSzfQVbhKEXupdA7nPgdk0NOen1Ds+hkPEy4WEUJFH7bzFe6LpJMiA
         QuoxcEMIlOSTZimKJGq0xWEoYR50h4Q6+BGX2Zuu6jR+Mxb7i88fBEH8UBHCYut8MdGK
         orOTUAkEqPx8LHJO+SsstsjxrRGCeButKZNWE69wKmn578bMLMPUemYG/zCO0upn0Wxb
         93NQ==
X-Forwarded-Encrypted: i=1; AJvYcCX30WSIGBcCH8hKD1p3CMYVJtlw2QjZ60W4kLL77al+I/SwL0DhQMzsU9+bpv2vpKeknDBzXLFJrBqMc3GcNIY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxzah1Dq8XPsKBhZelOyb5dOmiZzGoZuRfr5E/9kTrC6qOtYj6C
	QpTl0YVw56LY3YuZN5gnsIZLfKoNylSaKTLdcPuemGYkpAVDcThhf7ihxgf/13PDO/hW/Dy7R5V
	HvTpNF0YwqkWj6I10vP0zehGiOJtX8zO7/AKoR1pSSA==
X-Gm-Gg: AY/fxX5Qp5tCozcUbJA0OAdn0yprBC9CMJ4DJSJjKuQONquPGwv5CAVKCRLzq+CbndY
	POF0EwnNqGlbpRmY9tRfFSyGyEkgVehSJFqbEToPzkVf5BunDO/QlM+5caLhHaHczvd+4MDBNKI
	3TMQIIxwYcQISOrrK4lOQMmaytrCr4/PwdWFMsKSQ5qQeB/kuGZWauZ/UtD7JttCt1q0AY+N2iM
	VnVy4T/glZtqSGXt4QURURb8UDFbVvV45hz5Q+W0YjbYgQQzbeIvY4VQDGS0i1u9HEBW9V0P2gK
	6/2INos=
X-Google-Smtp-Source: AGHT+IEoQb+VMYUZF/EVHfCupM/J7UKB/HyklpfhaHst9+Iqt6sXvQ7lmZWvrOhCEyHebOWe5s6vxpHZd7OfrJbc6Sg=
X-Received: by 2002:a05:7022:6194:b0:11d:faef:21c2 with SMTP id
 a92af1059eb24-121722b44b3mr19049815c88.2.1767204570391; Wed, 31 Dec 2025
 10:09:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251231173633.3981832-6-csander@purestorage.com> <e9a1bd633fb4bb3d2820f63f41a8dd60d8c9c5e3c699fa56057ae393ef2f31d0@mail.kernel.org>
In-Reply-To: <e9a1bd633fb4bb3d2820f63f41a8dd60d8c9c5e3c699fa56057ae393ef2f31d0@mail.kernel.org>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Wed, 31 Dec 2025 13:09:19 -0500
X-Gm-Features: AQt7F2q8qmB_ZWyKhj1fKhcgEDCzRqBwfvvrWtG8WY5Jchb5VzTDRzCjSxJzD0s
Message-ID: <CADUfDZpSSikiZ8d8eWvfucj=Cvhc=k-sHN03EVExGBQ4Lx+23Q@mail.gmail.com>
Subject: Re: [PATCH 5/5] selftests/bpf: make cfi_stubs globals const
To: bot+bpf-ci@kernel.org
Cc: jikos@kernel.org, bentiss@kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	john.fastabend@gmail.com, andrii@kernel.org, martin.lau@linux.dev, 
	eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev, 
	kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, 
	tj@kernel.org, void@manifault.com, arighi@nvidia.com, changwoo@igalia.com, 
	mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com, 
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com, rostedt@goodmis.org, 
	bsegall@google.com, mgorman@suse.de, vschneid@redhat.com, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	dsahern@kernel.org, jhs@mojatatu.com, xiyou.wangcong@gmail.com, 
	jiri@resnulli.us, alibuda@linux.alibaba.com, dust.li@linux.alibaba.com, 
	sidraya@linux.ibm.com, wenjia@linux.ibm.com, mjambigi@linux.ibm.com, 
	tonylu@linux.alibaba.com, guwen@linux.alibaba.com, shuah@kernel.org, 
	mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com, 
	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org, netdev@vger.kernel.org, sched-ext@lists.linux.dev, 
	linux-rdma@vger.kernel.org, linux-s390@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, martin.lau@kernel.org, clm@meta.com, 
	ihor.solodrai@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 31, 2025 at 10:04=E2=80=AFAM <bot+bpf-ci@kernel.org> wrote:
>
> > diff --git a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c b/too=
ls/testing/selftests/bpf/test_kmods/bpf_testmod.c
> > index 90c4b1a51de6..5e460b1dbdb6 100644
> > --- a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
> > +++ b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
>
> [ ... ]
>
> > @@ -1275,7 +1275,7 @@ bpf_testmod_ops__test_return_ref_kptr(int dummy, =
struct task_struct *task__ref,
> >       return NULL;
> >  }
> >
> > -static struct bpf_testmod_ops __bpf_testmod_ops =3D {
> > +static const struct bpf_testmod_ops __bpf_testmod_ops =3D {
> >       .test_1 =3D bpf_testmod_test_1,
> >       .test_2 =3D bpf_testmod_test_2,
>
> Is it safe to make __bpf_testmod_ops const here? In bpf_testmod_init(),
> this struct is modified at runtime:
>
>     tramp =3D (void **)&__bpf_testmod_ops.tramp_1;
>     while (tramp <=3D (void **)&__bpf_testmod_ops.tramp_40)
>         *tramp++ =3D bpf_testmod_tramp;
>
> Writing to a const-qualified object is undefined behavior and may cause a
> protection fault when the compiler places this in read-only memory. Would
> the module fail to load on systems where .rodata is actually read-only?

Yup, that's indeed the bug caught by KASAN. Missed this mutation at
init time, I'll leave __bpf_testmod_ops as mutable.

Thanks,
Caleb

>
>
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a =
bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/READM=
E.md
>
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/206242=
06229

