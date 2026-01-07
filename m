Return-Path: <linux-kselftest+bounces-48433-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id DBC13CFF3BD
	for <lists+linux-kselftest@lfdr.de>; Wed, 07 Jan 2026 18:57:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9A2A0300EF60
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Jan 2026 17:57:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13F4335C19C;
	Wed,  7 Jan 2026 17:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="WHiLiGgg"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8B3D38DFDB
	for <linux-kselftest@vger.kernel.org>; Wed,  7 Jan 2026 17:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767807932; cv=none; b=muASGuuMeMf7niLjVbm+N3CsUZGgGBy/l2wxnPh5JHjgYyP2QKNlVNkr3irab19J0JOTF4VJL7OfbtrGNVJtQNVNoDvyf9uNHRScC01NQ7RRfn0ZgOcknYLTNP6EP/xy+9yXn1TArwEgNMhED5QaJRvSaZwGS5tc47wFpnW+JiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767807932; c=relaxed/simple;
	bh=jCKjePub3POo12duPtYPOuSdHEgDLQZESG1PLQByCW0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mCfOUf64hEyKflwHNs5URdn8PrGm7JrPE9tDocMdk2Sixmuf7/V5FktRrk3ahrjapkG8zij/fXg0D8iq9vJHfJz5bjFlX4xx0moiZkGCyP2/W3sC2YeraUcCfIWTOk/YO4dEzWFWfOjXyf3YexCHYFDqzDnjzcwC6qBiSUHlJDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=WHiLiGgg; arc=none smtp.client-ip=74.125.82.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-2b1161400afso89161eec.0
        for <linux-kselftest@vger.kernel.org>; Wed, 07 Jan 2026 09:45:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1767807922; x=1768412722; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=foZsXxtRErGvrhfIirA1Tid8BKr7EP+JHKEkLuwIADo=;
        b=WHiLiGggcACeXS3mPM9Dxr9m6Lld59I2nTw+jT9ZATnbDxiPIQniGTS9d9h03G1CAD
         qcTNOOp1ZHV3gVZQT5zGy3EUmsMH5Nur2bU3tuEbMqxKBBR7Yc5vckC/9+e4E9EQfZ/Q
         av7DjQwsm7uF4l9LPoftSfMvEGf2Ggq94Gg5BIEOQ0VDZ4s3jZmRmr1uzY93PlwHJMk1
         NJOGP6Nej1WkgIr7LrcKSYOYnlmdJTstHvA6mbwACaObcMrW/flBBAJIE8IF7vzppQTU
         HWVvOheyIxDmOmIDfXLXWrUDZPnqMWX402ECoK712WFfwMx58w9t8HcvMSicu/kqJWcj
         au9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767807922; x=1768412722;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=foZsXxtRErGvrhfIirA1Tid8BKr7EP+JHKEkLuwIADo=;
        b=hFB1vL+jMK/U9M35s+BYCOjt1RXVL5M+9dcGClt3px0m+xZZGw4p8JwWUDv2TXJtn+
         ywva5WJtn+voYHI1weD8Sql9vLEwZsYxJkyU4onojkO2d3PSIQCOFZAmeHFapyiUgQE3
         CX9MS+g1e+bOWxQaBvs/BipCUkj9dIelhviCsy/rXHjAxxkIE44hpId9k6jMVophgvGw
         0BBxvGjS5/5wwKnwaE3gH+5wfrA6HpVFJC2zRVPf8EiJrTk5ivZ/1B8oEVEIQhNEZKAm
         T95iN5fPxW/Ux4ERxvSet/1s1sbY4UrtwDtQzRaSRWSqJATVebsRZY/WZ0S+nobd7HwO
         tRnQ==
