Return-Path: <linux-kselftest+bounces-48364-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C996CFBB4D
	for <lists+linux-kselftest@lfdr.de>; Wed, 07 Jan 2026 03:24:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id ACB0B30A566A
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Jan 2026 02:20:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB8A923EAB4;
	Wed,  7 Jan 2026 02:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="dIFwD0tP"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-dl1-f41.google.com (mail-dl1-f41.google.com [74.125.82.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F46823AE87
	for <linux-kselftest@vger.kernel.org>; Wed,  7 Jan 2026 02:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767752417; cv=none; b=qhSku+uiOI6po2W6pg31fjky6wEqZxeZRlXeo2QKnCnm1GyPRxCXIttpnATNTj5YFyMpThFc1IrU1ZacLbbqGKgS4Tpgm+/T3pJDtsytaFCBd9R58PYREnczmnHm8NkviphijymkfO+ThbQaXFH4jw8aGvJve3tEmkE9tQYWvWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767752417; c=relaxed/simple;
	bh=AvddBUkPBSH0wJa5YIhAZhCUPkBMQMiLHhQKdPJqWPM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M9pBaiFeOIQplmz1e+jcu47wJFbz2/EP5WQzMBwzyQED7aTRt27uZ1ehw0OxqFUza57FP7ZrZQYwjkSY4/ES4C8Lepihwx4sdXsATPpHSN7JeL0He6wRgIoc9580yt/OlzyoD1d82ziCdjJBNevPxiZCZBShRlDIpP9A+hduMZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=dIFwD0tP; arc=none smtp.client-ip=74.125.82.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-dl1-f41.google.com with SMTP id a92af1059eb24-11f0d900dc4so49554c88.1
        for <linux-kselftest@vger.kernel.org>; Tue, 06 Jan 2026 18:20:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1767752414; x=1768357214; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nH/6zmQeVoutdpdBWxorB62PgSFMjPmFsHzqI05ISfE=;
        b=dIFwD0tPTRvw0LRGHNRIrnUWbIibGWwGU+aDnkHopNyvuCQXnvabRaLIercGHrB45s
         aDLWrgTWch43I6fgChaPEKS8TH9w+5mqn0YDL8ClkeQIRz9xLl8e2+dks90uEMvNxPu6
         KdbxnVeOgeCgWEdl10OhMiopbFaHspJmz4i5y5NYef56VTt8G9NnZ0umJGjvKo7Yn+15
         pCOc89uqRPTBsjkAMJsiVv8gmn/P875whRujX1hbDx7jYte/ictKHcfxUp6zhdsN0eH1
         gsGUAcPdXDpeRutB65B80IyO0/xt8VmVku50JgjfYVKHDurASG1db92BB/lmrKDDjPLE
         rWLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767752414; x=1768357214;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nH/6zmQeVoutdpdBWxorB62PgSFMjPmFsHzqI05ISfE=;
        b=uI8UJR/0/kdP1iMEbxlK9SOhYGlave5KIY+qmiQ++y8gWcTZ+ja85LhkVnN+Wl1pGS
         ZoFKRQmQ2bKgq3vj8iIie07dL/Eskm9rWQOVuN3zooDEfUIJ9pwB2j6dvOVoIPyCE3bw
         K2F1Z6ijoPJcsVvpHhQ383UqpOVFsSnF2VCq0nvskjDLO7PunYdGn+V6Mc27cJTihiZQ
         byuVu6FQZkh2AB2tXa/SA1Lku4amD26jQxUsd0Fnw7UGato2vy9p+nu7j14pNkKkAgWK
         Ak/3NAFujphVUG5eet9IAve9YtYsnAOc35OkAgKBQhO7RZBrLXArENk2IvrPKwzKxzSY
         BLiA==
X-Forwarded-Encrypted: i=1; AJvYcCXOrit5uXKmoxN3UEqMh6zGRxUDFIY1bOL5hHmYxUWGLz0u2TgcNsPoR7I6FfqQzpcKBqAozEZriVX+fn1Wk9Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7wv2CYZ2UaGdOxf4/LvC7vLVkoL6oKiVynycUT5sw1Rzqkpdc
	600qDfEa8VLvlf5RcR62oMOE4yxHXNs0ovJJArG4gTUHmo5ehuKGgLlRt7nmgQ6OScYW7ommZt3
	SCx2ugI/vMUHSqTwBj6V5Z/9pdbN+sGaYBsrhoVuuWA==
X-Gm-Gg: AY/fxX6fh6q2dea0Ee//7vVOyManKPFQMHk3DqTdfu51ziJnI7I7QxvMQodJZxHKEwO
	EyU8G+tTclTjqEDjSq0YIOKgRmYBDYC6xcWIfg0sPDw7P07CPLh/N4ttjoaozThS0SYTyNrl+2S
	QVqT0cV/gEGmZ4N+trbz2bxPERZQ/IvitFxaouy25f9DyxpcT9TSEE57Amq9IIPFUWHX3HIsl5V
	TBpO6acJ4AFcwqhEEiQc8nvngCAZlnrJC+0fz88vpD4KAOxmF3f6k+4dQcPIMj9IjsJUqHt
X-Google-Smtp-Source: AGHT+IHC8t2aAq/Ljug6rAjg7bb6O7srippWKn6q4BpZL9+Yj1Xf627/ee+f2KrLxWJraZVZtjcFRMx9b1Rde/vyuxo=
X-Received: by 2002:a05:7022:6723:b0:11a:2020:ac85 with SMTP id
 a92af1059eb24-121f8b7d702mr473887c88.4.1767752414196; Tue, 06 Jan 2026
 18:20:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260106005752.3784925-1-csander@purestorage.com>
 <20260106005752.3784925-4-csander@purestorage.com> <aV0Jd76i9Iru8Ge9@fedora>
 <CADUfDZpwRQv0yghG7S4ugNGc4X_b5bC=Za=+M-D36J5T46w64g@mail.gmail.com> <aV2lhCLzISL0J-vH@fedora>
In-Reply-To: <aV2lhCLzISL0J-vH@fedora>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Tue, 6 Jan 2026 18:20:02 -0800
X-Gm-Features: AQt7F2qWffftyT8OFORSaC1s-VMlzDnF8S4pvHy-j5UaHH9mqqU-p1cc60dk88I
Message-ID: <CADUfDZp-g+Juy0TkksWCMTy6Q8kjPQFhzs2X2MpcZvWz3N1rLw@mail.gmail.com>
Subject: Re: [PATCH v3 03/19] ublk: support UBLK_PARAM_TYPE_INTEGRITY in
 device creation
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, Shuah Khan <shuah@kernel.org>, linux-block@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Stanley Zhang <stazhang@purestorage.com>, Uday Shankar <ushankar@purestorage.com>, 
	"Martin K . Petersen" <martin.petersen@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 6, 2026 at 4:15=E2=80=AFPM Ming Lei <ming.lei@redhat.com> wrote=
:
>
> On Tue, Jan 06, 2026 at 08:32:08AM -0800, Caleb Sander Mateos wrote:
> > On Tue, Jan 6, 2026 at 5:09=E2=80=AFAM Ming Lei <ming.lei@redhat.com> w=
rote:
> > >
> > > On Mon, Jan 05, 2026 at 05:57:35PM -0700, Caleb Sander Mateos wrote:
> > > > From: Stanley Zhang <stazhang@purestorage.com>
> > > >
> > > > Add a feature flag UBLK_F_INTEGRITY for a ublk server to request
> > > > integrity/metadata support when creating a ublk device. The ublk se=
rver
> > > > can also check for the feature flag on the created device or the re=
sult
> > > > of UBLK_U_CMD_GET_FEATURES to tell if the ublk driver supports it.
> > > > UBLK_F_INTEGRITY requires UBLK_F_USER_COPY, as user copy is the onl=
y
> > > > data copy mode initially supported for integrity data.
> > > > Add UBLK_PARAM_TYPE_INTEGRITY and struct ublk_param_integrity to st=
ruct
> > > > ublk_params to specify the integrity params of a ublk device.
> > > > UBLK_PARAM_TYPE_INTEGRITY requires UBLK_F_INTEGRITY and a nonzero
> > > > metadata_size. The LBMD_PI_CAP_* and LBMD_PI_CSUM_* values from the
> > > > linux/fs.h UAPI header are used for the flags and csum_type fields.
> > > > If the UBLK_PARAM_TYPE_INTEGRITY flag is set, validate the integrit=
y
> > > > parameters and apply them to the blk_integrity limits.
> > > > The struct ublk_param_integrity validations are based on the checks=
 in
> > > > blk_validate_integrity_limits(). Any invalid parameters should be
> > > > rejected before being applied to struct blk_integrity.
> > > >
> > > > Signed-off-by: Stanley Zhang <stazhang@purestorage.com>
> > > > [csander: drop redundant pi_tuple_size field, use block metadata UA=
PI
> > > >  constants, add param validation]
> > > > Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
> > > > ---
> > > >  drivers/block/ublk_drv.c      | 94 +++++++++++++++++++++++++++++++=
+++-
> > > >  include/uapi/linux/ublk_cmd.h | 18 +++++++
> > > >  2 files changed, 111 insertions(+), 1 deletion(-)
> > > >
> > > > diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> > > > index 8e3da9b2b93a..066c6ae062a0 100644
> > > > --- a/drivers/block/ublk_drv.c
> > > > +++ b/drivers/block/ublk_drv.c
> > > > @@ -42,10 +42,12 @@
> > > >  #include <linux/mm.h>
> > > >  #include <asm/page.h>
> > > >  #include <linux/task_work.h>
> > > >  #include <linux/namei.h>
> > > >  #include <linux/kref.h>
> > > > +#include <linux/blk-integrity.h>
> > > > +#include <uapi/linux/fs.h>
> > > >  #include <uapi/linux/ublk_cmd.h>
> > > >
> > > >  #define UBLK_MINORS          (1U << MINORBITS)
> > > >
> > > >  #define UBLK_INVALID_BUF_IDX         ((u16)-1)
> > > > @@ -81,11 +83,12 @@
> > > >
> > > >  /* All UBLK_PARAM_TYPE_* should be included here */
> > > >  #define UBLK_PARAM_TYPE_ALL                                \
> > > >       (UBLK_PARAM_TYPE_BASIC | UBLK_PARAM_TYPE_DISCARD | \
> > > >        UBLK_PARAM_TYPE_DEVT | UBLK_PARAM_TYPE_ZONED |    \
> > > > -      UBLK_PARAM_TYPE_DMA_ALIGN | UBLK_PARAM_TYPE_SEGMENT)
> > > > +      UBLK_PARAM_TYPE_DMA_ALIGN | UBLK_PARAM_TYPE_SEGMENT | \
> > > > +      UBLK_PARAM_TYPE_INTEGRITY)
> > > >
> > > >  struct ublk_uring_cmd_pdu {
> > > >       /*
> > > >        * Store requests in same batch temporarily for queuing them =
to
> > > >        * daemon context.
> > > > @@ -628,10 +631,57 @@ static void ublk_dev_param_basic_apply(struct=
 ublk_device *ub)
> > > >               set_disk_ro(ub->ub_disk, true);
> > > >
> > > >       set_capacity(ub->ub_disk, p->dev_sectors);
> > > >  }
> > > >
> > > > +static int ublk_integrity_flags(u32 flags)
> > > > +{
> > > > +     int ret_flags =3D 0;
> > > > +
> > > > +     if (flags & LBMD_PI_CAP_INTEGRITY) {
> > > > +             flags &=3D ~LBMD_PI_CAP_INTEGRITY;
> > > > +             ret_flags |=3D BLK_INTEGRITY_DEVICE_CAPABLE;
> > > > +     }
> > > > +     if (flags & LBMD_PI_CAP_REFTAG) {
> > > > +             flags &=3D ~LBMD_PI_CAP_REFTAG;
> > > > +             ret_flags |=3D BLK_INTEGRITY_REF_TAG;
> > > > +     }
> > > > +     return flags ? -EINVAL : ret_flags;
> > > > +}
> > > > +
> > > > +static int ublk_integrity_pi_tuple_size(u8 csum_type)
> > > > +{
> > > > +     switch (csum_type) {
> > > > +     case LBMD_PI_CSUM_NONE:
> > > > +             return 0;
> > > > +     case LBMD_PI_CSUM_IP:
> > > > +     case LBMD_PI_CSUM_CRC16_T10DIF:
> > > > +             return 8;
> > > > +     case LBMD_PI_CSUM_CRC64_NVME:
> > > > +             return 16;
> > > > +     default:
> > > > +             return -EINVAL;
> > > > +     }
> > > > +}
> > > > +
> > > > +static enum blk_integrity_checksum ublk_integrity_csum_type(u8 csu=
m_type)
> > > > +{
> > > > +     switch (csum_type) {
> > > > +     case LBMD_PI_CSUM_NONE:
> > > > +             return BLK_INTEGRITY_CSUM_NONE;
> > > > +     case LBMD_PI_CSUM_IP:
> > > > +             return BLK_INTEGRITY_CSUM_IP;
> > > > +     case LBMD_PI_CSUM_CRC16_T10DIF:
> > > > +             return BLK_INTEGRITY_CSUM_CRC;
> > > > +     case LBMD_PI_CSUM_CRC64_NVME:
> > > > +             return BLK_INTEGRITY_CSUM_CRC64;
> > > > +     default:
> > > > +             WARN_ON_ONCE(1);
> > > > +             return BLK_INTEGRITY_CSUM_NONE;
> > > > +     }
> > > > +}
> > > > +
> > > >  static int ublk_validate_params(const struct ublk_device *ub)
> > > >  {
> > > >       /* basic param is the only one which must be set */
> > > >       if (ub->params.types & UBLK_PARAM_TYPE_BASIC) {
> > > >               const struct ublk_param_basic *p =3D &ub->params.basi=
c;
> > > > @@ -690,10 +740,33 @@ static int ublk_validate_params(const struct =
ublk_device *ub)
> > > >                       return -EINVAL;
> > > >               if (p->max_segment_size < UBLK_MIN_SEGMENT_SIZE)
> > > >                       return -EINVAL;
> > > >       }
> > > >
> > > > +     if (ub->params.types & UBLK_PARAM_TYPE_INTEGRITY) {
> > > > +             const struct ublk_param_integrity *p =3D &ub->params.=
integrity;
> > > > +             int pi_tuple_size =3D ublk_integrity_pi_tuple_size(p-=
>csum_type);
> > > > +             int flags =3D ublk_integrity_flags(p->flags);
> > > > +
> > > > +             if (!(ub->dev_info.flags & UBLK_F_INTEGRITY))
> > > > +                     return -EINVAL;
> > > > +             if (flags < 0)
> > > > +                     return flags;
> > > > +             if (pi_tuple_size < 0)
> > > > +                     return pi_tuple_size;
> > > > +             if (!p->metadata_size)
> > > > +                     return -EINVAL;
> > > > +             if (p->csum_type =3D=3D LBMD_PI_CSUM_NONE &&
> > > > +                 p->flags & LBMD_PI_CAP_REFTAG)
> > > > +                     return -EINVAL;
> > > > +             if (p->pi_offset + pi_tuple_size > p->metadata_size)
> > > > +                     return -EINVAL;
> > > > +             if (p->interval_exp < SECTOR_SHIFT ||
> > > > +                 p->interval_exp > ub->params.basic.logical_bs_shi=
ft)
> > > > +                     return -EINVAL;
> > > > +     }
> > > > +
> > > >       return 0;
> > > >  }
> > > >
> > > >  static void ublk_apply_params(struct ublk_device *ub)
> > > >  {
> > > > @@ -2941,10 +3014,25 @@ static int ublk_ctrl_start_dev(struct ublk_=
device *ub,
> > > >               lim.seg_boundary_mask =3D ub->params.seg.seg_boundary=
_mask;
> > > >               lim.max_segment_size =3D ub->params.seg.max_segment_s=
ize;
> > > >               lim.max_segments =3D ub->params.seg.max_segments;
> > > >       }
> > > >
> > > > +     if (ub->params.types & UBLK_PARAM_TYPE_INTEGRITY) {
> > > > +             const struct ublk_param_integrity *p =3D &ub->params.=
integrity;
> > > > +             int pi_tuple_size =3D ublk_integrity_pi_tuple_size(p-=
>csum_type);
> > > > +
> > > > +             lim.integrity =3D (struct blk_integrity) {
> > > > +                     .flags =3D ublk_integrity_flags(p->flags),
> > > > +                     .csum_type =3D ublk_integrity_csum_type(p->cs=
um_type),
> > > > +                     .metadata_size =3D p->metadata_size,
> > > > +                     .pi_offset =3D p->pi_offset,
> > > > +                     .interval_exp =3D p->interval_exp,
> > > > +                     .tag_size =3D p->tag_size,
> > > > +                     .pi_tuple_size =3D pi_tuple_size,
> > > > +             };
> > > > +     }
> > > > +
> > > >       if (wait_for_completion_interruptible(&ub->completion) !=3D 0=
)
> > > >               return -EINTR;
> > > >
> > > >       if (ub->ublksrv_tgid !=3D ublksrv_pid)
> > > >               return -EINVAL;
> > > > @@ -3131,10 +3219,14 @@ static int ublk_ctrl_add_dev(const struct u=
blksrv_ctrl_cmd *header)
> > > >               if (info.flags & (UBLK_F_USER_COPY | UBLK_F_SUPPORT_Z=
ERO_COPY |
> > > >                                       UBLK_F_AUTO_BUF_REG))
> > > >                       return -EINVAL;
> > > >       }
> > > >
> > > > +     /* User copy is required to access integrity buffer */
> > > > +     if (info.flags & UBLK_F_INTEGRITY && !(info.flags & UBLK_F_US=
ER_COPY))
> > > > +             return -EINVAL;
> > > > +
> > > >       /* the created device is always owned by current user */
> > > >       ublk_store_owner_uid_gid(&info.owner_uid, &info.owner_gid);
> > > >
> > > >       if (header->dev_id !=3D info.dev_id) {
> > > >               pr_warn("%s: dev id not match %u %u\n",
> > > > diff --git a/include/uapi/linux/ublk_cmd.h b/include/uapi/linux/ubl=
k_cmd.h
> > > > index ec77dabba45b..a54c47832fa2 100644
> > > > --- a/include/uapi/linux/ublk_cmd.h
> > > > +++ b/include/uapi/linux/ublk_cmd.h
> > > > @@ -309,10 +309,16 @@
> > > >   * the I/O's daemon task. The q_id and tag of the registered buffe=
r are required
> > > >   * in UBLK_U_IO_UNREGISTER_IO_BUF's ublksrv_io_cmd.
> > > >   */
> > > >  #define UBLK_F_BUF_REG_OFF_DAEMON (1ULL << 14)
> > > >
> > > > +/*
> > > > + * ublk device supports requests with integrity/metadata buffer.
> > > > + * Requires UBLK_F_USER_COPY.
> > > > + */
> > > > +#define UBLK_F_INTEGRITY (1ULL << 16)
> > > > +
> > > >  /* device state */
> > > >  #define UBLK_S_DEV_DEAD      0
> > > >  #define UBLK_S_DEV_LIVE      1
> > > >  #define UBLK_S_DEV_QUIESCED  2
> > > >  #define UBLK_S_DEV_FAIL_IO   3
> > > > @@ -598,10 +604,20 @@ struct ublk_param_segment {
> > > >       __u32   max_segment_size;
> > > >       __u16   max_segments;
> > > >       __u8    pad[2];
> > > >  };
> > > >
> > > > +struct ublk_param_integrity {
> > > > +     __u32   flags; /* LBMD_PI_CAP_* from linux/fs.h */
> > > > +     __u8    interval_exp;
> > > > +     __u8    metadata_size; /* UBLK_PARAM_TYPE_INTEGRITY requires =
nonzero */
> > > > +     __u8    pi_offset;
> > > > +     __u8    csum_type; /* LBMD_PI_CSUM_* from linux/fs.h */
> > > > +     __u8    tag_size;
> > > > +     __u8    pad[7];
> > > > +};
> > >
> > > Looks max_integrity_segments is missed, otherwise this patch is fine =
for me.
> >
> > My thinking was that there isn't any reason why a ublk server would
> > need to limit the number of integrity segments. The request integrity
> > segments aren't directly exposed to the ublk server through user copy.
> > And since zero copy isn't supported for integrity data, there's no
> > concern about needing to align the ublk integrity limits with the
> > backing device limits. What do you think?
>
> Yeah, it isn't needed in current implementation, but things may change in
> future.
>
> How about adding it(__u16) to `ublk_param_integrity`? And document it is =
ignored for
> user-copy based implementation. It is usually part of HW/SW interface wrt=
. PI.

Okay, may as well just plumb it through to the queue_limits then.

Best,
Caleb

