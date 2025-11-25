Return-Path: <linux-kselftest+bounces-46467-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DFF0C876F0
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Nov 2025 00:11:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F359B3B2D51
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Nov 2025 23:11:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DE212E8E06;
	Tue, 25 Nov 2025 23:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e71oji12"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24B171096F
	for <linux-kselftest@vger.kernel.org>; Tue, 25 Nov 2025 23:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764112288; cv=none; b=KDElq7HlrghyYzndMrbNugXlpb/afTJY+Y/kmvCcTC4dEeRCXnhdp2o0N+2/py4H96FLL5rUv3gtkk/6/WiZEpnPUOFe6idNs+uU5AQkabsDIsTu73sotRcuwiTJpcPPvKTCaeHCayEvifcFF83SqoPY54dtVQhYmJEsZNkz4/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764112288; c=relaxed/simple;
	bh=+qWmpCXtpd25LQDibm5GBF/511UW0DEw7aLw/WRHU7E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dYJd6WIFUtp/uFb7zlS92eWN4SHGZdjhklTEnGCfDjicrrO1QCXqHVvGmtdR433Me9ZcOVwk1VFitbBmUvPnzxSQt7O5rgBm1J2nUCqDDA1S0earkAtikEcXpBbkiVv0eKp23IM+7zCVfJXiBu7Mn6QJH7yLaUN4xT1wPL8jVv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e71oji12; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-42b47f662a0so157153f8f.0
        for <linux-kselftest@vger.kernel.org>; Tue, 25 Nov 2025 15:11:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764112284; x=1764717084; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9Kt7g7XcZcHGdJTJa9wjSXUe0CZFCbHTC6bAQbWNsbA=;
        b=e71oji12BL9vXQwyrsZeaNMnkKHdPpmHlid5q5LYbRNQIvdMoj+eWtC+m34rAX6cvQ
         oODWFNqK4VXlp1ToWBPULRkSS1oRUFQFAr94RywYnfZhElcJIh2Q1TtOAqe8Chv3vBZR
         vuyGt4rDfmjPUML9cl0dl7yftnL2NtwkoAaITFyCkjj4mvEhG2S8BvFJo7vI2uv9TIgx
         l8/Xzq9ZqMQTIs5DvrtdzJ+RFS4QcZRIJK5SqEVL/Yq4USlvYdb8cp5UdFJ6+Ay16yko
         EV49MFwpbwd80Jqcj8sFyXXZYbVWyARgB9c3cdl4GF9eRXoMZWwOmrIevbI7hy/Md2yx
         GbMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764112284; x=1764717084;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9Kt7g7XcZcHGdJTJa9wjSXUe0CZFCbHTC6bAQbWNsbA=;
        b=XJVMZ+2LEEatiun/jGaCOyPguulNN5tSwqLtQbp9YEe47ztYUNIHiEGOMmEoxHqsrA
         2OfT2+xrASYlYBgPmh5hdFRxgHtmTi/ATbfd2oA+E6gaf4UuOFcZz5c/34eLowL5H5/P
         Un/CnN2VHKyt+eHidDSyTnCJ7b+UozLKXFOqHz0ReSUX9gb+Zgn4kSakuCGdK0PqYQK+
         /sKy4yACIMby+QCzdOakxB3RbsoVU5Iv1jOuj96PuqfYaSdllk4ma6XW5RJN9WzsRjrk
         aoqjiC6FkgLEKCi4xnI+TxfXrc5OVYc894fypo/CkqV4M2s7B3AeI6/TeG8wVmUnwQJi
         Pk1A==
X-Forwarded-Encrypted: i=1; AJvYcCVQEk2BO/gVws6Wh5CN+xezfUuD+ON1kY1ffBeBBq7bLT8X34uW3mA8wBRrMk4xtqwU2XJHUAlly6wGWo2pZqY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyH5cIP2lwgndbNwooR5rIdlx71gTwt206PuOi8J0fZDlYRGAd4
	/LWAsZN1oEx+l6g6PHtbu0KRM8Y7iU9KxYmSDyY7FFHIeg5S6qLIuDsN+wOgtl/MywVmeWz7QpF
	eY4SnE9L+spQMxhjcMTzTzX7MIhKCrRQ=
