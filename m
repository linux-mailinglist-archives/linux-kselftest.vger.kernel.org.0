Return-Path: <linux-kselftest+bounces-20453-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5EFF9AC9E0
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Oct 2024 14:19:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F3C091C23E1E
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Oct 2024 12:19:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D98DD1AB6F1;
	Wed, 23 Oct 2024 12:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aDCbbNn/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A765619E99E;
	Wed, 23 Oct 2024 12:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729685971; cv=none; b=V9yIdljXUQMdE30urXapaPZcwHCT99+ZqZ8+18YxyGt1vaAk+ZoL0gwqXv9aQy4RnAgorFhUChuOF7wXDN8NyCKJGZTHduT4nkyJ5+4Hz1+whGA4pbI9MJ6ubiXslJkAm2UAwgiJMwQqE3L7co3NvPswXnrxNe/jwRDourXI/Ps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729685971; c=relaxed/simple;
	bh=Nel0teWPYV2DMRNkXDa1Z7k3Fl+vQmZbSDgEzb3yCgA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=awzo0ygOZ/sU85dmfoZbP+sOoTFDHdRx0ACXl1lunfysdf02picpbnHsDnbxBMd8DN79tRmg7y1LrVtdXUYH8hm2h5ZeAuI+fB4xzVb1EkXtlT9HSQT4obMR0EFAwc6MZzdEGwIabnVbPtFL+wnBIkgPV9pBzCd/DV6atghUw2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aDCbbNn/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 857D2C4CEC6;
	Wed, 23 Oct 2024 12:19:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729685971;
	bh=Nel0teWPYV2DMRNkXDa1Z7k3Fl+vQmZbSDgEzb3yCgA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aDCbbNn/kjW1k/LhjKlIjA++Na4cYYO4NvKJNHR9kQyafDU00+2yvsKUEsgFpoFFS
	 E/CFZW5Tsq/ZsfSgWqLYnOcdrF0iMbKvEhbZA1B0hERNF4q46xLkKd4+IUhtCiyQOq
	 WjRwl2676HBq7eOCgQxVdlWBH1UXObsg1jkAuHt6fHLjPFUMU22DzZtAjR56x+0rmj
	 QwTnHqSVZhbI86S2NQgBbUZUFL//Ha50SAcCW/y0GCAKExUVbzFIzOWHqYkS941Gp2
	 DzjP8EwL8eP3eHgDlaj2cfFsVLTx3uLhRDleZ0lzdC1GcpwFmh2CvyoAH0b7rtoB97
	 h9+3CYG8MwSWA==
Date: Wed, 23 Oct 2024 13:19:26 +0100
From: Simon Horman <horms@kernel.org>
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>,
	Geliang Tang <geliang@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Gregory Detal <gregory.detal@gmail.com>,
	Shuah Khan <shuah@kernel.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net 3/3] selftests: mptcp: list sysctl data
Message-ID: <20241023121926.GR402847@kernel.org>
References: <20241021-net-mptcp-sched-lock-v1-0-637759cf061c@kernel.org>
 <20241021-net-mptcp-sched-lock-v1-3-637759cf061c@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241021-net-mptcp-sched-lock-v1-3-637759cf061c@kernel.org>

On Mon, Oct 21, 2024 at 12:25:28PM +0200, Matthieu Baerts (NGI0) wrote:
> Listing all the values linked to the MPTCP sysctl knobs was not
> exercised in MPTCP test suite.
> 
> Let's do that to avoid any regressions, but also to have a kernel with a
> debug kconfig verifying more assumptions. For the moment, we are not
> interested by the output, only to avoid crashes and warnings.
> 
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>

I am assuming that we are ok with expanding test coverage via net,
which FWIIW, does seem reasonable to me.

Reviewed-by: Simon Horman <horms@kernel.org>

...

