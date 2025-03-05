Return-Path: <linux-kselftest+bounces-28294-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D82FDA4F8BE
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Mar 2025 09:25:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4DDBB170725
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Mar 2025 08:25:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECB611FC7DB;
	Wed,  5 Mar 2025 08:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=Usama.Anjum@collabora.com header.b="IYC5s83F"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5E7C1FC7D0;
	Wed,  5 Mar 2025 08:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741163122; cv=pass; b=pNjuhi/N83QxHN4IZkL66GYT0VZy3wYeBVyFRgyMGZ7OERBh22NlauV+kG2tGjLB96ZtgH/A99LLPQ6/fsMh5d5sii8GwFEsuKcd0uaYKP/nvJSz12hXIWTysAg+FU3Xr+nLjcKASXk1/s6yLH4gFuhM/NvjYoLY72D/n9x4wbs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741163122; c=relaxed/simple;
	bh=4QI8Os9GuwQ7DhSddhreLLWvpLqNFJoNSXjsqV4n9QA=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=dLxG6FyXkzPFlH22OIobOW/p8kA/jbIRu+zy5AUUtCrZsVrYptKsRzdrsEUf3L+56mUHiVpAOQdmuAw/b5Fiv5vIvhFMcKZHZnqIrvOcIRGcZlKvPYcxqHud/jaPNvVjJcXhACstRyWqOZ6UAUUiq/vShVFert+vKnvkj+6a90w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=Usama.Anjum@collabora.com header.b=IYC5s83F; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1741163106; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=K3xJNcfU2hs9jipz1svUwZ9VkazhJ+W4aRHFlQf898M6Z5H/KFfzsaKFbPkap3v41D1f4MtYKuuNvytrLgyBgqzf+uzJx7xa99OR9tQ3olB2u6fUm0I230EDpK/wvv3NtDCj+MyHfeMPLNWcV4y1jVDt/tWlu2+ktu4pTcmnxb0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1741163106; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=HqK6YABSFwp1gboqFKvcbJeiOgK8OI1HggxDTa8DH08=; 
	b=MlWDrmptzUsmjSWNVtowT3Q+LLHMc1pflL/hetj7Tx55bDML3M8dZgsmWlmd+vhOVvh81+6gFXlWL9taOR7cdKmx+rJwOHE7eQPAeQv7UyaN91zZ2PpAxXdFdOJucCS3sKocaxcu3TcBSvLGSGfHP75z3mPtlSd/dz2NwlVgaN4=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=Usama.Anjum@collabora.com;
	dmarc=pass header.from=<Usama.Anjum@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1741163106;
	s=zohomail; d=collabora.com; i=Usama.Anjum@collabora.com;
	h=Message-ID:Date:Date:MIME-Version:Cc:Cc:Subject:Subject:To:To:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=HqK6YABSFwp1gboqFKvcbJeiOgK8OI1HggxDTa8DH08=;
	b=IYC5s83FWR8MjxtXFJEziEP4iyTAkKSYIAJEu3n/yKkqPvITb+K8DHrVpbtvDjTX
	2S9IQ8VSyBBvGYqj0Y2kYqbbbW+K2fGKcLmh1AxJY4JElk7nkPGhC8fRswRR4xGTVAu
	MiAll9E9otUITp1EeolR3SaFwNCsztilkq/Osbto=
Received: by mx.zohomail.com with SMTPS id 1741163102954848.6112037464146;
	Wed, 5 Mar 2025 00:25:02 -0800 (PST)
Message-ID: <13019f33-0882-4af3-acf6-e41c2495f78d@collabora.com>
Date: Wed, 5 Mar 2025 13:25:40 +0500
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: Usama.Anjum@collabora.com, Dev Jain <dev.jain@arm.com>,
 linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, Mateusz Guzik <mjguzik@gmail.com>
Subject: Re: [PATCH v3 00/10] selftests/mm: Some cleanups from trying to run
 them
