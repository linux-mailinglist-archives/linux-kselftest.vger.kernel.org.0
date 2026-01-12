Return-Path: <linux-kselftest+bounces-48748-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 16E64D134A6
	for <lists+linux-kselftest@lfdr.de>; Mon, 12 Jan 2026 15:50:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BCA3B3010283
	for <lists+linux-kselftest@lfdr.de>; Mon, 12 Jan 2026 14:45:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A4D02BD586;
	Mon, 12 Jan 2026 14:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O8fr9WhA"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3C861DEFF5
	for <linux-kselftest@vger.kernel.org>; Mon, 12 Jan 2026 14:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768229134; cv=none; b=mHtRYNS/b/HroGq9BAP7zxzzQbUIDYqYsG6LH6r5ONu1u9Cp44fOsWTMBmoTK9X+KRmO+gLzK7PlYr8YyJAt1euJIYlJ1YhEbBD55J3aSpSmVDqdnTEvM/C5Rf+CctGuo6cNhBlOlq5LaDOP/bcv1T9Pbfy9Dn1xat7+pWEXGQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768229134; c=relaxed/simple;
	bh=+fFy/U/0QS2ExUBKXUxVDqLiAOAkFCHqy0COjF6Llvg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dtIWt/6sE9HUjezajyIbdDx5oiN1BYl8DR1facGlM+FulYXK4lwrXXhydfshaCwDEvy9BAHvB7bjzxSQJ75RzMgd2UDDWVgYjShnVtK0hsAqhVbRR9RuS/KS1dmErN2hfcyyrPcpSXUzRVxPYUDrxb2+UzQjMlofJGn6LGzhkPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=O8fr9WhA; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768229131;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ETHI/3OUezgnRwS6KYeqq9Ma7jrZzKcMVYcP88zenJo=;
	b=O8fr9WhAV9AT0ZBjdjdsXWCrS8Fq/B5CJEuPCu17CZZslJ9zKZ2LsxHi8Ph+8s9IIuxc76
	KAYNbeM2sXCDCpNNwHtZ597X86cqq6/fONRB7hVyHnQRZ4nggdR/zf4JqgjA2g0uw220IL
	/7iDhqImIkdnYe936vCRq/HSR7+5GpU=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-652-xZh1AQRqN6CnkJiPHF_qdg-1; Mon,
 12 Jan 2026 09:45:28 -0500
X-MC-Unique: xZh1AQRqN6CnkJiPHF_qdg-1
X-Mimecast-MFC-AGG-ID: xZh1AQRqN6CnkJiPHF_qdg_1768229126
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8DF3D1956050;
	Mon, 12 Jan 2026 14:45:26 +0000 (UTC)
Received: from fedora (unknown [10.72.116.42])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 188E918004D8;
	Mon, 12 Jan 2026 14:45:20 +0000 (UTC)
Date: Mon, 12 Jan 2026 22:45:15 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Jens Axboe <axboe@kernel.dk>, Shuah Khan <shuah@kernel.org>,
	linux-block@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Stanley Zhang <stazhang@purestorage.com>,
	Uday Shankar <ushankar@purestorage.com>,
	"Martin K . Petersen" <martin.petersen@oracle.com>
Subject: Re: [PATCH v4 00/19] ublk: add support for integrity data
Message-ID: <aWUI-4Z30PlhDB_Z@fedora>
References: <20260108091948.1099139-1-csander@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260108091948.1099139-1-csander@purestorage.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

On Thu, Jan 08, 2026 at 02:19:28AM -0700, Caleb Sander Mateos wrote:
> Much work has recently gone into supporting block device integrity data
> (sometimes called "metadata") in Linux. Many NVMe devices these days
> support metadata transfers and/or automatic protection information
> generation and verification. However, ublk devices can't yet advertise
> integrity data capabilities. This patch series wires up support for
> integrity data in ublk. The ublk feature is referred to as "integrity"
> rather than "metadata" to match the block layer's name for it and to
> avoid confusion with the existing and unrelated UBLK_IO_F_META.
> 
> To advertise support for integrity data, a ublk server fills out the
> struct ublk_params's integrity field and sets UBLK_PARAM_TYPE_INTEGRITY.
> The struct ublk_param_integrity flags and csum_type fields use the
> existing LBMD_PI_* constants from the linux/fs.h UAPI header. The ublk
> driver fills out a corresponding struct blk_integrity.
> 
> When a request with integrity data is issued to the ublk device, the
> ublk driver sets UBLK_IO_F_INTEGRITY in struct ublksrv_io_desc's
> op_flags field. This is necessary for a ublk server for which
> bi_offload_capable() returns true to distinguish requests with integrity
> data from those without.
> 
> Integrity data transfers can currently only be performed via the ublk
> user copy mechanism. The overhead of zero-copy buffer registration makes
> it less appealing for the small transfers typical of integrity data.
> Additionally, neither io_uring NVMe passthru nor IORING_RW_ATTR_FLAG_PI
> currently allow an io_uring registered buffer for the integrity data.
> The ki_pos field of the struct kiocb passed to the user copy
> ->{read,write}_iter() callback gains a bit UBLKSRV_IO_INTEGRITY_FLAG for
> a ublk server to indicate whether to access the request's data or
> integrity data.
> 
> Not yet supported is an analogue for the IO_INTEGRITY_CHK_*/BIP_CHECK_*
> flags to ask the ublk server to verify the guard, reftag, and/or apptag
> of a request's protection information. The user copy mechanism currently
> forbids a ublk server from reading the data/integrity buffer of a
> read-direction request. We could potentially relax this restriction for
> integrity data on reads. Alternatively, the ublk driver could verify the
> requested fields as part of the user copy operation.
> 
> v4:
> - Add max_integrity_segments to struct ublk_param_integrity (Ming)
> - Move UBLKSRV_IO_INTEGRITY_FLAG to avoid overflow from
>   QID + UBLKSRV_IO_BUF_OFFSET (Ming)
> - Check UBLK_F_INTEGRITY when UBLKSRV_IO_INTEGRITY_FLAG is used (Ming)
> - Initialize integrity backing file to disable integrity checks (Ming)
 
Hi Jens,

Can you consider to queue V4 into for-7.0/block if you are fine? So I can rebase
my BATCH_IO patchset against this one.

Thanks,
Ming


