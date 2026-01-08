Return-Path: <linux-kselftest+bounces-48462-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 30331D009D4
	for <lists+linux-kselftest@lfdr.de>; Thu, 08 Jan 2026 03:12:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1C521303EB89
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 Jan 2026 02:11:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E279E23ABA1;
	Thu,  8 Jan 2026 02:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aUeG1z+u"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5DEC237180
	for <linux-kselftest@vger.kernel.org>; Thu,  8 Jan 2026 02:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767838298; cv=none; b=pBLlzOn01r40C3yJcxbnAKhGOA1oG1HNjs66mexUzejiHFK9u2TWpYRTmaPOUq27czMbKVUToylctTMIqacAFn64nUSfAVP21by1og+nT+zg6h+ZSs3UNTZQOFq3fXMC2XdXCpxQ7wkKhYb/SHOlKfqg0HLMtsfVqLt+M+7lUjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767838298; c=relaxed/simple;
	bh=049aThQQ0R4hiDA0tJLpuzFVU7KU0eDMVCiKqIRr0Ng=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ogdSW/u1GPRD5/kOrz14f6iDcLE7P1KQPKo/3y23RijHPmesGTFENQ/Onw0SwAg4hcp+abIbVMBQHXE79vdZz+mOh8xk64PxWaokDis8UsZsXLYZy9uJD9WyXpRVC40aZp9dStCfK8rfP62SOElbXhNsjvJJ+c7DI01U3NbD3Mc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aUeG1z+u; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767838296;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rwTDfrrhXfxF0SpZgYiLTozrSeWG4M61kJgcHxQn5os=;
	b=aUeG1z+uetZJrPipJwvtnypwjb/qqWE1LB76r/c9zit/KrYm6J9akMGDQBq+cnhEYd7OTe
	JVjPZ1P/MaWo4Q8wZp9+QxSlNVXDDi0dv9/LKISTSSl9g8vvxEoGqjbzhOCNUi0UPxIXG5
	PoFojjQqvYa1FNI1slCtLb3wGQ0i8+E=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-121-3yITyVF1Ogm3ZGARGrb3yw-1; Wed,
 07 Jan 2026 21:11:30 -0500
X-MC-Unique: 3yITyVF1Ogm3ZGARGrb3yw-1
X-Mimecast-MFC-AGG-ID: 3yITyVF1Ogm3ZGARGrb3yw_1767838289
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CFCB019560B2;
	Thu,  8 Jan 2026 02:11:28 +0000 (UTC)
Received: from fedora (unknown [10.72.116.164])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 633C91956053;
	Thu,  8 Jan 2026 02:11:23 +0000 (UTC)
Date: Thu, 8 Jan 2026 10:11:18 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Jens Axboe <axboe@kernel.dk>, Shuah Khan <shuah@kernel.org>,
	linux-block@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Stanley Zhang <stazhang@purestorage.com>,
	Uday Shankar <ushankar@purestorage.com>,
	"Martin K . Petersen" <martin.petersen@oracle.com>
Subject: Re: [PATCH v3 09/19] ublk: implement integrity user copy
Message-ID: <aV8SRkTYU0NN2V6t@fedora>
References: <20260106005752.3784925-1-csander@purestorage.com>
 <20260106005752.3784925-10-csander@purestorage.com>
 <aV0PauBTiqWVQ-26@fedora>
 <CADUfDZryjLxVBFpk1c_NUp_GEWuWA=8UB6Vyx15tFUjQHGa_DQ@mail.gmail.com>
 <aV2onjve8cFAkJrV@fedora>
 <CADUfDZqxU+egMQh3ejZo4n3jHo7EwaTS7LXm2+G+RV3wpOzT9A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADUfDZqxU+egMQh3ejZo4n3jHo7EwaTS7LXm2+G+RV3wpOzT9A@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On Wed, Jan 07, 2026 at 05:50:04PM -0800, Caleb Sander Mateos wrote:
> On Tue, Jan 6, 2026 at 4:28 PM Ming Lei <ming.lei@redhat.com> wrote:
> >
> > On Tue, Jan 06, 2026 at 10:20:14AM -0800, Caleb Sander Mateos wrote:
> > > On Tue, Jan 6, 2026 at 5:34 AM Ming Lei <ming.lei@redhat.com> wrote:
> > > >
> > > > On Mon, Jan 05, 2026 at 05:57:41PM -0700, Caleb Sander Mateos wrote:
> > > > > From: Stanley Zhang <stazhang@purestorage.com>
> > > > >
> > > > > Add a function ublk_copy_user_integrity() to copy integrity information
> > > > > between a request and a user iov_iter. This mirrors the existing
> > > > > ublk_copy_user_pages() but operates on request integrity data instead of
> > > > > regular data. Check UBLKSRV_IO_INTEGRITY_FLAG in iocb->ki_pos in
> > > > > ublk_user_copy() to choose between copying data or integrity data.
> > > > >
> > > > > Signed-off-by: Stanley Zhang <stazhang@purestorage.com>
> > > > > [csander: change offset units from data bytes to integrity data bytes,
> > > > >  test UBLKSRV_IO_INTEGRITY_FLAG after subtracting UBLKSRV_IO_BUF_OFFSET,
> > > > >  fix CONFIG_BLK_DEV_INTEGRITY=n build,
> > > > >  rebase on ublk user copy refactor]
> > > > > Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
> > > > > ---
> > > > >  drivers/block/ublk_drv.c      | 52 +++++++++++++++++++++++++++++++++--
> > > > >  include/uapi/linux/ublk_cmd.h |  4 +++
> > > > >  2 files changed, 53 insertions(+), 3 deletions(-)
> > > > >
> > > > > diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> > > > > index e44ab9981ef4..9694a4c1caa7 100644
> > > > > --- a/drivers/block/ublk_drv.c
> > > > > +++ b/drivers/block/ublk_drv.c
> > > > > @@ -621,10 +621,15 @@ static inline unsigned ublk_pos_to_tag(loff_t pos)
> > > > >  {
> > > > >       return ((pos - UBLKSRV_IO_BUF_OFFSET) >> UBLK_TAG_OFF) &
> > > > >               UBLK_TAG_BITS_MASK;
> > > > >  }
> > > > >
> > > > > +static inline bool ublk_pos_is_integrity(loff_t pos)
> > > > > +{
> > > > > +     return !!((pos - UBLKSRV_IO_BUF_OFFSET) & UBLKSRV_IO_INTEGRITY_FLAG);
> > > > > +}
> > > > > +
> > > >
> > > > It could be more readable to check UBLKSRV_IO_INTEGRITY_FLAG only.
> > >
> > > That's assuming that UBLK_TAG_BITS = 16 has more bits than are
> > > strictly required by UBLK_MAX_QUEUE_DEPTH = 4096? Otherwise, adding
> > > UBLKSRV_IO_BUF_OFFSET = 1 << 31 to tag << UBLK_TAG_OFF could overflow
> > > into the QID bits, which could then overflow into
> > > UBLKSRV_IO_INTEGRITY_FLAG. That seems like a very fragile assumption.
> > > And if you want to rely on this assumption, why bother subtracting
> > > UBLKSRV_IO_BUF_OFFSET in ublk_pos_to_hwq() either? The compiler should
> > > easily be able to deduplicate the iocb->ki_pos - UBLKSRV_IO_BUF_OFFSET
> > > computations, so I can't imagine it matters for performance.
> >
> > UBLKSRV_IO_INTEGRITY_FLAG should be defined as one flag starting from top
> > bit(bit 62), then you will see it is just fine to check it directly.
> >
> > But it isn't a big deal to subtract UBLKSRV_IO_BUF_OFFSET or not here, I
> > will leave it to you.
> >
> > >
> > > >
> > > > >  static void ublk_dev_param_basic_apply(struct ublk_device *ub)
> > > > >  {
> > > > >       const struct ublk_param_basic *p = &ub->params.basic;
> > > > >
> > > > >       if (p->attrs & UBLK_ATTR_READ_ONLY)
> > > > > @@ -1047,10 +1052,37 @@ static size_t ublk_copy_user_pages(const struct request *req,
> > > > >                       break;
> > > > >       }
> > > > >       return done;
> > > > >  }
> > > > >
> > > > > +#ifdef CONFIG_BLK_DEV_INTEGRITY
> > > > > +static size_t ublk_copy_user_integrity(const struct request *req,
> > > > > +             unsigned offset, struct iov_iter *uiter, int dir)
> > > > > +{
> > > > > +     size_t done = 0;
> > > > > +     struct bio *bio = req->bio;
> > > > > +     struct bvec_iter iter;
> > > > > +     struct bio_vec iv;
> > > > > +
> > > > > +     if (!blk_integrity_rq(req))
> > > > > +             return 0;
> > > > > +
> > > > > +     bio_for_each_integrity_vec(iv, bio, iter) {
> > > > > +             if (!ublk_copy_user_bvec(&iv, &offset, uiter, dir, &done))
> > > > > +                     break;
> > > > > +     }
> > > > > +
> > > > > +     return done;
> > > > > +}
> > > > > +#else /* #ifdef CONFIG_BLK_DEV_INTEGRITY */
> > > > > +static size_t ublk_copy_user_integrity(const struct request *req,
> > > > > +             unsigned offset, struct iov_iter *uiter, int dir)
> > > > > +{
> > > > > +     return 0;
> > > > > +}
> > > > > +#endif /* #ifdef CONFIG_BLK_DEV_INTEGRITY */
> > > > > +
> > > > >  static inline bool ublk_need_map_req(const struct request *req)
> > > > >  {
> > > > >       return ublk_rq_has_data(req) && req_op(req) == REQ_OP_WRITE;
> > > > >  }
> > > > >
> > > > > @@ -2654,10 +2686,12 @@ ublk_user_copy(struct kiocb *iocb, struct iov_iter *iter, int dir)
> > > > >  {
> > > > >       struct ublk_device *ub = iocb->ki_filp->private_data;
> > > > >       struct ublk_queue *ubq;
> > > > >       struct request *req;
> > > > >       struct ublk_io *io;
> > > > > +     unsigned data_len;
> > > > > +     bool is_integrity;
> > > > >       size_t buf_off;
> > > > >       u16 tag, q_id;
> > > > >       ssize_t ret;
> > > > >
> > > > >       if (!user_backed_iter(iter))
> > > > > @@ -2667,10 +2701,11 @@ ublk_user_copy(struct kiocb *iocb, struct iov_iter *iter, int dir)
> > > > >               return -EACCES;
> > > > >
> > > > >       tag = ublk_pos_to_tag(iocb->ki_pos);
> > > > >       q_id = ublk_pos_to_hwq(iocb->ki_pos);
> > > > >       buf_off = ublk_pos_to_buf_off(iocb->ki_pos);
> > > > > +     is_integrity = ublk_pos_is_integrity(iocb->ki_pos);
> > > >
> > > > UBLKSRV_IO_INTEGRITY_FLAG can be set for device without UBLK_F_INTEGRITY,
> > > > so UBLK_F_INTEGRITY need to be checked in case of `is_integrity`.
> > >
> > > If UBLK_F_INTEGRITY isn't set, then UBLK_PARAM_TYPE_INTEGRITY isn't
> > > allowed, so the ublk device won't support integrity data. Therefore,
> > > blk_integrity_rq() will return false and ublk_copy_user_integrity()
> > > will just return 0. Do you think it's important to return some error
> > > code value instead? I would rather avoid the additional checks in the
> > > hot path.
> >
> > The check could be zero cost, but better to fail the wrong usage than
> > returning 0 silently, which may often imply big issue.
> 
> Not sure what you mean by "the check could be zero cost". It's 2
> branches to check for UBLK_F_INTEGRITY in the ublk_device flags and to
> check is_integrity. Even if the branches are predictable (and the
> is_integrity one might not be), there's still some cost for computing
> the conditions and taking up space in the branch history table.

ub->dev_info.nr_hw_queues is fetched for validating `q_id`, so
ub->dev_info.flags is always hit from the same cache line.

> A ublk server should already be checking that the return value from
> the user copy syscall matches the passed in length. Otherwise, the
> request's data was shorter than expected or a fault occurred while
> accessing the userspace buffer. But if you feel strongly, I'll add an
> explicit -EINVAL return code.

It is absolutely userspace fault or bug, I think it is better to fast fail.
Otherwise, it has to be documented clearly.


Thanks,
Ming