X-Forwarded-Encrypted: i=1; AJvYcCW1rNfQuw0GI1tdLb/JoHr0xuPF8QksbH7I71MQ81SoMLgpGPx7DSmYnbEbOzbALvV4R52BLbLVO0RZp/gY1yI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/cLCLpPFEWdey3BBsi2qnOvUFkE5ZWsvHwvIonaBIKaAi1Bv0
	HVzh35r9LKqxq1GE1VrqbuFdRuHjCgiCgalIoDs261bFz1RANsXn/eOjJFUvosU+Q/OeY5tUegW
	HPzH/HhVjX3cKOHLll4Z0qH+wfOqhYRlBxDWYaNBTxQ==
X-Gm-Gg: AY/fxX5kfr0nkqQ0DfHGFVqQeep9Z8OF8Y+L1snEUsaFq/Xq6Fjudrg23M8hGYNGIyT
	cKi7FKFt5PCS8LxTp1vo/UbTpWgIsnySvdnwCndoYGd94lyJNPukvc8gWCGp+2iJmKvDVOkpE9E
	IZ/QKzKe8a6HqEyh0o2BvuS2R26RwyNyrzJ1FszdFqvuvMHJECAyLc6nrRe2ZGJmygVECnConhJ
	Sbejmv8jyrrNRln0myEF30kfzKqR3XCnp4yoLe1V02pKBjG9+pa6suQhQKbNwJww20jk4bw
X-Google-Smtp-Source: AGHT+IHE4mNx6/EMhhE5Or86ECvZZOb/iAYbIUUmJtHg2DAtEbvcnnTp6HLgFs9IPt8sjIMcE7uikPBBa3Di7ryRAg8=
X-Received: by 2002:a05:7022:6723:b0:11a:2020:ac85 with SMTP id
 a92af1059eb24-121f8b7d702mr1418887c88.4.1767807922014; Wed, 07 Jan 2026
 09:45:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260103004529.1582405-1-csander@purestorage.com>
 <20260103004529.1582405-5-csander@purestorage.com> <aVkkSxNNUBMz9E61@fedora>
 <CADUfDZqF2rWRQVptMjM7JedkkHfM-K+V65=odLcdrc3OM9jsJg@mail.gmail.com> <aVxrih4F_V58QM3S@fedora>
In-Reply-To: <aVxrih4F_V58QM3S@fedora>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Wed, 7 Jan 2026 09:45:08 -0800
X-Gm-Features: AQt7F2oQrIk8nn83VQl3xbYGKbxt4bDu3LODYmdTykNvo8yQW48q6KDA6Ua86Y8
Message-ID: <CADUfDZpyYfUGC0zD76E--xVMOwBsf_NoLwax2n+0fVBOAjAODA@mail.gmail.com>
Subject: Re: [PATCH v2 04/19] ublk: set request integrity params in ublksrv_io_desc
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, Shuah Khan <shuah@kernel.org>, linux-block@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Stanley Zhang <stazhang@purestorage.com>, Uday Shankar <ushankar@purestorage.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 5, 2026 at 5:55=E2=80=AFPM Ming Lei <ming.lei@redhat.com> wrote=
:
>
> On Mon, Jan 05, 2026 at 08:44:48AM -0800, Caleb Sander Mateos wrote:
> > On Sat, Jan 3, 2026 at 6:14=E2=80=AFAM Ming Lei <ming.lei@redhat.com> w=
rote:
> > >
> > > On Fri, Jan 02, 2026 at 05:45:14PM -0700, Caleb Sander Mateos wrote:
> > > > Indicate to the ublk server when an incoming request has integrity =
data
> > > > by setting UBLK_IO_F_INTEGRITY in the ublksrv_io_desc's op_flags fi=
eld.
> > > > If the ublk device doesn't support integrity, the request will neve=
r
> > > > provide integrity data. If the ublk device supports integrity, the
> > > > request may omit the integrity buffer only if metadata_size matches=
 the
