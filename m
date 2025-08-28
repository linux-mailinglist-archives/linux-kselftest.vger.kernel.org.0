Return-Path: <linux-kselftest+bounces-40204-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AD324B3A746
	for <lists+linux-kselftest@lfdr.de>; Thu, 28 Aug 2025 19:04:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 717AE169945
	for <lists+linux-kselftest@lfdr.de>; Thu, 28 Aug 2025 17:04:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E21793314B9;
	Thu, 28 Aug 2025 17:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TqIjF2eh"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AA8F1624D5;
	Thu, 28 Aug 2025 17:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756400683; cv=none; b=O8V/TzsI/Chl5XFL7OKV/N7cxyaWfGm9R7uuk0N17RjlEhG7Bw52ePFUz7gImk8MThCJyYIeLOaep8kpxdh3cspB2qZk9Uun/A7/ZDjIMjDxx6DJURVlm6xDAiZjYiO82WjV7ThxJllUATZOkXFPnYgvoww9gocGQ78oo31Rf7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756400683; c=relaxed/simple;
	bh=ro7RSIiLzI/HFo3sLXaNXatjdUFS6DcqL5llpgvGnxM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=djvDkqdDimku+Eukn/8umxflmJjSLI7brXFOe+D5fiZ9A4Yv4r/1kn5DIKQnjCInwGe7ExoGPXyRoBuxa8n+uoCsOGV4BZizJIX0H/zL+iNllhchHtAMJizZLM0aWXhE+hsjyIi0xNKewvJZBXCJu1DHQ5ajVclKMHdhD13+lKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TqIjF2eh; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-b49c1c130c9so877056a12.0;
        Thu, 28 Aug 2025 10:04:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756400682; x=1757005482; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W2wC2bic+HM0w4hPf0WG0ikD2mufCn5v6xkL6+MZy2Q=;
        b=TqIjF2ehTlreF6k0K4kN55182G6+31r8+yNR7/ExgN63Z/i/CmkkezqJW/S8UFfImR
         nSUwol5m5Hw3JgeuvZqfkuEf903TUP10RPVEqfVPrSqh/nVbR2kAVvuJ2k51LKpQUpVw
         oZaXnk/Vn+vVlzyzywzUNXe3W1rAtnCki9TA/6NhkfsTpod9C1S50OVofJvlQRavVgpS
         2B83ICz4thNmwqVWLyeF6GdSy8GvqSkpdZID5pcQheH0548Ed4ZBCGs2fc27HIfGS+6p
         BX1NLMXpRg3gE95hsh5xEbxobGgA3DXWm+9Dr2cvy1AH4TQUZnlOsXWYtKltfrdF8PiF
         5rVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756400682; x=1757005482;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W2wC2bic+HM0w4hPf0WG0ikD2mufCn5v6xkL6+MZy2Q=;
        b=migjWQsJbO9pZeH/a7yaU6jqIXTYGmsM1W6xMtWyCcLtvw0OTTomQbLzmKm4TGmfKz
         u2d/Jh7D2oq9NEkkTholE1LA8M6+Gg4N80snMpvFmPPkrWj+/MgRkxYLjthOV19w7ql3
         /gnI2OgZlzc0dFleri0LsShLVpkn/2XMr/sKBgRAwzMRt4pysyDIohoUs5PBS4kogsuT
         qWItqaa1UydHmuLR69egPw4e4stAHKBVckAHieEu1A8ysDN7wBnlay6cbD8AtfG5vyyL
         6tfyTjDRlzr+gdJgyvQrlzmjsOB9wzY2I+KRZU8T1eKpcQ+pL3ncX43YIc8wJIeEEkd8
         n0vw==
X-Forwarded-Encrypted: i=1; AJvYcCV0prD57La6+O9cIdIaDr1WOf3yH62Xzc06qxK+yRVkT8MMkXwaV0Bu1CsAWmczFHiRKC8=@vger.kernel.org, AJvYcCX0OuxuHzJshEIjQgGE09zNXZVb5SOBm28yMl41JAE8unmQKOoRUTBnnYzB/5Bnd9DdjFC0/mqOfbLcbTLz@vger.kernel.org, AJvYcCXJtG71t4zqINlOREUNc2Z8DRvNDIF6UsxsIPVoFS6imThMv7SMecUw8qKjGCMr2BiB3rG/NCAuxsQBrj6lwx0k@vger.kernel.org
X-Gm-Message-State: AOJu0YzScxQNhFB2HVXhrge7nEXGFsDLPZ9vTjmdVuXenZ1WFSqH+ws2
	U245eQWSTD4LwXM1OyPHCHPwxLzVJ0Oa3oYoezMPKto9m3kPlq3U3slxfKokzK4qsKTVDVlXkIA
	ktaGQfkQZLMJHahQuCjKoRqePoEcupFs=
