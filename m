Return-Path: <linux-kselftest+bounces-30497-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B14E6A851C4
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Apr 2025 04:54:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 280DF7AEC23
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Apr 2025 02:53:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E73027BF91;
	Fri, 11 Apr 2025 02:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KI9TVVpf"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CCCD347C7;
	Fri, 11 Apr 2025 02:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744340082; cv=none; b=TraAem+ZCfVa7wNshJwW95Xq/HBbFd6x+k26PdAnu/AXXA4xi4SfB25EWM+RQgupcJpXB6wktia+AXfz/aZjrxD7oIl1CD0VSegHTXJpeeGhfhdQUz6IRMkLSMO3q8EPsDgNAnx48+IRqRP2Wex7Hl1uKjxOkfyL9QWTPwNjt74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744340082; c=relaxed/simple;
	bh=Kj630UcPeGWaDB3XzRiRfg5UFlo6vctTLIVOGFTwTJ8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Tt8A672WMSGc7e2UItlrTPj5ao6dL2tbbKPlNaODPpR2/IZlSovYuHj5jyVgN00U2zDZclUy3oP9jBX83E6mZHtb77y1ZuA4BSp5k4XQttH5m5WX8Ie/NBIo7XOpc6ddjN4TCkd/YHz5YJzS3ApmcnjmFplQbe/K67MOJr7iYRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KI9TVVpf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E80AC4CEDD;
	Fri, 11 Apr 2025 02:54:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744340081;
	bh=Kj630UcPeGWaDB3XzRiRfg5UFlo6vctTLIVOGFTwTJ8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=KI9TVVpf/y5TEay5tHqFH7V7Biol4zFduwdUy09wcbugxBslHq3oErASwuXcHuG9K
	 feVpmWLh4oPy/pTqlyBUKi2WogI3+OslP3IPDipQ3EoJ9Fvav++vXl0rD06IgwD9uo
	 gl8T+q8YroGd5/ghVUhWCp4TQkC75NAhUXDrnLg9GcVK5Y71be8Kv92j/ekDF3bxOk
	 FAAK4xIdVC/s7GyncgeWmXMP5HAQ889IGIEy0/QHgd6gnGfQqFz0kfgxjc3UzTPAY/
	 SxlAQm5fnnZPJVlOIJpfRGudYAWki/00Ry6BMflMtWvrKKAq5A2DwZjE+Vychj9NFJ
	 35mlYWtYIzkcw==
Date: Thu, 10 Apr 2025 19:54:40 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Antonio Quartulli <antonio@openvpn.net>
Cc: netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Donald Hunter <donald.hunter@gmail.com>, Shuah Khan
 <shuah@kernel.org>, sd@queasysnail.net, ryazanov.s.a@gmail.com, Andrew Lunn
 <andrew+netdev@lunn.ch>, Simon Horman <horms@kernel.org>,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, Xiao Liang
 <shaw.leon@gmail.com>, steffen.klassert@secunet.com,
 antony.antony@secunet.com
Subject: Re: [PATCH net-next v25 01/23] net: introduce OpenVPN Data Channel
 Offload (ovpn)
Message-ID: <20250410195440.3ba7ba0f@kernel.org>
In-Reply-To: <20250407-b4-ovpn-v25-1-a04eae86e016@openvpn.net>
References: <20250407-b4-ovpn-v25-0-a04eae86e016@openvpn.net>
	<20250407-b4-ovpn-v25-1-a04eae86e016@openvpn.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 07 Apr 2025 21:46:09 +0200 Antonio Quartulli wrote:
> +static int ovpn_netdev_notifier_call(struct notifier_block *nb,
> +				     unsigned long state, void *ptr)
> +{
> +	struct net_device *dev = netdev_notifier_info_to_dev(ptr);
> +
> +	if (!ovpn_dev_is_valid(dev))
> +		return NOTIFY_DONE;
> +
> +	switch (state) {
> +	case NETDEV_REGISTER:
> +		/* add device to internal list for later destruction upon
> +		 * unregistration
> +		 */
> +		break;
> +	case NETDEV_UNREGISTER:
> +		/* can be delivered multiple times, so check registered flag,
> +		 * then destroy the interface
> +		 */
> +		break;
> +	case NETDEV_POST_INIT:
> +	case NETDEV_GOING_DOWN:
> +	case NETDEV_DOWN:
> +	case NETDEV_UP:
> +	case NETDEV_PRE_UP:
> +	default:
> +		return NOTIFY_DONE;
> +	}

Why are you using a notifier to get events for your own device?

> +	return NOTIFY_OK;
> +}

> +MODULE_DESCRIPTION("OpenVPN data channel offload (ovpn)");
> +MODULE_AUTHOR("(C) 2020-2025 OpenVPN, Inc.");

Companies can't author code, only people. Note that MODULE_AUTHOR()
is optional.