> > > > PI tuple size determined by csum_type. In this case, the ublk serve=
r
> > > > should internally generate/verify the protection information from t=
he
> > > > data and sector offset.
> > > > Set the UBLK_IO_F_CHECK_{GUARD,REFTAG,APPTAG} flags based on the
> > > > request's BIP_CHECK_{GUARD,REFTAG,APPTAG} flags, indicating whether=
 to
> > > > verify the guard, reference, and app tags in the protection informa=
tion.
> > > > The expected reference tag (32 or 48 bits) and app tag (16 bits) ar=
e
> > > > indicated in ublksrv_io_desc's new struct ublksrv_io_integrity inte=
grity
> > > > field. This field is unioned with the addr field to avoid changing =
the
> > >
> > > It might be fine to set per-rq app_tag, but bios in one request might=
 have
> > > different app_tag in case of io merge actually.
> >
> > I based this logic largely on the code under if (ns->head->ms) in
> > nvme_setup_rw(). That also assumes a single app_tag for the request.
> > Sounds like an existing bug if bios with different app_tags can be
> > merged together?
>
> Looks it is true.
>
> >
> > >
> > > Also block layer builds ref_tag for each internal, please see
> >
> > What do you mean by "internal"? "interval"?
> >
> > > t10_pi_generate() and ext_pi_crc64_generate().
> >
> > Yes, the reftag increases by 1 for each integrity interval. That's why
> > it suffices for an NVMe command reading multiple blocks to specify
> > only the expected reftag for the first block; the reftags for
> > subsequent blocks are incremented accordingly.
> >
> > Actually, I think we probably don't need to communicate the reftag
> > seed to the ublk server. NVMe doesn't use the reftag seed (which can
> > be overridden by struct uio_meta's seed field). Instead,
> > nvme_set_ref_tag() always uses the offset into the block device
> > divided by the integrity interval size, as required by all the
> > existing csum_type formats the kernel supports. So a ublk server could
> > just use the start_sector field of struct ublksrv_io_desc to compute
> > the expected reftags. And using start_sector as the reftag also means
> > merging requests would preserve their expected reftags.
>
> IMO, this way looks fine from user viewpoint, especially aligning with NV=
Me.
>
> >
> > >
> > > So looks this way is wrong.
> > >
> > > More importantly reusing iod->addr for other purpose not related with=
 IO
> > > buffer is very unfriendly for adding new features, and one lesson is =
for ZONED support
> > > by reusing ublksrv_io_cmd->addr for zoned's append lba.
> >
> > That's a fair point.
>
> One candidate is add per-IO mmaped meta area, which can be flexible to
> cover more use cases.
>
> >
> > >
> > > For example, there is chance to support dma-buf based zero copy for u=
blk, and
> > > please see the io-uring dma-buf support[1], and iod->addr might carry=
 IO buffer info
> > > in dma-buf format in future.
> > >
> > > [1] https://lore.kernel.org/io-uring/cover.1763725387.git.asml.silenc=
e@gmail.com/#t
>
> BTW, PI data size is often small, and it belongs to kernel, there could b=
e

The integrity data buffer isn't necessarily kernel memory. With
IORING_RW_ATTR_FLAG_PI, userspace can use a buffer from its address
space for the integrity data.

> chance to define PI data as pre-mapped DMA-BUF, then almost all drivers c=
an
> benefit from avoiding the runtime dma mapping for meta. But that may be o=
ne
> bigger thing.

Yes, I think it would be a significant amount of work to use
pre-mapped buffers for integrity data. I'd like to avoid that in this
patch set and focus on just the ublk integrity data support.

