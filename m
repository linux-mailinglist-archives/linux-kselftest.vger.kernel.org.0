Return-Path: <linux-kselftest+bounces-2082-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B748814CF1
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Dec 2023 17:24:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2BFF91C20F27
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Dec 2023 16:24:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C66D83C062;
	Fri, 15 Dec 2023 16:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="1ecKLawn"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C0C53BB2E;
	Fri, 15 Dec 2023 16:24:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DA47C433C8;
	Fri, 15 Dec 2023 16:24:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1702657465;
	bh=3ivctDNpxY6QN16Fx9iYaWrSP3bP36OnVGA1x0bMy7w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=1ecKLawnXRWIdI/i7mKpw840sXuWr4k8MRWaZ3qDBAoNDxF8hp4n/Y/EQqig5ct6M
	 q3OSxVI3cODnARqGoa06xs6iFe//H657653/uumd4qLZ+YQFrZOffqDlsFmJBcUHQx
	 U5FChq/bAohwoFx5J3qjTOrzqkAYQaSITTgejdcw=
Date: Fri, 15 Dec 2023 17:24:22 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: davidgow@google.com
Cc: Rae Moar <rmoar@google.com>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Jonathan Corbet <corbet@lwn.net>, Kees Cook <keescook@chromium.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>, Maxime Ripard <mripard@kernel.org>,
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org, linux-sound@vger.kernel.org
Subject: Re: [PATCH v4 1/5] kunit: Add APIs for managing devices
Message-ID: <2023121512-handcuff-unstable-63ed@gregkh>
References: <20231215-kunit_bus-v4-0-4f5160e2f95e@google.com>
 <20231215-kunit_bus-v4-1-4f5160e2f95e@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231215-kunit_bus-v4-1-4f5160e2f95e@google.com>

On Fri, Dec 15, 2023 at 03:39:08PM +0800, davidgow@google.com wrote:
> Tests for drivers often require a struct device to pass to other
> functions. While it's possible to create these with
> root_device_register(), or to use something like a platform device, this
> is both a misuse of those APIs, and can be difficult to clean up after,
> for example, a failed assertion.
> 
> Add some KUnit-specific functions for registering and unregistering a
> struct device:
> - kunit_device_register()
> - kunit_device_register_with_driver()
> - kunit_device_unregister()
> 
> These helpers allocate a on a 'kunit' bus which will either probe the
> driver passed in (kunit_device_register_with_driver), or will create a
> stub driver (kunit_device_register) which is cleaned up on test shutdown.
> 
> Devices are automatically unregistered on test shutdown, but can be
> manually unregistered earlier with kunit_device_unregister() in order
> to, for example, test device release code.
> 
> Reviewed-by: Matti Vaittinen <mazziesaccount@gmail.com>
> Reviewed-by: Maxime Ripard <mripard@kernel.org>
> Signed-off-by: David Gow <davidgow@google.com>

Nice work!

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

