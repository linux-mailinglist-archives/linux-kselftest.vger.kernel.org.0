Return-Path: <linux-kselftest+bounces-21152-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FC779B6B10
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Oct 2024 18:34:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9E2FDB21286
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Oct 2024 17:34:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CCB32144CE;
	Wed, 30 Oct 2024 17:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RvNDeelp"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 976692141B7;
	Wed, 30 Oct 2024 17:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730309616; cv=none; b=U+fPnLLeVayBf7Z3eYY0o//CTAjUVh14bkYJ1nf0MdwOPYs8pJE5V5Cd3hTwCK0YhS9gD5iCFMtnfGfVR2I1P10ghTA08XLiBXEgmFU3gOL1LC3THQSbFV2UFHnSiCqtHhKU+6Bd0XrFySb8LNLvgImW1ftCWpz7gnJCM9O5aT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730309616; c=relaxed/simple;
	bh=qbyrUlW1m4rkTdORz/K7r0dgMHqLO+J2ibYxADdDIfU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h1doDmX9yEBgP9XUxsRw75MVPyTauRVFUfWJbca0MkrFuhWPfo4zTq0DOD75NM/mWZeikh8eN9eeMWZTJsxLuDORMqM8jRtZdupWyyf1LyLsYfOiag90tWwykj62cHKkXJbwml09se0zOzpT52Mp/ud25GHF7JvWRsqB5BHFgc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RvNDeelp; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2e2e8c8915eso23387a91.3;
        Wed, 30 Oct 2024 10:33:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730309613; x=1730914413; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AbNs7JYn6s9LHFMw4kr4HA25mGY7CFs6MMGw+CbfZXU=;
        b=RvNDeelpEdUtdcd9Z5AB+LC04keVWd8xk4cHxF3m5fmh+pa1umMFt57InbqIvAWm/A
         tEQhYpE9YJE39mcRh1W/1vCJPNtU925/b+dZMZlzRb3B6NehiCI8ONJud4+b/rJYS/O/
         cpeceZkrulTeWpDXd0JPQmYEgDGuocnjkVwGWLi0g+s4JgScSSqj7/cF1QRTsZI8/lUi
         FCrdk6PMTfncSzSFnLcrAFrZshl1O+ZWYxTSkzMTwjVm0qQVcTq6rZAhR77lFh4dyV9a
         YHn1rOjgLdsxz49JYROxT1X1BE4+WHfsFr9sRmWG5RgVybqBazIcGyYrK8K3aASTP30V
         TEfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730309613; x=1730914413;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AbNs7JYn6s9LHFMw4kr4HA25mGY7CFs6MMGw+CbfZXU=;
        b=scSpWtqxJgnOZHqncfYUpnx11ug3ESImFDie5Mu1R7+5hBxaXPKxOI5S9izTNuL1Fc
         GrlUvuIvIaWvLNOxQXYaJdxnDwoeotR1GdG/R7pJ2dX1ojlnbYWjzGEmgdicvyH6oyfh
         o66qJonBjuW45GvBoiGFnlXBcsRDfcXXJr6JZ9l7QcXHKyuKTUdc1W1WZ0hPZMes4ck/
         aZwK84e7EsomU+D/OPP/68gD8IWCgzr4ySAOuRimFmrovoAGdVKkNSsU4PFrL5cEHBb2
         5YNKv3qHKH/lxm1obE9Q0YCpj66V831A25nGgrv5RETIyMl1JFcwSvUPn6hxMrOHmsdx
         KA9Q==
