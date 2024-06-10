Return-Path: <linux-kselftest+bounces-11591-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E964B9028D9
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Jun 2024 20:41:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 929DA1F21D0F
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Jun 2024 18:41:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2171C1509A8;
	Mon, 10 Jun 2024 18:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d0c5wjB2"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5525D14D2AB;
	Mon, 10 Jun 2024 18:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718044790; cv=none; b=BVuY/H1cGPsOeUGkmrYm3iXOwgVIKEv6fcEIvkatDFkax/fsf3A88F19pkA11V95Gd05k9d6TQy6n9A5ffDDn+Q6kD0NS/AAncB6ffmA6ObAodcMrs+RadvfrhvOemUSuqWUqUZBW+p6DKNNp5ecWwamYV/j2ZujyYqd17ttNUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718044790; c=relaxed/simple;
	bh=fKqD5f5/0GE7gIXsC0zZzonpmGQhNmbkyUx1u/Vw0+A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=guMUA3rbiEgi2jASIzNpC9AEoyVAgIpoxI+gbNhppNREsmGMj9gJhIrdGeQJNq8d99QINhvuUAi5bz/9FSdyPNtnllH3b5NgneKDScF0TQCWHX3w5mLf3GnNtWXu3Nxjle6QkUcoa1Jh6/O7l2xGmdmyRad0tMjCBk7633ihsi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d0c5wjB2; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-354f3f6c3b1so3893110f8f.2;
        Mon, 10 Jun 2024 11:39:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718044786; x=1718649586; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BX2BqskCUGTIe52ShH0n2+nBwA4ZfttYr38Hr8GVxi8=;
        b=d0c5wjB23optI5QwwnJNtxcCi8aIz81ZdxsPEDCokP2zFvq8nwOUEEi6F+AyJ6cdp9
         s0Xnu9FKac7Mmi+ARnJg6t54tz7GFLApRska++OMlAOFZKLntyKRbsgi++j5avRDQYeo
         6D8xloxzgwwzcLm0h85ZNlMEJbYN1rWh/9bIR+EOmCkHi7Or7K8JXnmPTc8jZlLyZLUP
         //OjRCnzQAbhvfS6tGypxMCXpctwZpV27ncUdVl7rMto5yFaso6vabm8UwKhue6RgdsZ
         LLC4LM/z9Kmi84dp1yuaAADeMSDWzT8GeQHOMj8sbUinayeccmDdgrWIsnYgQcrT6gjf
         JC6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718044786; x=1718649586;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BX2BqskCUGTIe52ShH0n2+nBwA4ZfttYr38Hr8GVxi8=;
        b=RSU6BJaNVWMJq6z5Bk0GjK6pv59e1WrqrdcIyx+3/u+M5O8PpiZ+8ffjCkxA0axHJ6
         X9Y6lsd5hVwxafF8w6sKuM2xYoH/puroQeR5OnC1d1zD4AIA0VEeA2B6/1l85Kq9LGDw
         tw3CElkW+A4mP3PlkZgI8KmWmaxpd0aQIybAG8tbFIrADlZFEPEamYOs8nbwAbHV8uau
         fj3zUCuB5tbmiASs77yYl+qqp4a+YdbI8wThtnv0LBGGQnD4rQecw7v9dQeHQG3t/JJm
         WVqLVNrSIebPeYP4nDdWlbiEC3Ap/IUD7j3YUbaEwhVSoJ0n67C716W5I15FHKNyHH5C
         LE8g==
X-Forwarded-Encrypted: i=1; AJvYcCVQI2THH7uvkZrK1QaxL2cL+RGjM72lPrrhvCL2VtPY3x2nMgjYe2AFueEybEgfNxh4xmrT2GUIWtgI2IKCdMuC5GQKFODigMURdqd8mCF6vO/MNpwFLWMCzE/JkWs2DcnoMIYwAnAsuSkPGmTUpsz5XmfwPoUllYe0a6NXE2zALJZWGYXlWjoLsPVUfqDiThuogOr9M2LkAeBknkt/OLzo32pWHVJSXT6UiBy69LHu8q/DRaWlAbWFOSo=
X-Gm-Message-State: AOJu0YwoLr1nOXtrqmtPK5BVgZlQdu5VfebBrCtDOoHKULjjfkEEYwy0
	kgFSzfMS1iiLsMPAacKc5qac07I3/htPjOkS09dIRFBrmXosRXt9sfSrqd/d9mi/9q95cYvv0Qa
	5kDKUSe1HTQlN3/act+C1zDV8XtOnLKCw
X-Google-Smtp-Source: AGHT+IEYrAxoBeRt81cMXgcWH8TrePlfB91jzBap0Ld2Ve1hPy9ZIMY5ysk44StmBEUJH2mf2Rq6ancHkMXukbEY6ro=
X-Received: by 2002:a05:6000:1f8c:b0:35f:2935:7cfd with SMTP id
 ffacd0b85a97d-35f29357e38mr1550081f8f.27.1718044786305; Mon, 10 Jun 2024
 11:39:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240608-hid_bpf_struct_ops-v3-0-6ac6ade58329@kernel.org> <20240608-hid_bpf_struct_ops-v3-15-6ac6ade58329@kernel.org>
In-Reply-To: <20240608-hid_bpf_struct_ops-v3-15-6ac6ade58329@kernel.org>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 10 Jun 2024 11:39:35 -0700
Message-ID: <CAADnVQLCyEZMyThCH6QNopBbWbNcpR+h2AaLhT0apEO7pOWrRQ@mail.gmail.com>
Subject: Re: [PATCH HID v3 15/16] HID: bpf: rework hid_bpf_ops_btf_struct_access
To: Benjamin Tissoires <bentiss@kernel.org>
Cc: Shuah Khan <shuah@kernel.org>, Jiri Kosina <jikos@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	Alexei Starovoitov <ast@kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	bpf <bpf@vger.kernel.org>, 
	"open list:HID CORE LAYER" <linux-input@vger.kernel.org>, 
	"open list:DOCUMENTATION" <linux-doc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 8, 2024 at 2:01=E2=80=AFAM Benjamin Tissoires <bentiss@kernel.o=
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
> changes in v3:
> - rewrote WRITE_RANGE macro to not deal with offset from the caller side
>
> new in v2
> ---
>  drivers/hid/bpf/hid_bpf_struct_ops.c | 91 +++++++++++++++++++++++++++---=
------
>  1 file changed, 69 insertions(+), 22 deletions(-)
>
> diff --git a/drivers/hid/bpf/hid_bpf_struct_ops.c b/drivers/hid/bpf/hid_b=
pf_struct_ops.c
> index 056d05d96962..b14eccb121e0 100644
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
> +#define WRITE_RANGE(_name, _field, _is_string)                          =
       \
> +       {                                                                =
       \
> +               .struct_name =3D #_name,                                 =
         \
> +               .struct_length =3D sizeof(struct _name),                 =
         \
> +               .start =3D offsetof(struct _name, _field),               =
         \
> +               .end =3D offsetofend(struct _name, _field) - !!(_is_strin=
g),

so it works because char name[128]; had last byte as zero
before prog writes into it (in addition to potentially having
earlier 0 bytes), so the string is guaranteed
to be null-terminated regardless of what prog writes into it.
Right?

Overall:
Acked-by: Alexei Starovoitov <ast@kernel.org>

