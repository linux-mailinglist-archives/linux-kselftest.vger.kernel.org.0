Return-Path: <linux-kselftest+bounces-34423-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CBEB4AD068A
	for <lists+linux-kselftest@lfdr.de>; Fri,  6 Jun 2025 18:22:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1556F3A4D97
	for <lists+linux-kselftest@lfdr.de>; Fri,  6 Jun 2025 16:22:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3104428982A;
	Fri,  6 Jun 2025 16:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AkgXZ7UD"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A9CD1A38F9;
	Fri,  6 Jun 2025 16:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749226959; cv=none; b=fm6bcHjXiVi9A3prklGc9FJzVHDh05S6JhT4KRG0YxDjUv/Ivtkgx98uSIr0IWiaCaby1RGDzsnOnFYN4SizgXoBYnuDG3VqxnBHijzfKLjbgyzPOluqeyaH1jH5lGRG+e9O/bhy7uTkuQCTtIggyI+iiys26pIPwP55ZrOjcvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749226959; c=relaxed/simple;
	bh=jn0A54m+AigrC0Kje3Ksl/fHLeDP7CfNeV5+EpwZARg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ucVkzGH6dyL7zsQDSNp9HaXFqWA9x/PoCGVtPI827VfKvkkfVtcXB+fQAyFvTCKLwuEgPGzXX7QqNaNX+9vcRVOs6A+aeE/mf6qrXTmcyf2S/UynX7nrCQ+/coGob4iBXn5CvjhxA80KGrwSUVOhbjoBzVlHMRWjt22UaNYHL1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AkgXZ7UD; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3a503d9ef59so1842938f8f.3;
        Fri, 06 Jun 2025 09:22:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749226956; x=1749831756; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KP+8ZJbQ3Iy35rM91JKh8W2oEf1yzBugHuEwD4w/SXs=;
        b=AkgXZ7UDFNmFeYGhbkVSl3n2NGvuvMlYq0xAE5qojNwJCIuj1h8CxGwj1sEbx3Sm9X
         gAhku1mlnsCXc+oNOgKd9oy6DeT6OXAscJntKBGypIcpmMem8lkKSsNnJIhC3a+9HH9k
         +92yRFDFdsK1Kf9E6lvHf4gVJ2T0xZn8fm2Km8G+St/p2rwGPH1oEvON1brbevZ+UrMP
         ycTqgPHpWUFSQFocgicFUl0pKJLRuRJt7yXnIqQ7nVLdeaNCxqu/AcjqtXLoKdQhSYa6
         CHfcBTCLj7uB/5fgQpX+ygypYTvCni65ByH8JhssS6sIzJus9rQEn6+7wqkumPfYVj+y
         2z8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749226956; x=1749831756;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KP+8ZJbQ3Iy35rM91JKh8W2oEf1yzBugHuEwD4w/SXs=;
        b=C9luDzNnwEj/qVwbg+hZDwbvQkRn+OSx7imKbIsjf5brvJxhSlf8g3xDleDVPP8ccy
         W2m6soXzU6hWJww8rCos+Z0np2pps7itTnFPPXT6aUI4dG85dxNMz6mKxzSi5w8NgYK3
         eGmRE6qoaAgo9KW9RqeTF2giuMx4Gsen6x50ULFjm7Tftw7/yW/fRMBH5Ndo9C5R5XK+
         eUerEbdO7mYkuI+lGrN+BCzRMV/uhngKuuqG/2qX65IUqYK2IgyfKKsFiQPwb02vY81F
         nw2il4r1JJYLSJX4eHxrnPscfPaPOoixpd0YzQpcZ9ZmNrdWifOrhYkT16EsiQ+bvvGH
         3lLA==
X-Forwarded-Encrypted: i=1; AJvYcCUJbyizmhBsoQVseY5v6Obm4QSZ/vwxmy3cyZY2bzR+TOw60tG/GCfXdcsX0NOEE2dYH4kDJLpqPyiIJNkrAaRW@vger.kernel.org, AJvYcCWfzbpivWrRUMsbWdttOB8g5Ys4PkXV3luJljFy9yKSDfleilrbxc1FkLEmwlqqbzfbcCmfQsrFAA==@vger.kernel.org, AJvYcCX/FfMbyS9bcZPDc7PkzsC0uleYO5MWU8m9iMCuu29TVd5nFxsR6PQwOBf12zHyNbO6mPA=@vger.kernel.org, AJvYcCX6TCrxZ0lb5eiU3Xwa2sytpqCixep6zVUjm+lIZ5YcWnmS92EVxiotd0s5/U5niLzwEHNSmSev+rCRdkzQ@vger.kernel.org
X-Gm-Message-State: AOJu0YyYQ9ns578lsokB+R8bo+pWe0UiApeTD98NcSYhhOAmp8H4tn3J
	7xDDlvTszRhjgwKweVhz/FWV8yBTxafaf9UWYa9ss7fvqPebvSA4hO1hhqF2/lO6rXW4QypNsG2
	PY0Ay1//YIxj4yKQ19xgmkY7GPLFrjuo=
X-Gm-Gg: ASbGncvmLMLfmjTMW3A7SS1QZiaAxXAVfKkeI4+nDMC3KjPJG90joNpnYXD3gIVhtX5
	GqZGpDU2l6VY0ZInLSZSFHnVv4QICM08GRPouRyTc/j5TeCNGBxZfs3zREtiavMA88JzHXhr6pO
	j2V4gxZEOJFiphY90uFaGl/JYEdGIqPq2bkFJ5ZNyH8pjQVZC2OWSZ2offN4eWtg==
