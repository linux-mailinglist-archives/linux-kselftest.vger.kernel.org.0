Return-Path: <linux-kselftest+bounces-22084-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F97C9CD695
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Nov 2024 06:35:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DAAA6B23336
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Nov 2024 05:35:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49F8417BEB7;
	Fri, 15 Nov 2024 05:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="R3vj7QGm"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25A721547CC
	for <linux-kselftest@vger.kernel.org>; Fri, 15 Nov 2024 05:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731648937; cv=none; b=eJtahadOYDDMdn2f8qnGFmcoiEqaHnbMxGa3h7Nmvczyzos97QF4FAPN5ec9lFwOFEZ7zkI/IywVEHHxbnA1ASCX7On15Ic5eim7wxtD0H2bpdlPHLSz++gFnK3GKsWzImc2O+tLZe/bh9faJpOAfOKHcw7A7mOFzJkEuwywRtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731648937; c=relaxed/simple;
	bh=cdjhK+TBxzG6Aq0TScwiL2PIyozWOYdj7aVmIdo383U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P39WRp/+eYEuADxDhj7hSHJxP/hMi0dEZC/KV9OqZCb9Awdy6sXccGh9EI84eTaeEWDGOZr7orCHsp0JCEbAFz3XC+F0r4NjdnpcC/S7oOFcyvTTRd/niF1p16coEj4CfUMpWz/BTfJxsFh5dr8v+lerApCOehSAvKAD5/V8Wxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=R3vj7QGm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 468A2C4CECF;
	Fri, 15 Nov 2024 05:35:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1731648936;
	bh=cdjhK+TBxzG6Aq0TScwiL2PIyozWOYdj7aVmIdo383U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=R3vj7QGmx6sOo2rZYaDZfcx4P8wUYz9lsi6hUzc6jM5R9kaF4qJTNETMR4Ylu5yRG
	 gKyuuWSBapY5XC2C2+EdTUVkUhGcEGvfharYSnjZtoUyE+cDXUs6ccRKley577Vs2s
	 wWyeysQ1bASbodqBYnUjkxrrF7ha/M/Nga6q/YGU=
Date: Fri, 15 Nov 2024 06:35:33 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Gax-c <zichenxie0106@gmail.com>
Cc: brendan.higgins@linux.dev, davidgow@google.com, rmoar@google.com,
	mripard@kernel.org, skhan@linuxfoundation.org,
	mazziesaccount@gmail.com, linux-kselftest@vger.kernel.org,
	kunit-dev@googlegroups.com, chenyuan0y@gmail.com, zzjas98@gmail.com
Subject: Re: [PATCH] kunit: Fix potential null dereference in
 kunit_device_driver_test()
Message-ID: <2024111524-applicant-spectacle-88cb@gregkh>
References: <20241115051745.14404-1-zichenxie0106@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241115051745.14404-1-zichenxie0106@gmail.com>

On Thu, Nov 14, 2024 at 11:17:46PM -0600, Gax-c wrote:
> From: Zichen Xie <zichenxie0106@gmail.com>
> 
> kunit_kzalloc() may return a NULL pointer, dereferencing it without
> NULL check may lead to NULL dereference.
> Add a NULL check for test_state.
> 
> Fixes: d03c720e03bd ("kunit: Add APIs for managing devices")
> Signed-off-by: Zichen Xie <zichenxie0106@gmail.com>
> ---
>  lib/kunit/kunit-test.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/lib/kunit/kunit-test.c b/lib/kunit/kunit-test.c
> index 37e02be1e710..d9c781c859fd 100644
> --- a/lib/kunit/kunit-test.c
> +++ b/lib/kunit/kunit-test.c
> @@ -805,6 +805,8 @@ static void kunit_device_driver_test(struct kunit *test)
>  	struct device *test_device;
>  	struct driver_test_state *test_state = kunit_kzalloc(test, sizeof(*test_state), GFP_KERNEL);
>  
> +	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, test_state);
> +
>  	test->priv = test_state;
>  	test_driver = kunit_driver_create(test, "my_driver");
>  
> -- 
> 2.34.1
> 

Hi,

This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
a patch that has triggered this response.  He used to manually respond
to these common problems, but in order to save his sanity (he kept
writing the same thing over and over, yet to different people), I was
created.  Hopefully you will not take offence and will fix the problem
in your patch and resubmit it so that it can be accepted into the Linux
kernel tree.

You are receiving this message because of the following common error(s)
as indicated below:

- You have marked a patch with a "Fixes:" tag for a commit that is in an
  older released kernel, yet you do not have a cc: stable line in the
  signed-off-by area at all, which means that the patch will not be
  applied to any older kernel releases.  To properly fix this, please
  follow the documented rules in the
  Documentation/process/stable-kernel-rules.rst file for how to resolve
  this.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot

