Return-Path: <linux-kselftest+bounces-15871-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A7D495A23D
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Aug 2024 18:01:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 17BBE285E59
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Aug 2024 16:01:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCED514D71F;
	Wed, 21 Aug 2024 16:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mfkSJu/t"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FECD14D28E;
	Wed, 21 Aug 2024 16:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724256043; cv=none; b=JH3PJOeEPisur4RlXbScFMqtaT40tZFnIY8MxspztzxSt1ucgrLFHhJ7wPblEJAnJe1pak3AF4LN/4MehYV/cN+VnPDrJeeTnzhhBMeohktjMs/n/kmwyg9UgGCjaPH0a3xDxQlQCtgnomSHMv8VqCwJtJ4Z27CfYdoZHW1UuHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724256043; c=relaxed/simple;
	bh=6/ijDimXn8Vy56loMyeJLmr0hdya+J6ZaBA7GNJEMKA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cBqKMchRb9BPELVGk0yQ57EeODi9DZ/pLhcw8Rpbq7Bkq12wGXx5F5zyy5ZsYuDVmZGnI9Pln8Ww6tI8e/ig6n36ZfKBpLpzFfoLvVOXWUKJcTg/zeJWFqRL4Z1yPBectS4Zcq9fCDD638U6i57nNIq5ItnfyocwhNu8H1MngjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mfkSJu/t; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8E22C32781;
	Wed, 21 Aug 2024 16:00:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724256043;
	bh=6/ijDimXn8Vy56loMyeJLmr0hdya+J6ZaBA7GNJEMKA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=mfkSJu/tCyKFPlygG2J7XWvJ2feqhh9ff/BuAQiCUmTLGtWWPpgE7RfestLrsEznB
	 OFuscwa319SGIy98OZKWgWM19hfWP94qBuzcCW7S0fWzoqknkV0VuLvhAibGwGiyHc
	 FeQOQGonPyEpbJqAJHiMK3cEooa9q7NBWtXCVA0hk7w6hVJr7pG9fiNprLDSqC73QF
	 GX3BAR61NBfDlC9IXxF6turw2xl8HhmsSXxPhNPRlKEYZ/ehyj+vF+4euJoLRu7mJW
	 eLHek/SbpJFv+li6HtghGYIe3oEIFc2Yd2h5Yxm2VFvQb3Nj314VOxj+fPvL6GNC36
	 o+IAuOlGswDTg==
Date: Wed, 21 Aug 2024 09:00:41 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Abhinav Jain <jain.abhinav177@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com,
 javier.carrasco.cruz@gmail.com, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com,
 shuah@kernel.org, skhan@linuxfoundation.org
Subject: Re: [PATCH v8 net-next 1/3] selftests: net: Create veth pair for
 testing in networkless kernel
Message-ID: <20240821090041.53df4147@kernel.org>
In-Reply-To: <20240821123733.109853-1-jain.abhinav177@gmail.com>
References: <20240820165006.4b6c8e44@kernel.org>
	<20240821123733.109853-1-jain.abhinav177@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 21 Aug 2024 18:07:33 +0530 Abhinav Jain wrote:
> I presumed that we would want to run the interface up/down, setup and ethtool tests on both veth.
> If this is not required, should I submit a v9 removing veth1 from the temp list?

Yes, please.

> Also, while sending v9, do I add the Review tag from Simon or it has to be reviewed again?

Yes, you should add the review tags

