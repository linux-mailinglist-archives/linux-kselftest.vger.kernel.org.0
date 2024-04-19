Return-Path: <linux-kselftest+bounces-8431-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3EC18AB02B
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Apr 2024 16:06:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B0D09284F38
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Apr 2024 14:06:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07E3812FB2F;
	Fri, 19 Apr 2024 14:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="CyP3Up9R"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D31EB12DDB5;
	Fri, 19 Apr 2024 14:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713535398; cv=none; b=Bs/RrJMRqzx4/RR7t2zmcDO+yPF5NF+GsCVEnMyztqlN/3ubdcAHmNxhfWAbv6EVeNL+0BtJVm/ApaB4WFixMIvqRn5vcPJZ+BAyd59Whtqp5mgeKNrfD2cUokqAhEeumo8QoZSLDtkYfiLhz288W4nMn4kPOWktUWPAkebG+6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713535398; c=relaxed/simple;
	bh=eqH1aWQ6y/Xs4N8czYfOUVDZDBYeQAX8RmC4mrbUQ/w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G89JImTinwhZOVSyiBdV9BZkRzUpmIgj21o/JS5jneCX+irQ6NfFF8TNlFjnAX4p26WXiErX831EVAeAUFmveW134jLL8lz4rhmAwr+Ny9u3POZBR7Ysrfz+3S+T0Ruag6/4scr6jBAFmJ2P2fP0TvpKy2VpiNRvPvkCMBjWQs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=CyP3Up9R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1289C072AA;
	Fri, 19 Apr 2024 14:03:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1713535398;
	bh=eqH1aWQ6y/Xs4N8czYfOUVDZDBYeQAX8RmC4mrbUQ/w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CyP3Up9RAJLx2lV2njOvVE8wUKiOVSmu0sNiuYLvY2i6JwtnEtuKBqIja8paozH9B
	 SUdvZ2TbG4jRhKjZG5sraOoFIiLy0AhqrUFoInVBoflMqpApyNU0hCt3uNpywlyRA4
	 PhMO+gMAazCTgtSHiirq798YLSnYjSovt464SiaY=
Date: Fri, 19 Apr 2024 16:03:12 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Wander Lairson Costa <wander@redhat.com>
Cc: Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	Maxime Ripard <mripard@kernel.org>,
	"open list:KERNEL UNIT TESTING FRAMEWORK (KUnit)" <linux-kselftest@vger.kernel.org>,
	"open list:KERNEL UNIT TESTING FRAMEWORK (KUnit)" <kunit-dev@googlegroups.com>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 2/2] kunit: avoid memory leak on device register error
Message-ID: <2024041919-unify-improve-d4a5@gregkh>
References: <20240419132504.9488-1-wander@redhat.com>
 <20240419132504.9488-3-wander@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240419132504.9488-3-wander@redhat.com>

On Fri, Apr 19, 2024 at 10:25:02AM -0300, Wander Lairson Costa wrote:
> If the device register fails, free the allocated memory before
> returning.
> 
> Signed-off-by: Wander Lairson Costa <wander@redhat.com>
> Fixes: d03c720e03bd ("kunit: Add APIs for managing devices")
> ---
>  lib/kunit/device.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/lib/kunit/device.c b/lib/kunit/device.c
> index 25c81ed465fb..d8c09dcb3e79 100644
> --- a/lib/kunit/device.c
> +++ b/lib/kunit/device.c
> @@ -131,6 +131,7 @@ static struct kunit_device *kunit_device_register_internal(struct kunit *test,
>  	err = device_register(&kunit_dev->dev);
>  	if (err) {
>  		put_device(&kunit_dev->dev);
> +		kfree(kunit_dev);

This still looks wrong, the release function for the device should free
the memory here, not this kfree, as the reference count in the embedded
'struct device' handles the memory logic for the whole structure (if
not, then something is REALLY wrong...)

You _do_ have a release function for the device, right?  If not, you
should be getting loud messages in the kernel log when releasing a
device here.

thanks,

greg k-h

