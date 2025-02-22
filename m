Return-Path: <linux-kselftest+bounces-27258-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7065FA406FF
	for <lists+linux-kselftest@lfdr.de>; Sat, 22 Feb 2025 10:39:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 54C557AEAAA
	for <lists+linux-kselftest@lfdr.de>; Sat, 22 Feb 2025 09:38:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9F4A207653;
	Sat, 22 Feb 2025 09:39:06 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C13246434;
	Sat, 22 Feb 2025 09:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=163.172.96.212
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740217146; cv=none; b=FmRD1mDVgLeKRqK3E/6QfNRwKmcmOMQLs6Nec0u4JGWJ4VWObkUA5vvZTzCdw+VW7dJfYE9UgaC72tca36xAfA8+ppXc9mpgTwBRyUU6guZRqI5AN0FZgP6srnMJa5mp4ZkKkXN2pHtbie36wwdPmfzcTNl1GIXV8/ZJtxFS6Ow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740217146; c=relaxed/simple;
	bh=tBnJOe2Jp2iK2XG+QCQzCSHSREDatiniWapDQu8szXg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mAXsKGXQjz89SicpWhinwLmbNZMtg+ZNKd5rPgxeWrsrUeq4ja3dc2vZckOVMbcPnhi485gpcPd1A7ZU+K2LC7pytli+T4shMSLniejzlgH1NoSZNqMnM5ftVLOl3/qiK8fMu6Mrvg3UTKWAbh436MrXwuUMXLOwMhSRYNEZDMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=1wt.eu; spf=pass smtp.mailfrom=1wt.eu; arc=none smtp.client-ip=163.172.96.212
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=1wt.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=1wt.eu
Received: (from willy@localhost)
	by pcw.home.local (8.15.2/8.15.2/Submit) id 51M9cp1k013291;
	Sat, 22 Feb 2025 10:38:51 +0100
Date: Sat, 22 Feb 2025 10:38:51 +0100
From: Willy Tarreau <w@1wt.eu>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc: Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftests/nolibc: only run constructor tests on nolibc
Message-ID: <20250222093851.GA13258@1wt.eu>
References: <20250212-nolibc-test-constructor-v1-1-c963875b3da4@weissschuh.net>
 <20250216093940.GA2192@1wt.eu>
 <670b08a4-9bc5-4700-94bb-272fda5c59d7@t-8ch.de>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <670b08a4-9bc5-4700-94bb-272fda5c59d7@t-8ch.de>
User-Agent: Mutt/1.10.1 (2018-07-13)

Hi Thomas,

On Mon, Feb 17, 2025 at 10:24:11PM +0100, Thomas Weißschuh wrote:
> On 2025-02-16 10:39:40+0100, Willy Tarreau wrote:
> > On Wed, Feb 12, 2025 at 07:01:01PM +0100, Thomas Weißschuh wrote:
> > > The nolibc testsuite can be run against other libcs to test for
> > > interoperability. Some aspects of the constructor execution are not
> > > standardized and musl does not provide all tested feature, for one it
> > > does not provide arguments to the constructors, anymore?
> > >
> > > Skip the constructor tests on non-nolibc configurations.
> > 
> > I'm not much surprised, I've always avoided arguments in my use of
> > constructors due to a lack of portability. However the patch disables
> > all constructors tests, while I'm seeing that the linkage_test version
> > does not make use of arguments, though there is an implied expectation
> > that they're executed in declaration order, which is not granted.
> 
> The tests are written specifically to test for execution order.
> While we can not rely on the order for other libcs, the idea was to
> expect a given order for the nolibc implementation.

OK.

> > I'm wondering if we shouldn't make the tests more robust:
> >   1) explicitly set linkage_test_constructor_test_value to zero in the
> >      declaration, because here it's not set so we have no guarantee
> >      (we're not in the kernel)
> 
> Ack.
> 
> >   2) only add values to check for cumulated values (e.g. |1 in const1,
> >      |2 in const2) and verify that the result is properly 3
> 
> This would stop validating the order.

That was my purpose but OK I got it. Then there's another option which
preserves the order and even gives history:

  __attribute__((constructor))
  static void constructor1(void)
  {
      constructor_test_value = constructor_test_value * 0x10 + 1;
  }

  __attribute__((constructor))
  static void constructor2(void)
  {
      constructor_test_value = constructor_test_value * 0x10 + 2;
  }
 
Then if executed in the right order, you'll find 0x12. If both
are executed in any order, it will always be >= 0x10. If only one
is executed, it will be < 0x10, and if none is executed, it's 0.

Willy

