Return-Path: <linux-kselftest+bounces-10337-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 70B9B8C82CB
	for <lists+linux-kselftest@lfdr.de>; Fri, 17 May 2024 10:55:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2731A1F215AC
	for <lists+linux-kselftest@lfdr.de>; Fri, 17 May 2024 08:55:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DC6E14003;
	Fri, 17 May 2024 08:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Eu9VoAKw"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 447838BF7;
	Fri, 17 May 2024 08:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715936097; cv=none; b=oINjblqZQyrgItslxFuLYk1qDf69T+lI1LvTpJbV7PKQZi+Wrg9Dpcved1PHwADZRsHXLFRvgqGVW+QseN4Te6EXNT4ngJFLhzaFTgf3WefH8Vo7UV0jx/SpCNVrt1tK5rAXf5/c76s66upT3tXplRg2WbxmQpOEAAFXudN3uuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715936097; c=relaxed/simple;
	bh=Xog/tS5vq+lgeG72Uoo6J9glCxSk0h/9CurO3SylIhE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pN+PEa5r8z/YTC6WEH4QEhRhxeH53x8YoDGYk2H6D7Mwiz6HVlPAGBn+pU4GVRnKJU1x7begm7DZdUgUwLQCVdRFXufZ48MihRVWomn+Tyt9IdeMp7LT5+Z8RVaAHsqJmL63oXYmvpoicNaDkTsw3t0yUezG40T++TTnpmtc75E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Eu9VoAKw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAB0FC2BD10;
	Fri, 17 May 2024 08:54:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715936096;
	bh=Xog/tS5vq+lgeG72Uoo6J9glCxSk0h/9CurO3SylIhE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Eu9VoAKw6f2oTSBALK1w42rV42/v/ppmD/OGZ7/GYrc3zPmhBDIL9Z/KNHFOTXFvr
	 RucdJymM6BqmwGyZCdaBD3/x77ExQmBbvfGA1TjmuM40NYD884qdhBqnZ1Yu1st/uJ
	 MAfnFmBIVy7L7tyPe2mUPDVSJPEMwHuYmYwYYQeMRD86lLvk80bc3wsbCaCT42VefA
	 n5t6M04EaVBQUAsCPCMGmevqqghddIlv44JuI1zEvrUqqBqnTQIMMEr+iFHwezEsIs
	 EqpkMLhx5BdCCcjigCt650+aVGeLgA1i8cEqdeCtns3Aua8VwISCSSrWca79tPJGWA
	 IBLru1NTFUp2A==
Date: Fri, 17 May 2024 09:54:52 +0100
From: Simon Horman <horms@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, liuhangbin@gmail.com, shuah@kernel.org,
	linux-kselftest@vger.kernel.org, Petr Machata <petrm@nvidia.com>,
	vladimir.oltean@nxp.com
Subject: Re: [PATCH net v3] selftests: net: local_termination: annotate the
 expected failures
Message-ID: <20240517085452.GC443576@kernel.org>
References: <20240516152513.1115270-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240516152513.1115270-1-kuba@kernel.org>

On Thu, May 16, 2024 at 08:25:13AM -0700, Jakub Kicinski wrote:
> Vladimir said when adding this test:
> 
>   The bridge driver fares particularly badly [...] mainly because
>   it does not implement IFF_UNICAST_FLT.
> 
> See commit 90b9566aa5cd ("selftests: forwarding: add a test for
> local_termination.sh").
> 
> We don't want to hide the known gaps, but having a test which
> always fails prevents us from catching regressions. Report
> the cases we know may fail as XFAIL.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

I agree that XFAIL is appropriate for cases like this - the test
is expected to fail and this can act like a TODO.

I also looked over how xfail_on_veth works and this usage seems
correct to me.

Reviewed-by: Simon Horman <horms@kernel.org>

