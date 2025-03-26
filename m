Return-Path: <linux-kselftest+bounces-29802-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A86A9A70F4D
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Mar 2025 04:09:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 047DD3B11AD
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Mar 2025 03:08:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 800DC1531E8;
	Wed, 26 Mar 2025 03:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VjG+MJOk"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCFD7664C6
	for <linux-kselftest@vger.kernel.org>; Wed, 26 Mar 2025 03:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742958536; cv=none; b=uC9DlnZJLRyyywLtbja0igL6dWzrYdmrivBc2TifSZAUWJHTMDPXEXXn4ArRvrF1eRBABPZgy0fEqA7uALL4DmVEzOXo1HV6LqEwz6ZR1zy9H2XL/eoMI8HmadAERU6lAF6+631W2yjVJj7v17S00O9G7GOilQZC2raubk5qTw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742958536; c=relaxed/simple;
	bh=JxMAH3fEf/dJeU9yku6nmMkKjIOiN2tGQV4Byl5vRnM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ij+rxX1wnHyceIoom7golHp3Q4pKtMC1WLjMLdJ33Wsc5QldzbOmp2siFHYaIJ3mLFbExC5lmTAZkhYy959JJaN+6fR+KUT0Z2v6/7VSGX+qofXKKNHrZN99R1iTPtXJ3uJUazxyHjQ+XwCp0Fy1rthexETUyTIlomjNhenKh0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VjG+MJOk; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742958534;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=t+YQ41MzT7Qo/WV4Xr3JF55HUBxUNDHByiLu3RRvc7c=;
	b=VjG+MJOk7lcFzGArsdxWOtqY85Pl/OWcHg7uw6z44aF15ZWQzltIIiag1tzTXOEtOeIJV0
	3NkoiZP0E208MJjpysn0au7vEbykLR7H+65jeS8IW6T+gRxKwMnuf9izKn9Dd6U1HlaFI1
	s+Z6Ak/bDooBne6UDxGhuQlJQ8t6X4o=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-76-L9KAD2hxMpewu3PHSXp-_A-1; Tue,
 25 Mar 2025 23:08:52 -0400
X-MC-Unique: L9KAD2hxMpewu3PHSXp-_A-1
X-Mimecast-MFC-AGG-ID: L9KAD2hxMpewu3PHSXp-_A_1742958531
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C54D619373D7;
	Wed, 26 Mar 2025 03:08:50 +0000 (UTC)
Received: from fedora (unknown [10.72.120.18])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 887F419560AB;
	Wed, 26 Mar 2025 03:08:45 +0000 (UTC)
Date: Wed, 26 Mar 2025 11:08:38 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Uday Shankar <ushankar@purestorage.com>
Cc: Shuah Khan <shuah@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] selftests: ublk: kublk: fix an error log line
Message-ID: <Z-NvtjsGBb_O5QvI@fedora>
References: <20250325-ublk_timeout-v1-0-262f0121a7bd@purestorage.com>
 <20250325-ublk_timeout-v1-2-262f0121a7bd@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250325-ublk_timeout-v1-2-262f0121a7bd@purestorage.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

On Tue, Mar 25, 2025 at 04:19:32PM -0600, Uday Shankar wrote:
> When doing io_uring operations using liburing, errno is not used to
> indicate errors, so the %m format specifier does not provide any
> relevant information for failed io_uring commands. Fix a log line
> emitted on get_params failure to translate the error code returned in
> the cqe->res field instead.
> 
> Signed-off-by: Uday Shankar <ushankar@purestorage.com>
> ---
>  tools/testing/selftests/ublk/kublk.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/ublk/kublk.c b/tools/testing/selftests/ublk/kublk.c
> index b17eee643b2dbfd59903b61718afcbc21da91d97..ded1b93e7913011499ae5dae7b40f0e425982ee4 100644
> --- a/tools/testing/selftests/ublk/kublk.c
> +++ b/tools/testing/selftests/ublk/kublk.c
> @@ -215,7 +215,7 @@ static void ublk_ctrl_dump(struct ublk_dev *dev)
>  
>  	ret = ublk_ctrl_get_params(dev, &p);
>  	if (ret < 0) {
> -		ublk_err("failed to get params %m\n");
> +		ublk_err("failed to get params %d %s\n", ret, strerror(-ret));
>  		return;

Reviewed-by: Ming Lei <ming.lei@redhat.com>

-- 
Ming


