Return-Path: <linux-kselftest+bounces-45946-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 71886C6C864
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Nov 2025 04:10:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 47B7F4E21F7
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Nov 2025 03:10:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 662F3256C70;
	Wed, 19 Nov 2025 03:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="bGycDVf+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32C752144CF
	for <linux-kselftest@vger.kernel.org>; Wed, 19 Nov 2025 03:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763521816; cv=none; b=lGipshgIx9SYwXxe8EO4LQxdUKsR/SZrtUxU4dJrFRnzV0Y+SHyqRNvQ2Cgwova2wvQrLkKg25I/IDkZzubY0WN8nXHV3U1VlDfr5Zaabj2d87iIZS6ELmzYHLjZQMuRfawpKr315Ms28nFVUNe7z3srACHlrs0zD48YDEDrF04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763521816; c=relaxed/simple;
	bh=68APKa9GlwtzRJX5iUtVJTi8dtri1nANgnJn/bvUutI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NC3tndkFWt6uvfKcyNSxct6RitNPb6Itl23EtQPmiLYLi+jG4OImzRF/YAJ+KsUKAzvsqi9va4e8m3T+Gh6jzjv4fEZPZ9v354uDEoHZxmBWVSRIwJnkLAogEWwtvVWytwKfiOvNUmwjfz5Iw2mDhm8z5jE8G8Dnq4bVCcwP/24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=bGycDVf+; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5942b58ac81so4801989e87.2
        for <linux-kselftest@vger.kernel.org>; Tue, 18 Nov 2025 19:10:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1763521812; x=1764126612; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q2YghkojSSpevvv9N/FPojo07MSL6tIdS5NFPr/1Qtk=;
        b=bGycDVf+S2KpLGKFGK1l+3DgXbILSDFu0HQWI+0ZHyMS6ahNIeQO9vLoGXVhIBonku
         zlP2S4IoH/aybfeafH0yz8/yv5Sc84EMr7osHCHRpHgQLOyfuPdfRBoyL8aOT5jMwcwo
         gNOhehI7bSjW7l0/uSwhD0EogZuMFDkGHdTWaLy80PxGBwWTBvySTCOOixmF7qTqoeNe
         Ga9ql2d7nSfXntqiwOF1uFflWtW07XMet7WSqNeqLUPeztJFtEE/laUvg1yGd2T4VQ9g
         ecZ8sVchhWF3zPJPH2tagkuZ+6WDUQrM9QFw1JLUX/Zxod+Sq2RVXi8UdMlbk7EgVjxQ
         Ug/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763521812; x=1764126612;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=q2YghkojSSpevvv9N/FPojo07MSL6tIdS5NFPr/1Qtk=;
        b=fUvPkwnuR4KAvaM4d8urKc/6TPf7DGSD1D813JtFIWEoqb45Xq2dWN+v0uCnZ2coWE
         HhdJgTbjRjEJqkbA8QcuEPGhheQVX6SfAnspvRFZkzvt0h6oD+vaVBv5KjGyWewbW83f
         X9CDPSlX2O/GF2zEcuj57AVBJ53fc09dnNpeQ78H8I6AvsZK8QxvEWtm0WaxpXf8vlP5
         25rYeiyS590JRb0Jmy4CaY8ETFybZ9zTP20NXJhQk0SFyDkQI3u8ql8XLudrdiSXaPLy
         r8i8GnV+LjBojI8KEY5VC2vDJHI+OL30MWGkHX8B4HcuC1pH6XN/tPGJFBwr5EU7aDVW
         sEcg==
X-Forwarded-Encrypted: i=1; AJvYcCWgKxfjytWv877VCuww3zfEwk1MJTAUsNLFogUZqihtxfzoXQoh7HSPLmp+PTjZ55P+KO0OBkyipjBgiQWoyjU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyaFv9DfxgNbkiqAqmHa3jgNI4gamKkIhUAv9Cok/K/tx7Et2yd
	uPn/8alszXqRQW23CSpRTX9bImVMaJS7BLM+KtJeGs9WP/mFd8u85Bpt91tBALeetqJZw/lWhfw
	BFGbTG7oE1flnGGZ5wAnRuJDnsQmX++yvwG8J61QBFw==
