Return-Path: <linux-kselftest+bounces-48511-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BF849D02D26
	for <lists+linux-kselftest@lfdr.de>; Thu, 08 Jan 2026 14:02:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 86E5230082D7
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 Jan 2026 13:02:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA3E94D2EDC;
	Thu,  8 Jan 2026 12:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A/SABkSt"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 533A44D247B
	for <linux-kselftest@vger.kernel.org>; Thu,  8 Jan 2026 12:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767876356; cv=none; b=WIktbRLt/dADntYkk/D33EAUe0TkBZWPcXAn7wFoe9tujS78TWz1SB+c6v+CSiplQMHKZ77WR4P96Z/LaWrkQF3LbO8N/u+jwVQPPsC+Jnq+SkOQZWk89wBb0vKE9RK/BFi4L40eovIFwazbxRFKnrg7PGveBMeZ6zQxxBfJixw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767876356; c=relaxed/simple;
	bh=dSgLsxBmLIeFQhbse6YhnfSBSP0ebgi7CgRsK8QiXdo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yk3rLaoU9UkQZbzlrH36dJlTRaGJwzjLMBAN/0iMDKzAgmr+QI10ZQ4cAx04B2eMNsiQuenO5CLZ3H/NSkNNL+ewpHndggWy63MxdW3t+3PDwGlRhb96zlllkCb/jDbk/drOWo7YkIzt3EsWkabIeXbHQWH9sLsLQse/mpKK264=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=A/SABkSt; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767876351;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DTPY6BuVneA+NGNeENGi8+r4P+7cDsHT61mnRmoz9Gg=;
	b=A/SABkStmmBCbbmOk4tTxL4QzRuLzj4CdSo1JhYXDNvFjuTTwmOaKyD8Tzu9iUEdmFG5Rx
	FIfD3TL9wZT7eb0o3H/J6uhV9N5N2YwdnfJCn4SgoJmm+6Pe5ZyTQx4lQEKq1yA/vh6rvD
	FiqFoGsU6YMltfYj+O2H4yY82qE9XAo=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-137-IzlU5juSP-Wl4rXuZ8dllg-1; Thu,
 08 Jan 2026 07:45:47 -0500
X-MC-Unique: IzlU5juSP-Wl4rXuZ8dllg-1
X-Mimecast-MFC-AGG-ID: IzlU5juSP-Wl4rXuZ8dllg_1767876346
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5C8361955E7F;
	Thu,  8 Jan 2026 12:45:46 +0000 (UTC)
Received: from fedora (unknown [10.72.116.180])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id AF5F230002D1;
	Thu,  8 Jan 2026 12:45:39 +0000 (UTC)
Date: Thu, 8 Jan 2026 20:45:33 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Jens Axboe <axboe@kernel.dk>, Shuah Khan <shuah@kernel.org>,
	linux-block@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Stanley Zhang <stazhang@purestorage.com>,
	Uday Shankar <ushankar@purestorage.com>,
	"Martin K . Petersen" <martin.petersen@oracle.com>
Subject: Re: [PATCH v4 18/19] selftests: ublk: add integrity params test
Message-ID: <aV-m7cJoMXJVZ5uT@fedora>
References: <20260108091948.1099139-1-csander@purestorage.com>
 <20260108091948.1099139-19-csander@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260108091948.1099139-19-csander@purestorage.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On Thu, Jan 08, 2026 at 02:19:46AM -0700, Caleb Sander Mateos wrote:
> Add test case null_04 to exercise all the different integrity params. It
> creates 4 different ublk devices with different combinations of
> integrity arguments and verifies their integrity limits via sysfs and
> the metadata_size utility.
> 
> Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>

Reviewed-by: Ming Lei <ming.lei@redhat.com>

Thanks,
Ming


