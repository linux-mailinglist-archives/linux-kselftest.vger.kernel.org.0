Return-Path: <linux-kselftest+bounces-48271-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A347CF661B
	for <lists+linux-kselftest@lfdr.de>; Tue, 06 Jan 2026 02:55:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 715D5300429D
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 Jan 2026 01:55:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8640221721;
	Tue,  6 Jan 2026 01:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TrJqkMFk"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D93C121FF46
	for <linux-kselftest@vger.kernel.org>; Tue,  6 Jan 2026 01:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767664539; cv=none; b=lNwg2Qlx+I7g5+3eifD6ss3diCpdfmVj0JptvtcCrU21fEozr1UFgp3VFs0e4dTSp6jrX+7KVKxBowvoj0VEeEjL4LA5P75Zn2kHEgq3/csUyqVW5M4IWpuTaVYpddRiheGxC+NPqdyF/UIDP39cSjTn46yLzaUlrhV8aVb395M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767664539; c=relaxed/simple;
	bh=FVzhdFndiyaeZn/ZXbRag3NTxTYTueURwbLXArlNCls=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C+4SCR4tb0j55fknAyLrxPLPZCn+TGWM+vkq2IikrT+Yeyza+ouIP5/3ajgw0hJlrgAGmVwNr1AC1mYMRhrkj1rPb7GTh1zi6znpHreVYBEzTu0PrVY1jd/RP7VUV2e2MdSGI8OIkSmaAcETb7dwnBH8s7H1cEDu/rPWpQ/IQkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TrJqkMFk; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767664536;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TqrbmwV2NsnPlt4zdPSfdnjZwfQNS3UmdSxT1ApGuxc=;
	b=TrJqkMFkE5H8vsSjZ6vA5ANwi4Io3qXOazgJe11Ds1m1A2AwVXsf39veCfekfZJZszL6YC
	MNw5iBRE8QuIOCT6UQAwVrkka5kGjrTmkb0+aFBRVv8Y4CEfzZo3aKuABmqnpt24lXQPk+
	fWUQcwW+u2lv0D6I64WPrAIZWpcjqzY=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-28-klqC1BbjP4STxwpU7DalrA-1; Mon,
 05 Jan 2026 20:55:33 -0500
X-MC-Unique: klqC1BbjP4STxwpU7DalrA-1
X-Mimecast-MFC-AGG-ID: klqC1BbjP4STxwpU7DalrA_1767664532
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D76871956050;
	Tue,  6 Jan 2026 01:55:31 +0000 (UTC)
Received: from fedora (unknown [10.72.116.57])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id EDDE3195398A;
	Tue,  6 Jan 2026 01:55:26 +0000 (UTC)
Date: Tue, 6 Jan 2026 09:55:22 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Jens Axboe <axboe@kernel.dk>, Shuah Khan <shuah@kernel.org>,
	linux-block@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Stanley Zhang <stazhang@purestorage.com>,
	Uday Shankar <ushankar@purestorage.com>
Subject: Re: [PATCH v2 04/19] ublk: set request integrity params in
 ublksrv_io_desc
Message-ID: <aVxrih4F_V58QM3S@fedora>
References: <20260103004529.1582405-1-csander@purestorage.com>
 <20260103004529.1582405-5-csander@purestorage.com>
 <aVkkSxNNUBMz9E61@fedora>
 <CADUfDZqF2rWRQVptMjM7JedkkHfM-K+V65=odLcdrc3OM9jsJg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADUfDZqF2rWRQVptMjM7JedkkHfM-K+V65=odLcdrc3OM9jsJg@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On Mon, Jan 05, 2026 at 08:44:48AM -0800, Caleb Sander Mateos wrote:
> On Sat, Jan 3, 2026 at 6:14 AM Ming Lei <ming.lei@redhat.com> wrote:
> >
> > On Fri, Jan 02, 2026 at 05:45:14PM -0700, Caleb Sander Mateos wrote:
> > > Indicate to the ublk server when an incoming request has integrity data
> > > by setting UBLK_IO_F_INTEGRITY in the ublksrv_io_desc's op_flags field.
> > > If the ublk device doesn't support integrity, the request will never
> > > provide integrity data. If the ublk device supports integrity, the
> > > request may omit the integrity buffer only if metadata_size matches the
> > > PI tuple size determined by csum_type. In this case, the ublk server
> > > should internally generate/verify the protection information from the
> > > data and sector offset.
> > > Set the UBLK_IO_F_CHECK_{GUARD,REFTAG,APPTAG} flags based on the
> > > request's BIP_CHECK_{GUARD,REFTAG,APPTAG} flags, indicating whether to
> > > verify the guard, reference, and app tags in the protection information.
> > > The expected reference tag (32 or 48 bits) and app tag (16 bits) are
> > > indicated in ublksrv_io_desc's new struct ublksrv_io_integrity integrity
> > > field. This field is unioned with the addr field to avoid changing the
> >
> > It might be fine to set per-rq app_tag, but bios in one request might have
> > different app_tag in case of io merge actually.
> 
> I based this logic largely on the code under if (ns->head->ms) in
> nvme_setup_rw(). That also assumes a single app_tag for the request.
> Sounds like an existing bug if bios with different app_tags can be
> merged together?

Looks it is true.

