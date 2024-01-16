Return-Path: <linux-kselftest+bounces-3090-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC78082F481
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Jan 2024 19:44:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 57B6FB2122C
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Jan 2024 18:44:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B82E1CD39;
	Tue, 16 Jan 2024 18:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="svDaK85D"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2267E1BF29;
	Tue, 16 Jan 2024 18:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705430644; cv=none; b=GqCHpVpFVWfnzQOxLNpnfoQRHnTEd1RQmPebLQFYSOssG8N5q2SrZl9f5pxMAHyYV2bQLoQWl5VQULD37vAieLwOievPhJMNYpCRC/i24QuRxlu5YQAX7oiIBkPRTxY9ebodQZA20NYRWYO93ppFOQunQOYRHeAgwmj2Z3l7Yvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705430644; c=relaxed/simple;
	bh=JNSQR9kR2k9xX+UG5m3NNrCPbEHk2gp5q9B7wMuhxdk=;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding; b=TNBlTfHWKw1UFdZjBMwBza8Hh3eoHjS9isCDCfDQcv/FPl/4YsWLYcR+ZBSZDfstLQedUPG27feRK3belzLP0Uijk31hPWk+iRrOd7ltxrqBOz4lMV24zLFm1WsCXLKAkR6Xc+FC+rEFB4M9H8/44IyfPRb4IBaD83K4O//MfFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=svDaK85D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E455C433C7;
	Tue, 16 Jan 2024 18:44:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705430643;
	bh=JNSQR9kR2k9xX+UG5m3NNrCPbEHk2gp5q9B7wMuhxdk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=svDaK85Dn27nWYxu5P7uhAlUWjnThBIO9ityi55aMp2ZkFT0jsuIxjomo3dPcJOwR
	 QanjQkCE4BibrDU2wLEOu2BWWavpBnlsE8tuCW6DgXve54IRx/xR8L7MuCD0/cLHz6
	 HRGeY7UnBCb8LWo/JTbBbfLLNwz6iu5ouiY9p9OBo0ljuwuqnNqjOtuadSU75Brzt/
	 yuU/nAxlW2Z3v5F5eOGYxKpBAl8eMyQj7owGQoWN6LjMnSYz4y0kstLhhpeYPFPXyk
	 O7tJJvQW/wpFddG1kVNMj6jgAqwKsZ6FlfeNqRAPUY4m6ZdJf0bWmnkOSXaDhyLzGA
	 nUqbLN1VTe7Dw==
Date: Tue, 16 Jan 2024 10:44:02 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Benjamin Poirier <bpoirier@nvidia.com>, Hangbin Liu
 <liuhangbin@gmail.com>
Cc: netdev@vger.kernel.org, Jay Vosburgh <j.vosburgh@gmail.com>, Andy
 Gospodarek <andy@greyhouse.net>, Shuah Khan <shuah@kernel.org>, "David S.
 Miller" <davem@davemloft.net>, Jonathan Toppins
 <jon.toppins+linux@gmail.com>, Nikolay Aleksandrov <razor@blackwall.org>,
 Michal Kubiak <michal.kubiak@intel.com>, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net] selftests: bonding: Add more missing config options
Message-ID: <20240116104402.1203850a@kernel.org>
In-Reply-To: <20240116154926.202164-1-bpoirier@nvidia.com>
References: <20240116154926.202164-1-bpoirier@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 16 Jan 2024 10:49:26 -0500 Benjamin Poirier wrote:
> As a followup to commit 03fb8565c880 ("selftests: bonding: add missing
> build configs"), add more networking-specific config options which are
> needed for bonding tests.
> 
> For testing, I used the minimal config generated by virtme-ng and I added
> the options in the config file. All bonding tests passed.
> 
> Fixes: bbb774d921e2 ("net: Add tests for bonding and team address list management") # for ipv6
> Fixes: 6cbe791c0f4e ("kselftest: bonding: add num_grat_arp test") # for tc options
> Fixes: 222c94ec0ad4 ("selftests: bonding: add tests for ether type changes") # for nlmon
> Suggested-by: Jakub Kicinski <kuba@kernel.org>
> Signed-off-by: Benjamin Poirier <bpoirier@nvidia.com>

With this applied the only remaining bonding test which fails in our CI
is bond-options [1], good progress! :) Looks like it doesn't finish in
time:

not ok 7 selftests: drivers/net/bonding: bond_options.sh # TIMEOUT 120 seconds

The tests run in a VM without HW virtualization support. Any opinions
about bumping the timeout for bonding? If we enable KASAN etc. things
will get even slower.

[1]
https://netdev-2.bots.linux.dev/vmksft-bonding/results/423800/7-bond-options-sh

