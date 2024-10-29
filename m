Return-Path: <linux-kselftest+bounces-21020-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 434B79B5596
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Oct 2024 23:13:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B744283DDA
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Oct 2024 22:13:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9307520A5EF;
	Tue, 29 Oct 2024 22:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kr0TokBw"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C7354DA03;
	Tue, 29 Oct 2024 22:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730240010; cv=none; b=isGMYQhclL4olsaAaljhtDiOP78/H8SUjHX+YxkfyhGbslLXIPj6hjKUG4G5uAa+wzGmQ/NxWaxaeSU0rMQNjTpglGIwqSitXjm0Lan+IS5HM8wqjmu3zprm3ZtJx0G115a4od6bxnyyts58uf+7MoCp1c755xXA66sM/ucSMVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730240010; c=relaxed/simple;
	bh=K42UbQHLjrIJcNe1jDI0e9lmLmiFejvW2JWm6RQHd+8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ryinnIsoe3UCoVLtM2/QcuKn0KidDTFKZaCU7NhiejD6OxNS3hSjDkrQIZdD74BE3SGcNU9YXR0dJWZCYhNzFnZMpkjlse4m89pcmZLJRhh5kL0SBT6UQAONjU+0c9Ib8e+Mqu6Tje8JVXjVaoqvd+WYU6d7xxEPwfmYWzdwG2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Kr0TokBw; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-7db238d07b3so4390046a12.2;
        Tue, 29 Oct 2024 15:13:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730240007; x=1730844807; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VQlVpBfjLtztrnPP80+7uMXP6laBp4yN+GsyJE2u/pw=;
        b=Kr0TokBwkGz1NiWq68q/rQUlg9de85q1GWvz8suaH3goXxvBjyI1lxpuHmIf/AUxNC
         zVF4MyoyM8teGECIz3c/VUhaNsGqijkRH7G5nGvxIcv4S7Jm48/BUZbnvhYHuD+FsSPS
         nZFGvYeBhxRiiB8WH+yb7tkbs8feO29dozLWoP+y3CJ/4bJkqZdsJLW8j73bjoamYkZq
         vAHY+2JGuJuK4b9eJb4iySspbneUvsDDNRCwg1IjorPw7ZDHwESrGY0Q3BUFn6G3YJd2
         HG6pNkaJvoCQI/0CEsAFbsc5WtaQ0kbHSgWNC/L6H4l6rrjA3iFITVUGgCij0sfyMXGk
         eztQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730240007; x=1730844807;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VQlVpBfjLtztrnPP80+7uMXP6laBp4yN+GsyJE2u/pw=;
        b=CEOuVHExYKsmJDtFqKwOt6tQ0kia2Y4qE2VlTtzga45TJ1jn1CeAs19XNga9MAJTcF
         WL0s7wQs7VCLumCkpt2oqXipUoyIEmzHA/smGxFyHKAvBokkZobBNH9t4jKVsiNRn0eT
         L7UebcOGKbRntCnj4jmO5B4Qd7W2u0MeNnZgepE5DRpeT5rxVkn1LoOgIwxZGXShubP4
         6rkiBR6j/0l9KloTzBpx6JQSbtFh3PjpodQxe9Ry5ZvYgiSB2lCg6uz+Ljl+M0LnfoXK
         zFN9QyNdwiHBIZ36jESQqxdzJfPFpJLkVgm670Z6xcPWi0268k4P179aCeOG0omfSkaR
         4hzg==
X-Forwarded-Encrypted: i=1; AJvYcCUUz0iFPy7ZFAmbgg75yq1EmX3wv9u4ls2/rEDjFC/6nuLndhV4Qc/tgiaLJQVYw4v/PlO2Pxiu4RhOAsji@vger.kernel.org, AJvYcCX/DMwMf0SvDC9bCd2IS+PVzUNrqUOSLNOo/GEuk6Mb3Un3gAx+uF1DRk7FD2Sihup9vKI=@vger.kernel.org, AJvYcCX0314u89kdDOX0y6RkJ/55YvoeecQupzBrmV2/93i+imf4u6BPE8MEJ82wE4HcMzjHetaIuWGOj8IEghlByaDbyCqv@vger.kernel.org, AJvYcCXG4//8ZI3EOh3h0fos60OFMV8x2ADxSKCwtbS23nmsOg9ppSIYbbuYdkLeaJYbNAEaDdQPiomm+K9aDrWz0uIu@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5zonFy26ZgCqkobovyvvZGtu0qMmZ2r60ydi44VzLiBDC5XUj
	CX/2iqKejDhl8dRAamH3/hSnyv1nak3GYIoYFG7Txpwn7XBqKs26JZ4Xpjz0KFDJ8kFDu2hkEsm
	pYtVPivrB1SAgCdAxjOqxMTu05ff/hWPF
