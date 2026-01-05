Return-Path: <linux-kselftest+bounces-48219-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AFCB9CF4D87
	for <lists+linux-kselftest@lfdr.de>; Mon, 05 Jan 2026 17:57:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 019A9327C1BB
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 Jan 2026 16:46:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B993733032E;
	Mon,  5 Jan 2026 16:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="dgiBx5Bl"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58E672F9C3D
	for <linux-kselftest@vger.kernel.org>; Mon,  5 Jan 2026 16:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767631503; cv=none; b=QJKG+J2Ks+zizpWb/ONxEk9beFqdlxIfltVlyug7757j+Ok4RS13XSI9nrnQ7wEOf6Lb393eBKjuGW/o2FlrH+Y3DxBnO3XQ/hZG1S+dqMXWD3v11e+Kt7h7D3vFOKtRji6SIgbKipmlrL54iC/PDJWC9CJNcbF7dJyUB+Aa9Qw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767631503; c=relaxed/simple;
	bh=q3oBIJBCKsgETtCPP1VXg2X9fdRdjcqRRDj8EfShKmg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=st80FA/d03LecGVxdy8lCfNeiGi7lll/YPVA5/A1jW1qvSvOGb+PKEbszOuLSJhvCWYk8sPTLu6kjUk4cLbFn8dughPYPeZyjdnHVM6kQ4RKc1xIlC+JURS6gI+lbcsfcukZuYysu2Y8p+dOo81d8Yf/d/iPWa8d9ENuheZKpd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=dgiBx5Bl; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-7f6bc8a4787so10137b3a.3
        for <linux-kselftest@vger.kernel.org>; Mon, 05 Jan 2026 08:45:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1767631500; x=1768236300; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L6BL2qPpVVqiVwXY3IB51McHsnbFfXZf1WvJyfM78Xk=;
        b=dgiBx5BlzLP/Ac9sW4gKVy6SEc1PSKMUt8WxGEEmLugL3iSMye3W/7CSXkyYzqn0YC
         p3yszztnQy/B5FjrWkH121uWLhZJ4nE9SceH5Fh9WWaFS4TxYErtvLdCFTU5Oyj7pKi8
         yvOJnYug0j0S3RD8axAMeu7Ayw7TP+onu9hJCu+cyPAJnzc+GgM/oNDl5gG8nVop9UOy
         /4rQvsSZkmYGQIvXDzpYliVP/s88blwyxdQ4cv1CJPLuildY5bSa5AJLWiJJ6vJMkPJQ
         aL87zu4SRfRAa9y/jw6fR2hbTqdom1XIyMo1zapI0cEddGYQo+u3bLguPcxYJ+xnoAgE
         uxYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767631500; x=1768236300;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=L6BL2qPpVVqiVwXY3IB51McHsnbFfXZf1WvJyfM78Xk=;
        b=qCGRIie7g1IFExweQocOaSx7UHvONGrgber8ufdEthhM4LBx3s3RWFHtGtmV1AmZ7d
         j0wq0AnREkjR9uyfeCwy6W2uCuypn5fkELdllH0D40JSSp5Roh1m273jabdAiG9lci0Q
         xjfDk5UtmjzkXyEq1Q9UhZbJBH2Fc0MnoH/GEzLQwI4yT39X0safsi0eGP+6EuFpRXc2
         d4INHj0fdp2Pf+GCRTmEJPw66PBaOIybMGq1cfCOH4gHZDxIGhHeN9iJtdWQ8FNTBqWS
         9N4ApOeABWqBTNl+ZGXKeb80cuW8iu8MN29IhTwLCGVVDauJTDq+O23z8BBxbNwOY4U3
         +WtQ==
X-Forwarded-Encrypted: i=1; AJvYcCVWlHDxJilrsMRGkrzp1+hkAO9kQoNj8e45QMEcK53mv1bWMXfk15DAJmLvtG9ej1ggNp1R7B8BZ6Ql7X0z16s=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOh9gy9+qgT8uAX25Mq0vuQBZBTqLysP1Snp6iosJaX4ghvq8d
	69vzeFZvk2xkNg79+uyRDOFgBFlQUKobhj8igDxxogNLqxM8ISJw3l9PDCVpORg77J6/pkKEnZL
	QLuWIdLOcsglHoVYJm6L+NlHYolfGFxYGoWfeHl5D0w==
