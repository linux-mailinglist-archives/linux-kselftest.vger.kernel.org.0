Return-Path: <linux-kselftest+bounces-31434-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD971A99637
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Apr 2025 19:16:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 02A054658CA
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Apr 2025 17:16:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BFA928BAB8;
	Wed, 23 Apr 2025 17:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k9B4Wko/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77C8428BAA8;
	Wed, 23 Apr 2025 17:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745428546; cv=none; b=hFBP+J6Wu3g7RAtIW53MGZt8XJPxnbyLchbhoUyd7v1n3HqIuFt8zxtVsglgUx05MlVRuQkh0USQXbzoh0TgPcawMba7i9R9rS9QcKa3Y9ZMCbiSxERPtYo/Nyi0NuyJzx/R2ar9vHuXL+YBG4RJLbU+Ek8C1qyQ0QoulTwfyNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745428546; c=relaxed/simple;
	bh=qnewsdTEiU9wbm6OnE47hsHNxgG19vfCD7IgfGQJEho=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rfxgAogGkLVnjG9VqjEBeANLZxqER8P3AqMoPFeay8Wx0agF4IXq2GBK3IcwCJ3FkSlrs8nIEJEvmOXZZVBjOb08RVfuCwO1TGr/aSy4VBm8p5oH7gdI09yeMGZkG7zFJ4tCDtJxKLFl6IRkvY9vskFhpj1aoblnLJWW6VVZB1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k9B4Wko/; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-ac7bd86f637so244951866b.1;
        Wed, 23 Apr 2025 10:15:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745428543; x=1746033343; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IXqH3/APdtQJoO7o2nnXO+aSVxcwfTQhNjLKJExRtA4=;
        b=k9B4Wko/3mzGLbuvyqr2fNnAZ17jmnQGZrj3JGmzklttP7qBuhxbN1Rld6dtah/He6
         hUmpc8NiObCojnvpP5sbkNMKqw8Bvy2df9ymPyJcmdXge/8tJCKEV4dd7w7kVlqmxauZ
         fEVEcBJ36yf9WUrV+tjkcbG9+SB+BLeHEdmGiTqpTaSZiPt2YZlezU27Zvll76bbsynt
         2ZTOdi6hzxC1aFvgCSo0EZ+F+Vx07wivoW0Qa9mPy24VjGcfO6tGupUUaUmH6pg3YJjW
         FkXKkd6WTZ6qUWcZ5SSY8jo6u0PnEhbwhw4rTQIKb6gqKqmJ1sO5CfFIhlb9RKIHZENz
         J0Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745428543; x=1746033343;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IXqH3/APdtQJoO7o2nnXO+aSVxcwfTQhNjLKJExRtA4=;
        b=bszRDBC6aRJTu9EXBpStRaF+Z/9weaEoRTB6jmbgQxVP8TGg3mVoAY0YvEjqiP/dMC
         y2qSZexJZCu35kqv1JwSHBEVrItQV8TBCbpGB49782F1bm8YO9cnKebX+4hjk0G8gA1T
         Du5m+oYawD4X63iX6HgBtEo0C2s6uK8tiBYedayu26BG390TXRzdqUIvjXrYj5t455qM
         nuaLHgWROYtwLfExn2ekpwTlF/GlQiyJs+hkrC+QGS4au3JHIf6d9WPfs9l6PWO+uZj1
         3E+GjS7uTFs9g90+HRR3ICvVpgNpwpR/eruiE+BckirpBQiSrqLNb6fiQyddd27ramTK
         p5Tg==
X-Forwarded-Encrypted: i=1; AJvYcCUN1W7LysZPLbMxvoGNQZaeCmlV95fxUVWOX1K52wFCOnVXZemCMpKM7tnxiCNVPmX8g0Q=@vger.kernel.org, AJvYcCUfgX/OZ51M/5kqTXxg1W59s2ONSpXbWeWsUM06fmxIlO1/p+0W7B1po6DDaz2NMNTmplRhc3Slf8fFGizi@vger.kernel.org, AJvYcCXUJQrOQOZaMEJpqell8NspBGwinVIlWbqBNPUw1/JhgRukENRSdZI2Dccgf3rBc4r0hWnEtFk87Qqu+ORRzydm@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6NO8ZHccoJsJ9VO5IMJCrQTPwUQfdIHvREJ9TXsbZAB+ML5af
	MW3rPyKjqJihpJMpONlrPwRTGFF5afAmVgPoYjPjkk1jOanzl9h64PG93avssMte8rMr2Eme5TY
	jNWY3w3xABI+WkmbglLDgZuzx57Y=
X-Gm-Gg: ASbGnctwMuL4eHc1lfdLfDelBe1YCa2zMmMFSUdgddhi4y8oWIN3fQCd/2t4kbF13TS
	otjRQxxZRGrFVcjUumO4zd8QmoVP7EOcYS0WcFWuPMUK3p8dPKjn75xdy0+EIGmRz45v2M0t/aH
	Xq3NhvFE09SWTNRThSA/8n7ZYgMnup0tVjXUElwA==
