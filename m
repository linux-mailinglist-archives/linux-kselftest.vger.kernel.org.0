Return-Path: <linux-kselftest+bounces-29444-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76B40A6948F
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Mar 2025 17:16:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9ECD3463AA5
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Mar 2025 16:15:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D56D01DD0DC;
	Wed, 19 Mar 2025 16:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="Peq5GDrv"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84B4D14A09E;
	Wed, 19 Mar 2025 16:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742400949; cv=none; b=JopeAyqWXFHrCViPOxnQjE6H77i9mf/I5RoCb8NR/pGDqNA+IPEMscDmQZ4UQCbJx70CYP69SnCAyzBT8xs+d23HlBq3Y0z5ERe42ctaW1n5f/w57B0TeFFUWWcbQvjpzrAEwxspYv6sTcZTvGC8h3fZz1xDgIzLSiHC+/O6bRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742400949; c=relaxed/simple;
	bh=Tf1/4jcAAXic4Wmc2Mvv4rTmGh6E/30Wvsye7p69dtI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MbRE5WdUiJttVhBYaFKMy6C+3gjEN+FeEnJy/jq93eYipS1Kln2ZYc0TZjBQQBA2U8BeE9iTV4G4cY0GwOkk8T3v1HRS1FtlyPkMtGLy7ksf8KyWXL+f0aX6/Me/dgBD0ooUNwKZUQxxb1ldYM7Ra4KqgmVKgnoah/H8c2PhSdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=Peq5GDrv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAFCBC4CEE4;
	Wed, 19 Mar 2025 16:15:47 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="Peq5GDrv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1742400946;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2VI/j+LK4IyIwE+OVTjjCr+GSdAaazGSA6tl8MFmzFY=;
	b=Peq5GDrvXDyXsqluuFRNiMS6x0ptJGsrdn/f/Q0RxgsBVPRnSqGcM3mY19Eg2LLgKfucFb
	WP/fFZCvRJjjx2xnPDHZVFAYbygBZZ0MZfpluc/fpLN5J3ZMb+ox4mMn/Cf537bviI/Mc/
	wcZRIUeC+YyDbHJQgBGem0DNPqNTKFM=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id c2e07f44 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 19 Mar 2025 16:15:46 +0000 (UTC)
Date: Wed, 19 Mar 2025 17:15:41 +0100
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Simon Horman <horms@kernel.org>, Phil Sutter <phil@nwl.cc>,
	Florian Westphal <fw@strlen.de>, Petr Mladek <pmladek@suse.com>,
	Yoann Congal <yoann.congal@smile.fr>, wireguard@lists.zx2c4.com,
	bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCHv4 RESEND net-next 2/2] selftests: wireguard: update to
 using nft for qemu test
Message-ID: <Z9rtrVk-15Ts_BNp@zx2c4.com>
References: <20250106081043.2073169-1-liuhangbin@gmail.com>
 <20250106081043.2073169-3-liuhangbin@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250106081043.2073169-3-liuhangbin@gmail.com>

On Mon, Jan 06, 2025 at 08:10:43AM +0000, Hangbin Liu wrote:
> +	echo "file /bin/nft $(NFTABLES_PATH)/src/nft 755 0 0" >> $@
> +	echo "file /lib/libmnl.so.0 $(TOOLCHAIN_PATH)/lib/libmnl.so.0 755 0 0" >> $@
> +	echo "file /lib/libnftnl.so.11 $(TOOLCHAIN_PATH)/lib/libnftnl.so.11 755 0 0" >> $@

Can't these be statically linked into the nft binary?

