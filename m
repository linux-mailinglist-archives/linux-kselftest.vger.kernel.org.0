Return-Path: <linux-kselftest+bounces-29109-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BF6F6A62000
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Mar 2025 23:14:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 093D33BBE0B
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Mar 2025 22:14:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3FD22054EF;
	Fri, 14 Mar 2025 22:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=codeweavers.com header.i=@codeweavers.com header.b="WvJokkPe"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail.codeweavers.com (mail.codeweavers.com [4.36.192.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF8681EA7DB;
	Fri, 14 Mar 2025 22:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=4.36.192.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741990433; cv=none; b=j66ANXejUy3kwRF394KC99VeqB0CzrKAOA7dO488Hu3JqAu1iogMfn5IBd2ZNbUakBJwM/GB2Ie/Mrwu4bl98R5epxhS4Aq4b8U6pffUyujbeRzJ4X+K89Td92CdLOZbgNF9cEHN6Hk0jb9eHV5nkyAYTwPG9PDuYCCDI9w2vHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741990433; c=relaxed/simple;
	bh=VVmBqZsMCcaJ3Q8+Yuqt3FOElehWgfdMOK5BGwIXwf0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TQRGXfwcUp2MxlWjCvWUbuRBtWDKjUl3OaraRtAjh6RoHyTs/TW0QwAxOdr4C37OiPAcxgLpmwebgIl38Se97YZA+esUP5Nmb458oBbHYNrh3KMkiVCaHfZ4bXS4H4W13OeqiPJYhIgalNX3FfHaMzY1lpDCc+lpQFOERZp/vYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeweavers.com; spf=pass smtp.mailfrom=codeweavers.com; dkim=pass (2048-bit key) header.d=codeweavers.com header.i=@codeweavers.com header.b=WvJokkPe; arc=none smtp.client-ip=4.36.192.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeweavers.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeweavers.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=codeweavers.com; s=s1; h=Content-Type:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=tARROvTEyg6Bj7/m1bSPdexGBw9j/tBptRqZVsS+nxY=; b=WvJokkPeNmTKCasnzDgI/i+rAh
	16w6zBmYW77emxvV2pJrvnogHSQ9qOo4Yyw9ZR0AEIUFT2kbXLRD9XNKjBeGnZiO0MrHLplFB7/Fj
	AeIKOIihBUVaV1i8UKAAgRgWHJ0dt2TjDdfgk0cJIDlcwHy4+uU2UfQdghmF1C+1NzbCqDiK9cHtW
	R02jI3XEGxOmdLGB0hfDCSECH55EBu9eQhmuPGjVHpXRsW46DV1HuxKBwVkKokDemk3lVRsweXArW
	reD6aguHCOn1rEfrZke+bhy7laTuGUl0Bn3aUnmhAvvdHt+4iv3GRvyPZbkwtxnkQCWeycWgTAlND
	/z3bPwiw==;
Received: from cw137ip160.mn.codeweavers.com ([10.69.137.160] helo=camazotz.localnet)
	by mail.codeweavers.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <zfigura@codeweavers.com>)
	id 1ttDHq-00EN2r-0X;
	Fri, 14 Mar 2025 17:13:50 -0500
From: Elizabeth Figura <zfigura@codeweavers.com>
To: Dan Carpenter <dan.carpenter@linaro.org>, Su Hui <suhui@nfschina.com>
Cc: shuah@kernel.org, wine-devel@winehq.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject:
 Re: [PATCH 1/4] selftests: ntsync: fix the wrong condition in wake_all
Date: Fri, 14 Mar 2025 17:13:50 -0500
Message-ID: <2051560.PIDvDuAF1L@camazotz>
In-Reply-To: <00d17d6d-19c9-4431-a3ac-c0f767c533d4@nfschina.com>
References: <00d17d6d-19c9-4431-a3ac-c0f767c533d4@nfschina.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"

On Friday, 14 March 2025 05:14:30 CDT Su Hui wrote:
> On 2025/3/14 17:21, Dan Carpenter wrote:
> > On Fri, Mar 14, 2025 at 03:14:51PM +0800, Su Hui wrote:
> >> When  'manual=false' and  'signaled=true', then expected value when using
> >> NTSYNC_IOC_CREATE_EVENT should be greater than zero. Fix this typo error.
> >>
> >> Signed-off-by: Su Hui<suhui@nfschina.com>
> >> ---
> >>   tools/testing/selftests/drivers/ntsync/ntsync.c | 2 +-
> >>   1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/tools/testing/selftests/drivers/ntsync/ntsync.c b/tools/testing/selftests/drivers/ntsync/ntsync.c
> >> index 3aad311574c4..bfb6fad653d0 100644
> >> --- a/tools/testing/selftests/drivers/ntsync/ntsync.c
> >> +++ b/tools/testing/selftests/drivers/ntsync/ntsync.c
> >> @@ -968,7 +968,7 @@ TEST(wake_all)
> >>   	auto_event_args.manual = false;
> >>   	auto_event_args.signaled = true;
> >>   	objs[3] = ioctl(fd, NTSYNC_IOC_CREATE_EVENT, &auto_event_args);
> >> -	EXPECT_EQ(0, objs[3]);
> >> +	EXPECT_LE(0, objs[3]);
> > It's kind of weird how these macros put the constant on the left.
> > It returns an "fd" on success.  So this look reasonable.  It probably
> > won't return the zero fd so we could probably check EXPECT_LT()?
> Agreed, there are about 29 items that can be changed to EXPECT_LT().
> I can send a v2 patchset with this change if there is no more other
> suggestions.

I personally think it looks wrong to use EXPECT_LT(), but I'll certainly defer to a higher maintainer on this point.



