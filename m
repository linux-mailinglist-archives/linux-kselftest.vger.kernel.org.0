Return-Path: <linux-kselftest+bounces-48361-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 95007CFBA01
	for <lists+linux-kselftest@lfdr.de>; Wed, 07 Jan 2026 02:49:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 641C7301F8FA
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Jan 2026 01:49:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEEAC221F17;
	Wed,  7 Jan 2026 01:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AJWZZSCI"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB6571DF73A
	for <linux-kselftest@vger.kernel.org>; Wed,  7 Jan 2026 01:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767750565; cv=none; b=kdTsR6gnLb/1cYSuY432dj2dO5s3ZNzvZRM9RS1v8q84gr37E6Mm9xiq23PP7cXzHVB7cTzw4T9Ow45NvrjgIRyiOIVT8K/rdFCjGZv/lLtWqffYSLlPAu99QBvh8HjSncfH/U2NQTTs65iVYCV42PSZr2AM4jHJqAQvR4d02gs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767750565; c=relaxed/simple;
	bh=8I9GjT/4xhIQfGV/EeWjbsnhm76msuHZvA8sis7Ux98=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FIJ3lE+fZC+Qq9+pICbIwbGRYSwxrQ15WjVQwWnYnhIt/yly2mfRBREb0pHNgoB4inFKBwDEJsMAIFf3E+Y2qIZ0r76ykqe142xKhtvZ14AwXe229+CpXiFDMpDDwAshomd5+94zKWu9b1wbRmXb3K3HLssXH7ENv1rvVHHRnEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AJWZZSCI; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767750562;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=z7n07AXa/uxY2FhXvpHcqjQsS4quypAabMIl3o2rtV0=;
	b=AJWZZSCINJrylQAuL1KqCp1H6DuDY5FFwLHikXi2W4f7m6sxNSCu1TOZlEiZwa7GhBbawJ
	UqdrCU0PDbLNCAqD13oxwvAcRWR0nGPn8VlIft+wm+JsX2NG7LC8vOLByiu9efFoFTHhlT
	QiuzchGPbvC9IApWhvzxsaKQIhULujs=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-472-Q-IFH2yRPOyvs2n4SE0AUg-1; Tue,
 06 Jan 2026 20:49:19 -0500
X-MC-Unique: Q-IFH2yRPOyvs2n4SE0AUg-1
X-Mimecast-MFC-AGG-ID: Q-IFH2yRPOyvs2n4SE0AUg_1767750557
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 60E921800669;
	Wed,  7 Jan 2026 01:49:17 +0000 (UTC)
Received: from fedora (unknown [10.72.116.130])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0084219560A7;
	Wed,  7 Jan 2026 01:49:11 +0000 (UTC)
Date: Wed, 7 Jan 2026 09:49:06 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Jens Axboe <axboe@kernel.dk>, Shuah Khan <shuah@kernel.org>,
	linux-block@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Stanley Zhang <stazhang@purestorage.com>,
	Uday Shankar <ushankar@purestorage.com>,
	"Martin K . Petersen" <martin.petersen@oracle.com>
Subject: Re: [PATCH v3 19/19] selftests: ublk: add end-to-end integrity test
Message-ID: <aV27kuSGuKdsL39E@fedora>
References: <20260106005752.3784925-1-csander@purestorage.com>
 <20260106005752.3784925-20-csander@purestorage.com>
 <aV0Xx2vWmL5Iuls4@fedora>
 <CADUfDZofEg0Q=veyihy=M-XCxoga6fkueJmLdJ4CVd6KU=GdBg@mail.gmail.com>
 <aV2m9yoxoTSxwCFN@fedora>
 <CADUfDZr5K9WztPnek1t1xnej6ALtyG_9yf9=ZGhVcHhqmyzx3g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADUfDZr5K9WztPnek1t1xnej6ALtyG_9yf9=ZGhVcHhqmyzx3g@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On Tue, Jan 06, 2026 at 05:32:29PM -0800, Caleb Sander Mateos wrote:
> On Tue, Jan 6, 2026 at 4:21 PM Ming Lei <ming.lei@redhat.com> wrote:
> >
> > On Tue, Jan 06, 2026 at 09:15:44AM -0800, Caleb Sander Mateos wrote:
> > > On Tue, Jan 6, 2026 at 6:10 AM Ming Lei <ming.lei@redhat.com> wrote:
> > > >
> > > > On Mon, Jan 05, 2026 at 05:57:51PM -0700, Caleb Sander Mateos wrote:
> > > > > Add test case loop_08 to verify the ublk integrity data flow. It uses
> > > > > the kublk loop target to create a ublk device with integrity on top of
> > > > > backing data and integrity files. It then writes to the whole device
> > > > > with fio configured to generate integrity data. Then it reads back the
> > > > > whole device with fio configured to verify the integrity data.
> > > > > It also verifies that injected guard, reftag, and apptag corruptions are
> > > > > correctly detected.
> > > > >
> > > > > Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
> > > > > ---
> > > > >  tools/testing/selftests/ublk/Makefile        |   1 +
> > > > >  tools/testing/selftests/ublk/test_loop_08.sh | 111 +++++++++++++++++++
> > > > >  2 files changed, 112 insertions(+)
> > > > >  create mode 100755 tools/testing/selftests/ublk/test_loop_08.sh
> > > > >
> > > > > diff --git a/tools/testing/selftests/ublk/Makefile b/tools/testing/selftests/ublk/Makefile
> > > > > index bfd68ae64142..ab745443fd58 100644
> > > > > --- a/tools/testing/selftests/ublk/Makefile
> > > > > +++ b/tools/testing/selftests/ublk/Makefile
> > > > > @@ -33,10 +33,11 @@ TEST_PROGS += test_loop_02.sh
> > > > >  TEST_PROGS += test_loop_03.sh
> > > > >  TEST_PROGS += test_loop_04.sh
> > > > >  TEST_PROGS += test_loop_05.sh
> > > > >  TEST_PROGS += test_loop_06.sh
> > > > >  TEST_PROGS += test_loop_07.sh
> > > > > +TEST_PROGS += test_loop_08.sh
> > > > >  TEST_PROGS += test_stripe_01.sh
> > > > >  TEST_PROGS += test_stripe_02.sh
> > > > >  TEST_PROGS += test_stripe_03.sh
> > > > >  TEST_PROGS += test_stripe_04.sh
> > > > >  TEST_PROGS += test_stripe_05.sh
> > > > > diff --git a/tools/testing/selftests/ublk/test_loop_08.sh b/tools/testing/selftests/ublk/test_loop_08.sh
> > > > > new file mode 100755
> > > > > index 000000000000..ca289cfb2ad4
> > > > > --- /dev/null
> > > > > +++ b/tools/testing/selftests/ublk/test_loop_08.sh
> > > > > @@ -0,0 +1,111 @@
> > > > > +#!/bin/bash
> > > > > +# SPDX-License-Identifier: GPL-2.0
> > > > > +
> > > > > +. "$(cd "$(dirname "$0")" && pwd)"/test_common.sh
> > > > > +
> > > > > +if ! _have_program fio; then
> > > > > +     exit $UBLK_SKIP_CODE
> > > > > +fi
> > > > > +
> > > > > +fio_version=$(fio --version)
> > > > > +if [[ "$fio_version" =~ fio-[0-9]+\.[0-9]+$ ]]; then
> > > > > +     echo "Requires development fio version with https://github.com/axboe/fio/pull/1992"
> > > > > +     exit $UBLK_SKIP_CODE
> > > > > +fi
> > > > > +
> > > > > +TID=loop_08
> > > > > +
> > > > > +_prep_test "loop" "end-to-end integrity"
> > > > > +
> > > > > +_create_backfile 0 256M
> > > > > +_create_backfile 1 32M # 256M * (64 integrity bytes / 512 data bytes)
> > > > > +integrity_params="--integrity_capable --integrity_reftag
> > > > > +                  --metadata_size 64 --pi_offset 56 --csum_type t10dif"
> > > > > +dev_id=$(_add_ublk_dev -t loop -u $integrity_params "${UBLK_BACKFILES[@]}")
> > > >
> > > > I tried above setting:
> > > >
> > > > ./kublk add -t loop --integrity_capable --integrity_reftag --metadata_size 64 --pi_offset 56 --csum_type t10dif --foreground -u /dev/sdb /dev/sdc
> > > > dev id 1: nr_hw_queues 2 queue_depth 128 block size 512 dev_capacity 8388608
> > > >         max rq size 1048576 daemon pid 38295 flags 0x160c2 state LIVE
> > > >         queue 0: affinity(0 )
> > > >         queue 1: affinity(8 )
> > > >
> > > > However, IO error is always triggered:
> > > >
> > > > [ 9202.316382] ublkb1: ref tag error at location 0 (rcvd 128)
> > > > [ 9202.317171] Buffer I/O error on dev ublkb1, logical block 0, async page read
> > >
> > > Hmm, what are the initial contents of /dev/sdc? It looks like they are
> > > nonzero, as the reftag being read for logical block 0 is 128 rather
> > > than the expected 0 (the reftag would be read from bytes 60 to 63 of
> > > /dev/sdc). In general, though, the partition scan may be expected to
> > > fail the bio-integrity-auto checks if the integrity data hasn't been
> > > initialized. I don't think this is an issue, since the partition scan
> > > is looking for a partition table but there's no guarantee that one
> > > exists.
> > > You can disable the kernel integrity checks if you want by writing 0
> > > to /sys/block/ublkb1/integrity/read_verify. However, I'm not sure it's
> > > possible to do this soon enough to take effect before the partition
> > > scan.
> > > We could also use the UBLK_F_NO_AUTO_PART_SCAN feature, once it lands,
> > > to suppress the partition scan and these error messages.
> >
> > UBLK_F_NO_AUTO_PART_SCAN can't avoid the following read failure.
> 
> Are you saying the reads aren't coming from the partition scan? What
> else would be issuing reads to the ublk device before fio is run on
> it?

I mean people can run fio read after disk is setup, or udev may read disk
in background.

> 
> >
> > I guess the issue can be avoided by adding small superblock to the meta
> > data file, then format it in the 1st time when superblock doesn't exist.
> 
> Not sure the complexity of a superblock is necessary. Could just
> initialize all the protection information with valid reftags and guard
> tags.

For verification purpose, the superblock can include only the info if PI meta
file is formatted or not. But it isn't a big deal if the meta backfile can
be formatted with tags in the specified setting.

> 
> >
> > This way will make it usable from test/verify purpose.
> 
> I'm still not following why it's not "usable" currently. Only blocks
> that have been written to (with protection information generated by
> fio or the kernel) can be read back, but that's how block devices are
> expected to be used. It seems fine to me for test purposes.
> test_loop_08.sh writes to the full ublk device before verifying it, so
> it shouldn't encounter any invalid reftags.

It triggers READ error easily, and will cause noisy report, just like
what I did...

Also you can't run FS test workload...


Thanks,
Ming


