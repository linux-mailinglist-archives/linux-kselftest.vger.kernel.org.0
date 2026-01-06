Return-Path: <linux-kselftest+bounces-48321-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BB67CF9D22
	for <lists+linux-kselftest@lfdr.de>; Tue, 06 Jan 2026 18:45:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EA45631D2805
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 Jan 2026 17:34:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21EF0346E54;
	Tue,  6 Jan 2026 17:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="XO9wN6w3"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-dl1-f51.google.com (mail-dl1-f51.google.com [74.125.82.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CE31346781
	for <linux-kselftest@vger.kernel.org>; Tue,  6 Jan 2026 17:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767719760; cv=pass; b=U5xIkA+UaXWJipxb3bZ33O4fnkm4bFhXja9R5oFpDF626j6JYTHfZnHpMLhvAxFqRhCX+pQehzsSLsHhQG/ZjAt/N5orkGbpXETCy0aYA/BA5r3V7Ubu9kcWp2FhDWYl06Hx2ZYsfafiTtO12To8hzCuYrzwxTbtlqn1Hx/BOY0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767719760; c=relaxed/simple;
	bh=BcUKT/WaKF3cc5RT8cSr1Hmp5p8kpbrtWjAK1Grl5Fg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TA8/Aef4aXd9hsuns1APnl3ryw1I6bM6xPRT40vmPvRvMSddEmLke62KUUq1Toq+twbRi5nd9ABiZ7G9j84hAmY3whk0eM2XJbUTC46HnAYm7Qb7O+Bx//BHwMPSWorhcxnRpLabIWQdLzoU2NvrpZMuknbKuJZt7qozgWwMexM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=XO9wN6w3; arc=pass smtp.client-ip=74.125.82.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-dl1-f51.google.com with SMTP id a92af1059eb24-11f42eaff60so43191c88.3
        for <linux-kselftest@vger.kernel.org>; Tue, 06 Jan 2026 09:15:56 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1767719756; cv=none;
        d=google.com; s=arc-20240605;
        b=dEHAF3O450tzbl1Edr5eNzpnejOjAZwELUCGaaSjSJVWJ+/3uVG5fdU6R8MyTnEBRV
         UlhrNKvunK/BnEdWULzUUcKDX8AwLudQc+4/82QJwFdCOUTA+jBJcd6toQLAab82aJ3K
         N0Xib2U3nSyQhSHQPHvya0JjBY0PeA2Fhn03Wr/atXTW5XNtA9AxS9N7NJg/AIijm/G9
         r+iVaQAolnJEza4SX5OIWMztL8xPz2XY4q1g+8r6Pa3rRo6wc1MN8ySf3bZOAAfKTV2g
         0yJXC2BSl74KQy2nCE0ZQKqM7Xj6WRomMVDcx3Gor9DXsSwI3mAvqwCBhEbsiZTX46Mx
         ylmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=h0S9X35x1dPYmVywIfwy49RDgI1meLSZA2LdM4U3+6o=;
        fh=xn23xnKaI0/dJGQjw/2qkpcPyiJwdDraUfDqqn87uQE=;
        b=YoJShkplpKwy0zdahEQ+YbHDgOWP+4PNnUusXLTviFivU3auHpcwqp5+9nBtLhz40R
         FJc7lGECgQGiLCwDitrlGSIEUC6FcoKIFa+R/wf+JJ7Hmw4/74aGi0eONLskZB/E9NpQ
         oeqxyysFkZUwDi512Lb9xNhUMuL4WoiMHEGlH5c8Oke5a9MC1cOZBpyefJ64hU1xv7O7
         1XJNzRbP8Cb9IQpP4okNpG7qHPETc5pnHYBCbh2v99Waf+qcDrMlQ9EP5vI3+1RN6Ovb
         0iqWUa6o5hgTsiMoDloBODeF1m5U8lLKMDBfe1+PprrbNB97xHlCDyvMuKLX0UIsbKqU
         ATHw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1767719756; x=1768324556; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h0S9X35x1dPYmVywIfwy49RDgI1meLSZA2LdM4U3+6o=;
        b=XO9wN6w3Opl7nMwLomPxLAU98QSEE6/7I4oGQQFjM3wtnqQSdRDxJalKkX2vq3OsWg
         il5XdccSJfDz+Bv9lZGLKHbLnwj8mSjjhsc2zkLmIlXuevG/AQnRKeQh6oHHc0qrVBW+
         jbkcx+Y6QPmgOM1XRyHJUcpvOM4bXFMGuD3PzfkGba0SR6NsanQfg7hQoggDguDpJX5E
         fZabPw5l81W4yK05v1oooaBtbl9uKJKCnuzAyIxyLwoBmu2to7KoRXPJ8TZhzJZ/gN6B
         N3eFZgSF6O5q0n8nPdKLdOA6295ZYXhU7U5edlXeY5Byov89mRUg+WPKcgHAD+n3IzfZ
         zuCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767719756; x=1768324556;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=h0S9X35x1dPYmVywIfwy49RDgI1meLSZA2LdM4U3+6o=;
        b=G8yDtoKb+vz+0uCzP8mKQz3mnQOFSq8oJNJRCa+wnKhJlSdovp+FmasiIW9OGzVhlG
         JbncpJIdtaU+elpssl6Vd0E6oOlDwgKzbPsZhsUis2qMl+Ml/EnYzKotqsilgvC8Dzlg
         W7zJGiE/bLlVHh9v0NoJw+IhJUHvx+I7/vXd9QjHjH9s7M/3jMDn7hD1DRz3ReP5pvdQ
         5ajVDbYHiDyEECSfQB1Jjyiv4wND364k3Wwrxb2SYjEf9LACJvoveYc55Y7YbHnvFemD
         jIXiIcetMUaYS3lKz7bzRibgXRET73DOEbrKmtRUdDf/DclwilMGS1enx3fZiKrNeZo9
         HFEA==
X-Forwarded-Encrypted: i=1; AJvYcCWb/hYQj5bdcWd8OB+zNFHdsGgIjjDF3D11M248i8sX3P0+fMRhoJ4TK2TX5kghOEl3YogdekttamcwC91jQs4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxI1or+pykk2vq6jkTU3PxOEbXMn57+n3VpqA7YOyieOuA2/Qvo
	TpSv8HnUi4zlKxuXcVUonHpoKtwE/FAiTAHkiMavHSQJCL0kJeXTN/47Q0Dzuhkhb98cTaMZqa6
	9NCo/bIENyULB+KgncdGf+tTZHw9MAuYgHiBAyOuoNg==
X-Gm-Gg: AY/fxX73+Hz6JUIL8lSkcxANQh6NlbzU0ECK0h3eRZMrnhBBCRv+NsLzLSLEvw7c6eB
	g8NyryVk6e7e3SllHbx0T2MSwZNIspBQPUKgvlsZLpD1WIR5WbdukITGftcL+ZdBktuqV8rtIkh
	6dY08AJqub5QMhpSz2yIJoRg9zGtdccfujiy8ZZiwwBZZEsz8ociEnHdLXrgMkev+FigGrqpO/A
	/bnQXsJJka0UuvkmgTnlkSSs4VMKpGvYzshWG6DoVWC8sv727tC+uTRX+8QcD0DatZA7aiKaxOp
	usyvkQ8=
X-Google-Smtp-Source: AGHT+IHsx2prbXYg3j18SfdVTQFJ60Rbk1R0GsSR/Ko74ivczv03vINWOjHdxoRdXuVpHJS26gsubAcJWKCBQS4KIZA=
X-Received: by 2002:a05:7022:6195:b0:119:e56a:4fff with SMTP id
 a92af1059eb24-121f18e1ff2mr1694930c88.4.1767719756030; Tue, 06 Jan 2026
 09:15:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260106005752.3784925-1-csander@purestorage.com>
 <20260106005752.3784925-20-csander@purestorage.com> <aV0Xx2vWmL5Iuls4@fedora>
In-Reply-To: <aV0Xx2vWmL5Iuls4@fedora>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Tue, 6 Jan 2026 09:15:44 -0800
X-Gm-Features: AQt7F2oH1KSrEU_qjpFRn21_6eSA-1DRw6ns58qu5_CQ83y4Pw0aC2-PF1SPR9A
Message-ID: <CADUfDZofEg0Q=veyihy=M-XCxoga6fkueJmLdJ4CVd6KU=GdBg@mail.gmail.com>
Subject: Re: [PATCH v3 19/19] selftests: ublk: add end-to-end integrity test
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, Shuah Khan <shuah@kernel.org>, linux-block@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Stanley Zhang <stazhang@purestorage.com>, Uday Shankar <ushankar@purestorage.com>, 
	"Martin K . Petersen" <martin.petersen@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 6, 2026 at 6:10=E2=80=AFAM Ming Lei <ming.lei@redhat.com> wrote=
:
>
> On Mon, Jan 05, 2026 at 05:57:51PM -0700, Caleb Sander Mateos wrote:
> > Add test case loop_08 to verify the ublk integrity data flow. It uses
> > the kublk loop target to create a ublk device with integrity on top of
> > backing data and integrity files. It then writes to the whole device
> > with fio configured to generate integrity data. Then it reads back the
> > whole device with fio configured to verify the integrity data.
> > It also verifies that injected guard, reftag, and apptag corruptions ar=
e
> > correctly detected.
> >
> > Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
> > ---
> >  tools/testing/selftests/ublk/Makefile        |   1 +
> >  tools/testing/selftests/ublk/test_loop_08.sh | 111 +++++++++++++++++++
> >  2 files changed, 112 insertions(+)
> >  create mode 100755 tools/testing/selftests/ublk/test_loop_08.sh
> >
> > diff --git a/tools/testing/selftests/ublk/Makefile b/tools/testing/self=
tests/ublk/Makefile
> > index bfd68ae64142..ab745443fd58 100644
> > --- a/tools/testing/selftests/ublk/Makefile
> > +++ b/tools/testing/selftests/ublk/Makefile
> > @@ -33,10 +33,11 @@ TEST_PROGS +=3D test_loop_02.sh
> >  TEST_PROGS +=3D test_loop_03.sh
> >  TEST_PROGS +=3D test_loop_04.sh
> >  TEST_PROGS +=3D test_loop_05.sh
> >  TEST_PROGS +=3D test_loop_06.sh
> >  TEST_PROGS +=3D test_loop_07.sh
> > +TEST_PROGS +=3D test_loop_08.sh
> >  TEST_PROGS +=3D test_stripe_01.sh
> >  TEST_PROGS +=3D test_stripe_02.sh
> >  TEST_PROGS +=3D test_stripe_03.sh
> >  TEST_PROGS +=3D test_stripe_04.sh
> >  TEST_PROGS +=3D test_stripe_05.sh
> > diff --git a/tools/testing/selftests/ublk/test_loop_08.sh b/tools/testi=
ng/selftests/ublk/test_loop_08.sh
> > new file mode 100755
> > index 000000000000..ca289cfb2ad4
> > --- /dev/null
> > +++ b/tools/testing/selftests/ublk/test_loop_08.sh
> > @@ -0,0 +1,111 @@
> > +#!/bin/bash
> > +# SPDX-License-Identifier: GPL-2.0
> > +
> > +. "$(cd "$(dirname "$0")" && pwd)"/test_common.sh
> > +
> > +if ! _have_program fio; then
> > +     exit $UBLK_SKIP_CODE
> > +fi
> > +
> > +fio_version=3D$(fio --version)
> > +if [[ "$fio_version" =3D~ fio-[0-9]+\.[0-9]+$ ]]; then
> > +     echo "Requires development fio version with https://github.com/ax=
boe/fio/pull/1992"
> > +     exit $UBLK_SKIP_CODE
> > +fi
> > +
> > +TID=3Dloop_08
> > +
> > +_prep_test "loop" "end-to-end integrity"
> > +
> > +_create_backfile 0 256M
> > +_create_backfile 1 32M # 256M * (64 integrity bytes / 512 data bytes)
> > +integrity_params=3D"--integrity_capable --integrity_reftag
> > +                  --metadata_size 64 --pi_offset 56 --csum_type t10dif=
"
> > +dev_id=3D$(_add_ublk_dev -t loop -u $integrity_params "${UBLK_BACKFILE=
S[@]}")
>
> I tried above setting:
>
> ./kublk add -t loop --integrity_capable --integrity_reftag --metadata_siz=
e 64 --pi_offset 56 --csum_type t10dif --foreground -u /dev/sdb /dev/sdc
> dev id 1: nr_hw_queues 2 queue_depth 128 block size 512 dev_capacity 8388=
608
>         max rq size 1048576 daemon pid 38295 flags 0x160c2 state LIVE
>         queue 0: affinity(0 )
>         queue 1: affinity(8 )
>
> However, IO error is always triggered:
>
> [ 9202.316382] ublkb1: ref tag error at location 0 (rcvd 128)
> [ 9202.317171] Buffer I/O error on dev ublkb1, logical block 0, async pag=
e read

Hmm, what are the initial contents of /dev/sdc? It looks like they are
nonzero, as the reftag being read for logical block 0 is 128 rather
than the expected 0 (the reftag would be read from bytes 60 to 63 of
/dev/sdc). In general, though, the partition scan may be expected to
fail the bio-integrity-auto checks if the integrity data hasn't been
initialized. I don't think this is an issue, since the partition scan
is looking for a partition table but there's no guarantee that one
exists.
You can disable the kernel integrity checks if you want by writing 0
to /sys/block/ublkb1/integrity/read_verify. However, I'm not sure it's
possible to do this soon enough to take effect before the partition
scan.
We could also use the UBLK_F_NO_AUTO_PART_SCAN feature, once it lands,
to suppress the partition scan and these error messages.

Best,
Caleb

> [ 9202.319478] ublkb1: ref tag error at location 0 (rcvd 128)
> [ 9202.319983] Buffer I/O error on dev ublkb1, logical block 0, async pag=
e read
> [ 9202.326332] ublkb1: ref tag error at location 0 (rcvd 128)
> [ 9202.326974] Buffer I/O error on dev ublkb1, logical block 0, async pag=
e read
> [ 9202.327570] ldm_validate_partition_table(): Disk read failed.
> [ 9202.336539] ublkb1: ref tag error at location 0 (rcvd 128)
> [ 9202.337228] Buffer I/O error on dev ublkb1, logical block 0, async pag=
e read
> [ 9202.339247] ublkb1: ref tag error at location 0 (rcvd 128)
> [ 9202.339779] Buffer I/O error on dev ublkb1, logical block 0, async pag=
e read
> [ 9202.344306] ublkb1: ref tag error at location 0 (rcvd 128)
> [ 9202.344948] Buffer I/O error on dev ublkb1, logical block 0, async pag=
e read
> [ 9202.347067] ublkb1: ref tag error at location 0 (rcvd 128)
> [ 9202.347558] Buffer I/O error on dev ublkb1, logical block 0, async pag=
e read
> [ 9202.348100] Dev ublkb1: unable to read RDB block 0
> [ 9202.350159] ublkb1: ref tag error at location 0 (rcvd 128)
> [ 9202.350642] Buffer I/O error on dev ublkb1, logical block 0, async pag=
e read
> [ 9202.354977] ublkb1: ref tag error at location 0 (rcvd 128)
> [ 9202.355539] Buffer I/O error on dev ublkb1, logical block 0, async pag=
e read
> [ 9202.356280]  ublkb1: unable to read partition table
>
>
>
> Thanks,
> Ming
>

