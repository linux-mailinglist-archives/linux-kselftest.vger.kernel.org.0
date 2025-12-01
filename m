Return-Path: <linux-kselftest+bounces-46861-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 265E0C99830
	for <lists+linux-kselftest@lfdr.de>; Tue, 02 Dec 2025 00:05:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 199814E1B6D
	for <lists+linux-kselftest@lfdr.de>; Mon,  1 Dec 2025 23:05:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4616E286410;
	Mon,  1 Dec 2025 23:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EySsHka1"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 152F3200110;
	Mon,  1 Dec 2025 23:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764630312; cv=none; b=MeWmMEUUD72FoFa+Nvw1O60FWiQjrvpzyB5GukE7lGsyTnRw7J+1JZj/MCA6x1gyH4p6Wxrso1GziAtcc5vACF+i/imOZyHppIt4f0okGluuhLEJLjiE9uG1D3jA8qw49K7c3HADHwdVSGeW0PfvElgqq8T0Ji2nI8omN2uxTE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764630312; c=relaxed/simple;
	bh=+RwdZzAxVA6x5/ldXNRxGJfwfndyYVCm7OwfFpRdce0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tBNQUxDtAYZJj8jQ9A89l/WXsq7kDaGBqkqHKPywXrLHE8C/qsu53QtQ6Lh1+gAYlBjpOCoILWb3tUEvJIOD+G6jTl/FKETBDDJm4VGnoNzvZyn9Q0hUI69QB5m66u5FT5l5jDy19/ElWsLPxek1cvjJKeWzc6ACTRDRcxJemZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EySsHka1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58E86C4CEF1;
	Mon,  1 Dec 2025 23:05:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764630311;
	bh=+RwdZzAxVA6x5/ldXNRxGJfwfndyYVCm7OwfFpRdce0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=EySsHka1wYUk7NkXPmW4y/vX+DwSxu3o7dZOI3+z7Ghe8EmbpwLuO7HHRsN7lwKN+
	 rfdTf4XtggqLYDrCV0JtT0qvsrMtRa1wY+wXqFrnIql/DLpwJ4KXKg3n3vo/+SqbKp
	 LZsxt1Rphkxg48fMhGk+I+Rg4ucsFRVfXy2JLUUXL5ncWFnYaHfaZMU9Z9U5pTx9gS
	 GxlInJ0+hjJuenWwRhipkERPPRUGLGxMWQ+5sFbjRF7a4MxJ7y/Dl7R6SvFELA66Jw
	 bg1X1WQuhjGipOoz5SztV8pYY/e4EiqWfKMmdQqIprJAnSkXjCDWcrbvk+JFtpMBz+
	 AOPYDAl2avm1A==
Date: Mon, 1 Dec 2025 15:05:09 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: chia-yu.chang@nokia-bell-labs.com
Cc: pabeni@redhat.com, edumazet@google.com, parav@nvidia.com,
 linux-doc@vger.kernel.org, corbet@lwn.net, horms@kernel.org,
 dsahern@kernel.org, kuniyu@google.com, bpf@vger.kernel.org,
 netdev@vger.kernel.org, dave.taht@gmail.com, jhs@mojatatu.com,
 stephen@networkplumber.org, xiyou.wangcong@gmail.com, jiri@resnulli.us,
 davem@davemloft.net, andrew+netdev@lunn.ch, donald.hunter@gmail.com,
 ast@fiberby.net, liuhangbin@gmail.com, shuah@kernel.org,
 linux-kselftest@vger.kernel.org, ij@kernel.org, ncardwell@google.com,
 koen.de_schepper@nokia-bell-labs.com, g.white@cablelabs.com,
 ingemar.s.johansson@ericsson.com, mirja.kuehlewind@ericsson.com,
 cheshire@apple.com, rs.ietf@gmx.at, Jason_Livingood@comcast.com,
 vidhi_goel@apple.com
Subject: Re: [PATCH v7 net-next 00/13] AccECN protocol case handling series
Message-ID: <20251201150509.6cd9fefc@kernel.org>
In-Reply-To: <20251201163800.3965-1-chia-yu.chang@nokia-bell-labs.com>
References: <20251201163800.3965-1-chia-yu.chang@nokia-bell-labs.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  1 Dec 2025 17:37:47 +0100 chia-yu.chang@nokia-bell-labs.com
wrote:
> Plesae find the v7 AccECN case handling patch series, which covers
> several excpetional case handling of Accurate ECN spec (RFC9768),
> adds new identifiers to be used by CC modules, adds ecn_delta into
> rate_sample, and keeps the ACE counter for computation, etc.
> 
> This patch series is part of the full AccECN patch series, which is available at
> https://github.com/L4STeam/linux-net-next/commits/upstream_l4steam/

Linux tagged 6.18 final, so net-next is closed for new code submissions
per the announcement at
https://lore.kernel.org/20251130174502.3908e3ee@kernel.org
-- 
pw-bot: defer