>
> > >
> > >
> > > > size of struct ublksrv_io_desc. UBLK_F_INTEGRITY requires
> > > > UBLK_F_USER_COPY and the addr field isn't used for UBLK_F_USER_COPY=
, so
> > > > the two fields aren't needed simultaneously.
> > > >
> > > > Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
> > > > ---
> > > >  drivers/block/ublk_drv.c      | 43 +++++++++++++++++++++++++++++++=
----
> > > >  include/uapi/linux/ublk_cmd.h | 27 ++++++++++++++++++++--
> > > >  2 files changed, 64 insertions(+), 6 deletions(-)
> > > >
> > > > diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> > > > index 2f9316febf83..51469e0627ff 100644
> > > > --- a/drivers/block/ublk_drv.c
> > > > +++ b/drivers/block/ublk_drv.c
> > > > @@ -316,10 +316,36 @@ static inline bool ublk_dev_is_zoned(const st=
ruct ublk_device *ub)
> > > >  static inline bool ublk_queue_is_zoned(const struct ublk_queue *ub=
q)
> > > >  {
> > > >       return ubq->flags & UBLK_F_ZONED;
> > > >  }
> > > >
> > > > +static void ublk_setup_iod_buf(const struct ublk_queue *ubq,
> > > > +                            const struct request *req,
> > > > +                            struct ublksrv_io_desc *iod)
> > > > +{
> > > > +#ifdef CONFIG_BLK_DEV_INTEGRITY
> > > > +     if (ubq->flags & UBLK_F_INTEGRITY) {
> > > > +             struct bio_integrity_payload *bip;
> > > > +             sector_t ref_tag_seed;
> > > > +
> > > > +             if (!blk_integrity_rq(req))
> > > > +                     return;
> > > > +
> > > > +             bip =3D bio_integrity(req->bio);
> > > > +             ref_tag_seed =3D bip_get_seed(bip);
> > >
> > > As mentioned, t10_pi_generate() and ext_pi_crc64_generate() builds
> > > per-internal ref tag.
> >
> > As mentioned, the reftags for subsequent intervals can be computed by
> > simply incrementing the seed. If the seed is assumed to always be
> > start_sector >> (interval_exp - SECTOR_SHIFT), then it may not be
> > necessary to communicate ref_tag_seed at all.
>
> Fair enough, but this should be documented in UAPI interface.
>
> >
> > >
> > >
> > > > +             iod->integrity.ref_tag_lo =3D ref_tag_seed;
> > > > +             iod->integrity.ref_tag_hi =3D ref_tag_seed >> 32;
> > > > +             iod->integrity.app_tag =3D bip->app_tag;
> > >
> > > In case of io merge, each bio may have different ->app_tag.
> >
> > It seems like it would make more sense to prevent merging bios with
> > different app_tags. In the common case where a request contains a
> > single bio, which has a single app_tag, it would be much more
> > efficient to communicate only the 1 app_tag instead of having to pass
> > a separate app_tag for every logical block/integrity interval.
>
> OK.
>
> >
> > >
> > > Given you have to copy meta data via user copy, I suggest to follow t=
he PI
> > > standard and make it per-internal.
> >
> > How are you suggesting the ublk server access bip->app_tag and
> > bip_get_seed(bip) (if overriding the reftag seed is supported)? Would
> > the ublk server need to make another user copy syscall?
> >
> > Or would you prefer I drop the BIP_CHECK_* flag support from this
> > patch set for now?
>
> I can understand the motivation, and extra syscall should be avoided for
> communicating reftag & apptag only, given you have explained both can be
> per-request instead of per-interval.
>
> But iod->addr should be avoided for this purpose, otherwise, new feature
> can conflict with this usage easily.
>
> But per-io mmapped area can solve this issue, the meta size can be one pa=
rameter
> of `ublksrv_ctrl_dev_info` with feature flag of UBLK_F_MMAPED_IO_META, wh=
at
> do you think of this way?

Are you thinking this userspace-mapped region would consist of one u16
app_tag per ublk I/O descriptor? It seems a bit complex to introduce
an additional userspace-mapped region just to communicate the app_tag.
What do you think about making the size of the I/O descriptor
information dependent on the feature flags? Basically extend
ublksrv_io_desc with an app_tag field if UBLK_F_INTEGRITY is set. This
mechanism could be extended to communicate other per-request
information in the future.

Thanks,
Caleb

