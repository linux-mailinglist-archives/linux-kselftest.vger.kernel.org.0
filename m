Return-Path: <linux-kselftest+bounces-11424-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 39C2F900AD1
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Jun 2024 18:57:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A3CE31F2327E
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Jun 2024 16:57:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3434019AA6D;
	Fri,  7 Jun 2024 16:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NbrS8nDR"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 671E31993B5;
	Fri,  7 Jun 2024 16:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717779455; cv=none; b=tioyv0D9tcoTgYYcVOeSi5JgIBSfjWw9y/qosypUwPpgqbXwDBXG3d0HC279EjC7l0AA5nWIECDUSPOqXkKGCXFGVnp7oZUCv1SrFs5HrLDLkTknkZsLXk/z9qZa/AI57DtZ9WEVwgXZugGUCBb7otL8B/u1cHZFFBLJdHJlxnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717779455; c=relaxed/simple;
	bh=vyIwv3aKDmIX4FeBkHbRcvl6eBbosit+VQOpM5pGDSk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D1ImrzdMf92Ejvi7oKrMURs6EzCrs1ogvbQ6hd/Nzy3LKTu+vKuOTXbUhsk0qyYjxDADPEUQcgSBf6Yp7i4ITkmYkK7wIw2oKiE8AI22Nt8yuwMqF2gJfzbsCOPbsvpE3fk1k9qsxLqYHFcU3Qw304RnEmVDbg5JLTZS2cY3Lmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NbrS8nDR; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-35e4aaa0f33so2289398f8f.0;
        Fri, 07 Jun 2024 09:57:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717779452; x=1718384252; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lmqHN8HdU+Bg3/a80lxpWcORyiTb4GcEocv7nj+8/gA=;
        b=NbrS8nDRek9OZd6qlaMFNVDk5CxE7vU079SSfcc6o9LgnaSagv1tRA1SeXqU7NVPd2
         hloO91TczMpjfatYhsCjcIikbp4K9fmuoUGvbjtD9yFMqDnqlttgXDy+UsG26XYzN9Y3
         7vFG5Le2ky5h2lAF4LvaxiLWGeyuuqD3287ctqU9+33R2/f2vx7h7V7jmwnkjPgprpdk
         +sI99cf1my+fov8MSyzoWHJkoJyb10FA69wJZ9cinhem3yOYgppfB1e8N8zEYMo7J9lC
         T2MP496FrWWB8l8+yCtQh0kLDHMUkD/dl3vaAo5ULPlXgNZfcQOY0XEK0AUi4jP8Ze5z
         SJGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717779452; x=1718384252;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lmqHN8HdU+Bg3/a80lxpWcORyiTb4GcEocv7nj+8/gA=;
        b=H9kNh087m2tyrppNEvqkzkW8yVxrfuXAguK4YEZo1tQRoX3e5lURS6paCJGm9g6MsS
         ROR+aFol2Qk9VkQ06MLfUM8YhRR3ERlpwZeGCojjDOhG+7VUqdZ3+K3n6BecbTAqvxIF
         1czLojwSjv2ncjHhAvjhx2ML01pTzatli8/V6K5S1dTc4jFP+wPG3riBoZQysJf+WIwU
         AU7y6WGfrCDzGvpGYOVr4tBwyDWTQ86XwV9DZ2eeAGFnHFpk1yFS0a02ZTogE5vNwwJg
         2rGedni83g78FA4lwtEEGzmrE0tL1ih1YeilHGLKTvjRD1p2NMex2BhZXWUZTWrlpYL4
         7rQQ==