X-Gm-Gg: ASbGncu0SUTMs3rC6TgluY+80STfWi/zrY2YO/S9BBYr/vwAmG+WIv3DDn8CbaVPGjc
	hmeehZi0waOtcek1gmHRBe43pc82U0G6jQGrdqQix/DZ0LM2UOnTQPpK4Rz+bN3OAE9ppyxSfeB
	vSLXH5RlaVNVUhYUdT2/8cA4dIBSgMB1FWA/XjoYVxHUQnFy23Iibx3W0jflNNZEe8IG8tb3znM
	A22QuHKM6ImCwHKQVf+EHUxN8KaHeAYLIceOb9AOB6n0IYgrWdrR2kNvHOcN1u9vdb7ynlurPnQ
	vvFSb9reo5ooHqdrVUkXd1WFszhj
X-Google-Smtp-Source: AGHT+IGUCbKCIKgKWM3EoeFu8vxWgYAcAtEOVQP39BHb++ZkzeaIJ0AfUUoTP71swdvNQ5ROzoAepdj6zZ8O+00yDK4=
X-Received: by 2002:a05:6000:2011:b0:429:cff0:1929 with SMTP id
 ffacd0b85a97d-42cc13943f3mr20070087f8f.29.1764112284315; Tue, 25 Nov 2025
 15:11:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251125145857.98134-1-leon.hwang@linux.dev> <20251125145857.98134-5-leon.hwang@linux.dev>
In-Reply-To: <20251125145857.98134-5-leon.hwang@linux.dev>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 25 Nov 2025 15:11:13 -0800
X-Gm-Features: AWmQ_bke60L0B3RR8fICdmj8KCCupFXinZdGEnpXRqwH_kf0k6RLaE3IJ4-iVuk
Message-ID: <CAADnVQJMM+PSq_nDL4rXbC42D+yX5iRo-G_y8qma5+OepcAESw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v11 4/8] bpf: Add BPF_F_CPU and BPF_F_ALL_CPUS
 flags support for percpu_hash and lru_percpu_hash maps
To: Leon Hwang <leon.hwang@linux.dev>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Jiri Olsa <jolsa@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Song Liu <song@kernel.org>, Eduard <eddyz87@gmail.com>, 
	Daniel Xu <dxu@dxuuu.xyz>, =?UTF-8?Q?Daniel_M=C3=BCller?= <deso@posteo.net>, 
	Martin KaFai Lau <martin.lau@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Shuah Khan <shuah@kernel.org>, Jason Xing <kerneljasonxing@gmail.com>, 
	Tao Chen <chen.dylane@linux.dev>, Willem de Bruijn <willemb@google.com>, 
	Paul Chaignon <paul.chaignon@gmail.com>, Anton Protopopov <a.s.protopopov@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Mykyta Yatsenko <yatsenko@meta.com>, 
	Tobias Klauser <tklauser@distanz.ch>, kernel-patches-bot@fb.com, 
	LKML <linux-kernel@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 25, 2025 at 7:00=E2=80=AFAM Leon Hwang <leon.hwang@linux.dev> w=
rote:
>
> Introduce BPF_F_ALL_CPUS flag support for percpu_hash and lru_percpu_hash
> maps to allow updating values for all CPUs with a single value for both
> update_elem and update_batch APIs.
>
> Introduce BPF_F_CPU flag support for percpu_hash and lru_percpu_hash
> maps to allow:
>
> * update value for specified CPU for both update_elem and update_batch
> APIs.
> * lookup value for specified CPU for both lookup_elem and lookup_batch
> APIs.
>
> The BPF_F_CPU flag is passed via:
>
> * map_flags along with embedded cpu info.
> * elem_flags along with embedded cpu info.
>
> Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
> ---
> v10 -> v11:
>  - Drop buggy '(u32)map_flags > BPF_F_ALL_CPUS' check in htab_map_check_u=
pdate_flags().

why?

