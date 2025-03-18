Return-Path: <linux-kselftest+bounces-29372-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CA8A6A67AD9
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Mar 2025 18:27:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2106D1899F7A
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Mar 2025 17:24:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC93B211491;
	Tue, 18 Mar 2025 17:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q24G8Iwj"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 783731D8A16;
	Tue, 18 Mar 2025 17:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742318672; cv=none; b=ZahPB5VwrWXdh02DEFejXt1DkNXozCakzQVfdusSNoGNQ2q7kBLi7tJPmnzNVfAoZjHVSUNN8NYIyUGE8TSxUirrxJ000BZUY2Y8dnejenL9eaPIncQCNXd8x6/PdhGYD6FoPtqHVgb1xg3g14zM/X2f1jpKEx5sFtKHZJChaYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742318672; c=relaxed/simple;
	bh=Duflyqz9wZdKo3NrQMhDO+J9gXLA+wLO6XkL+b25jrE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hwHqQy+jqJF/6mrqJexpdNNYAbKbk9Xyr1omhA/wkoHhRTGSceBJ4Tk2UsjOF0jxu1YQSjyKu70pK2mHbSOSzxp2xbBPULo2n7kXSfJ1gfip2V38NU6LmOMOyAb9XE9SwbtopNJ7l9Ziyz5rnH5hpvQek9XMdkbPfm6rWtWHw58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q24G8Iwj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53443C4CEDD;
	Tue, 18 Mar 2025 17:24:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742318671;
	bh=Duflyqz9wZdKo3NrQMhDO+J9gXLA+wLO6XkL+b25jrE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Q24G8IwjQ0xSUuTsxswIqkQjub4t1ISIF15+RSmNHachWnUa8DgrnDqm3SWwWGvzP
	 wE+EBljVz+Yt6U4+RVycgCieLd+2ILMi8D+OOr6Sz5nNuShI4046QioECukimS2omh
	 2/0JDuz6+GmQW+swJfDP8V6ygK9xt+wB6UWBTGtx2AA6pV+T38PJyAEfAbUzhKTxz2
	 N29HgvzFJz42PjqFhd3OWMUdiJOjg+OfIh6LzmcaDOYmI4UUW6Utzl+SoANh1fORwy
	 1IuvKsyGGzSHOxCnv+CIJotP0QlWKCYPgHlzHxg2dR1H+uTQz/ewLV0mTdDQqeZJzW
	 /fFNf5f748MMg==
Date: Tue, 18 Mar 2025 17:24:27 +0000
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
Subject: Re: [PATCH net-next 09/12] mptcp: sysctl: map path_manager to pm_type
Message-ID: <20250318172427.GN688833@kernel.org>
References: <20250313-net-next-mptcp-pm-ops-intro-v1-0-f4e4a88efc50@kernel.org>
 <20250313-net-next-mptcp-pm-ops-intro-v1-9-f4e4a88efc50@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250313-net-next-mptcp-pm-ops-intro-v1-9-f4e4a88efc50@kernel.org>

On Thu, Mar 13, 2025 at 11:20:58AM +0100, Matthieu Baerts (NGI0) wrote:
> From: Geliang Tang <tanggeliang@kylinos.cn>
> 
> This patch maps the newly added path manager sysctl "path_manager"
> to the old one "pm_type".
> 
> 	path_manager   pm_type
> 
> 	"kernel"    -> MPTCP_PM_TYPE_KERNEL
> 	"userspace" -> MPTCP_PM_TYPE_USERSPACE
> 	others      -> __MPTCP_PM_TYPE_NR
> 
> It is important to add this to keep a compatibility with the now
> deprecated pm_type sysctl knob.
> 
> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>

Reviewed-by: Simon Horman <horms@kernel.org>


