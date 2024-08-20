Return-Path: <linux-kselftest+bounces-15734-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 546C0957A85
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 Aug 2024 02:41:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 855B11C23121
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 Aug 2024 00:41:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 513306125;
	Tue, 20 Aug 2024 00:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C2G3yR4I"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 243DF4C79;
	Tue, 20 Aug 2024 00:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724114482; cv=none; b=m4Z+O6Y5c8ax++dIHdWifbR69kS9UhIWONwcP7svCUIXwpDhmItOTWqNDn1NeOueEzDLTCATE8K0Ca9QX29IpObZ5rQIQlcjiergCNOfK0C1bC9NcUNFKtFT0GxKrnQYhjiW7uFJxi8BfiS/wcnxdal3WffjS/oUWtvEu4vOUuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724114482; c=relaxed/simple;
	bh=7ZAfzDGUNcXNJn5ngLAJ6iXDIPggDG1icW/5xfzffoQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=houi0TT9Z705cSJS9/upGhQuSe55hXKGYOMYL1HJhaodQ4eer7qkyljJTTgZn9i9Uuk5HUkOkYcjfkFr3XFbmTBNoFTGkgjJaMjVBj/oDkhACpDAtew0aYeEHD2RD3ON+AOZEdPFFTa5twoTsO+ZqZELIp1RoR4ugtnCkq5vVr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C2G3yR4I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53BB2C32782;
	Tue, 20 Aug 2024 00:41:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724114481;
	bh=7ZAfzDGUNcXNJn5ngLAJ6iXDIPggDG1icW/5xfzffoQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=C2G3yR4I1wCwdl0UWQKU23/Yx+w8ishc3y3WmePfM8tz7qL3367yttA7kfNYO3/et
	 LQhGHDySICmHfeSnsvh9ty3LY7clzaF5i5+LJfe2AA199Ksh0ffvDru/5J5d1MdBe9
	 WjZSyFSkrSsxoI6sqqnBQHngzvu3uV0i/tW5i5TSspAPimeOpupqUYRzNNlbfmaZaA
	 rAarWTRLq58b9D+TmOwlOL/W7dK6Ty4VGQcaQmpJo6moB1cLDO+iTATAlHNZNZrJYR
	 iPHURZbLV/rFWvSGEqLh4/dZCPLRFycVxvlc+NaqBzN6TGBJR4X6s9DXQHxsJYJxbT
	 8+mpz3uQZ1SIA==
Date: Mon, 19 Aug 2024 17:41:20 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Ido Schimmel <idosch@idosch.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, shuah@kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next] selftests: net: add helper for checking if
 nettest is available
Message-ID: <20240819174120.2e544a2e@kernel.org>
In-Reply-To: <ZsIb2joq2MjBwk1u@shredder>
References: <20240817183848.658443-1-kuba@kernel.org>
	<ZsIb2joq2MjBwk1u@shredder>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 18 Aug 2024 19:05:46 +0300 Ido Schimmel wrote:
> Nice improvement. fib_rule_tests.sh can also benefit from this helper
> and so does vrf_route_leaking.sh which assumes 'nettest' is available
> in the working directory.
> 
> Do you want to fold the diff below into v2 (I tested it)?

Perfect! I left fib_rule_tests.sh out because its helper looked nicer
than the one copy pasted into all other scripts :) and it skips.
Shouldn't matter too much in practice, indeed.

