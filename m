Return-Path: <linux-kselftest+bounces-38745-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5729EB21B7B
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Aug 2025 05:15:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 130CE3A8105
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Aug 2025 03:15:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9169F2D8365;
	Tue, 12 Aug 2025 03:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sp+ResZc"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63E92255222;
	Tue, 12 Aug 2025 03:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754968511; cv=none; b=vDkvox4O7kGI9htBzXcFOhEsd230fPGDpwgGDRzjQBqFhte/QZP/3k9cd0XPazRERndLY87TM1jR0jeCMAuTmFSD2NKZmTLEVNbb7rIq4825VK/hTQPwbNgN/fxlr5sfzo25x6wfFHf5Kh14roU0q5/QuQOBUNjPiPtGu2hoebk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754968511; c=relaxed/simple;
	bh=QAsI2ZjUhYpWwQ0cu73hU8HQPYLWFdr5Bo+h/CHBM9g=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NGa/vG/KNGPiopvjA1c8S4tQWRig4WQ7bdiCtip836X/C/JWTUwNUVc4PIAdRmVyVfPgaK2+PN0Df/yLnaKUKydF+fwMAKsQmUQiLUvaSXsb9ohN7tl11x24/ihCeL3jnq/CezYvmTVbFdbsXyuimN2qoL8kXYbQPCXL9gOTzI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sp+ResZc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D90FC4CEED;
	Tue, 12 Aug 2025 03:15:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754968509;
	bh=QAsI2ZjUhYpWwQ0cu73hU8HQPYLWFdr5Bo+h/CHBM9g=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=sp+ResZcDjifmh8ydmC9MytgG9sKrm7ajwIKu+r1lCOvuLOoQO3MitlZi9YN8K1tH
	 GOeLwq40bYs21Esm9RMDHJnU9B+f+UqiT7WAY5yiR3KqDYewniKptg6d3AAmlKqHJZ
	 Nwl8dBTcgqIhI4nhP9JnuUD5j/pzuRaO2R+dG0i5EIqiUcQ4txahcqZlTOk3z85Uoo
	 xyU+cTNRBo3UYyMcJM9i3WgLHdCw1gKo5tKJNHfocwYfkEV4AuGOCGY4drM0A+bi0T
	 lrQnWRj+55BlUa2xRgUVJ+Jvs+5lw7UaSrLbT6dwrWoe37X2v15wWKR++2XwVO+lz+
	 FVluUlCEVouJg==
Date: Mon, 11 Aug 2025 20:15:08 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: Jay Vosburgh <jv@jvosburgh.net>, netdev@vger.kernel.org, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Nikolay
 Aleksandrov <razor@blackwall.org>, Simon Horman <horms@kernel.org>, Shuah
 Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, David Wilder <wilder@us.ibm.com>
Subject: Re: [PATCH net] bonding: don't set oif to bond dev when getting NS
 target destination
Message-ID: <20250811201508.508a7e3d@kernel.org>
In-Reply-To: <aJqhRXIb3zZutO6H@fedora>
References: <20250811140358.2024-1-liuhangbin@gmail.com>
	<783435.1754922439@famine>
	<20250811093328.70343754@kernel.org>
	<aJqhRXIb3zZutO6H@fedora>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 12 Aug 2025 02:04:53 +0000 Hangbin Liu wrote:
> On Mon, Aug 11, 2025 at 09:33:28AM -0700, Jakub Kicinski wrote:
> > On Mon, 11 Aug 2025 07:27:19 -0700 Jay Vosburgh wrote:  
> > > 	Generically, I'm wondering if test updates should be separate
> > > patches from the functional changes as a general policy.  
> > 
> > Yes, not sure if we made it a hard requirement, but I think it's our
> > preference. It is the reason why we don't require cover letters for
> > submissions with 2 patches.
> > 
> > Hangbin, please update config for bonding tests, looks like vlans 
> > are not enabled there today.  
> 
> BTW, I'd like to change the bond config to modules. Because we can't unload
> the modules with current config. It that OK for you?

Yes. I'm not sure if any of the bonding tests need to load the modules
explicitly but we'll find out :) In general modules are fine for the CI.

