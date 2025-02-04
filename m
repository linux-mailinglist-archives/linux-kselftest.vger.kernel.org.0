Return-Path: <linux-kselftest+bounces-25687-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DC6D0A274A9
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Feb 2025 15:44:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F8AC188258E
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Feb 2025 14:44:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FDDF2139C1;
	Tue,  4 Feb 2025 14:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YXlffpRU"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5205F207679;
	Tue,  4 Feb 2025 14:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738680278; cv=none; b=GIgIapq98lGUUaIzE6XLuszh2UAQdwsHjVWdFoYmiClZ98s4ecJopuqxt56nhgnVL1euRR7qG3RCPb7OD/gVaz5yHfb+9KnCcfHXMRs5Z9giDqZDOcgTv/AvVvenPmHMnB884df2b6YSXP+kP142inbC8VVNP0VzOrwF1D3tllA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738680278; c=relaxed/simple;
	bh=9qpNVsut/c6M5WoPl9GAwPNWB0VL3neUMFBcrqESpEQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GCnvV5xZiNCgfvfwA6VbbiVd1U4Q+76yfv8eaoSOy1zAxTZgG4aGlx6bUW9QCffnrL03zyb/Ecwr2QVWfIqt5lvBrDp6+p36uSyQ2LfXCTpNmx0lCN55uG02qpqh7HvATPWE9pSfGA7IODGqSVl3JWRi24G55MGltcG+3FtjxRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YXlffpRU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28AD6C4CEDF;
	Tue,  4 Feb 2025 14:44:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738680278;
	bh=9qpNVsut/c6M5WoPl9GAwPNWB0VL3neUMFBcrqESpEQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YXlffpRUlIOfhrljsycxJmuQsSSP8zT+Eg5L+gMONdPkxtw7Ov7CVOiU7NRJXegyF
	 OmuD6XOaAEdTShp8GPyAB7k+5TKaCOprhD15gWv/DsYZudP75l/ilhJ2FcH9Wm1ic0
	 P17REi19l3dpLpNvwO0xB/Bz3/C/vmq42T/LO1jYzKnKHeFkKleRXPI97lqMkKThrj
	 esUrF7yn+FRv+0Pum3Lh43lyP7CHe/8ql9NawSUMEbwu9ZbfXesuz3pNIS80TD4Txq
	 G0LgWZTygXYmSwDI3pRlI8So3V0paYevz3ISztLJdDJ8zlpYxgFKZEX0i+PJ2YFXnF
	 WZ22U8rWlR0Ow==
Date: Tue, 4 Feb 2025 14:44:32 +0000
From: Simon Horman <horms@kernel.org>
To: Peter Seiderer <ps.report@gmx.net>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>, Nam Cao <namcao@linutronix.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>,
	Artem Chernyshev <artem.chernyshev@red-soft.ru>
Subject: Re: [PATCH net-next v3 05/10] net: pktgen: fix 'ratep 0' error
 handling (return -EINVAL)
Message-ID: <20250204144432.GI234677@kernel.org>
References: <20250203170201.1661703-1-ps.report@gmx.net>
 <20250203170201.1661703-6-ps.report@gmx.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250203170201.1661703-6-ps.report@gmx.net>

On Mon, Feb 03, 2025 at 06:01:56PM +0100, Peter Seiderer wrote:
> Given an invalid 'ratep' command e.g. 'ratep 0' the return value is '1',
> leading to the following misleading output:
> 
> - the good case
> 
> 	$ echo "ratep 100" > /proc/net/pktgen/lo\@0
> 	$ grep "Result:" /proc/net/pktgen/lo\@0
> 	Result: OK: ratep=100
> 
> - the bad case (before the patch)
> 
> 	$ echo "ratep 0" > /proc/net/pktgen/lo\@0"
> 	-bash: echo: write error: Invalid argument
> 	$ grep "Result:" /proc/net/pktgen/lo\@0
> 	Result: No such parameter "atep"
> 
> - with patch applied
> 
> 	$ echo "ratep 0" > /proc/net/pktgen/lo\@0
> 	-bash: echo: write error: Invalid argument
> 	$ grep "Result:" /proc/net/pktgen/lo\@0
> 	Result: Idle
> 
> Signed-off-by: Peter Seiderer <ps.report@gmx.net>

Reviewed-by: Simon Horman <horms@kernel.org>


