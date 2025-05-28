Return-Path: <linux-kselftest+bounces-33908-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 15608AC5EA7
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 May 2025 03:18:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C91874A45AE
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 May 2025 01:18:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19948155326;
	Wed, 28 May 2025 01:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uwa1K1NH"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4787B652;
	Wed, 28 May 2025 01:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748395121; cv=none; b=NVcMCwhfsEWkXBXDOVRDUD8Xq8tQCwPuU//HpbDyM82TB+H0ICc7raI1krHSpWNR4KvElQle6DJ+U9GgZPjSqvUM7JzpS1BUevL529P+WTI7NDKb2NMeFePfjSzNriiBlzl3ViOY85Z/CVdCPU7pzXrv2ujhkyXXNf6cYENjezs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748395121; c=relaxed/simple;
	bh=p5QWRdhWaODG9aKY5tA69PeV91P0Vrp+Cj4FSE5f6hw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=D9eB2yas5exIV8CoHCyNQeN3PAlbJ49dj+94tGp2vohlRbO/kxpZJjEnGdXwcyWWwgDS+rClIe47RLHOg1OHypXpeWr8Mz+utZH/opLqnQfaDjJe//qayhOX4xYC/O3I/0l9EqW+Fb1JOf1TFAqodBq9IL8QN0cUNyKrn0zdmEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uwa1K1NH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87E20C4CEE9;
	Wed, 28 May 2025 01:18:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748395120;
	bh=p5QWRdhWaODG9aKY5tA69PeV91P0Vrp+Cj4FSE5f6hw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=uwa1K1NHzWm2IchSeYUR4fykOGrge/eVf2zfPNLzePfqn3/x9t3hLl5WqznVPEfPF
	 7bj9XlA+KJHDUGz/MpZFgTQsNEfOW90u2Vx2E/xYRzt+3sYtLBc2m7VAr646Ez6uxj
	 +q+5Vzke5jloJj65BsZiNwqNjnAwNLAb+MAp+XlbuQpmK7QvbQWP2CYF0wrEgypfmN
	 V0SPSKlMuwaY8CpRZZKclRy45Kg/suOBhrlj5Xse6wXnDvyg1VACx1+dBSZxWUTlsN
	 Az8ytsZi9dwKkJnMylk1H8ns2J6Lz4tU5sZMIDx2ibnWO+BFTp7PVb9vj2pfV9E5RE
	 lPi6WZ7GfRT+w==
Date: Tue, 27 May 2025 18:18:38 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Praveen Balakrishnan <praveen.balakrishnan@magd.ox.ac.uk>
Cc: <pablo@netfilter.org>, <kadlec@netfilter.org>, <davem@davemloft.net>,
 <edumazet@google.com>, <pabeni@redhat.com>, <horms@kernel.org>,
 <shuah@kernel.org>, <aconole@redhat.com>, <echaudro@redhat.com>,
 <i.maximets@ovn.org>, <netfilter-devel@vger.kernel.org>,
 <coreteam@netfilter.org>, <netdev@vger.kernel.org>,
 <linux-kselftest@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <skhan@linuxfoundation.org>, <linux-kernel-mentees@lists.linux.dev>
Subject: Re: [PATCH v2] selftests: net: fix spelling and grammar mistakes
Message-ID: <20250527181838.05cccdb3@kernel.org>
In-Reply-To: <20250523022242.3518-1-praveen.balakrishnan@magd.ox.ac.uk>
References: <4f0d5c19-8358-4e5b-a8f0-3adcee34ffd4@linuxfoundation.org>
	<20250523022242.3518-1-praveen.balakrishnan@magd.ox.ac.uk>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 23 May 2025 03:22:42 +0100 Praveen Balakrishnan wrote:
> Fix several spelling and grammatical mistakes in output messages from
> the net selftests to improve readability.
> 
> Only the message strings for the test output have been modified. No
> changes to the functional logic of the tests have been made.
> 
> Signed-off-by: Praveen Balakrishnan <praveen.balakrishnan@magd.ox.ac.uk>

This does not apply cleanly any more.
Please wait until net-next re-opens after the merge window, 
rebase and repost:
https://netdev.bots.linux.dev/net-next.html
-- 
pw-bot: cr

