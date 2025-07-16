Return-Path: <linux-kselftest+bounces-37393-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ACB49B06B52
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Jul 2025 03:53:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ADA0D3B5045
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Jul 2025 01:52:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02D59270EAA;
	Wed, 16 Jul 2025 01:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qTgagB9c"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5705219300;
	Wed, 16 Jul 2025 01:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752630791; cv=none; b=sceTX+y0skkEbNpZaPou0kbTomH3Yk1NlOsF99/43lNhsKR6BN9NEG7i4drbmk+FfgSSm669UdNRt6wLCP0YNuWpflfVq7leKH7ejlVJlB1nydmN20TyY2vrV+xlxAyXadxlwMx0bFTWiLQemqxZoaI7KXuibX/foB/K3nGy4QY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752630791; c=relaxed/simple;
	bh=AgPdoMqDg8L4fV5zB8M1dItkEtRnOeipC0P3Y056UeY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WP/DR7eiOFkzC2LrjvnmoAM1BHeu03wg7Z4aRzts6ZwrEHCpW82Q2qJwBxRkVC/J1vrtXLQT2KxUj6/L5CgrxCLAijkTkQbAlpL1eQtM6D0AgZmR74v+jBtJjpr38FQIJ5SclIJUMEa7N/5nOGddP8tjpdIDHXKqQEnwssDmR58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qTgagB9c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 889C1C4CEE3;
	Wed, 16 Jul 2025 01:53:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752630790;
	bh=AgPdoMqDg8L4fV5zB8M1dItkEtRnOeipC0P3Y056UeY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=qTgagB9cHMe+ZbpHpn8WJBvv3Jdk8SX/n3coj4tGdbe/GiFGoEezBmhIZZUI7honX
	 7jDEQqR259rgPqy4qyqVmGgnLFx1R4OZFPCnnErUy6lFWexbZcVZQ8YpVUfGCuoSMD
	 XagBZDO0CyMA9enWuTv/UDXeARG5lK5wjq2G4nXreKPBmSL3H1bg9ydjcxLT6D0JCL
	 jZL/S7aebScVTfXJ9nokt8YRJNfQjkb8/GNpTB0bqM+458Nbl9a0wfcMQMf1ZsMNas
	 NF+gZ/Ut2o5+ICR42peMqaqWapsS5d22Z4UpXlIWwKQFTf7yivSxVSVTxZWHDcS0RC
	 GqtVBZNpH+05Q==
Date: Tue, 15 Jul 2025 18:53:08 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, Geliang
 Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon
 Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>, Christoph Paasch
 <cpaasch@openai.com>, Davide Caratti <dcaratti@redhat.com>, Florian
 Westphal <fw@strlen.de>, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
 stable@vger.kernel.org
Subject: Re: [PATCH net v2 0/2] selftests: mptcp: connect: cover alt modes
Message-ID: <20250715185308.2ad30691@kernel.org>
In-Reply-To: <20250715-net-mptcp-sft-connect-alt-v2-0-8230ddd82454@kernel.org>
References: <20250715-net-mptcp-sft-connect-alt-v2-0-8230ddd82454@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 15 Jul 2025 20:43:27 +0200 Matthieu Baerts (NGI0) wrote:
> mptcp_connect.sh can be executed manually with "-m <MODE>" and "-C" to
> make sure everything works as expected when using "mmap" and "sendfile"
> modes instead of "poll", and with the MPTCP checksum support.
> 
> These modes should be validated, but they are not when the selftests are
> executed via the kselftest helpers. It means that most CIs validating
> these selftests, like NIPA for the net development trees and LKFT for
> the stable ones, are not covering these modes.
> 
> To fix that, new test programs have been added, simply calling
> mptcp_connect.sh with the right parameters.
> 
> The first patch can be backported up to v5.6, and the second one up to
> v5.14.

Looks like the failures that Paolo flagged yesterday:

https://lore.kernel.org/all/a7a89aa2-7354-42c7-8219-99a3cafd3b33@redhat.com/

are back as soon as this hit NIPA :(

https://netdev.bots.linux.dev/contest.html?branch=net-next-2025-07-16--00-00&executor=vmksft-mptcp&pw-n=0&pass=0

No idea why TBH, the tests run sequentially and connect.sh run before
any of the new ones.

I'm gonna leave it in patchwork in case the next run is clean,
please use pw-bot to discard them if they keep failing.

