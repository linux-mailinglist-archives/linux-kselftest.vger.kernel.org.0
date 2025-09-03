Return-Path: <linux-kselftest+bounces-40678-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1186EB4147D
	for <lists+linux-kselftest@lfdr.de>; Wed,  3 Sep 2025 07:47:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D33BC5424A1
	for <lists+linux-kselftest@lfdr.de>; Wed,  3 Sep 2025 05:47:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 172FF2D7818;
	Wed,  3 Sep 2025 05:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="AJGPNGVA"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC6FE2C326E;
	Wed,  3 Sep 2025 05:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756878417; cv=none; b=NhOkbGFAvtel/3h7UeegFs0F99sPxkSArOxeZnxcPf7KxAPjwbtO87E4Ru+cljTxVgjDo2pd/Lm8Dn8JpqEMrUR//7Qc9oiRnX/X33LXFdqpnQZpgk3Jfuh5fLT24h2UQh+BThUd1gjX4bCScJLXki9ow4AlYqf31b7qURAuL34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756878417; c=relaxed/simple;
	bh=9hTp2kzf2eoaja1GXk0znP0J6RMALdtD0zzMgSf3jas=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kyem+/0gsi/kvCqtKomzSQcXhPfggOPfIrMRNr3rWl6PYz9Eh9gxwiugcdp4BpWu071fxOEBol47Z7TlUplf30gEg7r0xV/2d1u/YRRuzz5RTVnrYbo56GPR+UOMWWdjlkT7V2v8sY3tZwaNHKSMbqH3Yc46zEpuHG0y+Vz80jk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=AJGPNGVA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBDC9C4CEF8;
	Wed,  3 Sep 2025 05:46:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1756878415;
	bh=9hTp2kzf2eoaja1GXk0znP0J6RMALdtD0zzMgSf3jas=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AJGPNGVAHNfcMwl+UO+6jBifopFrd2PXY1MvGAyqs3CuQ6FNRE8+PbNy+Q5KFiDGY
	 tCxHY67CdocyO6cLnL09/x56RyjQN/oNhEfCPLSSSgW/i2N+ddNUtenJ/tTJoxExs1
	 LUPvuFe4Id9gpnGBa8WUXutxOWIGIefhBh4rhTDU=
Date: Wed, 3 Sep 2025 07:46:51 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Abhinav Saxena <xandfury@gmail.com>
Cc: Shuah Khan <shuah@kernel.org>, Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Paul Moore <paul@paul-moore.com>, Kees Cook <kees@kernel.org>,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	llvm@lists.linux.dev, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v4] selftests/tty: add TIOCSTI test suite
Message-ID: <2025090312-pebbly-groggy-3df7@gregkh>
References: <20250902-toicsti-bug-v4-1-e5c960e0b3d6@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250902-toicsti-bug-v4-1-e5c960e0b3d6@gmail.com>

On Tue, Sep 02, 2025 at 06:17:56PM -0600, Abhinav Saxena wrote:
> TIOCSTI is a TTY ioctl command that allows inserting characters into
> the terminal input queue, making it appear as if the user typed those
> characters. This functionality has behavior that varies based on system
> configuration and process credentials.

<snip>

Any specific reason you didn't cc: the tty/serial maintainers and the
linux-serial list for this?

thanks,

greg k-h

