Return-Path: <linux-kselftest+bounces-46490-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B8A9C88DCB
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Nov 2025 10:09:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C89494E2AE6
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Nov 2025 09:09:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B47D302159;
	Wed, 26 Nov 2025 09:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Wqdxp7xy"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E30F315D2A
	for <linux-kselftest@vger.kernel.org>; Wed, 26 Nov 2025 09:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764148149; cv=none; b=bK0z6MHtSeOSWPICikCTyzbNpuD5gqYGoOQYK5L/khFVVervfjhO5fO7bBPfjjjrbEVCjxoSZnFdWF7ViMyZ+VJhgoc/+kLuHdIycryC3YlPifcB7KvPFcBa3XXkmDChfl5HRpk2WTh9QuXHrPiCd1J0DB0n7c3EuZgYyD9KI4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764148149; c=relaxed/simple;
	bh=6w7rkWZMm2OzZs1d4tCa6J3Sjb91QF8PMCdGPkKWBoM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=o08dc8/c8BT+QVcJoGRAI6NVoOu54kXriYJfKenuAN41WGaUFzfhP3J+/t5m2FoZNjJNTsAZ4vtHP3AYig9UVS3iXOHEIBc6GWfsuiMHXCwKr0H/uLIdx8aDnaH72pE/l28MYk3tBDbVeLpEY5Ae6nmpDKC2Gf0tyaf0Q/KI9yo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Wqdxp7xy; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764148146;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QioLbPIbEdhHQpe6rbAMDZ2orQalmMmfV24sYZuRkpM=;
	b=Wqdxp7xy4+Os0DcgohpI+IhukFCTVK0rGUSvqVRv8BLZfeGpU1i2hwC0nxwc8i691Om1m3
	eg4ZlyVYT/19A8sLOSA8frnM8WUQI2PujsyKTE+adOW1p/VLnmhuNNzWBbUv56UuoAzbwk
	u6j6oFikFAVEHAwURFEXxQTAbz2j1KE=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-610-9NRKrjBsMOyjmcTaAx-1rg-1; Wed,
 26 Nov 2025 04:09:02 -0500
X-MC-Unique: 9NRKrjBsMOyjmcTaAx-1rg-1
X-Mimecast-MFC-AGG-ID: 9NRKrjBsMOyjmcTaAx-1rg_1764148138
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 432561956096;
	Wed, 26 Nov 2025 09:08:57 +0000 (UTC)
Received: from fweimer-oldenburg.csb.redhat.com (unknown [10.44.32.146])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id F32D63001E83;
	Wed, 26 Nov 2025 09:08:46 +0000 (UTC)
From: Florian Weimer <fweimer@redhat.com>
To: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>,  Amir Goldstein <amir73il@gmail.com>,
 linux-fsdevel@vger.kernel.org,  Josef Bacik <josef@toxicpanda.com>,
 Jeff Layton <jlayton@kernel.org>,  Mike Yuan <me@yhndnzj.com>,
 Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>,
 Lennart Poettering <mzxreary@0pointer.de>,
 Daan De Meyer <daan.j.demeyer@gmail.com>,
 Aleksa Sarai <cyphar@cyphar.com>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Jens Axboe <axboe@kernel.dk>,  Tejun Heo <tj@kernel.org>,
 Johannes Weiner <hannes@cmpxchg.org>,
 Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>,  Eric Dumazet
 <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>,  Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>,
 Chuck Lever <chuck.lever@oracle.com>,  linux-nfs@vger.kernel.org,
 linux-kselftest@vger.kernel.org,  linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org,  cgroups@vger.kernel.org,
 netdev@vger.kernel.org, libc-alpha@sourceware.org, Dmitry V. Levin
 <ldv@strace.io>, address-sanitizer <address-sanitizer@googlegroups.com>,
 strace-devel@lists.strace.io
