Return-Path: <linux-kselftest+bounces-41290-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0084AB54567
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Sep 2025 10:30:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A03AA3B87AB
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Sep 2025 08:30:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 193F5262D14;
	Fri, 12 Sep 2025 08:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="kxGSdJrG"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C67DD1853;
	Fri, 12 Sep 2025 08:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757665849; cv=none; b=OUlXBlhFpYoe+5ReFNBqqmio0CDnqYdrDVp0LdILtoP92g76R+01tqPdE51pb5VOgsC2rlG2MWXYtlQKaiXHRpH3V7h/5prDU3/M5qShRXAJqS4TZKkfcGcz8x3KfC78lWG0qmXzKwEOXz0auxwnibSk4dFJv41iDiURURQCdDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757665849; c=relaxed/simple;
	bh=FucC4P8o0TptMas7mclBnXxe9nJiaVXXt/ty4BSyTfo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RYLCUCEB8wzsOhrJthBRzlxKqAlSZNEx8ftk8lYRNCzJiDWmAGtUAk5/UCng3+HnbfG3mRfrDGKb8dzNHuVlebsdhkJoMvfnbIW1It/Y7OvrRJLokgTMsMDhUnMn0AAlirMuHTlAu+eXguXH6JU+s24kbZTYdBJD5kHL/cnlHek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=kxGSdJrG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05329C4CEF4;
	Fri, 12 Sep 2025 08:30:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1757665848;
	bh=FucC4P8o0TptMas7mclBnXxe9nJiaVXXt/ty4BSyTfo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kxGSdJrGUQH8urbf/HkbGg2OKldY5UAPUcZaiZ7ObeDY1TSmirM7e+vD4FJJPnjtK
	 6OJLnDvEZiGY43xLUJnm/28EVZntxigHA3/GFaUGWUCdH4Vy/tTYgJcH9DpwMKfzCZ
	 Q05Q2T5N8bsLXRVjxlnGZvNvbiJhF+vmuBZk82oc=
Date: Fri, 12 Sep 2025 10:30:45 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Tzung-Bi Shih <tzungbi@kernel.org>
Cc: Benson Leung <bleung@chromium.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>,
	Dawid Niedzwiecki <dawidn@google.com>, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, chrome-platform@lists.linux.dev,
	linux-kselftest@vger.kernel.org,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: Re: [PATCH v3 0/5] platform/chrome: Fix a possible UAF via revocable
Message-ID: <2025091224-blaming-untapped-6883@gregkh>
References: <20250912081718.3827390-1-tzungbi@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250912081718.3827390-1-tzungbi@kernel.org>

On Fri, Sep 12, 2025 at 08:17:12AM +0000, Tzung-Bi Shih wrote:
> This is a follow-up series of [1].  It tries to fix a possible UAF in the
> fops of cros_ec_chardev after the underlying protocol device has gone by
> using revocable.
> 
> The 1st patch introduces the revocable which is an implementation of ideas
> from the talk [2].
> 
> The 2nd and 3rd patches add test cases for revocable in Kunit and selftest.
> 
> The 4th patch converts existing protocol devices to resource providers
> of cros_ec_device.
> 
> The 5th patch converts cros_ec_chardev to a resource consumer of
> cros_ec_device to fix the UAF.
> 
> [1] https://lore.kernel.org/chrome-platform/20250721044456.2736300-6-tzungbi@kernel.org/
> [2] https://lpc.events/event/17/contributions/1627/
> 
> Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>

This is, frankly, wonderful work.  Thanks so much for doing this, it's
what many of us have been wanting to see for a very long time but none
of us got around to actually doing it.

And it has tests!  And documentation!  Couldn't ask for more.

We can bikeshed about the REVOCABLE() macro name, but frankly, you wrote
it, you get to pick it :)

Laurent, Bartosz, Wolfram, any objection to this series?  I think this
addresses the issues that all of you have been raising for years with
our access of pointers that have different lifecycles from other
structures (i.e. struct cdev from struct device).

Also, Danilo, if you get the chance, can you give this a review as well?
At first glance it looks good to me, but as you wrote the Rust
implementation of this feature, a second pair of eyes would be great to
have if you have the time.

thanks,

greg k-h

