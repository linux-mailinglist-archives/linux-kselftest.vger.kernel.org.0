Return-Path: <linux-kselftest+bounces-39881-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A64DCB34AE0
	for <lists+linux-kselftest@lfdr.de>; Mon, 25 Aug 2025 21:28:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 64A7C2A00C0
	for <lists+linux-kselftest@lfdr.de>; Mon, 25 Aug 2025 19:28:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE99A28312E;
	Mon, 25 Aug 2025 19:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O/PqwRUI"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF28F19D8BC;
	Mon, 25 Aug 2025 19:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756150079; cv=none; b=P0UyNIjAUXl87KdHrk34e/1bWVET1CsvqkR1lXWGVOsYbjHAVVj9nzF9SQznLfDFnI0rFLQJnp7ra8B7lHuaL2qa4Au8FRFQvHAaJG43q7dkSAVx//l6kl/whx3pl/MT3ucK6B6XoWR+w72DcABc5D1U6WNdtjTvOGlZVcelIL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756150079; c=relaxed/simple;
	bh=NtYDnYYLBcQNliR7DjLF/2fRCZ+uTJO07x1lRyuK8Ys=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kZ4GiqH32eNQD+C2OR+EzAKeRMJzOyqD3odUAWSQI3y7oVHf2/F649kb0e8EW8CWSfk8tYzSjqvZ8e2dL6ed5OQGtakH4VBRP+BbOD+CCQaXr7jEdnIAmcfsk7JAoMPe7ZPTfHHF3YfmbuHzrFfsBxdIQ/QQyjTObN+HQGCM2Rk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O/PqwRUI; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-55f3edab4c7so2051826e87.3;
        Mon, 25 Aug 2025 12:27:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756150076; x=1756754876; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hWkGo7LIVWNgzW/3KtFiqD5dK4SoHZBbabk1AvnBAgE=;
        b=O/PqwRUI/DirKYNPMu+bxMj6FHWxjtbOI7pdR2BGroCyf8xzLFHN5CL8n3DUQP3f3g
         DhACAX8YC6QWP1/TrYFITm63oKM9EV004jup1fCUHkZiKuoOVvVxw6/bieuh82JRosIM
         trNvId3JnTSPsTwQpCw9xuQPjcDXv5tdicCVpMaLFXHTepYcl203278Ggafms5hipM42
         RQUWaB244jOAM8NfKzjHra3OdDD1YT5f+yeryEEQSESwgsJlGJxZNgAO5MTuoaGwezF3
         TBN+UM2KpIFUyRSeyzYJRp2IijQjKYLy4++xOV2YfXwFKeOFGXws5IITLsig4UdIqKqh
         OcUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756150076; x=1756754876;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hWkGo7LIVWNgzW/3KtFiqD5dK4SoHZBbabk1AvnBAgE=;
        b=lXobF/cE94XluIJoG9kwWHM1J50kSFZJ8CmrJbEM6LMt0qYyooy2qbjuygkuaPrhBA
         lrTIwQMDUtsBxqjX8h5elLU79vV3wG9Ce46kdda46neOyhy0mQlEsJ88FMKcQl1AF21j
         +y/ov2fCcqvVbk6oitX96X0fKpaG2Lswsagd0NtrohEDcW6HhEGPzL78Y/XfVEtBthI+
         i7OZCndSdl40AbI8dgGCMo7pUH/+COnEAtcQtjNZVmOAVTUwQvaMZjKE5v2xy17lX1Cj
         xWkUnTfFe99u5qBcLHgSPVvqbvswpLB6NwxfpbZXuqeJ/RQ4vEB9r6w5WXgKU9TuZ9Fq
         +/Yw==
X-Forwarded-Encrypted: i=1; AJvYcCWK124rjFtajkYphURGM/I3ayzm/Eeb9ejay553pa+IKHfbPGa+Q+6Hd+Y6HcRnh5A8+YNEfC3Dlexn6WTo@vger.kernel.org, AJvYcCWTBTqCxX+IunxoKozMky5W22abNr2EFg9krunM85bEnLM9TUdFCTEp1CYveiKxwHle0IM=@vger.kernel.org, AJvYcCXwmO1LSY9n69y7Jg2PXWLVpwNjHENqqePIuZ6m4a1DLOLCJ6fZ77eiqFcUW8KIap+XqkiOaA/lotYTvMJ8Hsrf@vger.kernel.org
X-Gm-Message-State: AOJu0YzZwcXdJTVqlupPbYEzb4MYRriAX1UBXy53WJy+s4Xev6uKdl3t
	eZ+N0Q/cklzhzGMcfLI0v6sxMUfCwkrfOj9811Wy3yic4rgsM6YILLhLNayYW6BSKRJ39rV3Cn2
	8+CCRJrNkoaV5Fw2JIGgfBaKoAqF6Aeo=
X-Gm-Gg: ASbGncty3yaA+9PmZVhxD/7ZlC5oTgCjTmvuAEkZc7EPNNBXCKqpGCd8Siez7snbQCW
	Q6IzXl0nIvNRdpYQcrRF/1nMCCG38C0qqEXNceAC/phu6YC5IlruohzKAH0Vf5oM1QUccRdC5bB
	46ZhsTCZde2Vn2l3sbCt1oh3tGulg2T7gv0wAHIftEM/TVh4zEfU1CEWeVAStkmhCb9XGqsBpwE
	9DbKtToD4tAyGcc4TaZYBlkCgeerYVvwJJg6Q==
