Return-Path: <linux-kselftest+bounces-41291-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C2784B54588
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Sep 2025 10:34:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 196571C87018
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Sep 2025 08:34:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55482221FA8;
	Fri, 12 Sep 2025 08:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c9N2FDhb"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 216D419E97A;
	Fri, 12 Sep 2025 08:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757666050; cv=none; b=BNqga+twoH/DpItN8lTtBG69momZ6rFY/AyOvmbyZH/n1jL5j5IJ87NHdzgUW09+jY7Dk+R+mzU33cdUy9uHnZnEa9xe3iD1M1BRjv1e13+gI3JKe795maYzN6xrmzKxJ4Bf5TrymswVE/Kz1E2ij3s9A1r+Mp7/Op6VSu9+HD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757666050; c=relaxed/simple;
	bh=3YJ666oAEbzsII7M4hQ6bgq3Dj6HF8q+iRrlgylpJr0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Vr/jW55Um4uNEi6ktLOQ6tIJlb1d8WLSVZfQeX7WnsxkStRjCEcdeG+9qkZiJQmW1w4bP+ybGydvGrre6c5Su22KbVu93kDkzCI0UHR0tnBk3UGeJB8TBfUm4tDusK49hxQe3clGTi8AOyoW6ReNwXUYIMMU9Hzm2Y2QzOMwfHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c9N2FDhb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19F37C4CEF4;
	Fri, 12 Sep 2025 08:34:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757666049;
	bh=3YJ666oAEbzsII7M4hQ6bgq3Dj6HF8q+iRrlgylpJr0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=c9N2FDhbMfLMkfICecdL3Vnp9rXpo9pZf59tFysbXx1lynUDxI/AhibgJKEhOrYJH
	 zLiXuIUTmL+xHHafaeSwOtgiP+8HTyP8Rms8MkD3LxN0XNrZRPndXvUA5HYIdQJ29d
	 vnga90lji41TaP4yMpDX6JYo00qfl5HX/fmW8Ebcgk8M0hUNFINO6gbueZkLGXWY4H
	 W5MLOHcweOXDTPc3egZdZpy6c0ZsROotFFuVENbuz02hTeeWpa1EBlHfrFKDFOesOo
	 mVEXSguvMTG2eJWBRfoUB45T1p93OTM1X72eWgRmwguu2YP3KjTdqdnpzYyYlYgXfB
	 9cfzc5PnUqIhw==
Message-ID: <1ff5bebd-1d7e-45e7-87a7-27ea57865063@kernel.org>
Date: Fri, 12 Sep 2025 10:34:05 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/5] platform/chrome: Fix a possible UAF via revocable
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Tzung-Bi Shih <tzungbi@kernel.org>, Benson Leung <bleung@chromium.org>,
 "Rafael J . Wysocki" <rafael@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <shuah@kernel.org>, Dawid Niedzwiecki <dawidn@google.com>,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 chrome-platform@lists.linux.dev, linux-kselftest@vger.kernel.org,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
 Wolfram Sang <wsa+renesas@sang-engineering.com>
References: <20250912081718.3827390-1-tzungbi@kernel.org>
 <2025091224-blaming-untapped-6883@gregkh>
From: Danilo Krummrich <dakr@kernel.org>
Content-Language: en-US
In-Reply-To: <2025091224-blaming-untapped-6883@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/12/25 10:30 AM, Greg Kroah-Hartman wrote:
> Also, Danilo, if you get the chance, can you give this a review as well?
> At first glance it looks good to me, but as you wrote the Rust
> implementation of this feature, a second pair of eyes would be great to
> have if you have the time.

Sure, I will follow up on this later today.

