Return-Path: <linux-kselftest+bounces-48355-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 79564CFB776
	for <lists+linux-kselftest@lfdr.de>; Wed, 07 Jan 2026 01:29:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 21DB33027CD8
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Jan 2026 00:28:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AA071C6FF5;
	Wed,  7 Jan 2026 00:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ekQ4Hgpx"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABEAC26290
	for <linux-kselftest@vger.kernel.org>; Wed,  7 Jan 2026 00:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767745712; cv=none; b=odF7lfNWJ0cxyVskAj6uDtZZszkFdUUs4D701SL98n/BxneTB4VpvI0mndJbBr5SjSuvhyYmMbdOlmZH2N3AYvNPN8Z87WBXa8n7mPbfvbrOa4gJ6YHV09NzQON0rpDXfWNONGEUkZvuZCxNJZsgnQ2sCuHHiZJdfW7rlzCg/DI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767745712; c=relaxed/simple;
	bh=OqKCrFTRWQn9DrKY7pdYXv+h56N0OkFE7m8PpD5f/KA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tYKY1rlxa5dojfeNTEPxB7iBfqPe3qDzmmG0b9ng2sJhJX1XJl/4F/mjtgSocHqxGXZs5kseEsUK4+WDMMq9uTQ3hGGK1vsiq4pP/oMRXb5brlo1haWihp8TDYEY+merUO/tYIQndmNZTE6vT9D69n+b8pRTgIvbH9ugMHdqB7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ekQ4Hgpx; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767745709;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=F/615Uf3niDsaKYgBdiWEyWdyh4+v6hUHAWVWt1qodc=;
	b=ekQ4Hgpx6mq+Gojd6ssj+068I28DCzt3U1oJQ1u539StQKNFtq+Dhp4KLW1QiDq3Su/dSp
	sKVtkha5+y/TZVoJUCrGPUulqIVTnttp4EC2kFcpRuAHF4TaO/BTcTiOPdY2cHAT15xVRQ
	LDUyHB6/030IQ1FMh1via/wlkA+0DcI=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-588-akNJJoCTMOGkJk8ZlX43-A-1; Tue,
 06 Jan 2026 19:28:26 -0500
X-MC-Unique: akNJJoCTMOGkJk8ZlX43-A-1
X-Mimecast-MFC-AGG-ID: akNJJoCTMOGkJk8ZlX43-A_1767745705
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E3E7C195608D;
	Wed,  7 Jan 2026 00:28:24 +0000 (UTC)
Received: from fedora (unknown [10.72.116.130])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BF18F30001B9;
	Wed,  7 Jan 2026 00:28:19 +0000 (UTC)
Date: Wed, 7 Jan 2026 08:28:14 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Jens Axboe <axboe@kernel.dk>, Shuah Khan <shuah@kernel.org>,
	linux-block@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Stanley Zhang <stazhang@purestorage.com>,
	Uday Shankar <ushankar@purestorage.com>,
	"Martin K . Petersen" <martin.petersen@oracle.com>
Subject: Re: [PATCH v3 09/19] ublk: implement integrity user copy
Message-ID: <aV2onjve8cFAkJrV@fedora>
References: <20260106005752.3784925-1-csander@purestorage.com>
 <20260106005752.3784925-10-csander@purestorage.com>
 <aV0PauBTiqWVQ-26@fedora>
 <CADUfDZryjLxVBFpk1c_NUp_GEWuWA=8UB6Vyx15tFUjQHGa_DQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADUfDZryjLxVBFpk1c_NUp_GEWuWA=8UB6Vyx15tFUjQHGa_DQ@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On Tue, Jan 06, 2026 at 10:20:14AM -0800, Caleb Sander Mateos wrote:
> On Tue, Jan 6, 2026 at 5:34 AM Ming Lei <ming.lei@redhat.com> wrote:
> >
> > On Mon, Jan 05, 2026 at 05:57:41PM -0700, Caleb Sander Mateos wrote:
> > > From: Stanley Zhang <stazhang@purestorage.com>
> > >
> > > Add a function ublk_copy_user_integrity() to copy integrity information
> > > between a request and a user iov_iter. This mirrors the existing
> > > ublk_copy_user_pages() but operates on request integrity data instead of
> > > regular data. Check UBLKSRV_IO_INTEGRITY_FLAG in iocb->ki_pos in
> > > ublk_user_copy() to choose between copying data or integrity data.
> > >
> > > Signed-off-by: Stanley Zhang <stazhang@purestorage.com>
> > > [csander: change offset units from data bytes to integrity data bytes,
> > >  test UBLKSRV_IO_INTEGRITY_FLAG after subtracting UBLKSRV_IO_BUF_OFFSET,
> > >  fix CONFIG_BLK_DEV_INTEGRITY=n build,
> > >  rebase on ublk user copy refactor]
> > > Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
> > > ---
> > >  drivers/block/ublk_drv.c      | 52 +++++++++++++++++++++++++++++++++--
> > >  include/uapi/linux/ublk_cmd.h |  4 +++
> > >  2 files changed, 53 insertions(+), 3 deletions(-)
> > >
> > > diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> > > index e44ab9981ef4..9694a4c1caa7 100644
> > > --- a/drivers/block/ublk_drv.c
> > > +++ b/drivers/block/ublk_drv.c
> > > @@ -621,10 +621,15 @@ static inline unsigned ublk_pos_to_tag(loff_t pos)
> > >  {
> > >       return ((pos - UBLKSRV_IO_BUF_OFFSET) >> UBLK_TAG_OFF) &
> > >               UBLK_TAG_BITS_MASK;
> > >  }
> > >
> > > +static inline bool ublk_pos_is_integrity(loff_t pos)
> > > +{
> > > +     return !!((pos - UBLKSRV_IO_BUF_OFFSET) & UBLKSRV_IO_INTEGRITY_FLAG);
> > > +}
> > > +
> >
> > It could be more readable to check UBLKSRV_IO_INTEGRITY_FLAG only.
> 
> That's assuming that UBLK_TAG_BITS = 16 has more bits than are
> strictly required by UBLK_MAX_QUEUE_DEPTH = 4096? Otherwise, adding
> UBLKSRV_IO_BUF_OFFSET = 1 << 31 to tag << UBLK_TAG_OFF could overflow
> into the QID bits, which could then overflow into
> UBLKSRV_IO_INTEGRITY_FLAG. That seems like a very fragile assumption.
> And if you want to rely on this assumption, why bother subtracting
> UBLKSRV_IO_BUF_OFFSET in ublk_pos_to_hwq() either? The compiler should
> easily be able to deduplicate the iocb->ki_pos - UBLKSRV_IO_BUF_OFFSET
> computations, so I can't imagine it matters for performance.

