Return-Path: <linux-kselftest+bounces-48457-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 27126D00955
	for <lists+linux-kselftest@lfdr.de>; Thu, 08 Jan 2026 02:50:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0F535300EDC4
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 Jan 2026 01:50:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB3C5221F06;
	Thu,  8 Jan 2026 01:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="cDPpsvrb"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-dl1-f51.google.com (mail-dl1-f51.google.com [74.125.82.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F7A039FCE
	for <linux-kselftest@vger.kernel.org>; Thu,  8 Jan 2026 01:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767837018; cv=none; b=D5K3ulsn2Sz5N0tOomYbdXf3WKByxhrqvfjYjGshJj3m76+0ip3f5wYO1jiFQQdJdtk+WXcuEHcmGnlVl2GzZ92mhgQneA/RiYbTXQLJRVztTM15Dlhlcfi17P5UqgPlzF2xgdjn2WZrRPwsogIIEd448Ns3UIYzOXbxXXguJKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767837018; c=relaxed/simple;
	bh=UaYWSHZn7QQ56NrVh9iMPN+1CuYvoH98mEaZEVdDXzU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=acBzl8BYZXnrlKMZbDIp02QXysXJ8P5eoigmgi2BkvY5r7kLGHhoj6bH+jcmfuxKz+GUTR8Yo1Nn1E2e1QJ5B/xtBclJuxqfyQ3AE7nZkfrxQwCeXD4Mol4prKKwjh7MoTUn5Pz+hAu8YknW+10uIPSDnvNGV39xU9Jx/S8r710=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=cDPpsvrb; arc=none smtp.client-ip=74.125.82.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-dl1-f51.google.com with SMTP id a92af1059eb24-11bba84006dso234848c88.2
        for <linux-kselftest@vger.kernel.org>; Wed, 07 Jan 2026 17:50:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1767837016; x=1768441816; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HIhIeuKFWB7qpXFbJnN1YWQXlT41MD3QHMrR5nZ2STE=;
        b=cDPpsvrbKxpnhbXGGfySJR6iLRjcb54++xt9O1Nt7YPr1liyu9cfeqWlAbYmyDAt5i
         YkNdxdpu65FhSo6MdSj6uc6hO7Kzm6UbVMVomnbLExMGBnC8Wf39WVmWGF6Q/JmwLJg9
         ZoTGCPnnCjogmWhsjvYD5ulIEX7ZnMfB1YXT0++K3KcAgNeqRWx+AU2VIOR9B/Zry9Ik
         eu+n/dqFPRoT8fwlgAe6NmLwvKf0LRYf/WA5OaTT5PqrhH85mvJlSCLmuKH4TiX9Sy7G
         fP3teLrC42/hqhQoVOJdi3Okk7I6HZtQhuEkNFH/I0CXDzwzbowo96YHhN9cI3xH5ZC9
         498Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767837016; x=1768441816;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HIhIeuKFWB7qpXFbJnN1YWQXlT41MD3QHMrR5nZ2STE=;
        b=iL1fDy7NfxczM1mAnJdPihtaVKdKQmJlEFnEgC3DTgwbacG3AqtrH5lwE3x7aU5REY
         wVIhxj7WleMYae1MFSEN06ETH39TY1OnmzRnYI9sVz8DmdlKwFSSl8HmqCqVcuAujiyQ
         wB9GDayxyvvh12xamCwGII2AKuXMeoujSP4VCoPIjW3PNTmU1HsvANRn+AdKIt9JYKVj
         8XN3q1ffpVorGd1czmphfFE2W7QfOv3zJPDp28iqJmWoxL3fMhX8F0EI/plMk7etPJWl
         ChCIZ5Amxeu2b8BbYaALnSFqWmLpWhPaKsRVHMvYHgwpu9hbWG6mAdOoSfuAwRJIYw5d
         thjg==
X-Forwarded-Encrypted: i=1; AJvYcCXUKchC1glIeBF8ynBaEE4OIDBDQlYOhXwqKMoZitKad8LV06TUGtcEvF71JSUy8V3itugAG5+Oi3s5i+r+frs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxV+G5bE0mtMaaM6MZ0QsQ51qJfpFOn0xyeqAbDIjBOlYGnd7Iz
	6MkNSClC0DOoLReo7WFF/GMqL3EzEJ32RTvQxQNDpuT7JKiaV5XgOkYbtGR8N2N40E46+EqTjFT
	HkJ1G5x0sQ9o8ZOr1xIz5diXTRrsIY69J/8fwnfjHeA==
X-Gm-Gg: AY/fxX5dWeEnuOiWMRkSYleKJZClJDmtP9x80SeLoruMPD27943/Oy1dZLeZkFPrp8b
	EgIbickLjk/vhA97sS3VSXdKdU2GPn9eWlk5vN9+FngOYZb5FevtBNnNO/ZtXjZDDX9XMA2A4js
	geY+9+ybUqhe5ceH0+FnXPvgPLs/ZK2xMJW8rmlAbsZIr1+cevZsfbMAhBmMmaR3MLpK/l25ysQ
	3EcuynmwMI5MXGrthtxPurglGFrFFPg/D+Y1kn8lyV+lQ3xhLApyyKdPGgY+520WOhnX3JK
X-Google-Smtp-Source: AGHT+IF1X70vcMbCo//vNOMTJPe6PDMTQcCrPR6OhmP+p6OYR3zSBaixirxQtUcaPMSPQ+S9O6Jhc2kXI5ezwbWz93E=
X-Received: by 2002:a05:7022:2217:b0:11e:3e9:3e9b with SMTP id
 a92af1059eb24-121f8b60647mr1996083c88.6.1767837015975; Wed, 07 Jan 2026
 17:50:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260106005752.3784925-1-csander@purestorage.com>
 <20260106005752.3784925-10-csander@purestorage.com> <aV0PauBTiqWVQ-26@fedora>
 <CADUfDZryjLxVBFpk1c_NUp_GEWuWA=8UB6Vyx15tFUjQHGa_DQ@mail.gmail.com> <aV2onjve8cFAkJrV@fedora>
In-Reply-To: <aV2onjve8cFAkJrV@fedora>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Wed, 7 Jan 2026 17:50:04 -0800
X-Gm-Features: AQt7F2raE1boRJ58y7mh2B26ETbXka1IOznXbmS8xUYSwnyynOTLTf1QD0bJsUk
Message-ID: <CADUfDZqxU+egMQh3ejZo4n3jHo7EwaTS7LXm2+G+RV3wpOzT9A@mail.gmail.com>
Subject: Re: [PATCH v3 09/19] ublk: implement integrity user copy
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, Shuah Khan <shuah@kernel.org>, linux-block@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Stanley Zhang <stazhang@purestorage.com>, Uday Shankar <ushankar@purestorage.com>, 
	"Martin K . Petersen" <martin.petersen@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 6, 2026 at 4:28=E2=80=AFPM Ming Lei <ming.lei@redhat.com> wrote=
:
>
> On Tue, Jan 06, 2026 at 10:20:14AM -0800, Caleb Sander Mateos wrote:
> > On Tue, Jan 6, 2026 at 5:34=E2=80=AFAM Ming Lei <ming.lei@redhat.com> w=
rote:
> > >
> > > On Mon, Jan 05, 2026 at 05:57:41PM -0700, Caleb Sander Mateos wrote:
> > > > From: Stanley Zhang <stazhang@purestorage.com>
> > > >
> > > > Add a function ublk_copy_user_integrity() to copy integrity informa=
tion
> > > > between a request and a user iov_iter. This mirrors the existing
> > > > ublk_copy_user_pages() but operates on request integrity data inste=
ad of
> > > > regular data. Check UBLKSRV_IO_INTEGRITY_FLAG in iocb->ki_pos in
> > > > ublk_user_copy() to choose between copying data or integrity data.
> > > >
> > > > Signed-off-by: Stanley Zhang <stazhang@purestorage.com>
> > > > [csander: change offset units from data bytes to integrity data byt=
es,
> > > >  test UBLKSRV_IO_INTEGRITY_FLAG after subtracting UBLKSRV_IO_BUF_OF=
FSET,
> > > >  fix CONFIG_BLK_DEV_INTEGRITY=3Dn build,
> > > >  rebase on ublk user copy refactor]
> > > > Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
> > > > ---
> > > >  drivers/block/ublk_drv.c      | 52 +++++++++++++++++++++++++++++++=
++--
> > > >  include/uapi/linux/ublk_cmd.h |  4 +++
> > > >  2 files changed, 53 insertions(+), 3 deletions(-)
> > > >
> > > > diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> > > > index e44ab9981ef4..9694a4c1caa7 100644
> > > > --- a/drivers/block/ublk_drv.c
> > > > +++ b/drivers/block/ublk_drv.c
> > > > @@ -621,10 +621,15 @@ static inline unsigned ublk_pos_to_tag(loff_t=
 pos)
> > > >  {
> > > >       return ((pos - UBLKSRV_IO_BUF_OFFSET) >> UBLK_TAG_OFF) &
> > > >               UBLK_TAG_BITS_MASK;
> > > >  }
> > > >
> > > > +static inline bool ublk_pos_is_integrity(loff_t pos)
> > > > +{
> > > > +     return !!((pos - UBLKSRV_IO_BUF_OFFSET) & UBLKSRV_IO_INTEGRIT=
Y_FLAG);
> > > > +}
> > > > +
> > >
> > > It could be more readable to check UBLKSRV_IO_INTEGRITY_FLAG only.
> >
> > That's assuming that UBLK_TAG_BITS =3D 16 has more bits than are
> > strictly required by UBLK_MAX_QUEUE_DEPTH =3D 4096? Otherwise, adding
> > UBLKSRV_IO_BUF_OFFSET =3D 1 << 31 to tag << UBLK_TAG_OFF could overflow
> > into the QID bits, which could then overflow into
> > UBLKSRV_IO_INTEGRITY_FLAG. That seems like a very fragile assumption.
> > And if you want to rely on this assumption, why bother subtracting
> > UBLKSRV_IO_BUF_OFFSET in ublk_pos_to_hwq() either? The compiler should
> > easily be able to deduplicate the iocb->ki_pos - UBLKSRV_IO_BUF_OFFSET
> > computations, so I can't imagine it matters for performance.
>
> UBLKSRV_IO_INTEGRITY_FLAG should be defined as one flag starting from top
> bit(bit 62), then you will see it is just fine to check it directly.
>
> But it isn't a big deal to subtract UBLKSRV_IO_BUF_OFFSET or not here, I
> will leave it to you.
>
> >
> > >
> > > >  static void ublk_dev_param_basic_apply(struct ublk_device *ub)
> > > >  {
> > > >       const struct ublk_param_basic *p =3D &ub->params.basic;
> > > >
> > > >       if (p->attrs & UBLK_ATTR_READ_ONLY)
> > > > @@ -1047,10 +1052,37 @@ static size_t ublk_copy_user_pages(const st=
ruct request *req,
> > > >                       break;
> > > >       }
> > > >       return done;
> > > >  }
> > > >
> > > > +#ifdef CONFIG_BLK_DEV_INTEGRITY
> > > > +static size_t ublk_copy_user_integrity(const struct request *req,
> > > > +             unsigned offset, struct iov_iter *uiter, int dir)
> > > > +{
> > > > +     size_t done =3D 0;
> > > > +     struct bio *bio =3D req->bio;
> > > > +     struct bvec_iter iter;
> > > > +     struct bio_vec iv;
> > > > +
> > > > +     if (!blk_integrity_rq(req))
> > > > +             return 0;
> > > > +
> > > > +     bio_for_each_integrity_vec(iv, bio, iter) {
> > > > +             if (!ublk_copy_user_bvec(&iv, &offset, uiter, dir, &d=
one))
> > > > +                     break;
> > > > +     }
> > > > +
> > > > +     return done;
> > > > +}
> > > > +#else /* #ifdef CONFIG_BLK_DEV_INTEGRITY */
> > > > +static size_t ublk_copy_user_integrity(const struct request *req,
> > > > +             unsigned offset, struct iov_iter *uiter, int dir)
> > > > +{
> > > > +     return 0;
> > > > +}
> > > > +#endif /* #ifdef CONFIG_BLK_DEV_INTEGRITY */
> > > > +
> > > >  static inline bool ublk_need_map_req(const struct request *req)
> > > >  {
> > > >       return ublk_rq_has_data(req) && req_op(req) =3D=3D REQ_OP_WRI=
TE;
> > > >  }
> > > >
> > > > @@ -2654,10 +2686,12 @@ ublk_user_copy(struct kiocb *iocb, struct i=
ov_iter *iter, int dir)
> > > >  {
> > > >       struct ublk_device *ub =3D iocb->ki_filp->private_data;
> > > >       struct ublk_queue *ubq;
> > > >       struct request *req;
> > > >       struct ublk_io *io;
> > > > +     unsigned data_len;
> > > > +     bool is_integrity;
> > > >       size_t buf_off;
> > > >       u16 tag, q_id;
> > > >       ssize_t ret;
> > > >
> > > >       if (!user_backed_iter(iter))
> > > > @@ -2667,10 +2701,11 @@ ublk_user_copy(struct kiocb *iocb, struct i=
ov_iter *iter, int dir)
> > > >               return -EACCES;
> > > >
> > > >       tag =3D ublk_pos_to_tag(iocb->ki_pos);
> > > >       q_id =3D ublk_pos_to_hwq(iocb->ki_pos);
> > > >       buf_off =3D ublk_pos_to_buf_off(iocb->ki_pos);
> > > > +     is_integrity =3D ublk_pos_is_integrity(iocb->ki_pos);
> > >
> > > UBLKSRV_IO_INTEGRITY_FLAG can be set for device without UBLK_F_INTEGR=
ITY,
> > > so UBLK_F_INTEGRITY need to be checked in case of `is_integrity`.
> >
> > If UBLK_F_INTEGRITY isn't set, then UBLK_PARAM_TYPE_INTEGRITY isn't
> > allowed, so the ublk device won't support integrity data. Therefore,
> > blk_integrity_rq() will return false and ublk_copy_user_integrity()
> > will just return 0. Do you think it's important to return some error
> > code value instead? I would rather avoid the additional checks in the
> > hot path.
>
> The check could be zero cost, but better to fail the wrong usage than
> returning 0 silently, which may often imply big issue.

Not sure what you mean by "the check could be zero cost". It's 2
branches to check for UBLK_F_INTEGRITY in the ublk_device flags and to
check is_integrity. Even if the branches are predictable (and the
is_integrity one might not be), there's still some cost for computing
the conditions and taking up space in the branch history table.
A ublk server should already be checking that the return value from
the user copy syscall matches the passed in length. Otherwise, the
request's data was shorter than expected or a fault occurred while
accessing the userspace buffer. But if you feel strongly, I'll add an
explicit -EINVAL return code.

Best,
Caleb

