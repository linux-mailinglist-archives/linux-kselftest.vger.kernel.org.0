Return-Path: <linux-kselftest+bounces-10616-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AF2A8CD134
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 May 2024 13:28:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 780E2281B5F
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 May 2024 11:28:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B78041474AE;
	Thu, 23 May 2024 11:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="VWUdpLN2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="oXhXplw+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from wfout1-smtp.messagingengine.com (wfout1-smtp.messagingengine.com [64.147.123.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCCE513C91D;
	Thu, 23 May 2024 11:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716463699; cv=none; b=tqXTUoycrad0Q5YDYnZY4tkbzAQjkOTT917O2YtQj66Rhx9WjWVRyC2OV9JG9YFEBYeA1AMQGXuDL5nOuAXJyPLB4PDBXnRBqWUWxNS8rA3rDn2+ZpJIbUsSMNPyJ8guOduG/A7wgXxFkXHf8xk4Kd9UC+fMk9uzeA0zhrp1l6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716463699; c=relaxed/simple;
	bh=98af4TZTxoNtCMAu0GpqxIFWTOMAVwBIl44PAzZ2++s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BhTLVVtpw5S5xPsQrRkCyBfvL85CW3dj3xv5bKzBxDRU3JEsyOE6XPXTN0dvDpRq95mK6pHjDyN1U/029vyRS0CRnR+5haR6Ov3OYOycNvgibrQRnLflrynUBAN9QU6tvUO9+mj0KCaJB/2sxxQ14Cgju0JhlnFFPXsqGavYIeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=VWUdpLN2; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=oXhXplw+; arc=none smtp.client-ip=64.147.123.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfout.west.internal (Postfix) with ESMTP id BC46C1C001DE;
	Thu, 23 May 2024 07:28:15 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Thu, 23 May 2024 07:28:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1716463695; x=1716550095; bh=if5e5WwkzJ
	eIoOCzGj7W+4ffr1RWsZHFOpu3DQ7P8u8=; b=VWUdpLN2a8RsBDIf+rC1CIxc2g
	mVsXBBruEuC0bqMUUP0T+xTp3vR2BS/SNGcEETCnv2Ifxj+etUKDu13EMVJuZ2EP
	xWtggkkA6jkGcfsy3/omIPPCvtW4fjaWzN6BoMf2WL1wfR9ohoVK3rNCHolFP1Sk
	H0+Fp5661//u+Ymqz3T6H/7z457lc6L/aDVuWpDQG+W4k8dvtGy8QWaULEqERuhe
	hU/G3fEclOgwXF62255tomnwim2ErSKe8+bN+hDK0ZWmX4aW+n+D3ocvnxJxAAOt
	3Rxzubp1f1/+RZSrYyyqdDXW0xcmL39RNyhWyIED451PTG9aW/MXg9RvzkwQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1716463695; x=1716550095; bh=if5e5WwkzJeIoOCzGj7W+4ffr1RW
	sZHFOpu3DQ7P8u8=; b=oXhXplw+/HmJEAscFsdO5pb1D1C9as6Rvi3qlyQe6mnT
	d87YfTHZcpTWMb4Je7IuJe+qDsBji+v3IIb75f+Nn6OvzJ5wsxJAW9jg69oYYu7v
	pF8CV7DLyN907NI6diN0/6rJMkjeJwXgRBhC9ej+gXZ+0TqUOW/ePQ9JzVRHmXsK
	o8DS6JiVyCo0SIoInElOkRu+84lism8uJru6Az6RPTy5MGpKwdTAggII7w1fTeLQ
	M8zVO4k0OAW8ioXbnl87yG119OY8w9jBkXTAU4LiYhF0e5dGdJewExiQcJK6KXsP
	acv58S8opmE05SsLLNaixlvp5Vl0KqumlXnjISXg6g==
X-ME-Sender: <xms:TyhPZjVwgqpUNUJJ7oVmfiYEgJJs68sCeZCSjG9t6GldNpcQbgoPQQ>
    <xme:TyhPZrmAK3kfMIK-V2bGdDhKhW5BbUlTWZ4F94aLj9YyHZQ7DWAcp5qFafwfpOGSN
    E5Yh-zx1uviJw>
X-ME-Received: <xmr:TyhPZvZcGL2-h8KWLmhzfsZPMVBC5kWbwtvQLNXGcwbS0Tcf8tIDCRuzyyReQ8P70iR2kai5XaCqQUp62lpx80S8HCc8wiNRbVYX7A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdeiiedggedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepifhrvghg
    ucfmjfcuoehgrhgvgheskhhrohgrhhdrtghomheqnecuggftrfgrthhtvghrnhepheegvd
    evvdeljeeugfdtudduhfekledtiefhveejkeejuefhtdeufefhgfehkeetnecuvehluhhs
    thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhrvghgsehkrhhorg
    hhrdgtohhm
X-ME-Proxy: <xmx:TyhPZuUEkLI2nCjDUFJlx4000_ffEMpr7MR-1XqNR_Jy1BsXCftn0g>
    <xmx:TyhPZtmXF8FFpbQhgH-uvYrx2B3ens5Wkq0tLUyPnIB5vLVc_qY_Lg>
    <xmx:TyhPZrc5axTrFTajOVnfhRHfQlX_dEjCGqsAY1db5w2TxHFsjC9SYA>
    <xmx:TyhPZnGO02CXTelJD2VDrDtVczcdc2c5twWV99ov0MLm582bZe04yA>
    <xmx:TyhPZscJOFBfrKh3kFp6ezJF_hSni6Qe0qW_QNpsHY9V2ZKHldLB61rM>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 23 May 2024 07:28:14 -0400 (EDT)
Date: Thu, 23 May 2024 13:28:12 +0200
From: Greg KH <greg@kroah.com>
To: Edward Liaw <edliaw@google.com>
Cc: stable@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
	kernel-team@android.com, Mark Brown <broonie@kernel.org>,
	Kees Cook <keescook@chromium.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND 6.6.y] kselftest: Add a ksft_perror() helper
Message-ID: <2024052305-unmapped-renewably-b3fc@gregkh>
References: <20240520175629.162697-1-edliaw@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240520175629.162697-1-edliaw@google.com>

On Mon, May 20, 2024 at 05:56:28PM +0000, Edward Liaw wrote:
> From: Mark Brown <broonie@kernel.org>
> 
> [ Upstream commit 907f33028871fa7c9a3db1efd467b78ef82cce20 ]
> 
> The standard library perror() function provides a convenient way to print
> an error message based on the current errno but this doesn't play nicely
> with KTAP output. Provide a helper which does an equivalent thing in a KTAP
> compatible format.
> 
> nolibc doesn't have a strerror() and adding the table of strings required
> doesn't seem like a good fit for what it's trying to do so when we're using
> that only print the errno.
> 
> Signed-off-by: Mark Brown <broonie@kernel.org>
> Reviewed-by: Kees Cook <keescook@chromium.org>
> Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
> Stable-dep-of: 071af0c9e582 ("selftests: timers: Convert posix_timers test to generate KTAP output")
> Signed-off-by: Edward Liaw <edliaw@google.com>
> ---
>  tools/testing/selftests/kselftest.h | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 

Now queued up, thanks.

greg k-h

