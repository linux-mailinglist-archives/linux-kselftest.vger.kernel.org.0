Return-Path: <linux-kselftest+bounces-17057-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3175696A490
	for <lists+linux-kselftest@lfdr.de>; Tue,  3 Sep 2024 18:36:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B5B18288057
	for <lists+linux-kselftest@lfdr.de>; Tue,  3 Sep 2024 16:36:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01E7218BC2A;
	Tue,  3 Sep 2024 16:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UX4tknn3"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBF0918BC21;
	Tue,  3 Sep 2024 16:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725381229; cv=none; b=e6ycqXXxIf9RoiraUkYxc92fGjuE5F8z3gAwZUnMdLboTClb0JN5eL0pgvIxDsOBDk8zoaeT+5QJlYx0NJAuK5aJ1vutlCdIfZRXSmN2eB8FOoihl6AxK+In92XfAn8DixjLBRAPfZFu8Zuj1CBrk1z8vUWpOLfl41mEGC66h9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725381229; c=relaxed/simple;
	bh=6Yg57+zQA+RKWmFz3J/bXMbmOzlooEBeuFJW8RKYpCs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m8zKTWkOCjbM3vdeWh3et/dD+Jyt+6CLuwcE71wFsWJ5OoJ+6tYmOgIWTonafiUIRTMDWZEGFkh4+abx0Om0lAaUr6qPy8gl3c+/tk+vcXnAKXN/iotdfbn2yY8RQxGo+Zk+UJe1isY34BPZCN1ZnIUjWApipJ7IOC+nT0Gnk8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UX4tknn3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 809BDC4CEC4;
	Tue,  3 Sep 2024 16:33:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725381229;
	bh=6Yg57+zQA+RKWmFz3J/bXMbmOzlooEBeuFJW8RKYpCs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UX4tknn3dB/a1xd6T5HNUHWdMy2VHWAQDmQeJsHVDNf5LnlZXpEDciUwHj5UQPVlP
	 2I1w92GLzS4nbVeCFC4iLlLWcSs7WCBZ+1jkKXhHlfo0/WgPXv+MTUS72S0w3czXFy
	 21MNpyGzD9VFdzw00Ex8dQGBD1mrnc1FywAC0dTOboxPHSGmxbOpzAtd7OipDHR6aF
	 8CxUKe5MAyCLeioc2neMf4ZE1B913TXSeH0rDNXK4tJgFVgZcnvgW5UnDzUVjtRCjW
	 hI9KURcXhSpNSxX8XwYRiplKY99S7x73tMLBpZM73p4XK71brrMCYYj+VLLflczQH+
	 IMbc4ryW96syg==
Date: Tue, 3 Sep 2024 17:33:15 +0100
From: Simon Horman <horms@kernel.org>
To: Liu Jing <liujing@cmss.chinamobile.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, shuah@kernel.org, netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftests/net: do_setcpu function not need to have a
 return value
Message-ID: <20240903163315.GE4792@kernel.org>
References: <20240903095111.7204-1-liujing@cmss.chinamobile.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240903095111.7204-1-liujing@cmss.chinamobile.com>

On Tue, Sep 03, 2024 at 05:51:11PM +0800, Liu Jing wrote:
> in the do_setcpu, this function does not need to have a return value,
> which is meaningless
> 
> Signed-off-by: Liu Jing <liujing@cmss.chinamobile.com>

Thanks,

I also see that the caller does not check the return value.

Reviewed-by: Simon Horman <horms@kernel.org>

