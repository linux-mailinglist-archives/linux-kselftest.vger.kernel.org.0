Return-Path: <linux-kselftest+bounces-15099-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AC7594D8F3
	for <lists+linux-kselftest@lfdr.de>; Sat, 10 Aug 2024 01:05:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA2101C21FDA
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 Aug 2024 23:05:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCF7716CD3B;
	Fri,  9 Aug 2024 23:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gentwo.org header.i=@gentwo.org header.b="lVSwrjsC"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from gentwo.org (gentwo.org [62.72.0.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 289F040BE5;
	Fri,  9 Aug 2024 23:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.72.0.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723244633; cv=none; b=PAJdvI2Mjh75OCE65Rp5V9eMSBQIZMf5C0nvDvjD3LPZEgfE2khMntJP/qEjgXEeMgSGCLdkprkmixPS+Y9Ge/rEXxNg0opQ+xxUeaaZdnvSsclZ+3Jm59etl62HglaVDZ9m/dFr7lLFQzA5LiHBl7V3TVmEJJpWapmI2eTP/6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723244633; c=relaxed/simple;
	bh=xOjgbVHoq+qMvCIiyrVGLH7gR4Niui5wdTSkXOeAFfU=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=aJ+9tmh/lB9/Xdq/NhV1wWWrjfK30GfuVHP15mnd/tYlc9Iux3MNvJyx1DE709HS2gJT+emOy/7+4TeD0dJVg8k6eM4MW2KZGFiaZBu2WAO7+vSlnEY5qgbow9gzBqewUe/GjDIY93A6i/T5DVdNsOSBwJHKNTYUrbjFzGVazwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gentwo.org; spf=pass smtp.mailfrom=gentwo.org; dkim=pass (1024-bit key) header.d=gentwo.org header.i=@gentwo.org header.b=lVSwrjsC; arc=none smtp.client-ip=62.72.0.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gentwo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentwo.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gentwo.org;
	s=default; t=1723237814;
	bh=xOjgbVHoq+qMvCIiyrVGLH7gR4Niui5wdTSkXOeAFfU=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=lVSwrjsC+sZuKS1DLVhy9GDaCag024tcjIOx6qIXLECPuE/JY2mtxhusObORDnwly
	 gwjYSd3ly7ynuRLm87I362QuIsonLOUnfDcRKIJsclRYwXBr5AeGjIMjmiYG9W+bBq
	 0Zp18W1uCvWBpE4cwSPCkuo3o8C6w3vZ2JtWwe/8=
Received: by gentwo.org (Postfix, from userid 1003)
	id 6BA864040E; Fri,  9 Aug 2024 14:10:14 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by gentwo.org (Postfix) with ESMTP id 69F024035C;
	Fri,  9 Aug 2024 14:10:14 -0700 (PDT)
Date: Fri, 9 Aug 2024 14:10:14 -0700 (PDT)
From: "Christoph Lameter (Ampere)" <cl@gentwo.org>
To: Shuah Khan <skhan@linuxfoundation.org>
cc: Dev Jain <dev.jain@arm.com>, akpm@linux-foundation.org, shuah@kernel.org, 
    david@redhat.com, willy@infradead.org, ryan.roberts@arm.com, 
    anshuman.khandual@arm.com, catalin.marinas@arm.com, vbabka@suse.cz, 
    mhocko@suse.com, apopple@nvidia.com, osalvador@suse.de, 
    baolin.wang@linux.alibaba.com, dave.hansen@linux.intel.com, 
    will@kernel.org, baohua@kernel.org, ioworker0@gmail.com, gshan@redhat.com, 
    mark.rutland@arm.com, kirill.shutemov@linux.intel.com, hughd@google.com, 
    aneesh.kumar@kernel.org, yang@os.amperecomputing.com, peterx@redhat.com, 
    broonie@kernel.org, mgorman@techsingularity.net, 
    linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
    linux-mm@kvack.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 2/2] selftests/mm: Do not fail test for a single migration
 failure
In-Reply-To: <e3bf3d2b-eb19-4678-916e-7a7f572b2936@linuxfoundation.org>
Message-ID: <aead8fc9-c60a-9ac6-280e-b2b9de85727c@gentwo.org>
References: <20240809103129.365029-1-dev.jain@arm.com> <20240809103129.365029-3-dev.jain@arm.com> <e3bf3d2b-eb19-4678-916e-7a7f572b2936@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Fri, 9 Aug 2024, Shuah Khan wrote:

> "Given that migration is a best-effort service, it is wrong to fail the
> test for just a single failure; hence, fail the test after 100 consecutive
> failures (where 100 is still a subjective choice)."
>
> You do want to mention the above here.
>
> The reason being, I would like to know what this does to the run-time of
> this test if migration fails and retried 100 times.

If we backoff earlier without engaging too much with the page then we can 
in turn affort to retry more times.

