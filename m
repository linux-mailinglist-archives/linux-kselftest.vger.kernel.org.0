Return-Path: <linux-kselftest+bounces-32884-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 629E8AB4849
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 May 2025 02:10:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9110A8C5487
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 May 2025 00:09:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC3475695;
	Tue, 13 May 2025 00:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gUtZx3G9"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EFC37482;
	Tue, 13 May 2025 00:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747094941; cv=none; b=tvPr+refxP/9BevvHTgfq3IRyMlNUzQo/Qxkz/NKBe8VGKveJ1A/w/tpUlUKgsUhlvZGtRwvuhQpU5xXKaFrZn4tlAZ0nNhnge8nsvYGkdnxAxPw00ZZdnof2S15yMwq2gzNeedwHwGbS5UKwmGBfFQVqqFxfH05S9QwYagZx28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747094941; c=relaxed/simple;
	bh=btui7WTriYwWwDaipfsN6n9UimydyKvuy3FhpjdcGQw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=O0NKgSUE8h/WHBwjALAg30eSC02kXfk4ppdtIRoh8oPZGwdLbrIlvPG2CbhIT5HC6TUjDEL8kPdgAarnwEz4TW0AvjB04yL1iPsCjJMBcd/vUzPFMKzerZt0n0PfoZG7X3Vx96V88o1bxwlDoEC/ttwI7FKuYb11qnQ3SZc8Yjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gUtZx3G9; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-43cf680d351so35596305e9.0;
        Mon, 12 May 2025 17:08:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747094937; x=1747699737; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z0usMcMWdY8lq5FVni3HwlJ8NWBna50dNtlKJxA0fhc=;
        b=gUtZx3G9lD2AXSLkpq25clKd9O4oNGWhOPkW0W8346vFvSrHzp/3mIO6eKYpVORXN1
         ArljCztyZfF1GaehiacKtjx+kRoBf/HGp3hWYlhnNryQVwi6dwIQzymL0YMcrHZiLKIq
         PX5Z5Wue+jj/vetKMlEWQ1pfLtAhsU7AEiX0hEDviR7qeqGn1eC0EuaOUnKj5ESGa+9u
         g5dD/M0TWccR5Y0wpKTt/wDKmRZ7F884jGRJrgLcRLMjMMnGZA4mSoQ7Q5VKiVjDd+ED
         cKk/n3zw68exjOfB5fDuj36ADoBUYwFSafWlFyWNHWZF1PomdjTZEoB/y2dZmfFrpVWR
         N4Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747094937; x=1747699737;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z0usMcMWdY8lq5FVni3HwlJ8NWBna50dNtlKJxA0fhc=;
        b=Yv0jRlKcHIhAmHcL+6MTSi2w8WHKbY1EnM38jVvvsMoVnjcWqeHP7GCQZREtWiylxr
         BX0zhW/NVdnz49h8DQeYUU0cO/Zv2/19hizJ/PUG9/oRS16Nq9GwZR3zTl+kVKOTAXNR
         jJmZmL0EGR76vimL3RuLCD8vWQXdnp+CqeixcTsWwfyv22H3bPSaRzBRHUwGdKRCtavm
         CNoNLzDvtUZe87q0RzPfdCcbvL3gBQJVo9M6gmAnIaXH7GJZeifI8S5amOclpDv4RP6+
         BMUUGa/AuG5oSdeNtahMR3Yf3+1346mv/bjAc5FqIum5PjgqsfRi2aF054HoVKosbBp8
         GntA==
X-Forwarded-Encrypted: i=1; AJvYcCU2ThUkhw9lL6bFY8n7A2L/bbpOgVF53od1ealkxe6gQcRhxa98IvYCrsAJBZc1qFvgRGKa9NAP4c4lLx4LSPiz@vger.kernel.org, AJvYcCU8WI/zcKmaJ1pYVQT2bfj0QHPyQIMlm9xE8zMC9+G8ooHbCua3L4RCAsHj4NkdpDv/X1vI3URT@vger.kernel.org, AJvYcCUIDES5z9wJqsh+2pHKUSbg2vr22oOM0znXwoKP/r4Y8gtEruOkNaydGiqyLsaj2IIxMUdgHpiGBH0UKJv8@vger.kernel.org, AJvYcCUgudH/w2Ny81UXtWBgob5iTenFVOedRpwPEJxpgrsp49IHYk/e9dWTFMqFWMPs5+vc8gWz1ZPJj7vcEQ==@vger.kernel.org, AJvYcCWESUZFTtvz14Nsr4u3ZX8rH/1qP9si4sF7RhqrvBjHgQn36BTcdTOnNaPXnLeflFPnqic=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZslhwCbmwNAAma1rkptuOh82U626By0zyIvzMeeKtQIWGZnU/
	hyJ6L/XeBRi4RHhciyfmgn5zXWxN12T14yuATjTd8HwavK60a8UgOYhmr8OF4KFvmzt3Zz8ju6S
	+31XcztSyMqo8YNYumAq2CGJWRrE=
