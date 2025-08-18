Return-Path: <linux-kselftest+bounces-39181-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A62E4B296C9
	for <lists+linux-kselftest@lfdr.de>; Mon, 18 Aug 2025 04:14:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 81D4D7A3E6A
	for <lists+linux-kselftest@lfdr.de>; Mon, 18 Aug 2025 02:12:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62288245014;
	Mon, 18 Aug 2025 02:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ghH55mxu"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEF08173
	for <linux-kselftest@vger.kernel.org>; Mon, 18 Aug 2025 02:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755483247; cv=none; b=bKt5dA+iXRV8MnPaGcxCaGG5A/pQClXQeazInBNNhlhBfR6XWrUTuqxz8pd1tMTmnUMAIe57EKgSMI5c9T+gPSGK3SGiZpOnbIfQHC7T3p+dRIcO/MeCTyfPK/yOGtJx+786tas8aa2uabY7J1FCE+v2jsMbDVMj1GrYq5w5BUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755483247; c=relaxed/simple;
	bh=IJc2jypFRnh16B3SmyiGG7GcC4dV7V2WPKeNjWuZ/7M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DVnuC5IOmiqgsv8kyU1zTaeWdUb7UhVy2ZFBBrLZPnsFrWeAHEC5lJ7s6UP5QuqxFC5cvSxzlBadXCOArKjpF7MJTNuygx1l6/jg0d1ZfgJ68qeGle+4ngFghqQ6u/vJD9KvoeonqD3w2qt2ILYHjnF7m8f1QaCX49QuhLAB2xA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ghH55mxu; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755483245;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=b8XuxuYGVNjlRqBB5h51vG9u+ccEzqMpuG57Y8sa914=;
	b=ghH55mxuPjEAMYfmIZZMyL6Up0rghYKYUqziRklgOI6arhUjhl5cFGFFmprmePv1Ag5ABX
	bgJ/PTZoG/3+gHPOQa4Jn92gkbGT9qL/rB6ZbtCPrmL1oG3vksh6FWl8ysDEX0xLkSUe8/
	xTLAnYNZviCnLw8BKfyME4MejSOoadQ=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-687-zUxGj90XMYyc361uKnXIBg-1; Sun,
 17 Aug 2025 22:14:00 -0400
X-MC-Unique: zUxGj90XMYyc361uKnXIBg-1
X-Mimecast-MFC-AGG-ID: zUxGj90XMYyc361uKnXIBg_1755483239
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2E43E180034F;
	Mon, 18 Aug 2025 02:13:59 +0000 (UTC)
Received: from fedora (unknown [10.72.116.112])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0DED219560AD;
	Mon, 18 Aug 2025 02:13:53 +0000 (UTC)
Date: Mon, 18 Aug 2025 10:13:48 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Akhilesh Patil <akhilesh@ee.iitb.ac.in>
Cc: shuah@kernel.org, axboe@kernel.dk, linux-block@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
	akhileshpatilvnit@gmail.com
Subject: Re: [PATCH] selftests: ublk: Use ARRAY_SIZE() macro to improve code
Message-ID: <aKKMXOeHEK_LHV8M@fedora>
References: <aKGihYui6/Pcijbk@bhairav-test.ee.iitb.ac.in>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aKGihYui6/Pcijbk@bhairav-test.ee.iitb.ac.in>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On Sun, Aug 17, 2025 at 03:06:05PM +0530, Akhilesh Patil wrote:
> Use ARRAY_SIZE() macro while calculating size of an array to improve
> code readability and reduce potential sizing errors.
> Implement this suggestion given by spatch tool by running
> coccinelle script - scripts/coccinelle/misc/array_size.cocci
> Follow ARRAY_SIZE() macro usage pattern in ublk.c introduced by,
> commit ec120093180b9 ("selftests: ublk: fix ublk_find_tgt()")
> wherever appropriate to maintain consistency.
> 
> Signed-off-by: Akhilesh Patil <akhilesh@ee.iitb.ac.in>
> ---
> Testing:
> * build checked for testing/selftests/ublk
> * tested by running 
> 	$ ./kublk --help
> Which exercises the impacted code path.

Nice!

Reviewed-by: Ming Lei <ming.lei@redhat.com>


Thanks,
Ming