> 
> >
> > Also block layer builds ref_tag for each internal, please see
> 
> What do you mean by "internal"? "interval"?
> 
> > t10_pi_generate() and ext_pi_crc64_generate().
> 
> Yes, the reftag increases by 1 for each integrity interval. That's why
> it suffices for an NVMe command reading multiple blocks to specify
> only the expected reftag for the first block; the reftags for
> subsequent blocks are incremented accordingly.
> 
> Actually, I think we probably don't need to communicate the reftag
> seed to the ublk server. NVMe doesn't use the reftag seed (which can
> be overridden by struct uio_meta's seed field). Instead,
> nvme_set_ref_tag() always uses the offset into the block device
> divided by the integrity interval size, as required by all the
> existing csum_type formats the kernel supports. So a ublk server could
> just use the start_sector field of struct ublksrv_io_desc to compute
> the expected reftags. And using start_sector as the reftag also means
> merging requests would preserve their expected reftags.

IMO, this way looks fine from user viewpoint, especially aligning with NVMe. 

> 
> >
> > So looks this way is wrong.
> >
> > More importantly reusing iod->addr for other purpose not related with IO
> > buffer is very unfriendly for adding new features, and one lesson is for ZONED support
> > by reusing ublksrv_io_cmd->addr for zoned's append lba.
> 
> That's a fair point.

One candidate is add per-IO mmaped meta area, which can be flexible to
cover more use cases. 

> 
> >
> > For example, there is chance to support dma-buf based zero copy for ublk, and
> > please see the io-uring dma-buf support[1], and iod->addr might carry IO buffer info
> > in dma-buf format in future.
> >
> > [1] https://lore.kernel.org/io-uring/cover.1763725387.git.asml.silence@gmail.com/#t

BTW, PI data size is often small, and it belongs to kernel, there could be
chance to define PI data as pre-mapped DMA-BUF, then almost all drivers can
benefit from avoiding the runtime dma mapping for meta. But that may be one
bigger thing.

> >
> >
> > > size of struct ublksrv_io_desc. UBLK_F_INTEGRITY requires
> > > UBLK_F_USER_COPY and the addr field isn't used for UBLK_F_USER_COPY, so
> > > the two fields aren't needed simultaneously.
> > >
> > > Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
> > > ---
> > >  drivers/block/ublk_drv.c      | 43 +++++++++++++++++++++++++++++++----
> > >  include/uapi/linux/ublk_cmd.h | 27 ++++++++++++++++++++--
> > >  2 files changed, 64 insertions(+), 6 deletions(-)
> > >
> > > diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> > > index 2f9316febf83..51469e0627ff 100644
> > > --- a/drivers/block/ublk_drv.c
> > > +++ b/drivers/block/ublk_drv.c
> > > @@ -316,10 +316,36 @@ static inline bool ublk_dev_is_zoned(const struct ublk_device *ub)
> > >  static inline bool ublk_queue_is_zoned(const struct ublk_queue *ubq)
> > >  {
> > >       return ubq->flags & UBLK_F_ZONED;
> > >  }
> > >
> > > +static void ublk_setup_iod_buf(const struct ublk_queue *ubq,
> > > +                            const struct request *req,
> > > +                            struct ublksrv_io_desc *iod)
> > > +{
> > > +#ifdef CONFIG_BLK_DEV_INTEGRITY
> > > +     if (ubq->flags & UBLK_F_INTEGRITY) {
> > > +             struct bio_integrity_payload *bip;
> > > +             sector_t ref_tag_seed;
> > > +
> > > +             if (!blk_integrity_rq(req))
> > > +                     return;
> > > +
> > > +             bip = bio_integrity(req->bio);
> > > +             ref_tag_seed = bip_get_seed(bip);
> >
> > As mentioned, t10_pi_generate() and ext_pi_crc64_generate() builds
> > per-internal ref tag.
> 
> As mentioned, the reftags for subsequent intervals can be computed by
> simply incrementing the seed. If the seed is assumed to always be
> start_sector >> (interval_exp - SECTOR_SHIFT), then it may not be
> necessary to communicate ref_tag_seed at all.

Fair enough, but this should be documented in UAPI interface.

> 
> >
> >
> > > +             iod->integrity.ref_tag_lo = ref_tag_seed;
> > > +             iod->integrity.ref_tag_hi = ref_tag_seed >> 32;
> > > +             iod->integrity.app_tag = bip->app_tag;
> >
> > In case of io merge, each bio may have different ->app_tag.
> 
> It seems like it would make more sense to prevent merging bios with
> different app_tags. In the common case where a request contains a
> single bio, which has a single app_tag, it would be much more
> efficient to communicate only the 1 app_tag instead of having to pass
> a separate app_tag for every logical block/integrity interval.

OK.

> 
> >
> > Given you have to copy meta data via user copy, I suggest to follow the PI
> > standard and make it per-internal.
> 
> How are you suggesting the ublk server access bip->app_tag and
> bip_get_seed(bip) (if overriding the reftag seed is supported)? Would
> the ublk server need to make another user copy syscall?
> 
> Or would you prefer I drop the BIP_CHECK_* flag support from this
> patch set for now?

I can understand the motivation, and extra syscall should be avoided for
communicating reftag & apptag only, given you have explained both can be
per-request instead of per-interval.

But iod->addr should be avoided for this purpose, otherwise, new feature
can conflict with this usage easily.

But per-io mmapped area can solve this issue, the meta size can be one parameter
of `ublksrv_ctrl_dev_info` with feature flag of UBLK_F_MMAPED_IO_META, what
do you think of this way?


Thanks,
Ming