>  - Update 'map_flags !=3D BPF_EXIST' to '!(map_flags & BPF_EXIST)' in
>    __htab_lru_percpu_map_update_elem().
> ---
>  include/linux/bpf.h  |  4 +-
>  kernel/bpf/hashtab.c | 96 ++++++++++++++++++++++++++++++--------------
>  kernel/bpf/syscall.c |  2 +-
>  3 files changed, 69 insertions(+), 33 deletions(-)
>
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index 01a99e3a3e51..f79d2ae27335 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -2761,7 +2761,7 @@ int map_set_for_each_callback_args(struct bpf_verif=
ier_env *env,
>                                    struct bpf_func_state *caller,
>                                    struct bpf_func_state *callee);
>
> -int bpf_percpu_hash_copy(struct bpf_map *map, void *key, void *value);
> +int bpf_percpu_hash_copy(struct bpf_map *map, void *key, void *value, u6=
4 flags);
>  int bpf_percpu_array_copy(struct bpf_map *map, void *key, void *value, u=
64 flags);
>  int bpf_percpu_hash_update(struct bpf_map *map, void *key, void *value,
>                            u64 flags);
> @@ -3833,6 +3833,8 @@ static inline bool bpf_map_supports_cpu_flags(enum =
bpf_map_type map_type)
>  {
>         switch (map_type) {
>         case BPF_MAP_TYPE_PERCPU_ARRAY:
> +       case BPF_MAP_TYPE_PERCPU_HASH:
> +       case BPF_MAP_TYPE_LRU_PERCPU_HASH:
>                 return true;
>         default:
>                 return false;
> diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
> index c8a9b27f8663..c768bf71d60f 100644
> --- a/kernel/bpf/hashtab.c
> +++ b/kernel/bpf/hashtab.c
> @@ -932,7 +932,7 @@ static void free_htab_elem(struct bpf_htab *htab, str=
uct htab_elem *l)
>  }
>
>  static void pcpu_copy_value(struct bpf_htab *htab, void __percpu *pptr,
> -                           void *value, bool onallcpus)
> +                           void *value, bool onallcpus, u64 map_flags)
>  {
>         void *ptr;
>
> @@ -943,19 +943,28 @@ static void pcpu_copy_value(struct bpf_htab *htab, =
void __percpu *pptr,
>                 bpf_obj_free_fields(htab->map.record, ptr);
>         } else {
>                 u32 size =3D round_up(htab->map.value_size, 8);
> -               int off =3D 0, cpu;
> +               void *val;
> +               int cpu;
> +
> +               if (map_flags & BPF_F_CPU) {
> +                       cpu =3D map_flags >> 32;
> +                       ptr =3D per_cpu_ptr(pptr, cpu);
> +                       copy_map_value(&htab->map, ptr, value);
> +                       bpf_obj_free_fields(htab->map.record, ptr);
> +                       return;
> +               }
>
>                 for_each_possible_cpu(cpu) {
>                         ptr =3D per_cpu_ptr(pptr, cpu);
> -                       copy_map_value_long(&htab->map, ptr, value + off)=
;
> +                       val =3D (map_flags & BPF_F_ALL_CPUS) ? value : va=
lue + size * cpu;
> +                       copy_map_value(&htab->map, ptr, val);
>                         bpf_obj_free_fields(htab->map.record, ptr);
> -                       off +=3D size;
>                 }
>         }
>  }
>
>  static void pcpu_init_value(struct bpf_htab *htab, void __percpu *pptr,
> -                           void *value, bool onallcpus)
> +                           void *value, bool onallcpus, u64 map_flags)
>  {
>         /* When not setting the initial value on all cpus, zero-fill elem=
ent
>          * values for other cpus. Otherwise, bpf program has no way to en=
sure
> @@ -973,7 +982,7 @@ static void pcpu_init_value(struct bpf_htab *htab, vo=
id __percpu *pptr,
>                                 zero_map_value(&htab->map, per_cpu_ptr(pp=
tr, cpu));
>                 }
>         } else {
> -               pcpu_copy_value(htab, pptr, value, onallcpus);
> +               pcpu_copy_value(htab, pptr, value, onallcpus, map_flags);
>         }
>  }
>
> @@ -985,7 +994,7 @@ static bool fd_htab_map_needs_adjust(const struct bpf=
_htab *htab)
>  static struct htab_elem *alloc_htab_elem(struct bpf_htab *htab, void *ke=
y,
>                                          void *value, u32 key_size, u32 h=
ash,
>                                          bool percpu, bool onallcpus,
> -                                        struct htab_elem *old_elem)
> +                                        struct htab_elem *old_elem, u64 =
map_flags)
>  {
>         u32 size =3D htab->map.value_size;
>         bool prealloc =3D htab_is_prealloc(htab);
> @@ -1043,7 +1052,7 @@ static struct htab_elem *alloc_htab_elem(struct bpf=
_htab *htab, void *key,
>                         pptr =3D *(void __percpu **)ptr;
>                 }
>
> -               pcpu_init_value(htab, pptr, value, onallcpus);
> +               pcpu_init_value(htab, pptr, value, onallcpus, map_flags);
>
>                 if (!prealloc)
>                         htab_elem_set_ptr(l_new, key_size, pptr);
> @@ -1147,7 +1156,7 @@ static long htab_map_update_elem(struct bpf_map *ma=
p, void *key, void *value,
>         }
>
>         l_new =3D alloc_htab_elem(htab, key, value, key_size, hash, false=
, false,
> -                               l_old);
> +                               l_old, map_flags);
>         if (IS_ERR(l_new)) {
>                 /* all pre-allocated elements are in use or memory exhaus=
ted */
>                 ret =3D PTR_ERR(l_new);
> @@ -1249,6 +1258,15 @@ static long htab_lru_map_update_elem(struct bpf_ma=
p *map, void *key, void *value
>         return ret;
>  }
>
> +static int htab_map_check_update_flags(bool onallcpus, u64 map_flags)
> +{
> +       if (unlikely(!onallcpus && map_flags > BPF_EXIST))
> +               return -EINVAL;
> +       if (unlikely(onallcpus && (map_flags & BPF_F_LOCK)))
> +               return -EINVAL;
> +       return 0;
> +}
> +
>  static long htab_map_update_elem_in_place(struct bpf_map *map, void *key=
,
>                                           void *value, u64 map_flags,
>                                           bool percpu, bool onallcpus)
> @@ -1262,9 +1280,9 @@ static long htab_map_update_elem_in_place(struct bp=
f_map *map, void *key,
>         u32 key_size, hash;
>         int ret;
>
> -       if (unlikely(map_flags > BPF_EXIST))
> -               /* unknown flags */
> -               return -EINVAL;
> +       ret =3D htab_map_check_update_flags(onallcpus, map_flags);
> +       if (unlikely(ret))
> +               return ret;
>
>         WARN_ON_ONCE(!bpf_rcu_lock_held());
>
> @@ -1289,7 +1307,7 @@ static long htab_map_update_elem_in_place(struct bp=
f_map *map, void *key,
>                 /* Update value in-place */
>                 if (percpu) {
>                         pcpu_copy_value(htab, htab_elem_get_ptr(l_old, ke=
y_size),
> -                                       value, onallcpus);
> +                                       value, onallcpus, map_flags);
>                 } else {
>                         void **inner_map_pptr =3D htab_elem_value(l_old, =
key_size);
>
> @@ -1298,7 +1316,7 @@ static long htab_map_update_elem_in_place(struct bp=
f_map *map, void *key,
>                 }
>         } else {
>                 l_new =3D alloc_htab_elem(htab, key, value, key_size,
> -                                       hash, percpu, onallcpus, NULL);
> +                                       hash, percpu, onallcpus, NULL, ma=
p_flags);
>                 if (IS_ERR(l_new)) {
>                         ret =3D PTR_ERR(l_new);
>                         goto err;
> @@ -1324,9 +1342,9 @@ static long __htab_lru_percpu_map_update_elem(struc=
t bpf_map *map, void *key,
>         u32 key_size, hash;
>         int ret;
>
> -       if (unlikely(map_flags > BPF_EXIST))
> -               /* unknown flags */
> -               return -EINVAL;
> +       ret =3D htab_map_check_update_flags(onallcpus, map_flags);
> +       if (unlikely(ret))
> +               return ret;
>
>         WARN_ON_ONCE(!bpf_rcu_lock_held());
>
> @@ -1342,7 +1360,7 @@ static long __htab_lru_percpu_map_update_elem(struc=
t bpf_map *map, void *key,
>          * to remove older elem from htab and this removal
>          * operation will need a bucket lock.
>          */
> -       if (map_flags !=3D BPF_EXIST) {
> +       if (!(map_flags & BPF_EXIST)) {
>                 l_new =3D prealloc_lru_pop(htab, key, hash);
>                 if (!l_new)
>                         return -ENOMEM;

It's not in the diff, but this is broken.
You tried to allow BPF_EXIST combination here, but didn't update
check_flags(),

so BPF_[NO]EXIST | BPF_F_CPU combination check_flags() will always
return 0, so BPF_[NO]EXIST flag will make no difference.

When you add features, always always add unit tests.
Patch 8 is not it. It's testing F_CPU. It doesn't check
that BPF_EXIST | BPF_F_CPU correctly errors when an element doesn't exist.

v10 was close, but then you decided to add this BPF_EXIST feature
and did it in a sloppy way. Why ?
Focus on one thing only. Land it and then do the next one.
11 revisions and still no go... it is not a good sign.

pw-bot: cr

