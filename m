Return-Path: <linux-kselftest+bounces-46900-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E033C9C8BF
	for <lists+linux-kselftest@lfdr.de>; Tue, 02 Dec 2025 19:10:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B93CD345528
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Dec 2025 18:10:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77CAC2C11E3;
	Tue,  2 Dec 2025 18:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qed2Yl5h"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A18A12C0323
	for <linux-kselftest@vger.kernel.org>; Tue,  2 Dec 2025 18:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764699043; cv=none; b=Y7D6kV/5BLQtXWTebNmZLZ5S6P6Aopc3tCJ0iCi8Wg2+riAyTT6XkrKP0sDx6fww/6lQOsLR2lY14JJszSW/8ECy5/qvXPS6xd/Vnn+O5xFBDS8/sT1sT4WTZapOvzQj5g+Cw/3QeXeog8wtvnQdDImR1bPFncrLIi/HRai4AMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764699043; c=relaxed/simple;
	bh=VxZLTvVizJzJap1+YiPVMWVXJUFU88RsVJRpSIPd9UM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d7TyVB1nsdjDrBaiHIQ8KJ7mvRpZiVEzt5tmMX8hPVKaBFIGmnokqLccerggpYrEZuCoYSmJQLYQ2alTVwJXOGIJsRwTQPqG0LLcxA8A8Xg+en1FlxA06z0EhhAwiML5CPttptmESkjSZndl/b/PNzgXEBjXrVMnEFA7OBDhfdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qed2Yl5h; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4779ce2a624so59625885e9.2
        for <linux-kselftest@vger.kernel.org>; Tue, 02 Dec 2025 10:10:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764699040; x=1765303840; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9zQ9S8GjJihhSkjyJGVqGv5zPPyHBC1OeTo6aMqxHdk=;
        b=Qed2Yl5hhdCAHM9EuJm3ZBQ5hpwZePTI4JcIz0drdZzt9CPPxkJWhUIeox7FWA8y5o
         LKt8Vl8iSrYxdRj5W3FPOSp5NK7Z6gRO0LIthcW5w2g+Huu/sejGbeBTRlpTDAiZsI8m
         AYWafeJUcYWOugWY6eXSTVj3//fcSTPjCMY5z+GjEcAt0Kmr+5Kc5T60a7wGVV//Kgf0
         AvwLWTjhMdvXALT4EHG47kfMTC7WFK3iPcd1ubw6uI/tRkCn3Ux17ZpzIgQDVz0T2UMI
         AWH038ti0hjdQucLQYo2WxCPTim1yjGKuVmOTRgJysY2KjdyqZaZBkWU+USc9Ml1lwei
         1AyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764699040; x=1765303840;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9zQ9S8GjJihhSkjyJGVqGv5zPPyHBC1OeTo6aMqxHdk=;
        b=IZOmqV6wLCMZ0kG8KBvyb1ATmQFQnbuxD8jryY5rIQSoYA6gOVk+6U11oz3F5mtVEl
         FLIrBasMtPLAJHBaZku+AGXTzWZ2XxXuBNrkmI1bFSXv/SecO4IDwVm6X52FmfoJU60E
         1kLyba8htqikvc0XSVJdhaZCnWAaFnqW+OqcL0YKIecXNn2pBwG1uAx+X11LgBTzpHxC
         xzJWtq79qU9zLeRuw/L4RMkWsbi4VW/s4dSAQpjHWM48uXKDTLBeGCr/mGZaEb+uzUmF
         G0bMByeaKu4clUubK0g3VL7x83NNj5ttWPTV281D4SFVaolP96PCUvn5BzDtI8jnOFjj
         whrQ==
X-Forwarded-Encrypted: i=1; AJvYcCUEHTPAMkFCp69zn+h+7guR9y0qG0swgF1a7cF38Dsxal7JJfEdPtTvNK/KZfq5h6oYcXHizf1GbxT4rj3uzVI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPJ2619dNT9VmIis5w64ajPeaR5SUKkL8hRJZMYI5FGM6nnGK1
	5/NkZHQxxEJSg16Ob8eDWCdcsDCdtCT1Z9xTirkCBcRAsIZVUsn0b6gsaFiXDKAt1KLebVrIrEP
	XCxgvbZq8TSRyR1O/Z5gHhgapheb0Ksw=