X-Gm-Gg: AY/fxX7jjqCunjJnTCe8jEqAj8yJ7B9sz64mHsJWZ9Omd6Lck99UNgGInTb+eh/f46K
	xqL3aoA8gAb1lnA298Zav+Ipg/NjGu2NBR+kV+DrUvzNvITuHPXHi9l/DPR6hsJ8cc7+21Xr1fz
	U0eDqbPbMyAkjXtC4A6AGdI+Koq+I7y876C/qjD3ED7XTwjpfwcyr9jcD/+uDKj4nssyXUnbOgQ
	F3Wc2xc6CpS1k9KlP7rPlY7dCuksU/nCJY+RfODUqL5lu/jxxlBYgEX42xFTAPsf0DhhxmV
X-Google-Smtp-Source: AGHT+IF8k9ZANyOFgf4uVHZiLOyEIYQd/42XmN4OjyQ1CnRUZ4eFH6gAsgBHijDU+QbTdIeIftviRS4WQOARay1ZyAA=
X-Received: by 2002:a05:7022:4298:b0:11e:3e9:3e9b with SMTP id
 a92af1059eb24-121723088c9mr25211029c88.6.1767631499550; Mon, 05 Jan 2026
 08:44:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260103004529.1582405-1-csander@purestorage.com>
 <20260103004529.1582405-5-csander@purestorage.com> <aVkkSxNNUBMz9E61@fedora>
In-Reply-To: <aVkkSxNNUBMz9E61@fedora>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Mon, 5 Jan 2026 08:44:48 -0800
X-Gm-Features: AQt7F2oLATeVcsBIU8okZcBk_MFEK1W5141SRB_Yq7_1i_fxRUD7vLCBZiqM1qY
Message-ID: <CADUfDZqF2rWRQVptMjM7JedkkHfM-K+V65=odLcdrc3OM9jsJg@mail.gmail.com>
Subject: Re: [PATCH v2 04/19] ublk: set request integrity params in ublksrv_io_desc
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, Shuah Khan <shuah@kernel.org>, linux-block@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Stanley Zhang <stazhang@purestorage.com>, Uday Shankar <ushankar@purestorage.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jan 3, 2026 at 6:14=E2=80=AFAM Ming Lei <ming.lei@redhat.com> wrote=
:
>
> On Fri, Jan 02, 2026 at 05:45:14PM -0700, Caleb Sander Mateos wrote:
> > Indicate to the ublk server when an incoming request has integrity data
> > by setting UBLK_IO_F_INTEGRITY in the ublksrv_io_desc's op_flags field.
> > If the ublk device doesn't support integrity, the request will never
> > provide integrity data. If the ublk device supports integrity, the
> > request may omit the integrity buffer only if metadata_size matches the
> > PI tuple size determined by csum_type. In this case, the ublk server
> > should internally generate/verify the protection information from the
> > data and sector offset.
> > Set the UBLK_IO_F_CHECK_{GUARD,REFTAG,APPTAG} flags based on the
> > request's BIP_CHECK_{GUARD,REFTAG,APPTAG} flags, indicating whether to
> > verify the guard, reference, and app tags in the protection information=
.
> > The expected reference tag (32 or 48 bits) and app tag (16 bits) are
> > indicated in ublksrv_io_desc's new struct ublksrv_io_integrity integrit=
y
> > field. This field is unioned with the addr field to avoid changing the
>
> It might be fine to set per-rq app_tag, but bios in one request might hav=
e
> different app_tag in case of io merge actually.

I based this logic largely on the code under if (ns->head->ms) in
nvme_setup_rw(). That also assumes a single app_tag for the request.
Sounds like an existing bug if bios with different app_tags can be
merged together?

>
> Also block layer builds ref_tag for each internal, please see

What do you mean by "internal"? "interval"?

> t10_pi_generate() and ext_pi_crc64_generate().

Yes, the reftag increases by 1 for each integrity interval. That's why
it suffices for an NVMe command reading multiple blocks to specify
only the expected reftag for the first block; the reftags for
subsequent blocks are incremented accordingly.

