Return-Path: <linux-kselftest+bounces-29803-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C167A70F59
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Mar 2025 04:24:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 32A7E3BA1B0
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Mar 2025 03:23:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99DA91662EF;
	Wed, 26 Mar 2025 03:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OstXbf5s"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D8611624C2
	for <linux-kselftest@vger.kernel.org>; Wed, 26 Mar 2025 03:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742959426; cv=none; b=URyuc28G2MaSZN8KI5i4wk9MQQIbWMNJ0LOSq4jWAZi6cI5mXdBPA7OYTaeshpjVCaj2EwyagEw7EBZBbpItgRYIzAnHiF+D0d9A/ZX595MCc1OEyzcVHTUMjohvn0VMpbmSzc6SYrLUf7bb+/nvrTN1MbdaRKZzHk5ahD6hwT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742959426; c=relaxed/simple;
	bh=P7bn55wXeMJPRDexynDBgsAbS8ColbNNzj/tf2ULPp0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L3VhXwVbNfdrjralDUOz0MkN5tqrWJpkQtuaqkugpNh+IVBOlH5zerwkW3WIrUJ8fnHwln8fRNh3mBigTw/nEifsBq5R9IRWu1MvHSylkgsQYmCHNyBqvwiv+Saa6WO1cmNjbpRSvLVoyi8f2f2UsTk6iW75tWPnjw3c3RaYX00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OstXbf5s; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742959424;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yvJPKTJxAPUCtWXz9c2dQUbgpghpe71N28GKAt2voe4=;
	b=OstXbf5sKm5jtUiRTAz7UdCsyl8jdWXIkWxnzsGzhW80FC/rDyuVqBB6RCV2j0aGtZ8N9M
	BN8JOw3x5+HAiNtgSWhcH/RJDdpfem+mhUe4iRugTeoUNL+a1Axw4pjZ7u+hdTGvLaLpk/
	BH6e9dctPotW3e4gT77IBMuLxaqvE2E=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-47-vIRBQndDMFKmhT5UKMO_cQ-1; Tue,
 25 Mar 2025 23:23:38 -0400
X-MC-Unique: vIRBQndDMFKmhT5UKMO_cQ-1
X-Mimecast-MFC-AGG-ID: vIRBQndDMFKmhT5UKMO_cQ_1742959417
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 114911956067;
	Wed, 26 Mar 2025 03:23:37 +0000 (UTC)
Received: from fedora (unknown [10.72.120.18])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D9069180B48D;
	Wed, 26 Mar 2025 03:23:31 +0000 (UTC)
Date: Wed, 26 Mar 2025 11:23:25 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Uday Shankar <ushankar@purestorage.com>
Cc: Shuah Khan <shuah@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] selftests: ublk: kublk: ignore SIGCHLD
Message-ID: <Z-NzLbW0nAIAUdIN@fedora>
References: <20250325-ublk_timeout-v1-0-262f0121a7bd@purestorage.com>
 <20250325-ublk_timeout-v1-3-262f0121a7bd@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250325-ublk_timeout-v1-3-262f0121a7bd@purestorage.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

On Tue, Mar 25, 2025 at 04:19:33PM -0600, Uday Shankar wrote:
> SIGCHLD from exiting children can arrive during io_uring_wait_cqe and
> cause it to return early with -EINTR. Since we don't have a handler for

Probably -EINTR needs to be handled, and libublksrv retry in case of -EINTR.

> SIGCHLD, avoid this issue by ignoring SIGCHLD.
> 
> Signed-off-by: Uday Shankar <ushankar@purestorage.com>
> ---
>  tools/testing/selftests/ublk/kublk.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/tools/testing/selftests/ublk/kublk.c b/tools/testing/selftests/ublk/kublk.c
> index ded1b93e7913011499ae5dae7b40f0e425982ee4..064a5bb6f12f35892065b8dfacb6f57f6fc16aee 100644
> --- a/tools/testing/selftests/ublk/kublk.c
> +++ b/tools/testing/selftests/ublk/kublk.c
> @@ -890,6 +890,7 @@ static int cmd_dev_add(struct dev_ctx *ctx)
>  		exit(-1);
>  	}
>  
> +	signal(SIGCHLD, SIG_IGN);

Reviewed-by: Ming Lei <ming.lei@redhat.com>

BTW, the SIGCHLD signal is ignored by default, looks it is good
to do it explicitly, if the -EINTR from io_uring_enter() can be avoided
in this way.


Thanks,
Ming


