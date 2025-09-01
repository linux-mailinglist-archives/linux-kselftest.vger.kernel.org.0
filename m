Return-Path: <linux-kselftest+bounces-40489-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D0085B3EC91
	for <lists+linux-kselftest@lfdr.de>; Mon,  1 Sep 2025 18:45:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5FE0C188764D
	for <lists+linux-kselftest@lfdr.de>; Mon,  1 Sep 2025 16:46:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2ADA231827;
	Mon,  1 Sep 2025 16:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F3wJytxH"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C360A2E041D;
	Mon,  1 Sep 2025 16:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756745139; cv=none; b=hoeKjbR7ltgSG5A5etwNXo35B6Kgo43NunI3yXvEahJab77txYA4cezo2H1rbWQDrggIKsJljR25+Wo0EcZKpV0nAQ24rn9jfjvBUQ+QmARZ+/VeZDvjIhI2lnwWUKGqKxiX2nrGMbtGkdXRKKVR6XrCxfmpXoIhq04W9dbS1gY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756745139; c=relaxed/simple;
	bh=vcOo2Jfy+SmwX6fXVsiUz6MiJOOeVn48CYI7J5ImBJs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tWs/cLT3nOIBJHodZoinMqJjsfdCfYYKy9oSMQAetrUH2LS6FGoVqQv1WAs49oE96vMcXGWSP/+B6xjCEn7MMe3U6y+U2g08GdZ1xCI8M+1sDYrZyBI3LM/3CVNeeeSqhqnaN3zbf1bpZKgGkXk+gpI4wLXVFjbiyffwJvamNkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F3wJytxH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67538C4CEF0;
	Mon,  1 Sep 2025 16:45:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756745139;
	bh=vcOo2Jfy+SmwX6fXVsiUz6MiJOOeVn48CYI7J5ImBJs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=F3wJytxHthuUIlQbT4nFihrBwvd2Nzd1f9M2Q6vVYFM6BLc7dWKSAelvMTk2FXqbR
	 0po8QkqrsE9oiHXpFoOCmYv3LgtecLoP6JpBGZi+7KM4qQlEuiFXl9+dEUydk+mCGW
	 wLVwDZ5BoCrzQ+/zx2gotZTazjhIjru7NYDkwhIEn9oRus8Qf3GOqtsM3HSvI8CQsB
	 OcXj1DmKHn5P7H2R10es1WVw0O0wb0lXPS5uzaaG21QOMqtqrkmy0xSu8+V17NSXvi
	 S3cNi9jZwkPc4nMG9hxeJFZu7p09Hs9iaOKpbJwphFsp0Wus0AqP1cRZVeKgZEPxvk
	 0swPqVU2R5kEA==
Date: Mon, 1 Sep 2025 17:45:35 +0100
From: Simon Horman <horms@kernel.org>
To: Zongmin Zhou <min_halo@163.com>
Cc: kuba@kernel.org, davem@davemloft.net, edumazet@google.com,
	pabeni@redhat.com, shuah@kernel.org, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, netdev@vger.kernel.org,
	Zongmin Zhou <zhouzongmin@kylinos.cn>
Subject: Re: [PATCH v3] selftests: net: avoid memory leak
Message-ID: <20250901164535.GN15473@horms.kernel.org>
References: <20250829191537.4618f815@kernel.org>
 <20250901054557.32811-1-min_halo@163.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250901054557.32811-1-min_halo@163.com>

On Mon, Sep 01, 2025 at 01:45:57PM +0800, Zongmin Zhou wrote:
> From: Zongmin Zhou <zhouzongmin@kylinos.cn>
> 
> The buffer be used without free,fix it to avoid memory leak.
> 
> Signed-off-by: Zongmin Zhou <zhouzongmin@kylinos.cn>
> ---
> Changes in v3:
> - move freeaddrinfo() to a separate label.
> Changes in v2:
> - add the label to use instead of directly to use on each case.

Reviewed-by: Simon Horman <horms@kernel.org>


