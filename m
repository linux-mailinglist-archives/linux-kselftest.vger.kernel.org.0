Return-Path: <linux-kselftest+bounces-47856-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 86E76CD691C
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Dec 2025 16:36:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 07BA1301A1DD
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Dec 2025 15:35:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6282B2FFDD8;
	Mon, 22 Dec 2025 15:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="OUehiaPh"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDBA92DC334
	for <linux-kselftest@vger.kernel.org>; Mon, 22 Dec 2025 15:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766417741; cv=none; b=IR4qN2IxfgG+5rhXGoJOb5W6UbgEs0TmejkWGmnd5FXQJn9YP0KCYF4bxpuzVxMINGJr+zx3J5AdJT2LUkelVjkBnxgE7ZpeZqNkenrnBuxPL+6IyutZ0tMjB8nYB10L1Bm+0BOADz7XiWSLRnVthU1OoKMoZ+1kNeWLijofHOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766417741; c=relaxed/simple;
	bh=PoSWDLt1BY12/wmoUnTkkQX425fb0XwPIoLz6YHAQzI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qOuZkNXyuZon8b0U27TsGklTQrQjau7vA0gZoXVvDPjy0mjhobIvuYYssCaClb/fh00wasSh1NIOZJsG5HIPBr3KQR5FsjxluTqCEeEC/TjkC25Lg1Xfzlt/hLC+zaIK+F2bZnRKmuZY6Jqf1FJqDfnA8xLt7GIfcor0KrFHFZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=OUehiaPh; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-7d481452588so242684b3a.3
        for <linux-kselftest@vger.kernel.org>; Mon, 22 Dec 2025 07:35:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1766417739; x=1767022539; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y1GrUAJlbdzOZ0XKY601sli1pZVJQLdTDOq57GxyWF4=;
        b=OUehiaPhKQuLMDxazo25Fg7Shz8HxhaynNu3DtWjqYXMHL56w/7IMnSeqdtu+qzUmN
         1kiFNGPlfUHBK8FR5rFURwn1wpUjahAPfBoJMxiQCAswnlNlkT5YOEWc1DgFCdTlvN2I
         6tmvJ2ljsBmOh7VyAmimGaL7fWMhVdKCGsoVzptI8tFIpodBsu3T6pEqAJvYETk9wwJU
         1ZlTy0s2Xc+WkAbImnBzs1lHsQ4Cd6Le1kLldrEoLhDBJ6EL2LRVwANXT+MhVte8Rpzg
         QH4qSQb4Uotex6LgwGP4PXLH1gb0dQuB+FzU3f7xgVVGOXu76bbF9PxaUIizVAAGHhc4
         hcHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766417739; x=1767022539;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=y1GrUAJlbdzOZ0XKY601sli1pZVJQLdTDOq57GxyWF4=;
        b=g8v60e072fIhxUYuRQCX1ieIPT/htYgeuLA8JtV4tAtnVZ32f+RPDrFeBGRsgeLtoy
         JNLZfUxab7bULNb2/pjWXfuVnGF26TNkHlebOC7JrGifeLvB9fNrCX+QKmTJ2PmGg4Zm
         Xom8V8gi6XPOca/9moIWmGzdGpO/c9M+h4xXbNjcm2ENHFuL/Ri786A1NPxZglqQh1P+
         +R74uUhKzeAZ5IDctX/hJYnW4NcbPRi1ZzLWDc2yCrNdMgLXKFnNg/KU3QI7rz4e6muZ
         ae2ZlE2/HZkvIjaUDsSBVI8tcVbTL3a7Y4LQtdyIiQ/tlNuDcKyvI8WGRFUVBgNDCDfT
         Z/WA==
X-Forwarded-Encrypted: i=1; AJvYcCXEn1xRQi00T2Zh9QqzlrQm8Va2rHJSg2D9CUEZ1oo9w3GdlwUKh4Bveh372qGBvyqouPoZ9aW9+PQOJg1puXc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzmduImHMKpcqNmN5y7XW5ZEPQvV2wL8T0QfIKMoQUr8J09to1W
	U7o1uh3Gi6IekDmxGuRptVtOv9q7XXtc00vp1Cli3PBQJtczVhh0udzMhjfODcVva9EbiouO5mW
	hDFD1hWMYFfLHM6EPqUzBc62arbDDH+hyw5r5b6iuig==
X-Gm-Gg: AY/fxX53pU7KjdtpuKZoYL5b0w4i2MUay2YP75K5brKQhh0SfpFpZpY7/1paZXGTz1v
	JWBiuinzXdkdjAaZBi4i78DZm+U87ZGoSHcPlyXXV4RwNLB5Ko8Yy3A5nAWPtK+0IBQTLH+mzME
	MeiVV8bJ3HuZeMS2Bs+He/A/4h81DMjxheg/yZBtMvp8pdheYsaxuNf8GlYgc45idHLKy0Wrfv/
	4ntRLxA9L2mZ6IeJlnhSwtbb4G9mINk2JVL3pHcyBFkBnZBrvmCuNNGC96bTL/EHpkj+4Q=
X-Google-Smtp-Source: AGHT+IHGICyU1yvOmr0xoPi/1lm+dEfWhw8D5hRIBtjDc1HDEKvXcCbLHsneu3autrrW0VWbSHW1MKiL7SfK4oVZO0Y=
X-Received: by 2002:a05:7022:f698:b0:119:e56b:c3f5 with SMTP id
 a92af1059eb24-121722eb266mr6940325c88.5.1766417738781; Mon, 22 Dec 2025
 07:35:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251217053455.281509-1-csander@purestorage.com>
 <20251217053455.281509-7-csander@purestorage.com> <aUlZ7APsr7tIdrWq@fedora>
In-Reply-To: <aUlZ7APsr7tIdrWq@fedora>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Mon, 22 Dec 2025 10:35:27 -0500
X-Gm-Features: AQt7F2o_Je621g-5NGH_CCBwQq_vAmviC5zrETLadoCil71GV2D9_Oh8exjccxU
Message-ID: <CADUfDZoW8NBJzRtnVaVF0aXdhW4qhMRijj9bQJqi88uOuswdiw@mail.gmail.com>
Subject: Re: [PATCH 06/20] ublk: support UBLK_PARAM_TYPE_INTEGRITY in device creation
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, Shuah Khan <shuah@kernel.org>, linux-block@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Stanley Zhang <stazhang@purestorage.com>, Uday Shankar <ushankar@purestorage.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 22, 2025 at 9:47=E2=80=AFAM Ming Lei <ming.lei@redhat.com> wrot=
e:
>
> On Tue, Dec 16, 2025 at 10:34:40PM -0700, Caleb Sander Mateos wrote:
> > From: Stanley Zhang <stazhang@purestorage.com>
> >
> > If the UBLK_PARAM_TYPE_INTEGRITY flag is set, validate the integrity
> > parameters and apply them to the blk_integrity limits.
> > UBLK_PARAM_TYPE_INTEGRITY requires CONFIG_BLK_DEV_INTEGRITY=3Dy,
> > UBLK_F_USER_COPY, and metadata_size > 0. Reuse the block metadata ioctl
> > LBMD_PI_CAP_* and LBMD_PI_CSUM_* constants from the linux/fs.h UAPI
> > header for the flags and csum_type field values.
> > The struct ublk_param_integrity validations are based on the checks in
> > blk_validate_integrity_limits(). Any invalid parameters should be
> > rejected before being applied to struct blk_integrity.
> >
> > Signed-off-by: Stanley Zhang <stazhang@purestorage.com>
> > [csander: add param validation]
> > Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
> > ---
> >  drivers/block/ublk_drv.c | 92 +++++++++++++++++++++++++++++++++++++++-
> >  1 file changed, 91 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> > index 4da5d8ff1e1d..2893a9172220 100644
> > --- a/drivers/block/ublk_drv.c
> > +++ b/drivers/block/ublk_drv.c
> > @@ -42,10 +42,12 @@
> >  #include <linux/mm.h>
> >  #include <asm/page.h>
> >  #include <linux/task_work.h>
> >  #include <linux/namei.h>
> >  #include <linux/kref.h>
> > +#include <linux/blk-integrity.h>
> > +#include <uapi/linux/fs.h>
> >  #include <uapi/linux/ublk_cmd.h>
> >
> >  #define UBLK_MINORS          (1U << MINORBITS)
> >
> >  #define UBLK_INVALID_BUF_IDX         ((u16)-1)
> > @@ -81,11 +83,12 @@
> >
> >  /* All UBLK_PARAM_TYPE_* should be included here */
> >  #define UBLK_PARAM_TYPE_ALL                                \
> >       (UBLK_PARAM_TYPE_BASIC | UBLK_PARAM_TYPE_DISCARD | \
> >        UBLK_PARAM_TYPE_DEVT | UBLK_PARAM_TYPE_ZONED |    \
> > -      UBLK_PARAM_TYPE_DMA_ALIGN | UBLK_PARAM_TYPE_SEGMENT)
> > +      UBLK_PARAM_TYPE_DMA_ALIGN | UBLK_PARAM_TYPE_SEGMENT | \
> > +      UBLK_PARAM_TYPE_INTEGRITY)
> >
> >  struct ublk_uring_cmd_pdu {
> >       /*
> >        * Store requests in same batch temporarily for queuing them to
> >        * daemon context.
> > @@ -613,10 +616,57 @@ static void ublk_dev_param_basic_apply(struct ubl=
k_device *ub)
> >               set_disk_ro(ub->ub_disk, true);
> >
> >       set_capacity(ub->ub_disk, p->dev_sectors);
> >  }
> >
> > +static int ublk_integrity_flags(u32 flags)
> > +{
> > +     int ret_flags =3D 0;
> > +
> > +     if (flags & LBMD_PI_CAP_INTEGRITY) {
> > +             flags &=3D ~LBMD_PI_CAP_INTEGRITY;
> > +             ret_flags |=3D BLK_INTEGRITY_DEVICE_CAPABLE;
> > +     }
> > +     if (flags & LBMD_PI_CAP_REFTAG) {
> > +             flags &=3D ~LBMD_PI_CAP_REFTAG;
> > +             ret_flags |=3D BLK_INTEGRITY_REF_TAG;
> > +     }
> > +     return flags ? -EINVAL : ret_flags;
> > +}
> > +
> > +static int ublk_integrity_pi_tuple_size(u8 csum_type)
> > +{
> > +     switch (csum_type) {
> > +     case LBMD_PI_CSUM_NONE:
> > +             return 0;
> > +     case LBMD_PI_CSUM_IP:
> > +     case LBMD_PI_CSUM_CRC16_T10DIF:
> > +             return 8;
> > +     case LBMD_PI_CSUM_CRC64_NVME:
> > +             return 16;
> > +     default:
> > +             return -EINVAL;
> > +     }
> > +}
> > +
> > +static enum blk_integrity_checksum ublk_integrity_csum_type(u8 csum_ty=
pe)
> > +{
> > +     switch (csum_type) {
> > +     case LBMD_PI_CSUM_NONE:
> > +             return BLK_INTEGRITY_CSUM_NONE;
> > +     case LBMD_PI_CSUM_IP:
> > +             return BLK_INTEGRITY_CSUM_IP;
> > +     case LBMD_PI_CSUM_CRC16_T10DIF:
> > +             return BLK_INTEGRITY_CSUM_CRC;
> > +     case LBMD_PI_CSUM_CRC64_NVME:
> > +             return BLK_INTEGRITY_CSUM_CRC64;
> > +     default:
> > +             WARN_ON_ONCE(1);
> > +             return BLK_INTEGRITY_CSUM_NONE;
> > +     }
> > +}
> > +
> >  static int ublk_validate_params(const struct ublk_device *ub)
> >  {
> >       /* basic param is the only one which must be set */
> >       if (ub->params.types & UBLK_PARAM_TYPE_BASIC) {
> >               const struct ublk_param_basic *p =3D &ub->params.basic;
> > @@ -675,10 +725,35 @@ static int ublk_validate_params(const struct ublk=
_device *ub)
> >                       return -EINVAL;
> >               if (p->max_segment_size < UBLK_MIN_SEGMENT_SIZE)
> >                       return -EINVAL;
> >       }
> >
> > +     if (ub->params.types & UBLK_PARAM_TYPE_INTEGRITY) {
> > +             const struct ublk_param_integrity *p =3D &ub->params.inte=
grity;
> > +             int pi_tuple_size =3D ublk_integrity_pi_tuple_size(p->csu=
m_type);
> > +             int flags =3D ublk_integrity_flags(p->flags);
> > +
> > +             if (!IS_ENABLED(CONFIG_BLK_DEV_INTEGRITY))
> > +                     return -EINVAL;
> > +             if (!ublk_dev_support_user_copy(ub))
> > +                     return -EINVAL;
>
> UBLK_IO_F_INTEGRITY should be checked here, and ublk_dev_support_user_cop=
y() can be
> validated with UBLK_IO_F_INTEGRITY together in ublk_ctrl_add_dev(), so
> mis-matched features can be failed earlier.

I'm not sure what you mean. UBLK_IO_F_INTEGRITY is a per-I/O flag set
in struct ublksrv_io_desc's op_flags field. Are you suggesting adding
a separate feature flag for integrity? I can do that, but I didn't
originally because none of the other UBLK_PARAM_TYPE_* flags have
associated features.

>
> Same for IS_ENABLED(CONFIG_BLK_DEV_INTEGRITY).
>
> > +             if (flags < 0)
> > +                     return flags;
> > +             if (pi_tuple_size < 0)
> > +                     return pi_tuple_size;
> > +             if (!p->metadata_size)
> > +                     return -EINVAL;
>
> blk_validate_integrity_limits() allows zero p->metadata_size with
> LBMD_PI_CSUM_NONE, maybe document ublk's support for zero metadata_size &=
 LBMD_PI_CSUM_NONE?

Sure, I can mention that UBLK_PARAM_TYPE_INTEGRITY requires a nonzero
metadata size. Would you prefer that metadata_size =3D=3D 0 be supported?
It would be a bit more code, but certainly possible.

Thanks,
Caleb

