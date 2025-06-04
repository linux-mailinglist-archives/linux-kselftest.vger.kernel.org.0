Return-Path: <linux-kselftest+bounces-34272-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E5911ACD4E9
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Jun 2025 03:35:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 44EF917C5CE
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Jun 2025 01:34:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 667BA1EEE6;
	Wed,  4 Jun 2025 01:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Lhxt1zNF"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EEC41C32
	for <linux-kselftest@vger.kernel.org>; Wed,  4 Jun 2025 01:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749000751; cv=none; b=pMnIg2k8i/aC3olnsbkF09yShOU5+upnH/0Tdf9d2ESZAMB3ZRoiJpgUlag+fkDy0/JkjBugjy6zFeY7FUfCMrcbazyp3cj8VwwenQ/ksR3R/LBEOFLbEIEC2wGB0gbT6PGY9xb/Wn8MXcodgcbAbrNcp0/le82y4urEQ2JmHk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749000751; c=relaxed/simple;
	bh=g8EG4OO/uAvkCE4/p6iHNot9cBDrmSO26DGJjcm3zrw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WShAd2skN8pzIZtYMnKTm36lxd06ax34RPHx9uHQy8UgPcQZu/1hwSmHKKamDFgSM6BOX2nMACNNOvT6Rwih0tw4YM1l91jXUEyyzHnsAryCd7irWtbQvYxCUxpx2Zv2l+YkLKTxPHMbMMDNdnsNugUkD36NdxRvsCTfVTrhAuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Lhxt1zNF; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749000748;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AKBoAi6FqTWhxAfztHNNXYUuQ67bFZoGcygltsWFPhE=;
	b=Lhxt1zNFFuIUZiTJBjDfVDL+k/o3OAQb9b2N06hTklrfxc0Qbf3lQF0cy1gUCOEZCz+0bp
	AXaB8xQYTX7AUhko7cE4IuktDp8EhlxCkOK/d6SVo1+WfaNu9XSdk4vrzaLqs4igQCiS4d
	OksN92EB96+gf8jJMPyImUOb1/Xbvro=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-578-mAqskQLwMNWuQ9VPlcGSvA-1; Tue,
 03 Jun 2025 21:32:25 -0400
X-MC-Unique: mAqskQLwMNWuQ9VPlcGSvA-1
X-Mimecast-MFC-AGG-ID: mAqskQLwMNWuQ9VPlcGSvA_1749000744
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0DBC71955DAB;
	Wed,  4 Jun 2025 01:32:24 +0000 (UTC)
Received: from fedora (unknown [10.72.116.100])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id AF01019560A3;
	Wed,  4 Jun 2025 01:32:20 +0000 (UTC)
Date: Wed, 4 Jun 2025 09:32:15 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Uday Shankar <ushankar@purestorage.com>
Cc: Shuah Khan <shuah@kernel.org>, linux-block@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftests: ublk: kublk: improve behavior on init failure
Message-ID: <aD-iH2D4gk6vD9Cw@fedora>
References: <20250603-ublk_init_fail-v1-1-87c91486230e@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250603-ublk_init_fail-v1-1-87c91486230e@purestorage.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

On Tue, Jun 03, 2025 at 05:38:33PM -0600, Uday Shankar wrote:
> Some failure modes are handled poorly by kublk. For example, if ublk_drv
> is built as a module but not currently loaded into the kernel, ./kublk
> add ... just hangs forever. This happens because in this case (and a few
> others), the worker process does not notify its parent (via a write to
> the shared eventfd) that it has tried and failed to initialize, so the
> parent hangs forever. Fix this by ensuring that we always notify the
> parent process of any initialization failure, and have the parent print
> a (not very descriptive) log line when this happens.
> 
> Signed-off-by: Uday Shankar <ushankar@purestorage.com>

Reviewed-by: Ming Lei <ming.lei@redhat.com>

Thanks,
Ming


