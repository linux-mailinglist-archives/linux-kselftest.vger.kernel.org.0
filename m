Return-Path: <linux-kselftest+bounces-26074-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 67DDEA2D2EE
	for <lists+linux-kselftest@lfdr.de>; Sat,  8 Feb 2025 03:13:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F3B5516BCAE
	for <lists+linux-kselftest@lfdr.de>; Sat,  8 Feb 2025 02:13:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5197149C41;
	Sat,  8 Feb 2025 02:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l4VlNQum"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C21022AD32;
	Sat,  8 Feb 2025 02:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738980795; cv=none; b=r2nuupqW9zJfcm2kygPCNEgANX+Db2FzHOvemFkgadyDcDZwBwijncrP4b/CYWIhiXDcK5WiVgnnMofi01fW9g9Q8HqKnLec6P3jNMfmqG1eRisAk7fWq3GcLn7I/KJoUjEkEa6YtDgOmeuxXIYkaP4egyswmXufOzaXMBW2nJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738980795; c=relaxed/simple;
	bh=mL+ITyuiGNpBMALJNIYhbcKCELzgAYzhvBpG7DiP2Dc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uQ84JwOTf3CQNGBY1acRygWaMA4FnRTI7yMwNYiN3TlV/9VI0QFblEfbmQX7OWRoHKd+lGn4Bfjk5dOf2jPN+RELVeR1sD0KzA5RdlZnS9HTB3ncp2mMp84WVUAtyL95iLHMm8ZkQRvuVpRFmL4jufurbdoNY7DgmImZbtcaI5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l4VlNQum; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-38dc6d55ebaso942352f8f.1;
        Fri, 07 Feb 2025 18:13:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738980792; x=1739585592; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vMVdUQt2Hs4AHI45+V3M/SEQtylrN719DsBo4dQUe3M=;
        b=l4VlNQumsLR9e4p4yf1E76zvponNRVtO4PQ7+SFhNsEx5yqJCKAi7Sw7T4Qg6HQFa5
         UbLjarBfWC74zPPRQQfe7/0a3tXMjAKtfRmCKMnukZI3ppszz0BGblZdBX3mSJL5m5Z4
         XmnhNe8vs0ccY0YgzYUeZ9B7G1GmIzZDll+Qjo+NxyYo483WGpY+aZMo55sqSHyADydY
         etm+SD16/IZDA2+73a3wG808yyHGfNemKRnDg/0c6YbDDGjI0SXYEVzdEmb47+esQr22
         5zGAFvzxvoUkqdFwAYkiIphbRMX5mJPz8GUvdip2HclhQWtmB0bCnr5yDQg9nS9roXGL
         q3Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738980792; x=1739585592;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vMVdUQt2Hs4AHI45+V3M/SEQtylrN719DsBo4dQUe3M=;
        b=JOOXS385Qlh/SpDb8YCPw2UY+pIERDCEGXPAG1gGmBxNf4T68OKBZirhWD6jtP5nBC
         EvbuJpN1w0pyM7mz1WQ9pOSklU2C1/twempvWFruSiCWpIcFLh3+q482amAERcmdrW8N
         DbY3/1R9WQFWNFzC9qn2rOk1UyR6JUTRpgUzyAJH+eUblklphbZjwI2KSKMbzDm/ULyt
         xzS1KK4rpjs+h7pWpMYQymx1OOFDSObsmHOASX5UlgeOi50WAqIiD2p0jVkbMb23g/Qo
         QhiZq2UGOhpEt3A0pqEYZ3LIEsHPkb7ioYfPlL2T3u3g347MyBj7ZyHw1LagondVMLH6
         meqg==
X-Forwarded-Encrypted: i=1; AJvYcCUjQ+UoHQzMBQOXhXhE3IrhdyuimNaCTVz/DFliUS/puVvEsnipfKre82SbKi131nbP0Mly7H5asHHGanJQPFIs@vger.kernel.org, AJvYcCXXKpdlGdSws7pVD+ICzRWU11VXlbe+zon22VPBctj9y6acj522i/Zn1LBJA9RGutuMCBm2LfMb8N+Gxy4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwS1NJhv7t34YsswfKfaB8wzd8aEOsb7+EeAxLvKloZGEgs0ulQ
	7ef+g2HXdCy8VQwY5KDdcp483R6J4gAdHkzkRPJoAW3rn2/EYwRDOH1d+QbSHFI38YgHUrPVSJh
	67w7qGA9csTDy0Nn+OB5pmZmyfs0=
X-Gm-Gg: ASbGnctE9zSqFhu9xfB4NSBvdKL/dRZ1xOe5dtWJmAs9NnNcWFd4HJpRVfCnpVoEFCO
	XsEjF/IyVRfIqcWgnY5Xn0A0jpXtX1dI2AmxgZfvVEww06FgcdcvhGMyxiZ3RsRUikJ3YDKa10p
	p+QIEvlPRXci3XZ9sLdai02MqkjSHx
X-Google-Smtp-Source: AGHT+IHtOumZO0TzFF3dJizADabd68SqxDCYx9llpJnC57zGgc8NmGky2a0+qNLm6R5waMYSXwKWIePdI/WpA2orgPQ=
X-Received: by 2002:adf:e60b:0:b0:38d:b52d:e11c with SMTP id
 ffacd0b85a97d-38dc994edbfmr2830396f8f.15.1738980791806; Fri, 07 Feb 2025
 18:13:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1738905497.git.yan@cloudflare.com> <177c4a3417d848aa9d72158e235be7d6b6f43915.1738905497.git.yan@cloudflare.com>
