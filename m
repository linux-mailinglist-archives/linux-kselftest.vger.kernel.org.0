Return-Path: <linux-kselftest+bounces-48503-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 58F3DD036C0
	for <lists+linux-kselftest@lfdr.de>; Thu, 08 Jan 2026 15:41:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1BCAC31B1A47
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 Jan 2026 14:26:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2394643489D;
	Thu,  8 Jan 2026 12:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JJmhVg/a"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8017243A200
	for <linux-kselftest@vger.kernel.org>; Thu,  8 Jan 2026 12:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767874490; cv=none; b=OEVV7bs/jT3qJtyT0m7Dv97y92ZWEx5X8CGL9sMclBblBjZ+l8hLtbkEwtCH7SdFUJuxPoC7N6dxC7JmGidtDSGTXPeT1NWamtDm/mRSuZu6fYcgb04k4eLYMYeBMkkNqksNudnjWRTBOdZvO3ObUjANPUPddFRBTECzYqZgO9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767874490; c=relaxed/simple;
	bh=8OjR00LI97LjKvDNXw3KG6qSBV2UsnBXXlfmyFmZlxY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gJKkO7rGwFjCIduGrueuKqSszNDIoW4jkXCHlIaEidLBn0hWvImCyRhqxaVO254Yg7U6MmTcpNmpaJ9eXAWQexLIAliNpp4T1QOHuvfZB0+xXii2N+Q8krsdlQ9E0WoG7DwVc3cf2OGcDkeXnBsMb2T7RBdzaxzFOikZFgimOZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JJmhVg/a; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767874485;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=t2qCFNA4/Erewu1t8D7IW9h5dHqTnH3aALQyYtKnmOM=;
	b=JJmhVg/aFcED5FvDXKZcsVq9AFmFMIzXtxfqz2in7+WhHTpAzZrmpHqnSFBLyEcjHvguEz
	gV5iXTUxlLwBlA/T95WRvpKbpWCCr4koluUsXGAbKo/4MXZz3VlTjja9i7eRwGD7hKrxvo
	+CAKh/SQVzKX39VCMhPYdBxjkunAl8g=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-561-AblKnrJkOPa--NQ8ZeZf2w-1; Thu,
 08 Jan 2026 07:14:38 -0500
X-MC-Unique: AblKnrJkOPa--NQ8ZeZf2w-1
X-Mimecast-MFC-AGG-ID: AblKnrJkOPa--NQ8ZeZf2w_1767874477
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C8BE0195608D;
	Thu,  8 Jan 2026 12:14:36 +0000 (UTC)
Received: from fedora (unknown [10.72.116.180])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1643F19560A2;
	Thu,  8 Jan 2026 12:14:29 +0000 (UTC)
Date: Thu, 8 Jan 2026 20:14:23 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Jens Axboe <axboe@kernel.dk>, Shuah Khan <shuah@kernel.org>,
	linux-block@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Stanley Zhang <stazhang@purestorage.com>,
	Uday Shankar <ushankar@purestorage.com>,
	"Martin K . Petersen" <martin.petersen@oracle.com>
Subject: Re: [PATCH v4 03/19] ublk: support UBLK_PARAM_TYPE_INTEGRITY in
 device creation
Message-ID: <aV-fnxYoyCdphIU5@fedora>
References: <20260108091948.1099139-1-csander@purestorage.com>
 <20260108091948.1099139-4-csander@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260108091948.1099139-4-csander@purestorage.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On Thu, Jan 08, 2026 at 02:19:31AM -0700, Caleb Sander Mateos wrote:
> From: Stanley Zhang <stazhang@purestorage.com>
> 
> Add a feature flag UBLK_F_INTEGRITY for a ublk server to request
> integrity/metadata support when creating a ublk device. The ublk server
> can also check for the feature flag on the created device or the result
> of UBLK_U_CMD_GET_FEATURES to tell if the ublk driver supports it.
> UBLK_F_INTEGRITY requires UBLK_F_USER_COPY, as user copy is the only
> data copy mode initially supported for integrity data.
> Add UBLK_PARAM_TYPE_INTEGRITY and struct ublk_param_integrity to struct
> ublk_params to specify the integrity params of a ublk device.
> UBLK_PARAM_TYPE_INTEGRITY requires UBLK_F_INTEGRITY and a nonzero
> metadata_size. The LBMD_PI_CAP_* and LBMD_PI_CSUM_* values from the
> linux/fs.h UAPI header are used for the flags and csum_type fields.
> If the UBLK_PARAM_TYPE_INTEGRITY flag is set, validate the integrity
> parameters and apply them to the blk_integrity limits.
> The struct ublk_param_integrity validations are based on the checks in
> blk_validate_integrity_limits(). Any invalid parameters should be
> rejected before being applied to struct blk_integrity.
> 
> Signed-off-by: Stanley Zhang <stazhang@purestorage.com>
> [csander: drop redundant pi_tuple_size field, use block metadata UAPI
>  constants, add param validation]
> Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>

Reviewed-by: Ming Lei <ming.lei@redhat.com>


Thanks,
Ming


