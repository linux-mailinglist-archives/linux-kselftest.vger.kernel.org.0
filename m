Return-Path: <linux-kselftest+bounces-41081-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 04D23B50956
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Sep 2025 01:46:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 216D71C20A4D
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Sep 2025 23:46:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 083C82848BF;
	Tue,  9 Sep 2025 23:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZTYzjFWr"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D25A7223337;
	Tue,  9 Sep 2025 23:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757461561; cv=none; b=VHwyIZmQO+9QC1zPnADgC8eY36iZP4Hha5bNARu00eiNx9VqTyONteNJFQEuMZd2d3rbqT/zF5T/JBrrV4YfF8eI98FrCY38y1RfncNHyr33lXd2psf6RNpYpYBI1oqGKi2B5/GqLdoRXaMY/er1Thh9BcytxUXRXzQK3MK9ndw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757461561; c=relaxed/simple;
	bh=7OopFAuQ9uCUpxzXKtKBIkITwWzO1Xn89zHsYdpatlg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ni1F6eH4kgLKrEREhrx8ngs8KCphtSshlT2p6G535NFQRXYHbG3X399oIu2MvGl6TB6pY1IZRtjCh88dBr1p/fLuVEu1ct4A71Q7Xl4ch2L4E1dseg3XPNaJDsKZCtn0Ydnq9blkceiHWRAlxY0/j91mPP5sN30lqF31Xm0NTbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZTYzjFWr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28B65C4CEF4;
	Tue,  9 Sep 2025 23:46:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757461561;
	bh=7OopFAuQ9uCUpxzXKtKBIkITwWzO1Xn89zHsYdpatlg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ZTYzjFWr1Ii4BKa9rgmif1OpgXi1Nybp9NafkfcLdPZII2IKmlb2Iifm5H8bDCqFP
	 SIvJQIKVbyK8HXK1Pn8/ZV+CREZTj4oYyptW8CYECbzDueKKxrtjBH1SNtB8ShNrGd
	 PWQ1XNmShavUXzzgp3Zj2Js5W0Sw3pTZqqPPWcMhElM1o4vPE7eQjHjIsoTr3P+ZYi
	 Y3Q6OaHvL6UHExOs27xmQWAEUwFOS9dSDW1WiUsXx6EBEg3oQrQXpcSvcDgC5t29LU
	 EOwG4/Oo/Vr4vNC0K31f8zE+Xxs7r85GRReB34ub2UR0zbKdaEi2eoclLfSv7ihQw2
	 Rr6ys+jhvQR/w==
Date: Tue, 9 Sep 2025 16:46:00 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: netdev@vger.kernel.org, Jay Vosburgh <jv@jvosburgh.net>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon
 Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>,
 linux-kselftest@vger.kernel.org
Subject: Re: [PATCHv2 2/2] selftests: bonding: add vlan over bond testing
Message-ID: <20250909164600.04aa44c7@kernel.org>
In-Reply-To: <20250908062802.392300-2-liuhangbin@gmail.com>
References: <20250908062802.392300-1-liuhangbin@gmail.com>
	<20250908062802.392300-2-liuhangbin@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  8 Sep 2025 06:28:02 +0000 Hangbin Liu wrote:
> Add a vlan over bond testing to make sure arp/ns target works.
> Also change all the configs to mudules.

Why are you switching everything to module?
The series needs to go to net, we should avoid unnecessary cleanups.
And I think changing the config is unrelated to the selftest so it
should be a standalone patch in the first place?
-- 
pw-bot: cr

