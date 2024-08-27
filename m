Return-Path: <linux-kselftest+bounces-16467-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B9D069618F7
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Aug 2024 23:06:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 643951F23D22
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Aug 2024 21:06:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D227F1D2F7F;
	Tue, 27 Aug 2024 21:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q8tE6zRc"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4877158DCC;
	Tue, 27 Aug 2024 21:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724792772; cv=none; b=lHRL0bFzrCycRKpaUbq29le5DNa9K7TicoqaKIDFDDDIAiciJGR1R42g2GLe0Jvf6t0/BmM7Xo/3SSAcMzpBlmL4UqbaVeff99OHOVWkakyfYIkDy7hG27dHbCQ/d5HjNSuey0dboNnteImYHUp9RBSfccTMxhZ9BBqP/cFOQqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724792772; c=relaxed/simple;
	bh=AITd6I4jN/3/3pEIAqMX/YbozHxwCGR6mJVUUAJ6sk8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=P6UuTnwH6IhEuiF5AduDIT1jvCZlhCSCPgxnTk/2HGvTbEkmOYPMnxGy14r6O7mU95oWCkEzwbXVqa1x/mtt6OEh76CrRmSKiSAKYfDQVsFtHLwQQedONvjnhTeKekkbmxYyhifSYokKdnz9N79mkn1Z9jHThQnCjf/It+mVOjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q8tE6zRc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2C5DC4AF1C;
	Tue, 27 Aug 2024 21:06:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724792772;
	bh=AITd6I4jN/3/3pEIAqMX/YbozHxwCGR6mJVUUAJ6sk8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=q8tE6zRcSPxmeVeQSgo//XfuIFHhHO0mPr6uAwzDHrtkxHZQw5uIKec2N6psBdtv4
	 NWANGlt20RJxfczWYmRpazwGnx4b1fuU2zjDBVnu1g8WTeZuXqiA9qlq+yRAqWDYht
	 v0zOHj4rigtQTCyPklDKiDIoljMIE/5omoFUaR+mVKauP13XY10Bbt23CJ/iS48yP6
	 fHvddnJGA41wgoi/PnEQbVX94eTORL+D+lSr9+U3e4Kvlw0VtMi9X/QL2gItgCeyi9
	 TFL6sEC06Eu6Pxm3pGFh9wpOWxS1Z3QCqzo/kqUg67n+9IxaBvn3kSr0vYLSa/5r6j
	 x4mERP7A+SpwQ==
Date: Tue, 27 Aug 2024 14:06:10 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: David Hunter <david.hunter.linux@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com,
 javier.carrasco.cruz@gmail.com, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com,
 shuah@kernel.org
Subject: Re: [PATCH 1/1 V3] selftests: net: improve missing modules error
 message
Message-ID: <20240827140610.0ec927df@kernel.org>
In-Reply-To: <20240827205629.51004-1-david.hunter.linux@gmail.com>
References: <20240826085010.27ff4377@kernel.org>
	<20240827205629.51004-1-david.hunter.linux@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 27 Aug 2024 16:56:29 -0400 David Hunter wrote:
> The error message describing the required modules is inaccurate.
> Currently, only  "SKIP: Need act_mirred module" is printed when any of
> the modules are missing. As a result, users might only include that
> module; however, three modules are required.
> 
> Fix the error message to show any/all modules needed for the script file
> to properly execute.
> 
> Signed-off-by: David Hunter <david.hunter.linux@gmail.com>

Please don't post patches in reply to:

Quoting documentation:

  Resending after review
  ~~~~~~~~~~~~~~~~~~~~~~
  
  Allow at least 24 hours to pass between postings. This will ensure reviewers
  from all geographical locations have a chance to chime in. Do not wait
  too long (weeks) between postings either as it will make it harder for reviewers
  to recall all the context.
  
  Make sure you address all the feedback in your new posting. Do not post a new
  version of the code if the discussion about the previous version is still
  ongoing, unless directly instructed by a reviewer.
  
  The new version of patches should be posted as a separate thread,
  not as a reply to the previous posting. Change log should include a link
  to the previous posting (see :ref:`Changes requested`).
  
See: https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#resending-after-review

Our patch queue is too long right now for me to handle incorrectly
posted patches, sorry, please repost tomorrow (v4 or v3 REPOST).
-- 
pw-bot: cr

