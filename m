Return-Path: <linux-kselftest+bounces-27951-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 636EEA4A74B
	for <lists+linux-kselftest@lfdr.de>; Sat,  1 Mar 2025 02:11:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 45356189C35D
	for <lists+linux-kselftest@lfdr.de>; Sat,  1 Mar 2025 01:12:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62F578BF8;
	Sat,  1 Mar 2025 01:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RzSI/tYB"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 860F923F378
	for <linux-kselftest@vger.kernel.org>; Sat,  1 Mar 2025 01:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740791511; cv=none; b=srq7im9dPhsNbW9Dan4Tn8IgMWOlNO15vjGs+P/JmiHvYSc9vUK1dbucthMvmel14I742fmQLwBDuJeO3EIOGKN0v8n5PyA2QJeD2Fn6I+qghmsqFDVKhdiiwKWQ2qgPX0CRfTpugDkIBagKai8JW0/90aD7KMoKuCkpFuyp1hc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740791511; c=relaxed/simple;
	bh=FoQbHK1AHUhmV23+HHInjGmtXUQqxcsPl/gizIBaA/o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MInUi90pc/I+Kd+xNF5XKPbZx6/EURmmX1oEpsHZ3+AKkf/jdTb+crU5JdK7ibK4cuDH/rk96ZxBvoJx4VlPcR9rLP+fN7XLcv5iYv0GcnN4THGLUgqaHInF9VpKJPa4zaLpnf3Gkxv/6VG6/GzLXNSCEIps0zRCK+Ru9poJ08E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RzSI/tYB; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740791508;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WYFUypGR1m+RxBQPIWa0pHntE0rb9GlxUKgPZ6Ol/5o=;
	b=RzSI/tYBRcUykjiv7yoyhFYgvZYkzuU1leWtBXVwdhVFyuHXaTW83X+/h+IBcoIrCPS2Vl
	edVtQHsNG1/xDJGFD5vNEqMWgj+dp3p97sPHRUVIC+641q11eXfRX7N5kudZ1QFG4/wc05
	W5+I/DkziDndRDbDq/GJ7lnA//qmREM=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-678-_zUIjpSwNvuGUWllmymjfg-1; Fri,
 28 Feb 2025 20:11:47 -0500
X-MC-Unique: _zUIjpSwNvuGUWllmymjfg-1
X-Mimecast-MFC-AGG-ID: _zUIjpSwNvuGUWllmymjfg_1740791506
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4F11D1944F05;
	Sat,  1 Mar 2025 01:11:45 +0000 (UTC)
Received: from fedora (unknown [10.72.120.4])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9B03819560AE;
	Sat,  1 Mar 2025 01:11:39 +0000 (UTC)
Date: Sat, 1 Mar 2025 09:11:34 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, linux-kselftest@vger.kernel.org,
	Keith Busch <kbusch@kernel.org>, io-uring@vger.kernel.org
Subject: Re: [PATCH V3 0/3] selftests: add ublk selftests
Message-ID: <Z8JexssISF2zsNRv@fedora>
References: <20250228161919.2869102-1-ming.lei@redhat.com>
 <360708f8-437f-4262-a734-b1bd680de339@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <360708f8-437f-4262-a734-b1bd680de339@kernel.dk>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

On Fri, Feb 28, 2025 at 09:37:47AM -0700, Jens Axboe wrote:
> On 2/28/25 9:19 AM, Ming Lei wrote:
> > Hello Jens,
> > 
> > This patchset adds ublk kernel selftests, which is very handy for
> > developer for verifying kernel change, especially ublk heavily depends
> > on io_uring subsystem. Also it provides template for target implementation.
> > 
> > Please consider it for v6.15.
> 
> Can we add the zc bits to the liburing test case as well?

OK, will unify the two tests and cover liburing too.

BTW, would you like to consider to move liburing tests or part of them
into kernel selftests? 

This way looks more friendly for kernel developer:

- single repo, and single patchset can include both io_uring kernel
  patches and selftests change

- easy to run test against same kernel repo

Also liburing development may be decoupled from io_uring kernel
a bit.



Thanks,
Ming