X-Google-Smtp-Source: AGHT+IEYkbhHnJvDDPQvU2tpFsWAjTJlixXEpvN/E2vmpH7vh1UzrwZ9yLtwBTpyoeDfkkZmyKp7sMNXPp2S/jM8rRM=
X-Received: by 2002:a05:6a20:9f95:b0:1d7:ca7:bfce with SMTP id
 adf61e73a8af0-1d9a850a3c9mr2918984637.42.1730240007327; Tue, 29 Oct 2024
 15:13:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241029002208.1947947-1-dolinux.peng@gmail.com> <20241029002208.1947947-3-dolinux.peng@gmail.com>
In-Reply-To: <20241029002208.1947947-3-dolinux.peng@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 29 Oct 2024 15:13:14 -0700
Message-ID: <CAEf4BzYBffp+47SLaV5sMWVAVSbxyDX3DnNoOju1y9wr+wupeQ@mail.gmail.com>
Subject: Re: [PATCH v4 2/3] bpf: Using binary search to improve the
 performance of btf_find_by_name_kind
To: Donglin Peng <dolinux.peng@gmail.com>
Cc: andrii@kernel.org, eddyz87@gmail.com, ast@kernel.org, rostedt@goodmis.org, 
	mhiramat@kernel.org, bpf@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 28, 2024 at 5:22=E2=80=AFPM Donglin Peng <dolinux.peng@gmail.co=
