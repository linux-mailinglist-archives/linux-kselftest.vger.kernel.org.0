Return-Path: <linux-kselftest+bounces-11206-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5A9B8FB4EB
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Jun 2024 16:12:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0CE191C22538
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Jun 2024 14:12:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 041D8136E2A;
	Tue,  4 Jun 2024 14:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="pd1OgHOf"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A526A134409;
	Tue,  4 Jun 2024 14:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717510340; cv=none; b=UDpmcvsbddak9Gn/32awk7JxTqqnNW+8IYNo3M4fhe++wTwHkhr9daI3jQYRVV0toAvuHCNRpwVphJPy4oIXQWe7xDmN2ntUzN3efmh04Sb6hGPnPQpQbMFK9KJ3DXJScyIYwmJ4yUJxpl9aI/0/US2fBEqvVVCV6ZysdauBGzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717510340; c=relaxed/simple;
	bh=a+dh7jhzlHhwln90offyZoiN+B1RFJofWEM3+SwHlVk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rTtR5yqnjCKNwYjpd0+0gu+1P4joD7L2YAP55Mk2+ehaptlJzNY7zdtdevVXNMZkRqscZa0/ANLXUlTKsWzZHniLZsW7wtCOQWFl9Woqg9jED/stHvPlTo99jkfMt0cLNunVN6GfaXYbdeRow4LrqbQqFrpW9nF7YnSUBB0PjEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=pd1OgHOf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61F7BC32786;
	Tue,  4 Jun 2024 14:12:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1717510340;
	bh=a+dh7jhzlHhwln90offyZoiN+B1RFJofWEM3+SwHlVk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pd1OgHOfoDM8EnggG7+pJFqnZGPBRXKf1p19Hkw8gIOj0vTIDFd8tqcqkmGwpKdyo
	 tofQyVfh5WlIA/S31F61Z5naCXDj855GpWEYV+cYU7QcJnHh9hNoMCXgKsAsf0lmV1
	 AUb21ZBtGnjdRUE3Nyb6ltfmQ4lRiHCQxMQ8wVJo=
Date: Tue, 4 Jun 2024 15:48:58 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Stephen Boyd <sboyd@kernel.org>
Cc: Michael Turquette <mturquette@baylibre.com>,
	linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
	patches@lists.linux.dev, kunit-dev@googlegroups.com,
	linux-kselftest@vger.kernel.org, devicetree@vger.kernel.org,
	Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Saravana Kannan <saravanak@google.com>,
	Daniel Latypov <dlatypov@google.com>,
	Christian Marangi <ansuelsmth@gmail.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Maxime Ripard <maxime@cerno.tech>
Subject: Re: [PATCH v5 06/11] platform: Add test managed
 platform_device/driver APIs
Message-ID: <2024060445-reverse-defendant-ec52@gregkh>
References: <20240603223811.3815762-1-sboyd@kernel.org>
 <20240603223811.3815762-7-sboyd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240603223811.3815762-7-sboyd@kernel.org>

On Mon, Jun 03, 2024 at 03:38:03PM -0700, Stephen Boyd wrote:
> Introduce KUnit resource wrappers around platform_driver_register(),
> platform_device_alloc(), and platform_device_add() so that test authors
> can register platform drivers/devices from their tests and have the
> drivers/devices automatically be unregistered when the test is done.
> 
> This makes test setup code simpler when a platform driver or platform
> device is needed. Add a few test cases at the same time to make sure the
> APIs work as intended.
> 
> Cc: Brendan Higgins <brendan.higgins@linux.dev>
> Cc: David Gow <davidgow@google.com>
> Cc: Rae Moar <rmoar@google.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> Signed-off-by: Stephen Boyd <sboyd@kernel.org>
> ---
>  Documentation/dev-tools/kunit/api/index.rst   |   5 +
>  .../dev-tools/kunit/api/platformdevice.rst    |  10 +
>  include/kunit/platform_device.h               |  20 ++
>  lib/kunit/Makefile                            |   4 +-
>  lib/kunit/platform-test.c                     | 223 +++++++++++++
>  lib/kunit/platform.c                          | 302 ++++++++++++++++++
>  6 files changed, 563 insertions(+), 1 deletion(-)
>  create mode 100644 Documentation/dev-tools/kunit/api/platformdevice.rst
>  create mode 100644 include/kunit/platform_device.h
>  create mode 100644 lib/kunit/platform-test.c
>  create mode 100644 lib/kunit/platform.c

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

