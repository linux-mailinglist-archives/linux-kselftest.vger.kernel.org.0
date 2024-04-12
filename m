Return-Path: <linux-kselftest+bounces-7765-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CACF8A2600
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Apr 2024 07:53:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C67D3287160
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Apr 2024 05:53:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C5AB1C29F;
	Fri, 12 Apr 2024 05:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q9+8AJug"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11A93335BC;
	Fri, 12 Apr 2024 05:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712901164; cv=none; b=jsV3Qv0L2jB3qEDoUUUEXIu50D3c759MIu7PGng4eb6B/IGK48b6g+oCwNvTh9G4A94Sgr62LCVxy2d1Is3NbMfGztnsWV3UczQKCKfKh6QMXBEie8S/s9kqC1FCKMo3m4IBe43HM0zaDGJTUxoLzj2RfOrNUOVRHrsq+VaRXPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712901164; c=relaxed/simple;
	bh=PRLrXt4iHYRuhCX+FBK/xkRc9ZS8SapIhaNby1J3XYc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MirxKfTCr3MYHWJU0RvOHL2r/sXeACHHWQ0Glw87ZGpxGyup6Hdy/IfP4JtC1DBwif3/n4IFdRVFN9KTZ+krDxv8o9AtzjWoOXGgsB+d/a4hXAUzalsM8BAQ45QdRmN4o/CffQndre96TK+d30j9EMDUIfHOAg0snyh3AW0Wm4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q9+8AJug; arc=none smtp.client-ip=209.85.210.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-6e0f43074edso433432a34.1;
        Thu, 11 Apr 2024 22:52:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712901161; x=1713505961; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5qFJdYxwdOe5l249mXHgFPLW3o2g9srXLWu5vVwAkKM=;
        b=Q9+8AJugmi+jhn1BxSkeD013ZoiHeo7GGV10Fzc/i+4+zczdrJx4lc4jA8CBII+EnS
         +R+HTF+F1r71gs2cI3lt2hJsskB6stvC/FEo+/F+NmYaHl98CDyypDeKvCbtJ3dhHGuf
         TA1m19+AM+GileThv0bxmMaK6YrIpTHPBksVBJL1H8+z94OE17zu+sgZ1MtPvjnRy9Mr
         3d1uwDpxzc2OUC6sCsEQmfBQPQUow4CYnE3rT63+EJ3jlOhiWrHZCR52ADCBDQZQK5MT
         g/tBXwPsyGSRMNOXgbcrrV5PIxWpiRo9ITpZ6z0Dvx/PjuLV0YmLYGKJ1juT2yj9RJGr
         /OdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712901161; x=1713505961;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5qFJdYxwdOe5l249mXHgFPLW3o2g9srXLWu5vVwAkKM=;
        b=uViGkGFZLoM55xQ39nCpSy29AQv2Z8hwBPRJqm8g2o1CYskNplXlyFvctb5kwEjonF
         pqAt2xfClaJW5zut5rgZzpx5YxyE8q+J0YnuwZbkyHTG5kWmct3Tw7i47nw9YGqiY14J
         la5s+jjMmm/qtxebfBy5ypir3hRZ4v6jAQi48TBiVHws/o+eLu9h8N37PsgWNnfTNtHI
         7NGPUe1NI8Gxn9PrwCst/sMcWRyUMu2rEN2NmH1kvK1EzssVI8i0dga9lKJ4hRozaFgk
         49cNJfoM6RAp68F2rCFrf/zeRXtSUbjLA1VqR91ju8ZxxJDbRAKKKj/UbsW4XgVRokd+
         jIUg==
