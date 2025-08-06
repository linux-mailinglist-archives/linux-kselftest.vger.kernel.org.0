Return-Path: <linux-kselftest+bounces-38384-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D02CB1C8BC
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Aug 2025 17:29:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 704CA1677FF
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Aug 2025 15:29:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD857290D85;
	Wed,  6 Aug 2025 15:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="feyplrQT"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D588225A3B;
	Wed,  6 Aug 2025 15:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754494175; cv=none; b=ahMjrM8yTYvvfFvlB2NHcSRN8K5/fwsgT9KtUK//nAXfUkDHXfF1fyWOkbKlibhCFcyJjMl9//94uhOFKiz9rxuQgOcvSAWjSHKOCzfcddl6fksifeW7WbiPsgZalOgjyqDUvgMz2UQk2FMgzyQdsG/5vDXPGaqYPCZqcLg9uoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754494175; c=relaxed/simple;
	bh=NcLJ+jxeVplExqStl8FnXa6rqScPexrHTp15tSKQZ5c=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CS/XxgageBlDDiITQZURiAKM17a06lxRqhpXXPRS8+9OULo0D/KnKv+LCMW7MKTLCmbaKtWzM1DIp8q0yIyT7NRbsMrOtaOUVg8T93SNcz9xvcRjMVNYb+JYOlCJxFF22sNEDWfQfuG0dqnAqAtlseohrjjdEa0GGe2ZdXdH2RI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=feyplrQT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98BF3C4CEE7;
	Wed,  6 Aug 2025 15:29:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754494175;
	bh=NcLJ+jxeVplExqStl8FnXa6rqScPexrHTp15tSKQZ5c=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=feyplrQTIQt6p/3bfzbFcw0x34M3UHvWkGnO7XNa26HWsW6YAbWjYsk/pHpENVa2B
	 aXDwt/Dsro4pcTK9nKZeq4TF4IUwLMhuZqNE3+FCshAQSmhwoK77GucGgNDthA1WS3
	 eHLvNw16SA+O63Wr2d7mEoOCzaTQDeOmM96kt4PA4LWiVwd2UxVrMyFhXBZnAy8x/a
	 ADt9AEZkvmfIyk+W9wSRGKfk8q+xhLWkOB99Mjo273CvXCWdu9l2B0VQJovpqk6tIh
	 RPb63yulCIYQoiIUKYSzWILHq5xLUT+/vy4nHCZJURC/P/Ry9gfAn2ldlCrfkbA6oP
	 v0mE1gASkzhgw==
Date: Wed, 6 Aug 2025 08:29:33 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Pranav Tyagi <pranav.tyagi03@gmail.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, shuah@kernel.org, dw@davidwei.uk, haiyuewa@163.com,
 axboe@kernel.dk, netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kernel-mentees@lists.linux.dev
Subject: Re: [PATCH] selftests/drivers/net: replace typeof() with
 __auto_type
Message-ID: <20250806082933.4c1240c1@kernel.org>
In-Reply-To: <20250806082016.14891-1-pranav.tyagi03@gmail.com>
References: <20250806082016.14891-1-pranav.tyagi03@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed,  6 Aug 2025 13:50:16 +0530 Pranav Tyagi wrote:
> Replace typeof() with __auto_type in iou-zcrx.c.
> __auto_type was introduced in GCC 4.9 and reduces the compile time for
> all compilers. No functional changes intended.

Yet another unnecessary compiler feature. Please no.

