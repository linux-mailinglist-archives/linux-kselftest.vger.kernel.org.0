Return-Path: <linux-kselftest+bounces-47963-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A8F8CDE376
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 Dec 2025 03:10:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 37C143000965
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 Dec 2025 02:10:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D7411EA7CE;
	Fri, 26 Dec 2025 02:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LAOJVq9u"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 677D51A7264
	for <linux-kselftest@vger.kernel.org>; Fri, 26 Dec 2025 02:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766715035; cv=none; b=fQeo1Gku40AUiyMybTvGwCKx+7ocMc76g/f8ZOwODCgOJNrLpZMX6NWRZ3Uh754SEpekRIccQNZlL7KnoItiD++o3bTgtx1PgYqucq0OH09z8ZtgTr3s9FID/vIh8w9Oaj8cZ0mGmizgWoGwCgqedvsycLUVVt2DuRm698ZgX9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766715035; c=relaxed/simple;
	bh=9ggAwuo9TW3kSxNTI5EKpb2ZQiqj4TjR/tA4HojIjx8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IYn2HZCveojuNHru9ljD9DuBDh6hVujbYTE+EN3zkpp+sy/LihmCcqo5JCRydw2TFw9N0++JoF7KIO7AZAmK00uSdxibfuSoX9eM3ZNbehxCYWvaDu/4SrdI8AZFmkCOhyfMk17bWDZfbp2OtrskIbz5ucSUFbSOjYjLOV3RVqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LAOJVq9u; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1766715032;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MDERFqptweSKP7bvhM14cY703imQm6StG/LqXv4G3fQ=;
	b=LAOJVq9utmpqrM7wLd0+uKaGbsqwOjTpEE/OYOqO/ZJjDIIw9UYtQYCB9jjcLIwddLmm5+
	D5y45xYMvxGea0A9jSKuURIvBa2g2B3V8Td5Mf0f7SNvR672XZyu7me1eGw39a8vvPy70P
	sgw/KDq1mkXG7CLhEz5qcWrI7DcCCto=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-601-d0hpOGyCOB2lKgQj7nxngQ-1; Thu,
 25 Dec 2025 21:10:29 -0500
X-MC-Unique: d0hpOGyCOB2lKgQj7nxngQ-1
X-Mimecast-MFC-AGG-ID: d0hpOGyCOB2lKgQj7nxngQ_1766715026
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3F1001956050;
	Fri, 26 Dec 2025 02:10:26 +0000 (UTC)
Received: from fedora (unknown [10.72.116.63])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id EFCD119560A7;
	Fri, 26 Dec 2025 02:10:20 +0000 (UTC)
Date: Fri, 26 Dec 2025 10:10:15 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Jens Axboe <axboe@kernel.dk>, Shuah Khan <shuah@kernel.org>,
	linux-block@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Stanley Zhang <stazhang@purestorage.com>,
	Uday Shankar <ushankar@purestorage.com>
Subject: Re: [PATCH 10/20] ublk: inline ublk_check_and_get_req() into
 ublk_user_copy()
Message-ID: <aU3uh3cAGEP6EJ1T@fedora>
References: <20251217053455.281509-1-csander@purestorage.com>
 <20251217053455.281509-11-csander@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251217053455.281509-11-csander@purestorage.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On Tue, Dec 16, 2025 at 10:34:44PM -0700, Caleb Sander Mateos wrote:
> ublk_check_and_get_req() has a single callsite in ublk_user_copy(). It
> takes a ton of arguments in order to pass local variables from
> ublk_user_copy() to ublk_check_and_get_req() and vice versa. And more
> are about to be added. Combine the functions to reduce the argument
> passing noise.
> 
> Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>

Reviewed-by: Ming Lei <ming.lei@redhat.com>

Thanks,
Ming


