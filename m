Return-Path: <linux-kselftest+bounces-45911-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id AF8E2C6B4B3
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Nov 2025 19:52:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 344944E7A49
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Nov 2025 18:52:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 765832DF706;
	Tue, 18 Nov 2025 18:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EfjsZ+cn"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7813A2DF3D9
	for <linux-kselftest@vger.kernel.org>; Tue, 18 Nov 2025 18:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763491900; cv=none; b=VhGzRRTVHM9H3sm2urjtXeo+UISlce3wMdZvkwRiVgCEXS6tnG+ZGHw53JjADsLbdifQFjcpst3BIibKfe0jMbcyrBICeFoq8KnLiNlx8jfTuoj5/Bu26FbqaRWn5LIJJWItSfmNlOYaZVd7CnhmnfGX8lwTKr4QXjQl0mhAgE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763491900; c=relaxed/simple;
	bh=81Sp+D+laB+03Tt7GS7Ug4TPjoj/pq6tLpAp2spnHLo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SkboXzeYnsXNVS5EGEDSuqL6Zix2m5X3LeV5Uue7L/qxBFUxRsIHvVD/mjy5u/JFsCaxxjP+ubSD8DQX9AtRzC+wIwERlNghw/WF/4p/FWjJjSaXBCyhPqJjPyQHs92S+sE+iBGksZT8mkTcnlaJBRP+MFyp8v/dlpmy9g87OBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EfjsZ+cn; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-787d6536438so1602377b3.1
        for <linux-kselftest@vger.kernel.org>; Tue, 18 Nov 2025 10:51:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763491897; x=1764096697; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AmJ1r+Yly7snQXkHFNnjZN8vcx+B6ZlSZ9GX621gT18=;
        b=EfjsZ+cnv1wHgig/mJwoJxuniaakJMKlEvfubMuS83oRH57Onp4uRAceKsoVmurjY9
         mQeOcPvD6RKghVCaDZlt1/RRvgKsEsa2xXtSFOglnQfyBDQEYzUXfyu2P1S9tByNhFLK
         FKCV6cPNuNXa49xSGW5Fo/GIRpfwyInnS/PJiyBy9r0wAP0VTIgQzpt6Sd1qcsl1jDgy
         8thrDAYEgaxOE2dc5SQKpkMa/Ow2efsFwfPFIDU+XLLJQxAHOwL+j0WETa9E7bLeIQOj
         VVckWSIgJARCoiwqgu79QrEKKBErCXYS0pYDyjshO3x8w6Z0wXE9BgKbgE859zj7Dkge
         3txQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763491897; x=1764096697;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=AmJ1r+Yly7snQXkHFNnjZN8vcx+B6ZlSZ9GX621gT18=;
        b=mVGwz3uc4/wj80e4ZI+xu/4oZN6YGyTevVHbiGCFkvfzqfRDFMesh5aIu8IiiWwoi7
         eqnruhqthZozPygUFZLGkU5CmQ6zJw3n7VcAGorQ3vt1WQgEjIR5zziZUAIomCnW5ZZD
         79aw1bnEIVHjLfhBpho+BfxIIs1W8uT1Mso+C814ZiLAZe2ON2UOE+Yv8Xl+uLAM4e7Y
         PBTV61LU3dwsDwP1gi83Frc1YaG3yWcQiVWLbEfbNFTMIjMv4GZbv72NKIT9SO1yQADi
         67h0RV3gLLdiJ+7p2ssIutYco/+iE7s2i6QATWBmcmRC+SRFER7xPfQxaTsdnD/xxreV
         Gdqg==
X-Forwarded-Encrypted: i=1; AJvYcCX2D7T4PLZn5vUTjKC91dC+0xKgymwNJoP0frOv/0Fmv7iZeBzTiaZbX7ftB5WlxThlwZHufLgcyA2TWE0jDic=@vger.kernel.org
X-Gm-Message-State: AOJu0YxnmSYGwaZFYSMxny2cP3Q0cq4mkBeh9x+RfDW0+5D27Dwhp44s
	A7bKdgFrtF0znyn8fDHzL67Z5bNmkj8K6ZPJzpH3nQnPVzp77bw4iiLMTu8FphdGisVfK+PuMu0
	8XDxmV01rcVBZS0iJdI5Vw7uV2gua2ZA=
