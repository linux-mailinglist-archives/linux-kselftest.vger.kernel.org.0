Return-Path: <linux-kselftest+bounces-48458-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DA3DD00988
	for <lists+linux-kselftest@lfdr.de>; Thu, 08 Jan 2026 03:04:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D8FD830141FC
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 Jan 2026 02:04:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E44F2264A9;
	Thu,  8 Jan 2026 02:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eE892nkE"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE12319E97F
	for <linux-kselftest@vger.kernel.org>; Thu,  8 Jan 2026 02:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767837841; cv=none; b=U7LjdgsaibM+XjAcjf/DLwmR252Wpg2n+uhbn63HIoEbX8+dW2dZovErmRnQd6Q6POnGBrSGUCpH0Dymev81HG/hP/9sywnUdz+lUEPixg9chBUnbQYfc201XngVx/AqtXVIVz7nYZF4XC34U0c8qF+/IdpsRVoqYIvbjcPUC1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767837841; c=relaxed/simple;
	bh=nFSgQw5repL4bg4rX6ve1p1bL53wEP4/lHpWX7vhe0k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U70jSyDjtVkal28LPNjfWAh2X6+cqKN00rtKvcMqGbgiFZ6PHUCAWoEAW2VJ/12t+Rx78/Y8H3GqHFc7MzecyGOdAsr/J581Kb/qpso4TYjqyR0VjdR1y5ex20Xxq3ydQD0z1Iaip7v6ie+0ODKLWFeKzKNmI3yXrPV4seuJfQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eE892nkE; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767837837;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iH8J0y5h4urC8PC3Rp+2w8joeJDe9xVDjIuHtLfMXHA=;
	b=eE892nkECKYPoCCXDKDjwH0nHEE/GbNQJ7Pgyw/VIHfx92AvOGvmOPdJ3H1p6WeKfOhpFi
	W0TmhCA5oYUdxT6Op4elrZWT3xS1spGRTuJkhhIlAKLMtxgYDuVBRcNnDUe7f+a8SFtPxh
	O7v+tvfMN2/F0c8h9N3wZZ5OXqxlot8=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-493-_2M56nkKNUiELhPdq9W6eA-1; Wed,
 07 Jan 2026 21:03:54 -0500
X-MC-Unique: _2M56nkKNUiELhPdq9W6eA-1
X-Mimecast-MFC-AGG-ID: _2M56nkKNUiELhPdq9W6eA_1767837832
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5EE9318005B2;
	Thu,  8 Jan 2026 02:03:52 +0000 (UTC)
Received: from fedora (unknown [10.72.116.164])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4054219560A2;
	Thu,  8 Jan 2026 02:03:46 +0000 (UTC)
Date: Thu, 8 Jan 2026 10:03:42 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Jens Axboe <axboe@kernel.dk>, Shuah Khan <shuah@kernel.org>,
	linux-block@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Stanley Zhang <stazhang@purestorage.com>,
	Uday Shankar <ushankar@purestorage.com>
Subject: Re: [PATCH v2 04/19] ublk: set request integrity params in
 ublksrv_io_desc
Message-ID: <aV8QfvaNO5P6vOs6@fedora>
References: <20260103004529.1582405-1-csander@purestorage.com>
 <20260103004529.1582405-5-csander@purestorage.com>
 <aVkkSxNNUBMz9E61@fedora>
 <CADUfDZqF2rWRQVptMjM7JedkkHfM-K+V65=odLcdrc3OM9jsJg@mail.gmail.com>
 <aVxrih4F_V58QM3S@fedora>
 <CADUfDZpyYfUGC0zD76E--xVMOwBsf_NoLwax2n+0fVBOAjAODA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADUfDZpyYfUGC0zD76E--xVMOwBsf_NoLwax2n+0fVBOAjAODA@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On Wed, Jan 07, 2026 at 09:45:08AM -0800, Caleb Sander Mateos wrote:
> On Mon, Jan 5, 2026 at 5:55 PM Ming Lei <ming.lei@redhat.com> wrote:
> >
> > On Mon, Jan 05, 2026 at 08:44:48AM -0800, Caleb Sander Mateos wrote:
> > > On Sat, Jan 3, 2026 at 6:14 AM Ming Lei <ming.lei@redhat.com> wrote:
> > > >
> > > > On Fri, Jan 02, 2026 at 05:45:14PM -0700, Caleb Sander Mateos wrote:
> > > > > Indicate to the ublk server when an incoming request has integrity data
> > > > > by setting UBLK_IO_F_INTEGRITY in the ublksrv_io_desc's op_flags field.
> > > > > If the ublk device doesn't support integrity, the request will never
> > > > > provide integrity data. If the ublk device supports integrity, the
> > > > > request may omit the integrity buffer only if metadata_size matches the
> > > > > PI tuple size determined by csum_type. In this case, the ublk server
> > > > > should internally generate/verify the protection information from the
> > > > > data and sector offset.
> > > > > Set the UBLK_IO_F_CHECK_{GUARD,REFTAG,APPTAG} flags based on the
> > > > > request's BIP_CHECK_{GUARD,REFTAG,APPTAG} flags, indicating whether to
> > > > > verify the guard, reference, and app tags in the protection information.
> > > > > The expected reference tag (32 or 48 bits) and app tag (16 bits) are
> > > > > indicated in ublksrv_io_desc's new struct ublksrv_io_integrity integrity
> > > > > field. This field is unioned with the addr field to avoid changing the
> > > >
> > > > It might be fine to set per-rq app_tag, but bios in one request might have
> > > > different app_tag in case of io merge actually.
> > >
> > > I based this logic largely on the code under if (ns->head->ms) in
> > > nvme_setup_rw(). That also assumes a single app_tag for the request.
> > > Sounds like an existing bug if bios with different app_tags can be
> > > merged together?
> >
> > Looks it is true.
> >
> > >
> > > >
> > > > Also block layer builds ref_tag for each internal, please see
> > >
> > > What do you mean by "internal"? "interval"?
> > >
> > > > t10_pi_generate() and ext_pi_crc64_generate().
> > >
> > > Yes, the reftag increases by 1 for each integrity interval. That's why
> > > it suffices for an NVMe command reading multiple blocks to specify
> > > only the expected reftag for the first block; the reftags for
> > > subsequent blocks are incremented accordingly.
> > >
> > > Actually, I think we probably don't need to communicate the reftag
> > > seed to the ublk server. NVMe doesn't use the reftag seed (which can
> > > be overridden by struct uio_meta's seed field). Instead,
> > > nvme_set_ref_tag() always uses the offset into the block device
> > > divided by the integrity interval size, as required by all the
> > > existing csum_type formats the kernel supports. So a ublk server could
> > > just use the start_sector field of struct ublksrv_io_desc to compute
> > > the expected reftags. And using start_sector as the reftag also means
> > > merging requests would preserve their expected reftags.
> >
> > IMO, this way looks fine from user viewpoint, especially aligning with NVMe.
> >
> > >
> > > >
> > > > So looks this way is wrong.
> > > >
> > > > More importantly reusing iod->addr for other purpose not related with IO
> > > > buffer is very unfriendly for adding new features, and one lesson is for ZONED support
> > > > by reusing ublksrv_io_cmd->addr for zoned's append lba.
> > >
> > > That's a fair point.
> >
> > One candidate is add per-IO mmaped meta area, which can be flexible to
> > cover more use cases.
> >
> > >
> > > >
> > > > For example, there is chance to support dma-buf based zero copy for ublk, and
> > > > please see the io-uring dma-buf support[1], and iod->addr might carry IO buffer info
> > > > in dma-buf format in future.
> > > >
> > > > [1] https://lore.kernel.org/io-uring/cover.1763725387.git.asml.silence@gmail.com/#t
> >
> > BTW, PI data size is often small, and it belongs to kernel, there could be
> 
> The integrity data buffer isn't necessarily kernel memory. With
> IORING_RW_ATTR_FLAG_PI, userspace can use a buffer from its address
> space for the integrity data.

You are right, that is something I missed, but it is from io_uring
interface.

> 
> > chance to define PI data as pre-mapped DMA-BUF, then almost all drivers can
> > benefit from avoiding the runtime dma mapping for meta. But that may be one
> > bigger thing.
> 
> Yes, I think it would be a significant amount of work to use
> pre-mapped buffers for integrity data. I'd like to avoid that in this
> patch set and focus on just the ublk integrity data support.

Agree.

