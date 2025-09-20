Return-Path: <linux-kselftest+bounces-41985-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E28B3B8BB45
	for <lists+linux-kselftest@lfdr.de>; Sat, 20 Sep 2025 02:49:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE551560426
	for <lists+linux-kselftest@lfdr.de>; Sat, 20 Sep 2025 00:49:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 142E8442C;
	Sat, 20 Sep 2025 00:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FdaZb5cO"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D97624A01;
	Sat, 20 Sep 2025 00:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758329344; cv=none; b=h9xHDCm9GO660OCq1xPY+4q2o1D/LRIg4tv9rbOGRnAHlxjvxLWS98LRqAtlqEWQ9bFJt7FtaDmJqf+dCuYEOPvjleJxvnIFOzs/YfaZLYPBvHUlgRvco+7Lj7SpzHDaaK1W6lPMjrfNpk7ncp33Nl+VRruB3igneabG3w6Ykek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758329344; c=relaxed/simple;
	bh=NDobZDXYvqCc1iQozpOOdSereN/nm18wHLtDe88nNRo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NtSavLrti6X3W7o/Tu7TzF5fM6ez3UeoJximQ9wuuNoNEVVkB4GCYyYCjUlkldT9MrMgSQnzlNRROVaiCoOBVg45ANhaQamm83iIApkKHOwo41Ek80HQEnpHZg1rB/w7m4asGDxvnMirZUSFUvj5zjS9yJyGhRAKiMjtiBQMxvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FdaZb5cO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A48A4C4CEF0;
	Sat, 20 Sep 2025 00:49:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758329343;
	bh=NDobZDXYvqCc1iQozpOOdSereN/nm18wHLtDe88nNRo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=FdaZb5cOxY87VKE+ljLrC2KhRoEhm+bNGHeB3D/nOuSiy/uMyBuGAeeVC1fGvxV6E
	 671ha9iU7Wko0ZD0gwSJ86yxXU/7hwH5P2jtuXxOBwwzpmm/SpkExr3AUz8UKXW6FZ
	 rshEQJAuepbxooy7M/+ba4Ba2ThOOxgFJIrZUhBiL7H9Zvn2r72SheYxAA9wt6nVuW
	 /aQk8OTk2+ULJMSMUstI1SKZhNUWZ7aFhY0mmRETD4BZikXmT4me1QjhXCLS+F7kMc
	 gV7cRLV9NlUAY+jawRwaWsm+Erp21cQMHhTT+Znjc4ixmV60kY2XI4qF1gMLYsOE8x
	 B2y3jEvnCyluA==
Date: Fri, 19 Sep 2025 17:49:01 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>, Simon Horman
 <horms@kernel.org>, david decotigny <decot@googlers.com>,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 linux-kselftest@vger.kernel.org, asantostc@gmail.com, efault@gmx.de,
 calvin@wbinvd.org, kernel-team@meta.com, jv@jvosburgh.net
Subject: Re: [PATCH net v5 4/4] selftest: netcons: add test for netconsole
 over bonded interfaces
Message-ID: <20250919174901.1a6062d7@kernel.org>
In-Reply-To: <20250918-netconsole_torture-v5-4-77e25e0a4eb6@debian.org>
References: <20250918-netconsole_torture-v5-0-77e25e0a4eb6@debian.org>
	<20250918-netconsole_torture-v5-4-77e25e0a4eb6@debian.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 18 Sep 2025 03:42:08 -0700 Breno Leitao wrote:
> This patch adds a selftest that verifies netconsole functionality
> over bonded network interfaces using netdevsim. It sets up two bonded
> interfaces acting as transmit (TX) and receive (RX) ends, placed in
> separate network namespaces. The test sends kernel log messages and
> verifies that they are properly received on the bonded RX interfaces
> with both IPv4 and IPv6, and using basic and extended netconsole
> formats.

I'm not great at reading bash but I don't think this tests what we care
about. We want to test bonding's special ability to propagate a netpoll
instances onto its sub-interfaces. So you should be trying to test
different orders of setting and disabling netpoll on the bond and its
sub-interfaces (while the other is setup path is also active).

Since the bonding tests can't run on real HW it can't live directly in
tools/testing/selftests/drivers/net/ we need to move it to either the
netdevsim group or the bonding group.