X-Forwarded-Encrypted: i=1; AJvYcCV/CyopVV5My/q54Ay+VG+k/NDfd8gA993wfQX9elDd5RkJ5PhHpjqlk5qEBjG44v/XkZU=@vger.kernel.org, AJvYcCVHNKA447KipzoCR9TlXPkUWy2bRYRHcfPgEYLSJ2N2erPtGZXALLNl7Bata0I3iMzhuiYsLcnXABxKnzdHNvp2@vger.kernel.org, AJvYcCVRcXKF1zXnaoD+zkIZCmZvyydAyt3/7SY6AgJ0iU49qjDkyuTIk4zRO1SU0EV8NmVhY7aRCC1s1nE8X94sgKGYXJ9z@vger.kernel.org, AJvYcCWsYWaRxs3Hs3RcSl0UPj9/z++bisFQdOwjqfo/NspkXsZaJlg0hkEVlYavO+D3MPU5yQRCMFjErBh9WnBM@vger.kernel.org
X-Gm-Message-State: AOJu0YxTw/2eXT28Lfys/H0KATNfa9Hcna3U1eGwNGU0xi7FyEJso4Ng
	YBAQJqEI9AURdXrxZn/ZYwLmHNntyI8gUTUmtvwaI+QwyB1pDQ5a87QVBExRiDsIxcI/RgMqm7O
	dtGzQuQ3QkE3y9Oo6Cao9XCgvVY0=
X-Google-Smtp-Source: AGHT+IHCHgqWXc3DNO/ejNjeaW2seryBvOjK/WNKmPhaqloxdQNRa0XZ16IbEV+3dIrC2V7+fO95xfft4Ie5BJVakLc=
X-Received: by 2002:a17:90b:50e:b0:2e2:e6bf:cd64 with SMTP id
 98e67ed59e1d1-2e8f104a4d1mr17516247a91.5.1730309612615; Wed, 30 Oct 2024
 10:33:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241029002208.1947947-1-dolinux.peng@gmail.com>
 <20241029002208.1947947-3-dolinux.peng@gmail.com> <CAEf4BzYBffp+47SLaV5sMWVAVSbxyDX3DnNoOju1y9wr+wupeQ@mail.gmail.com>
 <CAErzpmsyV46Pexj3CUCSaX+MzckoKSAe9D3eeEcTGK8m5BKJUg@mail.gmail.com>
In-Reply-To: <CAErzpmsyV46Pexj3CUCSaX+MzckoKSAe9D3eeEcTGK8m5BKJUg@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 30 Oct 2024 10:33:20 -0700
Message-ID: <CAEf4BzY=vfFBPFUNPy3LfrCTM0qpU=L0dgY+aK4GkGhkjPGw3A@mail.gmail.com>
Subject: Re: [PATCH v4 2/3] bpf: Using binary search to improve the
 performance of btf_find_by_name_kind
To: Donglin Peng <dolinux.peng@gmail.com>
Cc: andrii@kernel.org, eddyz87@gmail.com, ast@kernel.org, rostedt@goodmis.org, 
	mhiramat@kernel.org, bpf@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 30, 2024 at 8:00=E2=80=AFAM Donglin Peng <dolinux.peng@gmail.co=