X-Forwarded-Encrypted: i=1; AJvYcCXR/aVDDY/6Go1GQ23PdDplzQ68G3MjBoadZd150pgzToN7qUMOjrT0vRsX8IWTNHPeRScvEapcFf2204BmEd57d/n/SELppmNwb6Wdo9q0HNrK5UuyQKQuxF63GdKIr+IQwCY3qDivFHigPAnE9Sbny4muULUF88WENJg+Exnfr2BN/sZVootjDsD7xCjl0L4u/llQX1wvqsw2JtTavORnI+lF08w17s65zpOA6HL0+i9nH7NTONZ59aM=
X-Gm-Message-State: AOJu0Yxrhh0djTivncZuWYnmHu3+aYk/FscIYIpYnS5eOrw7WLHxf5eC
	HDIVmiI2QRXkqUG7yT4s+f/kgz8PwneeGLb3b4PXsqrs4xeypoxQLMRyGAmBEUTX82OCZM9Bp4c
	KwcbBiwC1xMhMUFFO4ZcbGBcQeu0=
X-Google-Smtp-Source: AGHT+IFOPs2JBnUtGoSpAAD8HQDvIVuOuQG2vJVm8c00EsEeTwtYixqeKoDug5QLbfb3XvREuIb4kiRam1yvt/x8AU8=
X-Received: by 2002:adf:8bd3:0:b0:355:7e4:3cfb with SMTP id
 ffacd0b85a97d-35efed39e96mr2701786f8f.23.1717779451434; Fri, 07 Jun 2024
 09:57:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240607-hid_bpf_struct_ops-v2-0-3f95f4d02292@kernel.org> <20240607-hid_bpf_struct_ops-v2-15-3f95f4d02292@kernel.org>
In-Reply-To: <20240607-hid_bpf_struct_ops-v2-15-3f95f4d02292@kernel.org>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 7 Jun 2024 09:57:20 -0700
Message-ID: <CAADnVQ+xPtq=kw_MKPaQkeAhdPndhJs1S5DRBGtByBQ-BgdFmA@mail.gmail.com>
Subject: Re: [PATCH HID v2 15/16] HID: bpf: rework hid_bpf_ops_btf_struct_access
To: Benjamin Tissoires <bentiss@kernel.org>
Cc: Shuah Khan <shuah@kernel.org>, Jiri Kosina <jikos@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	Alexei Starovoitov <ast@kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	bpf <bpf@vger.kernel.org>, 
	"open list:HID CORE LAYER" <linux-input@vger.kernel.org>, 
	"open list:DOCUMENTATION" <linux-doc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 7, 2024 at 8:29=E2=80=AFAM Benjamin Tissoires <bentiss@kernel.o=