X-Forwarded-Encrypted: i=1; AJvYcCX4bUX8iJOpIvEmxQ0KLB95ObGFFmOwbkc9n9Icoo0f12posqO3yxAbBTlfH2dovjB2Qx/Xtv0gWugsRgko+a6K1fnLFG57OFhLAu8BntrdZqjaPo1QOUhK2kezY5yvflcSv24cHVZc3+kDVmtpTWtZtpl1pN/BWUAiToHW0CxyS6e2YKzB
X-Gm-Message-State: AOJu0Yw9mI9uwHMC94entCCTq6GLCfOLelBf3g/a2fMmyik/GUQr53nZ
	bHZjXjyH3kKlPvDLoBNKe3p72jRQhUP95G8fdFEPYgY6B3Mrj2r/ryJkTA==
X-Google-Smtp-Source: AGHT+IFIcDSNLFkWHjIAcz/T6V4uuJZWPYxeiLC3fjYBJAAjalbLd9poY1/gEDW6oudFC2k2T46B5A==
X-Received: by 2002:a05:6808:2348:b0:3c5:ffff:9fc8 with SMTP id ef8-20020a056808234800b003c5ffff9fc8mr1591357oib.31.1712901160879;
        Thu, 11 Apr 2024 22:52:40 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id lc16-20020a056a004f5000b006ead1509847sm2109847pfb.216.2024.04.11.22.52.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 22:52:40 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id 4D67318468556; Fri, 12 Apr 2024 12:52:38 +0700 (WIB)
Date: Fri, 12 Apr 2024 12:52:37 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Elizabeth Figura <zfigura@codeweavers.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
	wine-devel@winehq.org,
	=?utf-8?B?QW5kcsOp?= Almeida <andrealmeid@igalia.com>,
	Wolfram Sang <wsa@kernel.org>,
	Arkadiusz Hiler <ahiler@codeweavers.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Andy Lutomirski <luto@kernel.org>, linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Randy Dunlap <rdunlap@infradead.org>,
	Mao Zhu <zhumao001@208suo.com>,
	Shaomin Deng <dengshaomin@cdjrlc.com>,
	Charles Han <hanchunchao@inspur.com>
Subject: Re: [PATCH v3 30/30] docs: ntsync: Add documentation for the ntsync
 uAPI.
Message-ID: <ZhjMJe69qFJtyD4I@archie.me>
References: <20240329000621.148791-1-zfigura@codeweavers.com>
 <20240329000621.148791-31-zfigura@codeweavers.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="iA//aiK0mS6pr5b8"
Content-Disposition: inline
In-Reply-To: <20240329000621.148791-31-zfigura@codeweavers.com>


