Return-Path: <linux-kselftest+bounces-30605-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CB31BA85FFE
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Apr 2025 16:07:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8FFC84632D0
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Apr 2025 14:06:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F4BD1F2367;
	Fri, 11 Apr 2025 14:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CiI5UjVI"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E213F8635A;
	Fri, 11 Apr 2025 14:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744380363; cv=none; b=eupo5RfB0gE22583xkGFIZFjwV99Jk/tYLjCKrBxhPNr9+2UbcUnOQ4Dss5W7K+lOWGH+d1dgciRQOUL5ZyCdyz9PU6f7hSrGc8PUQLe88izcRjbl86XkZP4EVNgW4jO+V22GYINkTyTQaT31ssB84c8ZrblT7w+nOSfQRVVoTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744380363; c=relaxed/simple;
	bh=HlikJyA3RK/we9R2FRAkqQszIW7QLL+7TnR3hFlO3p8=;
	h=Message-ID:Subject:From:To:Cc:In-Reply-To:References:Content-Type:
	 MIME-Version:Date; b=IbE1oKrbpBwj47u+ivqpbRLMZNxWYwZpqjcCx8hXLSnybXHLQQ+2Sh4UCxcGyQX3WLIA4TdZJBLQxsSeTijsRqcbcmAUHAX6RYgYILM2xGseprZ318K7llgjoAKBvQj83xFVmXN5I3BqVWSQXgUijuiw4YPY/6M+MCIGZbI7EuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CiI5UjVI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC75AC4CEE2;
	Fri, 11 Apr 2025 14:05:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744380362;
	bh=HlikJyA3RK/we9R2FRAkqQszIW7QLL+7TnR3hFlO3p8=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date:From;
	b=CiI5UjVI7wphAZSfd37O9uqQOvJAKY/aFXR68AI0sSamvYzff1Y7ICpnCiBARwqBS
	 e/PD3XhTxshajAoIHmgt1x20FRASYm6tF0W5rAveYgVU3aFJ9Vef6wRSFpaxZfaiQQ
	 hJ3IgZNzKdN7odI2VMzTsjM6zxME045mlw/5w4gV1YiUdEowJQ49gQBCax22ddNIw1
	 w27iN0wFSMhA0DJg0zYL0z66gdIfMncNL0N9+adRIHDY2ERW/GhiJiMMZqjuiHAJ8L
	 Sbn4t7uLSnRnOzM1Ub/lirc/SwLC1nCnDSjwkW1h1tbVVmQ768Zn4lVU83v8jmG3P6
	 QkgrvA4OLOZXA==
Message-ID: <1fb5a9e97e97b86c8b0d6008eee579a0bebea708.camel@kernel.org>
Subject: Re: [PATCH net-next 2/8] mptcp: sched: split validation part
From: Geliang Tang <geliang@kernel.org>
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, mptcp@lists.linux.dev, 
 Mat Martineau <martineau@kernel.org>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet	 <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni	 <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, Shuah Khan	 <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
In-Reply-To: <20250411-net-next-mptcp-sched-mib-sft-misc-v1-2-85ac8c6654c3@kernel.org>
References: 
	<20250411-net-next-mptcp-sched-mib-sft-misc-v1-0-85ac8c6654c3@kernel.org>
	 <20250411-net-next-mptcp-sched-mib-sft-misc-v1-2-85ac8c6654c3@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 11 Apr 2025 09:57:39 -0400
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Content-Transfer-Encoding: 8bit

Hi Matt,

On Fri, 2025-04-11 at 13:04 +0200, Matthieu Baerts (NGI0) wrote:
> From: Geliang Tang <geliang@kernel.org>

Please update my email as "Geliang Tang <tanggeliang@kylinos.cn>" here
and in patch 7, otherwise, CI will complain that the email address
after "From: " is different from that after "Signed-off-by: ".

Thanks,
-Geliang

> 
> A new interface .validate has been added in struct bpf_struct_ops
> recently. This patch prepares a future struct_ops support by
> implementing it as a new helper mptcp_validate_scheduler() for struct
> mptcp_sched_ops.
> 
> In this helper, check whether the required ops "get_subflow" of
> struct
> mptcp_sched_ops has been implemented.
> 
> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> Reviewed-by: Mat Martineau <martineau@kernel.org>
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> ---
>  net/mptcp/protocol.h |  1 +
>  net/mptcp/sched.c    | 17 +++++++++++++++--
>  2 files changed, 16 insertions(+), 2 deletions(-)
> 
> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> index
> d409586b5977f93bff14fffd83b1d3020d57353b..7aa38d74fef6b5f00d97a114d74
> b711014d0a52d 100644
> --- a/net/mptcp/protocol.h
> +++ b/net/mptcp/protocol.h
> @@ -744,6 +744,7 @@ void mptcp_info2sockaddr(const struct
> mptcp_addr_info *info,
>  			 struct sockaddr_storage *addr,
>  			 unsigned short family);
>  struct mptcp_sched_ops *mptcp_sched_find(const char *name);
> +int mptcp_validate_scheduler(struct mptcp_sched_ops *sched);
>  int mptcp_register_scheduler(struct mptcp_sched_ops *sched);
>  void mptcp_unregister_scheduler(struct mptcp_sched_ops *sched);
>  void mptcp_sched_init(void);
> diff --git a/net/mptcp/sched.c b/net/mptcp/sched.c
> index
> f09f7eb1d63f86b9899c72b5c2fd36c8445898a8..1e59072d478c9b52c7f7b60431b
> 589f6ca3abe65 100644
> --- a/net/mptcp/sched.c
> +++ b/net/mptcp/sched.c
> @@ -82,10 +82,23 @@ void mptcp_get_available_schedulers(char *buf,
> size_t maxlen)
>  	rcu_read_unlock();
>  }
>  
> +int mptcp_validate_scheduler(struct mptcp_sched_ops *sched)
> +{
> +	if (!sched->get_send) {
> +		pr_err("%s does not implement required ops\n",
> sched->name);
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
>  int mptcp_register_scheduler(struct mptcp_sched_ops *sched)
>  {
> -	if (!sched->get_send)
> -		return -EINVAL;
> +	int ret;
> +
> +	ret = mptcp_validate_scheduler(sched);
> +	if (ret)
> +		return ret;
>  
>  	spin_lock(&mptcp_sched_list_lock);
>  	if (mptcp_sched_find(sched->name)) {
> 


