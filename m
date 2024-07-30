Return-Path: <linux-kselftest+bounces-14415-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 962EC940405
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Jul 2024 04:00:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C5F6E1C20E58
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Jul 2024 02:00:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2389ACA6B;
	Tue, 30 Jul 2024 02:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mw3sCkjU"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDAFFBE4A;
	Tue, 30 Jul 2024 02:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722304815; cv=none; b=DSc2HOJ0KZMtV5xmpQnboO6DgCAhYh/U6d//YkBqatdY0s2l+iTm364t5ELMhEPx3Ne3TOXcXLkMTStuycYjTZrG1o7CveC5V0vBbQU7eY6lbtUkO/9IDDWDcGkg2VTcR3LWZfhyKzqOtiQ5pZ2QPXm7n60mYLRb1eDRBRsqJYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722304815; c=relaxed/simple;
	bh=qhq3xgNSW+dTwt9dpz+IYEbTuxWD8IdvUz6Qq6PX20k=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JBOWXY+CcwWIsMfCraqftNzNvP/9EsdsgRacYd/7qbINxGndORY/GREG2iwoA5iPXa+tSpeccLjNNVwYX5NTgvyEa1cp7RgNU2JC5FSZvaIs+Xd7xN9nnXxIK3bCa1Rwjpc6lqwlBovYOFqcNfA2zlt0jJ2tyurvF0VnbGBe5Ek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mw3sCkjU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2824EC32786;
	Tue, 30 Jul 2024 02:00:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722304814;
	bh=qhq3xgNSW+dTwt9dpz+IYEbTuxWD8IdvUz6Qq6PX20k=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=mw3sCkjUnrQgE8E8dFBwn3OPzAvNIhV7oV5WHCcULcIpOfc2qGha/Zsv2A7RXVCom
	 nsRE12Thhqq8wdVvwv35VZF/+a1VXyAEhbPF9BJQHFSc/CcCRRRvwxtuLFFT6FuhQg
	 gfHEKPZaFp7FNTUSNZqtLKMaXOnzmvAybDWaFMRVjRI02VDTt6aYNEhJ3eHjxyyior
	 L/BCnZ6kk0RqlUZCawwoHh0aISLnV7qV7t1gO2Op7S/YbosxZcxVHDuWDQZn/SrRL3
	 uXLwrvAMGLdevehH8C/U2T6O5+e5vNIgu+AHx+u1uQ35RuF5U2VEpc6xTCtMXki2oR
	 1rnJdnlBBWRuA==
Date: Mon, 29 Jul 2024 19:00:13 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Stanislav Fomichev <sdf@fomichev.me>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, Shuah Khan <shuah@kernel.org>, Joe Damato
 <jdamato@fastly.com>, Petr Machata <petrm@nvidia.com>,
 linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next 2/2] selftests: net: ksft: support marking
 tests as disruptive
Message-ID: <20240729190013.5b0743e7@kernel.org>
In-Reply-To: <20240729221042.2700882-2-sdf@fomichev.me>
References: <20240729221042.2700882-1-sdf@fomichev.me>
	<20240729221042.2700882-2-sdf@fomichev.me>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 29 Jul 2024 15:10:42 -0700 Stanislav Fomichev wrote:
> +    parser = argparse.ArgumentParser()
> +    parser.add_argument('--skip-disruptive', default=False, action='store_true', help='skip tests that might be disruptive (e.g. restart the interface)')
> +    global KSFT_ARGS
> +    KSFT_ARGS = parser.parse_args()

We pass all other args via env exports, I think we should stick to
that, it's easier to integrate with external runners.

FWIW Mohsin is also adding VERBOSE=1 this way:
https://lore.kernel.org/all/20240715030723.1768360-1-mohsin.bashr@gmail.com/

