Return-Path: <linux-kselftest+bounces-41384-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CD75B54F7F
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Sep 2025 15:27:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3ADDC7A486E
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Sep 2025 13:25:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34A77309DCB;
	Fri, 12 Sep 2025 13:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="AgzKqxck"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64AC881ACA;
	Fri, 12 Sep 2025 13:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757683651; cv=none; b=kyz+XEttX4BiKu/8Hux/nMWzaQD2Nsd4CRFsQnPRfnbQ0WKtb32ZqurnnQ4p9BOW3dMrCTy485BrFX9mzf6iEhfxQX8HObqcK/ep1IXlT6MDsRjzfnY7YXo6rmx3R0XjlcdACTlt1GGk2VCiIhEAa8dB/u5Y7KAPnNd81E63vFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757683651; c=relaxed/simple;
	bh=YRt/SbmBWeL8XPMgefUYTLtsB34qC53Zp3mKMWWmi+M=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=BEWyQydxUg+oQcpGK8xEoT8pSnGwh+EzCkLGmiqSmir/cZw63E9nI17SJay6sbdxB4EzJGk+F9hOUveD65hiJF8cTcXdO0V1/Hgz4FfsgXQaB0aDJqwLLlZ6L+bX7v8ERgPfoygbV9nN3F/Lqh0Wn+dh68oA3Kc/bIL9/R20shY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=AgzKqxck; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 149A640AF9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1757683648; bh=AbWZL4RM/Yp5wx7nOKC9LTy37m3PY7b7t7emap/6BTk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=AgzKqxckYT1IEdgDOIbwVz64MpLA0zpFibtc7YMfFt346WuXWliiSqkSF0cDdAkSa
	 +UMVqi80qsI8/MPovHZqGW5RgwjB7ABW2HNA0PcbJlkcTJ7nryc2Fsc3wXqb4TCWu0
	 /bybcmFES+YAIp+VZH5mKb9KhgQDfCZMQv9NnklcZOoQwFc1YiXiIAKZKFx/l+cnJS
	 TIiTa9MLeREAryxqLruX8jCmCoRFQiE16beZUmAjsOeaa/19QUqHQPhpylO8OY0TSE
	 kAITZkZ4DvsRZGJvyuHPWw/pASCw9xIwumx5cGo9sBGmurB6YvbWILWvr8WfrSst0S
	 fuNkBzb7ZUAXA==
Received: from localhost (unknown [IPv6:2601:280:4600:2da9::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 149A640AF9;
	Fri, 12 Sep 2025 13:27:28 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Tzung-Bi Shih <tzungbi@kernel.org>, Benson Leung <bleung@chromium.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J . Wysocki"
 <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>
Cc: Shuah Khan <shuah@kernel.org>, Dawid Niedzwiecki <dawidn@google.com>,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 chrome-platform@lists.linux.dev, linux-kselftest@vger.kernel.org,
 tzungbi@kernel.org
Subject: Re: [PATCH v3 1/5] revocable: Revocable resource management
In-Reply-To: <20250912081718.3827390-2-tzungbi@kernel.org>
References: <20250912081718.3827390-1-tzungbi@kernel.org>
 <20250912081718.3827390-2-tzungbi@kernel.org>
Date: Fri, 12 Sep 2025 07:27:26 -0600
Message-ID: <87v7lnn6m9.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Tzung-Bi Shih <tzungbi@kernel.org> writes:

> Some resources can be removed asynchronously, for example, resources
> provided by a hot-pluggable device like USB.  When holding a reference
> to such a resource, it's possible for the resource to be removed and
> its memory freed, leading to use-after-free errors on subsequent access.

Far be it from me to complain about a new feature that comes with nice
documentation!  I will make one small observation, though, for
consideration.

We have the document itself:

> diff --git a/Documentation/driver-api/driver-model/revocable.rst b/Documentation/driver-api/driver-model/revocable.rst
> new file mode 100644
> index 000000000000..b9e2968ba9c1
> --- /dev/null
> +++ b/Documentation/driver-api/driver-model/revocable.rst
> @@ -0,0 +1,151 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +==============================
> +Revocable Resource Management
> +==============================
> +
> +Overview
> +========
> +
> +In a system with hot-pluggable devices, such as USB, resources provided by
> +these devices can be removed asynchronously.  If a consumer holds a reference
> +to such a resource, the resource might be deallocated while the reference is
> +still held, leading to use-after-free errors upon subsequent access.
> +
> +The "revocable" mechanism addresses this by establishing a weak reference to a
> +resource that might be freed at any time.  It allows a resource consumer to
> +safely attempt to access the resource, guaranteeing that the access is valid
> +for the duration of its use, or it fails safely if the resource has already
> +been revoked.

[...]

Then there is the in-code documentation:

> diff --git a/drivers/base/revocable.c b/drivers/base/revocable.c
> new file mode 100644
> index 000000000000..80a48896b241
> --- /dev/null
> +++ b/drivers/base/revocable.c
> @@ -0,0 +1,229 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright 2025 Google LLC
> + *
> + * Revocable resource management
> + */
> +
> +#include <linux/device.h>
> +#include <linux/kref.h>
> +#include <linux/revocable.h>
> +#include <linux/slab.h>
> +#include <linux/srcu.h>
> +
> +/**
> + * DOC: Overview
> + *
> + * Some resources can be removed asynchronously, for example, resources
> + * provided by a hot-pluggable device like USB.  When holding a reference
> + * to such a resource, it's possible for the resource to be removed and
> + * its memory freed, leading to use-after-free errors on subsequent access.
> + *
> + * Introduce the revocable to establish weak references to such resources.
> + * It allows a resource consumer to safely attempt to access a resource
> + * that might be freed at any time by the resource provider.
> + *
> + * The implementation uses a provider/consumer model built on Sleepable
> + * RCU (SRCU) to guarantee safe memory access:
> + *
> + * - A resource provider allocates a struct revocable_provider and
> + *   initializes it with a pointer to the resource.

There is a certain amount of duplication here, stuff that might go out
of sync at some point.  I would consider pushing the bulk of the
information into the kerneldoc comments, then actually *using* those
comments in the .rst file (with kernel-doc directives) to create the
rendered version.

Thanks,

jon

