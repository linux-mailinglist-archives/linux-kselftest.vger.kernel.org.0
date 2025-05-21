Return-Path: <linux-kselftest+bounces-33467-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68EC5ABF763
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 May 2025 16:12:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 85B493AC52F
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 May 2025 14:11:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18C7123FC66;
	Wed, 21 May 2025 14:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LmMkkQJy"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6ADE194137;
	Wed, 21 May 2025 14:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747836611; cv=none; b=VRIqMc0EbfmCi+ipYzoQeHztE9ffxb+z6qmxBJ/YkEjvhSK7hhceVUJRwy44NSBfR0Nb49jnA7xgHp2woShdybwhcAwV8Q5ShuNbb1xavV+O+D+Lh1rfK/npRgVaDzDAt0FLMBB5yj4/H9NqW08tBjkUfctdzL0hxGPyYz6r6K0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747836611; c=relaxed/simple;
	bh=DZEgFzM4nzHH/r9PZ/9x1SizshuzRtVrhWfn2VQ2doU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TOrMuxzzBQQqnDY+vEC0nX1/w614xThTkif/sYaOWiOBJb5kuGi8DO/YMmJtCF1QIiJdfccnPXhDQ6Iu9mPXHv0EpMPPM9SpjJ7+aF+Sepax+f7uTaqzulsgsi+x/h0+G4rUMz1bznfud5+P2dVfFkehN2hdNhg6TAu6/dhTrMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LmMkkQJy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88FE2C4CEE4;
	Wed, 21 May 2025 14:10:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747836609;
	bh=DZEgFzM4nzHH/r9PZ/9x1SizshuzRtVrhWfn2VQ2doU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=LmMkkQJyNw/VJjwBRHSX4EySj8hOlqgazOjmHYKGiPMEaXn8ah3/Tb2sJUt1zHkY7
	 e4uGKGfZmvJnt6m7xBkPuEdk6A7JHQe7+iHfKB6azSYbRy2coHdgm8xjwAiToeTiIa
	 AcyuLvWX+EbwkmH9EreeBYC6jjtT9Z8e1NLu5YHz0aQHsEq/SKo8YkWNtvWrgVstJW
	 Ik21uYYr9k6KO35Ma7+6zyJ+XrpDJKezW+dqqILGnwPw7F8VIjwWUlBDvY8uDH45tP
	 BNbDPhuXHAmIdp+65UdUcCn/P7rIWt31JyU5T6FWJycJfUhNYNp/72AESV69hrhEwI
	 NWjGotVjDuyxA==
Date: Wed, 21 May 2025 07:10:07 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Tariq Toukan <ttoukan.linux@gmail.com>
Cc: Carolina Jubran <cjubran@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>,
 "David S. Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>,
 Eric Dumazet <edumazet@google.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Jiri Pirko <jiri@nvidia.com>, Gal Pressman <gal@nvidia.com>, Leon
 Romanovsky <leonro@nvidia.com>, Donald Hunter <donald.hunter@gmail.com>,
 Jiri Pirko <jiri@resnulli.us>, Jonathan Corbet <corbet@lwn.net>, Saeed
 Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>, Shuah Khan
 <shuah@kernel.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-rdma@vger.kernel.org,
 linux-kselftest@vger.kernel.org, Moshe Shemesh <moshe@nvidia.com>, Mark
 Bloch <mbloch@nvidia.com>, Cosmin Ratiu <cratiu@nvidia.com>
Subject: Re: [PATCH net-next V10 2/6] selftest: netdevsim: Add devlink rate
 tc-bw test
Message-ID: <20250521071007.0cb6f546@kernel.org>
In-Reply-To: <80b40828-8fa3-4313-8c98-823ac7c055c1@gmail.com>
References: <1747766287-950144-1-git-send-email-tariqt@nvidia.com>
	<1747766287-950144-3-git-send-email-tariqt@nvidia.com>
	<20250520155957.04b27217@kernel.org>
	<80b40828-8fa3-4313-8c98-823ac7c055c1@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 21 May 2025 10:05:13 +0300 Tariq Toukan wrote:
> On 21/05/2025 1:59, Jakub Kicinski wrote:
> > On Tue, 20 May 2025 21:38:03 +0300 Tariq Toukan wrote:  
> >> Test verifies that netdevsim correctly implements devlink ops callbacks
> >> that set tc-bw on leaf or node rate object.  
> > 
> > Please add a test that can actually validate a NIC HW.
> > The test probably needs to be in Python to use a remote endpoint,
> > and should live under tools/testing/../drivers/net/hw
> > 
> > We had a long conversation about what we expect from the API
> > vs how your HW works. One of the test cases should confirm
> > the expected behavior, IOW fail on mlx5. Which is fine,
> > unlikely that any NIC will have 100% compliance. But at
> > least we will be documenting the expectations.
> 
> No problem with that, we'll add.
> 
> We could've saved this extra cycle if my questions [1] exactly about 
> this topic weren't ignored.
> Area is vague and not well defined. We can continue with the iterative 
> guess and fix cycles, or alternatively get it clearly and formally defined.

I started a couple of times on answering but my hands go a little limb
when I have to explain things so obvious like "testing is a crucial part
of software development" :S  I mean.. nvidia certainly tests their code,
so I'm not sure where the disconnect is. I had a short conversation with
Gal at some conference where he, AFAIU, was doubting that device testing
can be part of an open source project.

It certainly is not advantageous to companies to have to share their
test code. So when you ask me for details on the rules what I hear is
"how can we make sure we do as little as possible".

Broadly, any new uAPI should come with tests which exercise the
functionality. We started a decade or so ago with netdevsim tests
which just validate the API layer itself. That did not provide
sufficient validation of the real implementations, crucially it did 
not check whether shallow APIs (devlink) actually behave the same
when implemented by multiple vendors. So two years ago we built 
the Python harness to be able to write tests for NIC functionality.
That is the level of testing we expect now. Obviously there will always
be exceptions. For instance I was pushing for common tests for the time
sync code (DPLL etc.) but I was convinced by the experts that it's hard
and that they generally test with $x0,000 measurement equipment.
So fair, I guess that's too hard. But for BW shaping tests? 
IIRC mlxsw has qdisc offload tests for BW shaping upstream.