X-Gm-Gg: ASbGncvU/zYt5Rfquo2IIdh1ywnoFQt1dQ+uN2LaKluXE270T+JESgf8+wKO83JNqxC
	kchs8ZeYirqq/NPd8g5yEXo5hR5In9fVa8+QDTXed1I/5g5aTDf/JqCtDH/n4wM3noodwM2SaoD
	LmDU68BqNVyJMpJPm7L3ckp4oZkDaZUrLuJ8Fh+ivt21y0aDNWYGOhevqPyx/P5XWKJ39oeuxR
X-Google-Smtp-Source: AGHT+IG6Hz90vyaSCvuZEEStO56/EfmLm4jy+VPkC+7LSgTl2r4zMMUWiNmhZdoBi9DUh7+CwrGSoK2927YgvRKWh68=
X-Received: by 2002:a05:6000:3110:b0:3a0:b817:2d7a with SMTP id
 ffacd0b85a97d-3a340d34576mr996553f8f.29.1747094936767; Mon, 12 May 2025
 17:08:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250512091511.2029269-1-skb99@linux.ibm.com> <2025051204-numbness-nephew-05f9@gregkh>
In-Reply-To: <2025051204-numbness-nephew-05f9@gregkh>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 12 May 2025 17:08:45 -0700
X-Gm-Features: AX0GCFtDKtwoUVfexcyHhD6lveCvM6KUQViwhMY0AsbIsdBYJejqhW-l-fzvCHU
Message-ID: <CAADnVQLbkUGTdF6SpNp-LiPwuNSa_vtsSHwXucXa44ecShhstw@mail.gmail.com>
Subject: Re: [RESEND PATCH] selftests/bpf: Fix bpf selftest build warning
To: Greg KH <gregkh@linuxfoundation.org>, 
	Network Development <netdev@vger.kernel.org>, Jakub Kicinski <kuba@kernel.org>
Cc: Saket Kumar Bhaskar <skb99@linux.ibm.com>, bpf <bpf@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Linux-Next Mailing List <linux-next@vger.kernel.org>, Hari Bathini <hbathini@linux.ibm.com>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Venkat Rao Bagalkote <venkat88@linux.ibm.com>, 
	Stephen Rothwell <sfr@canb.auug.org.au>, Daniel Borkmann <daniel@iogearbox.net>, 
	Mykola Lysenko <mykolal@fb.com>, "Song, Yoong Siang" <yoong.siang.song@intel.com>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 12, 2025 at 2:23=E2=80=AFAM Greg KH <gregkh@linuxfoundation.org=
> wrote:
>
> On Mon, May 12, 2025 at 02:45:11PM +0530, Saket Kumar Bhaskar wrote:
> > On linux-next, build for bpf selftest displays a warning:
> >
> > Warning: Kernel ABI header at 'tools/include/uapi/linux/if_xdp.h'
> > differs from latest version at 'include/uapi/linux/if_xdp.h'.
> >
> > Commit 8066e388be48 ("net: add UAPI to the header guard in various netw=
ork headers")
> > changed the header guard from _LINUX_IF_XDP_H to _UAPI_LINUX_IF_XDP_H
> > in include/uapi/linux/if_xdp.h.
> >
> > To resolve the warning, update tools/include/uapi/linux/if_xdp.h
> > to align with the changes in include/uapi/linux/if_xdp.h
> >
> > Fixes: 8066e388be48 ("net: add UAPI to the header guard in various netw=
ork headers")
> > Reported-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
> > Closes: https://lore.kernel.org/all/c2bc466d-dff2-4d0d-a797-9af7f676c06=
5@linux.ibm.com/
> > Tested-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
> > Signed-off-by: Saket Kumar Bhaskar <skb99@linux.ibm.com>
> > ---
> >
> > [RESEND]:
> >  - Added Fixes and Tested-by tag.
> >  - Added Greg as receipent for driver-core tree.
>
> Why?  Commit 8066e388be48 ("net: add UAPI to the header guard in various
> network headers") is not in that tree/branch, so why do I need it?

Certainly not driver-core.

Please resend with [PATCH net-next] and cc netdev.