rg> wrote:
>
> The idea is to provide a list of stucts and their editable fields.
>
> Currently no functional changes are introduced here, we will add some
> more writeable fields in the next patch.
>
> Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>
>
> ---
>
> new in v2
> ---
>  drivers/hid/bpf/hid_bpf_struct_ops.c | 91 +++++++++++++++++++++++++++---=
------
>  1 file changed, 69 insertions(+), 22 deletions(-)
>
> diff --git a/drivers/hid/bpf/hid_bpf_struct_ops.c b/drivers/hid/bpf/hid_b=
pf_struct_ops.c
> index 056d05d96962..944e6d91a36b 100644
> --- a/drivers/hid/bpf/hid_bpf_struct_ops.c
> +++ b/drivers/hid/bpf/hid_bpf_struct_ops.c
> @@ -16,6 +16,7 @@
>  #include <linux/hid_bpf.h>
>  #include <linux/init.h>
>  #include <linux/module.h>
> +#include <linux/stddef.h>
>  #include <linux/workqueue.h>
>  #include "hid_bpf_dispatch.h"
>
> @@ -52,40 +53,86 @@ static int hid_bpf_ops_check_member(const struct btf_=
type *t,
>         return 0;
>  }
>
> +struct hid_bpf_offset_write_range {
> +       const char *struct_name;
> +       u32 struct_length;
> +       u32 start;
> +       u32 end;
> +};
> +
>  static int hid_bpf_ops_btf_struct_access(struct bpf_verifier_log *log,
>                                            const struct bpf_reg_state *re=
g,
>                                            int off, int size)
>  {
> -       const struct btf_type *state;
> -       const struct btf_type *t;
> -       s32 type_id;
> +#define WRITE_RANGE(_name, _field, _start_offset, _end_offset)          =
       \
> +       {                                                                =
       \
> +               .struct_name =3D #_name,                                 =
         \
> +               .struct_length =3D sizeof(struct _name),                 =
         \
> +               .start =3D offsetof(struct _name, _field) + _start_offset=
,        \
> +               .end =3D offsetofend(struct _name, _field) + _end_offset,=
         \
> +       }

reading comment /* minus 1 to ensure \0 at the end */
in the next patch...
I don't see this logic below.
In general the manual byte offset adjustment
looks like a footgun. Maybe add a flag for \0 and avoid
messing with offsets?

>
> -       type_id =3D btf_find_by_name_kind(reg->btf, "hid_bpf_ctx",
> -                                       BTF_KIND_STRUCT);
> -       if (type_id < 0)
> -               return -EINVAL;
> +       const struct hid_bpf_offset_write_range write_ranges[] =3D {
> +               WRITE_RANGE(hid_bpf_ctx, retval, 0, 0),
> +       };
> +#undef WRITE_RANGE
> +       const struct btf_type *state =3D NULL;
> +       const struct btf_type *t;
> +       const char *cur =3D NULL;
> +       int i;
>
>         t =3D btf_type_by_id(reg->btf, reg->btf_id);
> -       state =3D btf_type_by_id(reg->btf, type_id);
> -       if (t !=3D state) {
> -               bpf_log(log, "only access to hid_bpf_ctx is supported\n")=
;
> -               return -EACCES;
> -       }
>
> -       /* out-of-bound access in hid_bpf_ctx */
> -       if (off + size > sizeof(struct hid_bpf_ctx)) {
> -               bpf_log(log, "write access at off %d with size %d\n", off=
, size);
> -               return -EACCES;
> +       for (i =3D 0; i < ARRAY_SIZE(write_ranges); i++) {
> +               const struct hid_bpf_offset_write_range *write_range =3D =
&write_ranges[i];
> +               s32 type_id;
> +
> +               /* we already found a writeable struct, but there is a
> +                * new one, let's break the loop.
> +                */
> +               if (t =3D=3D state && write_range->struct_name !=3D cur)
> +                       break;
> +
> +               /* new struct to look for */
> +               if (write_range->struct_name !=3D cur) {
> +                       type_id =3D btf_find_by_name_kind(reg->btf, write=
_range->struct_name,
> +                                                       BTF_KIND_STRUCT);
> +                       if (type_id < 0)
> +                               return -EINVAL;
> +
> +                       state =3D btf_type_by_id(reg->btf, type_id);
> +               }
> +
> +               /* this is not the struct we are looking for */
> +               if (t !=3D state) {
> +                       cur =3D write_range->struct_name;
> +                       continue;
> +               }
> +
> +               /* first time we see this struct, check for out of bounds=
 */
> +               if (cur !=3D write_range->struct_name &&
> +                   off + size > write_range->struct_length) {
> +                       bpf_log(log, "write access for struct %s at off %=
d with size %d\n",
> +                               write_range->struct_name, off, size);
> +                       return -EACCES;
> +               }
> +
> +               /* now check if we are in our boundaries */
> +               if (off >=3D write_range->start && off + size <=3D write_=
range->end)
> +                       return NOT_INIT;
> +
> +               cur =3D write_range->struct_name;
>         }
>
> -       if (off < offsetof(struct hid_bpf_ctx, retval)) {
> +
> +       if (t !=3D state)
> +               bpf_log(log, "write access to this struct is not supporte=
d\n");
> +       else
>                 bpf_log(log,
> -                       "write access at off %d with size %d on read-only=
 part of hid_bpf_ctx\n",
> -                       off, size);
> -               return -EACCES;
> -       }
> +                       "write access at off %d with size %d on read-only=
 part of %s\n",
> +                       off, size, cur);
>
> -       return NOT_INIT;
> +       return -EACCES;
>  }
>
>  static const struct bpf_verifier_ops hid_bpf_verifier_ops =3D {
>
> --
> 2.44.0
>

