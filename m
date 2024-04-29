Return-Path: <linux-kselftest+bounces-9054-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 889AC8B5EBD
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Apr 2024 18:17:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B9BDB1C21726
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Apr 2024 16:17:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26CD184DE4;
	Mon, 29 Apr 2024 16:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qnTivAxR"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F30FA84D35;
	Mon, 29 Apr 2024 16:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714407413; cv=none; b=qtR81FT84ZG3VqrdmClNtgwpEbMB75hYZFmeZOQ3sDzup8mntXB+p4gEmsNBSJkVlH0hpacMFWBNj6DGBG16je15RjZXxD9Dl2wC9Qgzz8D7klPmCMMksWmlj5z84o7+G9cRNd7nxgF0guCQqgzu519cS09VPsgxZbxcnpXKxa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714407413; c=relaxed/simple;
	bh=YXJGF1Zg4xe6UYYY8Irqeg5ykQPyYLk1knZJ6yRW8Xw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CBhQ8uYvO5Ar3r2eL0OnkeAUYVBpCU1KGU7DVxXRKOdN/tRk09GaKAXtm/ec4Bs/cdsmcCOwWz+k2K1JXH0Ue2AX4gmrcoRPZ5zrxOmy6b7HXo+XpcRt3zsGoT9abb6GgC+V5ldWfGAUbdCbQ/6bE2ekNh8YfW9qIGaqVdEf12I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qnTivAxR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 419CBC113CD;
	Mon, 29 Apr 2024 16:16:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714407412;
	bh=YXJGF1Zg4xe6UYYY8Irqeg5ykQPyYLk1knZJ6yRW8Xw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=qnTivAxRbuS4p39PeNaBv+2U7bbYVfk4Jfb6PM4sDcZ+g6B+IndY2wHw1x1g95lPI
	 vKruRY6jALIs5Sk6abnvCNlFrH9smXH7aT1I2zaq2T1CZjZkvLjRzVbCmXZgFz/X3x
	 D2IwYjHpOuw1oUqCtJ5x1uX65dxU9oikPZsXPbdz6qdQg4/c0tWIUg+OxKUNZUi2ci
	 f73BACpZNE+Gfpu1r3ZVNZfSa90JgxIM25Bcr5IEtxxwafR34OBC7nq2XCCHlGAe/8
	 TE2FGVgor991QgCkFFn0xDagyy6e8C2IQUNq2N2ti2EvhUzxU1M7R+o/QKhGzsdbFc
	 kIP+HHGlwy5Dw==
Date: Mon, 29 Apr 2024 09:16:51 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Andrew Lunn <andrew@lunn.ch>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, linux-kselftest@vger.kernel.org,
 willemdebruijn.kernel@gmail.com
Subject: Re: [PATCH net-next 6/6] selftests: drv-net-hw: add test for memory
 allocation failures with page pool
Message-ID: <20240429091651.7b831da9@kernel.org>
In-Reply-To: <3e332c1d-b767-48f2-8307-0d037921773f@lunn.ch>
References: <20240426232400.624864-1-kuba@kernel.org>
	<20240426232400.624864-7-kuba@kernel.org>
	<3e332c1d-b767-48f2-8307-0d037921773f@lunn.ch>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 29 Apr 2024 17:12:29 +0200 Andrew Lunn wrote:
> >   # ./drivers/net/hw/pp_alloc_fail.py
> >   KTAP version 1
> >   1..1
> >   # ethtool -G change retval: success
> >   ok 1 pp_alloc_fail.test_pp_alloc
> >   # Totals: pass:1 fail:0 xfail:0 xpass:0 skip:0 error:0  
> 
> If i'm reading the traffic generator correctly, this test runs for 24
> hours. Do we want some sort of warning here about the test duration?
> Some sort of alive indication very minute?

That's just the max value for the time param.
The generator is stopped / killed after we go thru the test steps.

