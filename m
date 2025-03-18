Return-Path: <linux-kselftest+bounces-29374-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BEF43A67ACE
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Mar 2025 18:26:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A99A37ABC54
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Mar 2025 17:25:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D8E7213E61;
	Tue, 18 Mar 2025 17:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e/uvRB5K"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AFC62139CB;
	Tue, 18 Mar 2025 17:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742318700; cv=none; b=iebrHgbgMgTp2C8wDMWmFIMKBbvpCLW/JQyxKV7abINprIECmmT9kZBCBsVGT6ZU+9cErVOwE41a34MrgoHbuc6GDh5u8AVfLkpdY71g3iugZjmz5YdJdfgFUYXq0z1gh8dGBwATrPX1SAJmrtvsEV2wLPjrQwcELXpxRjdyUqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742318700; c=relaxed/simple;
	bh=Hvyl8hZ/ioz+ygtnw5qd1uFyiRmasSSOn7978P9TNuI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RRhIKHjY9YtjE1RgOnPpZIKwQiX9/EJZ8Zm1SB1KV4ogZthDAqilj2Xe09xKHohsAUIdB7Kqr0iaP8JBQh48Sym6I3tIL4KSHaL3JtzO9o8B5z9XqCrAkH5ki+Ydcrr592MxIZJNilcHBitFwBtUYQDsNHZfBaAETiUXvfVcOaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e/uvRB5K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FF76C4CEE9;
	Tue, 18 Mar 2025 17:24:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742318700;
	bh=Hvyl8hZ/ioz+ygtnw5qd1uFyiRmasSSOn7978P9TNuI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=e/uvRB5KvUlKh0AwjzcmQ6vOHfLLk3Z/lQtKEkXbxK30DOAIW2JTlRXtsuyhpX1pb
	 A5MiojaWFrGqr2W0cs/x2m/muBNCFE9Ys50WOEzZXw/EP8SXn32Dc4lSudFaXPZq3z
	 kV+fJW/10iU6OtN5z8/88DAP/uu8F+nekVgZF8LNww5AUCjWxqVV92F+5tFQlgALPM
	 DT1qtuaR3OKsliF1y77I9/Jq1mDrxhaOjdPr4MwhMAyNMKFHLziV7I9nzQMAtFYUqH
	 DsCnzcjXRHEctaDAqgfhZAY0AK3BPNRMw4/uusGIEZvMBnQoV3qlxU4PBd/PMDiEzR
	 IKKabSy5Zr8EA==
Date: Tue, 18 Mar 2025 17:24:55 +0000
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
Subject: Re: [PATCH net-next 11/12] mptcp: sysctl: add available_path_managers
Message-ID: <20250318172455.GP688833@kernel.org>
References: <20250313-net-next-mptcp-pm-ops-intro-v1-0-f4e4a88efc50@kernel.org>
 <20250313-net-next-mptcp-pm-ops-intro-v1-11-f4e4a88efc50@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250313-net-next-mptcp-pm-ops-intro-v1-11-f4e4a88efc50@kernel.org>

On Thu, Mar 13, 2025 at 11:21:00AM +0100, Matthieu Baerts (NGI0) wrote:
> From: Geliang Tang <tanggeliang@kylinos.cn>
> 
> Similarly to net.mptcp.available_schedulers, this patch adds a new one
> net.mptcp.available_path_managers to list the available path managers.
> 
> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>

Reviewed-by: Simon Horman <horms@kernel.org>


