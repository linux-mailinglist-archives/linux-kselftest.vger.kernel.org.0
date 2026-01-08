Return-Path: <linux-kselftest+bounces-48510-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5251ED02BB1
	for <lists+linux-kselftest@lfdr.de>; Thu, 08 Jan 2026 13:49:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A60FA300E421
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 Jan 2026 12:49:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16174465EAA;
	Thu,  8 Jan 2026 12:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AIjEmJzH"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86CF7465D3D
	for <linux-kselftest@vger.kernel.org>; Thu,  8 Jan 2026 12:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767876169; cv=none; b=LHYLyyu/OohHLpAUGBi8n9rYIma9bvNI+LaqSleBdtPyzYJyNmLmvz7mSC5RrWq/4iPzYRwbjmB6N6jDhISdObkiae31z/GBoRLKc/c6hDaH1HePZMjwXDie5x5BDLVZAe2BcZLOFtwuv/86dCHBoOlAXmwlj/4rK0CFTtb+EZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767876169; c=relaxed/simple;
	bh=rCID7ihfpqiqBJh5JGnaHJiTTRwiLi8w2ml7fCklyR4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sZLNihsTInpfd7owYFRhZauFM/SirtEs5k1c5mUyzKHetgDX0rjDIiuc+qHA4uqu2LljVlfrUExjZKiQjMWUhDIX2wdnRYMha0l2KRAbT2VbgLF/3XdcLSaT6zoDlEZukszx1qRtyIUzHvSPVjB2OyEJepIXJUSwMv6kUvMfzfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AIjEmJzH; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767876166;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xxorc1hYnSYDj5qHulGUOtJiB+WHqxZGOCjvPA69Ukg=;
	b=AIjEmJzHZCgJQouXoqqMI0xKEHn/66r56rNPvYF2H64AeVd4fUkOhssvPASKe3WPn0MqhE
	IbJJlqGVs30TK8IJLRcaeMmatHIuQQsikaoKpxm2Jwm5tFjnLK7MkclLCEFQppyX8PcYFB
	jLvLT8OerH8OeFOo0fuMXaS/HImtdzc=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-517-xzBPntqaM8ibymP7cKLTBw-1; Thu,
 08 Jan 2026 07:42:43 -0500
X-MC-Unique: xzBPntqaM8ibymP7cKLTBw-1
X-Mimecast-MFC-AGG-ID: xzBPntqaM8ibymP7cKLTBw_1767876161
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A7FB518005AE;
	Thu,  8 Jan 2026 12:42:41 +0000 (UTC)
Received: from fedora (unknown [10.72.116.180])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DC8A430002D1;
	Thu,  8 Jan 2026 12:42:35 +0000 (UTC)
Date: Thu, 8 Jan 2026 20:42:30 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Jens Axboe <axboe@kernel.dk>, Shuah Khan <shuah@kernel.org>,
	linux-block@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Stanley Zhang <stazhang@purestorage.com>,
	Uday Shankar <ushankar@purestorage.com>,
	"Martin K . Petersen" <martin.petersen@oracle.com>
Subject: Re: [PATCH v4 17/19] selftests: ublk: add integrity data support to
 loop target
Message-ID: <aV-mNgMwsYEMTLSW@fedora>
References: <20260108091948.1099139-1-csander@purestorage.com>
 <20260108091948.1099139-18-csander@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260108091948.1099139-18-csander@purestorage.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On Thu, Jan 08, 2026 at 02:19:45AM -0700, Caleb Sander Mateos wrote:
> To perform and end-to-end test of integrity information through a ublk
> device, we need to actually store it somewhere and retrieve it. Add this
> support to kublk's loop target. It uses a second backing file for the
> integrity data corresponding to the data stored in the first file.
> The integrity file is initialized with byte 0xFF, which ensures the app
> and reference tags are set to the "escape" pattern to disable the
> bio-integrity-auto guard and reftag checks until the blocks are written.
> The integrity file is opened without O_DIRECT since it will be accessed
> at sub-block granularity. Each incoming read/write results in a pair of
> reads/writes, one to the data file, and one to the integrity file. If
> either backing I/O fails, the error is propagated to the ublk request.
> If both backing I/Os read/write some bytes, the ublk request is
> completed with the smaller of the number of blocks accessed by each I/O.
> 
> Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>

Reviewed-by: Ming Lei <ming.lei@redhat.com>

Thanks,
Ming


