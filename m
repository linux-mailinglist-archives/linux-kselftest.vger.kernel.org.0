Return-Path: <linux-kselftest+bounces-25797-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F226A283A5
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Feb 2025 06:28:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E6D5161587
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Feb 2025 05:28:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 057D121D5A4;
	Wed,  5 Feb 2025 05:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="vMDDXSD4"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44E7D21D59C
	for <linux-kselftest@vger.kernel.org>; Wed,  5 Feb 2025 05:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738733281; cv=none; b=f8cnSPrb/ZofiMltjTWamlfRcIwHesyaalpUwEODHAkZhCN6JAqzaYFjVMe+XSAyWNKpxlJHujBV7UrbQ/OOXvbryy44aO4XIa5vIZhp89TYmqmx3HR4fgk7Pr5Bx+MVUsjHJs1a1X4UKdXnEOoNo1oCZ6usg2JFEy/ULkpMKqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738733281; c=relaxed/simple;
	bh=pK4jSL3Gygw3R6JbuHJk0Jewq96zcYqsIuw0skDpqq4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OOPokCwypCuSqJ6Z7T9lgwV03b1jOwz+StqEN7UQul3ygM+zJLCacFx8E5H2DndL0t+q7xV4SenfQ1GUtpEDILRMTW0zh3Q3Fgnf/qRHAVr/MRQ+vtwOkYXyr5ejeOHFFlKNhEpBnwwWG8aiIXQ0wj0/eaHntChsZyRynVZaerc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=vMDDXSD4; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Tue, 4 Feb 2025 21:27:47 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1738733273;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Yr/kEl344VtN8JcOTmPwoh4ga2bP215c4hyTIT5ZTRI=;
	b=vMDDXSD4ut45yPfX2txcNftk5l9C5ldX6TFwkLReCHrtumv/Vl0odEIad0ry6rQQDz7zR8
	1tv7yqycrgyqXYmAs8NwRAV8uVboWNIz5jqEKyjVenwHoTVSXn2hk3WEcCkjvADxUoWIP3
	C2qoDmjcAXsDAiE8vR1Ywt6nHR1XL3A=
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
Subject: Re: [PATCH v7 5/6] selftests: pidfd: add tests for PIDFD_SELF_*
Message-ID: <23rf6rxqzezqa5zmuiwwairxatbmahboccwzp6p5tbvkjirvqc@h4qzhh3pvsun>
References: <cover.1738268370.git.lorenzo.stoakes@oracle.com>
 <7ab0e48b26ba53abf7b703df2dd11a2e99b8efb2.1738268370.git.lorenzo.stoakes@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7ab0e48b26ba53abf7b703df2dd11a2e99b8efb2.1738268370.git.lorenzo.stoakes@oracle.com>
X-Migadu-Flow: FLOW_OUT

On Thu, Jan 30, 2025 at 08:40:30PM +0000, Lorenzo Stoakes wrote:
> Add tests to assert that PIDFD_SELF* correctly refers to the current
> thread and process.
> 
> We explicitly test pidfd_send_signal(), however We defer testing of
> mm-specific functionality which uses pidfd, namely process_madvise() and
> process_mrelease() to mm testing (though note the latter can not be
> sensibly tested as it would require the testing process to be dying).
> 
> We also correct the pidfd_open_test.c fields which refer to .request_mask
> whereas the UAPI header refers to .mask, which otherwise break the import
> of the UAPI header.
> 
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

Reviewed-by: Shakeel Butt <shakeel.butt@linux.dev>

