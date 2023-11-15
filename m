Return-Path: <linux-kselftest+bounces-155-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 67F147EC7E5
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Nov 2023 16:52:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EA496B20B57
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Nov 2023 15:52:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01132433A8;
	Wed, 15 Nov 2023 15:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iuMFnn6B"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D12703172D;
	Wed, 15 Nov 2023 15:51:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC229C433C7;
	Wed, 15 Nov 2023 15:51:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700063515;
	bh=UtU8CmcT9tpGHDF8mWEF6lFxjr7HU9BJf79DrVfL3XU=;
	h=Date:From:To:Subject:In-Reply-To:References:Cc:From;
	b=iuMFnn6BH+6Tq7rWCf8rAh96nJnt5f3Kk8u85KM1oUuAshrXF5yfT2ZxUIemM4hEp
	 svANmekp8cG29Hx+ZsTFl4Sy3nO8hxZWNCmAqg3vP/F597iyH+1SG89CVP/unwZM3N
	 D0BJqSdywTPPoTUkN4Q/wPI9mR2iQNkTJwcKJ1BJvuMC3GEPMWf+UfZZ3K1SJSxQul
	 j/hoNezC0BYXRb9BPl8R74v+Sj0JuMeGvn9JTaayNeQE6nJDaZxiDUUZK6vGnfBV29
	 j0B9/cZthBdiWHKlV3NZjxvM9ddaiqlE47Ve3Maa8mJZ4XxDOupKXebfSdpQb4Ax/k
	 QtYwIwHUO7mAA==
Message-ID: <4e0c8bb796a67af5fb901f831c5f87fe.mripard@kernel.org>
Date: Wed, 15 Nov 2023 15:51:52 +0000
From: "Maxime Ripard" <mripard@kernel.org>
To: "David Gow" <davidgow@google.com>
Subject: Re: [PATCH 1/3] kunit: Add a macro to wrap a deferred action
 function
In-Reply-To: <20231110200830.1832556-1-davidgow@google.com>
References: <20231110200830.1832556-1-davidgow@google.com>
Cc: dlatypov@google.com, dri-devel@lists.freedesktop.org, kunit-dev@googlegroups.com, linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, llvm@lists.linux.dev, "Arthur
 Grillo" <arthurgrillo@riseup.net>, "Benjamin Berg" <benjamin.berg@intel.com>, "Brendan
 Higgins" <brendan.higgins@linux.dev>, "Daniel Vetter" <daniel@ffwll.ch>, "David
 Airlie" <airlied@gmail.com>, "Emma Anholt" <emma@anholt.net>, "Kees Cook" <keescook@chromium.org>, "Maarten
 Lankhorst" <maarten.lankhorst@linux.intel.com>, "Maxime Ripard" <mripard@kernel.org>,
 =?utf-8?b?TWHDrXJhIENhbmFs?= <mairacanal@riseup.net>, "Nathan Chancellor" <nathan@kernel.org>, "Rae
 Moar" <rmoar@google.com>, "Richard Fitzgerald" <rf@opensource.cirrus.com>, "Sami
 Tolvanen" <samitolvanen@google.com>, "Shuah Khan" <skhan@linuxfoundation.org>, "Thomas
 Zimmermann" <tzimmermann@suse.de>
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>

On Sat, 11 Nov 2023 04:08:26 +0800, David Gow wrote:
> KUnit's deferred action API accepts a void(*)(void *) function pointer
> which is called when the test is exited. However, we very frequently
> want to use existing functions which accept a single pointer, but which
> may not be of type void*. While this is probably dodgy enough to be on
> the wrong side of the C standard, it's been often used for similar
> 
> [ ... ]

Reviewed-by: Maxime Ripard <mripard@kernel.org>

Thanks!
Maxime

