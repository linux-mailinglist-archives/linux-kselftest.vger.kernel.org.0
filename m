Return-Path: <linux-kselftest+bounces-29370-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3127A67ACC
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Mar 2025 18:26:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D5E0442088F
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Mar 2025 17:24:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CC7320FA84;
	Tue, 18 Mar 2025 17:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="exu3qugX"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF6F11AB50D;
	Tue, 18 Mar 2025 17:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742318638; cv=none; b=q73FLR1KK6cxC2/sBBq57O2hILr/+P+s/HklDTTrY5gpe0smBHxOX59K8f6WfehysIBRqlLSK+78SCvfv0GS1CzpQ71KtFyEBxXFbimyFvU9dIV0eU2dPnNDghzjfgYrdzsSNAc+UuBq8tXnjau7I11Y7rjqBlKsx+YAfK3kvP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742318638; c=relaxed/simple;
	bh=oYgsRQEefgUr0DZZ9uTp8h/FL8SXH1Hl72e6vYpvfP4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oE/4nWbcCv8S+znR/cjp/1qmSpn+lJ1eDHdXndzhy/z7e5O4K9V7q7EiRqcRSgPsYZ5hgPsPQctPW04XeP5NQDGnQW/vdPBHTNvXhVxiYfshdFIwl15U+ZKDOaa34/i0rcd6YgbJUj6mqWDG80Ekq74+F2Bc9JmIjSKCl7JdA0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=exu3qugX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5D7DC4CEDD;
	Tue, 18 Mar 2025 17:23:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742318637;
	bh=oYgsRQEefgUr0DZZ9uTp8h/FL8SXH1Hl72e6vYpvfP4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=exu3qugX9zxockqKYp/ZeCJKxJd/Lkv/ipC6IKvko4k3owSbeV2F0X2/s7ARvDgO3
	 FUKdk/hvajkvj/JC/RKNTJH9XuYwt9s1Y64jOq01EyKoln9mFprnFvHPPqHi0ihtnQ
	 iSm/8sbhoWkSf/IsVzZicu+tmQRJS3PwvcyMhXRQCJwVSTVca20sOxyacW2BjE2nj9
	 ITcnnNKKDFsARAGv2W1VIy+Sx4hkDUJPwWLRsBA/lqkx8Lqb/1xYoxAHbKcZfFwGnS
	 u4FjObgT2iEFkijGWwhpJ4/BBaQn2qwLqkbgjWvm+ulWd2WRb75lALRxLoUTcgbFUB
	 RCKqc5RyEua3Q==
Date: Tue, 18 Mar 2025 17:23:52 +0000
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
Subject: Re: [PATCH net-next 07/12] mptcp: pm: register in-kernel and
 userspace PM
Message-ID: <20250318172352.GL688833@kernel.org>
References: <20250313-net-next-mptcp-pm-ops-intro-v1-0-f4e4a88efc50@kernel.org>
 <20250313-net-next-mptcp-pm-ops-intro-v1-7-f4e4a88efc50@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250313-net-next-mptcp-pm-ops-intro-v1-7-f4e4a88efc50@kernel.org>

On Thu, Mar 13, 2025 at 11:20:56AM +0100, Matthieu Baerts (NGI0) wrote:
> From: Geliang Tang <tanggeliang@kylinos.cn>
> 
> This patch defines the original in-kernel netlink path manager as a
> new struct mptcp_pm_ops named "mptcp_pm_kernel", and register it in
> mptcp_pm_kernel_register(). And define the userspace path manager as
> a new struct mptcp_pm_ops named "mptcp_pm_userspace", and register it
> in mptcp_pm_init().
> 
> To ensure that there's always a valid path manager available, the default
> path manager "mptcp_pm_kernel" will be skipped in mptcp_pm_unregister().
> 
> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>

Reviewed-by: Simon Horman <horms@kernel.org>