Subject: Stability of ioctl constants in the UAPI (Re: [PATCH 01/32] pidfs:
 validate extensible ioctls)
In-Reply-To: <20250910-work-namespace-v1-1-4dd56e7359d8@kernel.org> (Christian
	Brauner's message of "Wed, 10 Sep 2025 16:36:46 +0200")
References: <20250910-work-namespace-v1-0-4dd56e7359d8@kernel.org>
	<20250910-work-namespace-v1-1-4dd56e7359d8@kernel.org>
Date: Wed, 26 Nov 2025 10:08:44 +0100
Message-ID: <lhu7bvd6u03.fsf_-_@oldenburg.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

* Christian Brauner:

> Validate extensible ioctls stricter than we do now.
>
> Signed-off-by: Christian Brauner <brauner@kernel.org>
> ---
>  fs/pidfs.c         |  2 +-
>  include/linux/fs.h | 14 ++++++++++++++
>  2 files changed, 15 insertions(+), 1 deletion(-)
>
> diff --git a/fs/pidfs.c b/fs/pidfs.c
> index edc35522d75c..0a5083b9cce5 100644
> --- a/fs/pidfs.c
> +++ b/fs/pidfs.c
> @@ -440,7 +440,7 @@ static bool pidfs_ioctl_valid(unsigned int cmd)
>  		 * erronously mistook the file descriptor for a pidfd.
>  		 * This is not perfect but will catch most cases.
>  		 */
> -		return (_IOC_TYPE(cmd) == _IOC_TYPE(PIDFD_GET_INFO));
> +		return extensible_ioctl_valid(cmd, PIDFD_GET_INFO, PIDFD_INFO_SIZE_VER0);
>  	}
>  
>  	return false;
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index d7ab4f96d705..2f2edc53bf3c 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -4023,4 +4023,18 @@ static inline bool vfs_empty_path(int dfd, const char __user *path)
>  
>  int generic_atomic_write_valid(struct kiocb *iocb, struct iov_iter *iter);
>  
> +static inline bool extensible_ioctl_valid(unsigned int cmd_a,
> +					  unsigned int cmd_b, size_t min_size)
> +{
> +	if (_IOC_DIR(cmd_a) != _IOC_DIR(cmd_b))
> +		return false;
> +	if (_IOC_TYPE(cmd_a) != _IOC_TYPE(cmd_b))
> +		return false;
> +	if (_IOC_NR(cmd_a) != _IOC_NR(cmd_b))
> +		return false;
> +	if (_IOC_SIZE(cmd_a) < min_size)
> +		return false;
> +	return true;
> +}
> +
>  #endif /* _LINUX_FS_H */

Is this really the right direction?  This implies that the ioctl
constants change as the structs get extended.  At present, this impacts
struct pidfd_info and PIDFD_GET_INFO.

I think this is a deparature from the previous design, where (low-level)
userspace did not have not worry about the internal structure of ioctl
commands and could treat them as opaque bit patterns.  With the new
approach, we have to dissect some of the commands in the same way
extensible_ioctl_valid does it above.

So far, this impacts glibc ABI tests.  Looking at the strace sources, it
doesn't look to me as if the ioctl handler is prepared to deal with this
situation, either, because it uses the full ioctl command for lookups.

The sanitizers could implement generic ioctl checking with the embedded
size information in the ioctl command, but the current code structure is
not set up to handle this because it's indexed by the full ioctl
command, not the type.  I think in some cases, the size is required to
disambiguate ioctl commands because the type field is not unique across
devices.  In some cases, the sanitizers would have to know the exact
command (not just the size), to validate points embedded in the struct
passed to the ioctl.  So I don't think changing ioctl constants when
extensible structs change is obviously beneficial to the sanitizers,
either.

I would prefer if the ioctl commands could be frozen and decoupled from
the structs.  As far as I understand it, there is no requirement that
the embedded size matches what the kernel deals with.

Thanks,
Florian