X-Gm-Gg: ASbGncvHSAU0kheG0Sstqh4gnLyn2adjLX/JM/omHrTNPgvLsG7bhYz/lDQfIGLrAm5
	44Ied+dWTfQ1w+FoPMEvEUFlyNBuyoAqBThce5QEX/ZNQURNJcBGWZl7MYHMtEdF9AsB6VjlQGV
	7TBWRwk8TjsHFC5Q4CAYpLzRacJ4misPrH3Kk4W4xkIkuenRzAdlejNc4N/8tJ5J10EDgCnNqw+
	SZ3WIA9KlMgydLf6V4wpHpwOcp+73o6
X-Google-Smtp-Source: AGHT+IFiz9Fltl3Ekl6BtNBgM/mYYAS5rXsGZowBgqkTJqyGF3lSFbLfo89hYUxN7PU+O0TF3aQJIJzRRbhaEBFoDdQ=
X-Received: by 2002:a17:903:2ad0:b0:246:b93b:9739 with SMTP id
 d9443c01a7336-246b93b9d0bmr190974475ad.22.1756400681424; Thu, 28 Aug 2025
 10:04:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1756378974.git.rtoax@foxmail.com> <tencent_69BD268FBA201219240B51661D5E96A8D80A@qq.com>
In-Reply-To: <tencent_69BD268FBA201219240B51661D5E96A8D80A@qq.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 28 Aug 2025 10:04:29 -0700
X-Gm-Features: Ac12FXzNK0vBhdz_ED_YsUdfZ9pdzwt-wk3B0YpHBu8eCPK40xcRRGNSxIQkCok
Message-ID: <CAEf4Bza9=xYzT=QcoZjiqn7rnfBP9bjtEuWLu9qZKKodwOjgZg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 1/2] bpf/helpers: bpf_strnstr: Exact match length
To: Rong Tao <rtoax@foxmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, vmalik@redhat.com, 
	Rong Tao <rongtao@cestc.cn>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>, 
	"open list:BPF [GENERAL] (Safe Dynamic Programs and Tools)" <bpf@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 28, 2025 at 4:07=E2=80=AFAM Rong Tao <rtoax@foxmail.com> wrote:
>
> From: Rong Tao <rongtao@cestc.cn>
>
> strnstr should not treat the ending '\0' of s2 as a matching character,
> otherwise the parameter 'len' will be meaningless, for example:
>
>     1. bpf_strnstr("openat", "open", 4) =3D -ENOENT
>     2. bpf_strnstr("openat", "open", 5) =3D 0
>
> This patch makes (1) return 0, indicating a successful match.
>
> Signed-off-by: Rong Tao <rongtao@cestc.cn>
> ---
>  kernel/bpf/helpers.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>

Add Fixes: tag?

> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> index 401b4932cc49..ced7132980fe 100644
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c
> @@ -3672,10 +3672,12 @@ __bpf_kfunc int bpf_strnstr(const char *s1__ign, =
const char *s2__ign, size_t len
>
>         guard(pagefault)();
>         for (i =3D 0; i < XATTR_SIZE_MAX; i++) {
> -               for (j =3D 0; i + j < len && j < XATTR_SIZE_MAX; j++) {
> +               for (j =3D 0; i + j <=3D len && j < XATTR_SIZE_MAX; j++) =
{


that <=3D is a bit subtle, and combined with extra i+j=3D=3Dlen check below
is a bit confusing, so I think it would be good to add a short comment
explaining this corner case you caught and that we are doing this to
ensure that we matched entire s2 (and thus we need to find NUL to
confirm).

>                         __get_kernel_nofault(&c2, s2__ign + j, char, err_=
out);
>                         if (c2 =3D=3D '\0')
>                                 return i;
> +                       if (i + j =3D=3D len)
> +                               break;
>                         __get_kernel_nofault(&c1, s1__ign + j, char, err_=
out);
>                         if (c1 =3D=3D '\0')
>                                 return -ENOENT;
> --
> 2.51.0
>

