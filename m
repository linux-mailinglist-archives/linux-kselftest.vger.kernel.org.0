Return-Path: <linux-kselftest+bounces-45015-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 55431C3C6F2
	for <lists+linux-kselftest@lfdr.de>; Thu, 06 Nov 2025 17:31:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F9F11883550
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Nov 2025 16:27:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B30A357A4A;
	Thu,  6 Nov 2025 16:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UrLWfCfw"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA1E9357A32;
	Thu,  6 Nov 2025 16:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762446024; cv=none; b=ZSjcFtbc+SP7ou7i7aKkQMnxll6YBOqdVR+uZamTHnOXYJeO5OHzyrSJzeK6r/pJRVqvbdvB7GdGZeuAsff9NZhzx4Voch+YeuMxgIwHBtB89ccTCDHtKepn5pMIU+OmCLJbH6JNi4HMTqNYJdMMCddw0pdxS4lNBSGPl4B9HD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762446024; c=relaxed/simple;
	bh=u1mSWRYOwCwv2B/8Obub4YdH/xuVzupR6Fxm7Fdfab0=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=S6pXe7Re6s0Jzxsls2I+q0Ls1ikxyhAplnvkr/fSRn/9wm/tCbW0OrmbMxXXgmTSZoxYvF+PjpWvr0ncOXXs62IIGeQnr9UHYAd/MkRMKsB6yTd2Bnj89QePLMMOhFMMB7UOduLMNfrj+mrsxNQ0cRZBcRvyDVtx+ecMKQsbhJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UrLWfCfw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACBF1C4CEFB;
	Thu,  6 Nov 2025 16:20:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762446022;
	bh=u1mSWRYOwCwv2B/8Obub4YdH/xuVzupR6Fxm7Fdfab0=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=UrLWfCfwZ5CKz2ITptJHVyNVpORTo+o/BscLQuTrAjWiclPOvrcEWv/oVtZpcodeu
	 j1EIP67rJuOkw1/CJa+koFfkc1rZwdfPmM713rC/ChWCB6Y4a+9GlTnED++zKPHvN7
	 T7TyZ3xo1i3wlfH1koFOhXvDjWzHPAsPcWA6GvqivRm02TGKwRxa0nkIKy/sYZKhyL
	 img7O+ujQCHT8/s+zcjoQhZP5k7WHeWZECKlLPYuyh3CEZ0968gm/+0Jh83TSek0sK
	 ym9+wlO86aeC1oc+nTWFt6PaZslPae+oWSQv+aQogtUZSsBjHDDeX7Wft4Ql/n38Ei
	 LRa9/5yH3GxNg==
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 06 Nov 2025 17:20:17 +0100
Message-Id: <DE1QYZ73VEDY.3UGO41S4PAEVK@kernel.org>
Subject: Re: [PATCH v6 1/3] revocable: Revocable resource management
Cc: "Benson Leung" <bleung@chromium.org>, "Greg Kroah-Hartman"
 <gregkh@linuxfoundation.org>, "Rafael J . Wysocki" <rafael@kernel.org>,
 "Jonathan Corbet" <corbet@lwn.net>, "Shuah Khan" <shuah@kernel.org>,
 <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <chrome-platform@lists.linux.dev>, <linux-kselftest@vger.kernel.org>,
 "Laurent Pinchart" <laurent.pinchart@ideasonboard.com>, "Bartosz
 Golaszewski" <brgl@bgdev.pl>, "Wolfram Sang"
 <wsa+renesas@sang-engineering.com>, "Simona Vetter"
 <simona.vetter@ffwll.ch>, "Dan Williams" <dan.j.williams@intel.com>, "Jason
 Gunthorpe" <jgg@nvidia.com>
To: "Tzung-Bi Shih" <tzungbi@kernel.org>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20251106152330.11733-1-tzungbi@kernel.org>
 <20251106152330.11733-2-tzungbi@kernel.org>
In-Reply-To: <20251106152330.11733-2-tzungbi@kernel.org>

On Thu Nov 6, 2025 at 4:23 PM CET, Tzung-Bi Shih wrote:
> +Revocable vs. Device-Managed (devm) Resources
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +It's important to understand the distinction between a standard
> +device-managed (devm) resource and a resource managed by a revocable pro=
vider.
> +
> +The key difference is their lifetime:
> +
> +*   A **devm resource** is tied to the lifetime of the device.  It is
> +    automatically freed when the device is unbound.
> +*   A **revocable provider** persists as long as there are active refere=
nces
> +    to it from consumer handles.
> +
> +This means that a revocable provider can outlive the device that created
> +it.  This is a deliberate design feature, allowing consumers to hold a
> +reference to a resource even after the underlying device has been remove=
d,

This seems wrong, the consumer does not hold a reference to the encapsulate=
d
resource, it holds a reference to the revocable object itself.

The resource itself may be revoked at any point of time -- usually by devre=
s,
but can be anything.

This makes revocable an independent synchronization primitive -- which admi=
ttedly
is mainly designed for (device) resources. Yet, it's independent.

In comparison, devres manages the lifetime of a resource, while ignoring if
there are active users or not.

Hence, I think the description needs some adjustments, as it makes it sound=
s as
if they're the same thing with different lifetime patterns, while they're
fundamentally different components.

I'd rather explain how revocable can complement devres.

> +/**
> + * DOC: Overview
> + *
> + * Some resources can be removed asynchronously, for example, resources
> + * provided by a hot-pluggable device like USB.  When holding a referenc=
e
> + * to such a resource, it's possible for the resource to be removed and
> + * its memory freed, leading to use-after-free errors on subsequent acce=
ss.
> + *
> + * The "revocable" mechanism addresses this by establishing a weak refer=
ence
> + * to a resource that might be freed at any time.  It allows a resource
> + * consumer to safely attempt to access the resource, guaranteeing that =
the
> + * access is valid for the duration of its use, or it fails safely if th=
e
> + * resource has already been revoked.

Here you start the documentation with _how_ revocable can be used, but I'd
rather start with explaining what it is, i.e. explain that it is a
synchronization primitive manages the access to an object that can
asynchronously be revoked, etc.

I'd move the example use-case below that.

The code itself LGTM, hence with the above addressed,

Acked-by: Danilo Krummrich <dakr@kernel.org>

