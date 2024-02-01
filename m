Return-Path: <linux-kselftest+bounces-3911-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AC3F844E8E
	for <lists+linux-kselftest@lfdr.de>; Thu,  1 Feb 2024 02:16:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F98C1F2C95C
	for <lists+linux-kselftest@lfdr.de>; Thu,  1 Feb 2024 01:16:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8BCF1FC8;
	Thu,  1 Feb 2024 01:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U7zJf6cd"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E0913FDB;
	Thu,  1 Feb 2024 01:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706750120; cv=none; b=XbTzkIz5BV5Hm/aj/B4OBpN8CB8N/J+yrWPPKvnBQOwKCASP8TNLphHK6eFL61cB2jy913BzdfYB3/sYLSZ6BZvtyzWI5wTPqgIQixuHJfmD/gFUUgsvitU9ZQv+sbJg2x9JNzjvxKhSfBFdPhk3NpxQR5osF+SAKfmDLKlt618=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706750120; c=relaxed/simple;
	bh=xI9kxDTnO40mhXx+1mT9ERBGq3fM7AsdzehbVDIP/uI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZvumC+gokb5lhQPC4MYBHX4+QlVsTntW2tHR/GAmf19aXQ3Z8ckhdcFqLSKHi19Oc0XFF2/BGbAA6rH/05yj+Va5LqGDSKQDWwR3do5gV1flndRU08Aph4d/QjzkzIOu+w+j7w9qEF2+x7odhKJ3ZJB+UImHHvI9XFSI6JxmD18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U7zJf6cd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5B79C433C7;
	Thu,  1 Feb 2024 01:15:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706750119;
	bh=xI9kxDTnO40mhXx+1mT9ERBGq3fM7AsdzehbVDIP/uI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=U7zJf6cd+wica2bEqKoH0TFGobs0dKW7A7Wv+wLFq+NhcwNC/dluLJnix36GUb/M6
	 cMN5D94ajyFboFQkJN9c6y6YtWSMjDXwOHXE3Ny7R0oM/ExqoDmR19Xk2htrpIPpRD
	 FmKsuQTKxk2cuZ4F9pdKmHtwm+wGRbYmrCsot2/NhDGnMzqZ37R3TpPNwxX6NF/S6I
	 kMPPOo1QCbrfXF/t/oTVN+xjNZNRhSXigAommv1h6jJObE/EYys5KMVZwlqR3mo88c
	 DV5HUKNrUOktCk8d+3dkrw2U0VMkEgY/+ihwJMmTxqTaqwHHkjrXQuC93isYVnadx1
	 XMPtlynVojOQQ==
Date: Wed, 31 Jan 2024 17:15:13 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Benjamin Poirier <bpoirier@nvidia.com>
Cc: netdev@vger.kernel.org, Jay Vosburgh <j.vosburgh@gmail.com>, Andy
 Gospodarek <andy@greyhouse.net>, Shuah Khan <shuah@kernel.org>, Jiri Pirko
 <jiri@resnulli.us>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Petr Machata
 <petrm@nvidia.com>, Danielle Ratson <danieller@nvidia.com>, Ido Schimmel
 <idosch@nvidia.com>, Johannes Nixdorf <jnixdorf-oss@avm.de>, Davide Caratti
 <dcaratti@redhat.com>, Vladimir Oltean <vladimir.oltean@nxp.com>, Tobias
 Waldekranz <tobias@waldekranz.com>, Coco Li <lixiaoyan@google.com>, Willem
 de Bruijn <willemb@google.com>, Lucas Karpinski <lkarpins@redhat.com>,
 Anders Roxell <anders.roxell@linaro.org>, Hangbin Liu
 <liuhangbin@gmail.com>, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net 0/5] selftests: net: More small fixes
Message-ID: <20240131171513.20eece61@kernel.org>
In-Reply-To: <20240131140848.360618-1-bpoirier@nvidia.com>
References: <20240131140848.360618-1-bpoirier@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 31 Jan 2024 09:08:43 -0500 Benjamin Poirier wrote:
> Some small fixes for net selftests which follow from these recent commits:
> dd2d40acdbb2 ("selftests: bonding: Add more missing config options")
> 49078c1b80b6 ("selftests: forwarding: Remove executable bits from lib.sh")

Reviewed-by: Jakub Kicinski <kuba@kernel.org>

Not so great that the team test was passing even tho it lacks 
so many configs...

TAP version 13
1..1
# timeout set to 45
# selftests: drivers/net/team: dev_addr_lists.sh
# Error: Unknown device type.
# Error: Unknown device type.
# This program is not intended to be run as root.
[   17.601119] team0: Mode changed to "loadbalance"
# RTNETLINK answers: Operation not supported
# TEST: team cleanup mode lacp                                        [ OK ]
ok 1 selftests: drivers/net/team: dev_addr_lists.sh

:(

