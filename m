Return-Path: <linux-kselftest+bounces-35089-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 68532ADB5CD
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Jun 2025 17:46:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 335681890C23
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Jun 2025 15:46:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1235126463A;
	Mon, 16 Jun 2025 15:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pYq4N3To"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5F912820A7;
	Mon, 16 Jun 2025 15:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750088732; cv=none; b=gt6d4cfT68A0PjoAraNbsPT4dyOUlKpN5LJZ3rnrUhDGqXOg8MLRlLIkTnpbEWsVpBKS1AquvIX7of0tICzgWnJcO3NjKiJOFdbyw9LO+eYRIrIozu99oUBSKwifTK/wzeY2JkSQYIgaS1v7T8bH9q9q8S+A6q1VYkxOrfivr4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750088732; c=relaxed/simple;
	bh=eqJ2tUOlRedBHMVbikQn7vNqvx6tJ1bIb0c2oc4h4Tw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mrv5FmdUUKETHNhxI1CcAAuk8BdbXuUnpa27zOJ4zzGWD3vcRJz1GFsd9RHHBdgNvVw6GErjpqmp7Mke0HivkZL7BcogSKb7exQh+nNQARLRX0bJKY9QPIBpFW219tKT+56TLJLM3N/lumjGdoQH31DuqbyR3z+OqZ0pW7Vd1xc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pYq4N3To; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0DC0C4CEEA;
	Mon, 16 Jun 2025 15:45:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750088732;
	bh=eqJ2tUOlRedBHMVbikQn7vNqvx6tJ1bIb0c2oc4h4Tw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pYq4N3Tos+t+xCWWobu7NtpNPLamy0Su2zM4QYU7nSLMawYdD4/RxeMFgfM4dfmtw
	 Js/SutomzUuW6mxoC5/sejZoBS5CA3OjoTRfurHpIc2kA5tBR2d/KlOquAHEFnjbat
	 shHNUdr+KWbge266SdkeYD5U43gMLm9/8ZpjJ3vjID1U/iBsDQAIUoqhzCUvfz4frM
	 gKMN8GL05cE2VciLKCQQs/1FpOzEiNj90+Ou7T1gvnZqXnZL6IQBuE2x35HWpS1Qbm
	 jFo0B/a8OQmONb0+MDcxtw2dFb6sSn42B/g5ViWHmrSI2/7rgAh+K2wwxsUtH2MotX
	 5viPbpdJNGf9A==
Date: Mon, 16 Jun 2025 16:45:28 +0100
From: Simon Horman <horms@kernel.org>
To: Alok Tiwari <alok.a.tiwari@oracle.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, shuah@kernel.org,
	linux-kselftest@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, darren.kenny@oracle.com
Subject: Re: [PATCH v2] selftests: nettest: Fix typo in log and error
 messages for clarity
Message-ID: <20250616154528.GF6918@horms.kernel.org>
References: <20250615084822.1344759-1-alok.a.tiwari@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250615084822.1344759-1-alok.a.tiwari@oracle.com>

On Sun, Jun 15, 2025 at 01:48:12AM -0700, Alok Tiwari wrote:
> This patch corrects several logging and error message in nettest.c:
> - Corrects function name in log messages "setsockopt" -> "getsockopt".
> - Closes missing parentheses in "setsockopt(IPV6_FREEBIND)".
> - Replaces misleading error text ("Invalid port") with the correct
>   description ("Invalid prefix length").
> - remove Redundant wording like "status from status" and clarifies
>   context in IPC error messages.
> 
> These changes improve readability and aid in debugging test output.
> 
> Signed-off-by: Alok Tiwari <alok.a.tiwari@oracle.com>
> ---
> v1 ->v2
> remove extra space

Reviewed-by: Simon Horman <horms@kernel.org>


