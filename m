Return-Path: <linux-kselftest+bounces-6479-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DAC038863F4
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Mar 2024 00:29:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8DF90282B95
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Mar 2024 23:29:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A815814271;
	Thu, 21 Mar 2024 23:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="ZZo0gcLM"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FB354A2F;
	Thu, 21 Mar 2024 23:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711063763; cv=none; b=fzAvP00YuyEQG7GM/jUkPLVKUN099co+e10tWMEkaK/Ia58/lnKQV0f0ZdR6OYaIbTRyN0CjjNgi/ia3p37ET/8OfeoQE6/9OFXahedAj6ACE3Pna19KMhM38sTVShpvBxwJcfxdnOZdDlLDg9wCEII9AAK6bmT/7tgRuvWUPFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711063763; c=relaxed/simple;
	bh=2Pz8cF8MDfEMzcs0iw7P4Cuhg9qBQUWj10/JCOJ8j6A=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=aD96+0cd1qILmr140PaFGoBmtLrVNPrt1XRaNIucNMXxxLz6rTgr0R0V5pmDT28YOlfciVewrrO+SftfkbIxjAsckyy96cibONceGQS6ZFscDi4IjMxLUe0tWxJTP8SHIBNrqhqc1HG4kOBv0CCLisY/H7iEBwbocN63OjqY72I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=ZZo0gcLM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFF20C433F1;
	Thu, 21 Mar 2024 23:29:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1711063763;
	bh=2Pz8cF8MDfEMzcs0iw7P4Cuhg9qBQUWj10/JCOJ8j6A=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ZZo0gcLMk2YbSDlpvEQUevexiFASvpAWLaSETqlXlV95OeKlj+KzcsKdDuGt48SJZ
	 /5wLcMeYudg2R9TiX7dn3k5nf6Aqq5XNB3vE5e2n4oU5lV5RXk6EUjghRl2SQXYC5Z
	 NqK7l5VCclC4GWCu7ANbyx4WckGlW2S59lrmfs+g=
Date: Thu, 21 Mar 2024 16:29:22 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Edward Liaw <edliaw@google.com>
Cc: linux-kernel@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
 linux-kselftest@vger.kernel.org, kernel-team@android.com,
 linux-mm@kvack.org, Peter Xu <peterx@redhat.com>
Subject: Re: [PATCH v1] selftests/mm: sigbus-wp test requires
 UFFD_FEATURE_WP_HUGETLBFS_SHMEM
Message-Id: <20240321162922.172db3abb3a9aa4aca36afb6@linux-foundation.org>
In-Reply-To: <20240321232023.2064975-1-edliaw@google.com>
References: <20240321232023.2064975-1-edliaw@google.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 21 Mar 2024 23:20:21 +0000 Edward Liaw <edliaw@google.com> wrote:

> The sigbus-wp test requires the UFFD_FEATURE_WP_HUGETLBFS_SHMEM flag for
> shmem and hugetlb targets.  Otherwise it is not backwards compatible
> with kernels <5.19 and fails with EINVAL.
> 
> ...
>
> --- a/tools/testing/selftests/mm/uffd-unit-tests.c
> +++ b/tools/testing/selftests/mm/uffd-unit-tests.c
> @@ -1437,7 +1437,8 @@ uffd_test_case_t uffd_tests[] = {
>  		.uffd_fn = uffd_sigbus_wp_test,
>  		.mem_targets = MEM_ALL,
>  		.uffd_feature_required = UFFD_FEATURE_SIGBUS |
> -		UFFD_FEATURE_EVENT_FORK | UFFD_FEATURE_PAGEFAULT_FLAG_WP,
> +		UFFD_FEATURE_EVENT_FORK | UFFD_FEATURE_PAGEFAULT_FLAG_WP |
> +		UFFD_FEATURE_WP_HUGETLBFS_SHMEM,
>  	},
>  	{
>  		.name = "events",

Thanks, I'll add

Fixes: 73c1ea939b65 ("selftests/mm: move uffd sig/events tests into uffd unit tests")
Cc: <stable@vger.kernel.org>

