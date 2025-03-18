Return-Path: <linux-kselftest+bounces-29369-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 371F5A67AD4
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Mar 2025 18:26:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5239F3BDD82
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Mar 2025 17:23:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02AC720F078;
	Tue, 18 Mar 2025 17:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hNfLKZsj"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C54E61AB50D;
	Tue, 18 Mar 2025 17:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742318621; cv=none; b=l+FVYBLjN1iuZvx7EeC+sIQ1CwbwtKiULGFFmRSg1Ybw3jnIIrkamPPJI8tDpfByJ5ME9Y2ux35I/h+qdpFl536jnTcHBrSF0eprA3h6x7ehExl7o0htbgTgn3qMhbRO23bGlc4OInBLCUb20hdrH+3C1CrWlzxBmADE7v9sZ2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742318621; c=relaxed/simple;
	bh=RI785bwfL26wMO4CUNkVeNM811WfC7XiykyLr68ziJw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pf9M5cVVmJ77ST1IHyFC0r3CaBkgrurZ5yllaciaYG8yUJnbDJhEDtUOCH+RC0tba4MeSnQixci6LAHKXR3KWSzDwwd+0H3O2GHSa9wMKxstnEmR4axiO32s/gI+Gjer90hWLS07+ywINaTBlwN+3oUte9cjpwAdZ6kYkew2Xug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hNfLKZsj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 070C6C4CEDD;
	Tue, 18 Mar 2025 17:23:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742318621;
	bh=RI785bwfL26wMO4CUNkVeNM811WfC7XiykyLr68ziJw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hNfLKZsj0n02+Hf31+0mUjUX+hDLASM3B1vNiygqWjeEJpFDbGOv9nxA6SiNYsrwJ
	 01PGlsLJ98Cf7KSCQukr0KNDaGOU3Fo7p1iEDDfSiO6QMS3cLrXHUpxeOTM2hUVUA4
	 h4rQoLeHbyCNmRf+iwSy7W9CszyJ7R4ZOY7wGO97wMA8NnmoBUCbvqhnUjMKPXpQ/C
	 rGVa04haeNP9gbsmWIouSZwEH8s307PUZf2XEH3RnmZWXKGaffZW9+eFkWvR3MRsAD
	 RvAlDKHuoJBUnjHlf8EjxlQvfMaN+s5V/K47d/RfAgSFWKdBwQJ6XqOsd1lr8t69N5
	 iXu1DAAjwRFyA==
Date: Tue, 18 Mar 2025 17:23:37 +0000
From: Simon Horman <horms@kernel.org>
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>,
	Geliang Tang <geliang@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next 06/12] mptcp: pm: define struct mptcp_pm_ops
Message-ID: <20250318172337.GK688833@kernel.org>
References: <20250313-net-next-mptcp-pm-ops-intro-v1-0-f4e4a88efc50@kernel.org>
 <20250313-net-next-mptcp-pm-ops-intro-v1-6-f4e4a88efc50@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250313-net-next-mptcp-pm-ops-intro-v1-6-f4e4a88efc50@kernel.org>

On Thu, Mar 13, 2025 at 11:20:55AM +0100, Matthieu Baerts (NGI0) wrote:
> From: Geliang Tang <tanggeliang@kylinos.cn>
> 
> In order to allow users to develop their own BPF-based path manager,
> this patch defines a struct ops "mptcp_pm_ops" for an MPTCP path
> manager, which contains a set of interfaces. Currently only init()
> and release() interfaces are included, subsequent patches will add
> others step by step.
> 
> Add a set of functions to register, unregister, find and validate a
> given path manager struct ops.
> 
> "list" is used to add this path manager to mptcp_pm_list list when
> it is registered. "name" is used to identify this path manager.
> mptcp_pm_find() uses "name" to find a path manager on the list.
> 
> mptcp_pm_unregister is not used in this set, but will be invoked in
> .unreg of struct bpf_struct_ops. mptcp_pm_validate() will be invoked
> in .validate of struct bpf_struct_ops. That's why they are exported.
> 
> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>

Reviewed-by: Simon Horman <horms@kernel.org>