X-Google-Smtp-Source: AGHT+IENhXSbehQqfBW1svYcq0D4UIHBuJbvet0xcZ1l8BgXjBl9sSRbuFPUI4WEPm1PyA5ibhgYTL9d/lGV71q9Wms=
X-Received: by 2002:a17:906:942:b0:ac7:3441:79aa with SMTP id
 a640c23a62f3a-ace5459c3b0mr1838766b.13.1745428542340; Wed, 23 Apr 2025
 10:15:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250411-many_args_arm64-v1-0-0a32fe72339e@bootlin.com>
 <20250411-many_args_arm64-v1-1-0a32fe72339e@bootlin.com> <CAEf4Bzbn6BdXTOb0dTcsQmOMZpp5=DzGS2hHHQ3+dwcja=gv+w@mail.gmail.com>
 <D98Q8BRNUVS9.11J60C67L1ALR@bootlin.com>
In-Reply-To: <D98Q8BRNUVS9.11J60C67L1ALR@bootlin.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 23 Apr 2025 10:15:20 -0700
X-Gm-Features: ATxdqUE91QmVoMb8-9fNRcAVpV6sKAYDYDexZM632tte0cXJZXh3_ehQWPpgTAs
Message-ID: <CAEf4BzZHMYyGDZ4c4eNXG7Fm=ecxCCbKhKbQTbCjvWmKtdwvBw@mail.gmail.com>
Subject: Re: [PATCH RFC bpf-next 1/4] bpf: add struct largest member size in
 func model
To: =?UTF-8?Q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
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
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kselftest@vger.kernel.org, 
	linux-stm32@st-md-mailman.stormreply.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 17, 2025 at 12:14=E2=80=AFAM Alexis Lothor=C3=A9
<alexis.lothore@bootlin.com> wrote:
>
> Hi Andrii,
>
> On Wed Apr 16, 2025 at 11:24 PM CEST, Andrii Nakryiko wrote:
> > On Fri, Apr 11, 2025 at 1:32=E2=80=AFPM Alexis Lothor=C3=A9 (eBPF Found=
ation)
> > <alexis.lothore@bootlin.com> wrote:
> >>
> >> In order to properly JIT the trampolines needed to attach BPF programs
> >> to functions, some architectures like ARM64 need to know about the
> >> alignment needed for the function arguments. Such alignment can
> >> generally be deduced from the argument size, but that's not completely
> >> true for composite types. In the specific case of ARM64, the AAPCS64 A=
BI
> >> defines that a composite type which needs to be passed through stack
> >> must be aligned on the maximum between 8 and the largest alignment
> >> constraint of its first-level members. So the JIT compiler needs more
> >> information about the arguments to make sure to generate code that
> >> respects those alignment constraints.
> >>
> >> For struct arguments, add information about the size of the largest
> >> first-level member in the struct btf_func_model to allow the JIT
> >> compiler to guess the needed alignment. The information is quite
> >
> > I might be missing something, but how can the *size* of the field be
> > used to calculate that argument's *alignment*? i.e., I don't
> > understand why arg_largest_member_size needs to be calculated instead
> > of arg_largest_member_alignment...
>
> Indeed I initially checked whether I could return directly some alignment
> info from btf, but it then involves the alignment computation in the btf
> module. Since there could be minor differences between architectures abou=
t
> alignment requirements, I though it would be better to in fact keep align=
ment
> computation out of the btf module. For example, I see that 128 bits value=
s
> are aligned on 16 bytes on ARM64, while being aligned on 8 bytes on S390.
>
> And since for ARM64, all needed alignments are somehow derived from size
> (it is either directly size for fundamental types, or alignment of the
> largest member for structs, which is then size of largest member),
> returning the size seems to be enough to allow the JIT side to compute
> alignments.

If you mean the size of "primitive" field and/or array element
(applied recursively for all embedded structs/unions) then yes, that's
close enough. But saying just "largest struct member" is wrong,
because for

struct blah {
    struct {
        int whatever[128];
    } heya;
};


blah.heya has a large size, but alignment is still just 4 bytes.

I'd suggest looking at btf__align_of() in libbpf (tools/lib/bpf/btf.c)
to see how we calculate alignment there. It seems to work decently
enough. It won't cover any arch-specific extra rules like double
needing 16-byte alignment (I vaguely remember something like that for
some architectures, but I might be misremembering), or anything
similar. It also won't detect (I don't think it's possible without
DWARF) artificially increased alignment with attribute((aligned(N))).

>
> >> specific, but it allows to keep arch-specific concerns (ie: guessing t=
he
> >> final needed alignment for an argument) isolated in each JIT compiler.
> >
> > couldn't all this information be calculated in the JIT compiler (if
> > JIT needs that) from BTF?
>
> From what I understand, the JIT compiler does not have access to BTF info=
,
> only a substract from it, arranged in a struct btf_func_model ? This
> struct btf_func_model already has size info for standard types, but for
> structs we need some additional info about the members, hence this
> arg_largest_member_alignment addition in btf_func_model.
>
> Thanks,
>
> Alexis
>
> --
> Alexis Lothor=C3=A9, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com
>

