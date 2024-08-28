Return-Path: <linux-kselftest+bounces-16585-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DDDDC96304C
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 Aug 2024 20:42:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 93A1C1F25596
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 Aug 2024 18:42:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0DBE1ABEBB;
	Wed, 28 Aug 2024 18:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ILB9lcFp"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E8431AB505;
	Wed, 28 Aug 2024 18:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724870485; cv=none; b=Nn+d0PR+xZninwU7GLc/Z2lj2PdBy9BzTeCWkubnlOQkHhTerQVpV0WItzntXaK7Q4b4MaWE7MvJQALLDmJRwOAZdM3YoQIiI7L8xNWi+1rjJXjS0Un6TSJORwP9a0WAeljl+Bw6wuXdmhNn9YIRaKwL3Lq7HBusY+jvWAPIrDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724870485; c=relaxed/simple;
	bh=f20amj+s0/bexxQtJX76YR40SPUSVEd+adyEhx6Xr8I=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=grRp3QPh/6bLvj/0lCTFhioivSmV4PnnkYG8CT2drHMtDILjJXvgiAi433XqrVTVnOO+9PbPlMJ/ZjRWu0Rwqd2EOECrBjuMz6TLDeEdv05vckZ3KQZMChvHUe/dfr9zeubCNt9S7w+DNbkxjjuALDtwMnv1o0E3YfEl9cYR+xU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ILB9lcFp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F2A5C4CEC0;
	Wed, 28 Aug 2024 18:41:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724870485;
	bh=f20amj+s0/bexxQtJX76YR40SPUSVEd+adyEhx6Xr8I=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ILB9lcFp4DDErX8hKzQgAFnizMdChmDUpJYxEqDzM42VPj7hla/7HtsX/y9uNPkuP
	 hz/lEIaroKiOmltQSyUMCAUS4Eg64zC7L29GSEaLc8cn24fQKmEjr7GU60BIZ5imt4
	 18XCxi1m/XzrxGA79+Ktc+qnJQ/06YSNWEdgEIRvVESxDX8F25yDN2L6NvbHvMR8Cv
	 Pynzvlz1I30j/1WdgQGaX6KhxbOWvg2IGYNnjN1l8JIUoPsavD2FsyFACYPqfLFfKR
	 VXLwIDG2EXEktnEs8vSn2uz6dZht/gzLE7qxv3Wk81I6cuQiJndF9zTnDZsPG/+iHr
	 mpPeHnLq4TDCQ==
Date: Wed, 28 Aug 2024 11:41:23 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: fw@strlen.de, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, Pablo Neira Ayuso <pablo@netfilter.org>, Jozsef
 Kadlecsik <kadlec@netfilter.org>, David Ahern <dsahern@kernel.org>, Shuah
 Khan <shuah@kernel.org>, rbc@meta.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, netfilter-devel@vger.kernel.org, "open
 list:NETFILTER" <coreteam@netfilter.org>, "open list:KERNEL SELFTEST
 FRAMEWORK" <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH nf-next v3 1/2] netfilter: Make IP_NF_IPTABLES_LEGACY
 selectable
Message-ID: <20240828114123.3c85a9a5@kernel.org>
In-Reply-To: <Zs88pbEadxLWLLbn@gmail.com>
References: <20240827145242.3094777-1-leitao@debian.org>
	<20240827145242.3094777-2-leitao@debian.org>
	<20240828074240.2abaa74c@kernel.org>
	<Zs88pbEadxLWLLbn@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 28 Aug 2024 08:05:09 -0700 Breno Leitao wrote:
> On Wed, Aug 28, 2024 at 07:42:40AM -0700, Jakub Kicinski wrote:
> > On Tue, 27 Aug 2024 07:52:40 -0700 Breno Leitao wrote:  
> > > +++ b/tools/testing/selftests/net/config  
> > 
> > You gotta check all the configs, net is now fine, but bpf still breaks.
> > There may be more configs we don't use in CI.  
> 
> Sure, how can I find which configs I should care about?

There are various configs in the tree. Grep for the configs you convert
from select to depends on, they will all need updating.

