Return-Path: <linux-kselftest+bounces-32726-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8615AB08FF
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 May 2025 05:52:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 276029E2AB3
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 May 2025 03:52:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A9B323D290;
	Fri,  9 May 2025 03:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HYWwd3OH"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D06323A9BD
	for <linux-kselftest@vger.kernel.org>; Fri,  9 May 2025 03:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746762738; cv=none; b=ceuA6GAZExFPpsEKPwUJyAD8l09LzOjczWTX8/CYQCH/tiQoqzizUiZBqjylRki3ZS3a8u3UFeUjihMNT56GAgU0Fg2bfLodgucj3NG1Eu1Z3z2PV0I57jjeSluEdeL0fz5YTxeM2M/2TNs4VBEFvy53S3SgWU+H/djLo8Kqr/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746762738; c=relaxed/simple;
	bh=QiDElLEnEredBXBl1qAqKruXjIhOxE3F/GTDW5A86CQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qoBbyWBTfY3D/Y5V9qPn5xa8Yrh+L1se//sR0Szw3A97QV89xpFQpyGtAhO+ZZeWJD6pNPAIeP+S/6MlCD94HHSavtfrPzSRyASoY9xVfy5AhXPByUBHkBLBBXD/mGs/rBTYZEstTiRl9bYBCf2s7vYVErXXjQhIvoWHsmo8qA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HYWwd3OH; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1746762735;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xEjeqhiXcnCiNR51BnaqIffP/HKFb9eZ0GW1Mld0utM=;
	b=HYWwd3OHyNibcciyHK0hApQD9HoqoF169qZikKUJtwUTGcVYqWisZZF5Klpbp/apzZHw9k
	VvZ13XVn+yAHy93LYuoDJ5a79pdg9FDZ5+juVVR8F1gI0Nvr1Fgzkt7weijBbEyREjY4fd
	ipsA0Vz9G2So4wV7oEyY6bbQjA/eq4Q=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-627-RPTp4l4mMFOp3ecQKv5Omg-1; Thu,
 08 May 2025 23:52:12 -0400
X-MC-Unique: RPTp4l4mMFOp3ecQKv5Omg-1
X-Mimecast-MFC-AGG-ID: RPTp4l4mMFOp3ecQKv5Omg_1746762730
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 21858180048E;
	Fri,  9 May 2025 03:52:10 +0000 (UTC)
Received: from fedora (unknown [10.72.116.120])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 449CF1956058;
	Fri,  9 May 2025 03:52:03 +0000 (UTC)
Date: Fri, 9 May 2025 11:51:58 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Uday Shankar <ushankar@purestorage.com>
Cc: Jens Axboe <axboe@kernel.dk>,
	Caleb Sander Mateos <csander@purestorage.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Shuah Khan <shuah@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v6 2/8] sbitmap: fix off-by-one when wrapping hint
Message-ID: <aB173vMuGb_Sq2vx@fedora>
References: <20250507-ublk_task_per_io-v6-0-a2a298783c01@purestorage.com>
 <20250507-ublk_task_per_io-v6-2-a2a298783c01@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250507-ublk_task_per_io-v6-2-a2a298783c01@purestorage.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On Wed, May 07, 2025 at 03:49:36PM -0600, Uday Shankar wrote:
> In update_alloc_hint_after_get, we wrap the new hint back to 0 one bit
> too early. This breaks round robin tag allocation (BLK_MQ_F_TAG_RR) -
> some tags get skipped, so we don't get round robin tags even in the
> simple case of single-threaded load on a single hctx. Fix the off-by-one
> in the wrapping condition so that round robin tag allocation works
> properly.
> 
> The same pattern occurs in __sbitmap_get_word, so fix it there too.
> 
> Signed-off-by: Uday Shankar <ushankar@purestorage.com>
> ---
>  lib/sbitmap.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/lib/sbitmap.c b/lib/sbitmap.c
> index d3412984170c03dc6600bbe53f130404b765ac5a..aa1cec78b9649f1f3e8ef2d617dd7ee724391a8c 100644
> --- a/lib/sbitmap.c
> +++ b/lib/sbitmap.c
> @@ -51,7 +51,7 @@ static inline void update_alloc_hint_after_get(struct sbitmap *sb,
>  	} else if (nr == hint || unlikely(sb->round_robin)) {
>  		/* Only update the hint if we used it. */
>  		hint = nr + 1;
> -		if (hint >= depth - 1)
> +		if (hint >= depth)
>  			hint = 0;
>  		this_cpu_write(*sb->alloc_hint, hint);

This may help for round robin.

>  	}
> @@ -182,7 +182,7 @@ static int __sbitmap_get_word(unsigned long *word, unsigned long depth,
>  			break;
>  
>  		hint = nr + 1;
> -		if (hint >= depth - 1)
> +		if (hint >= depth)
>  			hint = 0;

I guess round robin may need to return -1 if 'hint >= depth'.

Also the existing behavior starts from adding sbitmap, maybe Jens
has idea why hint is checked against 'depth -1' instead of 'depth'.



Thanks,
Ming


