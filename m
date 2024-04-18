Return-Path: <linux-kselftest+bounces-8312-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 25FC38A9841
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Apr 2024 13:09:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A56ABB21251
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Apr 2024 11:09:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0E6815E218;
	Thu, 18 Apr 2024 11:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KKvUkZSx"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B93AC15B969;
	Thu, 18 Apr 2024 11:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713438589; cv=none; b=JW1+7kexRr+H0+yyjtpERL0715HbZ93W+xuhcYmlWehU0Gyru8s4l6Enn1MX9xfz7ePvN6vg/z1jFJglG7iEO9sOxTg7TXN/3VjAvakp/6uQK2WUcm2JzfElov/7tNINnUyP1b+rYXT/NuFCQ1VIwtCzMIBP1pT1xlh3IVZOjIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713438589; c=relaxed/simple;
	bh=qAVKH5tsIDe303O+jpYWLvoR3uryyXnhLGmBfvK6Sfs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D14BCp/FzW71zENpypBMcKb4kuB3PMv9EmwhjllrLYvbqIhDh20NqdteBky3r6BJwl7ylPJn0suZqQfM5NqD6M7WDNDcbGSUe5MuXiOsWQhepbOmqKbr5LbLtVbFsMfoAmBabzyA23zU/dNotprm85YC0IL3+7c1+7Lbir7t0oM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KKvUkZSx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1A3FC113CC;
	Thu, 18 Apr 2024 11:09:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713438589;
	bh=qAVKH5tsIDe303O+jpYWLvoR3uryyXnhLGmBfvK6Sfs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KKvUkZSxIQH4UmDHhzSMcuu7UGv7MuzSYjv8V4LgPrSJSIPi57BdvCkFvrTPwkNwU
	 1+gr4Wd1g1TMksHqWhTgNPRlDrE7MQT/uanqvMquHOxFGDgrntq1dM5HmKjxrSPkja
	 TGDh7fmgpEA6KXK4IqHBX0iolafWMWnP2opwxE99BUrpHI+To42oFoA6SSJbQu7WM/
	 82M0ALw9cST/t6z1h/XhcOkYqxxz1hDNbM7WeDbpdtzgDF0W4+MC61cA5cTaQzvVpX
	 i9AothM4dMaXqawcI/+1KrK3/uPAzR3DlejzKaHkSGuuMWM6gnn7QvlUdZVdTV6K/N
	 htRtY+UUGCZRg==
Date: Thu, 18 Apr 2024 13:09:45 +0200
From: Christian Brauner <brauner@kernel.org>
To: Nathan Chancellor <nathan@kernel.org>, 
	Adrian Reber <areber@redhat.com>
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: tools/testing/selftests/clone3/clone3_set_tid.c appears to
 always pass?
Message-ID: <20240418-hiebe-bahnt-066312cb324b@brauner>
References: <20240417152222.GA1517581@dev-arch.thelio-3990X>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240417152222.GA1517581@dev-arch.thelio-3990X>

On Wed, Apr 17, 2024 at 08:22:22AM -0700, Nathan Chancellor wrote:
> Hi Christian,
> 
> I am looking at tools/testing/selftests/clone3/clone3_set_tid.c as part
> of a patch to clean up the uses of 'return ksft_exit_...();' throughout
> the selftests (as they call exit() so they do not return) and I noticed
> that it seems to always pass even when there may have been an error?
> 
>       if (waitpid(ns_pid, &status, 0) < 0) {
>           ksft_print_msg("Child returned %s\n", strerror(errno));
>           ret = -errno;
>           goto out;
>       }
> 
>       ...
>   out:
>       ret = 0;
> 
>       return !ret ? ksft_exit_pass() : ksft_exit_fail();
>   }
> 
> Should the ret and out label positions be switched? Alternatively, it
> seems like ret and out do not have that many uses, perhaps it would just
> be better to call the ksft_exit_...() directly in their respective
> paths? I am not going to touch it as part of my patch but I felt it was
> worth reporting since it appears to have been there since the
> introduction of this test in commit 41585bbeeef9 ("selftests: add tests
> for clone3() with *set_tid").

Uh, good point. Let me Cc the original author.

