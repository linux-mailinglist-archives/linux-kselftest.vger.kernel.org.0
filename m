Return-Path: <linux-kselftest+bounces-49160-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DBD5D331F6
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Jan 2026 16:17:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8BBF93008C82
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Jan 2026 15:17:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6E0E31AAA7;
	Fri, 16 Jan 2026 15:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="nuiny6yU"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFA80288B1;
	Fri, 16 Jan 2026 15:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768576652; cv=none; b=Zqa+GyQOw8SOLbzpjdOxIyDlqj5qS1UNVBJ6NG126vJc/qYL5Bw9C1KyfFfeSYUwhId2616YvOqpQ9iKog7fi53O/bTFkiqryabKZoFE3gDKIGUl2hwNuJdSwQ2RZTZigMknzHDF5KJTRymJjM17XwKwDitH6XYzsMq+2JQ5AZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768576652; c=relaxed/simple;
	bh=BB7e2YHYn06NQdt++Wms3BC8JGMNNsCGREOc+mDWWps=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KM0QF9FYmeOflBReQuE/xaT47ixHPDwcvSwOUN/DDlJYyJ9ccDMYrkvvGHO63FBOAfZ6CiNRSbBjsL3iWsBnYXskJrIJpc7K0sdpgYNECZa17aoHiHfh+ksMOzgFW3yuCMV9sRFyCMZgCG57GY5JLC8Qmu90S2ZFQWw+CymGFr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=nuiny6yU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E493EC19421;
	Fri, 16 Jan 2026 15:17:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1768576652;
	bh=BB7e2YHYn06NQdt++Wms3BC8JGMNNsCGREOc+mDWWps=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nuiny6yUcOktCJoL/bpaAAkgkZ2YzPBJd43zBlFxqCwvqB7iCXtPgbdzNNEisHFHF
	 8PD4g6HVr+lBWruFk5OJRaxWp/1FsWEvGLoSR9CsPMx7azyWytpo8uyTiFTJ8wUO1r
	 EZ6osAppW2DDeHQQLFZwgaDjFJ+TvcYOxgA8Ff1s=
Date: Fri, 16 Jan 2026 16:17:29 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Tzung-Bi Shih <tzungbi@kernel.org>
Cc: Benson Leung <bleung@chromium.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Linus Walleij <linusw@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <shuah@kernel.org>, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, chrome-platform@lists.linux.dev,
	linux-kselftest@vger.kernel.org,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Simona Vetter <simona.vetter@ffwll.ch>,
	Dan Williams <dan.j.williams@intel.com>,
	Jason Gunthorpe <jgg@nvidia.com>, linux-gpio@vger.kernel.org
Subject: Re: [PATCH v7 0/3] drivers/base: Introduce revocable
Message-ID: <2026011607-canister-catalyst-9fdd@gregkh>
References: <20260116080235.350305-1-tzungbi@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260116080235.350305-1-tzungbi@kernel.org>

On Fri, Jan 16, 2026 at 08:02:32AM +0000, Tzung-Bi Shih wrote:
> The series is separated from [1] to show the independency and compare
> potential use cases easier.  This is the revocable core part.  Use cases
> are in other series.
> 
> The 1st patch introduces the revocable which is an implementation of ideas
> from the talk [2].
> 
> The 2nd and 3rd patches add test cases for revocable in Kunit and selftest.
> 
> [1] https://lore.kernel.org/chrome-platform/20251016054204.1523139-1-tzungbi@kernel.org
> [2] https://lpc.events/event/17/contributions/1627/
> 
> v7:
> - Rebase onto next-20260115.

Thanks for sticking with this, I've queued this up in the driver-core
testing branch for now, thanks!

greg k-h

