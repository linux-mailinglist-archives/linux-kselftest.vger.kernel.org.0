Return-Path: <linux-kselftest+bounces-42813-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A5CEBC0223
	for <lists+linux-kselftest@lfdr.de>; Tue, 07 Oct 2025 06:09:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 46F5D4E7FF2
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 Oct 2025 04:09:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FEC5217723;
	Tue,  7 Oct 2025 04:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YhTqT8nk"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4662120FAAB
	for <linux-kselftest@vger.kernel.org>; Tue,  7 Oct 2025 04:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759810143; cv=none; b=sDeW7L+xN/OqFH8V0svfN+JK/7JEiD/LEj1DffPCavKc8w30YUiuGbBdDUqg4rgFN+WiTg2FxkHFU5vgwT8ILYdveNU1NE1Zdmv0BHROF6j+rmV7qWR8I+xdOpHJvqTUo5VBrnn88QBb0wU1fx0bmLsSTXZ/WucZXxtBz7rlRrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759810143; c=relaxed/simple;
	bh=432QvHvOj19tKWGrDdk4erAr4nKhVAMEK3WbFkC/IRQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jMOTvSQNizZQxwvvAu95WLWKyyUkxh8QhGb9gVLpxmgxlzpcp0WNPwAVUJKiywyVkMzTvD/Pf3eJo00fzV/b5C3aDn72jrsyr4VFu3ZxEOEeOChW9G5UiHUX1niOUEvSN755n4Jg8cmc6Dk5fR9MPHRNvgFqNkOL5LX4HbCKRAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YhTqT8nk; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-46e33b260b9so54775455e9.2
        for <linux-kselftest@vger.kernel.org>; Mon, 06 Oct 2025 21:09:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759810140; x=1760414940; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wK04lQWKr2DjWtJceprl3zo5tRNApv5guaFqKP5j6NI=;
        b=YhTqT8nk2g/L01i/OaUJ8+4bKkVsbeTIxroy6/QXn6yXZjlnyHFktbGs3ef6/FXWAz
         f1G6wiirRsDMVVyVhqUyIoXvJXp/7wHif4GPFxJDe+V4Qn2tCkBjyR09EZuN4XTh0a7n
         vLfCIWmVU36f0XTWlKoai9+jIwwNse36wv+2K9421mSjoTx0b2dNYk9H3LQfc+V2wK2R
         iwegy6d4dZGBMP5E7m52Ec4MdNIGKtsEklg5Hg2D0KOLKqEpWGkQG+TuuMfCLtklhcdW
         IurDnPcR8AsaeRaPnuSlaa2v+yudDtoo6AA/Nn8hi3Ur7FLzlBajTC4sZP6x6LQriJOJ
         MBqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759810140; x=1760414940;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wK04lQWKr2DjWtJceprl3zo5tRNApv5guaFqKP5j6NI=;
        b=CUb/PLR48UDKjW4YEVAwnYUm9ul4BLHRqhect00GplVH2WN5nUSK5kSKh/PJ+itwlm
         TLkpU/K7fPWoNr4hvYfH/cKrt1kzEQRLyGOqosogpSfaxA7gzBVuXeDmxNODMx7aoOLp
         LYyUkGnHJjCqjvCTAf6v6GsE0yY2m0FBD72pMeaBQDSBiVkQ66y7MwAXko0MoPdGpq3L
         ernKbN2r6IdkX1vyPaE52xtkUNE0nm1DGUWK+gBB6bZwM16wEmT4EnqiiV/SMnw/6CvS
         tpjg2Bi7FvOII37Dofb6Aj2Lr36zfikdDazgMWyR14iOC4rj9hWTmgpImmTfMyxPQGWT
         PBXQ==
X-Forwarded-Encrypted: i=1; AJvYcCUwl0Rz0wDGsj6jRWDrBtIexcJ68KmULeyykFnTHNTNTchysrxhtaoCtbOZln9O0IcCyhv4gvifRFBcBibbEbo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQKXy9kL5Puex23S5LXDNL6aKJXzAKIbNt4qgBp9y0EEpaVNHs
	pbqlVzdMd4EfYws94J0jq9F68mHu1pQVpXyfm8dluenjVyq0mE7swGzmgFplgkPWA3Pzjk3jv9p
	Cd6g1QJtchjHGFXh2UqZdZqVGoXq+tkI=
X-Gm-Gg: ASbGnctVkufHnPL1TnWgeFOmfDt0Eu7IrWbckAS7+tKXED/0Ich3va0f8Nl82jEhe7h
	Dn2laWxxzn7/FBcO96CuJurfKe5+E011YrGdxq9mXLlDzoknwFFlqIBJzXj05OmoXZxE/io+C1Q
	OcbKUH/BF0AjSNAhVzorxpsc6iniLAp5yvVkbrjfrCu2tqFgq7BLPw/z2WSih9A0ZtPKKbugFKe
	jluMvP3HhF/k0+IYxo0hDzZCNwAYCXlLhyufk74jN6YBv19mX7ViNEgLviHgg/SzISxn/VCDw==
X-Google-Smtp-Source: AGHT+IHYHh6bEmYuCmFai3v43g5P6gr1pDPCY9ygDD4iuTvWaHhchyjoP1nQ92EQruT44rG7ohu+X4LwmhENyChZTvU=
X-Received: by 2002:a05:600c:4e94:b0:46e:394b:4991 with SMTP id
 5b1f17b1804b1-46e71105457mr96964855e9.11.1759810140454; Mon, 06 Oct 2025
 21:09:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1759804822.git.rongtao@cestc.cn> <tencent_6E59062E4249590597452A06AFCDA3098808@qq.com>
In-Reply-To: <tencent_6E59062E4249590597452A06AFCDA3098808@qq.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 6 Oct 2025 21:08:49 -0700
X-Gm-Features: AS18NWBUCpOWw8ZMVB20Bk2k82iz0iF-_IQG_RoaZfjQrcbZ-AoUhVqW_uV4EFY
Message-ID: <CAADnVQJFBR5ecewWdDhTqyXTMWH_QVEPCm2PXxV_3j1wa+tWMQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 1/2] bpf: add bpf_strcasestr,bpf_strncasestr kfuncs
To: Rong Tao <rtoax@foxmail.com>
Cc: Viktor Malik <vmalik@redhat.com>, Alexei Starovoitov <ast@kernel.org>, Eduard <eddyz87@gmail.com>, 
	Rong Tao <rongtao@cestc.cn>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>, 
	"open list:BPF [GENERAL] (Safe Dynamic Programs and Tools)" <bpf@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 6, 2025 at 8:00=E2=80=AFPM Rong Tao <rtoax@foxmail.com> wrote:
>
> +/**
> + * bpf_strnstr - Find the first substring in a length-limited string, ig=
noring
> + *               the case of the characters
> + * @s1__ign: The string to be searched
> + * @s2__ign: The string to search for
> + * @len: the maximum number of characters to search
> + *
> + * Return:
> + * * >=3D0      - Index of the first character of the first occurrence o=
f @s2__ign
> + *              within the first @len characters of @s1__ign
> + * * %-ENOENT - @s2__ign not found in the first @len characters of @s1__=
ign
> + * * %-EFAULT - Cannot read one of the strings
> + * * %-E2BIG  - One of the strings is too large
> + * * %-ERANGE - One of the strings is outside of kernel address space
> + */
> +__bpf_kfunc int bpf_strncasestr(const char *s1__ign, const char *s2__ign=
,
> +                                                               size_t le=
n)

See AI review for the above part.

pw-bot: cr