In-Reply-To: <177c4a3417d848aa9d72158e235be7d6b6f43915.1738905497.git.yan@cloudflare.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 7 Feb 2025 18:13:00 -0800
X-Gm-Features: AWEUYZk_MtqHQXzKI4BkK2PV1Eyra_1_lVM6nWl3q9LfEJr7dScDGdaAJwIlVR8
Message-ID: <CAADnVQJ=MPyoL3YrcCvCUG43R37bB7D6kuqysD-SJCQZE2yQrw@mail.gmail.com>
Subject: Re: [PATCH v2 bpf 1/2] bpf: skip non exist keys in generic_map_lookup_batch
To: Yan Zhai <yan@cloudflare.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>, Brian Vazquez <brianvv@google.com>, 
	LKML <linux-kernel@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, kernel-team <kernel-team@cloudflare.com>, 
	Hou Tao <houtao@huaweicloud.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 6, 2025 at 9:45=E2=80=AFPM Yan Zhai <yan@cloudflare.com> wrote:
>
> The generic_map_lookup_batch currently returns EINTR if it fails with
> ENOENT and retries several times on bpf_map_copy_value. The next batch
> would start from the same location, presuming it's a transient issue.
> This is incorrect if a map can actually have "holes", i.e.
> "get_next_key" can return a key that does not point to a valid value. At
> least the array of maps type may contain such holes legitly. Right now
> these holes show up, generic batch lookup cannot proceed any more. It
> will always fail with EINTR errors.
>
> Rather, do not retry in generic_map_lookup_batch. If it finds a non
> existing element, skip to the next key. This simple solution comes with
> a price that transient errors may not be recovered, and the iteration
> might cycle back to the first key under parallel deletion. For example,
> Hou Tao <houtao@huaweicloud.com> pointed out a following scenario:
>
> For LPM trie map:
> (1) ->map_get_next_key(map, prev_key, key) returns a valid key
>
> (2) bpf_map_copy_value() return -ENOMENT
> It means the key must be deleted concurrently.
>
> (3) goto next_key
> It swaps the prev_key and key
>
> (4) ->map_get_next_key(map, prev_key, key) again
> prev_key points to a non-existing key, for LPM trie it will treat just
> like prev_key=3DNULL case, the returned key will be duplicated.
>
> With the retry logic, the iteration can continue to the key next to the
> deleted one. But if we directly skip to the next key, the iteration loop
> would restart from the first key for the lpm_trie type.
>
> However, not all races may be recovered. For example, if current key is
> deleted after instead of before bpf_map_copy_value, or if the prev_key
> also gets deleted, then the loop will still restart from the first key
> for lpm_tire anyway. For generic lookup it might be better to stay
> simple, i.e. just skip to the next key. To guarantee that the output
> keys are not duplicated, it is better to implement map type specific
> batch operations, which can properly lock the trie and synchronize with
> concurrent mutators.
>
> Fixes: cb4d03ab499d ("bpf: Add generic support for lookup batch op")
> Closes: https://lore.kernel.org/bpf/Z6JXtA1M5jAZx8xD@debian.debian/
> Signed-off-by: Yan Zhai <yan@cloudflare.com>
> ---
> v1->v2: incorporate more useful information inside commit message.
> v1: https://lore.kernel.org/bpf/Z6OYbS4WqQnmzi2z@debian.debian/
> ---
>  kernel/bpf/syscall.c | 16 +++++-----------
>  1 file changed, 5 insertions(+), 11 deletions(-)
>
> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> index c420edbfb7c8..5d0a4db6fb85 100644
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c
> @@ -1979,8 +1979,8 @@ int generic_map_lookup_batch(struct bpf_map *map,
>         void __user *values =3D u64_to_user_ptr(attr->batch.values);
>         void __user *keys =3D u64_to_user_ptr(attr->batch.keys);
>         void *buf, *buf_prevkey, *prev_key, *key, *value;
> -       int err, retry =3D MAP_LOOKUP_RETRIES;
>         u32 value_size, cp, max_count;
> +       int err;
>
>         if (attr->batch.elem_flags & ~BPF_F_LOCK)
>                 return -EINVAL;
> @@ -2026,14 +2026,8 @@ int generic_map_lookup_batch(struct bpf_map *map,
>                 err =3D bpf_map_copy_value(map, key, value,
>                                          attr->batch.elem_flags);
>
> -               if (err =3D=3D -ENOENT) {
> -                       if (retry) {
> -                               retry--;
> -                               continue;
> -                       }
> -                       err =3D -EINTR;
> -                       break;
> -               }
> +               if (err =3D=3D -ENOENT)
> +                       goto next_key;
>
>                 if (err)
>                         goto free_buf;
> @@ -2048,12 +2042,12 @@ int generic_map_lookup_batch(struct bpf_map *map,
>                         goto free_buf;
>                 }
>
> +               cp++;
> +next_key:
>                 if (!prev_key)
>                         prev_key =3D buf_prevkey;
>
>                 swap(prev_key, key);
> -               retry =3D MAP_LOOKUP_RETRIES;
> -               cp++;

#define MAP_LOOKUP_RETRIES is unused after this patch.
Delete it as well.

Pls keep acks on respin.

pw-bot: cr

