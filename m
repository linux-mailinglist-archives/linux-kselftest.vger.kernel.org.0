Return-Path: <linux-kselftest+bounces-41403-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 109CBB55494
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Sep 2025 18:22:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C6B675A6B4E
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Sep 2025 16:22:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADC343191C7;
	Fri, 12 Sep 2025 16:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e5uF35DG"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A0463168FC;
	Fri, 12 Sep 2025 16:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757694173; cv=none; b=dZlquQ4oS35kjoLayhrolPsBOxwGhkG74yxHSLyMm+oXwUrh72S8KTnWKxgw54QX8lErT8iBQmFIzzlq17+Dd9MXnT3y+/0ymwj5nRHvVn28L70wriubiFIbKB0DmRBZaI5kYI/yurLYZ6lLEUgQIXz8TrIcSt7/IioFcnDL5qg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757694173; c=relaxed/simple;
	bh=6Tpu8MUm9Rx0ofTfEF8gpl0zbKPgVsQzRa8bbj3Hlm0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NPRhkqYAFpnBUwaDverIHJouJo1Y/g5KVFDgP3SrOEOLKWrlD3yXiikXCdKZo1iyFlMYm42Y9O8t3r/aggh1x/ZsP6QwJFAARhIsIIh1V+SJbg/ih0fi1dY8QEnp1zupQwdapLYBzNTY+zKM9OJT5C/fWFdPCLM5TcXuDywWYqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e5uF35DG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC871C4CEF4;
	Fri, 12 Sep 2025 16:22:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757694173;
	bh=6Tpu8MUm9Rx0ofTfEF8gpl0zbKPgVsQzRa8bbj3Hlm0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=e5uF35DGoCVbKYcyzGemD4NAmW6kUrLlwhUkC0sEsVkZRCJRSlMDCPL5FdEWHeiUH
	 /eBacKWXeLfYdTQZBZVQt3/Mbv7v6YANHR5qRkg8wzzsxS9XZACHy+/ezVfUxu2gLO
	 EjXtCXYAYfaq/zGZoArz5gaSKXwBPgF14jMGzJXRp94c2bxfX2DHzDRjJZjeNZozZ7
	 IVtl1b2p9JpdGxveNRa6jbZF5Hu/ihVC5Yv1Xz9emwtxXs+sOHw/tIrK+h3ausrCni
	 9hT/bl1pRRB51AhJVGH9OjfkaYvKBRhzHAbKwiThK6WjFFp9VPNZadlmUGElJJOPuV
	 zION3Kfq2IHMQ==
Message-ID: <1dc06657-e136-45c2-8012-9199194bfc9b@kernel.org>
Date: Fri, 12 Sep 2025 18:22:48 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/5] platform/chrome: Fix a possible UAF via revocable
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Bartosz Golaszewski <brgl@bgdev.pl>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Tzung-Bi Shih <tzungbi@kernel.org>,
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
 Krzysztof Kozlowski <krzk@kernel.org>, Benson Leung <bleung@chromium.org>,
 "Rafael J . Wysocki" <rafael@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <shuah@kernel.org>, Dawid Niedzwiecki <dawidn@google.com>,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 chrome-platform@lists.linux.dev, linux-kselftest@vger.kernel.org,
 Wolfram Sang <wsa+renesas@sang-engineering.com>,
 Dan Williams <dan.j.williams@intel.com>
References: <CACMJSeuKH+WKOXLNU92dMssqhK02xG3z=cT0VeXYM+ZGuPCB9g@mail.gmail.com>
 <aMQW2jUFlx7Iu9U5@tzungbi-laptop>
 <20250912132656.GC31682@pendragon.ideasonboard.com>
 <2025091209-curfew-safari-f6e0@gregkh>
 <CAMRc=MfdoB50o=3Q2p94o+f7S2Bzr=TAtWWQcDrC5Wf3Q5nqAA@mail.gmail.com>
 <20250912135916.GF31682@pendragon.ideasonboard.com>
 <2025091220-private-verse-d979@gregkh>
 <20250912142646.GI31682@pendragon.ideasonboard.com>
 <2025091237-cortex-carnage-5c34@gregkh>
 <CAMRc=Mf76m51VKktGc2K1uT4eacDqhsroRxG2RgtRyhQrhx0WA@mail.gmail.com>
 <20250912145416.GL31682@pendragon.ideasonboard.com>
From: Danilo Krummrich <dakr@kernel.org>
Content-Language: en-US
In-Reply-To: <20250912145416.GL31682@pendragon.ideasonboard.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 9/12/25 4:54 PM, Laurent Pinchart wrote:
> On Fri, Sep 12, 2025 at 04:44:56PM +0200, Bartosz Golaszewski wrote:
>> On Fri, Sep 12, 2025 at 4:40 PM Greg Kroah-Hartman
>> <gregkh@linuxfoundation.org> wrote:
>>> Either way, I think this patch series stands on its own, it doesn't
>>> require cdev to implement it, drivers can use it to wrap a cdev if they
>>> want to.  We have other structures that want to do this type of thing
>>> today as is proof with the rust implementation for the devm api.
>>
>> Yeah, I'm not against this going upstream. If more development is
>> needed for this to be usable in other parts of the kernel, that can be
>> done gradually. Literally no subsystem ever was perfect on day 1.
> 
> To be clear, I'm not against the API being merged for the use cases that
> would benefit from it, but I don't want to see drivers using it to
> protect from the cdev/unregistration race.

I mean, revocable is really a synchronization primitive in the end that
"revokes" access to some resource in a race free way.

So, technically, it probably belongs into lib/.

I think the reason it ended up in drivers/base/ is that one common use case is
to revoke a device resource from a driver when the device is unbound from this
driver; or in other words devres is an obvious user.

So, I think that any other API (cdev, devres, etc.) should  be built on top of it.

This is also what we do in Rust, Revocable is just a common synchronization
primitive and the (only) user it has is currently Devres building on top of it.

