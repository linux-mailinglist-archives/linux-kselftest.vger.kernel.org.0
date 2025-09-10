Return-Path: <linux-kselftest+bounces-41082-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D223B5097F
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Sep 2025 02:03:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D6DCD561331
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Sep 2025 00:03:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5005CA921;
	Wed, 10 Sep 2025 00:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MlRqfTHH"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26BC910F2;
	Wed, 10 Sep 2025 00:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757462605; cv=none; b=nmnfME0rzDnRWmrtJEV8zd4C7YJl1O4ENOqPW5luOEir1tayanRxEjVwA/0LN2/NzWVFK1otbzip7tQPmCTA6sWAk9aqj+MC9jzuuAnOC/UV7oJ7sGof6CAoATTw8FoiNqVPiTa9ev6b8rNthDBAfDSvqevHpjrj2qBxa0nVe6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757462605; c=relaxed/simple;
	bh=GwntTzkwKFk0XVbU9OiZglFwS+VRzCQQ+Oc2UE4ksQk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tdWebEkOOCGGwhOWcYIxCyohTUxdoYE2HlDW0tuYtguAd1rWMWCSIueIeF1l46ObpUnKjx2B3eW3VHg5WGGnCL2sE67ADtrdPBZCK+2LJ6CnYSyM1nZB54BcJ5a59DJ8OeZqNvxynLTMiALYt4/8+jYVnq13ixNwVwuROaLTDak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MlRqfTHH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38536C4CEF7;
	Wed, 10 Sep 2025 00:03:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757462604;
	bh=GwntTzkwKFk0XVbU9OiZglFwS+VRzCQQ+Oc2UE4ksQk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=MlRqfTHH/HUqsRZAyCyEBOdxepdRZ8F8GfsKfrfytw2zttbPOBN5gSM8WmbecrqRY
	 29yIQP8aeh48qTyUfluDBC/d9KOjWG4wgEoPCelWMC0zAh6IBJTkS89lSnkxOpag7a
	 fAQHZKBAIj293O5X+hx3FQrB48UJ6WOP8si8hqFLOqPTT3ug24OMbsA4M/zCElvWxG
	 M93fuA7oIdRjhvSFXUOiZNJwzJWOxBe5Oe6GgHXrfqSdmHAHVLPjSNTfS50xje3y3W
	 ndQIIYxEDUSkmAJSTpZmY/d0b8elE7xWpQ45JfTyxWxubPdjwxY41h67OujItm8pzF
	 Iv74k22+X2MCQ==
Date: Tue, 9 Sep 2025 17:03:23 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: David Ahern <dsahern@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 shuah@kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next v2] selftests: net: replace sleeps in
 fcnal-test with waits
Message-ID: <20250909170323.5b0dbcc0@kernel.org>
In-Reply-To: <263f7204-6f5b-4bbc-8c05-222cdb04fb15@kernel.org>
References: <20250908200949.270433-1-kuba@kernel.org>
	<20250909153346.4fa8c369@kernel.org>
	<263f7204-6f5b-4bbc-8c05-222cdb04fb15@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 9 Sep 2025 16:59:28 -0600 David Ahern wrote:
> > This makes some ping tests fail.
> > 
> > https://netdev-3.bots.linux.dev/vmksft-net/results/289602/129-fcnal-other-sh/stdout
> > https://netdev-3.bots.linux.dev/vmksft-net/results/289602/128-fcnal-ipv6-sh/stdout
> > 
> > I only tested with debug kernels, but the non-debug get upset.
> > I'll resend just the wait_local_port_listen changes. If the change
> > gets more complex it's probably good to separate them out in the first
> > place.  
> 
> That is surprising to me. I will take look tomorrow.

Thanks! FWIW I repro'd one with "pause on fail" enabled and trying 
to ping manually also wasn't working. Something odd.

