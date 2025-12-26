Return-Path: <linux-kselftest+bounces-47964-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CC2ECCDE397
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 Dec 2025 03:16:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6521D300658A
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 Dec 2025 02:16:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89F31239E63;
	Fri, 26 Dec 2025 02:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YC8ThcAU"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC7F51DE2AD
	for <linux-kselftest@vger.kernel.org>; Fri, 26 Dec 2025 02:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766715368; cv=none; b=u21fjawehTIJ7nBCjHo0NTzO7PJQ1YduOmqA4+XG9Acre2DsLT/uC8QLRnoNuNGXHpEoRpPHx6Gt8rK7qpdDL+6JdCJXNTYuvkxficBWTY7IIQlt55dPVDpw7dVzCjtC45XBHHYrZkC1SZpnAMDmdEw768noD0NVadX38gFfxmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766715368; c=relaxed/simple;
	bh=XJz/xS02uPxhxHrSA9i7sk4zqN2+z1O+TebFqAePuVI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZHlDXAtm9qrZ6O0WsGapSCFGTg/2bIhQUrbwn586PWDgZMY5rBYb4qZ1uRr1mvyn2ibeeD8FzD1tbVI3ne95tuGCitfHy5GBIrNJVbcm6mYbZAo9iR3dXGuGGYCvaZl80Q671TyQtiO0x2qqzOW4YYXkhVD4QeCIz6bO9TqRhCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YC8ThcAU; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1766715365;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ofRuYP0y+JnF5wSfDPx4NnS4F4KqjSuSTtEd+Y5vRs0=;
	b=YC8ThcAUTgRZIEyJh97C44KFwwM3Qm5WQyaJ0Tm1/OUQJMvLwemanuh93Nv7hnJZti2MP3
	85IsG6R31d/1ejrEBAt1UyVEOLJHpv2RHv9R+bVLwqESEzgANKDzwnoXdvsM3F7VA+k4fN
	REoHE/giSHYgUfHhDtPaZNHXRtiYIWU=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-671-s15KnxOLNWuCjXuk1F7qjg-1; Thu,
 25 Dec 2025 21:16:02 -0500
X-MC-Unique: s15KnxOLNWuCjXuk1F7qjg-1
X-Mimecast-MFC-AGG-ID: s15KnxOLNWuCjXuk1F7qjg_1766715360
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 56CA81956054;
	Fri, 26 Dec 2025 02:16:00 +0000 (UTC)
Received: from fedora (unknown [10.72.116.63])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9B2BF30001B9;
	Fri, 26 Dec 2025 02:15:55 +0000 (UTC)
Date: Fri, 26 Dec 2025 10:15:50 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Jens Axboe <axboe@kernel.dk>, Shuah Khan <shuah@kernel.org>,
	linux-block@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Stanley Zhang <stazhang@purestorage.com>,
	Uday Shankar <ushankar@purestorage.com>
Subject: Re: [PATCH 11/20] ublk: move offset check out of
 __ublk_check_and_get_req()
Message-ID: <aU3v1qBBRmDAcNzl@fedora>
References: <20251217053455.281509-1-csander@purestorage.com>
 <20251217053455.281509-12-csander@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251217053455.281509-12-csander@purestorage.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On Tue, Dec 16, 2025 at 10:34:45PM -0700, Caleb Sander Mateos wrote:
> __ublk_check_and_get_req() checks that the passed in offset is within
> the data length of the specified ublk request. However, only user copy
> (ublk_check_and_get_req()) supports accessing ublk request data at a
> nonzero offset. Zero-copy buffer registration (ublk_register_io_buf())
> always passes 0 for the offset, so the check is unnecessary. Move the
> check from __ublk_check_and_get_req() to ublk_check_and_get_req().
> 
> Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>

Reviewed-by: Ming Lei <ming.lei@redhat.com>


Thanks,
Ming


