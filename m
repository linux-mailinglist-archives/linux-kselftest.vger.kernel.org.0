Return-Path: <linux-kselftest+bounces-47903-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F3C0CD7C55
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Dec 2025 02:58:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 864E8300BF89
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Dec 2025 01:58:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DC69274B5F;
	Tue, 23 Dec 2025 01:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P2RYoD5z"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B76F826FA50
	for <linux-kselftest@vger.kernel.org>; Tue, 23 Dec 2025 01:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766455119; cv=none; b=AFc9x9tgj+IH5a7aYBkldIj4IAtCCTy2qhF/sTwtAZlgzlnESB6OzOLqXYeAZyG5So9xf58INZUb8IlmKWino7QDfA0dShhE+v30RZaZxdkIHFwIf6BQFgQcTMVNUAuLEwiKuFmJETBLvw0+IfA/fEuP7T+nHPvgJfcwlQOHBmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766455119; c=relaxed/simple;
	bh=vzHUnLQ+yxGWtXH7nJn1uJLvOBgknSPTdP82hXl2FaU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gWVzB8Ca1I5D4merBSeFubaV96jnEoqvRD06SroHsngSI+Rug3ykb4oYvZ4kidxMj4Idv92MATJYjC27D3aBoSVltAp9m9oXd9iJAZypMN7rA6CzWAtNW04+RobbbNXHq1tR/gm6Yf6Ud0CnDDWCF4fZYyEpcQUNT11aoiDlAP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=P2RYoD5z; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1766455116;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wbHdy8jdrd9e77NvpwF/dSYZtO3xRPA/0ecEDbzD7kI=;
	b=P2RYoD5zporR2qa/kCOCv4yX6lKAIHK6erojAtit4l5M5jOPmB0qKYoYYhVwQFf9MOZggO
	qqc97Yis7WovpT0TxkNY1fn6E+hr8y3NPvJoMDP+4jembL7Z27EMpMOzn8wLLnWrQQ3iwW
	m8TjMHTBMXi+UKsprCKPlpPt4qaDJwM=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-688-Ra5iqk38OaCkOKxpbkkhOg-1; Mon,
 22 Dec 2025 20:58:30 -0500
X-MC-Unique: Ra5iqk38OaCkOKxpbkkhOg-1
X-Mimecast-MFC-AGG-ID: Ra5iqk38OaCkOKxpbkkhOg_1766455109
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 58FB91956054;
	Tue, 23 Dec 2025 01:58:29 +0000 (UTC)
Received: from fedora (unknown [10.72.116.97])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8684E180066E;
	Tue, 23 Dec 2025 01:58:24 +0000 (UTC)
Date: Tue, 23 Dec 2025 09:58:19 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Jens Axboe <axboe@kernel.dk>, Shuah Khan <shuah@kernel.org>,
	linux-block@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Stanley Zhang <stazhang@purestorage.com>,
	Uday Shankar <ushankar@purestorage.com>
Subject: Re: [PATCH 06/20] ublk: support UBLK_PARAM_TYPE_INTEGRITY in device
 creation
Message-ID: <aUn3O2RJtXOpNkyQ@fedora>
References: <20251217053455.281509-1-csander@purestorage.com>
 <20251217053455.281509-7-csander@purestorage.com>
 <aUlZ7APsr7tIdrWq@fedora>
 <CADUfDZoW8NBJzRtnVaVF0aXdhW4qhMRijj9bQJqi88uOuswdiw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADUfDZoW8NBJzRtnVaVF0aXdhW4qhMRijj9bQJqi88uOuswdiw@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

