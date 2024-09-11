Return-Path: <linux-kselftest+bounces-17744-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4504197545D
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Sep 2024 15:47:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F18E128848F
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Sep 2024 13:47:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69B4218593F;
	Wed, 11 Sep 2024 13:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="KNX/FErm"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A9513FB30;
	Wed, 11 Sep 2024 13:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726062177; cv=none; b=WTL9XpLxzV5tsGP6fiuYtBsEkK14okoDXFgIGlg3Nq/tcjXPv7NYJ+2ABwLiU3rVnoFxM4piF7/okKVw7J3rOzSY8nNf+7hnQV1AbR/GU7yrt5pwB4aopSnDN+jMKKAGYbmxJLfdvk5rNkPQECq7aHL+yOfcn59U3WA+eOTQDTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726062177; c=relaxed/simple;
	bh=vosQFMqVeWlqyx+8zloPqf1L0mA6shKLN+AlFRSRpJk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RrnfRXFMtx607NHnZ28H58D/ERFwLKArIgq94jy3v8WBYivjBZ7kSkWlGGXsr+W4GkG4anwXAjvXSA7QR9iktyaV/2gbApYzQLGj8N/+SEPjXXMuvrXZNHOy24Fpy96kUdup8VB1GCpMhGBoRfuht9YzfoTYhe7TNR25u1/gViU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=KNX/FErm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F008EC4CEC7;
	Wed, 11 Sep 2024 13:42:55 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="KNX/FErm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1726062174;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4lV2m3KMFp9ovsECSqWqpXb9O4EEIMzInVmmTyh86ds=;
	b=KNX/FErm/3XaI5Mi205mARY7DWPJRjrz4PT4JhHTTEh0550vEYa+6uk9J3fRvdQrkbaFCj
	PJwP5lWETVMMf1WmH2ol3Vs5wA/eOeh+CpPnXXwInHrxhXy8DExk9Rlcoc8SYDhY7xY7qc
	k2JPa1MNJUMTHx8RmaXOTygHgxfY3B4=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 347c38e4 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 11 Sep 2024 13:42:54 +0000 (UTC)
Date: Wed, 11 Sep 2024 15:42:52 +0200
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
To: Heiko Carstens <hca@linux.ibm.com>
Cc: Shuah Khan <shuah@kernel.org>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Jens Remus <jremus@linux.ibm.com>, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-s390@vger.kernel.org
Subject: Re: [PATCH 2/2] selftests: vDSO: fix vdso_config for s390
Message-ID: <ZuGeXMeRPoeuqz66@zx2c4.com>
References: <20240911085015.3581722-1-hca@linux.ibm.com>
 <20240911085015.3581722-3-hca@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240911085015.3581722-3-hca@linux.ibm.com>

On Wed, Sep 11, 2024 at 10:50:15AM +0200, Heiko Carstens wrote:
> Running vdso_test_correctness on s390x (aka s390 64 bit) emits a warning:
> 
> Warning: failed to find clock_gettime64 in vDSO
> 
> This is caused by the "#elif defined (__s390__)" check in vdso_config.h
> which the defines VDSO_32BIT.
> 
> If __s390x__ is defined also __s390__ is defined. Therefore the correct
> check must make sure that only __s390__ is defined.
> 
> Therefore add the missing !defined(__s390x__). Also use common
> __s390x__ define instead of __s390X__.
> 
> Signed-off-by: Heiko Carstens <hca@linux.ibm.com>

I'll add to it:

    Fixes: 693f5ca08ca0 ("kselftest: Extend vDSO selftest")