> 
> >
> > > >
> > > >
> > > > > size of struct ublksrv_io_desc. UBLK_F_INTEGRITY requires
> > > > > UBLK_F_USER_COPY and the addr field isn't used for UBLK_F_USER_COPY, so
> > > > > the two fields aren't needed simultaneously.
> > > > >
> > > > > Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
> > > > > ---
> > > > >  drivers/block/ublk_drv.c      | 43 +++++++++++++++++++++++++++++++----
> > > > >  include/uapi/linux/ublk_cmd.h | 27 ++++++++++++++++++++--
> > > > >  2 files changed, 64 insertions(+), 6 deletions(-)
> > > > >
> > > > > diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> > > > > index 2f9316febf83..51469e0627ff 100644
> > > > > --- a/drivers/block/ublk_drv.c
> > > > > +++ b/drivers/block/ublk_drv.c
> > > > > @@ -316,10 +316,36 @@ static inline bool ublk_dev_is_zoned(const struct ublk_device *ub)
> > > > >  static inline bool ublk_queue_is_zoned(const struct ublk_queue *ubq)
> > > > >  {
> > > > >       return ubq->flags & UBLK_F_ZONED;
> > > > >  }
> > > > >
> > > > > +static void ublk_setup_iod_buf(const struct ublk_queue *ubq,
> > > > > +                            const struct request *req,
> > > > > +                            struct ublksrv_io_desc *iod)
> > > > > +{
> > > > > +#ifdef CONFIG_BLK_DEV_INTEGRITY
> > > > > +     if (ubq->flags & UBLK_F_INTEGRITY) {
> > > > > +             struct bio_integrity_payload *bip;
> > > > > +             sector_t ref_tag_seed;
> > > > > +
> > > > > +             if (!blk_integrity_rq(req))
> > > > > +                     return;
> > > > > +
> > > > > +             bip = bio_integrity(req->bio);
> > > > > +             ref_tag_seed = bip_get_seed(bip);
> > > >
> > > > As mentioned, t10_pi_generate() and ext_pi_crc64_generate() builds
> > > > per-internal ref tag.
> > >
> > > As mentioned, the reftags for subsequent intervals can be computed by
> > > simply incrementing the seed. If the seed is assumed to always be
> > > start_sector >> (interval_exp - SECTOR_SHIFT), then it may not be
> > > necessary to communicate ref_tag_seed at all.
> >
> > Fair enough, but this should be documented in UAPI interface.
> >
> > >
> > > >
> > > >
> > > > > +             iod->integrity.ref_tag_lo = ref_tag_seed;
> > > > > +             iod->integrity.ref_tag_hi = ref_tag_seed >> 32;
> > > > > +             iod->integrity.app_tag = bip->app_tag;
> > > >
> > > > In case of io merge, each bio may have different ->app_tag.
> > >
> > > It seems like it would make more sense to prevent merging bios with
> > > different app_tags. In the common case where a request contains a
> > > single bio, which has a single app_tag, it would be much more
> > > efficient to communicate only the 1 app_tag instead of having to pass
> > > a separate app_tag for every logical block/integrity interval.
> >
> > OK.
> >
> > >
> > > >
> > > > Given you have to copy meta data via user copy, I suggest to follow the PI
> > > > standard and make it per-internal.
> > >
> > > How are you suggesting the ublk server access bip->app_tag and
> > > bip_get_seed(bip) (if overriding the reftag seed is supported)? Would
> > > the ublk server need to make another user copy syscall?
> > >
> > > Or would you prefer I drop the BIP_CHECK_* flag support from this
> > > patch set for now?
> >
> > I can understand the motivation, and extra syscall should be avoided for
> > communicating reftag & apptag only, given you have explained both can be
> > per-request instead of per-interval.
> >
> > But iod->addr should be avoided for this purpose, otherwise, new feature
> > can conflict with this usage easily.
> >
> > But per-io mmapped area can solve this issue, the meta size can be one parameter
> > of `ublksrv_ctrl_dev_info` with feature flag of UBLK_F_MMAPED_IO_META, what
> > do you think of this way?
> 
> Are you thinking this userspace-mapped region would consist of one u16
> app_tag per ublk I/O descriptor? It seems a bit complex to introduce
> an additional userspace-mapped region just to communicate the app_tag.
> What do you think about making the size of the I/O descriptor
> information dependent on the feature flags? Basically extend
> ublksrv_io_desc with an app_tag field if UBLK_F_INTEGRITY is set. This
> mechanism could be extended to communicate other per-request
> information in the future.

Right, that is basically what I suggested:

- add new feature flag UBLK_F_IO_DESC_EXT or UBLK_F_IO_META, meantime add
  .io_desc_ext_size or .io_meta_size field in `ublksrv_ctrl_dev_info`

- in case of this feature enabled, per-IO mmaped data size is increased to
  
  	sizeof(ublksrv_io_desc) + 
		.io_desc_ext_size or .io_meta_size(should be 8 bytes aligned)

This way should be easy to implement, and it is flexible for many extentions
in future, such as, you can set proper size for avoiding extra PI user copy
for small IO.


Thanks,
Ming


