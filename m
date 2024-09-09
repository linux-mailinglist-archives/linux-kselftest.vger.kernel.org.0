Return-Path: <linux-kselftest+bounces-17532-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D68E97205C
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Sep 2024 19:23:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 75B47B23576
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Sep 2024 17:23:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77801172773;
	Mon,  9 Sep 2024 17:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dXm+dTgt"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F5CC1865C;
	Mon,  9 Sep 2024 17:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725902590; cv=none; b=pEVh3j4v1nd24L3dS02WPkojiRbqwGobPXCdVbl/b3CUTcFnFLrSiaa9sL6VCpa8D2hq+lq52tlSToOAd2EZ66zyc689zfTQzfMatbiIfshe9aQ+mh7JNRKpPmI6Q7QEuv2WX/X5Q9WzIDicr1JIZ9ErPZ5WsQ8awa3vif5/6co=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725902590; c=relaxed/simple;
	bh=ARNE1GoRCaGtDrcWy2PA91FxDv3h5Zk21Xfzd0I6xyg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NYuyDUFmxPrjXLO5FK3TcrJwLKgx9JCI2qX3TYJ8gsRY29YoTqNZwoQd7s2w+CesZZQdriJ+SkC8kTG63DIndnSeGwHZLRQuzbFOndfzRuUZj8zazQ8fA2GcNFs+tgx3UiwKkShqglX49yCKs424ZP3KxJPgeyx2KG6i76dcuG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dXm+dTgt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB212C4CEC5;
	Mon,  9 Sep 2024 17:23:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725902590;
	bh=ARNE1GoRCaGtDrcWy2PA91FxDv3h5Zk21Xfzd0I6xyg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=dXm+dTgtHsr3YlzpW2tEHgnowVws6yR3gLCxCBxNaJ2FCEXGlJL8STEKQtyRKnoxJ
	 Rb1D5MUWwexUYx+nEGRikZRGtqDodBpXRVFEyEyM/M/iHS27FRQxJc0LBlTwzaFXlN
	 beqYSd4KFNTjgLbAF5tHwUsKt5fdjW9uw4K6wo15XteUaK44eV6S4xPXoflcoYPEMJ
	 AMUDnPN1VNOTpAWFGusA/U1PBze6HePvxAYLinDtrXqKx0rm2ybcyfTZryMIwVOJwY
	 G3d8e2IkaEpaBTYPZb4ZRlZTQeAa4a4rIL85/ZLg73d27vpDprpxN2FRRcgRmOPPAz
	 7aaAD+nN0A1jQ==
Date: Mon, 9 Sep 2024 10:23:09 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: willemdebruijn.kernel@gmail.com
Cc: Jason Xing <kerneljasonxing@gmail.com>, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, shuah@kernel.org,
 willemb@google.com, linux-kselftest@vger.kernel.org,
 netdev@vger.kernel.org, Jason Xing <kernelxing@tencent.com>
Subject: Re: [PATCH net-next v2] selftests: return failure when timestamps
 can't be reported
Message-ID: <20240909102309.3da82583@kernel.org>
In-Reply-To: <20240905160035.62407-1-kerneljasonxing@gmail.com>
References: <20240905160035.62407-1-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri,  6 Sep 2024 00:00:35 +0800 Jason Xing wrote:
> When I was trying to modify the tx timestamping feature, I found that
> running "./txtimestamp -4 -C -L 127.0.0.1" didn't reflect the error:
> I succeeded to generate timestamp stored in the skb but later failed
> to report it to the userspace (which means failed to put css into cmsg).
> It can happen when someone writes buggy codes in __sock_recv_timestamp(),
> for example.

Willem, thoughts?

