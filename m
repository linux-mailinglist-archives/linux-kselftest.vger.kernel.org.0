Return-Path: <linux-kselftest+bounces-29148-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 528C6A6327A
	for <lists+linux-kselftest@lfdr.de>; Sat, 15 Mar 2025 21:29:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5BAFC18912E6
	for <lists+linux-kselftest@lfdr.de>; Sat, 15 Mar 2025 20:30:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E113A1A00F0;
	Sat, 15 Mar 2025 20:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=codeweavers.com header.i=@codeweavers.com header.b="mFXn99Ra"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail.codeweavers.com (mail.codeweavers.com [4.36.192.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6B7B199938;
	Sat, 15 Mar 2025 20:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=4.36.192.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742070587; cv=none; b=cfnbTiwvJh9kLk3zhNDG78xfeHEAF3drmMRCVahoH/0/FuLnpnL0iXAY7iHx3Tk1CUdmYfCegwyqm07RhIalSTxvbl8Fx68RGixFqk7dd/Y+VEmNM6zhhnwMtXMIw4rrlHbpbgRlva5ne27LgDNP0wCJvcgox9Fky+w/p/sCIJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742070587; c=relaxed/simple;
	bh=bESWuJ+Itq4oJ3aJ397TS7MjXGGRBg/L2tRAqVurZDE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RxB6hooOSISDUw0pL59WzWZYXgjGorGSNBRxAREDwW+K/Iskkh0p6mNgxnoDBlBE9T4BViYa+bp3Gut1qCj+NSwb636Q9A8wmT5LrhQqf+bae0Qa4GyH1akm6jIP6ycnvx+Qlpkix07/+azHLLSpyK9j5QIbgWRhSPtoAy/YLuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeweavers.com; spf=pass smtp.mailfrom=codeweavers.com; dkim=pass (2048-bit key) header.d=codeweavers.com header.i=@codeweavers.com header.b=mFXn99Ra; arc=none smtp.client-ip=4.36.192.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeweavers.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeweavers.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=codeweavers.com; s=s1; h=Content-Type:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=mAKXnqJdcH8Ooug16GzPe92yZG0ErD4qlNwxhet2A7Y=; b=mFXn99RaEtHUudZVObKDbdlTmq
	FBMJCw+/XUVWe7xPrLtGWFsAwhPIe60dqcnwi+EelHfoD77tnpxoeUymYy3VBZ7P1+FRNN2BhNb7F
	CTWpTUoIGFSBoRA2B8lowtdw+Zqouw8+WVbz5Pp1q6/GHjFJ6/AUmWlBCwiWTzbavYBz2JybdFcc+
	l9MKQNFyng6a5XVsnfqK2q8OOFkX31Eo8r9HytnlNaDGOmzYm35eJMC1UrAN8+Fbiow+P4EIvacDh
	LeUY1lAAWkmNpXPJH+w0rhxk3wdmt6wMiFp+MFIjHXNvbL24jm1ojbn9CnGFF4ebP8a0hDj+S6YJ6
	57ChAsKQ==;
Received: from cw137ip160.mn.codeweavers.com ([10.69.137.160] helo=camazotz.localnet)
	by mail.codeweavers.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <zfigura@codeweavers.com>)
	id 1ttY8d-00HXBc-0q;
	Sat, 15 Mar 2025 15:29:43 -0500
From: Elizabeth Figura <zfigura@codeweavers.com>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Su Hui <suhui@nfschina.com>, shuah@kernel.org, wine-devel@winehq.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel-janitors@vger.kernel.org
Subject:
 Re: [PATCH 1/4] selftests: ntsync: fix the wrong condition in wake_all
Date: Sat, 15 Mar 2025 15:29:43 -0500
Message-ID: <1961744.6tgchFWduM@camazotz>
In-Reply-To: <f86c7af5-9e7f-41a0-a357-6a356fdeb0b9@stanley.mountain>
References:
 <00d17d6d-19c9-4431-a3ac-c0f767c533d4@nfschina.com>
 <2051560.PIDvDuAF1L@camazotz>
 <f86c7af5-9e7f-41a0-a357-6a356fdeb0b9@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"

On Saturday, 15 March 2025 04:39:46 CDT Dan Carpenter wrote:
> On Fri, Mar 14, 2025 at 05:13:50PM -0500, Elizabeth Figura wrote:
> > On Friday, 14 March 2025 05:14:30 CDT Su Hui wrote:
> > > On 2025/3/14 17:21, Dan Carpenter wrote:
> > > > On Fri, Mar 14, 2025 at 03:14:51PM +0800, Su Hui wrote:
> > > >> When  'manual=false' and  'signaled=true', then expected value when using
> > > >> NTSYNC_IOC_CREATE_EVENT should be greater than zero. Fix this typo error.
> > > >>
> > > >> Signed-off-by: Su Hui<suhui@nfschina.com>
> > > >> ---
> > > >>   tools/testing/selftests/drivers/ntsync/ntsync.c | 2 +-
> > > >>   1 file changed, 1 insertion(+), 1 deletion(-)
> > > >>
> > > >> diff --git a/tools/testing/selftests/drivers/ntsync/ntsync.c b/tools/testing/selftests/drivers/ntsync/ntsync.c
> > > >> index 3aad311574c4..bfb6fad653d0 100644
> > > >> --- a/tools/testing/selftests/drivers/ntsync/ntsync.c
> > > >> +++ b/tools/testing/selftests/drivers/ntsync/ntsync.c
> > > >> @@ -968,7 +968,7 @@ TEST(wake_all)
> > > >>   	auto_event_args.manual = false;
> > > >>   	auto_event_args.signaled = true;
> > > >>   	objs[3] = ioctl(fd, NTSYNC_IOC_CREATE_EVENT, &auto_event_args);
> > > >> -	EXPECT_EQ(0, objs[3]);
> > > >> +	EXPECT_LE(0, objs[3]);
> > > > It's kind of weird how these macros put the constant on the left.
> > > > It returns an "fd" on success.  So this look reasonable.  It probably
> > > > won't return the zero fd so we could probably check EXPECT_LT()?
> > > Agreed, there are about 29 items that can be changed to EXPECT_LT().
> > > I can send a v2 patchset with this change if there is no more other
> > > suggestions.
> > 
> > I personally think it looks wrong to use EXPECT_LT(), but I'll certainly
> > defer to a higher maintainer on this point.
> 
> I'm not sure I understand what you are saying.  Are you saying that we
> should allow zero as an expected file descriptor here?  I don't have
> strong feelings about that either way.

Yes, my apologies for the ambiguous wording. That is, EXPECT_LE looks more correct to me than EXPECT_LT per se.

> Putting variables on the right, Yoda speak is.  Unnatural is.

Yes, I certainly agree with this. I wrote it this way in the first place because I was following some other example, I forget which.

> I did a git grep and the KUNIT_EXPECT_LT() just calls the parameters
> left and right instead of "expected" and "seen".  Expected is wrong
> for LT because we expect it to be != to the expected value.  It's
> the opposite.  We're expecting the unexpected!  It would be better
> to just call them left and right.
> 
> regards,
> dan carpenter
> 





