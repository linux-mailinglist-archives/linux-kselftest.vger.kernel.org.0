Return-Path: <linux-kselftest+bounces-32735-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E3A7AAB0BF6
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 May 2025 09:44:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B91D13ADBE9
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 May 2025 07:44:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1552626FDBA;
	Fri,  9 May 2025 07:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hErbatne"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C34EB218EB1
	for <linux-kselftest@vger.kernel.org>; Fri,  9 May 2025 07:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746776682; cv=none; b=VbIOT1OKgANNA5F9V7AopZf3SshnHYhveQ/ZtQKBgIIk1carX3dDkK65zwrT7LmQhFUgxHcl8mKpD0TG5jWEzyiFk8/BMNPyz/GWx84+9K+tw3j971uL8q0CCo7qB3zUv/BMUVq5ddA9zb+4LhqOurnsaucylxpICZJVGvJQBMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746776682; c=relaxed/simple;
	bh=TAty2NV9PsuMxmoZonWPYrPQIhfitnRzbAtx54JRaxc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NeEdc2RsoqgLPBKiIALxdvZQ78cCLV3cdVBipU02pyZabo/nPqtWMIPujF2pFKPBTOOm/9eS71KLV+PjA+/G94kWIZpNE98B0HwZGIDwyT/XXMDH3XJ9Rj1Unx6e8irC/6qKK4hNdlx/mrnhHNJrdHMxRrgIn0l7cbS9XPqo/7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hErbatne; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1746776678;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=seu2ludiam+HVLe4Ct2xcwi5iBXcFBPfUZ2n7NKG5WQ=;
	b=hErbatne1r5SBCFlQxo6pthMiCUQBgNd4HxNrew5M8eBK/+Ta/yHjyw4fDjNIFUAKyvc8S
	YwmQ9Me6REjXdjAghqudFBCSEqLYnDd3q68Og4ZII0p/oqVzEpgBNMtR2JiZFkrqSvWkTG
	lOz9xO7z21c3HLyBkJ4MWlNAdTohw2w=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-58-8bGUiQmlOrOnCf57PDtyCw-1; Fri,
 09 May 2025 03:44:34 -0400
X-MC-Unique: 8bGUiQmlOrOnCf57PDtyCw-1
X-Mimecast-MFC-AGG-ID: 8bGUiQmlOrOnCf57PDtyCw_1746776672
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 89D0819560B2;
	Fri,  9 May 2025 07:44:32 +0000 (UTC)
Received: from fedora (unknown [10.72.116.140])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 27A8618004A7;
	Fri,  9 May 2025 07:44:25 +0000 (UTC)
Date: Fri, 9 May 2025 15:44:19 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Uday Shankar <ushankar@purestorage.com>
Cc: Jens Axboe <axboe@kernel.dk>,
	Caleb Sander Mateos <csander@purestorage.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Shuah Khan <shuah@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v6 5/8] selftests: ublk: kublk: lift queue initialization
 out of thread
Message-ID: <aB2yU5HUYtmKFzol@fedora>
References: <20250507-ublk_task_per_io-v6-0-a2a298783c01@purestorage.com>
 <20250507-ublk_task_per_io-v6-5-a2a298783c01@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250507-ublk_task_per_io-v6-5-a2a298783c01@purestorage.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

On Wed, May 07, 2025 at 03:49:39PM -0600, Uday Shankar wrote:
> Currently, each ublk server I/O handler thread initializes its own
> queue. However, as we move towards decoupled ublk_queues and ublk server
> threads, this model does not make sense anymore, as there will no longer
> be a concept of a thread having "its own" queue. So lift queue
> initialization out of the per-thread ublk_io_handler_fn and into a loop
> in ublk_start_daemon (which runs once for each device).
> 
> There is a part of ublk_queue_init (ring initialization) which does
> actually need to happen on the thread that will use the ring; that is
> separated into a separate ublk_thread_init which is still called by each
> I/O handler thread.
> 
> Signed-off-by: Uday Shankar <ushankar@purestorage.com>

Reviewed-by: Ming Lei <ming.lei@redhat.com>


thanks,
Ming


