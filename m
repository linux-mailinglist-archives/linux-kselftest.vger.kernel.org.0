Return-Path: <linux-kselftest+bounces-2790-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F7FF829372
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Jan 2024 06:47:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A2B791C2160E
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Jan 2024 05:47:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67400DF4E;
	Wed, 10 Jan 2024 05:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="eP4fmrHe"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41DCEDDD1;
	Wed, 10 Jan 2024 05:47:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63DDAC433C7;
	Wed, 10 Jan 2024 05:47:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1704865652;
	bh=u+YhZyGDNOdxdSwFJegLKK032t1WLWGChzSAS8V2a3k=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=eP4fmrHeRepHJ0pA0bpACG1sSKddJlzxQYKGjO2sPLYRp2GO/6aI2gyHnltcbzz/w
	 f1YKgHF8aG4zSjc384gmDeq8DWygduXo3UGRiJ/1yTYQPnAtOEyf+XSAQb00X8YNHv
	 KosuDzJzDhq4TYM2bYt5FAi1UuatWoGJTk43veDc=
Date: Tue, 9 Jan 2024 21:47:31 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Breno Leitao <leitao@debian.org>
Cc: riel@surriel.com, linux-mm@kvack.org, Shuah Khan <shuah@kernel.org>,
 vegard.nossum@oracle.com, rppt@kernel.org, songmuchun@bytedance.com,
 shy828301@gmail.com, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] selftests/mm: new test that steals pages
Message-Id: <20240109214731.a7694ae4a575be838b40e9ea@linux-foundation.org>
In-Reply-To: <20240105155419.1939484-2-leitao@debian.org>
References: <20240105155419.1939484-1-leitao@debian.org>
	<20240105155419.1939484-2-leitao@debian.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri,  5 Jan 2024 07:54:19 -0800 Breno Leitao <leitao@debian.org> wrote:

> This test stresses the race between of madvise(DONTNEED), a page fault
> and a parallel huge page mmap, which should fail due to lack of
> available page available for mapping.
> 
> This test case must run on a system with one and only one huge page
> available.
> 
> 	# echo 1 > /sys/kernel/mm/hugepages/hugepages-2048kB/nr_hugepages

Can't the test framework perform this configuration prior to running
the test?

> During setup, the test allocates the only available page, and starts
> three threads:
> 
>   - thread 1:
>       * madvise(MADV_DONTNEED) on the allocated huge page
>   - thread 2:
>       * Write to the allocated huge page
>   - thread 3:
>       * Tries to allocated (steal) an extra huge page (which is not
>         available)
> 
> thread 3 should never succeed in the allocation, since the only huge
> page was never unmapped, and should be reserved.
> 
> Touching the old page after thread3 allocation will raise a SIGBUS.
> 

It's a bit strange to merge a selftest which is expected to fail
because of a known but unfixed kernel bug.  But I'll toss the test
in there anyway, as we deserve to get bug reports ;)

