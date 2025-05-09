Return-Path: <linux-kselftest+bounces-32739-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 00959AB0DBF
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 May 2025 10:50:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 576B44E6B3B
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 May 2025 08:49:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39E4827FD64;
	Fri,  9 May 2025 08:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OwZ6boWy"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6721127FD46
	for <linux-kselftest@vger.kernel.org>; Fri,  9 May 2025 08:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746780381; cv=none; b=N6k/1NaOvlR3lUvuKV3Q+AuGA/SE7aX12Us8Tf4RaU1+7LYDkaeNz9UffTh47ZAakkqkOUzFHuRga4fFHv/flZE0S/HLKaxOadd+p+zZUJujz+zfsCGcrkKK0LwW/PQo5BToQE21MvAFUsZ8FfXRBI6osjPwwsOgaMJpypmDR5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746780381; c=relaxed/simple;
	bh=4NVF5+MV/4djn8Pk1xuaXAM/Z2bwawWbmW+j2uP+wb8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dcBf4WisFqg3Coadw2+dWJmZ5vJ3Y5miAAMU2NjWFGhbDAb8kjC5HGx/DI0bgaixLjd4xyUz0UJX4Kt5wy28DHuNNOVx7Q1pF/JJz5b/84YyB/iCWeDxHUEdBB284c8vM9VRVTWPd3d4MA8j9DKK+io8E5d2H5f1e380oPs6iQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OwZ6boWy; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1746780377;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Ldm0PwyqH66jO1Mug4aaT3rBzKXZfNBu7VHXn9V5Kxw=;
	b=OwZ6boWyRdtNN7VeE2z9EFqRflW4f7dKxx6EUkTP2VkIuRizftIUGjkfGUA1g42ZwX37tb
	xPB8eEj22tCg56e4Cixn7i9HPPNaLMNXhpG8eNMqYu7nLFjFwsAlie3Z1Muo75VDE9jThB
	9sX0E6fUMaM+0yVBuuZgc948mgcEbeQ=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-590-oP9NcB4AMfiEs_wRKzwhqQ-1; Fri,
 09 May 2025 04:46:16 -0400
X-MC-Unique: oP9NcB4AMfiEs_wRKzwhqQ-1
X-Mimecast-MFC-AGG-ID: oP9NcB4AMfiEs_wRKzwhqQ_1746780374
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3FDB31800374;
	Fri,  9 May 2025 08:46:14 +0000 (UTC)
Received: from fedora (unknown [10.72.116.140])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 68A8830001A1;
	Fri,  9 May 2025 08:46:06 +0000 (UTC)
Date: Fri, 9 May 2025 16:46:00 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Uday Shankar <ushankar@purestorage.com>
Cc: Jens Axboe <axboe@kernel.dk>,
	Caleb Sander Mateos <csander@purestorage.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Shuah Khan <shuah@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v6 7/8] selftests: ublk: kublk: decouple ublk_queues from
 ublk server threads
Message-ID: <aB3AyJdO7-mFzjFf@fedora>
References: <20250507-ublk_task_per_io-v6-0-a2a298783c01@purestorage.com>
 <20250507-ublk_task_per_io-v6-7-a2a298783c01@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250507-ublk_task_per_io-v6-7-a2a298783c01@purestorage.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On Wed, May 07, 2025 at 03:49:41PM -0600, Uday Shankar wrote:
> Add support in kublk for decoupled ublk_queues and ublk server threads.
> kublk now has two modes of operation:
> 
> - (preexisting mode) threads and queues are paired 1:1, and each thread
>   services all the I/Os of one queue
> - (new mode) thread and queue counts are independently configurable.
>   threads service I/Os in a way that balances load across threads even
>   if load is not balanced over queues. requires passing --round_robin
> 
> The new mode of operation is exercised by the new test_generic_08, which
> issues I/O against a single queue and verifies that each of the 8 ublk
> server threads handles exactly 1/8 of the total I/O count. Under the old
> mode of operation (i.e. without --round_robin), all I/O goes to one ublk
> server thread, and the test fails.

Hi Uday,

I just setup two ublk devices in the following way:

[root@ktest-40 ublk]# ./kublk add -t null -q 2  --nthreads=4 --round_robin
dev id 0: nr_hw_queues 2 queue_depth 128 block size 512 dev_capacity 524288000
	max rq size 1048576 daemon pid 8516 flags 0x842 state LIVE
	queue 0: affinity(0 )
	queue 1: affinity(8 )

[root@ktest-40 ublk]# ./kublk add -t null -q 2
dev id 1: nr_hw_queues 2 queue_depth 128 block size 512 dev_capacity 524288000
	max rq size 1048576 daemon pid 8539 flags 0x42 state LIVE
	queue 0: affinity(0 )
	queue 1: affinity(8 )

Then run 'fio/t/io_uring -p0 /dev/ublkb[0|1]', and IOPS of /dev/ublkb0 is
just 1/3 of /dev/ublkb1.

For ublk/loop, '-q 2  --nthreads=4 --round_robin' is still a bit slower
than '-q 2', but the gap isn't too big(<10%).


Thanks,
Ming