X-Google-Smtp-Source: AGHT+IGVEAky3KX3oy4NEAVyuC3jToJkW1CmYjw5OMscoOz7z7KXYJisj9AihaxTJFjuwXjoE5ERBeNQiq7yk/6UiSY=
X-Received: by 2002:a05:6000:288c:b0:3a4:db49:94aa with SMTP id
 ffacd0b85a97d-3a531ab5272mr3524523f8f.21.1749226955387; Fri, 06 Jun 2025
 09:22:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250411-many_args_arm64-v1-0-0a32fe72339e@bootlin.com>
 <20250411-many_args_arm64-v1-1-0a32fe72339e@bootlin.com> <CAEf4Bzbn6BdXTOb0dTcsQmOMZpp5=DzGS2hHHQ3+dwcja=gv+w@mail.gmail.com>
 <D98Q8BRNUVS9.11J60C67L1ALR@bootlin.com> <CAEf4BzZHMYyGDZ4c4eNXG7Fm=ecxCCbKhKbQTbCjvWmKtdwvBw@mail.gmail.com>
 <D9E9IQQ3QKXM.3UJ17G9CBS1FH@bootlin.com> <DADMLIVHMSSO.3AXSI5216WCT6@bootlin.com>
 <9a2ba0ad-b34d-42f8-89a6-d9a44f007bdc@linux.dev> <DAEFD2WH7HRV.2SOG9Q00QSEXH@bootlin.com>
 <CAADnVQ+T_s6dAwJ5JKqNqA8tq1P+MdfPvPw0EoY5yOf8PnGT4g@mail.gmail.com> <DAFA7QSTVFQF.3MG5408HBVNT7@bootlin.com>
In-Reply-To: <DAFA7QSTVFQF.3MG5408HBVNT7@bootlin.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 6 Jun 2025 09:22:24 -0700
X-Gm-Features: AX0GCFtcDPhEpzZqMjlQoxov485AHY3mrKKmWdCvVJeIQl1NL0jKc2KqPI-LVsc
Message-ID: <CAADnVQKr3ftNt1uQVrXBE0a2o37ZYRo2PHqCoHUnw6PE5T2LoA@mail.gmail.com>
Subject: Re: [Question] attributes encoding in BTF
To: =?UTF-8?Q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
Cc: Ihor Solodrai <ihor.solodrai@linux.dev>, Andrii Nakryiko <andrii.nakryiko@gmail.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	John Fastabend <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Puranjay Mohan <puranjay@kernel.org>, Xu Kuohai <xukuohai@huaweicloud.com>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	Florent Revest <revest@chromium.org>, Bastien Curutchet <bastien.curutchet@bootlin.com>, 
	ebpf@linuxfoundation.org, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
	bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, linux-stm32@st-md-mailman.stormreply.com, 
	dwarves@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 6, 2025 at 12:45=E2=80=AFAM Alexis Lothor=C3=A9
<alexis.lothore@bootlin.com> wrote:
>
> Hi Alexei,
>
> On Thu Jun 5, 2025 at 6:09 PM CEST, Alexei Starovoitov wrote:
> > On Thu, Jun 5, 2025 at 12:35=E2=80=AFAM Alexis Lothor=C3=A9
> > <alexis.lothore@bootlin.com> wrote:
> >>
> >> Hi Ihor,
> >>
> >> On Wed Jun 4, 2025 at 7:31 PM CEST, Ihor Solodrai wrote:
> >> > On 6/4/25 2:02 AM, Alexis Lothor=C3=83=C2=A9 wrote:
>
> [...]
>
> >> Thanks for the details ! I have missed this possibility, as I have bee=
n
> >> assuming that DWARF info was exposing the needed info. I'll take a loo=
k at
> >> it, but if those attributes can not be represented by DWARF, I'll have=
 to
> >> find another way of getting those packing/alignment modifications on d=
ata
> >> type (eg: re-use/share btf__align_of from libbpf, as suggested by Andr=
ii,
> >> but it may not able to cover all cases).
> >
> > Not sure all the trouble is worth it.
> > I feel it's a corner case. Something we don't need to fix.
>
> TBH I don't own any specific use case really needing this handling, so if
> it does not feel worth the trouble, I'm fine with not trying to support
> this. My effort is rather motivated by the goal of aligning the ARM64
> features with other platform, and so of getting rid of
> tools/testing/selftests/bpf/DENYLIST.aarch64.
>
> For the record, this effort also showed that the same kind of issue affec=
ts
> other platforms already supporting many args + structs passed by value ([=
1])
> - structs alignment with specific alignment constraints are not
>   specifically handled (eg: a struct with an __int128 as a top-level
>   member, leading to a 16 byte alignment requirement)
> - packing and custom alignment is not handled
>
> From there, I could do two different things:
> 1. do nothing, keep ARM64 as-is with the current version which has been
>   recently merged: ARM64 then denies attachment to any function trying to
>   pass a struct by value on stack. We keep the tracing_struct tests denie=
d
>   for ARM64. Other platforms still allow to attach such functions, but ma=
y
>   be parsing wrongly arguments in those specific cases.
> 2. add the constraint applied on ARM64 (refusing attachment when structs =
are
>   passed through stack) to other JIT compilers. Then update the
>   tracing_struct test to ensure this specific case is properly denied on
>   all platforms to avoid risking reading wrongly arguments passed through
>   stack when structs or large types are involved.
>
> I tend to think 2. is better, but let me know if you have a different
> opinion here.

Agree. tracing_struct_many_args is working on x86, but assumptions
about BTF being able to express everything about calling convention
were not correct, so let's roll back.

