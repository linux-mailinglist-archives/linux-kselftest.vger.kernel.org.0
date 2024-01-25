Return-Path: <linux-kselftest+bounces-3554-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A683383BC59
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Jan 2024 09:52:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5DF281F2A732
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Jan 2024 08:52:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4059C1B818;
	Thu, 25 Jan 2024 08:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IYUj1HU7"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3E0C1BC22
	for <linux-kselftest@vger.kernel.org>; Thu, 25 Jan 2024 08:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706172747; cv=none; b=qj6tYqyEZWX2L+fscpoR4jpgYwVsFj4Bq+Wp9dkhUVJicB+JbT4zRfcelUHdVOF+ZEXjIUUIU4KYM8lLzgckx85+IHO8eH4r3TDML1ZoYegH5z2oMGbOZs9/Op5IB5c+ad1LoopGFGgN7qs3mdxB+9ohCqmsY2UXV1O/tBAtDh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706172747; c=relaxed/simple;
	bh=k2p6vgQQ/RAXPDiRE/JTyB/ah5UQEk6s51M/bFsBvoE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e1uwTbEDwARIWpr8LFf6kVaj+HMkiW0n/WBmkq1YiWv8tXEjspOVwPmUFZjQZIzP6YPwZWRsis3IpXnPv/AoFW2lHsuuC5esAGnuWRDFyQPznFJMu4FwexmuC7N9Jx1Q6bc0Xd8hgIf0AbpaildvIFi/3APGsVPoQFq72x5/dUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IYUj1HU7; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706172744;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RIvhVbbUBp0xDkqN9EFINDsqzRK2vtIqnaFyFbvxcz4=;
	b=IYUj1HU7KcXOR33QzpiPZs1uMrlV6slu1QxKbgZOFf5ZpKtJfGdNx/N+cVC9LfsOvMzvvC
	2/CkImv/ptppAi9kr2+XCbyYojAA0gltuw12Qly8y/WO/CBQ8Bo7iBzn6PaVZbP22GXhFl
	Uu35OfHjHC5/46wg9v9Yl+8iWHmTN9s=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-282-wyJvKCclPfaYZvuE4Kc6Ww-1; Thu, 25 Jan 2024 03:52:22 -0500
X-MC-Unique: wyJvKCclPfaYZvuE4Kc6Ww-1
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-683699fede9so85715956d6.0
        for <linux-kselftest@vger.kernel.org>; Thu, 25 Jan 2024 00:52:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706172741; x=1706777541;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RIvhVbbUBp0xDkqN9EFINDsqzRK2vtIqnaFyFbvxcz4=;
        b=WGzkjMQIQSGA8GLeNlPlzGZj1qEM1XzhNk5EcAIgIGac3Krbd5Cu3aN2qJRp05hc4e
         4C8uZ4/NOeJlNW9DsfmLjBCs+qD7k0ikRmRJdOA6uBbYBtldnXYfc4i/gfpNlyBink3v
         p9qhEbF4qhASlcsKQCgzUp2i4UByt3VB5K+C1XSi3XvgeWrNYCTj/8RbzZT8UVgkdk8n
         mFz41Wiv6pbj/FV1tW9BjbFVQsE4OMzjdqzqIaVP2sH7Zh6zoLa+Nz1u42Lk86AQX1Bl
         NV2zPG+sEZ7vrdewZEh+ljo9drotAnryLbtAlEQ4XBhIJkTj1QMpHFi1Y4FLwEpLRAcM
         cu2g==
X-Gm-Message-State: AOJu0YwVNBiFTiIms3hEwfOAhQAOV/X1belPfJ7PSDe6hG0028p+MpAn
	pIAU6RQ2XKMPcnItyvI5jt+oe0H1cMnID9ppYTfXmTwY88DHJD1FbwOoZAjAkWHMc4prTZQBx8C
	K83ldsMh23RSvhQk+HDOunsngWBCYV51o67PVPUdx1GyxB7kWOceVy8Wto4ZXYhXBEQ==
X-Received: by 2002:a05:6214:2b09:b0:685:3444:4ee with SMTP id jx9-20020a0562142b0900b00685344404eemr686911qvb.89.1706172741540;
        Thu, 25 Jan 2024 00:52:21 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHg3Tn6pQa0lndCQs5ycOlaqdnrfYc2D/GxlqryQE6ZGT5VDCr7Pq3ggUwd1eeQFdOE1BBzgg==
X-Received: by 2002:a05:6214:2b09:b0:685:3444:4ee with SMTP id jx9-20020a0562142b0900b00685344404eemr686900qvb.89.1706172741246;
        Thu, 25 Jan 2024 00:52:21 -0800 (PST)
Received: from localhost ([81.56.90.2])
        by smtp.gmail.com with ESMTPSA id i3-20020ad44ba3000000b0068198012890sm5243372qvw.66.2024.01.25.00.52.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jan 2024 00:52:20 -0800 (PST)
Date: Thu, 25 Jan 2024 09:52:18 +0100
From: Davide Caratti <dcaratti@redhat.com>
To: Pedro Tammela <pctammela@mojatatu.com>
Cc: netdev@vger.kernel.org, jhs@mojatatu.com, xiyou.wangcong@gmail.com,
	jiri@resnulli.us, shuah@kernel.org, kuba@kernel.org,
	vladimir.oltean@nxp.com, edumazet@google.com, pabeni@redhat.com,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next v2 0/5] selftests: tc-testing: misc changes for
 tdc
Message-ID: <ZbIhQiUmk5FbyCc9@dcaratti.users.ipa.redhat.com>
References: <20240124181933.75724-1-pctammela@mojatatu.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240124181933.75724-1-pctammela@mojatatu.com>

On Wed, Jan 24, 2024 at 03:19:28PM -0300, Pedro Tammela wrote:
> Patches 1 and 3 are fixes for tdc that were discovered when running it
> using defconfig + tc-testing config and against the latest iproute2.
> 
> Patch 2 improves the taprio tests.
> 
> Patch 4 enables all tdc tests.
> 
> Patch 5 fixes the return code of tdc for when a test fails
> setup/teardown.
> 
> v1->v2: Suggestions by Davide
>

for the series,

Reviewed-by: Davide Caratti <dcaratti@redhat.com> 

thanks!
-- 
davide


