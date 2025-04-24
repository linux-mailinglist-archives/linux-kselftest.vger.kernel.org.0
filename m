Return-Path: <linux-kselftest+bounces-31614-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CE93DA9BB1C
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Apr 2025 01:15:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CFBA41BA3C6F
	for <lists+linux-kselftest@lfdr.de>; Thu, 24 Apr 2025 23:15:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A8F228DF12;
	Thu, 24 Apr 2025 23:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y06bmQHR"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B05AA21B908;
	Thu, 24 Apr 2025 23:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745536502; cv=none; b=bIgKUSokYWRKST/QlCPAIlV/4AmCz2J0jOdpKau2SiVW4wzh3eDLDNFICind85dfVilnzeZX6CCrlVF4mvcFYTGooe3RPmgx7JwCvRptG7RYx0N9K1P96aQJ95iHs3j9KkpSOaAdmXy2HrtQigq8W93Fwx3c+ua/2hfBncVbO+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745536502; c=relaxed/simple;
	bh=SZmW6NDesJiC4yWM47StZa3pUw3CqjZrbcrvD8G3RfU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S3dYvUrpI57AQyq1BE/WXAfERqiOyqKOMkE06Tn0GMlHgDTRLweggQ3muJM9SBoFLUMeeyzSffa52LEZ4uUGkfe+ZZjYc7xFf4TkveQrYnLCV3Sh7D8L9JKTVdJLt+gmzjNaUZWOzUqwBC5eIoIMFxbNMBp/+33Qx3hWHV76RXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y06bmQHR; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-39ee5a5bb66so1009253f8f.3;
        Thu, 24 Apr 2025 16:15:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745536499; x=1746141299; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s8gs1eFT2kcTigsEaDxM7aO9zrXV1nvZcJgmjCeGg/s=;
        b=Y06bmQHRe4qWmUdz3aPwQApw0E8WpNMZXVjbcoP2myBGjpBEu+Q9qULj5JTJ0Kbdx4
         pmGKqmhCWSjM5fpXcxUg+yObr8wGcdcqMKXvhBIvOhBLOA9OwBk9HfCTcaya7dUB8KB/
         WqFX+wK33tRhVvg5VgI7Qsw2/6Z37KOKw4dRu5s29ZmXvUKuRcHbTLrETmIBZdCsf/gc
         4HDxjgVjNn6dLq6TwbplaZw4jJrdlnhyerQKmLNdyZXuehZ23ixa2/iSk//JA41Et9Ny
         gQYBXUgunGxEBLHHlhOIKkGFgA1ST3sLJmStwgoytZmCVJkXUXF4L7LcvkjOqO2pIrtw
         WW2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745536499; x=1746141299;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s8gs1eFT2kcTigsEaDxM7aO9zrXV1nvZcJgmjCeGg/s=;
        b=EWMu6+VEBDdh0Wivz7+oiKNsVTfx5dMeKgRt68oD+jW0ffJOlXC0K4n4hYXdqAdLNH
         AsTM1YX+kJQluYc3n9bdstrapyzAtK1joIquxCuY3MmOAJJQIcCJJEFn3anZcir0f+9R
         dY43k0XgWDA055vssx2ty0poFrw7eATKhEjrtPA5azhUwMQFzSItcJ1H2Cu32o2gWOc5
         INPLYPekFpWVOeAeE4nzyqRXSIv/FRUlmzmb/rWMVwSu60krE59dFCFePoO0MDKmGvy0
         uVVp5yMi22yVoEV6nOZVXn/4YVH2I9x65xsqBT6dKKavVgbqd0YnzDl0b7KbB36aX6/M
         pQhQ==
X-Forwarded-Encrypted: i=1; AJvYcCUdpMA5lMOL3l0J9kS22iZqI0vFrAZFB5jOz4oruZJPChxGN7s9fbRMWYj98GzNlemdPhLnJJ0GnViXqpW4@vger.kernel.org, AJvYcCVNOaQjxrIs72d67lkgHhzJWhKy+eKJPGZflboTPRlnASbgCFD7Z6UFH1idtPZaeTgI4aVj2Im/ssYXvQJoMufX@vger.kernel.org, AJvYcCXOvktZl6Q2hGrTsZ8sW/pEGMuuo7uv4s3xJsn9Tg1knOKoMmlmSVVZ48ffL+sSxg3YhEY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyjDX5Fx2yak3uEH+tHMUVgjOGp5bAKJnXkNXtEZDYU8OlloeNB
	1DNuO3psY9Cpup3TWSENccYb2aiMQ6iDfroBBOroXXGvDArc2tcFzhdLbypiZ/Lm4fVc+xzFXrE
	KauKXyS/44ei6n3QMzRmrhFZrBnQ=
X-Gm-Gg: ASbGncs1BGteImOxQSUDf1Ga+7LT5nvvYsMekXsAOC8JoxuXLjBvATjRZOW0gRW7NUD
	w880yolIZBUa7baeDZreMlN6nbGFZ3hWothjBQ06t7IuYnKu4IKoUw9Pwr8QR7s7cACtL9bJ8b7
	W/0ysQCf0njX3gFLX8C0NMx05FLZPh45zQ0yrXqQ==