X-Google-Smtp-Source: AGHT+IE/v0WhEuhuYszot70qOf5CLPWK+nLXeOdB6grAADoaHvFZzuH9pkAzesP0BZ9rS+nWKgZUj356MlhJV+hCY20=
X-Received: by 2002:a05:6512:135a:b0:554:f76a:bac2 with SMTP id
 2adb3069b0e04-55f0cd67a31mr4417626e87.17.1756150075457; Mon, 25 Aug 2025
 12:27:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250813152958.3107403-1-kafai.wan@linux.dev> <20250813152958.3107403-3-kafai.wan@linux.dev>
 <eb6f9ba4acccc7685596a8f1b282667a43d51ca8.camel@gmail.com>
 <CANk7y0hQWOL3OW8Ok4e-kp7Brn5Zq6H5+EfS=mVtoVd+AUxZmA@mail.gmail.com> <35c18502a4870d8a833c1c9af20b85ca3f8a0ff6.camel@gmail.com>
In-Reply-To: <35c18502a4870d8a833c1c9af20b85ca3f8a0ff6.camel@gmail.com>
From: Puranjay Mohan <puranjay12@gmail.com>
Date: Mon, 25 Aug 2025 21:27:44 +0200
X-Gm-Features: Ac12FXyl_ZssxVjMiFFRpGL2RvpHKQ-cQoOuTURV7HwdhECwlkorXw1hCV8QywI
Message-ID: <CANk7y0gVNwX70ur0KkZKNkSDq7RH1xs5=dOHx_UCOErbwc7zhA@mail.gmail.com>
Subject: Re: [PATCH bpf v2 2/2] selftests/bpf: Add socket filter attach test
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: KaFai Wan <kafai.wan@linux.dev>, puranjay@kernel.org, xukuohai@huaweicloud.com, 
	ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com, 
	andrii@kernel.org, martin.lau@linux.dev, song@kernel.org, 
	yonghong.song@linux.dev, kpsingh@kernel.org, sdf@fomichev.me, 
	haoluo@google.com, jolsa@kernel.org, mykolal@fb.com, shuah@kernel.org, 
	mrpre@163.com, linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 14, 2025 at 6:06=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
>
> On Thu, 2025-08-14 at 13:23 +0200, Puranjay Mohan wrote:
> > On Thu, Aug 14, 2025 at 2:35=E2=80=AFAM Eduard Zingerman <eddyz87@gmail=
.com> wrote:
> > >
> > > On Wed, 2025-08-13 at 23:29 +0800, KaFai Wan wrote:
> > > > This test verifies socket filter attachment functionality on archit=
ectures
> > > > supporting either BPF JIT compilation or the interpreter.
> > > >
> > > > It specifically validates the fallback to interpreter behavior when=
 JIT fails,
> > > > particularly targeting ARMv6 devices with the following configurati=
on:
> > > >   # CONFIG_BPF_JIT_ALWAYS_ON is not set
> > > >   CONFIG_BPF_JIT_DEFAULT_ON=3Dy
> > > >
> > > > Signed-off-by: KaFai Wan <kafai.wan@linux.dev>
> > > > ---
> > >
> > > This test should not be landed as-is, first let's do an analysis for
> > > why the program fails to jit compile on arm.
> > >
> > > I modified kernel to dump BPF program before jit attempt, but don't
> > > see anything obviously wrong with it.  The patch to get disassembly
> > > and disassembly itself with resolved kallsyms are attached.
> > >
> > > Can someone with access to ARM vm/machine take a looks at this?
> > > Puranjay, Xu, would you have some time?
> >
> > Hi Eduard,
> > Thanks for the email, I will look into it.
> >
> > Let me try to boot a kernel on ARMv6 qemu and reproduce this.
>
> Thank you, Puranjay,
>
> While looking at the code yesterday I found a legit case for failing
> to jit on armv6:
>
> https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git/tree/arc=
h/arm/net/bpf_jit_32.c#n445
> https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git/tree/arc=
h/arm/net/bpf_jit_32.c#n2089
>
> But attached program does not seem to be that big to hit 0xfff boundary.

Hi Eduard,

You were right, I have verified that the program is hitting the 0xfff
boundary while doing the call to bpf_skb_load_helper_32
While jiting this call, emit_a32_mov_i(tmp[1], func, ctx); is called,
where this issue it triggered.

The offset in imm_offset() is calculated as:
ctx->offsets[ctx->prog->len - 1] * 4 + ctx->prologue_bytes +
ctx->epilogue_bytes + imm_i * 4

For this program, ctx->offsets[ctx->prog->len - 1] * 4 itself is
0x1400 which is above 0xfff boundary.
So, this is not a bug and expected behaviour with the current
implementation of the JIT.

For now, we can merge this and later I will try to improve the JIT so
it works for bigger programs.

Thanks,
Puranjay

