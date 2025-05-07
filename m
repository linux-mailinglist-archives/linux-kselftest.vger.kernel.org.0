Return-Path: <linux-kselftest+bounces-32625-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7E40AAEF06
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 May 2025 01:09:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E95B9C07B3
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 May 2025 23:09:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37BB429186F;
	Wed,  7 May 2025 23:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="EOfFAo1F"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03DEF1ACEC8;
	Wed,  7 May 2025 23:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746659365; cv=none; b=Ra+8FwTB8Tfbw7TUj4E7Ze6wEzLzEailBzF5RO3FA5sdpUyhKNOP3PdpROenn2NOBxzVThxK3aIO+t09DUQijAsQUq3O6lzg5NXoeOw1jQrqxDLDV3WJyGCpBAg5r4dnxfDJbYfjtxIUkrDxhupaAVWg5v8iD4j6XxdS84QUBgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746659365; c=relaxed/simple;
	bh=KMFzgmh2r5Df+u8KVgowuji0vPzSkWx80se/kz0YMRQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PeKjyk1gSbueEx3Lz4pduur9uBGaVv49REKx6IFHgaKTbPkVns2eSKyR3Y+eyC+eavq/a9JO5TTew4meDlYIwo8hk4NSj87L18LliHdFeQ6lszF4hdt81TmQHs63v6kEIEhEHso5IxrJgv1CltitLLiJxV4c9O1zf3IwuyV0uf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=EOfFAo1F; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
	:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=o0wgH0daWTZzvybrzGF8aoTDHaUJ4f2HlkJDU/65xBw=; b=EOfFAo1F4lXkUxfsluF8fC+AA5
	qLkeCPpxopOz0WVewlU4Z0nxujmKcDDCa7s+lE0PYWEnslk4YxuF+cQEEUU6bOyfSCvHOvWs8FwuS
	V5kxqwjFG2dZDt90AmxcpZMYckkCCMQXkMjbCygesJuXSE1av3H5WNIJbPq3dxdJpuZsfJaOeIM8h
	J5VLIhZCJKjFUq4EO9JMHQAO/nRhWlBEY4FpWzQd/rr/OHPm8FzFdBLl8l/in4CzuYAbiR7BQZoFj
	z9JGAib7VU6U+mG/t/GrlIx+eqakJwTNxCkdYQv503xLnsv9iNJ4yPloXw02ilKpn0I9xRWsjy4e2
	9H63hs6g==;
Received: from [50.39.124.201] (helo=[192.168.254.17])
	by desiato.infradead.org with esmtpsa (Exim 4.98.1 #2 (Red Hat Linux))
	id 1uCnsj-0000000FwIO-3tGf;
	Wed, 07 May 2025 23:09:18 +0000
Message-ID: <e454bcf1-ae3c-41bd-b376-6560ea534925@infradead.org>
Date: Wed, 7 May 2025 16:08:49 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 8/8] Documentation: ublk: document UBLK_F_RR_TAGS
To: Uday Shankar <ushankar@purestorage.com>, Ming Lei <ming.lei@redhat.com>,
 Jens Axboe <axboe@kernel.dk>, Caleb Sander Mateos <csander@purestorage.com>,
 Andrew Morton <akpm@linux-foundation.org>, Shuah Khan <shuah@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org
References: <20250507-ublk_task_per_io-v6-0-a2a298783c01@purestorage.com>
 <20250507-ublk_task_per_io-v6-8-a2a298783c01@purestorage.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20250507-ublk_task_per_io-v6-8-a2a298783c01@purestorage.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 5/7/25 2:49 PM, Uday Shankar wrote:
> Document the new flag UBLK_F_RR_TAGS along with its intended use case.
> Also describe the new restrictions on threading model imposed by
> ublk_drv (one (qid,tag) pair is can be served by only one thread), and
> remove references to ubq_daemon/per-queue threads, since such a concept
> no longer exists.
> 
> Signed-off-by: Uday Shankar <ushankar@purestorage.com>
> ---
>  Documentation/block/ublk.rst | 83 ++++++++++++++++++++++++++++++++++++++------
>  1 file changed, 72 insertions(+), 11 deletions(-)
> 
> diff --git a/Documentation/block/ublk.rst b/Documentation/block/ublk.rst
> index 854f823b46c2add01d0b65ba36aecd26c45bb65d..e9cbabdd69c5539a02463780ba5e51de0416c3f6 100644
> --- a/Documentation/block/ublk.rst
> +++ b/Documentation/block/ublk.rst
> @@ -115,15 +115,15 @@ managing and controlling ublk devices with help of several control commands:
>  
>  - ``UBLK_CMD_START_DEV``
>  
> -  After the server prepares userspace resources (such as creating per-queue
> -  pthread & io_uring for handling ublk IO), this command is sent to the
> +  After the server prepares userspace resources (such as creating I/O handler
> +  threads & io_uring for handling ublk IO), this command is sent to the
>    driver for allocating & exposing ``/dev/ublkb*``. Parameters set via
>    ``UBLK_CMD_SET_PARAMS`` are applied for creating the device.
>  
>  - ``UBLK_CMD_STOP_DEV``
>  
>    Halt IO on ``/dev/ublkb*`` and remove the device. When this command returns,
> -  ublk server will release resources (such as destroying per-queue pthread &
> +  ublk server will release resources (such as destroying I/O handler threads &
>    io_uring).
>  
>  - ``UBLK_CMD_DEL_DEV``
> @@ -208,15 +208,15 @@ managing and controlling ublk devices with help of several control commands:
>    modify how I/O is handled while the ublk server is dying/dead (this is called
>    the ``nosrv`` case in the driver code).
>  
> -  With just ``UBLK_F_USER_RECOVERY`` set, after one ubq_daemon(ublk server's io
> -  handler) is dying, ublk does not delete ``/dev/ublkb*`` during the whole
> +  With just ``UBLK_F_USER_RECOVERY`` set, after the ublk server exits,
> +  ublk does not delete ``/dev/ublkb*`` during the whole
>    recovery stage and ublk device ID is kept. It is ublk server's
>    responsibility to recover the device context by its own knowledge.
>    Requests which have not been issued to userspace are requeued. Requests
>    which have been issued to userspace are aborted.
>  
> -  With ``UBLK_F_USER_RECOVERY_REISSUE`` additionally set, after one ubq_daemon
> -  (ublk server's io handler) is dying, contrary to ``UBLK_F_USER_RECOVERY``,
> +  With ``UBLK_F_USER_RECOVERY_REISSUE`` additionally set, after the ublk server
> +  exits, contrary to ``UBLK_F_USER_RECOVERY``,
>    requests which have been issued to userspace are requeued and will be
>    re-issued to the new process after handling ``UBLK_CMD_END_USER_RECOVERY``.
>    ``UBLK_F_USER_RECOVERY_REISSUE`` is designed for backends who tolerate
> @@ -241,10 +241,11 @@ can be controlled/accessed just inside this container.
>  Data plane
>  ----------
>  
> -ublk server needs to create per-queue IO pthread & io_uring for handling IO
> -commands via io_uring passthrough. The per-queue IO pthread
> -focuses on IO handling and shouldn't handle any control & management
> -tasks.
> +The ublk server should create dedicated threads for handling I/O. Each
> +thread should have its own io_uring through which it is notified of new
> +I/O, and through which it can complete I/O. These dedicated threads
> +should focus on IO handling and shouldn't handle any control &
> +management tasks.
>  
>  The's IO is assigned by a unique tag, which is 1:1 mapping with IO

   ???

>  request of ``/dev/ublkb*``.
> @@ -265,6 +266,13 @@ with specified IO tag in the command data:
>    destined to ``/dev/ublkb*``. This command is sent only once from the server
>    IO pthread for ublk driver to setup IO forward environment.
>  
> +  Once a thread issues this command against a given (qid,tag) pair, the thread
> +  registers itself as that I/O's daemon. In the future, only that I/O's daemon
> +  is allowed to issue commands against the I/O. If any other thread attempts
> +  to issue a command against a (qid,tag) pair for which the thread is not the
> +  daemon, the command will fail. Daemons can be reset only be going through
> +  recovery.
> +
>  - ``UBLK_IO_COMMIT_AND_FETCH_REQ``
>  
>    When an IO request is destined to ``/dev/ublkb*``, the driver stores
> @@ -309,6 +317,59 @@ with specified IO tag in the command data:
>    ``UBLK_IO_COMMIT_AND_FETCH_REQ`` to the server, ublkdrv needs to copy
>    the server buffer (pages) read to the IO request pages.
>  
> +Load balancing
> +--------------
> +
> +A simple approach to designing a ublk server might involve selecting a
> +number of I/O handler threads N, creating devices with N queues, and
> +pairing up I/O handler threads with queues, so that each thread gets a
> +unique qid, and it issues ``FETCH_REQ``s against all tags for that qid.
> +Indeed, before the introduction of the ``UBLK_F_RR_TAGS`` feature, this
> +was essentially the only option (*)

Add ending period (full stop), please.

> +
> +This approach can run into performance issues under imbalanced load.
> +This architecture taken together with the `blk-mq architecture
> +<https://docs.kernel.org/block/blk-mq.html>`_ implies that there is a
> +fixed mapping from I/O submission CPU to the ublk server thread that
> +handles it. If the workload is CPU-bottlenecked, only allowing one ublk
> +server thread to handle all the I/O generated from a single CPU can
> +limit peak bandwidth.
> +
> +To address this issue, two changes were made:
> +
> +- ublk servers can now pair up threads with I/Os (i.e. (qid,tag) pairs)
> +  arbitrarily. In particular, the preexisting restriction that all I/Os
> +  in one queue must be served by the same thread is lifted.
> +- ublk servers can now specify ``UBLK_F_RR_TAGS`` when creating a ublk
> +  device to get round-robin tag allocation on each queue

Add ending period (full stop), please.

> +
> +The ublk server can check for the presence of these changes by testing
> +for the ``UBLK_F_RR_TAGS`` feature.
> +
> +With these changes, a ublk server can balance load as follows:
> +
> +- create the device with ``UBLK_F_RR_TAGS`` set in
> +  ``ublksrv_ctrl_dev_info::flags`` when issuing the ``ADD_DEV`` command
> +- issue ``FETCH_REQ``s from ublk server threads to (qid,tag) pairs in
> +  a round-robin manner. For example, for a device configured with
> +  ``nr_hw_queues=2`` and ``queue_depth=4``, and a ublk server having 4
> +  I/O handling threads, ``FETCH_REQ``s could be issued as follows, where
> +  each entry in the table is the pair (``ublksrv_io_cmd::q_id``,
> +  ``ublksrv_io_cmd::tag``) in the payload of the ``FETCH_REQ``.
> +
> +  ======== ======== ======== ========
> +  thread 0 thread 1 thread 2 thread 3
> +  ======== ======== ======== ========
> +  (0, 0)   (0, 1)   (0, 2)   (0, 3)
> +  (1, 3)   (1, 0)   (1, 1)   (1, 2)
> +
> +With this setup, I/O submitted on a CPU which maps to queue 0 will be
> +balanced across all threads instead of all landing on the same thread.
> +Thus, a potential bottleneck is avoided.
> +
> +(*) technically, one I/O handling thread could service multiple queues

       Technically,

> +if it wanted to, but that doesn't help with imbalanced load

Add ending period (full stop), please.


> +
>  Zero copy
>  ---------
>  
> 

-- 
~Randy


