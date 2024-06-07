Return-Path: <linux-kselftest+bounces-11445-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FAB6900D38
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Jun 2024 22:53:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A44D0283DB0
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Jun 2024 20:53:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B348C154C12;
	Fri,  7 Jun 2024 20:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b="GFZ9KF6+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9654F154BFB;
	Fri,  7 Jun 2024 20:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717793576; cv=none; b=J5LnbssOv9C4yEZkAFnAQ2UccunpGSs9Vsz2FqvaJpuW3UikYVE9cdJVfOVNTTpMEnenpFgiM6IdDGjt5Vof9YKWYL8jOFF2IkXcf4ITIhL2gvYBggzMcBVbB41qsohBW8MsHtdsHpS8nBfNDJVOP46N4BiE5KsEGKmUKroiF5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717793576; c=relaxed/simple;
	bh=VMLxmXz/u3qMiTiYWYaIgTSjlhBqu0PyuRoBOBtThgY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GZz1HVNw+LSvzowPVDGil6ZimO8o/vf7AVeF7tZojOQ3xxHjMJ3ovtGHkfxGTMmANd1IuXcBctA8GDdmS9DzXIdDk51hMasYMFApmDmeDPGWjF7VGp1kGgJ8S39ywtIAGaLMSn3ELpfngLsJDY+ygwE82gEE5FLstvOk0YHFGBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com; spf=pass smtp.mailfrom=pankajraghav.com; dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b=GFZ9KF6+; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pankajraghav.com
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4Vwtgk3THBz9sGk;
	Fri,  7 Jun 2024 22:52:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pankajraghav.com;
	s=MBO0001; t=1717793570;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GYQp9dC3UpZGBuYImicESfmUl6H1CygZfqRoSmgI07M=;
	b=GFZ9KF6+TkSf21PJjhZ4xQoUU2T7OJrIN0wiyXn9te1gMwhL8I+ZOTrDBEj7B1aul3hKhC
	ruUhiFiEpkmjpsMZLd9S6BUTUCiJl6enb/lTyCJVNIPgP59Uu43TGIgV3JzEllNNDXBu5L
	PRsMgKT2cTd9G6uHkmrak67jlPrSR3NDdtvY9qXMF0DAjM3JCwzDqnki82q0t/Fmmpn/K/
	qH/9eiiuaQuP1SuH5fjp0syHQE7pgt2JIotwB93EBjH67OcHOi1LiDTd3w+1DgLU9ClHWG
	mMIQmwnslL42WT8ZbP401PvI2fnmldonX8gsnFQyo/Cov3dFW1t/m9Ky1NQqvQ==
Date: Fri, 7 Jun 2024 20:52:47 +0000
From: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Donet Tom <donettom@linux.ibm.com>, Shuah Khan <shuah@kernel.org>,
	Matthew Wilcox <willy@infradead.org>,
	Tony Battersby <tonyb@cybernetics.com>, linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
	Ritesh Harjani <ritesh.list@gmail.com>,
	Mike Rapoport <rppt@kernel.org>,
	Muchun Song <songmuchun@bytedance.com>,
	David Hildenbrand <david@redhat.com>, p.raghav@samsung.com,
	usama.anjum@collabora.com
Subject: Re: [PATCH v4] selftest: mm: Test if hugepage does not get leaked
 during __bio_release_pages()
Message-ID: <20240607205247.b7touyyblwcpamfm@quentin>
References: <20240607182000.6494-1-donettom@linux.ibm.com>
 <20240607130623.76ba44371f8f406f5d1678b7@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240607130623.76ba44371f8f406f5d1678b7@linux-foundation.org>

On Fri, Jun 07, 2024 at 01:06:23PM -0700, Andrew Morton wrote:
> On Fri,  7 Jun 2024 13:20:00 -0500 Donet Tom <donettom@linux.ibm.com> wrote:
> 
> > V4:
> > - Added this test to run_vmtests.sh.
> 
> v4 also contains this change:

I think v3 already had these changes [1]

V3:
- Fixed the build error when it is compiled with _FORTIFY_SOURCE.

[1] https://lore.kernel.org/linux-kselftest/20240607055046.138650-1-donettom@linux.ibm.com/
> 
> --- a/tools/testing/selftests/mm/hugetlb_dio.c~selftest-mm-test-if-hugepage-does-not-get-leaked-during-__bio_release_pages-v4
> +++ a/tools/testing/selftests/mm/hugetlb_dio.c
> @@ -40,7 +40,7 @@ void run_dio_using_hugetlb(unsigned int
>  		ksft_exit_fail_msg("Unable to determine huge page size\n");
>  
>  	/* Open the file to DIO */
> -	fd = open("/tmp", O_TMPFILE | O_RDWR | O_DIRECT);
> +	fd = open("/tmp", O_TMPFILE | O_RDWR | O_DIRECT, 0664);
>  	if (fd < 0)
>  		ksft_exit_fail_perror("Error opening file\n");
>  
> 

