Return-Path: <linux-kselftest+bounces-16850-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 97672966979
	for <lists+linux-kselftest@lfdr.de>; Fri, 30 Aug 2024 21:24:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A0091F2147D
	for <lists+linux-kselftest@lfdr.de>; Fri, 30 Aug 2024 19:24:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C820E1BBBE5;
	Fri, 30 Aug 2024 19:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LEL/uP6F"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 978243DBB6;
	Fri, 30 Aug 2024 19:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725045892; cv=none; b=PkpmYgf8AUuohCeIjv72shI7NYQz1RSJpdfDcZDXmOwk03wqSfxbiAe/UVJFDYnELN760ejpYDjD/SbrPYtTkGnlRYXIfMaDlVqMqZctv8ysBb5BdvgE7PBiZtrPa29AJEtRkxSwRLIwJ0a8X6oSjHbCdl0OOozGuv3iFFFACP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725045892; c=relaxed/simple;
	bh=6wy5OUvluFvY1dYnAHEYY9UmwOwWVwM3nMeX75yr0j0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GbzBADEaa9Oizrs4wnQXylqNua/fizd9Wi0xfZMWnxbo0jVEXEWcl6qmL+W/z5uoOMVFFthKggGMYWOE1plYc5WmcO/0rbLYwmwCrswJoBYiuePwvf0QvpRet+CskiPnPUcS386X3/mCOzO+CpuLXLjTZ7RQABJPuM/S3AboWew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LEL/uP6F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D78E8C4CEC2;
	Fri, 30 Aug 2024 19:24:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725045892;
	bh=6wy5OUvluFvY1dYnAHEYY9UmwOwWVwM3nMeX75yr0j0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LEL/uP6FrP0f8rej5pk+hC0IJLBUbG6xXfs8RGUpFbXh2Yj3+OE/gP7ASE+B+eLow
	 r1URH9fFigSb2H3asVTJ0OJDdTpB/9Sci8GlFGp43s+RFtwOX7mlcLFbJHhcEh0Am5
	 tvjVFZNWylYVWbyFdkJdi8feVYP85gbPrhw6cDJ5rbpzmVpHsnCg2o8eQjLozEiQmI
	 egv8DSi8VhKcjMb9WqjEXMrKFfYjHnBAnS52/Y+PotvYyBKvR8nMmu4VT1TKt8AF2h
	 zSAZy9nr3brYjj0qkzvr8u7bN3BeIAommhVpYBfc8cDtbb3MsRu99zQ2/PMlt0nDUZ
	 6vEC2hkw5PJIg==
Date: Fri, 30 Aug 2024 09:24:50 -1000
From: Tejun Heo <tj@kernel.org>
To: Waiman Long <longman@redhat.com>
Cc: Zefan Li <lizefan.x@bytedance.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
	Shuah Khan <shuah@kernel.org>, cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH-cgroup 0/2] cgroup/cpuset: Account for boot time isolated
 CPUs
Message-ID: <ZtIcgpKqtZ89RlT5@slm.duckdns.org>
References: <20240820195536.202066-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240820195536.202066-1-longman@redhat.com>

On Tue, Aug 20, 2024 at 03:55:34PM -0400, Waiman Long wrote:
> The current cpuset code and test_cpuset_prs.sh test have not fully
> account for the possibility of pre-isolated CPUs added by the "isolcpus"
> boot command line parameter. This patch series modifies them to do the
> right thing whether or not "isolcpus" is present or not.
> 
> The updated test_cpuset_prs.sh was run successfully with or without the
> "isolcpus" option.
> 
> Waiman Long (2):
>   cgroup/cpuset: Account for boot time isolated CPUs
>   selftest/cgroup: Make test_cpuset_prs.sh deal with pre-isolated CPUs

Applied 1-2 to cgroup/for-6.12.

Thanks.

-- 
tejun