X-Gm-Gg: ASbGncvUb9TNNTye8PIzrVMkO/DVz6WtSxVdq02fxNwyQgJfln50nPOJxpiwbgvDjZ3
	5h68P0c7FWQdh0UO5MKG5DJb67LqNnSxn/fslpoj/25yvi8VCnNjcWuwkchGG/Hm6oXqb4cz/I1
	DI8SQmZxEDD3QgmHeRtE0t1y2id2BcWrcNQP7BseQBX1i1Pa9TWE7GI/dY3ZpCJ+zfFG8NkzbMr
	EfDVWKeX5rt9dHZuJ89DIFJstunl9jM4Jt1Qm1/TaY1+UemA8g5Lpu8hRMBGQjjLNRplxgSoZDI
	bk63xKuJVXx4Nxbyo9z2+w==
X-Google-Smtp-Source: AGHT+IFShkDcISZm2LxvfcdYpj0QvJDYeStfFXrrkERqm+AvudmI/Y8s3QmYdw621TlBmZTH/o0S5hkm+1SrE09tqKk=
X-Received: by 2002:a05:690c:2a8e:b0:786:87b1:960a with SMTP id
 00721157ae682-78965771c42mr22430047b3.1.1763491897264; Tue, 18 Nov 2025
 10:51:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251113-netconsole_dynamic_extradata-v2-0-18cf7fed1026@meta.com>
 <20251113-netconsole_dynamic_extradata-v2-3-18cf7fed1026@meta.com> <ucjifexudkswvaef5c25hbzszdnzsnx3drdaqkf7ytdpi6qzk6@pd46ih2slt3w>
In-Reply-To: <ucjifexudkswvaef5c25hbzszdnzsnx3drdaqkf7ytdpi6qzk6@pd46ih2slt3w>
From: Gustavo Luiz Duarte <gustavold@gmail.com>
Date: Tue, 18 Nov 2025 18:51:25 +0000
X-Gm-Features: AWmQ_bm1HKja1h38EaRzKpJFc3jLvJv52aUCJJuXweopUqbndptdtXQQNn2qV0Q
Message-ID: <CAGSyskVSLtG-JyboQ6TLVKwMvHVH8YmgLJE1wFTU2czxCWFCzQ@mail.gmail.com>
Subject: Re: [PATCH net-next v2 3/4] netconsole: Dynamic allocation of
 userdata buffer