On Mon, Dec 22, 2025 at 10:35:27AM -0500, Caleb Sander Mateos wrote:
> On Mon, Dec 22, 2025 at 9:47 AM Ming Lei <ming.lei@redhat.com> wrote:
> >
> > On Tue, Dec 16, 2025 at 10:34:40PM -0700, Caleb Sander Mateos wrote:
> > > From: Stanley Zhang <stazhang@purestorage.com>
> > >
> > > If the UBLK_PARAM_TYPE_INTEGRITY flag is set, validate the integrity
> > > parameters and apply them to the blk_integrity limits.
> > > UBLK_PARAM_TYPE_INTEGRITY requires CONFIG_BLK_DEV_INTEGRITY=y,
> > > UBLK_F_USER_COPY, and metadata_size > 0. Reuse the block metadata ioctl
> > > LBMD_PI_CAP_* and LBMD_PI_CSUM_* constants from the linux/fs.h UAPI
> > > header for the flags and csum_type field values.
> > > The struct ublk_param_integrity validations are based on the checks in
> > > blk_validate_integrity_limits(). Any invalid parameters should be
> > > rejected before being applied to struct blk_integrity.
> > >
> > > Signed-off-by: Stanley Zhang <stazhang@purestorage.com>
> > > [csander: add param validation]
> > > Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
> > > ---
> > >  drivers/block/ublk_drv.c | 92 +++++++++++++++++++++++++++++++++++++++-
> > >  1 file changed, 91 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> > > index 4da5d8ff1e1d..2893a9172220 100644
> > > --- a/drivers/block/ublk_drv.c
> > > +++ b/drivers/block/ublk_drv.c
> > > @@ -42,10 +42,12 @@
> > >  #include <linux/mm.h>
> > >  #include <asm/page.h>
> > >  #include <linux/task_work.h>
> > >  #include <linux/namei.h>
> > >  #include <linux/kref.h>
> > > +#include <linux/blk-integrity.h>
> > > +#include <uapi/linux/fs.h>
> > >  #include <uapi/linux/ublk_cmd.h>
> > >
> > >  #define UBLK_MINORS          (1U << MINORBITS)
> > >
> > >  #define UBLK_INVALID_BUF_IDX         ((u16)-1)
> > > @@ -81,11 +83,12 @@
> > >
> > >  /* All UBLK_PARAM_TYPE_* should be included here */
> > >  #define UBLK_PARAM_TYPE_ALL                                \
> > >       (UBLK_PARAM_TYPE_BASIC | UBLK_PARAM_TYPE_DISCARD | \
> > >        UBLK_PARAM_TYPE_DEVT | UBLK_PARAM_TYPE_ZONED |    \
> > > -      UBLK_PARAM_TYPE_DMA_ALIGN | UBLK_PARAM_TYPE_SEGMENT)
> > > +      UBLK_PARAM_TYPE_DMA_ALIGN | UBLK_PARAM_TYPE_SEGMENT | \
> > > +      UBLK_PARAM_TYPE_INTEGRITY)
> > >
> > >  struct ublk_uring_cmd_pdu {
> > >       /*
> > >        * Store requests in same batch temporarily for queuing them to
> > >        * daemon context.
> > > @@ -613,10 +616,57 @@ static void ublk_dev_param_basic_apply(struct ublk_device *ub)
> > >               set_disk_ro(ub->ub_disk, true);
> > >
> > >       set_capacity(ub->ub_disk, p->dev_sectors);
> > >  }
> > >
> > > +static int ublk_integrity_flags(u32 flags)
> > > +{
> > > +     int ret_flags = 0;
> > > +
> > > +     if (flags & LBMD_PI_CAP_INTEGRITY) {
> > > +             flags &= ~LBMD_PI_CAP_INTEGRITY;
> > > +             ret_flags |= BLK_INTEGRITY_DEVICE_CAPABLE;
> > > +     }
> > > +     if (flags & LBMD_PI_CAP_REFTAG) {
> > > +             flags &= ~LBMD_PI_CAP_REFTAG;
> > > +             ret_flags |= BLK_INTEGRITY_REF_TAG;
> > > +     }
> > > +     return flags ? -EINVAL : ret_flags;
> > > +}
> > > +
> > > +static int ublk_integrity_pi_tuple_size(u8 csum_type)
> > > +{
> > > +     switch (csum_type) {
> > > +     case LBMD_PI_CSUM_NONE:
> > > +             return 0;
> > > +     case LBMD_PI_CSUM_IP:
> > > +     case LBMD_PI_CSUM_CRC16_T10DIF:
> > > +             return 8;
> > > +     case LBMD_PI_CSUM_CRC64_NVME:
> > > +             return 16;
> > > +     default:
> > > +             return -EINVAL;
> > > +     }
> > > +}
> > > +
> > > +static enum blk_integrity_checksum ublk_integrity_csum_type(u8 csum_type)
> > > +{
> > > +     switch (csum_type) {
> > > +     case LBMD_PI_CSUM_NONE:
> > > +             return BLK_INTEGRITY_CSUM_NONE;
> > > +     case LBMD_PI_CSUM_IP:
> > > +             return BLK_INTEGRITY_CSUM_IP;
> > > +     case LBMD_PI_CSUM_CRC16_T10DIF:
> > > +             return BLK_INTEGRITY_CSUM_CRC;
> > > +     case LBMD_PI_CSUM_CRC64_NVME:
> > > +             return BLK_INTEGRITY_CSUM_CRC64;
> > > +     default:
> > > +             WARN_ON_ONCE(1);
> > > +             return BLK_INTEGRITY_CSUM_NONE;
> > > +     }
> > > +}
> > > +
> > >  static int ublk_validate_params(const struct ublk_device *ub)
> > >  {
> > >       /* basic param is the only one which must be set */
> > >       if (ub->params.types & UBLK_PARAM_TYPE_BASIC) {
> > >               const struct ublk_param_basic *p = &ub->params.basic;
> > > @@ -675,10 +725,35 @@ static int ublk_validate_params(const struct ublk_device *ub)
> > >                       return -EINVAL;
> > >               if (p->max_segment_size < UBLK_MIN_SEGMENT_SIZE)
> > >                       return -EINVAL;
> > >       }
> > >
> > > +     if (ub->params.types & UBLK_PARAM_TYPE_INTEGRITY) {
> > > +             const struct ublk_param_integrity *p = &ub->params.integrity;
> > > +             int pi_tuple_size = ublk_integrity_pi_tuple_size(p->csum_type);
> > > +             int flags = ublk_integrity_flags(p->flags);
> > > +
> > > +             if (!IS_ENABLED(CONFIG_BLK_DEV_INTEGRITY))
> > > +                     return -EINVAL;
> > > +             if (!ublk_dev_support_user_copy(ub))
> > > +                     return -EINVAL;
> >
> > UBLK_IO_F_INTEGRITY should be checked here, and ublk_dev_support_user_copy() can be
> > validated with UBLK_IO_F_INTEGRITY together in ublk_ctrl_add_dev(), so
> > mis-matched features can be failed earlier.
> 
> I'm not sure what you mean. UBLK_IO_F_INTEGRITY is a per-I/O flag set

I misread it as feature flag of `UBLK_F_INTEGRITY`...

> in struct ublksrv_io_desc's op_flags field. Are you suggesting adding
> a separate feature flag for integrity? I can do that, but I didn't
> originally because none of the other UBLK_PARAM_TYPE_* flags have
> associated features.

oops, you don't define feature flag of UBLK_F_INTEGRITY, then how can
userspace know UBLK INTEGRITY is supported by driver?

With UBLK_F_INTEGRITY you can run early check in ublk_ctrl_add_dev() for:

- dependency on user copy
- if kernel enables CONFIG_BLK_DEV_INTEGRITY

> 
> >
> > Same for IS_ENABLED(CONFIG_BLK_DEV_INTEGRITY).
> >
> > > +             if (flags < 0)
> > > +                     return flags;
> > > +             if (pi_tuple_size < 0)
> > > +                     return pi_tuple_size;
> > > +             if (!p->metadata_size)
> > > +                     return -EINVAL;
> >
> > blk_validate_integrity_limits() allows zero p->metadata_size with
> > LBMD_PI_CSUM_NONE, maybe document ublk's support for zero metadata_size & LBMD_PI_CSUM_NONE?
> 
> Sure, I can mention that UBLK_PARAM_TYPE_INTEGRITY requires a nonzero
> metadata size. Would you prefer that metadata_size == 0 be supported?
> It would be a bit more code, but certainly possible.

It can be started with less feature/functions, and can be extended in future.


Thanks,
Ming


