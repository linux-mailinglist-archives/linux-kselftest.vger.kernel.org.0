Return-Path: <linux-kselftest+bounces-28364-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF802A540A3
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Mar 2025 03:25:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 23E6616E4B0
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Mar 2025 02:25:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DF9518DB2C;
	Thu,  6 Mar 2025 02:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D0w+ZGr3"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DA589450;
	Thu,  6 Mar 2025 02:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741227933; cv=none; b=TLyqm6oFWxIp/iAIjzgsnZMazp1Kd6FgdXdqG10bDEjhmix6ygg16IyBSanZn6r3XisJm8vjYX2B1WnQSc/u6nq59HGOBHaZ4EtcLxBb1mGR61KTLD/s3uXd27H7sddB4stEDB5VCo/53wWHShm4TWwsp41gak3maFRQ9TaBeoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741227933; c=relaxed/simple;
	bh=KnpNO+5ktqkAQIHcChs8cLmYjY/VGJmY6SdSL8ui50c=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pOZmFRruzavy/XmGjGzdUr7GfE1lgFy1/YPXxF2gtZDqx1gf392ivxCD9L+LfI1BLU/rGiww6hkngey8HuN4vN6WWhLoNKFMa6hyK0jvVrrs+4xcG9LOZEcd2z5JDIA3rax0ONFKPoAjA5H77jqGjT3mTcsn8oNqbCuR4S2+W3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D0w+ZGr3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6595EC4CED1;
	Thu,  6 Mar 2025 02:25:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741227932;
	bh=KnpNO+5ktqkAQIHcChs8cLmYjY/VGJmY6SdSL8ui50c=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=D0w+ZGr3BO0SJdKc7ucFvO4E6TmFR6/lmxho2QwlVoP74g7n++8APCV4SGEd6eIRV
	 goI2OoJdLoP9dAfVMRrhHpf+elQ/++/5gJc9s68UZtQ3SeLcZ9Rrm2fvV5948nelsi
	 xuUboo2jtTMEoaXrdQnLw+0cOLnrJ+pOQoDIe+2baWh8lbOyd1iP/7w2tzZ8yt7+Uj
	 NIA+soQHuyXD5DVUvjVpkn6IBLr4S1mVcmnf01CfAvoVtxIghY6XryuTBQz2CrGtJ4
	 gF5zBFZwQd/F3izgb455YXrCOCjZdyu0TIX18tcIVbpBBKAnuCjbuUDo3HN9dIJnHN
	 wqIRTgOl7r7fg==
Date: Wed, 5 Mar 2025 18:25:31 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>, Paolo Abeni
 <pabeni@redhat.com>, Jay Vosburgh <jv@jvosburgh.net>, Andrew Lunn
 <andrew+netdev@lunn.ch>, Eric Dumazet <edumazet@google.com>, Nikolay
 Aleksandrov <razor@blackwall.org>, Simon Horman <horms@kernel.org>, Jianbo
 Liu <jianbol@nvidia.com>, Boris Pismenny <borisp@nvidia.com>, Tariq Toukan
 <tariqt@nvidia.com>, Shuah Khan <shuah@kernel.org>, netdev@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCHv3 net 0/2] bonding: fix incorrect mac address setting
Message-ID: <20250305182531.7f612203@kernel.org>
In-Reply-To: <Z8gKYzpJw_DoYEMx@fedora>
References: <20250207092920.543458-1-liuhangbin@gmail.com>
	<Z8gKYzpJw_DoYEMx@fedora>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 5 Mar 2025 08:25:07 +0000 Hangbin Liu wrote:
> Could you help process it, or should I re-post it?

Repost.

