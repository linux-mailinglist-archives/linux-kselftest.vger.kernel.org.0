Return-Path: <linux-kselftest+bounces-10416-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE7FB8C9784
	for <lists+linux-kselftest@lfdr.de>; Mon, 20 May 2024 02:04:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 344F6B20B37
	for <lists+linux-kselftest@lfdr.de>; Mon, 20 May 2024 00:04:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9702367;
	Mon, 20 May 2024 00:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="F7aihozi"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98B477F6;
	Mon, 20 May 2024 00:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716163438; cv=none; b=OpR/eE6o/aAoq04W50/Z7rX70OTkZquRtHKBgE6Fz2MbwP2PBlPOdi0XF24ujmw0EgTNkRkPCvILHTvMPkajJTBXBwaZWV3HwwHeoZrLVuaGOahBtVgl19teXJrpVxCRRSM2U0ysmojmh4GJvxfNTzSvOOKmLtm7/cOdwARcyfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716163438; c=relaxed/simple;
	bh=7yFBaYGbdejk5hZQC2H+aoo4UlB4LeIDYylGT3eKgD4=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=B7DBRMWdlBr4lwcGq1vfIvSSap8ahvv4cL2zxPFwyA0jub7SACYCABZBDSNRQYcj1cAnv+6bGw83VSo0jT9ct+xN++QrkuLGIlafszfWKC/VMMJu9v13ok2SKqpJvKyxJ9pUin2tTeLwRcmvP/k2C/7+PHQ6zVRM7hxpXdDq/h4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=F7aihozi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8B81C32781;
	Mon, 20 May 2024 00:03:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1716163438;
	bh=7yFBaYGbdejk5hZQC2H+aoo4UlB4LeIDYylGT3eKgD4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=F7aihoziRiv6mHe2u8ZO/m74t67Vxpw3JJ0ZBNtIDAf3ae4hDtDSkxecj1KkyhUAe
	 8DYzLinGmCU2Ui+NNUi6bOEhV/UaTSSIrS0NFQlY0CyVlsXitk4xZspPOMvtMDRs10
	 LquAgTIpZNCHokNh4+x2Hmf31O3o5Pk2k56vRFmc=
Date: Sun, 19 May 2024 17:03:57 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Dev Jain <dev.jain@arm.com>
Cc: shuah@kernel.org, linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, Anshuman.Khandual@arm.com,
 sjayaram@akamai.com, stable@vger.kernel.org
Subject: Re: [PATCH 2/2] selftests/mm: compaction_test: Fix trivial test
 success and reduce probability of OOM-killer invocation
Message-Id: <20240519170357.757d30aac192c686f10d709c@linux-foundation.org>
In-Reply-To: <20240515093633.54814-3-dev.jain@arm.com>
References: <20240515093633.54814-1-dev.jain@arm.com>
	<20240515093633.54814-3-dev.jain@arm.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 15 May 2024 15:06:33 +0530 Dev Jain <dev.jain@arm.com> wrote:

> Reset nr_hugepages to zero before the start of the test.
> 
> If a non-zero number of hugepages is already set before the start of the
> test, the following problems arise:
> 
>  - The probability of the test getting OOM-killed increases.
> Proof: The test wants to run on 80% of available memory to prevent
> OOM-killing (see original code comments). Let the value of mem_free at the
> start of the test, when nr_hugepages = 0, be x. In the other case, when
> nr_hugepages > 0, let the memory consumed by hugepages be y. In the former
> case, the test operates on 0.8 * x of memory. In the latter, the test
> operates on 0.8 * (x - y) of memory, with y already filled, hence, memory
> consumed is y + 0.8 * (x - y) = 0.8 * x + 0.2 * y > 0.8 * x. Q.E.D
> 
>  - The probability of a bogus test success increases.
> Proof: Let the memory consumed by hugepages be greater than 25% of x,
> with x and y defined as above. The definition of compaction_index is
> c_index = (x - y)/z where z is the memory consumed by hugepages after
> trying to increase them again. In check_compaction(), we set the number
> of hugepages to zero, and then increase them back; the probability that
> they will be set back to consume at least y amount of memory again is
> very high (since there is not much delay between the two attempts of
> changing nr_hugepages). Hence, z >= y > (x/4) (by the 25% assumption).
> Therefore,
> c_index = (x - y)/z <= (x - y)/y = x/y - 1 < 4 - 1 = 3
> hence, c_index can always be forced to be less than 3, thereby the test
> succeeding always. Q.E.D
> 
> NOTE: This patch depends on the previous one.
> 
> -int check_compaction(unsigned long mem_free, unsigned int hugepage_size)
> +int check_compaction(unsigned long mem_free, unsigned int hugepage_size,
> +		     int initial_nr_hugepages)
>  {
>  	int fd, ret = -1;
>  	int compaction_index = 0;
> -	char initial_nr_hugepages[10] = {0};
>  	char nr_hugepages[10] = {0};
> +	char init_nr_hugepages[10] = {0};
> +
> +	sprintf(init_nr_hugepages, "%d", initial_nr_hugepages);

Well, [10] isn't really large enough.  "-1111111111" requires 12 chars,
with the trailing \0.  And I'd suggest an unsigned type and a %u -
negative initial_nr_hugepages doesn't make a lot of sense.

>  
> +int set_zero_hugepages(int *initial_nr_hugepages)
> +{
> +	int fd, ret = -1;
> +	char nr_hugepages[10] = {0};

Ditto?

> +	fd = open("/proc/sys/vm/nr_hugepages", O_RDWR | O_NONBLOCK);
> +	if (fd < 0) {
> +		ksft_print_msg("Failed to open /proc/sys/vm/nr_hugepages: %s\n",
> +			       strerror(errno));
> +		goto out;
> +	}
> +
> +	if (read(fd, nr_hugepages, sizeof(nr_hugepages)) <= 0) {
> +		ksft_print_msg("Failed to read from /proc/sys/vm/nr_hugepages: %s\n",
> +			       strerror(errno));
> +		goto close_fd;
> +	}
> +
> +	lseek(fd, 0, SEEK_SET);
> +
> +	/* Start with the initial condition of 0 huge pages */
> +	if (write(fd, "0", sizeof(char)) != sizeof(char)) {
> +		ksft_print_msg("Failed to write 0 to /proc/sys/vm/nr_hugepages: %s\n",
> +			       strerror(errno));
> +		goto close_fd;
> +	}
> +
> +	*initial_nr_hugepages = atoi(nr_hugepages);
> +	ret = 0;
> +
> + close_fd:
> +	close(fd);
> +
> + out:
> +	return ret;
> +}


