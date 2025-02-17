Return-Path: <linux-kselftest+bounces-26798-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7070FA38ADD
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Feb 2025 18:47:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C4FE3A924D
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Feb 2025 17:47:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0790022DFB3;
	Mon, 17 Feb 2025 17:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FZo9n1Ck"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D20C822D4F1;
	Mon, 17 Feb 2025 17:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739814462; cv=none; b=mt3+tIZ8ccFeEjzZ5IkuUlmfEyH7AzMZ5yMEUXr5uRU5fhNh0QlCZzyM5ZEZQrW+KWYj0TBiKMCPqkONJV9Jvftk4JBhGZwYM4zAsiOLGCYzHbKbmcYIH+9thkxhYN3u3zyHuiy7IeopzJEYHyUB6hI0CDKn0yqmPIP9NV0H30I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739814462; c=relaxed/simple;
	bh=3S1ZTxenp/rLN8CeI8x5Y52SOGdmi/iiQrZa8PnssEI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=O7UqDFWY0ChkN/HNapXow/Edc7v1R5a2dSrLz8FZELbrlBxhF/F20Ltj2EJ9s+v6fuJVZgbA8nxXANtiH1IK0bqTuOfpMhsJ3at6RsxxeIy8v2B6ccUnDhIp6nVW1r8bXDOn+MnQ/oRz6IsdrvUtaK9wqL4uwrFQAiMDUa2X0Og=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FZo9n1Ck; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C092FC4CED1;
	Mon, 17 Feb 2025 17:47:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739814462;
	bh=3S1ZTxenp/rLN8CeI8x5Y52SOGdmi/iiQrZa8PnssEI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=FZo9n1Ckc2QMqq5I8aNjdvlDBDBTTX8PTnypEsY0zo0pwyit7y3DmurE04BLjKp86
	 O1Ra7thxiExpApeXhwbilDOBoIMibbGiduN1rQPhcsZSZW6UKdSOG5cmYCBk/Tyt+/
	 DfXLzDKHmPe+rqBsOEthuRc+kK9ttY9A6N0KjisUZ6xS76bdDZE/7Z686BDaaDYUj8
	 wl9XK9EUTFE5SG5xGfOotFyAz4amxmyjGHF2TyjYkal3O/ypDi6VqIUFDPqD6nIyjr
	 3bjpQ/enQw9UUPr6og1kfS5UNbDC4lGlwam/b5ULl3LKYKD1DPCqp7ExWANtiyZ3r9
	 J9XGkQN06vZYA==
Date: Mon, 17 Feb 2025 09:47:40 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Simon Horman <horms@kernel.org>
Cc: Peter Seiderer <ps.report@gmx.net>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, "David S .
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>, Artem Chernyshev
 <artem.chernyshev@red-soft.ru>, Nam Cao <namcao@linutronix.de>, Frederic
 Weisbecker <frederic@kernel.org>
Subject: Re: [PATCH net-next v5 8/8] net: pktgen: use defines for the
 various dec/hex number parsing digits lengths
Message-ID: <20250217094740.76a25671@kernel.org>
In-Reply-To: <20250216091739.GW1615191@kernel.org>
References: <20250213110025.1436160-1-ps.report@gmx.net>
	<20250213110025.1436160-9-ps.report@gmx.net>
	<20250214201145.2f824428@kernel.org>
	<20250216091739.GW1615191@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 16 Feb 2025 09:17:39 +0000 Simon Horman wrote:
> On Fri, Feb 14, 2025 at 08:11:45PM -0800, Jakub Kicinski wrote:
> > On Thu, 13 Feb 2025 12:00:25 +0100 Peter Seiderer wrote:  
> > > Use defines for the various dec/hex number parsing digits lengths
> > > (hex32_arg/num_arg calls).  
> > 
> > I don't understand the value of this patch, TBH.
> > 
> > Example:
> > 
> > +#define HEX_2_DIGITS 2
> > 
> > -		len = hex32_arg(&user_buffer[i], 2, &tmp_value);
> > +		len = hex32_arg(&user_buffer[i], HEX_2_DIGITS, &tmp_value);
> > 
> > The word hex is already there.
> > There is still a two.
> > I don't think the new define has any explanatory power?
> > 
> > Previous 7 patches look ready indeed.  
> 
> This one is on me. I felt the magic number 2 and so on
> was unclear. But if you prefer the code as-is that is fine by me too.

I agree that it's a bit hard to guess what the call does and what 
the arguments are. To me at least, the constants as named don't help. 
We can get a third opinion, or if none is provided skip the patch for
now?

