Return-Path: <linux-kselftest+bounces-9389-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D4728BB1F3
	for <lists+linux-kselftest@lfdr.de>; Fri,  3 May 2024 19:54:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8E636B223F3
	for <lists+linux-kselftest@lfdr.de>; Fri,  3 May 2024 17:54:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05660158204;
	Fri,  3 May 2024 17:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ZctGSkb/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D4CF1552FE
	for <linux-kselftest@vger.kernel.org>; Fri,  3 May 2024 17:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714758844; cv=none; b=bPiREGL2Ka4kwGCrx5pCuVphjztV1x1B0ltFDqkFOJvyTQCe4+bHnI7PdzM+7+aRvWqpFV9a+P8c6Qu9Ag0Wdv7ABYRmObkPr2kf8oi9FqhyXUO2+azg4Fa8opqNVFNRLVUzkp+SHojQPksXBaNm11kFPAnYFrzjW1x8rLZY7cc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714758844; c=relaxed/simple;
	bh=MmDr3BQCMFU+IxtuacVnHLexHCTvPtzyWCTkicg3BgI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qSNGvGFao9JzYgfJMWc07UEfQmeGGxKPD//RALKV+EP3zua/nHNaZsc6uLsS8NI7bR2ViO7V9w4wuvo8yhDOa/n7w1RRJrUiA7FmyZ3O3Owwn1uvhXuzrD6//RF0AeQ4EZTJAwChTMmdpbNGiXyreicP4z9vAlIg4psHR2/77L4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ZctGSkb/; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Fri, 3 May 2024 10:53:52 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1714758840;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=x0XQCMnsbYkYwtaS+30vq6EUAn0n4Ulc3+8JbTfZjrU=;
	b=ZctGSkb/BdmDJ3EmsYgUjqlACWFjy+wtUCPB5wpK9c5hQuQEhXvroesiWdCKe01cerZhl4
	lZc2TSh3k0fCMjFNX3qYzv8AV5+b9Uo1RSM+OJL5ZuEQ1aSTBZwiQmRr7UjKQO5J6VIddu
	GriUkbStsO1LOxVEf7YwERAckrj4XkM=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Roman Gushchin <roman.gushchin@linux.dev>
To: John Hubbard <jhubbard@nvidia.com>
Cc: Shuah Khan <shuah@kernel.org>, Tejun Heo <tj@kernel.org>,
	Zefan Li <lizefan.x@bytedance.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Waiman Long <longman@redhat.com>,
	Yosry Ahmed <yosryahmed@google.com>, Nhat Pham <nphamcs@gmail.com>,
	Chengming Zhou <chengming.zhou@linux.dev>,
	Valentin Obst <kernel@valentinobst.de>,
	linux-kselftest@vger.kernel.org, cgroups@vger.kernel.org,
	linux-mm@kvack.org, LKML <linux-kernel@vger.kernel.org>,
	llvm@lists.linux.dev
Subject: Re: [PATCH 1/4] selftests/cgroup: fix clang build failures for abs()
 calls
Message-ID: <ZjUksIIiiZX_1P06@P9FQF9L96D>
References: <20240503035105.93280-1-jhubbard@nvidia.com>
 <20240503035105.93280-2-jhubbard@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240503035105.93280-2-jhubbard@nvidia.com>
X-Migadu-Flow: FLOW_OUT

On Thu, May 02, 2024 at 08:51:02PM -0700, John Hubbard wrote:
> First of all, in order to build with clang at all, one must first apply
> Valentin Obst's build fix for LLVM [1]. Once that is done, then when
> building with clang, via:
> 
>     make LLVM=1 -C tools/testing/selftests
> 
> ...clang is pickier than gcc, about which version of abs(3) to call,
> depending on the argument type:
> 
>    int abs(int j);
>    long labs(long j);
>    long long llabs(long long j);
> 
> ...and this is causing both build failures and warnings, when running:
> 
>     make LLVM=1 -C tools/testing/selftests
> 
> Fix this by calling labs() in value_close(), because the arguments are
> unambiguously "long" type.
> 
> [1] https://lore.kernel.org/all/20240329-selftests-libmk-llvm-rfc-v1-1-2f9ed7d1c49f@valentinobst.de/
> 
> Signed-off-by: John Hubbard <jhubbard@nvidia.com>

Reviewed-by: Roman Gushchin <roman.gushchin@linux.dev>

Thanks!

