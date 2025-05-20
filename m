Return-Path: <linux-kselftest+bounces-33438-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BB8BABE7D9
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 May 2025 01:00:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A6EF3BF1A6
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 May 2025 22:59:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8955825E83F;
	Tue, 20 May 2025 22:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XlQooxPY"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50E281DB124;
	Tue, 20 May 2025 22:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747781999; cv=none; b=toGWpqHJ+Cvp8GcCk0QjluXksoxRDOIcJL4TyZCOeQ8tsWp9hWxGrJXOxRfqXPxkl76yNmgWvFUHdJNVL/xWaBXUMCJZyqtbXAaLcKvnBn+kKsRbfJO4GsymaW4Qf2DyuLj5RQusWaSX9xUCAOpTTkCDYFcIwjEh4rz7CC964fk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747781999; c=relaxed/simple;
	bh=gTQNvf/9cpbAN7wF1rSo4wWYuMaNi88KIdv6xt3mwn8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Em1LmTlqXWBBA0b9qtv4q58VrjDHUSD7dhlOwdZpOOG9YDHxZOzd3P3yRUb7TxM+Qwija7bK8FAujycn0o9QKv9JGeGsUEcc5zPQ6eCqme1s9fQBtbwYwYr4BlSi+deItugJPgMvnK7W/1R1LmVm67PDDh4uCtxsdQvD7FUqykE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XlQooxPY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2AFDC4CEE9;
	Tue, 20 May 2025 22:59:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747781998;
	bh=gTQNvf/9cpbAN7wF1rSo4wWYuMaNi88KIdv6xt3mwn8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=XlQooxPYVVVdZZ6A7SEzxhWExRGuUo8AKbYZbrxl7vewcyVbEZMZnuynUp8lY83dO
	 Q8Eygf4ZOlO+TqNutNFj5r7rKZDlYZpw/gUkY/Hsg53v2OvvzUFsDFB1KhSMP5gwkr
	 NV3C++V2YfjE8aQ5Fr8SlSLD7cfVJuye0u+h4mPISHfSd4LDVGMnaLQdDBk2m3oBrs
	 091wa7fdXLyChefd5vyvMN9HV51yYSdf+Ohy6bckFHDM+A1/d1jFAKEEUG2Ho10GQA
	 LgpEMry2QdE6n/hGgsDGnhVy2/NEalntLREDqstPDTTF1JtEsjtuUfuUlvO0lvKVTq
	 1cmSj1LVvpgXg==
Date: Tue, 20 May 2025 15:59:57 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Carolina Jubran <cjubran@nvidia.com>
Cc: Tariq Toukan <tariqt@nvidia.com>, "David S. Miller"
 <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>, Eric Dumazet
 <edumazet@google.com>, "Andrew Lunn" <andrew+netdev@lunn.ch>, Jiri Pirko
 <jiri@nvidia.com>, Gal Pressman <gal@nvidia.com>, "Leon Romanovsky"
 <leonro@nvidia.com>, Donald Hunter <donald.hunter@gmail.com>, "Jiri Pirko"
 <jiri@resnulli.us>, Jonathan Corbet <corbet@lwn.net>, Saeed Mahameed
 <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>, Shuah Khan
 <shuah@kernel.org>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
 <linux-rdma@vger.kernel.org>, <linux-kselftest@vger.kernel.org>, "Moshe
 Shemesh" <moshe@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, Cosmin Ratiu
 <cratiu@nvidia.com>
Subject: Re: [PATCH net-next V10 2/6] selftest: netdevsim: Add devlink rate
 tc-bw test
Message-ID: <20250520155957.04b27217@kernel.org>
In-Reply-To: <1747766287-950144-3-git-send-email-tariqt@nvidia.com>
References: <1747766287-950144-1-git-send-email-tariqt@nvidia.com>
	<1747766287-950144-3-git-send-email-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 20 May 2025 21:38:03 +0300 Tariq Toukan wrote:
> Test verifies that netdevsim correctly implements devlink ops callbacks
> that set tc-bw on leaf or node rate object.

Please add a test that can actually validate a NIC HW.
The test probably needs to be in Python to use a remote endpoint,
and should live under tools/testing/../drivers/net/hw

We had a long conversation about what we expect from the API 
vs how your HW works. One of the test cases should confirm
the expected behavior, IOW fail on mlx5. Which is fine,
unlikely that any NIC will have 100% compliance. But at
least we will be documenting the expectations.

