Return-Path: <linux-kselftest+bounces-48506-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DD8CAD029FF
	for <lists+linux-kselftest@lfdr.de>; Thu, 08 Jan 2026 13:28:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E5530300DDB0
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 Jan 2026 12:28:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CADF847DFB2;
	Thu,  8 Jan 2026 12:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KB+BSUz9"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19E1A43E9EF
	for <linux-kselftest@vger.kernel.org>; Thu,  8 Jan 2026 12:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767874897; cv=none; b=Ee2IGTDxUCZV/LLiU7yV5lPHu1e9ntbrqOwZDzl6qFQMlm/wY1OMPjHdeGmIQ+SRs0uMEnKvvrDGF4JVZBETCxJxWSezX1Q4IPwCeNpY1GbH13lC1ft5t7A1T015jLBV6SjIghEvcc+TJ0xYFRo9kPBzYCvQM2qjv1XikGyVvLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767874897; c=relaxed/simple;
	bh=8SM4MI9MHu2d+B7/tHCcJBOA3yty0hENdIFkqsI3XQg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tCaqkQjJjNSxEX9oKM5z+B7wMHBU8kZQMqyoYDamE+gzwnjL1QcnVZdT0aY/DwROq9wXQGwRml4uGs1+imgoscra0rgw91B/8FsHm5XbwnwZ7HH1/MSIS1qah/6+BGh/1hPb98sjEMJNz+977ebKL2k/Y1h4neefTSV27cJ0deM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KB+BSUz9; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767874895;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=26Rj5TAjE/4/XHt4A+TRRbU6e7CFdZ1rGBzWbzvXsvA=;
	b=KB+BSUz9gxDM5Ma4p7N1LUv5jhgxscNgyN81GyWLFdDgxey5+ikkqHwEp5wSRaJL/pYCJ1
	WaY5FM1rjpMsj0kQmUNOokfMV2duzn3CKgRMf4hXhckCfD0VDrMkIkvXMLMVYt2MEHwbsf
	4CH1/qCeVPCGiV1i8bR4OvvZ2aT+Pl8=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-44-_5jIPL6tNyaTpF0xrqTXgw-1; Thu,
 08 Jan 2026 07:21:32 -0500
X-MC-Unique: _5jIPL6tNyaTpF0xrqTXgw-1
X-Mimecast-MFC-AGG-ID: _5jIPL6tNyaTpF0xrqTXgw_1767874890
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 70BC619560B7;
	Thu,  8 Jan 2026 12:21:30 +0000 (UTC)
Received: from fedora (unknown [10.72.116.180])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DD56518008FF;
	Thu,  8 Jan 2026 12:21:23 +0000 (UTC)
Date: Thu, 8 Jan 2026 20:21:18 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Jens Axboe <axboe@kernel.dk>, Shuah Khan <shuah@kernel.org>,
	linux-block@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Stanley Zhang <stazhang@purestorage.com>,
	Uday Shankar <ushankar@purestorage.com>,
	"Martin K . Petersen" <martin.petersen@oracle.com>
Subject: Re: [PATCH v4 13/19] selftests: ublk: add utility to get block
 device metadata size
Message-ID: <aV-hPqT3B4rHV2s8@fedora>
References: <20260108091948.1099139-1-csander@purestorage.com>
 <20260108091948.1099139-14-csander@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260108091948.1099139-14-csander@purestorage.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

On Thu, Jan 08, 2026 at 02:19:41AM -0700, Caleb Sander Mateos wrote:
> Some block device integrity parameters are available in sysfs, but
> others are only accessible using the FS_IOC_GETLBMD_CAP ioctl. Add a
> metadata_size utility program to print out the logical block metadata
> size, PI offset, and PI size within the metadata. Example output:
> $ metadata_size /dev/ublkb0
> metadata_size: 64
> pi_offset: 56
> pi_tuple_size: 8
> 
> Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>

Reviewed-by: Ming Lei <ming.lei@redhat.com>

Thanks
Ming