X-Gm-Gg: ASbGncu7fxdF6jWWfYpudkLki+AlkJptZD3Eb6+BVU398YvanF9SmQQdiKP6WZQyXF5
	cXv5tQkxHdhR4xYDkg9YFXT2pY6SzQpD1SuNxtejoat0A+Egbn+B6IwjiB3+iLmspDYrKx8aOu7
	pdo0HyYROvpzl/kCZKfqmUKZ0JlURxxcLMH6KlEedbDXUeIJ2u5PpU7nNnQxK+m+75b/YZmiFV/
	c4uqbdCqhwuYrSbcxPX/rWrFHhvq4vcRhrfunFLFnBSc52rNmJhsHMTvTaFdSGfzhApNgyYtEQj
	k28baxH1HOk+r1t5Q034F1DwBBG5
X-Google-Smtp-Source: AGHT+IGmDtLnJKQFaF8xzPjXK2P568G6lE89uAl5uGpADSt7HpTFHnRZBJn5SJKWegqVu0Veh5Q2gsTPy35UnnzwJl8=
X-Received: by 2002:a05:6000:2508:b0:42b:32f5:ad18 with SMTP id
 ffacd0b85a97d-42e0f1d59bamr31271636f8f.9.1764699039852; Tue, 02 Dec 2025
 10:10:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251202153032.10118-1-leon.hwang@linux.dev> <20251202153032.10118-2-leon.hwang@linux.dev>
In-Reply-To: <20251202153032.10118-2-leon.hwang@linux.dev>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 2 Dec 2025 10:10:28 -0800
X-Gm-Features: AWmQ_bmp0KkYlQV48oluSytqF-nJ2NcrUFwqTfZotzXIVOWFqiw0XL5HFHmpBg4
Message-ID: <CAADnVQKrxz6Fa-rT6466U_HjE4TDDrJ9kdU_h28=Av+L92NBgA@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/3] bpf: Avoid unintended eviction when updating
 lru_hash maps
To: Leon Hwang <leon.hwang@linux.dev>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>, 
	Saket Kumar Bhaskar <skb99@linux.ibm.com>, "David S . Miller" <davem@davemloft.net>, 
	LKML <linux-kernel@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, kernel-patches-bot@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 2, 2025 at 7:31=E2=80=AFAM Leon Hwang <leon.hwang@linux.dev> wr=
ote:
>
> When updating an existing element in lru_hash maps, the current
> implementation always calls prealloc_lru_pop() to get a new node before
> checking if the key already exists. If the map is full, this triggers
> LRU eviction and removes an existing element, even though the update
> operation only needs to modify the value of an existing key in-place.
>
> This is problematic because:
> 1. Users may unexpectedly lose entries when doing simple value updates
> 2. The eviction overhead is unnecessary for existing key updates
>
> Fix this by first checking if the key exists before allocating a new
> node. If the key is found, update the value in-place, refresh the LRU
> reference, and return immediately without triggering any eviction.
>
> Fixes: 29ba732acbee ("bpf: Add BPF_MAP_TYPE_LRU_HASH")
> Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
> ---
>  kernel/bpf/hashtab.c | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
>
> diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
> index c8a9b27f8663..fb624aa76573 100644
> --- a/kernel/bpf/hashtab.c
> +++ b/kernel/bpf/hashtab.c
> @@ -1207,6 +1207,27 @@ static long htab_lru_map_update_elem(struct bpf_ma=
p *map, void *key, void *value
>         b =3D __select_bucket(htab, hash);
>         head =3D &b->head;
>
> +       ret =3D htab_lock_bucket(b, &flags);
> +       if (ret)
> +               goto err_lock_bucket;
> +
> +       l_old =3D lookup_elem_raw(head, hash, key, key_size);
> +
> +       ret =3D check_flags(htab, l_old, map_flags);
> +       if (ret)
> +               goto err;
> +
> +       if (l_old) {
> +               bpf_lru_node_set_ref(&l_old->lru_node);
> +               copy_map_value(&htab->map, htab_elem_value(l_old, map->ke=
y_size), value);
> +               check_and_free_fields(htab, l_old);
> +       }

We cannot do this. It breaks the atomicity of the update.
We added htab_map_update_elem_in_place() for a very specific case.
See
https://lore.kernel.org/all/20250401062250.543403-1-houtao@huaweicloud.com/
and discussion in v1,v2.

We cannot do in-place updates for other map types.
It will break user expectations.

pw-bot: cr

