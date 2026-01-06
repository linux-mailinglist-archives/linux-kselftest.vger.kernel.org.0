Return-Path: <linux-kselftest+bounces-48338-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 49636CFA1EE
	for <lists+linux-kselftest@lfdr.de>; Tue, 06 Jan 2026 19:26:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D0781304CAEB
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 Jan 2026 18:26:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC2C93587C9;
	Tue,  6 Jan 2026 18:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="JwJWBgoP"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD8623587A0
	for <linux-kselftest@vger.kernel.org>; Tue,  6 Jan 2026 18:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767723629; cv=none; b=eoV73HN+zgxauCDduZB+jfdxrCZ0i+pMFdq3NqrdrMxfYFjHuv3VHHN3ReEf14nPZ16SCwx0AZLN7CDOIUyIFwMycg30E0wm+qA1vvF5X5LD4xWSNVpmTL4VXZs6dK3sm6qtrDlw+36f0Q8wzsMrXyDIsMYO6sY+2ycu6Pz4VcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767723629; c=relaxed/simple;
	bh=ebIajIsNCEAaLXdlDyN9HP/t+M4wECN11cF+l0otgw0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R9kSucU3AYysB502TJdZyvzd2wrDfr1LEIaR9RSdt+E+FKGk50G2MhJJqvZ2PEKk1M43jsSCyhjWeuapglMH2B/43LRbFKlaJKcUp+yvHxzuoMe+CSYwTgz0PxcBOT8kYbPRPThOPG9ax4FDujqtumWKVofe4ME5NW4bbzjQqxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=JwJWBgoP; arc=none smtp.client-ip=74.125.82.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-dl1-f46.google.com with SMTP id a92af1059eb24-11dd21d402cso41995c88.2
        for <linux-kselftest@vger.kernel.org>; Tue, 06 Jan 2026 10:20:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1767723626; x=1768328426; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NFBIpZGvOZlFODU4+hZrVYsOqSpPgzir/I9+wtVk4UE=;
        b=JwJWBgoPJNShPuh8xPrcrI5mtKo+gjabwRlGfpQFoYqAm4DKaL57wH1UuE1kj/Kpof
         oKa6EfMDne2ADArVTScBqh7w+YGZUiT1GQwliazisc6JxBCGThAO/urUl9GGHNnjHEmj
         w/3y7UbJHYzM84mGULTMUqIph4EwhDSae7tKbNUY5oQTK8/Bua6WLs0maxo5yHJueKbW
         WvRHWTfzI+5u2IxqN7vSCgIq3MrqYReBi35BAqSanMncwW3oDsPpURxdGySt9jbrGIJL
         I89kNS6ftL+sXZ4xnQanX8JNXMfKJTQjMXnZylbcRef2gfhJBkBCyMHnNIqfOYm4tpG2
         N5iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767723626; x=1768328426;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NFBIpZGvOZlFODU4+hZrVYsOqSpPgzir/I9+wtVk4UE=;
        b=iVXpSQDGJiH1Z5bkx3iatS0lPs3LyckfkfoD5Nqk5A936W2dg6FiZixUQuLsL6iC9D
         CtRBU8jRHluKgFh/81IWoNtJa7fKsSZUyfL26+5xY7eG5ha79VBgtUTN0kbFOYQMvRWZ
         GeuPM4nxVAi6bCVpGZ29STBC//CvrULMMCnux1wBKfmKN9IEiEXJIMTef1+5lFTJ5t7d
         /VfZVpRsQIrqU5nwF0FsQb80PzlZYnS15ISxKUHNdzRUhj/S5w/8BQo94b5MpPvs33ZS
         D5HgEmrNr4UeB+pQ0TmL5ilC18eYbY0SEDQSTeraa3mkfn1YBzXNMfUvBiZ03L5MuQpA
         Rjww==
X-Forwarded-Encrypted: i=1; AJvYcCVgueKs8fznMLwr4XK77Q3Dx7SsNAFTR63hpQcOtG+DFNYU21LuYk/FNVCE4DnNgU5XByPgm7dSo6T9+gI7yaM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzwPRXkWR8DtJ++AvRq/Bou1sS6SBkiXZrEBm1tzyZEi+H26d/5
	5YkX8A3LtgkekhO2zUDZXrByVxE0iU5lVuFFxn0h07Ep0D0Cb5jlrzejcwiPSzAkwb5aVN03Nkq
	uOr8MOVWd5rU5cHnvaJOXuPmTmcSXhGSLUbxIro/CFg==