X-Google-Smtp-Source: AGHT+IE/YHe0tNhYaMF75gOnF/79ImQh8cJXhRvuuQQVkEf5Rbn7XpEgOWmmcxAdQyOyipX96Oi3C6Ci8VDp5VFlVyI=
X-Received: by 2002:a5d:47a9:0:b0:39a:c9ac:cd58 with SMTP id
 ffacd0b85a97d-3a074e37565mr6270f8f.29.1745536498767; Thu, 24 Apr 2025
 16:14:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250411-many_args_arm64-v1-0-0a32fe72339e@bootlin.com>
 <20250411-many_args_arm64-v1-1-0a32fe72339e@bootlin.com> <CAEf4Bzbn6BdXTOb0dTcsQmOMZpp5=DzGS2hHHQ3+dwcja=gv+w@mail.gmail.com>
 <D98Q8BRNUVS9.11J60C67L1ALR@bootlin.com> <CAEf4BzZHMYyGDZ4c4eNXG7Fm=ecxCCbKhKbQTbCjvWmKtdwvBw@mail.gmail.com>
 <D9E9IQQ3QKXM.3UJ17G9CBS1FH@bootlin.com> <6b6472c3-0718-4e60-9972-c166d51962a3@huaweicloud.com>
 <D9EWSDXHDGFJ.FIDSHIR1OP80@bootlin.com>
In-Reply-To: <D9EWSDXHDGFJ.FIDSHIR1OP80@bootlin.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 24 Apr 2025 16:14:47 -0700
X-Gm-Features: ATxdqUHSd3r3JNAn_frzfTxFj2BJG7Z5GLEC-zQw6e4_nKCYPS6OLcRLFS8EitM
Message-ID: <CAADnVQJjQLdc_Chvz9v2-huCb9rmi048heK-eEX30AtW10H+-Q@mail.gmail.com>
Subject: Re: [PATCH RFC bpf-next 1/4] bpf: add struct largest member size in
 func model
To: =?UTF-8?Q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
Cc: Xu Kuohai <xukuohai@huaweicloud.com>, Andrii Nakryiko <andrii.nakryiko@gmail.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	John Fastabend <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Puranjay Mohan <puranjay@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	Florent Revest <revest@chromium.org>, Bastien Curutchet <bastien.curutchet@bootlin.com>, 
	ebpf@linuxfoundation.org, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
	bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, linux-stm32@st-md-mailman.stormreply.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 24, 2025 at 6:38=E2=80=AFAM Alexis Lothor=C3=A9
<alexis.lothore@bootlin.com> wrote:
>
> Hi Xu,
>
> On Thu Apr 24, 2025 at 2:00 PM CEST, Xu Kuohai wrote:
> > On 4/24/2025 3:24 AM, Alexis Lothor=C3=A9 wrote:
> >> Hi Andrii,
> >>
> >> On Wed Apr 23, 2025 at 7:15 PM CEST, Andrii Nakryiko wrote:
> >>> On Thu, Apr 17, 2025 at 12:14=E2=80=AFAM Alexis Lothor=C3=A9
> >>> <alexis.lothore@bootlin.com> wrote:
> >>>>
> >>>> Hi Andrii,
> >>>>
> >>>> On Wed Apr 16, 2025 at 11:24 PM CEST, Andrii Nakryiko wrote:
> >>>>> On Fri, Apr 11, 2025 at 1:32=E2=80=AFPM Alexis Lothor=C3=A9 (eBPF F=
oundation)
> >>>>> <alexis.lothore@bootlin.com> wrote:
>
> [...]
>
> >> Thanks for the pointer, I'll take a look at it. The more we discuss th=
is
> >> series, the less member size sounds relevant for what I'm trying to ac=
hieve
> >> here.
> >>
> >> Following Xu's comments, I have been thinking about how I could detect=
 the
> >> custom alignments and packing on structures, and I was wondering if I =
could
> >> somehow benefit from __attribute__ encoding in BTF info ([1]). But
> >> following your hint, I also see some btf_is_struct_packed() in
> >> tools/lib/bpf/btf_dump.c that could help. I'll dig this further and se=
e if
> >> I can manage to make something work with all of this.
> >>
> >
> > With DWARF info, we might not need to detect the structure alignment an=
ymore,
> > since the DW_AT_location attribute tells us where the structure paramet=
er is
> > located on the stack, and DW_AT_byte_size gives us the size of the stru=
cture.
>
> I am not sure to follow you here, because DWARF info is not accessible
> from kernel at runtime, right ? Or are you meaning that we could, at buil=
d
> time, enrich the BTF info embedded in the kernel thanks to DWARF info ?

Sounds like arm64 has complicated rules for stack alignment and
stack offset computation for passing 9th+ argument.

Since your analysis shows:
"there are about 200 functions accept 9 to 12 arguments, so adding support
for up to 12 function arguments."
I say, let's keep the existing limitation:
        if (nregs > 8)
                return -ENOTSUPP;

If there is a simple and dumb way to detect that arg9+ are scalars
with simple stack passing rules, then, sure, let's support those too,
but fancy packed/align(x)/etc let's ignore.

