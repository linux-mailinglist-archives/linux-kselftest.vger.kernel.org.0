Return-Path: <linux-kselftest+bounces-19692-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3576299DB12
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Oct 2024 03:06:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE78A2831C6
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Oct 2024 01:06:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A88F6F06B;
	Tue, 15 Oct 2024 01:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="scVAaAET"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D0D0DDBB;
	Tue, 15 Oct 2024 01:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728954389; cv=none; b=K1YzjEyE2o74xOu6njKcSWxf19KruPqOy/VaSfl5ldCNtwLfA42/KkMQZiaAgNAUyh8GF9TNK5fvzFpObpHPTLbbpAcH+iyt8mPjN4+dAglS1UioDL+uJ+P5BmDJ93uSE9Q6bKO44QpfpPfE7WQzVGiODPSFXUIKZZQLJxG21Zs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728954389; c=relaxed/simple;
	bh=0vRjrEifTFZRYerDEOyYtut3vd1clooP5OIowb+P7N8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NjLYTEcFyg4nUSCD9SF236lWpZ0Q2GUwgDGykDUMK84Wi1I311+VqNRHR5683opa1SNe+b+kJ/N0UTov1BjNsYNldTFYMC9kfqhZN7nRUjmswiRDhVpCsBLp4V3YCZTvmb5nqBpUGW2cyEtXfG9kwESFea0WjaKAVtfHKVB/a18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=scVAaAET; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F77DC4CEC3;
	Tue, 15 Oct 2024 01:06:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728954388;
	bh=0vRjrEifTFZRYerDEOyYtut3vd1clooP5OIowb+P7N8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=scVAaAET/anX5eVaykSk1KRDUXUsg24top8qWSOnngIS0H56/qDVGKw5h9AyZyHlJ
	 DufLOMjBuSzPwMMwxvER8a26HQo/KvOntO89m5Xh9FWe2Qnc34mELP35AgqUc1HaRs
	 34xLnFgrdv5T8osNjD+o5BOUiLF1dpO4mVEXM2p+NFfu4Mdp4ek9FV/Up4OKfNZvKL
	 /DZi/ekyiRHvYpUwDCc20lkALWUFLiKbzjnuMmFXlKDQONfEmu/0p0cstW7cV63rKP
	 hwLOq8aAVVPhxJLwyQ/w4BcsBpaJDDjl+lqKbQhBquvXW/t72fUPLOj9WhSV2iZhbx
	 XRGSWI3KPgS0Q==
Date: Mon, 14 Oct 2024 15:06:27 -1000
From: Tejun Heo <tj@kernel.org>
To: Xiu Jianfeng <xiujianfeng@huaweicloud.com>
Cc: lizefan.x@bytedance.com, hannes@cmpxchg.org, mkoutny@suse.com,
	shuah@kernel.org, joshua.hahn6@gmail.com, cgroups@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
	xiujianfeng@huawei.com
Subject: Re: [PATCH -next] selftests/cgroup: Fix compile error in test_cpu.c
Message-ID: <Zw3AE90cH8g8Blx4@slm.duckdns.org>
References: <20241011061153.107208-1-xiujianfeng@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241011061153.107208-1-xiujianfeng@huaweicloud.com>

On Fri, Oct 11, 2024 at 06:11:53AM +0000, Xiu Jianfeng wrote:
> From: Xiu Jianfeng <xiujianfeng@huawei.com>
> 
> When compiling the cgroup selftests with the following command:
> 
> make -C tools/testing/selftests/cgroup/
> 
> the compiler complains as below:
> 
> test_cpu.c: In function ‘test_cpucg_nice’:
> test_cpu.c:284:39: error: incompatible type for argument 2 of ‘hog_cpus_timed’
>   284 |                 hog_cpus_timed(cpucg, param);
>       |                                       ^~~~~
>       |                                       |
>       |                                       struct cpu_hog_func_param
> test_cpu.c:132:53: note: expected ‘void *’ but argument is of type ‘struct cpu_hog_func_param’
>   132 | static int hog_cpus_timed(const char *cgroup, void *arg)
>       |                                               ~~~~~~^~~
> 
> Fix it by passing the address of param to hog_cpus_timed().
> 
> Fixes: 2e82c0d4562a ("cgroup/rstat: Selftests for niced CPU statistics")
> Signed-off-by: Xiu Jianfeng <xiujianfeng@huawei.com>

Applied to cgroup/for-6.13.

Thanks.

-- 
tejun

