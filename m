Return-Path: <linux-kselftest+bounces-17531-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4832972054
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Sep 2024 19:22:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED9021C233A0
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Sep 2024 17:22:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E266E16DC12;
	Mon,  9 Sep 2024 17:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WmA7M44q"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9AE116BE0D;
	Mon,  9 Sep 2024 17:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725902517; cv=none; b=nYSUBQUXQTcouIJ0slakc2dUxlkpP5WsrYhSGyt7wT+Ri9vQwvnbMujaJMdtif4ZxL2dKKir8hJyExSDvyh+Y9DOihfzGcrM+zvHlSDUYO70aeXuLU8+m7e5iqE/Mc1eIdQmpBV15biMopeDe3XyYWCr8wicou6NgFsxf7geUxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725902517; c=relaxed/simple;
	bh=MMEDLH4/SEsaQGxTEBWbWVrqvvNayG5ppa/AkCMBPHQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AUiVYpVYjAkp02fHZJkr9YIzvXPeoTaCNwj3bmtolXZ2n84fzaVmgsNNT6nyJLb3/H+sHsqkoOFZPe/xhQ5KzCU1blZXhxWqd+npUGc65fqvIixhYpLTYgqZvOIokRXp+G8SW9XxOmSxlE1xYLz38WY/6EVrfUJwwdzPmBpAcH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WmA7M44q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31856C4CEC5;
	Mon,  9 Sep 2024 17:21:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725902517;
	bh=MMEDLH4/SEsaQGxTEBWbWVrqvvNayG5ppa/AkCMBPHQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=WmA7M44qBs0A943XOA2iciFemFa+/+wv3k26OqcA6OD4EDe1S9Dy+iSfbvZXTJ4vR
	 US3sor6yJx2WE+4kpvtrbUqfk7hf3yqQee9OUIhxLw9bnLsFsJpXV8mq1k1lqKUWzB
	 OQdRyKw4F6sMZNw57C9V2SsevxhnnyLezKAKvgBU2cVrS5XyZzobibw4pIxrCw3Lrm
	 Lmj0iIBkd3hBrBHEyuuCD5eC43JhKCq7umBDtC5OJfZCQnbVOGy1YrtZfM0jMlJite
	 02MMCMFfYI6ibLBNBGjf8n7QpBtML3kC2ibqhi+ymeeWMgs4g+kvzHbyLR+lSb0our
	 fWWLnEMw5LDPQ==
Date: Mon, 9 Sep 2024 10:21:56 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, ncardwell@google.com, shuah@kernel.org,
 linux-kselftest@vger.kernel.org, fw@strlen.de, Willem de Bruijn
 <willemb@google.com>
Subject: Re: [PATCH net-next v2 0/2] selftests/net: add packetdrill
Message-ID: <20240909102156.28ac12ba@kernel.org>
In-Reply-To: <20240905231653.2427327-1-willemdebruijn.kernel@gmail.com>
References: <20240905231653.2427327-1-willemdebruijn.kernel@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu,  5 Sep 2024 19:15:50 -0400 Willem de Bruijn wrote:
> Lay the groundwork to import into kselftests the over 150 packetdrill
> TCP/IP conformance tests on github.com/google/packetdrill.
> 
> 1/2: add kselftest infra for TEST_PROGS that need an interpreter
> 
> 2/2: add the specific packetdrill tests
> 
> Both can go through net-next, I imagine. But let me know if the
> core infra should go through linux-kselftest.

Okay, looks like the set has survived DaveM's weekend cleanup of
patchwork :)  I'm planning to apply it in the afternoon (Pacific 
time), please LMK if anyone has objections / needs more time to
review. I'm expecting 'unshare -n' as a follow up.