m> wrote:
>
> Currently, we are only using the linear search method to find the type id
> by the name, which has a time complexity of O(n). This change involves
> sorting the names of btf types in ascending order and using binary search=
,
> which has a time complexity of O(log(n)). This idea was inspired by the
> following patch:
>
> 60443c88f3a8 ("kallsyms: Improve the performance of kallsyms_lookup_name(=
)").
>
> At present, this improvement is only for searching in vmlinux's and
> module's BTFs.
>
> Another change is the search direction, where we search the BTF first and
> then its base, the type id of the first matched btf_type will be returned=
.
>
> Here is a time-consuming result that finding 87590 type ids by their name=
s in
> vmlinux's BTF.
>
> Before: 158426 ms
> After:     114 ms
>
> The average lookup performance has improved more than 1000x in the above =
scenario.
>
> Tested-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> Signed-off-by: Donglin Peng <dolinux.peng@gmail.com>
> ---
> v4:
>  - move the modification of libbpf to another patch
>
> v3:
>  - Link: https://lore.kernel.org/all/20240608140835.965949-1-dolinux.peng=
@gmail.com/
>  - Sort btf_types during build process other than during boot, to reduce =
the
>    overhead of memory and boot time.
>
> v2:
>  - Link: https://lore.kernel.org/all/20230909091646.420163-1-pengdonglin@=
sangfor.com.cn
> ---
>  include/linux/btf.h |   1 +
>  kernel/bpf/btf.c    | 157 ++++++++++++++++++++++++++++++++++++++++----
>  2 files changed, 147 insertions(+), 11 deletions(-)
>
> diff --git a/include/linux/btf.h b/include/linux/btf.h
> index b8a583194c4a..64c35aaa22fa 100644
> --- a/include/linux/btf.h
> +++ b/include/linux/btf.h
> @@ -216,6 +216,7 @@ bool btf_is_module(const struct btf *btf);
>  bool btf_is_vmlinux(const struct btf *btf);
>  struct module *btf_try_get_module(const struct btf *btf);
>  u32 btf_nr_types(const struct btf *btf);
> +u32 btf_type_cnt(const struct btf *btf);
>  struct btf *btf_base_btf(const struct btf *btf);
>  bool btf_member_is_reg_int(const struct btf *btf, const struct btf_type =
*s,
>                            const struct btf_member *m,
> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> index 5cd1c7a23848..6d0d58989640 100644
> --- a/kernel/bpf/btf.c
> +++ b/kernel/bpf/btf.c
> @@ -262,6 +262,7 @@ struct btf {
>         u32 data_size;
>         refcount_t refcnt;
>         u32 id;
> +       u32 nr_types_sorted;
>         struct rcu_head rcu;
>         struct btf_kfunc_set_tab *kfunc_set_tab;
>         struct btf_id_dtor_kfunc_tab *dtor_kfunc_tab;
> @@ -548,23 +549,102 @@ u32 btf_nr_types(const struct btf *btf)
>         return total;
>  }
>
> -s32 btf_find_by_name_kind(const struct btf *btf, const char *name, u8 ki=
nd)
> +u32 btf_type_cnt(const struct btf *btf)
> +{
> +       return btf->start_id + btf->nr_types;
> +}
> +
> +static s32 btf_find_by_name_bsearch(const struct btf *btf, const char *n=
ame,
> +                                   int *start, int *end)
>  {
>         const struct btf_type *t;
> -       const char *tname;
> -       u32 i, total;
> +       const char *name_buf;
> +       int low, low_start, mid, high, high_end;
> +       int ret, start_id;
> +
> +       start_id =3D btf->base_btf ? btf->start_id : 1;
> +       low_start =3D low =3D start_id;
> +       high_end =3D high =3D start_id + btf->nr_types_sorted - 1;
> +
> +       while (low <=3D high) {
> +               mid =3D low + (high - low) / 2;
> +               t =3D btf_type_by_id(btf, mid);
> +               name_buf =3D btf_name_by_offset(btf, t->name_off);
> +               ret =3D strcmp(name, name_buf);
> +               if (ret > 0)
> +                       low =3D mid + 1;
> +               else if (ret < 0)
> +                       high =3D mid - 1;
> +               else
> +                       break;
> +       }
>
> -       total =3D btf_nr_types(btf);
> -       for (i =3D 1; i < total; i++) {
> -               t =3D btf_type_by_id(btf, i);
> -               if (BTF_INFO_KIND(t->info) !=3D kind)
> -                       continue;
> +       if (low > high)
> +               return -ESRCH;
>
> -               tname =3D btf_name_by_offset(btf, t->name_off);
> -               if (!strcmp(tname, name))
> -                       return i;
> +       if (start) {
> +               low =3D mid;
> +               while (low > low_start) {
> +                       t =3D btf_type_by_id(btf, low-1);
> +                       name_buf =3D btf_name_by_offset(btf, t->name_off)=
;
> +                       if (strcmp(name, name_buf))
> +                               break;
> +                       low--;
> +               }
> +               *start =3D low;
> +       }
> +
> +       if (end) {
> +               high =3D mid;
> +               while (high < high_end) {
> +                       t =3D btf_type_by_id(btf, high+1);
> +                       name_buf =3D btf_name_by_offset(btf, t->name_off)=
;
> +                       if (strcmp(name, name_buf))
> +                               break;
> +                       high++;
> +               }
> +               *end =3D high;
>         }
>

this is an overcomplicated implementation, you need something like
find_linfo() implementation in kernel/bpf/log.c. Note how much shorter
and leaner it is.

I also don't think you need to return `end`. Given you always start
from start and linearly scan forward, you just need to make sure that
you never go beyond the BTF type array, for which you can use
btf_type_cnt(). So no need for doing this linear scan twice.

> +       return mid;
> +}
> +
> +s32 btf_find_by_name_kind(const struct btf *btf, const char *name, u8 ki=
nd)
> +{
> +       const struct btf_type *t;
> +       const char *tname;
> +       int start, end;
> +       s32 id, total;
> +
> +       do {
> +               if (btf->nr_types_sorted) {
> +                       /* binary search */
> +                       id =3D btf_find_by_name_bsearch(btf, name, &start=
, &end);
> +                       if (id > 0) {
> +                               while (start <=3D end) {
> +                                       t =3D btf_type_by_id(btf, start);
> +                                       if (BTF_INFO_KIND(t->info) =3D=3D=
 kind)
> +                                               return start;
> +                                       start++;
> +                               }
> +                       }
> +               } else {
> +                       /* linear search */
> +                       total =3D btf_type_cnt(btf);
> +                       for (id =3D btf->base_btf ? btf->start_id : 1;
> +                               id < total; id++) {
> +                               t =3D btf_type_by_id(btf, id);
> +                               if (BTF_INFO_KIND(t->info) !=3D kind)
> +                                       continue;
> +
> +                               tname =3D btf_name_by_offset(btf, t->name=
_off);
> +                               if (!strcmp(tname, name))
> +                                       return id;
> +                       }
> +               }
> +               btf =3D btf->base_btf;
> +       } while (btf);
> +
>         return -ENOENT;
>  }
>
> @@ -6141,6 +6221,53 @@ int get_kern_ctx_btf_id(struct bpf_verifier_log *l=
og, enum bpf_prog_type prog_ty
>         return kctx_type_id;
>  }
>
> +static int btf_check_sort(struct btf *btf, int start_id)
> +{
> +       int i, n, nr_names =3D 0;
> +
> +       n =3D btf_nr_types(btf);
> +       for (i =3D start_id; i < n; i++) {
> +               const struct btf_type *t;
> +               const char *name;
> +
> +               t =3D btf_type_by_id(btf, i);
> +               if (!t)
> +                       return -EINVAL;
> +
> +               name =3D btf_str_by_offset(btf, t->name_off);
> +               if (!str_is_empty(name))
> +                       nr_names++;
> +       }
> +

this loop makes zero sense to me, what are you trying to achieve with
it and why?

> +       for (i =3D 0; i < nr_names - 1; i++) {

just start from start_id + 1, all the way to n, and check that sorting
invariant holds for all items

> +               const struct btf_type *t1, *t2;
> +               const char *s1, *s2;
> +
> +               t1 =3D btf_type_by_id(btf, start_id + i);
> +               if (!t1)
> +                       return -EINVAL;
> +
> +               s1 =3D btf_str_by_offset(btf, t1->name_off);
> +               if (str_is_empty(s1))
> +                       goto out;
> +
> +               t2 =3D btf_type_by_id(btf, start_id + i + 1);
> +               if (!t2)
> +                       return -EINVAL;
> +
> +               s2 =3D btf_str_by_offset(btf, t2->name_off);
> +               if (str_is_empty(s2))
> +                       goto out;
> +
> +               if (strcmp(s1, s2) > 0)
> +                       goto out;
> +       }
> +
> +       btf->nr_types_sorted =3D nr_names;
> +out:
> +       return 0;
> +}

[...]

