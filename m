Return-Path: <linux-kselftest+bounces-29364-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2680A67AAF
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Mar 2025 18:21:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 41B78169DB0
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Mar 2025 17:20:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 974D220F077;
	Tue, 18 Mar 2025 17:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="egPWR3Kn"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6339619F489;
	Tue, 18 Mar 2025 17:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742318416; cv=none; b=RujN+3XoslUsPvzHJSI9N+biJUBFCHBaCjlrmKFJ9FRpChVBduaOHi0sY5HrifW4tj9oluYWcxCQFu8AM1fM5BkmEPQbHc21em5/IHFHL+WPC78FIjkjy+q+AnrROrui8vaDZurrXu6rpG3ypdzQ6w+2mZaryP/6fjT2sbG7pkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742318416; c=relaxed/simple;
	bh=B8WfSdBHs4NoolEROlvmKmppn8bwVFeQLvcCjFB4rfM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TA1UenUKVMhy8CvZ8k+9cNIpDwA//Trnn18EWy95F0PYYyXvzJ+DqZ3yetZSLMlizkoHbs/IO3jT77AXnldQoKpG6cW700iuyRzXtZ0X6KwcCoauRb+U+d8CnBcS3U1Xsj8VDAePYKBXkYxp2ITCdXwuBQVK/BELGbnUEx/JnAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=egPWR3Kn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DE1AC4CEDD;
	Tue, 18 Mar 2025 17:20:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742318414;
	bh=B8WfSdBHs4NoolEROlvmKmppn8bwVFeQLvcCjFB4rfM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=egPWR3KnkaFtrgBztVzHkRzGcXP5ZAGdg4xQH/WXmhIMscedKiRJ0169tIEgTkS0h
	 6F2//dPxqQ08zj4L3ByOtJfCOVbaOVUTHi5a2Kg5Go7OSyKb11yfv9wM/Lzk++Pm/7
	 Wa0poOxrulMV8wH1CbeP85elu73V2WCqo1oTlGcQTPsYsX56V+qpnTPc6HXvOLl93f
	 Du4ooUc5FWlnyn/79lQnL+OliV6rs4Q52vQvXX3BePV4b/FSscujiGteMfUoe3kHfH
	 gQ5p6h0gfIHGJxN09haSfKjW1BIk00Qbq9L9YihfJkiJssZYqAwW5T7O15K7kZ9hk9
	 lhe/VDHB099Kw==
Date: Tue, 18 Mar 2025 17:20:10 +0000
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
Subject: Re: [PATCH net-next 01/12] mptcp: pm: split netlink and in-kernel
 init
Message-ID: <20250318172010.GF688833@kernel.org>
References: <20250313-net-next-mptcp-pm-ops-intro-v1-0-f4e4a88efc50@kernel.org>
 <20250313-net-next-mptcp-pm-ops-intro-v1-1-f4e4a88efc50@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250313-net-next-mptcp-pm-ops-intro-v1-1-f4e4a88efc50@kernel.org>

On Thu, Mar 13, 2025 at 11:20:50AM +0100, Matthieu Baerts (NGI0) wrote:
> The registration of mptcp_genl_family is useful for both the in-kernel
> and the userspace PM. It should then be done in pm_netlink.c.
> 
> On the other hand, the registration of the in-kernel pernet subsystem is
> specific to the in-kernel PM, and should stay there in pm_kernel.c.
> 
> Reviewed-by: Mat Martineau <martineau@kernel.org>
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>

Reviewed-by: Simon Horman <horms@kernel.org>


