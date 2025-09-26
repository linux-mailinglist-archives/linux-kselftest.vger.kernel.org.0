Return-Path: <linux-kselftest+bounces-42472-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02A1BBA3FF2
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 Sep 2025 15:57:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D5FD57AF1AE
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 Sep 2025 13:54:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1FC92FBDF0;
	Fri, 26 Sep 2025 13:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nvM3Urmr"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA2992FAC12;
	Fri, 26 Sep 2025 13:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758894853; cv=none; b=KYbV8/Biw6SKTmu3Ep9Eox09L+O+hZtSftdIP5C4t+A69srKEsSrrnZ8KdaZMFfm4E/dS5NvY3JiqgaG8IIglq0qjjIR4wh+0tInFO/ZAqa0tlcaaZBTvEHyOxvIwz4yHn6BKwani06YX0qGvE5uwqQKfEx9noNmZPxf7Qou6Do=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758894853; c=relaxed/simple;
	bh=reTwJtnJiaFvXZS4w2F+0OxQN0oWrN/MUgp/MOHPUAE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BtEwEZAPaZFN7sr9Mmf7sN5fVb8lNOcYlQWzhCmw6OFVU0tyWdUqh4qu5xL2skqbwtJlisJWvdNeSa6aPV1gbAwfXZ8cyfyrnzPdTtuAAlY0/TNnjjXS3fHWxzZcpbKeuJPZx79PnCl6s6SOAvT88ePTJumSzrrAE6e7H8hMzCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nvM3Urmr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8489FC4CEF4;
	Fri, 26 Sep 2025 13:54:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758894853;
	bh=reTwJtnJiaFvXZS4w2F+0OxQN0oWrN/MUgp/MOHPUAE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nvM3UrmrXxU0NooKLNEexv6iF5/dvimOyTv4SFZN86UmKsjQcbQxRDqxzPoUu7EDa
	 JcxTd8x4fl0MIiQ7yaEmq4THzdQa0SQ9EfRgwf9mY7OCqX6gynVh5EJGW6ewbT1dZC
	 P4k6lFxewTENUzTpYTkMVWykM5Guw+FV7VmTNcVdCFgj4hWzWt3Go75g9H4F4iUY9F
	 AKRjyKPkA17WDKsn5eHHlhIXhevsJnIf/Gu7R/mwC8RogWmPc8KcrJWa8gwF249QrS
	 p8q3OAGVJ/NyrSoUiYTEMfhePAGsEnIWqX4C+nuh2wsmFQVD7PCGGnuMgbnFe8mwJU
	 9j52gHUipxuiQ==
Date: Fri, 26 Sep 2025 14:54:09 +0100
From: Simon Horman <horms@kernel.org>
To: Petr Machata <petrm@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, Ido Schimmel <idosch@nvidia.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
	mlxsw@nvidia.com
Subject: Re: [PATCH net-next 02/13] selftests: net: lib: Rename
 ip_link_set_master() to adf_*
Message-ID: <aNabAUTx8ZPtoFz3@horms.kernel.org>
References: <cover.1758821127.git.petrm@nvidia.com>
 <53ce64231faa1396a968b2869af5f1c0aebec2c9.1758821127.git.petrm@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <53ce64231faa1396a968b2869af5f1c0aebec2c9.1758821127.git.petrm@nvidia.com>

On Thu, Sep 25, 2025 at 07:31:45PM +0200, Petr Machata wrote:
> Rename this function to mark it as autodefer.
> For details, see the discussion in the cover letter.
> 
> Signed-off-by: Petr Machata <petrm@nvidia.com>

Reviewed-by: Simon Horman <horms@kernel.org>


