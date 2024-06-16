Return-Path: <linux-kselftest+bounces-12023-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 54CE0909E8B
	for <lists+linux-kselftest@lfdr.de>; Sun, 16 Jun 2024 18:29:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F29011F2128D
	for <lists+linux-kselftest@lfdr.de>; Sun, 16 Jun 2024 16:29:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE63E1B806;
	Sun, 16 Jun 2024 16:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bNVtg83X"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A23BE1B27D;
	Sun, 16 Jun 2024 16:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718555366; cv=none; b=Be+bZDovxK5Kl7vGknN4AV/vvBkQTlheyuR+toWKV7STGuBBwlaMM3koQ4K6i//ESCcGh5DIs/UMPw93SfAbez45R7zsJ/thlbqKeTkZC7vXdBPmrA75EIWp/QbXu9bqPrK43mw/66zes9rLpwJXSw9t8tw5r656I6PVN4MeZbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718555366; c=relaxed/simple;
	bh=REIGcrgW0URtti7TofJ3NAJkkr2O7MnOpHLisa5LZNI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PnRY1HB+oak8DUpN3+QX1kZ7E9rqQrryHlx4BGfWR+y5Pb0qZYe8B9nzdVsmq//bm8ApaTLx9t3cB0OvqN32KZyPnLSTtndsGewUMoJFlDm2hI1NbaCHU6ot/NLy0suOquQ69K/gYFfDFXpwM2e/ak6QZKz1JbTll6xg6RpofQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bNVtg83X; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 099FAC2BBFC;
	Sun, 16 Jun 2024 16:29:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718555365;
	bh=REIGcrgW0URtti7TofJ3NAJkkr2O7MnOpHLisa5LZNI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bNVtg83Xk3USn8IcbSB5Lgel/Nq4JGtcF8ymT1k/bT4royLn7uUwkwF1mTaVQ/T02
	 bGpS73hDNecUKG4FhgJlBcAxC14J8RDqxGjt6U9Wyt6rg4tzEJyMMWkeZGUj/5UEi0
	 8FJXrOdftbEoGvhfMd3qNFE5JwZCs8r9oYAB+CUPTN+4xYdT0h5HstrIJN9mE1DDYI
	 e6QzG+O8NqAt8rwQBzfmQmY9cNxLhJSKtrotLSpTHznWwTBxHpoaP0UbQaY3yzKlI9
	 dALhXIgtac/aDLAIP/lNAyMZvDJ9lla6hLSJz0OZzXur1MpwkCHY8MOO8tUfqVWCOF
	 MdvMnrTqhxjDA==
Date: Sun, 16 Jun 2024 17:29:20 +0100
From: Simon Horman <horms@kernel.org>
To: Aaron Conole <aconole@redhat.com>
Cc: netdev@vger.kernel.org, dev@openvswitch.org,
	linux-kernel@vger.kernel.org, Ilya Maximets <i.maximets@ovn.org>,
	Stefano Brivio <sbrivio@redhat.com>,
	Eric Dumazet <edumazet@google.com>, linux-kselftest@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	"David S. Miller" <davem@davemloft.net>
Subject: Re: [ovs-dev] [RFC net-next 2/7] selftests: openvswitch: Refactor
 actions parsing.
Message-ID: <20240616162920.GL8447@kernel.org>
References: <20240613181333.984810-1-aconole@redhat.com>
 <20240613181333.984810-3-aconole@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240613181333.984810-3-aconole@redhat.com>

On Thu, Jun 13, 2024 at 02:13:28PM -0400, Aaron Conole wrote:
> Until recently, the ovs-dpctl utility was used with a limited actions set
> and didn't need to have support for multiple similar actions.  However,
> when adding support for tunnels, it will be important to support multiple
> set() actions in a single flow.  When printing these actions, the existing
> code will be unable to print all of the sets - it will only print the
> first.
> 
> Refactor this code to be easier to read and support multiple actions of the
> same type in an action list.
> 
> Signed-off-by: Aaron Conole <aconole@redhat.com>

Reviewed-by: Simon Horman <horms@kernel.org>
Tested-by: Simon Horman <horms@kernel.org>

