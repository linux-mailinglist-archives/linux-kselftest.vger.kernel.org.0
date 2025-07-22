Return-Path: <linux-kselftest+bounces-37794-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 57A7CB0D010
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Jul 2025 05:09:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B8A86C7B59
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Jul 2025 03:08:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00D6928BA85;
	Tue, 22 Jul 2025 03:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="UDrsL0hv"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A59CA2E36FD;
	Tue, 22 Jul 2025 03:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753153763; cv=none; b=F2jF5tthaC/dHc45Jgmsqz65eLc0Fk5XSz7CzDTZPmtOcJpEAV6/JBG2a3kOovLasJ/V/TWI1r7jsIqSx5rmghI2Bcwj3gwy2EO7K+w+q8mYYUkqDA0iZwWGDQXVBUYEKNYwWK98Kf8Emxvgw78uHDmnM/0ZKkJ90TbCh0WA5Wo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753153763; c=relaxed/simple;
	bh=3DA3Y3JFxdB7JXAPsUmGUF8PlIivhZaQxaEto41YdUs=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=O/miyO++gNKny7slvYyfgbNninmHZAHZL+wghtPviDqssywHVkS+cDeSH0Z0a4DrmVuoZu99xV75ov/IPXCSjcBlztwmVm/1R48ebuMc4hd4ABXHf7exmQ4CUJRieIuYQJ0HOWzH1108z0nLEXqnPR9/5Ezjrt9pXbSISKQVuf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=UDrsL0hv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0117DC4CEED;
	Tue, 22 Jul 2025 03:09:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1753153763;
	bh=3DA3Y3JFxdB7JXAPsUmGUF8PlIivhZaQxaEto41YdUs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=UDrsL0hv9J71Vwcbfl4jjyWauYG79gPGqrXmYRC87svaGRTFkItr/viYPYhFcj98g
	 nUNLDVZSp6VKZyBz/mtE91e/ZfMqrVchV70GcxvyW0PtgK94eoPewmvWtcTJN6PPOE
	 dsua/pWhWGb0hLaHJ99E4s/6xVBjvwUvqMLloQkw=
Date: Mon, 21 Jul 2025 20:09:22 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: SeongJae Park <sj@kernel.org>
Cc: Shuah Khan <shuah@kernel.org>, damon@lists.linux.dev,
 kernel-team@meta.com, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 16/22] selftests/damon/sysfs.py: generalize DAMOS
 schemes commit assertion
Message-Id: <20250721200922.79b34a049af4a02947c716ee@linux-foundation.org>
In-Reply-To: <20250720171652.92309-17-sj@kernel.org>
References: <20250720171652.92309-1-sj@kernel.org>
	<20250720171652.92309-17-sj@kernel.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 20 Jul 2025 10:16:46 -0700 SeongJae Park <sj@kernel.org> wrote:

> DAMOS scheme commitment assertion is hard-coded for a specific test
> case.  Split it out into a general version that can be reused for
> different test cases.
> 

This patch has the same name as [18/22].  I renamed this patch to

"selftests/damon/sysfs.py: generalize DAMOS access pattern commit assertion"

and altered its changelog to

: DAMOS scheme access pattern assertion is hard-coded for a specific test
: case.  Split it out into a general version that can be reused for
: different test cases.

> --- a/tools/testing/selftests/damon/sysfs.py
> +++ b/tools/testing/selftests/damon/sysfs.py
> @@ -76,6 +76,42 @@ def assert_migrate_dests_committed(dests, dump):
>          assert_true(dump['node_id_arr'][idx] == dest.id, 'node_id', dump)
>          assert_true(dump['weight_arr'][idx] == dest.weight, 'weight', dump)
>  
> +def assert_access_pattern_committed(pattern, dump):
> +    assert_true(dump['min_sz_region'] == pattern.size[0], 'min_sz_region',
> +                dump)
> +    assert_true(dump['max_sz_region'] == pattern.size[1], 'max_sz_region',
> +                dump)
> +    assert_true(dump['min_nr_accesses'] == pattern.nr_accesses[0],
> +                'min_nr_accesses', dump)
> +    assert_true(dump['max_nr_accesses'] == pattern.nr_accesses[1],
> +                'max_nr_accesses', dump)
> +    assert_true(dump['min_age_region'] == pattern.age[0], 'min_age_region',
> +                dump)
> +    assert_true(dump['max_age_region'] == pattern.age[1], 'miaxage_region',
> +                dump)
> +
> +def assert_scheme_committed(scheme, dump):
> +    assert_access_pattern_committed(scheme.access_pattern, dump['pattern'])
> +    action_val = {
> +            'willneed': 0,
> +            'cold': 1,
> +            'pageout': 2,
> +            'hugepage': 3,
> +            'nohugeapge': 4,
> +            'lru_prio': 5,
> +            'lru_deprio': 6,
> +            'migrate_hot': 7,
> +            'migrate_cold': 8,
> +            'stat': 9,
> +            }
> +    assert_true(dump['action'] == action_val[scheme.action], 'action', dump)
> +    assert_true(dump['apply_interval_us'] == scheme. apply_interval_us,
> +                'apply_interval_us', dump)
> +    assert_true(dump['target_nid'] == scheme.target_nid, 'target_nid', dump)
> +    assert_migrate_dests_committed(scheme.dests, dump['migrate_dests'])
> +    assert_quota_committed(scheme.quota, dump['quota'])
> +    assert_watermarks_committed(scheme.watermarks, dump['wmarks'])
> +
>  def main():
>      kdamonds = _damon_sysfs.Kdamonds(
>              [_damon_sysfs.Kdamond(
> @@ -122,28 +158,7 @@ def main():
>      if len(ctx['schemes']) != 1:
>          fail('number of schemes', status)
>  
> -    scheme = ctx['schemes'][0]
> -    if scheme['pattern'] != {
> -            'min_sz_region': 0,
> -            'max_sz_region': 2**64 - 1,
> -            'min_nr_accesses': 0,
> -            'max_nr_accesses': 2**32 - 1,
> -            'min_age_region': 0,
> -            'max_age_region': 2**32 - 1,
> -            }:
> -        fail('damos pattern', status)
> -    if scheme['action'] != 9:   # stat
> -        fail('damos action', status)
> -    if scheme['apply_interval_us'] != 0:
> -        fail('damos apply interval', status)
> -    if scheme['target_nid'] != -1:
> -        fail('damos target nid', status)
> -
> -    assert_migrate_dests_committed(_damon_sysfs.DamosDests(),
> -                                   scheme['migrate_dests'])
> -    assert_quota_committed(_damon_sysfs.DamosQuota(), scheme['quota'])
> -    assert_watermarks_committed(_damon_sysfs.DamosWatermarks(),
> -                                scheme['wmarks'])
> +    assert_scheme_committed(_damon_sysfs.Damos(), ctx['schemes'][0])
>  
>      kdamonds.stop()
>  
> -- 
> 2.39.5

