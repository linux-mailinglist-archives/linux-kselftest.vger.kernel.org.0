Return-Path: <linux-kselftest+bounces-43890-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 75118C02236
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Oct 2025 17:33:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 56E024EED70
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Oct 2025 15:33:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE3D533C520;
	Thu, 23 Oct 2025 15:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UWdbPyqa"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CD6A3148DA;
	Thu, 23 Oct 2025 15:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761233576; cv=none; b=uduOZJg1rlb91dQv+K4xwdgw2ziqncPk69kYjtBSkfTp02ZjmYCruWASoiEpGkq87cu/2e/x0LdmgN8UNBj0kmTaRCmuuwbhYCI4SP1WZeqRpNPMZt4mlywWcohexUt/xB2rh4iOztkx8fgBpc3BTdnijKD4CdUFMXLed9mpgeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761233576; c=relaxed/simple;
	bh=XWgIjgaPWWRK/K8ZkgpeSuSzQfaMGgBfkWqh/08psNA=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=buIWr5s4BvKD6nFP8murTR7FKQIDffuRNIP994XvcsBokfyp3Ppek7xLo4ZDbcvWqxuwRML22UKG8Awtq4nEdFqqEkTkROs3GGQykKJWhltEcsnZjC3ggANiVTaDLVd6aacJO9nI+A8RKC7CZEQE/hmQG7OxXVF1HV3p/tgQtIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UWdbPyqa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69860C4CEE7;
	Thu, 23 Oct 2025 15:32:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761233576;
	bh=XWgIjgaPWWRK/K8ZkgpeSuSzQfaMGgBfkWqh/08psNA=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To:From;
	b=UWdbPyqa/eWAUCsL6TzPRPggAxQQWmRNHjOxYHtiy6evueRxeUvtKRb9dGW4c90P6
	 pIyKAY0bmo/d3iOZDbOnOMMsnZemCOa5XWa+mclxGf0qrZzpec7LhB07pIAeHVCeRl
	 022nX9pTHkr9sNamsXdGzG05MgKbb+xc34827N7qToLfBDp4DclZxIbvhZSX+pTwAk
	 kUzBEZPF6Z+1v4KTXLxMnJFw0TDObLMn2dgBHvV62yI4ENPa7CrqpFPGE0WkctCV/o
	 iY5UEyA7FT07n7EDezsQjWrBNDWMA/O3XMw3XlhYaCZFUxVqMRNLGaqYFBQVKLSCkS
	 gLLCcyLy6yghQ==
Message-ID: <07ebf7d9-0071-483c-a68e-645853e83831@kernel.org>
Date: Thu, 23 Oct 2025 17:32:51 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Danilo Krummrich <dakr@kernel.org>
Subject: Re: [PATCH v5 5/7] revocable: Add fops replacement
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Tzung-Bi Shih <tzungbi@kernel.org>, Benson Leung <bleung@chromium.org>,
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
References: <20251016054204.1523139-6-tzungbi@kernel.org>
 <20251016123149.GA88213@nvidia.com> <aPGryj-V5PQZRtoI@google.com>
 <20251017134916.GK3901471@nvidia.com> <aPJp3hP44n96Rug9@tzungbi-laptop>
 <009c8e5e-02d3-4017-bb84-e3a8f01b9dc9@kernel.org>
 <20251017163738.GB316284@nvidia.com>
 <bee969ed-c050-43a4-961c-07443a45943c@kernel.org>
 <20251017184415.GE316284@nvidia.com> <DDKXACTUJ9IT.3W11J2HE7SLJW@kernel.org>
 <20251017225632.GF316284@nvidia.com>
Content-Language: en-US
In-Reply-To: <20251017225632.GF316284@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On Sat Oct 18, 2025 at 12:56 AM CEST, Jason Gunthorpe wrote:
> On Fri, Oct 17, 2025 at 11:41:56PM +0200, Danilo Krummrich wrote:
>> On Fri Oct 17, 2025 at 8:44 PM CEST, Jason Gunthorpe wrote:
>> > On Fri, Oct 17, 2025 at 08:19:06PM +0200, Danilo Krummrich wrote:
>> >> On 10/17/25 6:37 PM, Jason Gunthorpe wrote:
>> >> > On Fri, Oct 17, 2025 at 06:29:10PM +0200, Danilo Krummrich wrote:
>> >> > 
>> >> >> I'm not sure about MISC device though. Unless there's a good reason,
>> >> >> I think MISC device should be "fenced" instead.
>> >> > 
>> >> > misc is a very small wrapper around raw fops, and raw fops are
>> >> > optimized for performance. Adding locking that many important things
>> >> > like normal files don't need to all fops would not be agreed.
>> >> > 
>> >> > The sketch in this series where we have a core helper to provide a
>> >> > shim fops that adds on the lock is smart and I think could be an
>> >> > agreeable way to make a synchronous misc and cdev unregister for
>> >> > everyone to trivially use.
>> >> 
>> >> Sure, for MISC devices without a parent for instance there are no device
>> >> resources to access anyways.
>> >
>> > There are many situations with misc that can get people into trouble without
>> > parent:
>> >
>> >  misc_deregister(x);
>> >  timer_shutdown_sync(y);
>> >  kfree(z);
>> >
>> > For example. It is is buggy if the fops touch y or z.
>> >
>> > This is why a _sync version is such a nice clean idea because with 5
>> > letters the above can just be fixed.
>> >
>> > Wrapping everything in a revocable would be a huge PITA.
>> 
>> That's a bit of a different problem though. Revocable clearly isn't the
>> solution. _sync() works, but doesn't account for the actual problem, which is
>> that the file private has at least shared ownership of y and z.
>> 
>> So, it's more of an ownership / lifetime problem. The file private data should
>> either own y and z entirely or a corresponding reference count that is dropped
>> in fops release().
>
> I think both versions are popular in the kernel.. You can legimately
> treat y and z the same as device resources without creating a
> correctness problem and it is less code.
>
> You can also do refcounts.
>
> For instance at least in C you'd never argue that people should use
> refcount private data when they use a timer or irq subsystem. You'd
> use a simple sync cleanup and be done with it.

Don't get me wrong, I'm well aware that there are multiple ways to achieve
correctness, and I know what's common, not common, etc.

And I also don't mean to say "just reference count your private data", which in
a lot of (maybe even most) cases clearly is the wrong thing to do (compared to
specific objects contained within the private data).

What I'm saying is that it's better to think about the lifetime of an object and
what it is owned by.

Let's say we have a memory allocation of some object X, then the question is who
owns this object. Is it the module, the file private data, device private data,
interrupt handler, etc.

If it is only owned by a single thing (e.g. file private), then it's simple:
allocate and initialize in open(), release in release(), and only ever access
in other fops.

However, if we have shared ownership of an object, and it is contained in
multiple different private data objects, then reference count is much more
robust, compared to having your driver manually keeping track of how it can
synchronize against all the owners of that object.

