Return-Path: <linux-kselftest+bounces-48672-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id ACCB7D0E025
	for <lists+linux-kselftest@lfdr.de>; Sun, 11 Jan 2026 01:37:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CC7B5301CEB3
	for <lists+linux-kselftest@lfdr.de>; Sun, 11 Jan 2026 00:37:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BE0770830;
	Sun, 11 Jan 2026 00:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="VkHIdnuq"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD8BD611E;
	Sun, 11 Jan 2026 00:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768091825; cv=none; b=ruIrIbkI7/wjNpckox4eqb0uaS9vJWe96SjXVBl/oW8+GiPqdkVeT6A66RrPjMK6mY0MNdedrrvrj7nhZNfwk3MDBTaevWwcFI+th4LV9kGyH0AybIo6qHgm2deVI37JjPkyoUiIc4b8E6z+x3N08r1GavmyI0nRBjyCrc4/pxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768091825; c=relaxed/simple;
	bh=RP/QQUt3xOSF4p4BUNnPlwK6BDXZRjUEGy8pztaa+OM=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=oO6ftYRgeqM3KZov4ReJetXFferuKLBDimQosjZdw6A2gqH5nNFcCegJmis14ZwwbdsDfvAtzeCsp/G1U7BwHBORHXMbJPsDCZa1zfB8RtXCMzaNkBZwMtbY6Rk3aXo+E5jrCh/3d5G+mUKKptFCiHTnILwsKtajYNhRBI4YkJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=VkHIdnuq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 166B3C4CEF1;
	Sun, 11 Jan 2026 00:37:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1768091825;
	bh=RP/QQUt3xOSF4p4BUNnPlwK6BDXZRjUEGy8pztaa+OM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=VkHIdnuqbLB+mjbkjrPTaSTMAZDlBdV8QV5FamIkRBGy5iTcGOjTs6O+y5OxQne4v
	 dFr/obRcQ3BwaD8droZfw9DOzQUXclknXRiRFod0uOAlam2QhHqZw4QK5s/2DiyA+M
	 4V5MEJOh7e7MJXYxNQkxgVCRAUX+tA4a3EXdluuo=
Date: Sat, 10 Jan 2026 16:37:04 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Sun Jian <sun.jian.kdev@gmail.com>
Cc: Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, SeongJae Park
 <sj@kernel.org>
Subject: Re: [PATCH] selftests/mm: ksm_tests: skip when not run as root
Message-Id: <20260110163704.7b5e1e10735113baa23f42ef@linux-foundation.org>
In-Reply-To: <20260109094313.52307-1-sun.jian.kdev@gmail.com>
References: <20260109094313.52307-1-sun.jian.kdev@gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri,  9 Jan 2026 17:43:13 +0800 Sun Jian <sun.jian.kdev@gmail.com> wrote:

> ksm_tests writes KSM sysfs knobs under /sys/kernel/mm/ksm, which requires
> root privileges. When run unprivileged, it fails with permission errors
> and reports FAIL, which is misleading.
> 
> Skip the test early when not run as root to avoid false failures.

Thanks.

When reissuing a patch it's nice to cc those individuals who commented
on previous versions.

> --- a/tools/testing/selftests/mm/ksm_tests.c
> +++ b/tools/testing/selftests/mm/ksm_tests.c
> @@ -766,6 +766,11 @@ int main(int argc, char *argv[])
>  	bool merge_across_nodes = KSM_MERGE_ACROSS_NODES_DEFAULT;
>  	long size_MB = 0;
>  
> +	if (geteuid() != 0) {
> +		printf("# SKIP ksm_tests requires root privileges\n");
> +		return KSFT_SKIP;
> +	}
> +

lgtm.  selftests/ code performs this test in about 20 places already,
all different.  In the interests of consistency and code cleanliness,
perhaps some kind person will centralize this check in some fashion!