X-Gm-Gg: AY/fxX7QPm8HVHYVHwMspgcKowNahZoNkWyjpq3VvGl8qzM1z714oZOgCzSig7JHhyQ
	p6xks2b6ROPrQ8c8baMdYdxMWNGcSbJsJ1sYRYLFOXG2rpZSDUXh7HXFhMYucExwkOvBoK211MA
	eYOftbzg2ox1PchLVF0m+k+Rr/Mel2HXNBt+eg8im4VOTI+BMsHrA7++Eb2xODejwOxocemfhAu
	GQpbsAf1QTSK2qomJKg0GvGaekA8s1yTzWSDKvAPjr8nGaGDKkpxAiMhmH3FybrJxsgLhB7
X-Google-Smtp-Source: AGHT+IE0KofUxg5lEGxsAVpLbHlGM/FyF8D5GQ2NJ0KDsjXkAS47DwF8YiGFgIpCLiZ1o5h8yYe6PL5D5DQT2f54HFw=
X-Received: by 2002:a05:7022:42a7:b0:11e:3e9:3e89 with SMTP id
 a92af1059eb24-121f18ea258mr1840934c88.7.1767723625636; Tue, 06 Jan 2026
 10:20:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260106005752.3784925-1-csander@purestorage.com>
 <20260106005752.3784925-10-csander@purestorage.com> <aV0PauBTiqWVQ-26@fedora>
In-Reply-To: <aV0PauBTiqWVQ-26@fedora>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Tue, 6 Jan 2026 10:20:14 -0800
X-Gm-Features: AQt7F2qi_5E9WBZPnpvafZe-4ti-j5mNJvNs0Ekwu2OQuM3Hx9s-YvfFNiycSRM
Message-ID: <CADUfDZryjLxVBFpk1c_NUp_GEWuWA=8UB6Vyx15tFUjQHGa_DQ@mail.gmail.com>
Subject: Re: [PATCH v3 09/19] ublk: implement integrity user copy
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, Shuah Khan <shuah@kernel.org>, linux-block@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Stanley Zhang <stazhang@purestorage.com>, Uday Shankar <ushankar@purestorage.com>, 
	"Martin K . Petersen" <martin.petersen@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 6, 2026 at 5:34=E2=80=AFAM Ming Lei <ming.lei@redhat.com> wrote=
:
>
> On Mon, Jan 05, 2026 at 05:57:41PM -0700, Caleb Sander Mateos wrote:
> > From: Stanley Zhang <stazhang@purestorage.com>
> >
> > Add a function ublk_copy_user_integrity() to copy integrity information
> > between a request and a user iov_iter. This mirrors the existing
> > ublk_copy_user_pages() but operates on request integrity data instead o=
f
> > regular data. Check UBLKSRV_IO_INTEGRITY_FLAG in iocb->ki_pos in
> > ublk_user_copy() to choose between copying data or integrity data.
> >
> > Signed-off-by: Stanley Zhang <stazhang@purestorage.com>
> > [csander: change offset units from data bytes to integrity data bytes,
> >  test UBLKSRV_IO_INTEGRITY_FLAG after subtracting UBLKSRV_IO_BUF_OFFSET=
,
> >  fix CONFIG_BLK_DEV_INTEGRITY=3Dn build,
> >  rebase on ublk user copy refactor]
> > Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
> > ---
> >  drivers/block/ublk_drv.c      | 52 +++++++++++++++++++++++++++++++++--
> >  include/uapi/linux/ublk_cmd.h |  4 +++
> >  2 files changed, 53 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> > index e44ab9981ef4..9694a4c1caa7 100644
> > --- a/drivers/block/ublk_drv.c
> > +++ b/drivers/block/ublk_drv.c
> > @@ -621,10 +621,15 @@ static inline unsigned ublk_pos_to_tag(loff_t pos=
)
> >  {
> >       return ((pos - UBLKSRV_IO_BUF_OFFSET) >> UBLK_TAG_OFF) &
> >               UBLK_TAG_BITS_MASK;
> >  }
> >
> > +static inline bool ublk_pos_is_integrity(loff_t pos)
> > +{
> > +     return !!((pos - UBLKSRV_IO_BUF_OFFSET) & UBLKSRV_IO_INTEGRITY_FL=
AG);
> > +}
> > +
>
> It could be more readable to check UBLKSRV_IO_INTEGRITY_FLAG only.

