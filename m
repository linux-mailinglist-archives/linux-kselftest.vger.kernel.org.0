Return-Path: <linux-kselftest+bounces-22960-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 611969E7DD4
	for <lists+linux-kselftest@lfdr.de>; Sat,  7 Dec 2024 02:50:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 20CFA2828D7
	for <lists+linux-kselftest@lfdr.de>; Sat,  7 Dec 2024 01:50:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D56F7125D5;
	Sat,  7 Dec 2024 01:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="efQPzkK7"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A87278F64;
	Sat,  7 Dec 2024 01:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733536252; cv=none; b=NI1WBHJMEMUFjE3JyIT3uDpP3ZmwUXnozhMZ15UgjmCpwBxdB9DAk7vKp9FLKrMEOPs0PILV0D2NjiV/kGt1meV111vhw9HqI1CRQmlZehZE3DYFwVpjpoRNfa9HzHUPl/H02Pdc4q5NagyCgpenGTLrdQH2O+ZTuLu/GlonnwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733536252; c=relaxed/simple;
	bh=kzWxelifGoKO74BTdss29VG8y7iq1uEeYrocjxaQnM0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Fw49qLKTp3KK+KiiYZn9Ef9E5uO4q5+Y19J+h4gqqgms8+BxRPVkOodxRQTwSIxgDE6ewrnS10s1u3NHOfdCQLhIu6XJU9r2xHXOPRv23VzRoY6pkQcaRRQG9EZ83tk4D5xJAdvUnjbvrqLTRv8wcLqg8hVDq/bat0wdOgf73yo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=efQPzkK7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C56ABC4CED1;
	Sat,  7 Dec 2024 01:50:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733536252;
	bh=kzWxelifGoKO74BTdss29VG8y7iq1uEeYrocjxaQnM0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=efQPzkK7BzO8xnEjJLgGZCosfX3S5GtUf7awwmQAu79igyo8v2gVVoXi8LLj8dbmq
	 /lMuLFIyjNdtFZ4aWNXn8iL0ITXcLIHqG8xL6AhaEFkTYF+1+kkJI07jhp/W3VWAlw
	 6qLzJNscba2ylQooiitr7Crz5T57MbDKmvsNGzlCxMK9IvSUteCZVElDRlmyizCuj9
	 KGk4jk5Cp3AyInG0F9l4r5BydHPwDN60015RL/U1kb736XxQHtZlT2dWeoU73dMRRl
	 ieNguyhxgqZnK8Bnoqlkex7/oa5kgAsVajvaJnZyVBTF65ehTlblIklBRX+zzj/JL0
	 qYwc58OaN2Vlw==
Date: Fri, 6 Dec 2024 17:50:50 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Simon Horman <horms@kernel.org>
Cc: Zhu Jun <zhujun2@cmss.chinamobile.com>, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, shuah@kernel.org,
 netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftests: net: Fix typo in psock_tpacket.c
Message-ID: <20241206175050.28c93659@kernel.org>
In-Reply-To: <20241206125955.GO2581@kernel.org>
References: <20241204075756.11561-1-zhujun2@cmss.chinamobile.com>
	<20241206125955.GO2581@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 6 Dec 2024 12:59:55 +0000 Simon Horman wrote:
> FTR, I'm not sure that I understand the grammar in the comment.

+1

Looks like the author didn't do much due diligence.
-- 
pw-bot: reject

