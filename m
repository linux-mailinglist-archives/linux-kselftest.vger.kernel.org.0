Return-Path: <linux-kselftest+bounces-35203-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4933DADC97F
	for <lists+linux-kselftest@lfdr.de>; Tue, 17 Jun 2025 13:34:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 341573A1D14
	for <lists+linux-kselftest@lfdr.de>; Tue, 17 Jun 2025 11:34:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FFE12DBF5F;
	Tue, 17 Jun 2025 11:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QruMvEV3"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4CAC289812;
	Tue, 17 Jun 2025 11:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750160061; cv=none; b=MiiEFrGcTc0C6sGMNqu5CPzsoTZGZ5f57vTR0j7HocfIJIDabcoOVQLjpZjZu1QYwj84W21KoS3VSjVndhy9EawI1WMB1X66faxrgCWJv9HSU9RnzH7fdc5zPdWn7hiCcbD0sTF51dMOH3dpR1f3g4tgqHq2vbfIe+LyV+SBTzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750160061; c=relaxed/simple;
	bh=/lJ+FLdCZAFvrJYe9sfXUZLx/0jpBGTUY7hMUsF7QeE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i2B2fP4UBuOL2pWhLuLJf3XTftKcsFcXUhIRc0SyUBPoj9At9qNAQJQw+E3MrGPErpklO245c5UdQh2NsQCg1MXqrK4dVEXX4OfU+ulIKVKTiSg5WtgPCW1r9vu/zLV+CVcufAwph3nvKt1/7xOh6H5ZdiCCnrBDqhUnr8RJwjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QruMvEV3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D2DAC4CEED;
	Tue, 17 Jun 2025 11:34:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750160058;
	bh=/lJ+FLdCZAFvrJYe9sfXUZLx/0jpBGTUY7hMUsF7QeE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QruMvEV3syp0zvzgTiFlFSn9SohoBKo6YhOBCD9srGiOX5KJl7Dgt7RF8kJXL2tVe
	 2OubJVUhNO5VhRku1629Pqq0ukJNNi4a+qoLW7n9j6cTBwQPLm822+lJoqDZZGqN2T
	 nF+W+p1VRr7wArBP0iYXA5ezA0s0fCiz3uepRrFG3SrU2zKKNL8jlu5QBaIGjh/Qdv
	 ewJuENYg1H03pc4fV5vU0xVnxwDZqiWF/LlqRWhItwG8lCVT3P9xh3TIWqQe/KDPgi
	 QHO7TmscuQwooCFoZzG3yKk+o27gbwZLBnRUbnX3MqvjABeieqcBC4X0l8dchCIn8K
	 8gcAnMZw0w5Ww==
Date: Tue, 17 Jun 2025 12:34:14 +0100
From: Simon Horman <horms@kernel.org>
To: Eric Woudstra <ericwouds@gmail.com>
Cc: Pablo Neira Ayuso <pablo@netfilter.org>,
	Jozsef Kadlecsik <kadlec@netfilter.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Vladimir Oltean <olteanv@gmail.com>,
	netfilter-devel@vger.kernel.org, netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [RFC PATCH v2 nf-next] selftests: netfilter: Add
 bridge_fastpath.sh
Message-ID: <20250617113414.GI5000@horms.kernel.org>
References: <20250617065930.23647-1-ericwouds@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250617065930.23647-1-ericwouds@gmail.com>

On Tue, Jun 17, 2025 at 08:59:30AM +0200, Eric Woudstra wrote:
> Add a script to test various scenarios where a bridge is involved
> in the fastpath. It runs tests in the forward path, and also in
> a bridged path.
> 
> The setup is similar to a basic home router with multiple lan ports.
> 
> It uses 3 pairs of veth-devices. Each or all pairs can be
> replaced by a pair of real interfaces, interconnected by wire.
> This is necessary to test the behavior when dealing with
> dsa ports, foreign (dsa) ports and switchdev userports that support
> SWITCHDEV_OBJ_ID_PORT_VLAN.
> 
> See the head of the script for a detailed description.
> 
> Run without arguments to perform all tests on veth-devices.
> 
> Signed-off-by: Eric Woudstra <ericwouds@gmail.com>

Hi Eric,

If this proposal proceeds could you please consider running shellcheck over
the script and address the warnings it flags produces.

A shellcheck test was recently added to NIPA and we'd like to at least
minimise adding new warnings to the tree.

