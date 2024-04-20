Return-Path: <linux-kselftest+bounces-8531-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BCD78AB9FD
	for <lists+linux-kselftest@lfdr.de>; Sat, 20 Apr 2024 08:27:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 103BB1C208D1
	for <lists+linux-kselftest@lfdr.de>; Sat, 20 Apr 2024 06:27:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41D40FBEE;
	Sat, 20 Apr 2024 06:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="wIQjmFR2"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03898D52A;
	Sat, 20 Apr 2024 06:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713594448; cv=none; b=NrXwn/I4q7fjSYfuQ+fT9ANkLdARJdyi1vaswazBr7zRc9eul+ydTPLXQjIxsQhTqgerepom8+p7CYfl7ZesG1MT2A3xaFIIZ52hvONega+1gTXBoMQCzx2dBLiQTF76e65ptOvbuJdJrrNxho6fwG0sdBr9zxwQ6ErKrUZSDFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713594448; c=relaxed/simple;
	bh=3Rv9kxynFCiNH8AU1R2lEpYXFpko+0AQnoUOT+h2Jyg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I8VrpZ0uGfNHC4mzD0NZvtSmrhxT+dJrEGxkWpQYP89OHwbuMRZ9piUtuC1OQRmpXCVeaLxNVeqysexjVYp4hY3hFJh68oe5NuNK3qP2P4llrxJ5Gd0Fc/pgjVLpHiGCvlbm5ITzXP4zeky9bLiaHXIEjsjyMI7SpQ1FUPgauf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=wIQjmFR2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 191A9C072AA;
	Sat, 20 Apr 2024 06:27:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1713594447;
	bh=3Rv9kxynFCiNH8AU1R2lEpYXFpko+0AQnoUOT+h2Jyg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=wIQjmFR2eL7dfW/tf0dG3m1+HlC9GWL5lotRyARqlTiYBrZx1RfCNueYDRnfIdBnL
	 4LGDFPndq8A3e1F6BgYEZ7s3PvWn/tkNwNRxJK2Hy+MR9Qlp9oNFt2bJ9JtfkYUa6O
	 KCSUlwGNstX7TvRLtyzIOCjnNQLerpCnfIzvN5Kw=
Date: Sat, 20 Apr 2024 08:27:20 +0200
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
Subject: Re: [PATCH v4 1/2] kunit: unregister the device on error
Message-ID: <2024042013-condition-glade-90e4@gregkh>
References: <2024041955-strangely-snack-b335@gregkh>
 <bf0dc8a8-d5e9-4402-8305-5b7a954e6382@web.de>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <bf0dc8a8-d5e9-4402-8305-5b7a954e6382@web.de>

On Fri, Apr 19, 2024 at 06:32:05PM +0200, Markus Elfring wrote:
> > > kunit_init_device() should unregister the device on bus register error,
> > > but mistakenly it tries to unregister the bus.
> > >
> > > Unregister the device instead of the bus.
> …
> > Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> 
> Would you ever like to distinguish hardware register errors from
> item registration failures according to further improved commit messages?

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

