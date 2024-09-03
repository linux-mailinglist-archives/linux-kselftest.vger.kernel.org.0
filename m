Return-Path: <linux-kselftest+bounces-17054-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32AD396A417
	for <lists+linux-kselftest@lfdr.de>; Tue,  3 Sep 2024 18:19:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 87B02B244BF
	for <lists+linux-kselftest@lfdr.de>; Tue,  3 Sep 2024 16:19:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2C2718B466;
	Tue,  3 Sep 2024 16:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i/QSrfeq"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96ACE405C9;
	Tue,  3 Sep 2024 16:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725380368; cv=none; b=EL+VbKgbbUn602G/Rf3t7v64e31uqJ1GDIL0cIDllz2mY12EOCZzJaxqVtWwR0bemfWpBqs6vN/2yWGvUZ8TPEshY5zrfpWpfGfsi44hyUyJRVff7+q1AwpBfW1xfqTgsPa5ftMLnN/6f049h8CmLN5uNe1I4sfP3ZqUo6aUXvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725380368; c=relaxed/simple;
	bh=WllGggugZ28zZO74W4H1juh4xO9s8coYO5exYjqiISc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jrEjGTTfRoxTKSRYeUXYIH6v+CUQTYUnavzEU57JeVjejCxg1hq8RiBJpzqDzUYrtCYpN+u9rHVUAe3HLiQe23YwW2YyxyGe3Fd79HogDHNpmufiNNaCWwVxSuGS4TJhHXFK9jvjJ9+QAYxTh/qXNCmBPYynIYg6rz9ZUDm23YM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i/QSrfeq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B513C4CEC4;
	Tue,  3 Sep 2024 16:19:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725380368;
	bh=WllGggugZ28zZO74W4H1juh4xO9s8coYO5exYjqiISc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=i/QSrfeqwKdbBgXMZOK9ypMoOCPtVu8+IRKiOWYrE8sPS5bwyhqbsBciU0rrON7Ln
	 MhkEk2a6qJWm9t3vlqNmyJJ93zidWq4Z7Hn27tVIr6nz7lZiiMYHNFnlc1Oad2oABr
	 BMmIy0oUXSFfS01XfttuAY05tYnXfbqyRX1v+ygkpUgrbj3USOPzonpqhVlESyu7RA
	 +Wy9EOMh5VmtJIcZ8xoSTqQ0tZ856RvXkQkCIKQiH2emZ1ze/UhNdARmifYiwresfQ
	 SSR9jRG9fj/kqhLIBfDY+OziOPNiQg5jF9yxwprRQ3Wh1F8NyD1nf+q3CPFU1sfXX8
	 uQDwj+iJHg9og==
Date: Tue, 3 Sep 2024 17:19:24 +0100
From: Simon Horman <horms@kernel.org>
To: Chen Ni <nichen@iscas.ac.cn>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, shuah@kernel.org, netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftests: net: convert comma to semicolon
Message-ID: <20240903161924.GD4792@kernel.org>
References: <20240903074519.781224-1-nichen@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240903074519.781224-1-nichen@iscas.ac.cn>

On Tue, Sep 03, 2024 at 03:45:19PM +0800, Chen Ni wrote:
> Replace a comma between expression statements by a semicolon.
> 
> Signed-off-by: Chen Ni <nichen@iscas.ac.cn>

As mentioned at [1] I think it would be nice if the patch description
was a bit more descriptive.

[1] https://lore.kernel.org/all/20240903152125.GA4792@kernel.org/

