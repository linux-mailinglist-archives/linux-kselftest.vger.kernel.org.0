Return-Path: <linux-kselftest+bounces-34819-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FCD2AD7451
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 Jun 2025 16:44:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EA9257AA31B
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 Jun 2025 14:40:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D756325BF1C;
	Thu, 12 Jun 2025 14:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HeWqqdY5"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5BF825BF02;
	Thu, 12 Jun 2025 14:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749739171; cv=none; b=Pxepq7KvOdRS/5MVEI8+B07RbSCricvuuHbGfuog779wHZAwcOSI2Y5BWtSKWCcgtGoFim7XPs9NScBIC4wWnZ/8Kp2JmAHto6LxtVuQGxo4uOG8xe+F383GOhbNjIn7wqqsLH9/9nKsCVPL3ehXUOKeh+XphnMY7bnYiNtPX+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749739171; c=relaxed/simple;
	bh=oocYYW9XhNGhlIxt3VxA0yDbX+cvu/AYrEHlCDzEaEU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AwJi/vxYgZYtWZhR+vRFnsbxZJN8asC62tfZ5dJZgTbgj6A7btgjPC1owapw0pdCCM3ARfitKvoIMTXpJpdSN74J3cVBh9rk8hZ+q7gRaCe4qZKEJ7LwymL/2ujOgS4zY/EEB3s/pYzPf1gbWLORsLeA1x2Rj8epM7AD4L7fGAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HeWqqdY5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDB59C4CEF7;
	Thu, 12 Jun 2025 14:39:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749739171;
	bh=oocYYW9XhNGhlIxt3VxA0yDbX+cvu/AYrEHlCDzEaEU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=HeWqqdY5vrpn0k5DQvBel2CHEGRBgQDN15MknA6s3IDn1q15iZRQdO9brvYgOw177
	 3MORk3AUrQAElWBebC92T8aK8le5Ne9IOPe3m79od2/iZRTLPjTEACw4dAxWAq0LIl
	 Nbfc58jHNiOieAz6Fsf/6ttOegsKnaYKDds6AVzzqhEAAxCA8xy3ZnwYQYmZ3fnJP8
	 UTaPQwt7hGzhEJQ2KwkG9QfN172sCiD0hPzFBU6c/j1GfBge/+x7BevqT+tFj45XL5
	 AReWpz5axKrG5sfnaHIuUxRCkUiPptVnl1sbtl9Glk15VhXxSu10ho7aSlzNxaa66x
	 3k3A5hLKio1LA==
Date: Thu, 12 Jun 2025 07:39:29 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Stanislav Fomichev <stfomichev@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, skalluru@marvell.com, manishc@marvell.com,
 andrew+netdev@lunn.ch, michael.chan@broadcom.com,
 pavan.chebbi@broadcom.com, ajit.khaparde@broadcom.com,
 sriharsha.basavapatna@broadcom.com, somnath.kotur@broadcom.com,
 anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
 tariqt@nvidia.com, saeedm@nvidia.com, louis.peens@corigine.com,
 shshaikh@marvell.com, GR-Linux-NIC-Dev@marvell.com, ecree.xilinx@gmail.com,
 horms@kernel.org, dsahern@kernel.org, shuah@kernel.org,
 ruanjinjie@huawei.com, mheib@redhat.com, linux-kernel@vger.kernel.org,
 intel-wired-lan@lists.osuosl.org, linux-rdma@vger.kernel.org,
 oss-drivers@corigine.com, linux-net-drivers@amd.com,
 linux-kselftest@vger.kernel.org, leon@kernel.org, Cosmin Ratiu
 <cratiu@nvidia.com>
Subject: Re: [PATCH net-next v3 1/4] udp_tunnel: remove rtnl_lock dependency
Message-ID: <20250612073929.151fe6bf@kernel.org>
In-Reply-To: <aEo_2hOn5kh6kBpk@mini-arch>
References: <20250610171522.2119030-1-stfomichev@gmail.com>
	<20250610171522.2119030-2-stfomichev@gmail.com>
	<20250611184345.3b403ad0@kernel.org>
	<aEo_2hOn5kh6kBpk@mini-arch>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 11 Jun 2025 19:47:54 -0700 Stanislav Fomichev wrote:
> > There are multiple entry points to this code, basically each member of
> > struct udp_tunnel_nic_ops and the netdev notifiers. In this patch only
> > reset and work are locked. I'm a bit confused as to what is the new
> > lock protecting :S  
> 
> I though that most of the callers are from do_setlink and there we have
> rtnl and we grab rtnl+lock during the sync. But that doesn't
> address the suspend/resume vs do_setlink race, that's true :-(

It's the UDP tunnels that add and remove the ports usually.