To: Breno Leitao <leitao@debian.org>
Cc: Andre Carvalho <asantostc@gmail.com>, Simon Horman <horms@kernel.org>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Shuah Khan <shuah@kernel.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 14, 2025 at 1:04=E2=80=AFPM Breno Leitao <leitao@debian.org> wr=
ote:
>
> On Thu, Nov 13, 2025 at 08:42:20AM -0800, Gustavo Luiz Duarte wrote:
> > @@ -875,45 +875,61 @@ static ssize_t userdatum_value_show(struct config=
_item *item, char *buf)
> >       return sysfs_emit(buf, "%s\n", &(to_userdatum(item)->value[0]));
> >  }
> >
> > -static void update_userdata(struct netconsole_target *nt)
> > +static int update_userdata(struct netconsole_target *nt)
> >  {
> > +     struct userdatum *udm_item;
> > +     struct config_item *item;
> >       struct list_head *entry;
> > -     int child_count =3D 0;
> > +     char *old_buf =3D NULL;
> > +     char *new_buf =3D NULL;
> >       unsigned long flags;
> > +     int offset =3D 0;
> > +     int len =3D 0;
> >
> > -     spin_lock_irqsave(&target_list_lock, flags);
> > -
> > -     /* Clear the current string in case the last userdatum was delete=
d */
> > -     nt->userdata_length =3D 0;
> > -     nt->userdata[0] =3D 0;
> > -
> > +     /* Calculate buffer size */
>
> Please create a function for this one.

will do in v3

>
> >       list_for_each(entry, &nt->userdata_group.cg_children) {
> > -             struct userdatum *udm_item;
> > -             struct config_item *item;
> > -
> > -             if (child_count >=3D MAX_USERDATA_ITEMS) {
> > -                     spin_unlock_irqrestore(&target_list_lock, flags);
> > -                     WARN_ON_ONCE(1);
> > -                     return;
> > +             item =3D container_of(entry, struct config_item, ci_entry=
);
> > +             udm_item =3D to_userdatum(item);
> > +             /* Skip userdata with no value set */
> > +             if (udm_item->value[0]) {
> > +                     len +=3D snprintf(NULL, 0, " %s=3D%s\n", item->ci=
_name,
> > +                                     udm_item->value);
> >               }
> > -             child_count++;
> > +     }
> > +
> > +     WARN_ON_ONCE(len > MAX_EXTRADATA_ENTRY_LEN * MAX_USERDATA_ITEMS);
>
> If we trigger this WARN_ON_ONCE, please return, and do not proceed with
> the buffer replacement.

will do in v3.

>
> > +
> > +     /* Allocate new buffer */
> > +     if (len) {
> > +             new_buf =3D kmalloc(len + 1, GFP_KERNEL);
> > +             if (!new_buf)
> > +                     return -ENOMEM;
> > +     }
> >
> > +     /* Write userdata to new buffer */
> > +     list_for_each(entry, &nt->userdata_group.cg_children) {
> >               item =3D container_of(entry, struct config_item, ci_entry=
);
> >               udm_item =3D to_userdatum(item);
> > -
> >               /* Skip userdata with no value set */
> > -             if (strnlen(udm_item->value, MAX_EXTRADATA_VALUE_LEN) =3D=
=3D 0)
> > -                     continue;
> > -
> > -             /* This doesn't overflow userdata since it will write
> > -              * one entry length (1/MAX_USERDATA_ITEMS long), entry co=
unt is
> > -              * checked to not exceed MAX items with child_count above
> > -              */
> > -             nt->userdata_length +=3D scnprintf(&nt->userdata[nt->user=
data_length],
> > -                                              MAX_EXTRADATA_ENTRY_LEN,=
 " %s=3D%s\n",
> > -                                              item->ci_name, udm_item-=
>value);
> > +             if (udm_item->value[0]) {
> > +                     offset +=3D scnprintf(&new_buf[offset], len + 1 -=
 offset,
> > +                                         " %s=3D%s\n", item->ci_name,
> > +                                         udm_item->value);
> > +             }
> >       }
> > +
> > +     WARN_ON_ONCE(offset !=3D len);
>
> if we hit the warning above, then offset < len, and we are wrapping some
> item, right?
>
> > +
> > +     /* Switch to new buffer and free old buffer */
> > +     spin_lock_irqsave(&target_list_lock, flags);
> > +     old_buf =3D nt->userdata;
> > +     nt->userdata =3D new_buf;
> > +     nt->userdata_length =3D len;
>
> This should be nt->userdata_length =3D offset, supposing the scnprintf go=
t
> trimmed, and the WARN_ON_ONCE above got triggered. Offset is the lenght
> that was appened to new_buf.

Agree. Will use offset instead of len here in v3.

>
> >       spin_unlock_irqrestore(&target_list_lock, flags);
> > +
> > +     kfree(old_buf);
> > +
> > +     return 0;
> >  }
>
> This seems all safe. update_userdata() is called with never called in
> parallel, given it should be called with dynamic_netconsole_mutex, and
> nt-> operations are protected by target_list_lock.
>
> The only concern is nt->userdata_length =3D offset (instead of len).
>
> >
> >  static ssize_t userdatum_value_store(struct config_item *item, const c=
har *buf,
> > @@ -937,7 +953,9 @@ static ssize_t userdatum_value_store(struct config_=
item *item, const char *buf,
> >
> >       ud =3D to_userdata(item->ci_parent);
> >       nt =3D userdata_to_target(ud);
> > -     update_userdata(nt);
> > +     ret =3D update_userdata(nt);
> > +     if (ret < 0)
> > +             goto out_unlock;
> >       ret =3D count;
> >  out_unlock:
> >       mutex_unlock(&dynamic_netconsole_mutex);
> > @@ -1193,7 +1211,10 @@ static struct configfs_attribute *netconsole_tar=
get_attrs[] =3D {
> >
> >  static void netconsole_target_release(struct config_item *item)
> >  {
> > -     kfree(to_target(item));
> > +     struct netconsole_target *nt =3D to_target(item);
>
> Thinking about this now, I suppose netconsole might be reading this in
> parallel, and then we are freeing userdata mid-air.
>
> Don't we need the target_list_lock in here ?

This method is called after drop_netconsole_target(), which removes
the target from target_list. This guarantees that we won't race with
write_ext_msg().
Also, a config_group cannot be removed while it still has child items.
This guarantees that we won't race with userdata or attribute
operations.
So I believe this is safe.

>
> --
> pw-bot: cr

