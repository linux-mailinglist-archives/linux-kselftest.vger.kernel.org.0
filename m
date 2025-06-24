Return-Path: <linux-kselftest+bounces-35667-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D52CAE5CAF
	for <lists+linux-kselftest@lfdr.de>; Tue, 24 Jun 2025 08:17:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A4E73B85C6
	for <lists+linux-kselftest@lfdr.de>; Tue, 24 Jun 2025 06:16:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76E121C8639;
	Tue, 24 Jun 2025 06:17:03 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C80E19AD48;
	Tue, 24 Jun 2025 06:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=163.172.96.212
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750745823; cv=none; b=cK4tjyQOViJlXbxUKACVAIJk8R9w0U8Uu/mAR+qydg7rORLd97yL0FeARYPTLxNjNYyDQ51+skP9pax69QDiES1lkqOpgSYX215RonBnUnFIc3ZfkyZsZr70ZgZ9yEXbVKyh1Mm9RjsbX8dCqSQWzmAMhu/BmAbN4J0jA4Caf9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750745823; c=relaxed/simple;
	bh=0aNwrtkXI+uUiY/BGNksdhClK5e8HwszF3+9vayo5j4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hrlJ8bxNH6B+OOHwK0GLbqSq+NwYhYGnwZh27ihlpIe6yNyi1HHvl6VEEcKO+4ArTRwbAXDqCg7ca60+4DrLOkVRmW0ak+zAvnJPRqT6VnbgRRr4Yx9eOgY5XN8kQm12wIoK7JFdJZMioDYOuyA+7PulT5Su1M/lR8jHCwPoQYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=1wt.eu; spf=pass smtp.mailfrom=1wt.eu; arc=none smtp.client-ip=163.172.96.212
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=1wt.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=1wt.eu
Received: (from willy@localhost)
	by pcw.home.local (8.15.2/8.15.2/Submit) id 55O67OOW030925;
	Tue, 24 Jun 2025 08:07:24 +0200
Date: Tue, 24 Jun 2025 08:07:24 +0200
From: Willy Tarreau <w@1wt.eu>
To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>,
        Yoshinori Sato <ysato@users.osdn.me>, Rich Felker <dalias@libc.org>,
        Shuah Khan <shuah@kernel.org>, linux-sh@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/3] tools/nolibc: add support for SuperH
Message-ID: <20250624060724.GA30919@1wt.eu>
References: <20250623-nolibc-sh-v2-0-0f5b4b303025@weissschuh.net>
 <6d83088ebfeee7f7d3190872234f7b53ee758c65.camel@physik.fu-berlin.de>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6d83088ebfeee7f7d3190872234f7b53ee758c65.camel@physik.fu-berlin.de>
User-Agent: Mutt/1.10.1 (2018-07-13)

Hi Adrian,

On Tue, Jun 24, 2025 at 08:03:47AM +0200, John Paul Adrian Glaubitz wrote:
> Hi Thomas,
> 
> On Mon, 2025-06-23 at 23:15 +0200, Thomas Weißschuh wrote:
> > Add support for SuperH/"sh" to nolibc.
> > Only sh4 is tested for now.
> > 
> > This is only tested on QEMU so far.
> > Additional testing would be very welcome.
> > Test instructions:
> > $ cd tools/testings/selftests/nolibc/
> > $ make -f Makefile.nolibc ARCH=sh CROSS_COMPILE=sh4-linux- nolibc-test
> > $ file nolibc-test
> > nolibc-test: ELF 32-bit LSB executable, Renesas SH, version 1 (SYSV), statically linked, not stripped
> > $ ./nolibc-test
> > Running test 'startup'
> > 0 argc = 1                                                        [OK]
> > ...
> > Total number of errors: 0
> > Exiting with status 0
> 
> Apologies, I haven't been able to test this yet as my board currently
> doesn't want to boot kernels newer than v6.5.0 and I have not been able
> to bisect the problem yet.
> 
> Can I test this on v6.5.0 as well?

In theory it should be OK as we try to support oldest supported kernels.

Willy

