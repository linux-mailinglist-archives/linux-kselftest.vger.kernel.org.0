Return-Path: <linux-kselftest+bounces-48354-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 90D1BCFB719
	for <lists+linux-kselftest@lfdr.de>; Wed, 07 Jan 2026 01:21:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EF3093025158
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Jan 2026 00:21:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BB54156F20;
	Wed,  7 Jan 2026 00:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hf6RobgE"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EBC0DF76
	for <linux-kselftest@vger.kernel.org>; Wed,  7 Jan 2026 00:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767745289; cv=none; b=B9jbTSQrMQwQc89j8UASInLoXTDOK2ANdQIj/w5G9cvVpHpbKMRlW8qEz0Bp0E9uD7MVsLMzF7/6Xw4B7BqydaMj1bLjmzWaVOpJY+KoNk0vZkiAbBLcChjjxevdqySopy3nKV1u6mY2hDbm3wWhBq8CcjgXA6VVokZqSk8NY9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767745289; c=relaxed/simple;
	bh=G1qRH18gNZ7PbelegWWfFwRrYaiG1Y8q3gk9uJIKtaE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=orZWrGJy1+amEe1VDAZDG24DgR9PmuDvI+XRKnEt1943W8g4CdqM4b20xaeui5WIIl2HxoN4Beu8uG1VZStbq8BgWtH03IuVcMKLpL97oBlRULqUyQhMsQsvLmlKfCCr+3ynC72DdyV3UXdQesTthu3uVHAS9K+8eYrPX79tLFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hf6RobgE; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767745286;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zE6vt8NA0l3DWsX3pagRXICkR2XCk1IgpKjyvQAhOf4=;
	b=hf6RobgEaR1Ydu9ClEneZU+ZJznqhwJp1TQVjUWtpQOmvywA0gsL3ZBNgBhcMZC4EJfx3p
	SO6TcMloysqqUyO2VXg6c9yB64SkSpl5Cw9bYz0FmkkZ/tdPNMRaPTVyuPSSMBaHGwRDlk
	YeIld5ZW3MBFEtO1fEfEfGv6u/dLcIE=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-247-XF3f2VEbPCybXZAEJXkZ_g-1; Tue,
 06 Jan 2026 19:21:23 -0500
X-MC-Unique: XF3f2VEbPCybXZAEJXkZ_g-1
X-Mimecast-MFC-AGG-ID: XF3f2VEbPCybXZAEJXkZ_g_1767745282
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BC2591956046;
	Wed,  7 Jan 2026 00:21:21 +0000 (UTC)
Received: from fedora (unknown [10.72.116.130])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 593EC19560A7;
	Wed,  7 Jan 2026 00:21:15 +0000 (UTC)
Date: Wed, 7 Jan 2026 08:21:11 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Jens Axboe <axboe@kernel.dk>, Shuah Khan <shuah@kernel.org>,
	linux-block@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Stanley Zhang <stazhang@purestorage.com>,
	Uday Shankar <ushankar@purestorage.com>,
	"Martin K . Petersen" <martin.petersen@oracle.com>
Subject: Re: [PATCH v3 19/19] selftests: ublk: add end-to-end integrity test
Message-ID: <aV2m9yoxoTSxwCFN@fedora>
References: <20260106005752.3784925-1-csander@purestorage.com>
 <20260106005752.3784925-20-csander@purestorage.com>
 <aV0Xx2vWmL5Iuls4@fedora>
 <CADUfDZofEg0Q=veyihy=M-XCxoga6fkueJmLdJ4CVd6KU=GdBg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADUfDZofEg0Q=veyihy=M-XCxoga6fkueJmLdJ4CVd6KU=GdBg@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On Tue, Jan 06, 2026 at 09:15:44AM -0800, Caleb Sander Mateos wrote:
> On Tue, Jan 6, 2026 at 6:10 AM Ming Lei <ming.lei@redhat.com> wrote:
> >
> > On Mon, Jan 05, 2026 at 05:57:51PM -0700, Caleb Sander Mateos wrote:
> > > Add test case loop_08 to verify the ublk integrity data flow. It uses
> > > the kublk loop target to create a ublk device with integrity on top of
> > > backing data and integrity files. It then writes to the whole device
> > > with fio configured to generate integrity data. Then it reads back the
> > > whole device with fio configured to verify the integrity data.
> > > It also verifies that injected guard, reftag, and apptag corruptions are
> > > correctly detected.
> > >
> > > Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
> > > ---
> > >  tools/testing/selftests/ublk/Makefile        |   1 +
> > >  tools/testing/selftests/ublk/test_loop_08.sh | 111 +++++++++++++++++++
> > >  2 files changed, 112 insertions(+)
> > >  create mode 100755 tools/testing/selftests/ublk/test_loop_08.sh
> > >
> > > diff --git a/tools/testing/selftests/ublk/Makefile b/tools/testing/selftests/ublk/Makefile
> > > index bfd68ae64142..ab745443fd58 100644
> > > --- a/tools/testing/selftests/ublk/Makefile
> > > +++ b/tools/testing/selftests/ublk/Makefile
> > > @@ -33,10 +33,11 @@ TEST_PROGS += test_loop_02.sh
> > >  TEST_PROGS += test_loop_03.sh
> > >  TEST_PROGS += test_loop_04.sh
> > >  TEST_PROGS += test_loop_05.sh
> > >  TEST_PROGS += test_loop_06.sh
> > >  TEST_PROGS += test_loop_07.sh
> > > +TEST_PROGS += test_loop_08.sh
> > >  TEST_PROGS += test_stripe_01.sh
> > >  TEST_PROGS += test_stripe_02.sh
> > >  TEST_PROGS += test_stripe_03.sh
> > >  TEST_PROGS += test_stripe_04.sh
> > >  TEST_PROGS += test_stripe_05.sh
> > > diff --git a/tools/testing/selftests/ublk/test_loop_08.sh b/tools/testing/selftests/ublk/test_loop_08.sh
> > > new file mode 100755
> > > index 000000000000..ca289cfb2ad4
> > > --- /dev/null
> > > +++ b/tools/testing/selftests/ublk/test_loop_08.sh
> > > @@ -0,0 +1,111 @@
> > > +#!/bin/bash
> > > +# SPDX-License-Identifier: GPL-2.0
> > > +
> > > +. "$(cd "$(dirname "$0")" && pwd)"/test_common.sh
> > > +
> > > +if ! _have_program fio; then
> > > +     exit $UBLK_SKIP_CODE
> > > +fi
> > > +
> > > +fio_version=$(fio --version)
> > > +if [[ "$fio_version" =~ fio-[0-9]+\.[0-9]+$ ]]; then
> > > +     echo "Requires development fio version with https://github.com/axboe/fio/pull/1992"
> > > +     exit $UBLK_SKIP_CODE
> > > +fi
> > > +
> > > +TID=loop_08
> > > +
> > > +_prep_test "loop" "end-to-end integrity"
> > > +
> > > +_create_backfile 0 256M
> > > +_create_backfile 1 32M # 256M * (64 integrity bytes / 512 data bytes)
> > > +integrity_params="--integrity_capable --integrity_reftag
> > > +                  --metadata_size 64 --pi_offset 56 --csum_type t10dif"
> > > +dev_id=$(_add_ublk_dev -t loop -u $integrity_params "${UBLK_BACKFILES[@]}")
> >
> > I tried above setting:
> >
> > ./kublk add -t loop --integrity_capable --integrity_reftag --metadata_size 64 --pi_offset 56 --csum_type t10dif --foreground -u /dev/sdb /dev/sdc
> > dev id 1: nr_hw_queues 2 queue_depth 128 block size 512 dev_capacity 8388608
> >         max rq size 1048576 daemon pid 38295 flags 0x160c2 state LIVE
> >         queue 0: affinity(0 )
> >         queue 1: affinity(8 )
> >
> > However, IO error is always triggered:
> >
> > [ 9202.316382] ublkb1: ref tag error at location 0 (rcvd 128)
> > [ 9202.317171] Buffer I/O error on dev ublkb1, logical block 0, async page read
> 
> Hmm, what are the initial contents of /dev/sdc? It looks like they are
> nonzero, as the reftag being read for logical block 0 is 128 rather
> than the expected 0 (the reftag would be read from bytes 60 to 63 of
> /dev/sdc). In general, though, the partition scan may be expected to
> fail the bio-integrity-auto checks if the integrity data hasn't been
> initialized. I don't think this is an issue, since the partition scan
> is looking for a partition table but there's no guarantee that one
> exists.
> You can disable the kernel integrity checks if you want by writing 0
> to /sys/block/ublkb1/integrity/read_verify. However, I'm not sure it's
> possible to do this soon enough to take effect before the partition
> scan.
> We could also use the UBLK_F_NO_AUTO_PART_SCAN feature, once it lands,
> to suppress the partition scan and these error messages.

UBLK_F_NO_AUTO_PART_SCAN can't avoid the following read failure.

I guess the issue can be avoided by adding small superblock to the meta
data file, then format it in the 1st time when superblock doesn't exist.

This way will make it usable from test/verify purpose.


Thanks,
Ming