That's assuming that UBLK_TAG_BITS =3D 16 has more bits than are
strictly required by UBLK_MAX_QUEUE_DEPTH =3D 4096? Otherwise, adding
UBLKSRV_IO_BUF_OFFSET =3D 1 << 31 to tag << UBLK_TAG_OFF could overflow
into the QID bits, which could then overflow into
UBLKSRV_IO_INTEGRITY_FLAG. That seems like a very fragile assumption.
And if you want to rely on this assumption, why bother subtracting
UBLKSRV_IO_BUF_OFFSET in ublk_pos_to_hwq() either? The compiler should
easily be able to deduplicate the iocb->ki_pos - UBLKSRV_IO_BUF_OFFSET
computations, so I can't imagine it matters for performance.

>
> >  static void ublk_dev_param_basic_apply(struct ublk_device *ub)
> >  {
> >       const struct ublk_param_basic *p =3D &ub->params.basic;
> >
> >       if (p->attrs & UBLK_ATTR_READ_ONLY)
> > @@ -1047,10 +1052,37 @@ static size_t ublk_copy_user_pages(const struct=
 request *req,
> >                       break;
> >       }
> >       return done;
> >  }
> >
> > +#ifdef CONFIG_BLK_DEV_INTEGRITY
> > +static size_t ublk_copy_user_integrity(const struct request *req,
> > +             unsigned offset, struct iov_iter *uiter, int dir)
> > +{
> > +     size_t done =3D 0;
> > +     struct bio *bio =3D req->bio;
> > +     struct bvec_iter iter;
> > +     struct bio_vec iv;
> > +
> > +     if (!blk_integrity_rq(req))
> > +             return 0;
> > +
> > +     bio_for_each_integrity_vec(iv, bio, iter) {
> > +             if (!ublk_copy_user_bvec(&iv, &offset, uiter, dir, &done)=
)
> > +                     break;
> > +     }
> > +
> > +     return done;
> > +}
> > +#else /* #ifdef CONFIG_BLK_DEV_INTEGRITY */
> > +static size_t ublk_copy_user_integrity(const struct request *req,
> > +             unsigned offset, struct iov_iter *uiter, int dir)
> > +{
> > +     return 0;
> > +}
> > +#endif /* #ifdef CONFIG_BLK_DEV_INTEGRITY */
> > +
> >  static inline bool ublk_need_map_req(const struct request *req)
> >  {
> >       return ublk_rq_has_data(req) && req_op(req) =3D=3D REQ_OP_WRITE;
> >  }
> >
> > @@ -2654,10 +2686,12 @@ ublk_user_copy(struct kiocb *iocb, struct iov_i=
ter *iter, int dir)
> >  {
> >       struct ublk_device *ub =3D iocb->ki_filp->private_data;
> >       struct ublk_queue *ubq;
> >       struct request *req;
> >       struct ublk_io *io;
> > +     unsigned data_len;
> > +     bool is_integrity;
> >       size_t buf_off;
> >       u16 tag, q_id;
> >       ssize_t ret;
> >
> >       if (!user_backed_iter(iter))
> > @@ -2667,10 +2701,11 @@ ublk_user_copy(struct kiocb *iocb, struct iov_i=
ter *iter, int dir)
> >               return -EACCES;
> >
> >       tag =3D ublk_pos_to_tag(iocb->ki_pos);
> >       q_id =3D ublk_pos_to_hwq(iocb->ki_pos);
> >       buf_off =3D ublk_pos_to_buf_off(iocb->ki_pos);
> > +     is_integrity =3D ublk_pos_is_integrity(iocb->ki_pos);
>
> UBLKSRV_IO_INTEGRITY_FLAG can be set for device without UBLK_F_INTEGRITY,
> so UBLK_F_INTEGRITY need to be checked in case of `is_integrity`.

If UBLK_F_INTEGRITY isn't set, then UBLK_PARAM_TYPE_INTEGRITY isn't
allowed, so the ublk device won't support integrity data. Therefore,
blk_integrity_rq() will return false and ublk_copy_user_integrity()
will just return 0. Do you think it's important to return some error
code value instead? I would rather avoid the additional checks in the
hot path.

>
> >
> >       if (q_id >=3D ub->dev_info.nr_hw_queues)
> >               return -EINVAL;
> >
> >       ubq =3D ublk_get_queue(ub, q_id);
> > @@ -2683,21 +2718,31 @@ ublk_user_copy(struct kiocb *iocb, struct iov_i=
ter *iter, int dir)
> >       io =3D &ubq->ios[tag];
> >       req =3D __ublk_check_and_get_req(ub, q_id, tag, io);
> >       if (!req)
> >               return -EINVAL;
> >
> > -     if (buf_off > blk_rq_bytes(req)) {
> > +     if (is_integrity) {
> > +             struct blk_integrity *bi =3D &req->q->limits.integrity;
> > +
> > +             data_len =3D bio_integrity_bytes(bi, blk_rq_sectors(req))=
;
> > +     } else {
> > +             data_len =3D blk_rq_bytes(req);
> > +     }
> > +     if (buf_off > data_len) {
> >               ret =3D -EINVAL;
> >               goto out;
> >       }
> >
> >       if (!ublk_check_ubuf_dir(req, dir)) {
> >               ret =3D -EACCES;
> >               goto out;
> >       }
> >
> > -     ret =3D ublk_copy_user_pages(req, buf_off, iter, dir);
> > +     if (is_integrity)
> > +             ret =3D ublk_copy_user_integrity(req, buf_off, iter, dir)=
;
> > +     else
> > +             ret =3D ublk_copy_user_pages(req, buf_off, iter, dir);
> >
> >  out:
> >       ublk_put_req_ref(io, req);
> >       return ret;
> >  }
> > @@ -3931,11 +3976,12 @@ static struct miscdevice ublk_misc =3D {
> >  static int __init ublk_init(void)
> >  {
> >       int ret;
> >
> >       BUILD_BUG_ON((u64)UBLKSRV_IO_BUF_OFFSET +
> > -                     UBLKSRV_IO_BUF_TOTAL_SIZE < UBLKSRV_IO_BUF_OFFSET=
);
> > +                     UBLKSRV_IO_BUF_TOTAL_SIZE +
> > +                     UBLKSRV_IO_INTEGRITY_FLAG < UBLKSRV_IO_BUF_OFFSET=
);
>
> Maybe it can be simplified as:
>
> BUILD_BUG_ON(UBLK_INTEGRITY_FLAG_OFF >=3D 63);  /* Must fit in loff_t */

Okay, I think that works. Even if the addition of
UBLKSRV_IO_BUF_OFFSET causes an overflow to the next bit, it should
still fit within a 64-bit integer.

Thanks,
Caleb

>
> >       BUILD_BUG_ON(sizeof(struct ublk_auto_buf_reg) !=3D 8);
> >
> >       init_waitqueue_head(&ublk_idr_wq);
> >
> >       ret =3D misc_register(&ublk_misc);
> > diff --git a/include/uapi/linux/ublk_cmd.h b/include/uapi/linux/ublk_cm=
d.h
> > index c1103ad5925b..3af7e3684834 100644
> > --- a/include/uapi/linux/ublk_cmd.h
> > +++ b/include/uapi/linux/ublk_cmd.h
> > @@ -132,10 +132,14 @@
> >  #define UBLK_MAX_NR_QUEUES   (1U << UBLK_QID_BITS)
> >
> >  #define UBLKSRV_IO_BUF_TOTAL_BITS    (UBLK_QID_OFF + UBLK_QID_BITS)
> >  #define UBLKSRV_IO_BUF_TOTAL_SIZE    (1ULL << UBLKSRV_IO_BUF_TOTAL_BIT=
S)
> >
> > +/* Copy to/from request integrity buffer instead of data buffer */
> > +#define UBLK_INTEGRITY_FLAG_OFF UBLKSRV_IO_BUF_TOTAL_BITS
> > +#define UBLKSRV_IO_INTEGRITY_FLAG (1ULL << UBLK_INTEGRITY_FLAG_OFF)
> > +
> >  /*
> >   * ublk server can register data buffers for incoming I/O requests wit=
h a sparse
> >   * io_uring buffer table. The request buffer can then be used as the d=
ata buffer
> >   * for io_uring operations via the fixed buffer index.
> >   * Note that the ublk server can never directly access the request dat=
a memory.
> > --
> > 2.45.2
> >
>
> Thanks,
> Ming
>