Actually, I think we probably don't need to communicate the reftag
seed to the ublk server. NVMe doesn't use the reftag seed (which can
be overridden by struct uio_meta's seed field). Instead,
nvme_set_ref_tag() always uses the offset into the block device
divided by the integrity interval size, as required by all the
existing csum_type formats the kernel supports. So a ublk server could
just use the start_sector field of struct ublksrv_io_desc to compute
the expected reftags. And using start_sector as the reftag also means
merging requests would preserve their expected reftags.

>
> So looks this way is wrong.
>
> More importantly reusing iod->addr for other purpose not related with IO
> buffer is very unfriendly for adding new features, and one lesson is for =
ZONED support
> by reusing ublksrv_io_cmd->addr for zoned's append lba.

That's a fair point.

>
> For example, there is chance to support dma-buf based zero copy for ublk,=
 and
> please see the io-uring dma-buf support[1], and iod->addr might carry IO =
buffer info
> in dma-buf format in future.
>
> [1] https://lore.kernel.org/io-uring/cover.1763725387.git.asml.silence@gm=
ail.com/#t
>
>
> > size of struct ublksrv_io_desc. UBLK_F_INTEGRITY requires
> > UBLK_F_USER_COPY and the addr field isn't used for UBLK_F_USER_COPY, so
> > the two fields aren't needed simultaneously.
> >
> > Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
> > ---
> >  drivers/block/ublk_drv.c      | 43 +++++++++++++++++++++++++++++++----
> >  include/uapi/linux/ublk_cmd.h | 27 ++++++++++++++++++++--
> >  2 files changed, 64 insertions(+), 6 deletions(-)
> >
> > diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> > index 2f9316febf83..51469e0627ff 100644
> > --- a/drivers/block/ublk_drv.c
> > +++ b/drivers/block/ublk_drv.c
> > @@ -316,10 +316,36 @@ static inline bool ublk_dev_is_zoned(const struct=
 ublk_device *ub)
> >  static inline bool ublk_queue_is_zoned(const struct ublk_queue *ubq)
> >  {
> >       return ubq->flags & UBLK_F_ZONED;
> >  }
> >
> > +static void ublk_setup_iod_buf(const struct ublk_queue *ubq,
> > +                            const struct request *req,
> > +                            struct ublksrv_io_desc *iod)
> > +{
> > +#ifdef CONFIG_BLK_DEV_INTEGRITY
> > +     if (ubq->flags & UBLK_F_INTEGRITY) {
> > +             struct bio_integrity_payload *bip;
> > +             sector_t ref_tag_seed;
> > +
> > +             if (!blk_integrity_rq(req))
> > +                     return;
> > +
> > +             bip =3D bio_integrity(req->bio);
> > +             ref_tag_seed =3D bip_get_seed(bip);
>
> As mentioned, t10_pi_generate() and ext_pi_crc64_generate() builds
> per-internal ref tag.

As mentioned, the reftags for subsequent intervals can be computed by
simply incrementing the seed. If the seed is assumed to always be
start_sector >> (interval_exp - SECTOR_SHIFT), then it may not be
necessary to communicate ref_tag_seed at all.

>
>
> > +             iod->integrity.ref_tag_lo =3D ref_tag_seed;
> > +             iod->integrity.ref_tag_hi =3D ref_tag_seed >> 32;
> > +             iod->integrity.app_tag =3D bip->app_tag;
>
> In case of io merge, each bio may have different ->app_tag.

It seems like it would make more sense to prevent merging bios with
different app_tags. In the common case where a request contains a
single bio, which has a single app_tag, it would be much more
efficient to communicate only the 1 app_tag instead of having to pass
a separate app_tag for every logical block/integrity interval.

>
> Given you have to copy meta data via user copy, I suggest to follow the P=
I
> standard and make it per-internal.

How are you suggesting the ublk server access bip->app_tag and
bip_get_seed(bip) (if overriding the reftag seed is supported)? Would
the ublk server need to make another user copy syscall?

Or would you prefer I drop the BIP_CHECK_* flag support from this
patch set for now?

Thanks,
Caleb

