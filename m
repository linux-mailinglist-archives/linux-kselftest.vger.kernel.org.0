Return-Path: <linux-kselftest+bounces-25795-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 338A1A28390
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Feb 2025 06:15:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C237C16681A
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Feb 2025 05:15:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66D122135A2;
	Wed,  5 Feb 2025 05:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ELGEV0dl"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77E3848CFC;
	Wed,  5 Feb 2025 05:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738732533; cv=none; b=u7/ASP+ZBWLsqUMJdWGZAswSPBx+TR368tT2vU+ukPI6VVfiYf2rb6t/jgoyzIAyyBNNj15SZooXGL3iNef3lJp/uusExnmP018HG8EqF2/0Bzz8qnEa9MuQF8O50mIxONROV1AJQMJPiTpk7FcZm1SQRG7xZQTEy4GrPyvdqAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738732533; c=relaxed/simple;
	bh=xpBy48y2UA+KR8n96ofnXCyxi6Puye/KsMnusz7ALI0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fyE87Efgu9AUkmbFOxP8u2kbX799FRT06E1lBEvUzBtH/og47IO8oAxA3vBzu7RNXUF3I8h0vzRYSM75pa7AWy9zSQ9U2Z2/wuYiFZ7H3QrbsgqSvrT5pAY0Hrc8IPfFN5EQRzmAyZkY5b/LqrvewY5472pIjLFhRXgxnL462hM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ELGEV0dl; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Tue, 4 Feb 2025 21:15:18 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1738732524;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uaUTjakUpxcnMvPtqVtBHVgW1WpzJNuk4AUuTtP76xc=;
	b=ELGEV0dlfwwKJBt+oluV0KMpYUwslc9g6nW25Njqp4hc7CXzcvIrGnaYFukv5xTdhKry9z
	FonXis5B9BNqHjif+Yawlao2Mkt2ZhM58ggOlteBAzKh88lUf/jluF/Kak3rgS9aKQKx3G
	gmJ+di8fDu1C6ZiBV+I90/cZX88r3vk=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Christian Brauner <christian@brauner.io>, 
	Shuah Khan <shuah@kernel.org>, "Liam R . Howlett" <Liam.Howlett@oracle.com>, 
	Suren Baghdasaryan <surenb@google.com>, Vlastimil Babka <vbabka@suse.cz>, pedro.falcato@gmail.com, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, 
	linux-api@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Oliver Sang <oliver.sang@intel.com>, John Hubbard <jhubbard@nvidia.com>, Tejun Heo <tj@kernel.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, Michal Koutny <mkoutny@suse.com>, 
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v7 3/6] tools: testing: separate out wait_for_pid() into
 helper header
Message-ID: <y2meyucpfxlu2d2ldotxwhohlkypevzbaygaw5snz2ge5kns4s@mzadihw74hgj>
References: <cover.1738268370.git.lorenzo.stoakes@oracle.com>
 <c611be6f7df6aa85f72c6d4d329b30bbe4a0fbed.1738268370.git.lorenzo.stoakes@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c611be6f7df6aa85f72c6d4d329b30bbe4a0fbed.1738268370.git.lorenzo.stoakes@oracle.com>
X-Migadu-Flow: FLOW_OUT

On Thu, Jan 30, 2025 at 08:40:28PM +0000, Lorenzo Stoakes wrote:
> It seems tests other than the pidfd tests use the wait_for_pid() function
> declared in pidfd.h.
> 
> Since we will shortly be modifying pidfd.h in a way that might clash with
> other tests, separate this out and update tests accordingly.
> 
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

Reviewed-by: Shakeel Butt <shakeel.butt@linux.dev>

