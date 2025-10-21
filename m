Return-Path: <linux-kselftest+bounces-43647-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DCACCBF4FE9
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 Oct 2025 09:36:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 265253A3A70
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 Oct 2025 07:35:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68C8D27FD76;
	Tue, 21 Oct 2025 07:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ZF3m40Jn"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35D4727FB1E;
	Tue, 21 Oct 2025 07:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761032150; cv=none; b=ouYbwThu7nS2m7q+MbBux2o3D9iq931qKtupmetEt07X8B7XE1LD5okJUV8qzhtNdDOZaH6e2ag1hOWFUPx61kbmSDBtbVAAOQ6rj6GbwQOJKDCeVDwTmBiBYh0LQzqnmE1IbELc/23ML0F7KAdv6ZOtjnR4vB3KLHA8HWSYHE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761032150; c=relaxed/simple;
	bh=X7cRHSjXRGJM7wUbMm04IaWm8HIAEs4IU/+DZbQNmmY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TPO2vfZSWA5vyVYjfHVCEoSNoHRJf0h0I3fu6w02gs7rwy1jKCFll9OL5SxPtwbIDkyV8WDn6e3KoCL1nX1ZLLbkLy8+w3n2k86SM60H8i3iBNrcUKwBscdwTLwceqL6tGFDjzRxsErXisIqxMBa8tAmygFHKal+W7Y1Mn8Z3Ns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ZF3m40Jn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 296C3C4CEF1;
	Tue, 21 Oct 2025 07:35:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1761032149;
	bh=X7cRHSjXRGJM7wUbMm04IaWm8HIAEs4IU/+DZbQNmmY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZF3m40JnrkJq0Zzlrd/gSWdkTrS+ITLiIJ3P7bgYMqVPXjZmxslmq6eQr0R+IjNVK
	 zFgBRM+8jrLmktKUGfCZLDORZcoyLGjuVDE1ufeVf0dvCe1wWXfFIZn2WuZ6HaYoMN
	 CncWuoeFy18c5UJIW8HASO+lmdYsqxmBBotPfVtY=
Date: Tue, 21 Oct 2025 09:35:46 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Gabriele Paoloni <gpaoloni@redhat.com>
Cc: shuah@kernel.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org, corbet@lwn.net,
	linux-doc@vger.kernel.org, linux-mm@kvack.org,
	safety-architecture@lists.elisa.tech, acarmina@redhat.com,
	kstewart@linuxfoundation.org, chuckwolber@gmail.com
Subject: Re: [RFC PATCH v2 0/3] Add testable code specifications
Message-ID: <2025102111-facility-dismay-322e@gregkh>
References: <20250910170000.6475-1-gpaoloni@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250910170000.6475-1-gpaoloni@redhat.com>

On Wed, Sep 10, 2025 at 06:59:57PM +0200, Gabriele Paoloni wrote:
> [1] was an initial proposal defining testable code specifications for
> some functions in /drivers/char/mem.c.
> However a Guideline to write such specifications was missing and test
> cases tracing to such specifications were missing.
> This patchset represents a next step and is organised as follows:
> - patch 1/3 contains the Guideline for writing code specifications
> - patch 2/3 contains examples of code specfications defined for some
>   functions of drivers/char/mem.c
> - patch 3/3 contains examples of selftests that map to some code
>   specifications of patch 2/3
> 
> [1] https://lore.kernel.org/all/20250821170419.70668-1-gpaoloni@redhat.com/

"RFC" implies there is a request.  I don't see that here, am I missing
that?  Or is this "good to go" and want us to seriously consider
accepting this?

thanks,

greg k-h

