Return-Path: <linux-kselftest+bounces-4721-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1596855B97
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Feb 2024 08:24:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D33891C210AB
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Feb 2024 07:24:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D38F6DDC4;
	Thu, 15 Feb 2024 07:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="waq7iMT0"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77CF5B677;
	Thu, 15 Feb 2024 07:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707981881; cv=none; b=MyiyQKwo0E5KAkidzQcvWKQe30L7BSnfeQgzkW2ECh4ICEWCVEEpwxraYoI9OkwFeswPNK51ha5B9lmpBaFyrhidUQlIdGYDy0sL2VfJ1ijt5FkSHG19gB//bRIKiojIeedsxZcY3uS52DEflJUmYgsuCn7bYN6kJGgdWT/rPAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707981881; c=relaxed/simple;
	bh=NFXrK4YQfB6VSsKUZYkJSP5c8FFcKLqDcxwwI5yeci4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D3y6QIJRtTIcQ7MbvD64fdUtPtx8ARfDYRYUTkd76AXSSiylDHIc8f+KpqkfXQMxuV9qyypirjFZrVzAsq2dCUQgprhtf00Nq1Dg29kIF9/dXx7TYsF23o6fJ4ztxR/JlCkQ5YS92aWutgcajk3+6xE47GhlzTGAil2Sga9nuPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=waq7iMT0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 430EFC433C7;
	Thu, 15 Feb 2024 07:24:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1707981880;
	bh=NFXrK4YQfB6VSsKUZYkJSP5c8FFcKLqDcxwwI5yeci4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=waq7iMT0tSu/JUKa4x7ROIFCLSlhJ1h81L0zWznZKqwEtO4MttfHj8GkKrphAl216
	 K9DF67q2ojl2uX6mwTqg+iBt9bJ6iSyPV0qhhWYWahIwfOTr9gsO7OJ8bar2nO+3Ic
	 mv4DRTqv2GIS9FYkUOorsFNDlSjkmHRc+VcU61nc=
Date: Thu, 15 Feb 2024 08:24:37 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Elizabeth Figura <zfigura@codeweavers.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
	linux-api@vger.kernel.org, wine-devel@winehq.org,
	=?iso-8859-1?Q?Andr=E9?= Almeida <andrealmeid@igalia.com>,
	Wolfram Sang <wsa@kernel.org>,
	Arkadiusz Hiler <ahiler@codeweavers.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Andy Lutomirski <luto@kernel.org>, linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 00/31] NT synchronization primitive driver
Message-ID: <2024021530-untagged-gyration-69f8@gregkh>
References: <20240214233645.9273-1-zfigura@codeweavers.com>
 <5754084.DvuYhMxLoT@camazotz>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5754084.DvuYhMxLoT@camazotz>

On Wed, Feb 14, 2024 at 06:01:22PM -0600, Elizabeth Figura wrote:
> On Wednesday, 14 February 2024 17:36:36 CST Elizabeth Figura wrote:
> > This patch series introduces a new char misc driver, /dev/ntsync, which is used
> > to implement Windows NT synchronization primitives.
> 
> Ugh, sorry, I made a bit of a mess while sending this revision. I accidentally
> sent 000* instead of 00*, and then tried to fix it by sending the rest with
> --in-reply-to but forgot to also add --no-thread. Please let me know if I should
> resend the whole series.

Please resend the whole thing, as a v2 series, as our tools can't pick
this up easily as-is.

thanks,

greg k-h

