Return-Path: <linux-kselftest+bounces-33984-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7639DAC7B60
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 May 2025 11:47:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C0FE63B6A7B
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 May 2025 09:47:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6311128C2BF;
	Thu, 29 May 2025 09:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bSz11vVk"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9438328C5CE
	for <linux-kselftest@vger.kernel.org>; Thu, 29 May 2025 09:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748512062; cv=none; b=HKhS8eOmzwG5rSe9ChJh7x57R4Cg7epT3FpwKBGhY8i6EVbGuwf827bIrFajMao8+zCk3LqJYPag4VJZJ4SKMSw+FGjE/ozI1SqqsouDLC0zC9IcB7t75Is9WpjsveeZQgUXblHA6zexEwdQ88XoTWkdLhR97/4HdASyDWjeSP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748512062; c=relaxed/simple;
	bh=esbMwKIq+NGJ61GoWeW5P3mmGT1974Lfq/CFXsNUSlA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NIoyJiF6aMH/ao5WN4j0DN2LDrg2Xgo74ddDDM14fDjGVYc6Slq/44dwTIQUdNa0R4KeOJdRy7AxJv4gDkkj1rRr2WSHaBfFLFAOMKlN7KqSeRSTUVeYFKRGHKQ3pkJ3V/mUjsBL1fhpWuJmFKDDv6s6IS+EOCUW0GNlcQvN/mw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bSz11vVk; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1748512059;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WzsQ4MsaOEcFvK/PBh6fi+RCWqlOYDTaoJUuToZdXhI=;
	b=bSz11vVkl6JpPeEmKqsXnrIIOZtARlB4AN4U89GgbWsMFGEm2bVZ0TG5vwPyMrnKzZMZ8h
	Qvk8XCggLOQyt/4Y0n33rm7SIieoRIU4rb7pVipZSblLx3xZR+7IFs4ogMFD/7Do3s++KN
	HjOA/STkwkpUOnH2cV6E3F3rLEa9Vao=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-554-rN0D50jFP1GUDupxD1_5iQ-1; Thu,
 29 May 2025 05:47:36 -0400
X-MC-Unique: rN0D50jFP1GUDupxD1_5iQ-1
X-Mimecast-MFC-AGG-ID: rN0D50jFP1GUDupxD1_5iQ_1748512054
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 612E41800447;
	Thu, 29 May 2025 09:47:34 +0000 (UTC)
Received: from fedora (unknown [10.72.116.35])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 07095180049D;
	Thu, 29 May 2025 09:47:27 +0000 (UTC)
Date: Thu, 29 May 2025 17:47:22 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Uday Shankar <ushankar@purestorage.com>
Cc: Jens Axboe <axboe@kernel.dk>,
	Caleb Sander Mateos <csander@purestorage.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Shuah Khan <shuah@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v7 6/8] selftests: ublk: kublk: decouple ublk_queues from
 ublk server threads
Message-ID: <aDgtKtFTi--IWpqB@fedora>
References: <20250527-ublk_task_per_io-v7-0-cbdbaf283baa@purestorage.com>
 <20250527-ublk_task_per_io-v7-6-cbdbaf283baa@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250527-ublk_task_per_io-v7-6-cbdbaf283baa@purestorage.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

On Tue, May 27, 2025 at 05:01:29PM -0600, Uday Shankar wrote:
> Add support in kublk for decoupled ublk_queues and ublk server threads.
> kublk now has two modes of operation:
> 
> - (preexisting mode) threads and queues are paired 1:1, and each thread
>   services all the I/Os of one queue
> - (new mode) thread and queue counts are independently configurable.
>   threads service I/Os in a way that balances load across threads even
>   if load is not balanced over queues.
> 
> The default is the preexisting mode. The new mode is activated by
> passing the --per_io_tasks flag.
> 
> Signed-off-by: Uday Shankar <ushankar@purestorage.com>
> ---

...

> diff --git a/tools/testing/selftests/ublk/kublk.h b/tools/testing/selftests/ublk/kublk.h
> index 3a2ae095bee18633acd5a9c923cfab2d14fe3bff..4cc8103bc49a7a93bbf61986cde8f4e6e1be716d 100644
> --- a/tools/testing/selftests/ublk/kublk.h
> +++ b/tools/testing/selftests/ublk/kublk.h
> @@ -80,6 +80,7 @@ struct dev_ctx {
>  	char tgt_type[16];
>  	unsigned long flags;
>  	unsigned nr_hw_queues;
> +	unsigned nthreads;
>  	unsigned queue_depth;
>  	int dev_id;
>  	int nr_files;
> @@ -89,6 +90,7 @@ struct dev_ctx {
>  	unsigned int	fg:1;
>  	unsigned int	recovery:1;
>  	unsigned int	auto_zc_fallback:1;
> +	unsigned int	per_io_tasks:1;
>  
>  	int _evtfd;
>  	int _shmid;
> @@ -128,6 +130,7 @@ struct ublk_io {
>  	unsigned short refs;		/* used by target code only */
>  
>  	int tag;
> +	int buf_index;

Both the above two can be 'unsigned short', otherwise:

Reviewed-by: Ming Lei <ming.lei@redhat.com>


