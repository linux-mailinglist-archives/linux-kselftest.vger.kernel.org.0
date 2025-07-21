Return-Path: <linux-kselftest+bounces-37732-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FC41B0BB0F
	for <lists+linux-kselftest@lfdr.de>; Mon, 21 Jul 2025 04:57:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6386917417A
	for <lists+linux-kselftest@lfdr.de>; Mon, 21 Jul 2025 02:57:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BAA21EB5D6;
	Mon, 21 Jul 2025 02:57:39 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35E8749625;
	Mon, 21 Jul 2025 02:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=163.172.96.212
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753066658; cv=none; b=b3jBH3wrj/M+qOS4smB7I5ZsLtiCB308fGTgs0rJdCZiYyryqjqrDLoez4An+nklRIY68290raRBeMVdZl7zuDjofWj5byzczgneXjuEQFpCflB2XG6carILBEa4akjAvnIiIisKDD1R5l7TRN73sUazGltiYEizvcBkYolXGzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753066658; c=relaxed/simple;
	bh=DT2qFUbrALMb/Ihn2YKx1cwZ7lLCygvn87yXHQHlcD0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Slz9BUIM5LLQCVkgy7/EZgO5y/sKxdthy9dERU7HwkqKxYF7nyveD8aHYEtRor6iffIHbCoExr7h90N6SC+C//QkVVzP/+L1nODfDFOursejAQf9scPxx10xXoHJ1DkiryzbHGsjOOLx1BEo2o+RsXKQVeoE1IDoEJm6Hc22Uc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=1wt.eu; spf=pass smtp.mailfrom=1wt.eu; arc=none smtp.client-ip=163.172.96.212
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=1wt.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=1wt.eu
Received: (from willy@localhost)
	by pcw.home.local (8.15.2/8.15.2/Submit) id 56L2vUKA001992;
	Mon, 21 Jul 2025 04:57:30 +0200
Date: Mon, 21 Jul 2025 04:57:30 +0200
From: Willy Tarreau <w@1wt.eu>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc: Shuah Khan <shuah@kernel.org>, Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
        Bill Wendling <morbo@google.com>,
        Justin Stitt <justinstitt@google.com>, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH 0/3] selftests/nolibc: enable qemu-system tests with LLVM
 builds
Message-ID: <20250721025730.GC1886@1wt.eu>
References: <20250719-nolibc-llvm-system-v1-0-1730216ce171@weissschuh.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250719-nolibc-llvm-system-v1-0-1730216ce171@weissschuh.net>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Sat, Jul 19, 2025 at 05:38:26PM +0200, Thomas Weiﬂschuh wrote:
> Currently the test setup does not support running nolibc-test built with
> LLVM in qemu-system. Enable this.
> 
> FYI, sparc32 on LLVM seems to be broken at the moment. To me this looks
> like a LLVM regression, emitting invalid object code.
> 
> Signed-off-by: Thomas Weiﬂschuh <linux@weissschuh.net>

For the series, once the help message is adjusted:

  Acked-by: Willy Tarreau <w@1wt.eu>

Thanks!
Willy

