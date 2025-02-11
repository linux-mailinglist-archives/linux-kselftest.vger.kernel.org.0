Return-Path: <linux-kselftest+bounces-26404-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D6EE4A313A5
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Feb 2025 19:00:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8BB7A167664
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Feb 2025 18:00:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E0611E5B62;
	Tue, 11 Feb 2025 18:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="odGOWcaY"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75C4F261595;
	Tue, 11 Feb 2025 18:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739296807; cv=none; b=hAizhPc2jDJJfbO+wJAFgPE3WBbso6eKC+wBZBibxv6FqbtdJr/3/R2k/KnL7xh1ErAY6OS7wSkVnyAO/WMq6WvMyrYlKtID5g8lnJrLyc1AwejLbAMLpvbKRy3NIuyBZNkLpbC+mUOg06Ez0hW1sY34FmVGBe67d0LBhI5oSss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739296807; c=relaxed/simple;
	bh=UwvRs8pwFAJ6JeV5xxEyLtwclB0ZDjxvlAJA9mgKqhw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FUZ4497Ew1zksOtexrpYs5jRhI6OWJgMuIaZ8C14+9gXY1kagUnVRMSWsI5xpqOvwTcbjAyzb25SBGPTR3uqv0ewANsu849ixG3IVqCJWfb6C3Px24Ui+QQeZL5kUoeY0JnEbdKWqhTgYYyxBuodmfkH7KKZ++5Adw3yY+KfJYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=odGOWcaY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEBA1C4CEDD;
	Tue, 11 Feb 2025 18:00:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739296806;
	bh=UwvRs8pwFAJ6JeV5xxEyLtwclB0ZDjxvlAJA9mgKqhw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=odGOWcaY02eC9ZmWOnctZ4yOtbBxji73PMEk1FDdZDuK+fi3ucHv/x6t9nQOaKAK7
	 AGUoOl7pYQeSRlRI5mpn6bV2nO77R4uaqfvqRYkvbBz+zjyhd8Vj4oh1lV570HQ7DA
	 KCKmMxCwkJH6xt/tNnYaUSfYqM4tHzVbLbXAMCKg3YTisFNB49q8pMSKSc3Owu2a9T
	 Hq7rY+tQjgFE9oztTH8g3Fa2A7065Kq+zuNa6DKLxMVJS+0u0tMv6rIKlHKOddZSCI
	 QujNwOE10Ml1r/6vWq6pBQTlN+76tmlxZLQ/WJrd2+xRtki6iZsydV/2WlQSOK1GU8
	 285ZQxf9suUNA==
Date: Tue, 11 Feb 2025 18:00:03 +0000
From: Simon Horman <horms@kernel.org>
To: Pranav Tyagi <pranav.tyagi03@gmail.com>
Cc: linux-kselftest@vger.kernel.org, linux-kernel-mentees@lists.linux.dev,
	skhan@linuxfoundation.org
Subject: Re: [PATCH] selftests: net: fix grammar in
 reuseaddr_ports_exhausted.c log message
Message-ID: <20250211180003.GA1626852@kernel.org>
References: <20250211170633.4458-1-pranav.tyagi03@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250211170633.4458-1-pranav.tyagi03@gmail.com>

On Tue, Feb 11, 2025 at 10:36:33PM +0530, Pranav Tyagi wrote:
> This patch fixes a grammatical error in a test log message in
> reuseaddr_ports_exhausted.c for better clarity as a part of lfx
> application tasks
> 
> Signed-off-by: Pranav Tyagi <pranav.tyagi03@gmail.com>

Hi Pranav,

As this is a patch for Networking it should probably be submitted to
netdev@vger.kernel.org and targeted at the net-next tree, like this:

	Subject: [PATCH net-next] ...

Please take a look over the document at the link below
and don't hesitate to reach out to me if you have any questions.

https://docs.kernel.org/process/maintainer-netdev.html