--iA//aiK0mS6pr5b8
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 28, 2024 at 07:06:21PM -0500, Elizabeth Figura wrote:
> diff --git a/Documentation/userspace-api/ntsync.rst b/Documentation/users=
pace-api/ntsync.rst
> new file mode 100644
> index 000000000000..202c2350d3af
> --- /dev/null
> +++ b/Documentation/userspace-api/ntsync.rst
> @@ -0,0 +1,399 @@
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +NT synchronization primitive driver
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +This page documents the user-space API for the ntsync driver.
> +
> +ntsync is a support driver for emulation of NT synchronization
> +primitives by user-space NT emulators. It exists because implementation
> +in user-space, using existing tools, cannot match Windows performance
> +while offering accurate semantics. It is implemented entirely in
> +software, and does not drive any hardware device.
> +
> +This interface is meant as a compatibility tool only, and should not
> +be used for general synchronization. Instead use generic, versatile
> +interfaces such as futex(2) and poll(2).
> +
> +Synchronization primitives
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
> +
> +The ntsync driver exposes three types of synchronization primitives:
> +semaphores, mutexes, and events.
> +
> +A semaphore holds a single volatile 32-bit counter, and a static 32-bit
> +integer denoting the maximum value. It is considered signaled when the
> +counter is nonzero. The counter is decremented by one when a wait is
> +satisfied. Both the initial and maximum count are established when the
> +semaphore is created.
> +
> +A mutex holds a volatile 32-bit recursion count, and a volatile 32-bit
> +identifier denoting its owner. A mutex is considered signaled when its
> +owner is zero (indicating that it is not owned). The recursion count is
> +incremented when a wait is satisfied, and ownership is set to the given
> +identifier.
> +
> +A mutex also holds an internal flag denoting whether its previous owner
> +has died; such a mutex is said to be abandoned. Owner death is not
> +tracked automatically based on thread death, but rather must be
> +communicated using ``NTSYNC_IOC_MUTEX_KILL``. An abandoned mutex is
> +inherently considered unowned.
> +
> +Except for the "unowned" semantics of zero, the actual value of the
> +owner identifier is not interpreted by the ntsync driver at all. The
> +intended use is to store a thread identifier; however, the ntsync
> +driver does not actually validate that a calling thread provides
> +consistent or unique identifiers.
> +
> +An event holds a volatile boolean state denoting whether it is signaled
> +or not. There are two types of events, auto-reset and manual-reset. An
> +auto-reset event is designaled when a wait is satisfied; a manual-reset
> +event is not. The event type is specified when the event is created.
> +
> +Unless specified otherwise, all operations on an object are atomic and
> +totally ordered with respect to other operations on the same object.
> +
> +Objects are represented by files. When all file descriptors to an
> +object are closed, that object is deleted.
> +
> +Char device
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +The ntsync driver creates a single char device /dev/ntsync. Each file
> +description opened on the device represents a unique instance intended
> +to back an individual NT virtual machine. Objects created by one ntsync
> +instance may only be used with other objects created by the same
> +instance.
> +
> +ioctl reference
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +All operations on the device are done through ioctls. There are four
> +structures used in ioctl calls::
> +
> +   struct ntsync_sem_args {
> +   	__u32 sem;
> +   	__u32 count;
> +   	__u32 max;
> +   };
> +
> +   struct ntsync_mutex_args {
> +   	__u32 mutex;
> +   	__u32 owner;
> +   	__u32 count;
> +   };
> +
> +   struct ntsync_event_args {
> +   	__u32 event;
> +   	__u32 signaled;
> +   	__u32 manual;
> +   };
> +
> +   struct ntsync_wait_args {
> +   	__u64 timeout;
> +   	__u64 objs;
> +   	__u32 count;
> +   	__u32 owner;
> +   	__u32 index;
> +   	__u32 alert;
> +   	__u32 flags;
> +   	__u32 pad;
> +   };
> +
> +Depending on the ioctl, members of the structure may be used as input,
> +output, or not at all. All ioctls return 0 on success.
> +
> +The ioctls on the device file are as follows:
> +
> +.. c:macro:: NTSYNC_IOC_CREATE_SEM
> +
> +  Create a semaphore object. Takes a pointer to struct
> +  :c:type:`ntsync_sem_args`, which is used as follows:
> +
> +  .. list-table::
> +
> +     * - ``sem``
> +       - On output, contains a file descriptor to the created semaphore.
> +     * - ``count``
> +       - Initial count of the semaphore.
> +     * - ``max``
> +       - Maximum count of the semaphore.
> +
> +  Fails with ``EINVAL`` if ``count`` is greater than ``max``.
> +
> +.. c:macro:: NTSYNC_IOC_CREATE_MUTEX
> +
> +  Create a mutex object. Takes a pointer to struct
> +  :c:type:`ntsync_mutex_args`, which is used as follows:
> +
> +  .. list-table::
> +
> +     * - ``mutex``
> +       - On output, contains a file descriptor to the created mutex.
> +     * - ``count``
> +       - Initial recursion count of the mutex.
> +     * - ``owner``
> +       - Initial owner of the mutex.
> +
> +  If ``owner`` is nonzero and ``count`` is zero, or if ``owner`` is
> +  zero and ``count`` is nonzero, the function fails with ``EINVAL``.
> +
> +.. c:macro:: NTSYNC_IOC_CREATE_EVENT
> +
> +  Create an event object. Takes a pointer to struct
> +  :c:type:`ntsync_event_args`, which is used as follows:
> +
> +  .. list-table::
> +
> +     * - ``event``
> +       - On output, contains a file descriptor to the created event.
> +     * - ``signaled``
> +       - If nonzero, the event is initially signaled, otherwise
> +         nonsignaled.
> +     * - ``manual``
> +       - If nonzero, the event is a manual-reset event, otherwise
> +         auto-reset.
> +
> +The ioctls on the individual objects are as follows:
> +
> +.. c:macro:: NTSYNC_IOC_SEM_POST
> +
> +  Post to a semaphore object. Takes a pointer to a 32-bit integer,
> +  which on input holds the count to be added to the semaphore, and on
> +  output contains its previous count.
> +
> +  If adding to the semaphore's current count would raise the latter
> +  past the semaphore's maximum count, the ioctl fails with
> +  ``EOVERFLOW`` and the semaphore is not affected. If raising the
> +  semaphore's count causes it to become signaled, eligible threads
> +  waiting on this semaphore will be woken and the semaphore's count
> +  decremented appropriately.
> +
> +.. c:macro:: NTSYNC_IOC_MUTEX_UNLOCK
> +
> +  Release a mutex object. Takes a pointer to struct
> +  :c:type:`ntsync_mutex_args`, which is used as follows:
> +
> +  .. list-table::
> +
> +     * - ``mutex``
> +       - Ignored.
> +     * - ``owner``
> +       - Specifies the owner trying to release this mutex.
> +     * - ``count``
> +       - On output, contains the previous recursion count.
> +
> +  If ``owner`` is zero, the ioctl fails with ``EINVAL``. If ``owner``
> +  is not the current owner of the mutex, the ioctl fails with
> +  ``EPERM``.
> +
> +  The mutex's count will be decremented by one. If decrementing the
> +  mutex's count causes it to become zero, the mutex is marked as
> +  unowned and signaled, and eligible threads waiting on it will be
> +  woken as appropriate.
> +
> +.. c:macro:: NTSYNC_IOC_SET_EVENT
> +
> +  Signal an event object. Takes a pointer to a 32-bit integer, which on
> +  output contains the previous state of the event.
> +
> +  Eligible threads will be woken, and auto-reset events will be
> +  designaled appropriately.
> +
> +.. c:macro:: NTSYNC_IOC_RESET_EVENT
> +
> +  Designal an event object. Takes a pointer to a 32-bit integer, which
> +  on output contains the previous state of the event.
> +
> +.. c:macro:: NTSYNC_IOC_PULSE_EVENT
> +
> +  Wake threads waiting on an event object while leaving it in an
> +  unsignaled state. Takes a pointer to a 32-bit integer, which on
> +  output contains the previous state of the event.
> +
> +  A pulse operation can be thought of as a set followed by a reset,
> +  performed as a single atomic operation. If two threads are waiting on
> +  an auto-reset event which is pulsed, only one will be woken. If two
> +  threads are waiting a manual-reset event which is pulsed, both will
> +  be woken. However, in both cases, the event will be unsignaled
> +  afterwards, and a simultaneous read operation will always report the
> +  event as unsignaled.
> +
> +.. c:macro:: NTSYNC_IOC_READ_SEM
> +
> +  Read the current state of a semaphore object. Takes a pointer to
> +  struct :c:type:`ntsync_sem_args`, which is used as follows:
> +
> +  .. list-table::
> +
> +     * - ``sem``
> +       - Ignored.
> +     * - ``count``
> +       - On output, contains the current count of the semaphore.
> +     * - ``max``
> +       - On output, contains the maximum count of the semaphore.
> +
> +.. c:macro:: NTSYNC_IOC_READ_MUTEX
> +
> +  Read the current state of a mutex object. Takes a pointer to struct
> +  :c:type:`ntsync_mutex_args`, which is used as follows:
> +
> +  .. list-table::
> +
> +     * - ``mutex``
> +       - Ignored.
> +     * - ``owner``
> +       - On output, contains the current owner of the mutex, or zero
> +         if the mutex is not currently owned.
> +     * - ``count``
> +       - On output, contains the current recursion count of the mutex.
> +
> +  If the mutex is marked as abandoned, the function fails with
> +  ``EOWNERDEAD``. In this case, ``count`` and ``owner`` are set to
> +  zero.
> +
> +.. c:macro:: NTSYNC_IOC_READ_EVENT
> +
> +  Read the current state of an event object. Takes a pointer to struct
> +  :c:type:`ntsync_event_args`, which is used as follows:
> +
> +  .. list-table::
> +
> +     * - ``event``
> +       - Ignored.
> +     * - ``signaled``
> +       - On output, contains the current state of the event.
> +     * - ``manual``
> +       - On output, contains 1 if the event is a manual-reset event,
> +         and 0 otherwise.
> +
> +.. c:macro:: NTSYNC_IOC_KILL_OWNER
> +
> +  Mark a mutex as unowned and abandoned if it is owned by the given
> +  owner. Takes an input-only pointer to a 32-bit integer denoting the
> +  owner. If the owner is zero, the ioctl fails with ``EINVAL``. If the
> +  owner does not own the mutex, the function fails with ``EPERM``.
> +
> +  Eligible threads waiting on the mutex will be woken as appropriate
> +  (and such waits will fail with ``EOWNERDEAD``, as described below).
> +
> +.. c:macro:: NTSYNC_IOC_WAIT_ANY
> +
> +  Poll on any of a list of objects, atomically acquiring at most one.
> +  Takes a pointer to struct :c:type:`ntsync_wait_args`, which is
> +  used as follows:
> +
> +  .. list-table::
> +
> +     * - ``timeout``
> +       - Absolute timeout in nanoseconds. If ``NTSYNC_WAIT_REALTIME``
> +         is set, the timeout is measured against the REALTIME clock;
> +         otherwise it is measured against the MONOTONIC clock. If the
> +         timeout is equal to or earlier than the current time, the
> +         function returns immediately without sleeping. If ``timeout``
> +         is U64_MAX, the function will sleep until an object is
> +         signaled, and will not fail with ``ETIMEDOUT``.
> +     * - ``objs``
> +       - Pointer to an array of ``count`` file descriptors
> +         (specified as an integer so that the structure has the same
> +         size regardless of architecture). If any object is
> +         invalid, the function fails with ``EINVAL``.
> +     * - ``count``
> +       - Number of objects specified in the ``objs`` array.
> +         If greater than ``NTSYNC_MAX_WAIT_COUNT``, the function fails
> +         with ``EINVAL``.
> +     * - ``owner``
> +       - Mutex owner identifier. If any object in ``objs`` is a mutex,
> +         the ioctl will attempt to acquire that mutex on behalf of
> +         ``owner``. If ``owner`` is zero, the ioctl fails with
> +         ``EINVAL``.
> +     * - ``index``
> +       - On success, contains the index (into ``objs``) of the object
> +         which was signaled. If ``alert`` was signaled instead,
> +         this contains ``count``.
> +     * - ``alert``
> +       - Optional event object file descriptor. If nonzero, this
> +         specifies an "alert" event object which, if signaled, will
> +         terminate the wait. If nonzero, the identifier must point to a
> +         valid event.
> +     * - ``flags``
> +       - Zero or more flags. Currently the only flag is
> +         ``NTSYNC_WAIT_REALTIME``, which causes the timeout to be
> +         measured against the REALTIME clock instead of MONOTONIC.
> +     * - ``pad``
> +       - Unused, must be set to zero.
> +
> +  This function attempts to acquire one of the given objects. If unable
> +  to do so, it sleeps until an object becomes signaled, subsequently
> +  acquiring it, or the timeout expires. In the latter case the ioctl
> +  fails with ``ETIMEDOUT``. The function only acquires one object, even
> +  if multiple objects are signaled.
> +
> +  A semaphore is considered to be signaled if its count is nonzero, and
> +  is acquired by decrementing its count by one. A mutex is considered
> +  to be signaled if it is unowned or if its owner matches the ``owner``
> +  argument, and is acquired by incrementing its recursion count by one
> +  and setting its owner to the ``owner`` argument. An auto-reset event
> +  is acquired by designaling it; a manual-reset event is not affected
> +  by acquisition.
> +
> +  Acquisition is atomic and totally ordered with respect to other
> +  operations on the same object. If two wait operations (with different
> +  ``owner`` identifiers) are queued on the same mutex, only one is
> +  signaled. If two wait operations are queued on the same semaphore,
> +  and a value of one is posted to it, only one is signaled. The order
> +  in which threads are signaled is not specified.
> +
> +  If an abandoned mutex is acquired, the ioctl fails with
> +  ``EOWNERDEAD``. Although this is a failure return, the function may
> +  otherwise be considered successful. The mutex is marked as owned by
> +  the given owner (with a recursion count of 1) and as no longer
> +  abandoned, and ``index`` is still set to the index of the mutex.
> +
> +  The ``alert`` argument is an "extra" event which can terminate the
> +  wait, independently of all other objects. If members of ``objs`` and
> +  ``alert`` are both simultaneously signaled, a member of ``objs`` will
> +  always be given priority and acquired first.
> +
> +  It is valid to pass the same object more than once, including by
> +  passing the same event in the ``objs`` array and in ``alert``. If a
> +  wakeup occurs due to that object being signaled, ``index`` is set to
> +  the lowest index corresponding to that object.
> +
> +  The function may fail with ``EINTR`` if a signal is received.
> +
> +.. c:macro:: NTSYNC_IOC_WAIT_ALL
> +
> +  Poll on a list of objects, atomically acquiring all of them. Takes a
> +  pointer to struct :c:type:`ntsync_wait_args`, which is used
> +  identically to ``NTSYNC_IOC_WAIT_ANY``, except that ``index`` is
> +  always filled with zero on success if not woken via alert.
> +
> +  This function attempts to simultaneously acquire all of the given
> +  objects. If unable to do so, it sleeps until all objects become
> +  simultaneously signaled, subsequently acquiring them, or the timeout
> +  expires. In the latter case the ioctl fails with ``ETIMEDOUT`` and no
> +  objects are modified.
> +
> +  Objects may become signaled and subsequently designaled (through
> +  acquisition by other threads) while this thread is sleeping. Only
> +  once all objects are simultaneously signaled does the ioctl acquire
> +  them and return. The entire acquisition is atomic and totally ordered
> +  with respect to other operations on any of the given objects.
> +
> +  If an abandoned mutex is acquired, the ioctl fails with
> +  ``EOWNERDEAD``. Similarly to ``NTSYNC_IOC_WAIT_ANY``, all objects are
> +  nevertheless marked as acquired. Note that if multiple mutex objects
> +  are specified, there is no way to know which were marked as
> +  abandoned.
> +
> +  As with "any" waits, the ``alert`` argument is an "extra" event which
> +  can terminate the wait. Critically, however, an "all" wait will
> +  succeed if all members in ``objs`` are signaled, *or* if ``alert`` is
> +  signaled. In the latter case ``index`` will be set to ``count``. As
> +  with "any" waits, if both conditions are filled, the former takes
> +  priority, and objects in ``objs`` will be acquired.
> +
> +  Unlike ``NTSYNC_IOC_WAIT_ANY``, it is not valid to pass the same
> +  object more than once, nor is it valid to pass the same object in
> +  ``objs`` and in ``alert``. If this is attempted, the function fails
> +  with ``EINVAL``.

The doc LGTM, thanks!

Reviewed-by: Bagas Sanjaya <bagasdotme@gmail.com>

--=20
An old man doll... just what I always wanted! - Clara

--iA//aiK0mS6pr5b8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZhjMHwAKCRD2uYlJVVFO
o7/FAP9yH1ysblZ4jEXNxQSWiCvnf8y47VuUJu5Juxe3roRdnAD+O1/1BfQ7/Cmv
G0S7P22oILqfprmiwMF2s+QH8ukU8AY=
=odRa
-----END PGP SIGNATURE-----

--iA//aiK0mS6pr5b8--

