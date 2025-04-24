Return-Path: <linux-kselftest+bounces-31590-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6957A9B57D
	for <lists+linux-kselftest@lfdr.de>; Thu, 24 Apr 2025 19:38:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9F02C7B930D
	for <lists+linux-kselftest@lfdr.de>; Thu, 24 Apr 2025 17:37:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BB8E28E617;
	Thu, 24 Apr 2025 17:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E2gIiRDg"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E072A28B50F;
	Thu, 24 Apr 2025 17:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745516173; cv=none; b=ZNkJJ0JKoh5eI8388j+HNv+LMfkjx9/9XhwQs+ZuM/MZaoxFrDu/FWj5/7tPj5tBPNri/NTowTA9MEphVzD72F4yEN9mrgMFZWMWbxH0h6tCHRo3jbk5vid5u3rVm7qKS8mOB6aw3MRa0JFYRL8kku1DUshur9SYBXHJ5P94PyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745516173; c=relaxed/simple;
	bh=LXwnnz906d1xYC1VPscfzjQaP1ILzKuqIOE7J7H2BE4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ebLK0Z/kgch6LKbuUVg0kyoaCoO9P5vPgUr0ZgREkvh/fMbiofmPBI+NHwo87cRa+N8Yf9eAC1U90VgzYWOqoM1zVGyr0vzggGWTD8DC2LU2ffdPf+NlyHnu5IWfwzIM8x+CuvoxaQx1jCAhUyEoBZQBNHaS5RED3CVZQ026hBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E2gIiRDg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A2A5C4CEE3;
	Thu, 24 Apr 2025 17:36:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745516172;
	bh=LXwnnz906d1xYC1VPscfzjQaP1ILzKuqIOE7J7H2BE4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=E2gIiRDg2CldVcrOjV9LGHtDUQ3be3aAfogJdjMryL4Z+kbzUckehRTBiw6cez4K1
	 rK+VIPAxBsND7yVR9FGxRq4nCa2Xkm6NzvGLumQM/OR4hYKU+XaElpliX+NOUgPjuP
	 CKUSh71eLXfrgUrEgPHt75u0a47t/vdP3w5td/v5oKqNLn23ZtEROMo917Gf4r47B+
	 pEh1dmoV787l6TyYLOcshL8VX62Vf946AjFMnwsXzc3mqX3iizeXREpZRayvSlQfXB
	 LrqA0rgcZlITPr4GREkLjv//LY4z9yBdR19rRtx+633DQIdKaE64Hyh5kxmAXP2AiR
	 j3+w5OKgE06CQ==
Date: Thu, 24 Apr 2025 18:36:05 +0100
From: Simon Horman <horms@kernel.org>
To: chia-yu.chang@nokia-bell-labs.com
Cc: dsahern@kernel.org, kuniyu@amazon.com, bpf@vger.kernel.org,
	netdev@vger.kernel.org, dave.taht@gmail.com, pabeni@redhat.com,
	jhs@mojatatu.com, kuba@kernel.org, stephen@networkplumber.org,
	xiyou.wangcong@gmail.com, jiri@resnulli.us, davem@davemloft.net,
	edumazet@google.com, andrew+netdev@lunn.ch, donald.hunter@gmail.com,
	ast@fiberby.net, liuhangbin@gmail.com, shuah@kernel.org,
	linux-kselftest@vger.kernel.org, ij@kernel.org,
	ncardwell@google.com, koen.de_schepper@nokia-bell-labs.com,
	g.white@cablelabs.com, ingemar.s.johansson@ericsson.com,
	mirja.kuehlewind@ericsson.com, cheshire@apple.com, rs.ietf@gmx.at,
	Jason_Livingood@comcast.com, vidhi_goel@apple.com
Subject: Re: [PATCH v5 net-next 00/15] AccECN protocol patch series
Message-ID: <20250424173605.GL3042781@horms.kernel.org>
References: <20250422153602.54787-1-chia-yu.chang@nokia-bell-labs.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250422153602.54787-1-chia-yu.chang@nokia-bell-labs.com>

On Tue, Apr 22, 2025 at 05:35:47PM +0200, chia-yu.chang@nokia-bell-labs.com wrote:
> From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
> 
> Hello,
> 
> Plese find the v5:
> 
> v5 (22-Apr-2025)
> - Further fix for 32-bit ARM alignment in tcp.c (Simon Horman <horms@kernel.org>)
> 
> v4 (18-Apr-2025)
> - Fix 32-bit ARM assertion for alignment requirement (Simon Horman <horms@kernel.org>)

Thanks, I confirm that v6 appears to be clear wrt these
build checks for 32-bit ARM assertion for alignment requirements.

...