UBLKSRV_IO_INTEGRITY_FLAG should be defined as one flag starting from top
bit(bit 62), then you will see it is just fine to check it directly.

But it isn't a big deal to subtract UBLKSRV_IO_BUF_OFFSET or not here, I
will leave it to you.

> 
> >
> > >  static void ublk_dev_param_basic_apply(struct ublk_device *ub)
> > >  {
> > >       const struct ublk_param_basic *p = &ub->params.basic;
> > >
> > >       if (p->attrs & UBLK_ATTR_READ_ONLY)
> > > @@ -1047,10 +1052,37 @@ static size_t ublk_copy_user_pages(const struct request *req,
> > >                       break;
> > >       }
> > >       return done;
> > >  }
> > >
> > > +#ifdef CONFIG_BLK_DEV_INTEGRITY
> > > +static size_t ublk_copy_user_integrity(const struct request *req,
> > > +             unsigned offset, struct iov_iter *uiter, int dir)
> > > +{
> > > +     size_t done = 0;
> > > +     struct bio *bio = req->bio;
> > > +     struct bvec_iter iter;
> > > +     struct bio_vec iv;
> > > +
> > > +     if (!blk_integrity_rq(req))
> > > +             return 0;
> > > +
> > > +     bio_for_each_integrity_vec(iv, bio, iter) {
> > > +             if (!ublk_copy_user_bvec(&iv, &offset, uiter, dir, &done))
> > > +                     break;
> > > +     }
> > > +
> > > +     return done;
> > > +}
> > > +#else /* #ifdef CONFIG_BLK_DEV_INTEGRITY */
> > > +static size_t ublk_copy_user_integrity(const struct request *req,
> > > +             unsigned offset, struct iov_iter *uiter, int dir)
> > > +{
> > > +     return 0;
> > > +}
> > > +#endif /* #ifdef CONFIG_BLK_DEV_INTEGRITY */
> > > +
> > >  static inline bool ublk_need_map_req(const struct request *req)
> > >  {
> > >       return ublk_rq_has_data(req) && req_op(req) == REQ_OP_WRITE;
> > >  }
> > >
> > > @@ -2654,10 +2686,12 @@ ublk_user_copy(struct kiocb *iocb, struct iov_iter *iter, int dir)
> > >  {
> > >       struct ublk_device *ub = iocb->ki_filp->private_data;
> > >       struct ublk_queue *ubq;
> > >       struct request *req;
> > >       struct ublk_io *io;
> > > +     unsigned data_len;
> > > +     bool is_integrity;
> > >       size_t buf_off;
> > >       u16 tag, q_id;
> > >       ssize_t ret;
> > >
> > >       if (!user_backed_iter(iter))
> > > @@ -2667,10 +2701,11 @@ ublk_user_copy(struct kiocb *iocb, struct iov_iter *iter, int dir)
> > >               return -EACCES;
> > >
> > >       tag = ublk_pos_to_tag(iocb->ki_pos);
> > >       q_id = ublk_pos_to_hwq(iocb->ki_pos);
> > >       buf_off = ublk_pos_to_buf_off(iocb->ki_pos);
> > > +     is_integrity = ublk_pos_is_integrity(iocb->ki_pos);
> >
> > UBLKSRV_IO_INTEGRITY_FLAG can be set for device without UBLK_F_INTEGRITY,
> > so UBLK_F_INTEGRITY need to be checked in case of `is_integrity`.
> 
> If UBLK_F_INTEGRITY isn't set, then UBLK_PARAM_TYPE_INTEGRITY isn't
> allowed, so the ublk device won't support integrity data. Therefore,
> blk_integrity_rq() will return false and ublk_copy_user_integrity()
> will just return 0. Do you think it's important to return some error
> code value instead? I would rather avoid the additional checks in the
> hot path.

The check could be zero cost, but better to fail the wrong usage than
returning 0 silently, which may often imply big issue.


Thanks, 
Ming