To: Brendan Jackman <jackmanb@google.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Andrew Morton <akpm@linux-foundation.org>, Shuah Khan <shuah@kernel.org>
References: <20250228-mm-selftests-v3-0-958e3b6f0203@google.com>
Content-Language: en-US
From: Muhammad Usama Anjum <Usama.Anjum@collabora.com>
In-Reply-To: <20250228-mm-selftests-v3-0-958e3b6f0203@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External

Hi,

Thanks for adding to the series Dev Jain. The series looks good. Thanks for doing
such a series. It helps everyone.

For the series:
Reviewed-by: Muhammad Usama Anjum <usama.anjum@collabora.com>

On 2/28/25 9:54 PM, Brendan Jackman wrote:
> I never had much luck running mm selftests so I spent a few hours
> digging into why.
> 
> Looks like most of the reason is missing SKIP checks, so this series is
> just adding a bunch of those that I found. I did not do anything like
> all of them, just the ones I spotted in gup_longterm, gup_test, mmap,
> userfaultfd and memfd_secret.
> 
> It's a bit unfortunate to have to skip those tests when ftruncate()
> fails, but I don't have time to dig deep enough into it to actually make
> them pass. I have observed the issue on 9pfs and heard rumours that NFS
> has a similar problem.
> 
> I'm now able to run these test groups successfully:
> 
> - mmap
> - gup_test
> - compaction
> - migration
> - page_frag
> - userfaultfd
> 
> Signed-off-by: Brendan Jackman <jackmanb@google.com>
> ---
> Changes in v3:
> - Added fix for userfaultfd tests.
> - Dropped attempts to use sudo.
> - Fixed garbage printf in uffd-stress.
>   (Added EXTRA_CFLAGS=-Werror FORCE_TARGETS=1 to my scripts to prevent
>    such errors happening again).
> - Fixed missing newlines in ksft_test_result_skip() calls.
> - Link to v2: https://lore.kernel.org/r/20250221-mm-selftests-v2-0-28c4d66383c5@google.com
> 
> Changes in v2 (Thanks to Dev for the reviews):
> - Improve and cleanup some error messages
> - Add some extra SKIPs
> - Fix misnaming of nr_cpus variable in uffd tests
> - Link to v1: https://lore.kernel.org/r/20250220-mm-selftests-v1-0-9bbf57d64463@google.com
> 
> ---
> Brendan Jackman (10):
>       selftests/mm: Report errno when things fail in gup_longterm
>       selftests/mm: Skip uffd-stress if userfaultfd not available
>       selftests/mm: Skip uffd-wp-mremap if userfaultfd not available
>       selftests/mm/uffd: Rename nr_cpus -> nr_threads
>       selftests/mm: Print some details when uffd-stress gets bad params
>       selftests/mm: Don't fail uffd-stress if too many CPUs
>       selftests/mm: Skip map_populate on weird filesystems
>       selftests/mm: Skip gup_longerm tests on weird filesystems
>       selftests/mm: Drop unnecessary sudo usage
>       selftests/mm: Ensure uffd-wp-mremap gets pages of each size
> 
>  tools/testing/selftests/mm/gup_longterm.c    | 45 ++++++++++++++++++----------
>  tools/testing/selftests/mm/map_populate.c    |  7 +++++
>  tools/testing/selftests/mm/run_vmtests.sh    | 25 ++++++++++++++--
>  tools/testing/selftests/mm/uffd-common.c     |  8 ++---
>  tools/testing/selftests/mm/uffd-common.h     |  2 +-
>  tools/testing/selftests/mm/uffd-stress.c     | 42 ++++++++++++++++----------
>  tools/testing/selftests/mm/uffd-unit-tests.c |  2 +-
>  tools/testing/selftests/mm/uffd-wp-mremap.c  |  5 +++-
>  8 files changed, 95 insertions(+), 41 deletions(-)
> ---
> base-commit: 76544811c850a1f4c055aa182b513b7a843868ea
> change-id: 20250220-mm-selftests-2d7d0542face
> 
> Best regards,


-- 
BR,
Muhammad Usama Anjum

