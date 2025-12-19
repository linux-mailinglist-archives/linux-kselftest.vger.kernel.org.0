Return-Path: <linux-kselftest+bounces-47734-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 685DFCD0386
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Dec 2025 15:16:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id DB7623034167
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Dec 2025 14:16:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5088025B662;
	Fri, 19 Dec 2025 14:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y/ES9zN0"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F35C26158C
	for <linux-kselftest@vger.kernel.org>; Fri, 19 Dec 2025 14:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766153807; cv=none; b=XKMUiyc2BlXhk+xmxSAbJhhmr36QMMPHl0pmv47trK3OD8S1MnwMHUww42UiCHcQiWdhhET4PODEOKLaktKF8J2g29AS4/EUxao6O1g0DKXteAthJVqQxpharsEEbRUZ51BjrhtoPPkC4GIOSryAK+9wK1BeOcasKQltB4X9k9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766153807; c=relaxed/simple;
	bh=qFdBthuvOaf5gMDGOSU82adg6xi1wuqIG4gH/BzEp80=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EKL7Vn/zcx60EHKt9kP/jDdkkdZAAzl/gJY5mjdebuWwTFzIt38xnxrLe9CjDWqCbOfQS3mn3AlgWqyn1rzKyBQpinNE7L1Dy/OTJXid8aSF8uAZ5Iy0e08E0beIj2bATFzuBTFyJ6aM4GbYfdt8CQi8p7uZumAlEYuwtychkz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Y/ES9zN0; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1766153804;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iWXPrzLiJtl4wMOdUVzXHjiRsKB7d+Unwe6U8L+x5pE=;
	b=Y/ES9zN0RNQvnd1xNlei9+qx9uU2dABKp2P8nMt8r4WkR2nGYWAH3hvzS4cuPKX/30fOlQ
	lxWPwk9YKMYuPTrY/L2HaZJsUcGJdpLmYXi6eyvp+z/hkGtNyIfph3N0qwU7+hdUMakW7c
	i5Khyvn8jkIHUuKMpY6JtazQu0thmjA=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-36-9u1jT9wROnWuWrlt2bYX1A-1; Fri,
 19 Dec 2025 09:16:39 -0500
X-MC-Unique: 9u1jT9wROnWuWrlt2bYX1A-1
X-Mimecast-MFC-AGG-ID: 9u1jT9wROnWuWrlt2bYX1A_1766153797
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4D986195608E;
	Fri, 19 Dec 2025 14:16:37 +0000 (UTC)
Received: from fedora (unknown [10.72.116.41])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3082A180045B;
	Fri, 19 Dec 2025 14:16:25 +0000 (UTC)
Date: Fri, 19 Dec 2025 22:16:14 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Jens Axboe <axboe@kernel.dk>, Shuah Khan <shuah@kernel.org>,
	linux-block@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Stanley Zhang <stazhang@purestorage.com>,
	Uday Shankar <ushankar@purestorage.com>
Subject: Re: [PATCH 03/20] blk-integrity: take const pointer in
 blk_integrity_rq()
Message-ID: <aUVeLmewQ0R-Z6ge@fedora>
References: <20251217053455.281509-1-csander@purestorage.com>
 <20251217053455.281509-4-csander@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251217053455.281509-4-csander@purestorage.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On Tue, Dec 16, 2025 at 10:34:37PM -0700, Caleb Sander Mateos wrote:
> blk_integrity_rq() doesn't modify the struct request passed in, so allow
> a const pointer to be passed. Use a matching signature for the
> !CONFIG_BLK_DEV_INTEGRITY version.
> 
> Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>

Reviewed-by: Ming Lei <ming.lei@redhat.com>

Thanks,
Ming


