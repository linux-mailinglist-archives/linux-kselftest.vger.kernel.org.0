Return-Path: <linux-kselftest+bounces-10017-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C5E848C26C1
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 May 2024 16:24:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0337B1C2196B
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 May 2024 14:24:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCAB414B08C;
	Fri, 10 May 2024 14:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KJyAaejJ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5D0D12C49A;
	Fri, 10 May 2024 14:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715351065; cv=none; b=WqwfelQcewxMKDsmptrcuxsWYw2yj5C+80p75K/A7g/c7Uz3fpDWfZE1tixW0WHhmTIxpNHSRzH7cB9Q+yOsQbcWfIjmgZdTOQKkSlpAVCqr7R41dzY4RQavNKBpU21lcARKronh7tcXbAu/VF4tyBVRhwEL/IZuyIn5P9TXip8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715351065; c=relaxed/simple;
	bh=68cy3OWmU7FTC7loYSlzPxDTmEmXv7gXoo7lImMbn1E=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=U/fKIHUL37TgX5zrqQfT9NCltLvrgzF+g5DBcLfeGwOWe28PfRW/lG2OoTfD1mBX9vSFgydIZC/dgBYrK9Rv9ziUZroggJKsX0fZisr2YBce5jEYu/UYgrb6w6ggO/tehLQXT1xYIecGBuE2eGcw9tpo03Ro2Z59FS/YsFZD0H0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KJyAaejJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9C0FC113CC;
	Fri, 10 May 2024 14:24:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715351065;
	bh=68cy3OWmU7FTC7loYSlzPxDTmEmXv7gXoo7lImMbn1E=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=KJyAaejJdvzgelVmdjU9B+Lhz9EZimToFTkl/bbPps1+2gFJ1XofdKv71AJYIHiPX
	 riusM2qhuHV3ZYk3/SIFqWAIBxFtO/G6dldQmLomAFB80w1egL5Mk7gs7Uqy81b5oh
	 iAE84KW2/ttOF4KeN2Qx7lPfGV1wdg3VAjd3svpTocrXxv1p1/5bP+uLa4Rbl8y37f
	 VEmfe6F34hnq7Nmb3SxSreH1vl4h6ElG13KqsbSIADozjzvKJotZBPVwdjQqR33wzj
	 fOOKfdxc3jfLqnKyn89NX1b5OjzrplWB/xt0KDlKdxxhq1ZqIjmTV2t+Gg4J41RP2n
	 qlpZ90JmmzfCg==
Date: Fri, 10 May 2024 07:24:24 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Shuah Khan
 <shuah@kernel.org>, Petr Machata <petrm@nvidia.com>, Benjamin Poirier
 <bpoirier@nvidia.com>, Hangbin Liu <liuhangbin@gmail.com>, Ido Schimmel
 <idosch@nvidia.com>, Jiri Pirko <jiri@resnulli.us>,
 linux-kselftest@vger.kernel.org, Joachim Wiberg <troglobit@gmail.com>
Subject: Re: [PATCH net-next] selftests: net: use upstream mtools
Message-ID: <20240510072424.7c05850b@kernel.org>
In-Reply-To: <20240510112856.1262901-1-vladimir.oltean@nxp.com>
References: <20240510112856.1262901-1-vladimir.oltean@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 10 May 2024 14:28:56 +0300 Vladimir Oltean wrote:
> Check that the deployed mtools version is 3.0 or above. Note that the
> version check breaks compatibility with my fork 

And Joachim's tree from before the tag, the PR was merged a while back
;)

> where I didn't bump the version, but I assume that won't be a problem.

Agreed, no point accumulating more bespoke checks.
I updated NIPA, next run should have tagged 3.0.

Speaking of requirement checks - I run the test on a fresh Fedora
install yesterday and it was failing with no indication of why.
Then I realized tcpdump wasn't installed :(

