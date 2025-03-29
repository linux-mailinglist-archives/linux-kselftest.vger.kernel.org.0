Return-Path: <linux-kselftest+bounces-29905-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EDC30A753B1
	for <lists+linux-kselftest@lfdr.de>; Sat, 29 Mar 2025 01:25:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 06A5D188D249
	for <lists+linux-kselftest@lfdr.de>; Sat, 29 Mar 2025 00:25:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A78A1367;
	Sat, 29 Mar 2025 00:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dnwF0i26"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B8373C0C
	for <linux-kselftest@vger.kernel.org>; Sat, 29 Mar 2025 00:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743207911; cv=none; b=M/uRXUB0fQbyEwK15DJ80xVavj7i/njFztKenas/bTEVa4CMUuTol5ZJDlsA60iUMCPsHnU+eInLYZDDZ99+BE53r2fHESj8gnM1i3WJ4Xb2R/CHtpzAjuDMs1DEzZorF5+6oZJiqiV3NPvTFEdo27Q/ZXlKll84xG9lwx9lRyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743207911; c=relaxed/simple;
	bh=Uc4puZpJ8y011zUu0r2ZFkZU7myn/0EWQxj4lZgFnHU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y4QkYo9z9VjvJfgXgyEK9UvuSkTIKwKATYILNUaM0V1NB1e6c6DlniYhJsj95caB3BpqH0ZQSP3zuht8WgNhwV8Tbmui0iY9EOY+D9quU26KuqVYARWI29mHqSFjWvLMYhhX91EU9t1BiMKUQNGoOOuUMkhCNgldt5k28au8VxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dnwF0i26; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743207907;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SNLHRJkLYG6CjblppsCn50wSvmQ1BuieKOcF0hmw4/Y=;
	b=dnwF0i26vcNqEPObnG9veuFzuVFzdcheG6CvhEDQQt4apb3V6p8A5/DSDdrbE5iZDdErab
	9rnyDsBYSHkQnenzwOmFSsNNa4tea7M0Ku1PS78ID9gUh1lLbDNGLJm0Bk7vpmhSkL70G+
	/o+wrXqhC4V5MgzkKKK9NIpzzZHYCK8=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-246-WlL2B_30PBqZrm6k7tvGmw-1; Fri,
 28 Mar 2025 20:25:05 -0400
X-MC-Unique: WlL2B_30PBqZrm6k7tvGmw-1
X-Mimecast-MFC-AGG-ID: WlL2B_30PBqZrm6k7tvGmw_1743207904
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 75246180882E;
	Sat, 29 Mar 2025 00:25:03 +0000 (UTC)
Received: from fedora (unknown [10.72.120.3])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2C7C3180AF7C;
	Sat, 29 Mar 2025 00:24:57 +0000 (UTC)
Date: Sat, 29 Mar 2025 08:24:52 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Jens Axboe <axboe@kernel.dk>, Shuah Khan <shuah@kernel.org>,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 0/2] ublk: specify io_cmd_buf pointer type
Message-ID: <Z-c91HQmMb2ozGdh@fedora>
References: <20250328194230.2726862-1-csander@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250328194230.2726862-1-csander@purestorage.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

On Fri, Mar 28, 2025 at 01:42:28PM -0600, Caleb Sander Mateos wrote:
> io_cmd_buf points to an array of ublksrv_io_desc structs but its type is
> char *. Indexing the array requires an explicit multiplication and cast.
> The compiler also can't check the pointer types.
> 
> Change io_cmd_buf's type to struct ublksrv_io_desc * so it can be
> indexed directly and the compiler can type-check the code.
> 
> Make the same change to the ublk selftests.
> 
> Caleb Sander Mateos (2):
>   ublk: specify io_cmd_buf pointer type
>   selftests: ublk: specify io_cmd_buf pointer type
> 
>  drivers/block/ublk_drv.c             | 8 ++++----
>  tools/testing/selftests/ublk/kublk.c | 2 +-
>  tools/testing/selftests/ublk/kublk.h | 4 ++--
>  3 files changed, 7 insertions(+), 7 deletions(-)

Reviewed-by: Ming Lei <ming.lei@redhat.com>

Thanks,
Ming


