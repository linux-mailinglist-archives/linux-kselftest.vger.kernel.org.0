Return-Path: <linux-kselftest+bounces-40716-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EC99B42E4C
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Sep 2025 02:37:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BBF4C5E7864
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Sep 2025 00:37:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E350715624D;
	Thu,  4 Sep 2025 00:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EKb0p+c8"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B314D11185;
	Thu,  4 Sep 2025 00:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756946269; cv=none; b=CKlYcwu/JMUPeUx5rQST4uB4vfX/0wPwbuCv3bQkPBhQlBTtI+f/XLsVodYTRbtw8kk6x/bkj30FbQWGobwx18VSMSisGbIdGjU2a3rVMeIEdELvbcxmKhty4K/9nnwjFF6KAKNmg8mEE4Y2WUzzyXpb2QuV2MpBvM/NyogldgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756946269; c=relaxed/simple;
	bh=NolWOvG4QsvlIv/gjPI7YpwDSettfhcYFKxMsBKbASk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VCXxas6hzGZ2HIEo5daq+7Of95w5DhL04kGSd9QCCTUzttpktTFNOISmovxRKwwQaToTvZLQOQNG8ZwzliLySzYXvyTTMDY7DIxUNlxjpLypcAjvw6gwJ/lfuEmG7n5P9FL6JCjxKgnPp8hbGTDcZWkQh7eltiZVx4JpUrOwcTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EKb0p+c8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5CCBC4CEE7;
	Thu,  4 Sep 2025 00:37:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756946267;
	bh=NolWOvG4QsvlIv/gjPI7YpwDSettfhcYFKxMsBKbASk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=EKb0p+c8aqKFipoaV/P5iGdQW8/hboXbUjd0vh960xEZwZlyt3fo9D/2yzUPHCWmT
	 xJ8EMTMDzjOL7Oh1diNcfmzz74HZux5y6wciqwgpjC6T6vXscfPuzspJwpwZurLe9L
	 uMsVBTYbHqpWUC/WcBogvvb49wTtbbWpPOBMWXOkD6NYDCCYe4bsUaiDh2ATw0YoPG
	 dsDV628CPXWiK00SlJnqn7dx1LdZiutQQbisK5G6D5ovRAPbLgCeFzVnQsUR0AY6WM
	 bU5W07Z/JSXMkdQ4vLBgEHnRXdJP0rt15sc5G3HmVj7tzF0u5skVRSkSj9AbfkSOiv
	 4EQwHACXfXV4A==
Date: Wed, 3 Sep 2025 17:37:46 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 linux-kselftest@vger.kernel.org, asantostc@gmail.com, efault@gmx.de,
 calvin@wbinvd.org, kernel-team@meta.com
Subject: Re: [PATCH net-next] selftest: netcons: create a torture test
Message-ID: <20250903173746.5c04c306@kernel.org>
In-Reply-To: <20250902-netconsole_torture-v1-1-03c6066598e9@debian.org>
References: <20250902-netconsole_torture-v1-1-03c6066598e9@debian.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 02 Sep 2025 09:33:33 -0700 Breno Leitao wrote:
> Create a netconsole test that puts a lot of pressure on the netconsole
> list manipulation. Do it by creating dynamic targets and deleting
> targets while messages are being sent. Also put interface down while the
> messages are being sent, as creating parallel targets.
> 
> The code launches three background jobs on distinct schedules:
> 
>  * Toggle netcons target every 30 iterations
>  * create and delete random_target every 50 iterations
>  * toggle iface every 70 iterations
> 
> This creates multiple concurrency sources that interact with netconsole
> states. This is good practice to simulate stress, and exercise netpoll
> and netconsole locks.

Oh, when you said "selftest will be posted later" in the fix I thought
you meant days, not hours later :) It's better if the fix and test are
in one series. Better for backports, and it avoid situations like last
night when the fix was already dropped from pw but this test was still
running (and crashing the kernel).

Regarding the test, I think it makes sense. Tho is there a way we can
reuse more of the existing code? Do you write all these scripts by hand
or get AI to write them? I was hoping you'd add more tests relating to
bonding. To confirm bonding still works. And as I mentioned I think
bonding is still a bit buggy if we "propagate" multiple nps and then
remove them out of order..

