Return-Path: <linux-kselftest+bounces-48784-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A3142D14C5F
	for <lists+linux-kselftest@lfdr.de>; Mon, 12 Jan 2026 19:29:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 79DFA301832A
	for <lists+linux-kselftest@lfdr.de>; Mon, 12 Jan 2026 18:29:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A840B3876A7;
	Mon, 12 Jan 2026 18:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="EWhXdRjy"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-dl1-f49.google.com (mail-dl1-f49.google.com [74.125.82.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 830DC387583
	for <linux-kselftest@vger.kernel.org>; Mon, 12 Jan 2026 18:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768242578; cv=pass; b=Hv6H3oM6hkivVvRS3bQ6J8w1Uqqhfsx2K7P4CxJURASIqDfdLa7SnDPE5h1rMRdmGjPsbYPzUfcr4VeASbFKZ/AhHr88aly0qlVe6ZOeYDqX0txfA+ia0JnOMa/A70JpP0lCb6sBXbv+Mc6QEj44ZbOpWUf9FNKUQA59EAa2+8A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768242578; c=relaxed/simple;
	bh=FUpHOPt4IEgZcX0r1LogNpavV3zSOIqpKbst42N5uaA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F00JMudaqBnGaRgzhQM0TW37fpaS9w1mk+nxchBO/j3BeZTvdQpS6zV3SozZimu78MDUxnZlKJBApgziIPRehA3XxY9MJZNhUNk7SZ45N2PfNkrvPv2CHGfK9c45SU5fl/TAhWhv9p14eW7RPJHPDpvrbPdm420vmDGYKYpi4TE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=EWhXdRjy; arc=pass smtp.client-ip=74.125.82.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-dl1-f49.google.com with SMTP id a92af1059eb24-121a15dacd1so499460c88.1
        for <linux-kselftest@vger.kernel.org>; Mon, 12 Jan 2026 10:29:36 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768242576; cv=none;
        d=google.com; s=arc-20240605;
        b=cIN56RvISGL20F7wYyRjtK7iMLJDnIhGheTmrO+o74s/wcwG38A6T4dKNFQKWm9Iy+
         D779cmLHwZMgmybBKOX3BMJzvWlEWNenhvrNuAKHwvPW7ptGlGvOJZ2HGMl/N+5U0l5v
         dlc8t9zGnrEYT06M40rw5pgSeqzw+UW4jP1w5A62+C4FKDVROj3+Y0rufi5i8m83zzvm
         huTpZ54xjXDGj7iHTLCfVSv3tAMiKpxOmTloMAfitiq0so1bygdsPRfc944/hS16JV/4
         v20OzB6Ro7pikZWf7uPTRMxPNTJR4V8UHAqTjPj0VUKhW6LGl4qQOTPdA+q43vFQmtdr
         VNGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ogd853Kk4ubl3A3TV6d4A1RR6W2yCsORLXTCLFqIUIY=;
        fh=FxHZs/2CYNtIrqgqNob5EJ0pMrEHaGeZ9rs2ZB9YX60=;
        b=RzqLxauN8xiVKIuNRroWiMs9KRavQFDCczShmzYElLxrUohj1e9n64jjxh3QwlWMt6
         BZUxOWlYcL60sbiSMmPbfU7tNhLLB+2Ufqh2e+gcAOCcxnljOyEMLia/Mu5cw7AE8vSu
         saJLzb777jBZ4UyuJM7k+Tiw+OVz++8JLY1zeSjk7sJmNoQzeU9ycW24WBd+KxwZqcNo
         0zytXj9CFsAQiL61i1+v4WXQd3Pt6a4eofZJG5UEP7hblZB86T6oetj1qMVdiKM81MUp
         lRt1B0OPUNowgU3yZziI9wQ7XtiQTrajv0jzQjHfnc7HEEsvwIQgILWWBKBZMbjutNn6
         Gwng==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1768242576; x=1768847376; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ogd853Kk4ubl3A3TV6d4A1RR6W2yCsORLXTCLFqIUIY=;
        b=EWhXdRjys9U8oWSyDTKqpLqI6y+xeaKZtwZpPmqFp5pxgmIr1Is4buV5af6J7vF4E4
         7us5kPcrne6eIELwDZ5nX+iYfpFUAiTuUaqqH4D9Vy7W6OQKFzMt240v91xLlFjrzLqo
         gqy30lh+2VoCu6lNptgZYMqMXmFFbKaa202Eu88pEirKcOG21FmoYq+D5UJHAzCGwMRU
         sQ3EeCpDsUZ2CPUqudmt8uRHlmbg4Cejh26Fa0GV29HPXIUMQP59YRWfYg+SXlQ6L69L
         +8191zi939GwNNMzzRbSs22cghb7k8zQD+g65Hn9zmPLLlfvNbn9hCZlTUXGLVuWWwy9
         dDmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768242576; x=1768847376;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ogd853Kk4ubl3A3TV6d4A1RR6W2yCsORLXTCLFqIUIY=;
        b=Y8xMJ4V0T1onClcLGEHdRamxKyQPKuLUb1u/XVuQDgqQZTABFzK9SSoZ5U7cr1jZaI
         eYTN8zCHW5TOXk2fV0LCpm86eyKaKQMhDoWv/5m2B73V4OHoNTPNI+oM7ZzxiJrTaZJu
         eVwEHOy9qu8bRqmxnvh9FcTZl5uZDUA2AcRAjwwD4GGmyaQ7xdUR4YnIIpKjMf5d33VR
         1PkF05HAeFgIwmGrK2+02UBFA9TQX+zhlyV9ENmqr7RpvL+STfTGJR7qzsn/upUpBONS
         DfXjSf60cb0e6khq/7kNlCmlc5d/S5T1rc7g1dEYLy4/hW38B6vxqeUQJqwsuxxpPcfp
         3U1g==
X-Forwarded-Encrypted: i=1; AJvYcCXvgwf+/6uk5W5IMxZXEi08ZwSvjzFFbtlyMsXfrSyMpoezygzyOh2jwgI164mt18XrPi5vyNA7cXzIVfulleI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSN3cjObL7zdx2T25bxab9EUQDp31AtEI0YX/lAegF7ZTSMzQc
	zY9LHshiQwDaVfRtSJc/06PxW50OERAHfxmJXDqME/3g6ieUQG57qVDehTBdaTQ9J88puRPGSX9
	IPf1YQ4DwJEZCkBvluf1dExWg4ti2oW6O3o/YaHCQfg==
X-Gm-Gg: AY/fxX5u9iUOCi8hp1L9BvRFz6mFDeoZFUdb/0OC/wlGdOXb7jsfEqF6+pdrllz4+2r
	h0ZzHs3gWFf9KwPjrg0NgxSRTQBwU28dNHq/iTr+4db193aE9rguBGOk8VHenj8aZzMkd/Hv4wQ
	4LLpSYbEHPQIoBXfogcLvz/f86+x41Z/SMeSDznHfjZEacRKwWkW24zf2r1DXuGVzKXimlxWh+u
	x3wOMIEKGlJTRK3UTbZ11qqDgNKWK3EWTboOwiOrxGtrJsI2OnvxslwlK6lx5pF0/d+6BZd
X-Google-Smtp-Source: AGHT+IHM5mdp2ESFbQnQHup/EVrjeLulpF3EjsgWvB8/FOYUzcdsyBgaH98XYKE3lyl6wNQPNUR2nsmM6vwuE9x3X7k=
X-Received: by 2002:a05:7022:799:b0:119:e56b:46b7 with SMTP id
 a92af1059eb24-121f8abf499mr10911260c88.1.1768242575232; Mon, 12 Jan 2026
 10:29:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260108091948.1099139-1-csander@purestorage.com>
 <20260108091948.1099139-9-csander@purestorage.com> <f0c205d9-609f-4b08-af67-3d8730eb6fce@zazolabs.com>
In-Reply-To: <f0c205d9-609f-4b08-af67-3d8730eb6fce@zazolabs.com>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Mon, 12 Jan 2026 10:29:23 -0800
X-Gm-Features: AZwV_Qide7yvit3jonWa-fQp0nnmgkkOuuK8FL6QKxDxsErOmM1S8B6V58DEkss
Message-ID: <CADUfDZrAx-ALGpNckfZOwR2LUqQMYud9cb14bMp1SW_E12isLg@mail.gmail.com>
Subject: Re: [PATCH v4 08/19] ublk: move offset check out of __ublk_check_and_get_req()
To: alex+zkern@zazolabs.com
Cc: Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>, Shuah Khan <shuah@kernel.org>, 
	linux-block@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Stanley Zhang <stazhang@purestorage.com>, 
	Uday Shankar <ushankar@purestorage.com>, 
	"Martin K . Petersen" <martin.petersen@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 12, 2026 at 10:17=E2=80=AFAM Alexander Atanasov <alex@zazolabs.=
com> wrote:
>
> On 8.01.26 11:19, Caleb Sander Mateos wrote:
> > __ublk_check_and_get_req() checks that the passed in offset is within
> > the data length of the specified ublk request. However, only user copy
> > (ublk_check_and_get_req()) supports accessing ublk request data at a
> > nonzero offset. Zero-copy buffer registration (ublk_register_io_buf())
> > always passes 0 for the offset, so the check is unnecessary. Move the
> > check from __ublk_check_and_get_req() to ublk_check_and_get_req().
> >
> > Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
> > Reviewed-by: Ming Lei <ming.lei@redhat.com>
> > ---
> >   drivers/block/ublk_drv.c | 16 +++++++++-------
> >   1 file changed, 9 insertions(+), 7 deletions(-)
> >
> > diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> > index e7697dc4a812..8eefb838b563 100644
> > --- a/drivers/block/ublk_drv.c
> > +++ b/drivers/block/ublk_drv.c
> > @@ -253,11 +253,11 @@ struct ublk_params_header {
> >
>
> [snip]
>
> > @@ -2603,13 +2603,10 @@ static inline struct request *__ublk_check_and_=
get_req(struct ublk_device *ub,
> >               goto fail_put;
> >
> >       if (!ublk_rq_has_data(req))
> >               goto fail_put;
> >
> > -     if (offset > blk_rq_bytes(req))
> > -             goto fail_put;
> > -
> >       return req;
> >   fail_put:
> >       ublk_put_req_ref(io, req);
> >       return NULL;
> >   }
> > @@ -2687,14 +2684,19 @@ ublk_user_copy(struct kiocb *iocb, struct iov_i=
ter *iter, int dir)
> >
> >       if (tag >=3D ub->dev_info.queue_depth)
> >               return -EINVAL;
> >
> >       io =3D &ubq->ios[tag];
> > -     req =3D __ublk_check_and_get_req(ub, q_id, tag, io, buf_off);
> > +     req =3D __ublk_check_and_get_req(ub, q_id, tag, io);
> >       if (!req)
> >               return -EINVAL;
> >
> > +     if (buf_off > blk_rq_bytes(req)) {
> > +             ret =3D -EINVAL;
> > +             goto out;
> > +     }
> > +
>
> Offset is zero based, bytes are count so it should be >=3D here.
>
> It will work this way but for buf_off =3D=3D blk_rq_bytes(req) user will =
get
> 0 instead of EINVAL.

This is the existing behavior in __ublk_check_and_get_req(). I agree
allowing buf_off =3D=3D blk_rq_bytes(req) seems odd, but changing it now
could break ublk servers relying on the current behavior.

Best,
Caleb

>
> static size_t ublk_copy_user_pages(const struct request *req,
>                  unsigned offset, struct iov_iter *uiter, int dir)
> {
>         size_t done =3D 0;
> ...
>          rq_for_each_segment(bv, req, iter) {
> ...
>                  if (offset >=3D bv.bv_len) {
>                          offset -=3D bv.bv_len; // bv_len is same as
> blk_rq_bytes(req)
>                          continue; // this breaks the loop when =3D=3D
>                  }
> ...
>         }
>         return done; // done is never incremented
> }
>
> >       if (!ublk_check_ubuf_dir(req, dir)) {
> >               ret =3D -EACCES;
> >               goto out;
> >       }
>
>
> --
> have fun,
> alex
>

