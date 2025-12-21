Return-Path: <linux-kselftest+bounces-47804-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EFCB9CD4452
	for <lists+linux-kselftest@lfdr.de>; Sun, 21 Dec 2025 19:57:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8C1503006A42
	for <lists+linux-kselftest@lfdr.de>; Sun, 21 Dec 2025 18:57:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C83032FDC28;
	Sun, 21 Dec 2025 18:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="g+GTEdc1"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97A0184A35;
	Sun, 21 Dec 2025 18:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766343430; cv=none; b=GMmTvd9ayefECW8JrZV5ml1p3+zBmqRU0U7pE7MnKU+2iK8159pzhiXMHA3M9BbT6WFOJc7E1q0S35+12WWBm4WhzeHviiFkYgLi4p8mklL0lzH1OTU//4yMLqnqDyVAh7JR12QMB8lcxuJ/t1KXYLeW3TH2Mu6mcdrmVM0fQpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766343430; c=relaxed/simple;
	bh=hGQHHnPP2FAXKrHAOJzdAxZu07/LllOij9yDLMsdGM8=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=gzguzjKNjl6N83MB7x31/aqeehdHAQed3cFaCk6ZIHkU95b5IL7MUqM7zM0ypACoU5pg5GiyOe+ReJXkdDV015sD71ejWy8kJJyYuAS1EjafG7ZrAk8/SRgLbagWAGJ4xdy31Z/zxjLrIDH6hghdEaWfK80PUhSa/Rd+zY2VNx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=g+GTEdc1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4CD1C4CEFB;
	Sun, 21 Dec 2025 18:57:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1766343430;
	bh=hGQHHnPP2FAXKrHAOJzdAxZu07/LllOij9yDLMsdGM8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=g+GTEdc1y/9lf6gj0ixFdSdxktQF8rWsMKHsoSn6bcMfeHOG2y7LU0Y019TXF927J
	 kY4014nBSvXnSsvNdhZRS8fsy4JQyXJ7AwiD/cyD2cEQ1pMQSi55tztfyYpZFtdKYe
	 trjqvcQID3OtOjPEMBo0aOTBuLmzUPHXUAlHAeG8=
Date: Sun, 21 Dec 2025 10:57:09 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Chunyu Hu <chuhu@redhat.com>
Cc: david@kernel.org, shuah@kernel.org, linux-mm@kvack.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, vbabka@suse.cz,
 rppt@kernel.org, surenb@google.com, mhocko@suse.com, Luiz Capitulino
 <luizcap@redhat.com>
Subject: Re: [PATCH v2 1/5] selftests/mm: fix va_high_addr_switch.sh return
 value
Message-Id: <20251221105709.d2e44cf1bb05bd9669e76d0c@linux-foundation.org>
In-Reply-To: <20251221040025.3159990-1-chuhu@redhat.com>
References: <20251221040025.3159990-1-chuhu@redhat.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 21 Dec 2025 12:00:21 +0800 Chunyu Hu <chuhu@redhat.com> wrote:

> Patch series "Fix va_high_addr_switch.sh test failure - again", v2.
> 
> The series address several issues exist for the va_high_addr_switch test:
> 1) the test return value is ignored in va_high_addr_switch.sh.
> 2) the va_high_addr_switch test requires 6 hugepages not 5.
> 3) the reurn value of the first test in va_high_addr_switch.c can be
>    overridden by the second test.
> 4) the nr_hugepages setup in run_vmtests.sh for arm64 can be done in
>    va_high_addr_switch.sh too.
> 5) update a comment for check_test_requirements.
> 
> Changes in v2:
>  - shorten the comment in for hugepages setup in v1
>  - add a new patch to fix the return value overridden issue in
>    va_high_addr_switch.c
>  - fix a code comment for check_test_requirements.
>  - update the series summary in patch 1
>  - add reviewed-by from Luiz Capitulino on patch 1 and patch 3

The "Changes in v2" material is best placed below the "---" separator -
I prefer not to capture such short-term development-time info within
the permanent kernel record.

> This patch: (of 5)
> 
> The return value should be return value of va_high_addr_switch, otherwise
> a test failure would be silently ignored.
> 
> Reviewed-by: Luiz Capitulino <luizcap@redhat.com>
> Fixes: d9d957bd7b61 ("selftests/mm: alloc hugepages in va_high_addr_switch test")
> CC: Luiz Capitulino <luizcap@redhat.com>
> Signed-off-by: Chunyu Hu <chuhu@redhat.com>
> 
> ...
>
> According to the doc below, I don't add the cover letter, not sure if cover
> letter is preferred, and if that's the case, the doc need an update.

Funnily enough, your series was in the exact format which I use when
committing patch series.  Usually people put the cover letter in a
separate [0/N] email and I move that into the [1/N] patch's changelog,
as you've done here.

> https://www.ozlabs.org/~akpm/stuff/tpp.txt

God does that still exist?  Pretty soon it will be able to legally
drink in bars.

I think its content got absorbed into a Documentation/ file a long time
ago!



