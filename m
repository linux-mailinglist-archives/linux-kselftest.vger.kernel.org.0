Return-Path: <linux-kselftest+bounces-8400-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DB58C8AA836
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Apr 2024 08:07:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7BA121F21646
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Apr 2024 06:07:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73822C129;
	Fri, 19 Apr 2024 06:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="WNlDWGD6"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F077C121;
	Fri, 19 Apr 2024 06:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713506828; cv=none; b=kxD5dF4zadK8qUOoebkK4rmt+XDhqpCy903NwFRodDd4rQO1hbGh0sSsF/SV7pVEjg548UJYb6qfDwmOwJGz9EZ1VZqJyni7iwQ9RgCUJ4hWv8LyeKzFM4IweWdOJMVBwZRxSCQaf7+UhQHclDzUY/za3WXBgsZ6gVAKW6HjBEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713506828; c=relaxed/simple;
	bh=q/7us5n3dTmlIJdrg9CFZY9TJi5va1SRXgR2lP4H0mY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QErT8QvQ+5Ul7XRg7jmhlZS4glxBy2XJMN1ThSNIhnGVkEskMyamzAX3T9l9eKqo7iYmt4yFieBC2R78L2dfWZ19092IarjYGRy0C2+LTv5cTDFbzN44qDR0hmFPeyThnAViz0HqyHjPCtI5p8FaDom+XkYMzwE20YdA7EZT+zo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=WNlDWGD6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66657C072AA;
	Fri, 19 Apr 2024 06:07:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1713506827;
	bh=q/7us5n3dTmlIJdrg9CFZY9TJi5va1SRXgR2lP4H0mY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WNlDWGD6iNGT6PbaoXLOdz2U8frQN5uu+XH9/a305fwMcZ+YW6LM3StUJal4BnEsl
	 zurirrLPoWLcU45cp9pIVZstKy3XZ1WNko1G5WY5kqKfkFKmVwb5mZUAHdKUO9CrL8
	 wXrxf31NkhOdV5NLXji5TSN0G3sgcA75CnCaVXXM=
Date: Fri, 19 Apr 2024 08:07:04 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Markus Elfring <Markus.Elfring@web.de>
Cc: Wander Lairson Costa <wander@redhat.com>, kunit-dev@googlegroups.com,
	linux-kselftest@vger.kernel.org, kernel-janitors@vger.kernel.org,
	Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <davidgow@google.com>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	Maxime Ripard <mripard@kernel.org>, Rae Moar <rmoar@google.com>,
	Shuah Khan <skhan@linuxfoundation.org>,
	LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 1/2] kunit: unregister the device on error
Message-ID: <2024041949-print-cried-85fd@gregkh>
References: <20240418210236.194190-2-wander@redhat.com>
 <405247be-09e9-4a2d-9363-93b5862fc615@web.de>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <405247be-09e9-4a2d-9363-93b5862fc615@web.de>

On Fri, Apr 19, 2024 at 07:40:43AM +0200, Markus Elfring wrote:
> > kunit_init_device() should unregister the device on bus register error,
> > but mistakenly it tries to unregister the bus.
> 
> Would the following description variant be more appropriate?
> 
>    kunit_init_device() should unregister the device on bus registration error.
>    But it mistakenly tries to unregister the bus.

Hi,

This is the semi-friendly patch-bot of Greg Kroah-Hartman.

Markus, you seem to have sent a nonsensical or otherwise pointless
review comment to a patch submission on a Linux kernel developer mailing
list.  I strongly suggest that you not do this anymore.  Please do not
bother developers who are actively working to produce patches and
features with comments that, in the end, are a waste of time.

Patch submitter, please ignore Markus's suggestion; you do not need to
follow it at all.  The person/bot/AI that sent it is being ignored by
almost all Linux kernel maintainers for having a persistent pattern of
behavior of producing distracting and pointless commentary, and
inability to adapt to feedback.  Please feel free to also ignore emails
from them.

thanks,

greg k-h's patch email bot

