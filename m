Return-Path: <linux-kselftest+bounces-43397-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A985DBEAB83
	for <lists+linux-kselftest@lfdr.de>; Fri, 17 Oct 2025 18:30:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 1C11835F5B8
	for <lists+linux-kselftest@lfdr.de>; Fri, 17 Oct 2025 16:30:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 520C82BE7CB;
	Fri, 17 Oct 2025 16:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nr/DQxOU"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21AC3286D55;
	Fri, 17 Oct 2025 16:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760718556; cv=none; b=fCQTi4DQHctMWAoltoZzwwhB1suYm66duCVrQKzwMaf7JakV7obWGAkZY3eiBgeAkXQVuQQwE4nFKfrk7tue6FPN/v/D7jLlBRSFUmVQBea/p3/kR0J1jZat1FnZct7MQgFCmCISKANFX4KWJgopoN4C+C36J/cxyje7PDvy+I0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760718556; c=relaxed/simple;
	bh=cxH8AEVNPDIQjHrSAWaXBFonbMHNK+hNSZlmONSJ1Lc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WHJBuUza3LLTEQCVJMEXGl2DfT0mDktC0OhuZNfVczZiLzNBs/6pxvndefmAuP0Hxk/j1R2A4/3WykMTyoJcuAZrn11eh8Goy1Avv/YzJY4rMG8ZcNleQHWF2Pc01rAXLtQENjenFUCsr2CAYxBQJJagCn8qIeO0In2z3zBck5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nr/DQxOU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DB29C4CEFE;
	Fri, 17 Oct 2025 16:29:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760718555;
	bh=cxH8AEVNPDIQjHrSAWaXBFonbMHNK+hNSZlmONSJ1Lc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Nr/DQxOUdu88qzYrbJUCP5f1PCgoSOkIdWC93VkPf32uAFWaBitVvaw1yZqG8XyU0
	 ap/rvH2rkoQ2IYesoAMG72rFZ24LLXBgWp+j36SoTB/PDk02bfp0GSSXSdsJyz5QHv
	 P62CuDLE166Zyz5Q3a8v6MNFkVazxjnMy3c9fyBy6k3DrwVEozUh40FY5HrFcr65Yr
	 rQhJenn1bOw7tTMMM3NL0PgC9fKu0ZM8PdELy7n99o6sULWghet/meuEed6XbFL31E
	 +ZIGs45QtrW7iQEWFPhF64p6DF+Lk1gOYYdsGrWhEXRDWUDRBJ9/MXThNFGipxJ5Fk
	 1mOZoWGJx8ALQ==
Message-ID: <009c8e5e-02d3-4017-bb84-e3a8f01b9dc9@kernel.org>
Date: Fri, 17 Oct 2025 18:29:10 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 5/7] revocable: Add fops replacement
To: Tzung-Bi Shih <tzungbi@kernel.org>
Cc: Jason Gunthorpe <jgg@nvidia.com>, Benson Leung <bleung@chromium.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J . Wysocki" <rafael@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <shuah@kernel.org>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, chrome-platform@lists.linux.dev,
 linux-kselftest@vger.kernel.org,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Bartosz Golaszewski <brgl@bgdev.pl>,
 Wolfram Sang <wsa+renesas@sang-engineering.com>,
 Simona Vetter <simona.vetter@ffwll.ch>,
 Dan Williams <dan.j.williams@intel.com>
References: <20251016054204.1523139-1-tzungbi@kernel.org>
 <20251016054204.1523139-6-tzungbi@kernel.org>
 <20251016123149.GA88213@nvidia.com> <aPGryj-V5PQZRtoI@google.com>
 <20251017134916.GK3901471@nvidia.com> <aPJp3hP44n96Rug9@tzungbi-laptop>
From: Danilo Krummrich <dakr@kernel.org>
Content-Language: en-US
In-Reply-To: <aPJp3hP44n96Rug9@tzungbi-laptop>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/17/25 6:07 PM, Tzung-Bi Shih wrote:
> Imagining:
> - Driver X provides the res1.
> - Driver Y provides the res2.
> - Driver Z provides the chardev /dev/zzz.  The file operations use res1
>   and res2.
> - A userspace program opened /dev/zzz.
> 
> In the approach, what is .remove() of driver X supposed to do when driver X
> is unbinding (e.g. due to device unplug)?

There are use-cases for revocable, but this example is a bit too generic:

Drivers don't just share device resources with other random drivers, they
usually have a defined relationship through a bus.

For instance, if you have a driver on the platform bus and another driver
connected through the auxiliary bus, there is a defined lifetime: The auxiliary
device has to be unbound before its parent device.

This means that as long as you are in a scope where your auxiliary device is
bound, it is safe to use a device resource from that parent without further checks.

The goal should always be to proof to be in such a scope when accessing device
resources (in Rust we can let the compiler ensure this at compile time :).

However, there are rare (yet valid) cases where such a scope can't be
guaranteed. DRM has such cases, and, unfortunately, MISC device seems to be
another one.

I know the reasons why DRM has to have this design, I'm not sure about MISC
device though. Unless there's a good reason, I think MISC device should be
"fenced" instead.

