Return-Path: <linux-kselftest+bounces-14764-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77D909468E6
	for <lists+linux-kselftest@lfdr.de>; Sat,  3 Aug 2024 11:45:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 923EE1C209F6
	for <lists+linux-kselftest@lfdr.de>; Sat,  3 Aug 2024 09:45:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF63267A0D;
	Sat,  3 Aug 2024 09:45:39 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3256310A1A;
	Sat,  3 Aug 2024 09:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=163.172.96.212
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722678339; cv=none; b=faIvZhX01Ax/1POQhhbC9OT2XlSpyxS6y4fAhzJu7pJGCIcQnVlPysa15uN6NN2/B36doR/rHGUFQtLJyezFCUmPaG8tXlhGnZLyE+DxkcO865FdpTs0b2fvFyrephyz1sf0ml9Ku1sgUwChud9QRMg7k5dRRcgDZ0bWGcE8Kmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722678339; c=relaxed/simple;
	bh=Bi0dE/WuHGRJQfK2kHETxGNZ/GbQZ1Cp9W16DCz7Cyg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ym+7gM6hoidxeATufyXQRb1i4+MLjCOAhtgMc36UGBlFblnJ1NsgMMtJ8dQt8Ge5lrWVBzTs/6atZpw0dcpMpsNEqn9zRYD89varxZsDcagXq2M1nHQg0hJZN1wzZ1E+nh1OyWo/5VEXvKNoB41qpwopaaQ3+PGPAQI/VK1kMUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=1wt.eu; spf=pass smtp.mailfrom=1wt.eu; arc=none smtp.client-ip=163.172.96.212
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=1wt.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=1wt.eu
Received: (from willy@localhost)
	by pcw.home.local (8.15.2/8.15.2/Submit) id 4739jUnQ029260;
	Sat, 3 Aug 2024 11:45:30 +0200
Date: Sat, 3 Aug 2024 11:45:30 +0200
From: Willy Tarreau <w@1wt.eu>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc: Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 09/12] selftests/nolibc: add support for LLVM= parameter
Message-ID: <20240803094530.GE29127@1wt.eu>
References: <20240728-nolibc-llvm-v1-0-bc384269bc35@weissschuh.net>
 <20240728-nolibc-llvm-v1-9-bc384269bc35@weissschuh.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240728-nolibc-llvm-v1-9-bc384269bc35@weissschuh.net>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Sun, Jul 28, 2024 at 12:10:03PM +0200, Thomas Weiﬂschuh wrote:
> Makefile.include can modify CC and CFLAGS for usage with clang.
> Make use of it.
> 
> Signed-off-by: Thomas Weiﬂschuh <linux@weissschuh.net>
> ---
>  tools/testing/selftests/nolibc/Makefile | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/tools/testing/selftests/nolibc/Makefile b/tools/testing/selftests/nolibc/Makefile
> index 8000bc3c408b..cdff317c35f2 100644
> --- a/tools/testing/selftests/nolibc/Makefile
> +++ b/tools/testing/selftests/nolibc/Makefile
> @@ -155,6 +155,9 @@ CFLAGS  ?= -Os -fno-ident -fno-asynchronous-unwind-tables -std=c89 -W -Wall -Wex
>  		$(CFLAGS_$(XARCH)) $(CFLAGS_STACKPROTECTOR) $(CFLAGS_EXTRA)
>  LDFLAGS :=
>  
> +# Modify CFLAGS based on LLVM=
> +include $(srctree)/tools/scripts/Makefile.include

I'm confused, doesn't it precisely undo the previous patch, which
said that we ought not to include Makefile.include as it makes it
harder for LLVM ?

If so, I suspect that both commits should be squashed with a better
explanation for both operations at once (e.g. maybe "move makefile
inclusion later to benefit from LLVM=..." etc).

Thanks,
Willy

