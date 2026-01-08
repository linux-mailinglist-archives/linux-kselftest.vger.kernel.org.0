Return-Path: <linux-kselftest+bounces-48505-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id B5B21D02AEF
	for <lists+linux-kselftest@lfdr.de>; Thu, 08 Jan 2026 13:39:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1D8813018C65
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 Jan 2026 12:38:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 815504B3A9D;
	Thu,  8 Jan 2026 12:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OF5+924/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E09754B3A96
	for <linux-kselftest@vger.kernel.org>; Thu,  8 Jan 2026 12:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767874820; cv=none; b=soKV2jIQb9iIo2EGWzqQXzGHqf0NmM9Q+8WygKXLACUdMinnCQNc2ZEgsVNjzcQbWIgHmvVj6jOS1C1vrx6U3sl+j7C5VncGTzxdUJDo7c+bLL/tN92ha62UaYZunNORY0lRTPDTgKYXpZo2dXEARNUkskFI8wpuO62SHRR2rqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767874820; c=relaxed/simple;
	bh=NNpGr0TUosqGSN2a0EGi84k3Eo0OmIJDd6rO5DGlzxA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DTiXhlbEjMBZhWRxt5kU32fAsrEwqokN02DM8fCkvXvkfpG/Zzk07Y4Fvar3lhQ1fJCbRg9ksgHb8dcUPRq/mgouMoe/28zwP1OYK/qsd7367kJxwkng2julM9C3HHoS8KnBkB8YyhqV7UeeTEdnaWnrLjN1ggnHopuW+eqEjW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OF5+924/; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767874816;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=O3gEBAPNPXaPH1lX1DR0amMzqk/RyPoLCSLo0EIYFeo=;
	b=OF5+924//pmTE+XzYLOk38LcqvxwnJEWxqQ/PQZIaCX0lAnLs6mULnPk4rEblggQi4VRH7
	bLBBAB6lWd584SLpqlHgm2R251ZRBGrBY7beKPpKUhn1xmMekDKszgCGxoF+3qgEi/GYIF
	14OTjFqc7awS3prtnYDKG8f8uRhDf6s=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-457-J4mfcCOBPt-WaBJOwseDYQ-1; Thu,
 08 Jan 2026 07:20:13 -0500
X-MC-Unique: J4mfcCOBPt-WaBJOwseDYQ-1
X-Mimecast-MFC-AGG-ID: J4mfcCOBPt-WaBJOwseDYQ_1767874811
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 60BE21956059;
	Thu,  8 Jan 2026 12:20:11 +0000 (UTC)
Received: from fedora (unknown [10.72.116.180])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CE57430002D1;
	Thu,  8 Jan 2026 12:20:03 +0000 (UTC)
Date: Thu, 8 Jan 2026 20:19:58 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Jens Axboe <axboe@kernel.dk>, Shuah Khan <shuah@kernel.org>,
	linux-block@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Stanley Zhang <stazhang@purestorage.com>,
	Uday Shankar <ushankar@purestorage.com>,
	"Martin K . Petersen" <martin.petersen@oracle.com>
Subject: Re: [PATCH v4 09/19] ublk: implement integrity user copy
Message-ID: <aV-g7obwQw4HFcn8@fedora>
References: <20260108091948.1099139-1-csander@purestorage.com>
 <20260108091948.1099139-10-csander@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260108091948.1099139-10-csander@purestorage.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On Thu, Jan 08, 2026 at 02:19:37AM -0700, Caleb Sander Mateos wrote:
> From: Stanley Zhang <stazhang@purestorage.com>
> 
> Add a function ublk_copy_user_integrity() to copy integrity information
> between a request and a user iov_iter. This mirrors the existing
> ublk_copy_user_pages() but operates on request integrity data instead of
> regular data. Check UBLKSRV_IO_INTEGRITY_FLAG in iocb->ki_pos in
> ublk_user_copy() to choose between copying data or integrity data.
> 
> Signed-off-by: Stanley Zhang <stazhang@purestorage.com>
> [csander: change offset units from data bytes to integrity data bytes,
>  fix CONFIG_BLK_DEV_INTEGRITY=n build, rebase on user copy refactor]
> Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>

Reviewed-by: Ming Lei <ming.lei@redhat.com>


Thanks,
Ming


