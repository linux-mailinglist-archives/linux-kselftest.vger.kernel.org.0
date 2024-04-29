Return-Path: <linux-kselftest+bounces-9056-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A61A88B5EF7
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Apr 2024 18:27:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 65658280FB0
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Apr 2024 16:27:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D76D784D15;
	Mon, 29 Apr 2024 16:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="trPM41cV"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACA6584A58;
	Mon, 29 Apr 2024 16:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714408069; cv=none; b=Fx1n/5sX8QXMeBy77MtU/Q2uKa9RrJKKimps7YeCPQUKvJdpAV+RUg/OIG12oxWY6kX8otqTETyEb3mxHZX/mwLunyd84coMbyFGKXf18mTIm9+jpTPKnvafc07sGxuNA8k3M0pEPjDoBwRkvSI9mDZSlnJHFWzH24/qY5++Mdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714408069; c=relaxed/simple;
	bh=aqj/EIZbRjieJ/aUXcaSUzTZo7Js/xrao3OVFzrESAo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FlJ0kCuz0GQHKhAGI4489Y4GnXH0G+eJa9VJoPmt1QripNWQxoIQAilek7l12yB3x0/ysp5Kzd8M86u7i/Th2njxShRMRVa26rqCe/gr66lZVwAsz7uVRha4CWrr62XDqVxiG4HGB9Y6TWYFfV30Hi6Zc4O10n98+sSOL5KwiqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=trPM41cV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DC5EC113CD;
	Mon, 29 Apr 2024 16:27:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714408069;
	bh=aqj/EIZbRjieJ/aUXcaSUzTZo7Js/xrao3OVFzrESAo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=trPM41cVmtL9V9jcDQf3wjaz6LeuGCAwhcShC/C1ksu/ozloF28B5ZHTjTn+L+iEG
	 iQ8Y/1qK7N7X98oL4oPwzBg/MoUsEQ5f5FpLKHmgFAhheGaVMlaHPDX1u/ZHWA4PzY
	 RlZA2+erBXs3fVt8jhlU0KlnuDc16SISPaxO5d/nIo9IxR+LHL9NN0FEdLAflaDmoF
	 nmkSfIK8+Ga/L9VTb52CrhYCKVU6BCkF3NPc87tR23Mc8D9evvM3hO+lDJNjmp5vHt
	 5PaYLg9XS6qsOGKLZJtFga0jOLPONVoKhYelTY8BUljLZ/kPIORNVqkeXcmW3LrNm1
	 2ASrlr4yBJEOg==
Date: Mon, 29 Apr 2024 09:27:48 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next 6/6] selftests: drv-net-hw: add test for memory
 allocation failures with page pool
Message-ID: <20240429092748.2250c20f@kernel.org>
In-Reply-To: <662fb69baa4b7_2e6aae2947c@willemb.c.googlers.com.notmuch>
References: <20240426232400.624864-1-kuba@kernel.org>
	<20240426232400.624864-7-kuba@kernel.org>
	<662d0268e71c5_28b98529417@willemb.c.googlers.com.notmuch>
	<20240429075158.51b3f8d6@kernel.org>
	<662fb69baa4b7_2e6aae2947c@willemb.c.googlers.com.notmuch>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 29 Apr 2024 11:02:51 -0400 Willem de Bruijn wrote:
> The only interesting points so far are the use of deploy (which I
> assume you have on some internal patch already)

Yup, they need a touch more cleaning up but the PSP tests use it.

> and that with bkg would not fail the test if the background process
> exits with error.

Ah, that's a bug, yes. We should record the value of fail from 
the constructor and use it in __exit__().

