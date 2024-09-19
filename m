Return-Path: <linux-kselftest+bounces-18132-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 793DF97CA48
	for <lists+linux-kselftest@lfdr.de>; Thu, 19 Sep 2024 15:42:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B8FA285E35
	for <lists+linux-kselftest@lfdr.de>; Thu, 19 Sep 2024 13:42:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 394A219E83E;
	Thu, 19 Sep 2024 13:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PLDsHw0C"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04AD319D8BB;
	Thu, 19 Sep 2024 13:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726753325; cv=none; b=KwP6XFuR67bnEBudFw800TNOHzek52HpMnHIb/eciP2nQgLaPWwf+9PGvSlfaGhNgvt7KulSVobgQfrxOMz0KRHRfA9syoq9qyPcRe/bSxBMgb9Wjkwhv0GpVAF2uGMZqNjJFCcGTYrLfcoCvi8jJeUlZHaMXkq8lWP6rprPWOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726753325; c=relaxed/simple;
	bh=jQxDy751b9YjhDzWie/8758VZV89mHLnI1lsChkCIxY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fczqfyrnu3OunZ11PpS8VvWPhEDLVwJRW5jYDwqd8tzq1iXtn0znuh8ooahLXCUKDaZshltutre29AJfImcg5geTunyAIJ7/X5i1C/2Pv/tD6rsjG+rbz0lgWW9vkn0ggI6kpu7DAGmBU+9Fzo5jdF/SPk/dNsMtI/P9MC95FPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PLDsHw0C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A797C4CEC6;
	Thu, 19 Sep 2024 13:42:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726753324;
	bh=jQxDy751b9YjhDzWie/8758VZV89mHLnI1lsChkCIxY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PLDsHw0Cik3DgcQ0IeiK0t5A0uNB19Nz4rjAr7D4wakqScR5BQ9cD+MWZESwXM9iZ
	 HWQ6D35iff5mGdK9rxiJw2S7JjcbCBJxp3YO2qDfflNOY81IAR5NZl2HkIOImIV09L
	 +rRtCO+3olAi03hNlb4OazXfrUrP+mcQg9w0bl1xZIg8m518iU8XopuiJ52dxdJcul
	 XjVaHSoNcUdtTrcIGSiUy4sUYIzZKxPDfihxUTU87ej9hLya5v9z4SMtDzpCDhys1A
	 tZyGIy6BCAy8TQydf/jb3sVIZHxRqARlCmfL6LRqOSEkMI85/GqAFXcY87cC48a9Px
	 4sv9sPdKjt1aA==
Date: Thu, 19 Sep 2024 14:41:59 +0100
From: Simon Horman <horms@kernel.org>
To: Jamie Bainbridge <jamie.bainbridge@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Ido Schimmel <idosch@nvidia.com>, netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2] selftests: forwarding: Avoid false MDB
 delete/flush failures
Message-ID: <20240919134159.GA1571683@kernel.org>
References: <c92569919307749f879b9482b0f3e125b7d9d2e3.1726480066.git.jamie.bainbridge@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c92569919307749f879b9482b0f3e125b7d9d2e3.1726480066.git.jamie.bainbridge@gmail.com>

On Mon, Sep 16, 2024 at 07:49:05PM +1000, Jamie Bainbridge wrote:
> Running this test on a small system produces different failures every
> test checking deletions, and some flushes. From different test runs:
> 
> TEST: Common host entries configuration tests (L2)                [FAIL]
>   Failed to delete L2 host entry
> 
> TEST: Common port group entries configuration tests (IPv4 (S, G)) [FAIL]
>   IPv4 (S, G) entry with VLAN 10 not deleted when VLAN was not specified
> 
> TEST: Common port group entries configuration tests (IPv6 (*, G)) [FAIL]
>   IPv6 (*, G) entry with VLAN 10 not deleted when VLAN was not specified
> 
> TEST: Flush tests                                                 [FAIL]
>   Entry not flushed by specified VLAN ID
> 
> TEST: Flush tests                                                 [FAIL]
>   IPv6 host entry not flushed by "nopermanent" state
> 
> Add a short sleep after deletion and flush to resolve this.
> 
> Create a delay variable just for this test to allow short sleep, the
> lib.sh WAIT_TIME of 5 seconds makes the test far longer than necessary.
> 
> Tested on several weak systems with 0.1s delay:
> - Ivy Bridge Celeron netbook (2014 x86_64)
> - Raspberry Pi 3B (2016 aarch64)
> - Small KVM VM on Intel 10th gen (2020 x86_64)
> All these systems ran 25 test runs in a row with 100% pass OK.
> 
> Fixes: b6d00da08610 ("selftests: forwarding: Add bridge MDB test")
> Signed-off-by: Jamie Bainbridge <jamie.bainbridge@gmail.com>
> ---
> v2: Avoid false check failures as seen by Jakub Kicinski.
> ---

Reviewed-by: Simon Horman <horms@kernel.org>


