Return-Path: <linux-kselftest+bounces-48301-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7192FCF8B1A
	for <lists+linux-kselftest@lfdr.de>; Tue, 06 Jan 2026 15:10:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7B887300153A
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 Jan 2026 14:10:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFBC027F010;
	Tue,  6 Jan 2026 14:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hnTpuqtC"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB607233722
	for <linux-kselftest@vger.kernel.org>; Tue,  6 Jan 2026 14:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767708634; cv=none; b=gmJTcDIJm14ME3vwwNxsdAF7C0hc9PTPYskjdkowe8St1p4E4yMF1lp+/c1Qk+rQxXr0lpB3OumlcS8IKLSNN6ZzExXrEazCYDzwP/CQR0DOEPJjckgPXVQj0ccS0j0aQ6savUQUPBUI5jv+ScKPeapbxbRykjXug4QaGGh6HWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767708634; c=relaxed/simple;
	bh=515A1Ze/d8n3Ha+aRtuXZTlbFyrHeWURMG0vanVFztM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=umG9+jhOE9ga1NaC6XSyPtMWGac7+CF3wedhTycbJExgBv/O7sLbf34xniTxA9mpzYcwYHnTrfzuOssRNzh8Gkr5aYJsp6H7hMr8Z1SPMrLvCMtlp2QG9O9LFelJdMNWpIiz+VEghTg8eqU/BzuuQiTo/BARVG2cUBGNtli2CMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hnTpuqtC; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767708631;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1g+ZO/94q1ivwdez+O4FZrlvIVly9LXqKXHuSbHbO44=;
	b=hnTpuqtC5XifIP7a8qqF5HDTjbmxPmMbkqpMV5D0s4HiILjsRNq+d5c1yQqc+RaXKgk0xH
	9ZMWOd/u9tkrlfnaxf/pccGswtV5IU+vrBs+42FibhYDiOSt33APqxn6wedkTg71N1Qjge
	XW+i27mVBmLukki7XTUd0SlUVSva6b4=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-612-5ThPj8GQMmGWrLNkwpFDlg-1; Tue,
 06 Jan 2026 09:10:28 -0500
X-MC-Unique: 5ThPj8GQMmGWrLNkwpFDlg-1
X-Mimecast-MFC-AGG-ID: 5ThPj8GQMmGWrLNkwpFDlg_1767708626
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6FAC5195608D;
	Tue,  6 Jan 2026 14:10:26 +0000 (UTC)
Received: from fedora (unknown [10.72.116.130])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 11D0B19560AB;
	Tue,  6 Jan 2026 14:10:20 +0000 (UTC)
Date: Tue, 6 Jan 2026 22:10:15 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Jens Axboe <axboe@kernel.dk>, Shuah Khan <shuah@kernel.org>,
	linux-block@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Stanley Zhang <stazhang@purestorage.com>,
	Uday Shankar <ushankar@purestorage.com>,
	"Martin K . Petersen" <martin.petersen@oracle.com>
Subject: Re: [PATCH v3 19/19] selftests: ublk: add end-to-end integrity test
Message-ID: <aV0Xx2vWmL5Iuls4@fedora>
References: <20260106005752.3784925-1-csander@purestorage.com>
 <20260106005752.3784925-20-csander@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260106005752.3784925-20-csander@purestorage.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On Mon, Jan 05, 2026 at 05:57:51PM -0700, Caleb Sander Mateos wrote:
> Add test case loop_08 to verify the ublk integrity data flow. It uses
> the kublk loop target to create a ublk device with integrity on top of
> backing data and integrity files. It then writes to the whole device
> with fio configured to generate integrity data. Then it reads back the
> whole device with fio configured to verify the integrity data.
> It also verifies that injected guard, reftag, and apptag corruptions are
> correctly detected.
> 
> Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
> ---
>  tools/testing/selftests/ublk/Makefile        |   1 +
>  tools/testing/selftests/ublk/test_loop_08.sh | 111 +++++++++++++++++++
>  2 files changed, 112 insertions(+)
>  create mode 100755 tools/testing/selftests/ublk/test_loop_08.sh
> 
> diff --git a/tools/testing/selftests/ublk/Makefile b/tools/testing/selftests/ublk/Makefile
> index bfd68ae64142..ab745443fd58 100644
> --- a/tools/testing/selftests/ublk/Makefile
> +++ b/tools/testing/selftests/ublk/Makefile
> @@ -33,10 +33,11 @@ TEST_PROGS += test_loop_02.sh
>  TEST_PROGS += test_loop_03.sh
>  TEST_PROGS += test_loop_04.sh
>  TEST_PROGS += test_loop_05.sh
>  TEST_PROGS += test_loop_06.sh
>  TEST_PROGS += test_loop_07.sh
> +TEST_PROGS += test_loop_08.sh
>  TEST_PROGS += test_stripe_01.sh
>  TEST_PROGS += test_stripe_02.sh
>  TEST_PROGS += test_stripe_03.sh
>  TEST_PROGS += test_stripe_04.sh
>  TEST_PROGS += test_stripe_05.sh
> diff --git a/tools/testing/selftests/ublk/test_loop_08.sh b/tools/testing/selftests/ublk/test_loop_08.sh
> new file mode 100755
> index 000000000000..ca289cfb2ad4
> --- /dev/null
> +++ b/tools/testing/selftests/ublk/test_loop_08.sh
> @@ -0,0 +1,111 @@
> +#!/bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +
> +. "$(cd "$(dirname "$0")" && pwd)"/test_common.sh
> +
> +if ! _have_program fio; then
> +	exit $UBLK_SKIP_CODE
> +fi
> +
> +fio_version=$(fio --version)
> +if [[ "$fio_version" =~ fio-[0-9]+\.[0-9]+$ ]]; then
> +	echo "Requires development fio version with https://github.com/axboe/fio/pull/1992"
> +	exit $UBLK_SKIP_CODE
> +fi
> +
> +TID=loop_08
> +
> +_prep_test "loop" "end-to-end integrity"
> +
> +_create_backfile 0 256M
> +_create_backfile 1 32M # 256M * (64 integrity bytes / 512 data bytes)
> +integrity_params="--integrity_capable --integrity_reftag
> +                  --metadata_size 64 --pi_offset 56 --csum_type t10dif"
> +dev_id=$(_add_ublk_dev -t loop -u $integrity_params "${UBLK_BACKFILES[@]}")

I tried above setting:

./kublk add -t loop --integrity_capable --integrity_reftag --metadata_size 64 --pi_offset 56 --csum_type t10dif --foreground -u /dev/sdb /dev/sdc
dev id 1: nr_hw_queues 2 queue_depth 128 block size 512 dev_capacity 8388608
	max rq size 1048576 daemon pid 38295 flags 0x160c2 state LIVE
	queue 0: affinity(0 )
	queue 1: affinity(8 )

However, IO error is always triggered:

[ 9202.316382] ublkb1: ref tag error at location 0 (rcvd 128)
[ 9202.317171] Buffer I/O error on dev ublkb1, logical block 0, async page read
[ 9202.319478] ublkb1: ref tag error at location 0 (rcvd 128)
[ 9202.319983] Buffer I/O error on dev ublkb1, logical block 0, async page read
[ 9202.326332] ublkb1: ref tag error at location 0 (rcvd 128)
[ 9202.326974] Buffer I/O error on dev ublkb1, logical block 0, async page read
[ 9202.327570] ldm_validate_partition_table(): Disk read failed.
[ 9202.336539] ublkb1: ref tag error at location 0 (rcvd 128)
[ 9202.337228] Buffer I/O error on dev ublkb1, logical block 0, async page read
[ 9202.339247] ublkb1: ref tag error at location 0 (rcvd 128)
[ 9202.339779] Buffer I/O error on dev ublkb1, logical block 0, async page read
[ 9202.344306] ublkb1: ref tag error at location 0 (rcvd 128)
[ 9202.344948] Buffer I/O error on dev ublkb1, logical block 0, async page read
[ 9202.347067] ublkb1: ref tag error at location 0 (rcvd 128)
[ 9202.347558] Buffer I/O error on dev ublkb1, logical block 0, async page read
[ 9202.348100] Dev ublkb1: unable to read RDB block 0
[ 9202.350159] ublkb1: ref tag error at location 0 (rcvd 128)
[ 9202.350642] Buffer I/O error on dev ublkb1, logical block 0, async page read
[ 9202.354977] ublkb1: ref tag error at location 0 (rcvd 128)
[ 9202.355539] Buffer I/O error on dev ublkb1, logical block 0, async page read
[ 9202.356280]  ublkb1: unable to read partition table



Thanks,
Ming