m> wrote:
>
> On Wed, Oct 30, 2024 at 6:13=E2=80=AFAM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >
> > On Mon, Oct 28, 2024 at 5:22=E2=80=AFPM Donglin Peng <dolinux.peng@gmai=
l.com> wrote:
> > >
> > > Currently, we are only using the linear search method to find the typ=
e id
> > > by the name, which has a time complexity of O(n). This change involve=
s
> > > sorting the names of btf types in ascending order and using binary se=
arch,
> > > which has a time complexity of O(log(n)). This idea was inspired by t=
he
> > > following patch:
> > >
> > > 60443c88f3a8 ("kallsyms: Improve the performance of kallsyms_lookup_n=
ame()").
> > >
> > > At present, this improvement is only for searching in vmlinux's and
> > > module's BTFs.
> > >
> > > Another change is the search direction, where we search the BTF first=
 and
> > > then its base, the type id of the first matched btf_type will be retu=
rned.
> > >
> > > Here is a time-consuming result that finding 87590 type ids by their =
names in
> > > vmlinux's BTF.
> > >
> > > Before: 158426 ms
> > > After:     114 ms
> > >
> > > The average lookup performance has improved more than 1000x in the ab=
ove scenario.
> > >
> > > Tested-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > > Signed-off-by: Donglin Peng <dolinux.peng@gmail.com>
> > > ---
> > > v4:
> > >  - move the modification of libbpf to another patch
> > >
> > > v3:
> > >  - Link: https://lore.kernel.org/all/20240608140835.965949-1-dolinux.=
peng@gmail.com/
> > >  - Sort btf_types during build process other than during boot, to red=
uce the
> > >    overhead of memory and boot time.
> > >
> > > v2:
> > >  - Link: https://lore.kernel.org/all/20230909091646.420163-1-pengdong=
lin@sangfor.com.cn
> > > ---
> > >  include/linux/btf.h |   1 +
> > >  kernel/bpf/btf.c    | 157 ++++++++++++++++++++++++++++++++++++++++--=
--
> > >  2 files changed, 147 insertions(+), 11 deletions(-)
> > >
> > > diff --git a/include/linux/btf.h b/include/linux/btf.h
> > > index b8a583194c4a..64c35aaa22fa 100644
> > > --- a/include/linux/btf.h
> > > +++ b/include/linux/btf.h
> > > @@ -216,6 +216,7 @@ bool btf_is_module(const struct btf *btf);
> > >  bool btf_is_vmlinux(const struct btf *btf);
> > >  struct module *btf_try_get_module(const struct btf *btf);
> > >  u32 btf_nr_types(const struct btf *btf);
> > > +u32 btf_type_cnt(const struct btf *btf);
> > >  struct btf *btf_base_btf(const struct btf *btf);
> > >  bool btf_member_is_reg_int(const struct btf *btf, const struct btf_t=
ype *s,
> > >                            const struct btf_member *m,
> > > diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> > > index 5cd1c7a23848..6d0d58989640 100644
> > > --- a/kernel/bpf/btf.c
> > > +++ b/kernel/bpf/btf.c
> > > @@ -262,6 +262,7 @@ struct btf {
> > >         u32 data_size;
> > >         refcount_t refcnt;
> > >         u32 id;
> > > +       u32 nr_types_sorted;
> > >         struct rcu_head rcu;
> > >         struct btf_kfunc_set_tab *kfunc_set_tab;
> > >         struct btf_id_dtor_kfunc_tab *dtor_kfunc_tab;
> > > @@ -548,23 +549,102 @@ u32 btf_nr_types(const struct btf *btf)
> > >         return total;
> > >  }
> > >
> > > -s32 btf_find_by_name_kind(const struct btf *btf, const char *name, u=
8 kind)
> > > +u32 btf_type_cnt(const struct btf *btf)
> > > +{
> > > +       return btf->start_id + btf->nr_types;
> > > +}
> > > +
> > > +static s32 btf_find_by_name_bsearch(const struct btf *btf, const cha=
r *name,
> > > +                                   int *start, int *end)
> > >  {
> > >         const struct btf_type *t;
> > > -       const char *tname;
> > > -       u32 i, total;
> > > +       const char *name_buf;
> > > +       int low, low_start, mid, high, high_end;
> > > +       int ret, start_id;
> > > +
> > > +       start_id =3D btf->base_btf ? btf->start_id : 1;
> > > +       low_start =3D low =3D start_id;
> > > +       high_end =3D high =3D start_id + btf->nr_types_sorted - 1;
> > > +
> > > +       while (low <=3D high) {
> > > +               mid =3D low + (high - low) / 2;
> > > +               t =3D btf_type_by_id(btf, mid);
> > > +               name_buf =3D btf_name_by_offset(btf, t->name_off);
> > > +               ret =3D strcmp(name, name_buf);
> > > +               if (ret > 0)
> > > +                       low =3D mid + 1;
> > > +               else if (ret < 0)
> > > +                       high =3D mid - 1;
> > > +               else
> > > +                       break;
> > > +       }
> > >
> > > -       total =3D btf_nr_types(btf);
> > > -       for (i =3D 1; i < total; i++) {
> > > -               t =3D btf_type_by_id(btf, i);
> > > -               if (BTF_INFO_KIND(t->info) !=3D kind)
> > > -                       continue;
> > > +       if (low > high)
> > > +               return -ESRCH;
> > >
> > > -               tname =3D btf_name_by_offset(btf, t->name_off);
> > > -               if (!strcmp(tname, name))
> > > -                       return i;
> > > +       if (start) {
> > > +               low =3D mid;
> > > +               while (low > low_start) {
> > > +                       t =3D btf_type_by_id(btf, low-1);
> > > +                       name_buf =3D btf_name_by_offset(btf, t->name_=
off);
> > > +                       if (strcmp(name, name_buf))
> > > +                               break;
> > > +                       low--;
> > > +               }
> > > +               *start =3D low;
> > > +       }
> > > +
> > > +       if (end) {
> > > +               high =3D mid;
> > > +               while (high < high_end) {
> > > +                       t =3D btf_type_by_id(btf, high+1);
> > > +                       name_buf =3D btf_name_by_offset(btf, t->name_=
off);
> > > +                       if (strcmp(name, name_buf))
> > > +                               break;
> > > +                       high++;
> > > +               }
> > > +               *end =3D high;
> > >         }
> > >
> >
> > this is an overcomplicated implementation, you need something like
> > find_linfo() implementation in kernel/bpf/log.c. Note how much shorter
> > and leaner it is.
> >
> > I also don't think you need to return `end`. Given you always start
> > from start and linearly scan forward, you just need to make sure that
> > you never go beyond the BTF type array, for which you can use
> > btf_type_cnt(). So no need for doing this linear scan twice.
>
> Thank you, but the situation here is different. When
> the btf file is sorted, the btf_types with a name are
> placed at the beginning of the file, while those without
> a name are placed at the end. Additionally, if there
> are multiple btf_types with the same name in a btf file,
> they will have different kinds, and these btf_types with
> the same name will be grouped together. For example, in
> the following case:
>
> ...
> [13561] FUNC 'bp_constraints_unlock' type_id=3D105264 linkage=3Dstatic
> [13562] STRUCT 'bp_cpuinfo' size=3D20 vlen=3D2
>         'cpu_pinned' type_id=3D66670 bits_offset=3D0
>         'tsk_pinned' type_id=3D13568 bits_offset=3D32
> [13563] VAR 'bp_cpuinfo' type_id=3D103076, linkage=3Dstatic
> [13564] FUNC 'bp_init_aperfmperf' type_id=3D70013 linkage=3Dstatic
> [13565] STRUCT 'bp_patching_desc' size=3D16 vlen=3D3
> ...
>
> Both 13562 and 13563 have the name 'bp_cpuinfo', but their
> kinds are different. Therefore, when using the btf_find_by_name_bsearch
> function to find the btf_type named 'bp_cpuinfo', the start
> parameter will be set to 11562 and the end parameter will
> be set to 11563. We can then check their kind to obtain the
> correct btf_type.

I understand that, thank you. find_linfo() shows an example of binary
search to find the rightmost item that's <=3D than requested search key.
You have a similar problem here. You need to find the leftmost item
that's equal to the search key.

Both of these problems are solved by binary search without any extra
post-processing and linear scans.

>
> >
> > > +       return mid;
> > > +}
> > > +
> > > +s32 btf_find_by_name_kind(const struct btf *btf, const char *name, u=
8 kind)
> > > +{
> > > +       const struct btf_type *t;
> > > +       const char *tname;
> > > +       int start, end;
> > > +       s32 id, total;
> > > +
> > > +       do {
> > > +               if (btf->nr_types_sorted) {
> > > +                       /* binary search */
> > > +                       id =3D btf_find_by_name_bsearch(btf, name, &s=
tart, &end);
> > > +                       if (id > 0) {
> > > +                               while (start <=3D end) {
> > > +                                       t =3D btf_type_by_id(btf, sta=
rt);
> > > +                                       if (BTF_INFO_KIND(t->info) =
=3D=3D kind)
> > > +                                               return start;
> > > +                                       start++;
> > > +                               }
> > > +                       }
> > > +               } else {
> > > +                       /* linear search */
> > > +                       total =3D btf_type_cnt(btf);
> > > +                       for (id =3D btf->base_btf ? btf->start_id : 1=
;
> > > +                               id < total; id++) {
> > > +                               t =3D btf_type_by_id(btf, id);
> > > +                               if (BTF_INFO_KIND(t->info) !=3D kind)
> > > +                                       continue;
> > > +
> > > +                               tname =3D btf_name_by_offset(btf, t->=
name_off);
> > > +                               if (!strcmp(tname, name))
> > > +                                       return id;
> > > +                       }
> > > +               }
> > > +               btf =3D btf->base_btf;
> > > +       } while (btf);
> > > +
> > >         return -ENOENT;
> > >  }
> > >
> > > @@ -6141,6 +6221,53 @@ int get_kern_ctx_btf_id(struct bpf_verifier_lo=
g *log, enum bpf_prog_type prog_ty
> > >         return kctx_type_id;
> > >  }
> > >
> > > +static int btf_check_sort(struct btf *btf, int start_id)
> > > +{
> > > +       int i, n, nr_names =3D 0;
> > > +
> > > +       n =3D btf_nr_types(btf);
> > > +       for (i =3D start_id; i < n; i++) {
> > > +               const struct btf_type *t;
> > > +               const char *name;
> > > +
> > > +               t =3D btf_type_by_id(btf, i);
> > > +               if (!t)
> > > +                       return -EINVAL;
> > > +
> > > +               name =3D btf_str_by_offset(btf, t->name_off);
> > > +               if (!str_is_empty(name))
> > > +                       nr_names++;
> > > +       }
> > > +
> >
> > this loop makes zero sense to me, what are you trying to achieve with
> > it and why?
>
> As previously mentioned, if the btf file is sorted, the
> btf_type with a name will be placed at the beginning of
> the file in ascending order, while those without a name
> will be placed at the end. Therefore, we can verify if
> the btf file is sorted by following these steps:
>
> Step 1: Count the number of btf_types with a name and
>              store it as nr_names.
>
> Step 2: Inspect the first nr_names btf_types. If any of
>             the following cases occur, it indicates that the
>             btf file is not sorted:
>            1. A btf_type without a name is encountered.
>            2. The name of the current btf_type is greater  than
>                the name of the next btf_type.

This is convoluted and unnecessary. Just go over all items and
validate that each pair maintains the sorting criteria.

>
> >
> > > +       for (i =3D 0; i < nr_names - 1; i++) {
> >
> > just start from start_id + 1, all the way to n, and check that sorting
> > invariant holds for all items
> >
> > > +               const struct btf_type *t1, *t2;
> > > +               const char *s1, *s2;
> > > +
> > > +               t1 =3D btf_type_by_id(btf, start_id + i);
> > > +               if (!t1)
> > > +                       return -EINVAL;
> > > +
> > > +               s1 =3D btf_str_by_offset(btf, t1->name_off);
> > > +               if (str_is_empty(s1))
> > > +                       goto out;
> > > +
> > > +               t2 =3D btf_type_by_id(btf, start_id + i + 1);
> > > +               if (!t2)
> > > +                       return -EINVAL;
> > > +
> > > +               s2 =3D btf_str_by_offset(btf, t2->name_off);
> > > +               if (str_is_empty(s2))
> > > +                       goto out;
> > > +
> > > +               if (strcmp(s1, s2) > 0)
> > > +                       goto out;
> > > +       }
> > > +
> > > +       btf->nr_types_sorted =3D nr_names;
> > > +out:
> > > +       return 0;
> > > +}
> >
> > [...]