X-Gm-Gg: ASbGncs2pdIVKhpDUzX0XiRuNsEfUmzssG/004chOY81157FXWCni3AMqDQKIVg9W97
	kOGYLodnp4HEpWfpz+dmKEu+/CIAwz9CWpewokNpUG1gNNZ4NVwD1lA8x6DCqTHyRDOpeAan0uo
	0MNFLZfTCmdTrPp5p3pfl83zLFjl815lnKXw/MKLZ0d/qE73fA+c/q7wLjj5AgRdUPRvt/5IxDC
	MAP0b4fh4y5Q3rj3DrfprMCJT2IzeCbc3K7+zxY4CsfjEnzIQHCvvRG+viMz8xB+WgJNganTD4n
	7CNUip80TIST0NnTT5d6ELQ9FWf70qsyTXnaIkT+Gvb8N1qjcqg=
X-Google-Smtp-Source: AGHT+IHMfGHXG2CYSD+9mEa3R6HmQrws78pTq2FdPwawAY9UdcuMW4+8J5YqjKlFwTC664TQ0iqCfNsOnK8j4YPxHfc=
X-Received: by 2002:a05:6512:61cb:10b0:595:91dc:7289 with SMTP id
 2adb3069b0e04-59591dc7516mr2637749e87.9.1763521812320; Tue, 18 Nov 2025
 19:10:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251115225550.1086693-1-hoyeon.lee@suse.com> <20251115225550.1086693-2-hoyeon.lee@suse.com>
 <9ed9de08-9a5b-4fc9-9213-ca918dafea0b@linux.dev>
In-Reply-To: <9ed9de08-9a5b-4fc9-9213-ca918dafea0b@linux.dev>
From: Hoyeon Lee <hoyeon.lee@suse.com>
Date: Wed, 19 Nov 2025 12:09:38 +0900
X-Gm-Features: AWmQ_bnkvj7-3fT807_E8LeNQCflok9rVCdhBURRRkQZwi9Cgcuqb5hVKaJ_Sr8
Message-ID: <CAK7-dKbxgFqw8cjfw3oWvZCQat=UKUq7u4zU+nx4xw-g5m4n_Q@mail.gmail.com>
Subject: Re: [bpf-next v1 1/5] selftests/bpf: use sockaddr_storage instead of
 addr_port in cls_redirect test
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 19, 2025 at 8:12=E2=80=AFAM Martin KaFai Lau <martin.lau@linux.=
dev> wrote:
>
> On 11/15/25 2:55 PM, Hoyeon Lee wrote:
>
> >   struct tuple {
> >       int family;
>
> The "family" is not needed either. Just use the ss_family from src or
> dst. The 'struct tuple' can be removed also?
>
> I'm on the fence about whether this "struct sockaddr_storage" change is
> worth the code churn. Are patch 1 and 2 the only tests that need this
> change?
>

Thanks for the feedback.

Yes, patches 1 and 2 are the only tests that use a custom address/port
representation. These are the last remaining cases, and no further
changes are needed elsewhere. The code churn is fully contained within
these two patches.

For the =E2=80=9Cfamily=E2=80=9D field, agreed. ss_family is sufficient, an=
d the tuple
wrapper can be removed. If you're okay with that direction, I can drop
the family field and resend patches 1 and 2 with that cleanup applied.

> Patch 3 and 4 make sense. Patch 3 and 4 are applied.
>
> Please post patch 5 as a separate patch on its own.
>

Thanks for applying patches 3 and 4. I will send patch 5 separately as
requested.

Thanks again for your time.


> > -     struct addr_port src;
> > -     struct addr_port dst;
> > +     struct sockaddr_storage src;
> > +     struct sockaddr_storage dst;
> >   };
>

