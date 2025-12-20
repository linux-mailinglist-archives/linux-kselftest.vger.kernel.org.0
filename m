Return-Path: <linux-kselftest+bounces-47777-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B5327CD35CC
	for <lists+linux-kselftest@lfdr.de>; Sat, 20 Dec 2025 19:58:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 759C0300C6CF
	for <lists+linux-kselftest@lfdr.de>; Sat, 20 Dec 2025 18:58:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3C5030F957;
	Sat, 20 Dec 2025 18:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="08/+s6Qc"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63B3530F549;
	Sat, 20 Dec 2025 18:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766257093; cv=none; b=S164pwYFET5eioHUPhcZVB5SlQJL/7nEUTlWRAqbS1usRRlHRSWVpV6aog/j9qDXlEmBAun5il2Zrz1KkIWFUYLqzAYFKzHsUKZAARumc2mDWaRBJQK9At+7NQJr7AnHxkdohymEDxksgEK9ITWMdafB5m+baXL8CJdEcI1q/IQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766257093; c=relaxed/simple;
	bh=hNYk6WvWY18rpSMRepWtGWSsWj/pCn+KqXDaxv4oSAU=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=b9YqjwyWZehV4PVQqMJVq8nHZ7mZPrztmzgR8zvUpDTPU0Bxz1c96jKV62SNZd/P7zeGpgS/iXHTVd5oaGDiXp2wxcwkJWmUwbUkTD8dCqo8sDhGbpiuf3CM7vV43ErAS72+mc3XSWYvgx/tykGperLC32BQtUCCYrM+7wqpwpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=08/+s6Qc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A1B0C4CEF5;
	Sat, 20 Dec 2025 18:58:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1766257092;
	bh=hNYk6WvWY18rpSMRepWtGWSsWj/pCn+KqXDaxv4oSAU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=08/+s6Qcq4HVi/H4W3MD2fJtmg7A9T0b0dpAdF6cTj998kxZ05Wn5oTdiktIwlApz
	 0EchykW636s6Lpq0OHCtMt0h4Wp27k4JHqqKiipg8mEBrTJZ4AeuriGkskTQYloVrd
	 Mo7nYwxl7wCG5hi5yvisMSx9xRVdadUMOkYeiQ0s=
Date: Sat, 20 Dec 2025 10:58:11 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Li Wang <liwang@redhat.com>
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, David Hildenbrand <david@kernel.org>, Mark Brown
 <broonie@kernel.org>, Shuah Khan <shuah@kernel.org>, Waiman Long
 <longman@redhat.com>
Subject: Re: [PATCH 1/3] selftests/mm/write_to_hugetlbfs: parse -s with
 strtoull and use size_t
Message-Id: <20251220105811.3516167661cd696f464cc3b0@linux-foundation.org>
In-Reply-To: <20251220111645.2246009-2-liwang@redhat.com>
References: <20251220111645.2246009-1-liwang@redhat.com>
	<20251220111645.2246009-2-liwang@redhat.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 20 Dec 2025 19:16:43 +0800 Li Wang <liwang@redhat.com> wrote:

> write_to_hugetlbfs currently parses the -s size argument with atoi()
> into an int. This silently accepts malformed input, cannot report overflow,
> and can truncate large sizes.
> 
> --- Error log ---
>  # uname -r
>  6.12.0-xxx.el10.aarch64+64k
> 
>  # ls /sys/kernel/mm/hugepages/hugepages-*
>  hugepages-16777216kB/  hugepages-2048kB/  hugepages-524288kB/
> 
>  #./charge_reserved_hugetlb.sh -cgroup-v2
>  # -----------------------------------------
>  ...
>  # nr hugepages = 10
>  # writing cgroup limit: 5368709120
>  # writing reseravation limit: 5368709120

Can we fix that typo while we're in there?  "reservation".

>  ...
>  # Writing to this path: /mnt/huge/test
>  # Writing this size: -1610612736        <--------
> 
> Switch size to size_t and parse -s using strtoull() with proper validation.
> Also print the size using %zu.
> 
> This makes the test utility more robust and avoids undefined/incorrect
> behavior with large or invalid -s values.
> 
> ...
>
> --- a/tools/testing/selftests/mm/write_to_hugetlbfs.c
> +++ b/tools/testing/selftests/mm/write_to_hugetlbfs.c
> @@ -68,7 +68,7 @@ int main(int argc, char **argv)
>  	int key = 0;
>  	int *ptr = NULL;
>  	int c = 0;
> -	int size = 0;
> +	size_t size = 0;
>  	char path[256] = "";
>  	enum method method = MAX_METHOD;
>  	int want_sleep = 0, private = 0;
> @@ -86,7 +86,20 @@ int main(int argc, char **argv)
>  	while ((c = getopt(argc, argv, "s:p:m:owlrn")) != -1) {
>  		switch (c) {
>  		case 's':
> -			size = atoi(optarg);
> +			errno = 0;
> +			char *end = NULL;
> +			unsigned long long tmp = strtoull(optarg, &end, 10);

Coding-style nits: we do accept c99-style definitions nowadays but I do
think our eyes prefer the less surprising "definitions come before
code" style.  So the above could be

			char *end = NULL;
			unsigned long long tmp = strtoull(optarg, &end, 10);

			errno = 0;

Also, `errno' belongs to libc.  It seems wrong to be altering it from
within our client code.

> +			if (errno || end == optarg || *end != '\0') {
> +				errno = EINVAL;
> +				perror("Invalid -s size");
> +				exit_usage();
> +			}
> +			if (tmp == 0) {
> +				errno = EINVAL;
> +				perror("size not found");
> +				exit_usage();
> +			}
> +			size = (size_t)tmp;
>  			break;

I'm not really clear on what problems we're trying to solve here, but
this all seems like a lot of fuss.  Can we just do

	if (sscanf(optarg, "%zu", &size) != 1)

?

>  		case 'p':
>  			strncpy(path, optarg, sizeof(path) - 1);
> @@ -131,7 +144,7 @@ int main(int argc, char **argv)
>  	}
>  
>  	if (size != 0) {
> -		printf("Writing this size: %d\n", size);
> +		printf("Writing this size: %zu\n", size);
>  	} else {
>  		errno = EINVAL;
>  		perror("size not found");


