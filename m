Return-Path: <linux-kselftest+bounces-30455-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4214AA83630
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Apr 2025 04:06:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 85F723AA48A
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Apr 2025 02:06:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65FA61714B7;
	Thu, 10 Apr 2025 02:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="k6KH+ox/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtpbg150.qq.com (smtpbg150.qq.com [18.132.163.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 463CD1ADC6D
	for <linux-kselftest@vger.kernel.org>; Thu, 10 Apr 2025 02:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.132.163.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744250799; cv=none; b=YXnu82hvXOXqA/eufZNpDA/0DJ3tjlaP3QXASkEMP88IhDgvp5Cw1ACuaGIIr/kHTdJdgwaB8Bl9xtdXB1NnagFd9xtQxJeaCpG6KW0aEeUGVHuHUUPcGZyw6ra9lgDahjILnR56HnRBkh86SbY/vlSs0Hw5uKzvsIX/o5u53lE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744250799; c=relaxed/simple;
	bh=yPt/SYCJb2H5D33+mGq0yAPukrQgwFbxZn+4xgU1Mz0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bdYRlriUnKAk21x5jEw4S0xX1nb/sH/4CxLhHx59jGqM2bg3ZUCCUytqFltMahIVKp0OK6ZWxAECDUIV6OZ4MB5rFQDP8Dwc1DprUKQU5vVVHvtn3sAxEYHhW2MO5mAQV3FcSiDB94wJERXZPTvRl++IWpmFE1nPCQwGWIBWRko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=k6KH+ox/; arc=none smtp.client-ip=18.132.163.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1744250741;
	bh=4BvQZ+r0nyENHr7hTVSkbl67k1Ui6nZzygzHDktljSo=;
	h=Date:From:To:Subject:Message-ID:MIME-Version;
	b=k6KH+ox/gQDOxdAbcrQ3pvZkCNbBjSd0Xxsq6DRydscZavJYc5aIeSYHS5Uexp1Ko
	 zwBqq+n7pF+IsppkcgBPBp3Zq0DjDvujD6yEXb8+vQbdQa2FtqElRXR6dHU40NoXgi
	 EGjnyfdFWvIu6zgeLzRvPcjEK9kAM9uH032hoags=
X-QQ-mid: bizesmtp26t1744250739t41132d1
X-QQ-Originating-IP: 8d20ZpaicyMGd1JvVCa3ljkXdhsiR1rnzgxRhxHfS3o=
Received: from rocky ( [125.76.217.162])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 10 Apr 2025 10:05:36 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 11279037504239352353
Date: Thu, 10 Apr 2025 10:05:36 +0800
From: Lu Fei <lufei@uniontech.com>
To: Shuah Khan <skhan@linuxfoundation.org>, Petr Vorel <pvorel@suse.cz>
Cc: viro <viro@zeniv.linux.org.uk>,
	linux-kselftest <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH v2] unshare_test: set nr_open using soft limit
Message-ID: <0FC313BEA92B7F30+Z/cncGDpBZfEstJx@rocky>
References: <20250401015557.113872-1-lufei@uniontech.com>
 <8aa78b76-b9f9-4d23-a009-97b26aefcf33@linuxfoundation.org>
 <20250409055656.GA231133@pevik>
 <87e72133-03f0-48fe-ac0d-3f2ac278357a@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87e72133-03f0-48fe-ac0d-3f2ac278357a@linuxfoundation.org>
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:uniontech.com:qybglogicsvrgz:qybglogicsvrgz8a-0
X-QQ-XMAILINFO: Nl7eTg5yGHnwKhn1GMhyWeStKAp5jfvgTLxw1onA5sNclisEtSeYOPtB
	nJClC664bitJOQ1Flqo/omJ0y8z2HD4SZk51JpUQvlOlBnjN05pgcK8+Cxs0O5vOzPGuuyP
	hQ5LQsLfqyfo98Du+MK+qsPT263uQSUqEMvty3bZ09rYdXqabCafVr0GBS+OxlGL57LTspX
	hWxCSLhgZqapXZ85qnU8KA+t8DKQPSknm4ynLM6mnBGD+Si4+DU3V5lAK5GODx1dcva+/sO
	ikm/7XuEk9zze9P4PjlLik+RsGZMWLHVJp2NTXkuEMXa4IbwuBOk9wxzUumzMzQKkVa5Huj
	36TQN5drSSg4Lx4OzrNTQpFmt7rhMqVtTHwHvpNyTqeynFIdLA3HvSXETx/Reo092+zt9tc
	mHssDw0ZAgAucsTgb5+iEnl3KPtLPa6xDUp1rAYulwOh+ncs2haIxXgBTSLXh63b4gM3RbX
	tI9nJfh6hJjhc2eBU+M+kobddyhvHHVluT1dnX9VFEAsc9tFPzTkfp8QEiqIQe/DFqWJSHY
	5opbmfVNxXAFgYAGj/B+6/fZZsy6Fxccs1dGzyOKC/R5b8VSqUfGebvYGp2PuYb4VtI/THh
	Ye8UAov8xzMnO6YG5unEMFtxqkcKMV1GFvDTs7zLMYyH3PoLfv14f62J4iqmsmi0FFPktUW
	I6dicHmS/kAOkMK7yIP8tuF6B0Fi/Y7Tx8BNskbHp/2+LoCN2vIkqidQNbj/kKPiA0Zdv9B
	kfy7DJi8WGIGMERIfTeBk5D4+PVCRRQzspvJCG9cdkJq3Zy4DTfidXDEFnj19MBnoTtVb2m
	4WiLTw5Z+8tsCibpJ6AGXsnVll/WUgbbbeeWLxJ3puEVV5fX3Vjg15Kwa2ujwG/ZZNythjh
	Uz1HBVjBp8IDeBdp98hMXXSTx3v4EkhXoIPwpsxwEysdNoT4AmZgxv2MFICemzjswFKrhQC
	V54trLEtZVIU9GIR5gsM+fkHp
X-QQ-XMRINFO: OWPUhxQsoeAVDbp3OJHYyFg=
X-QQ-RECHKSPAM: 0

On Wed, Apr 09, 2025 at 03:30:32PM -0600, Shuah Khan wrote:
> On 4/8/25 23:56, Petr Vorel wrote:
> > > On 3/31/25 19:55, lufei wrote:
> > > > Set maximum file descriptor number limit by rlimit.rlim_max than
> > > > nr_open(hard limit). Hard limit may cause dup2 fail.
> > 
> > > > Signed-off-by: lufei <lufei@uniontech.com>
> > 
> > > Petr, Al,
> > 
> > > Okay to take this patch?
> > 
> > LGTM, hopefully I haven't overlook anything.
> > 
> > Reviewed-by: Petr Vorel <pvorel@suse.cz>
> > 
> > FYI Cyril Hrubis suggested a different approach (for LTP tests which is based on
> > this Al's test):
> > 
> > https://lore.kernel.org/ltp/Z-u7yYJpTBG8Hi6A@yuki.lan/
> > https://lore.kernel.org/ltp/Z-vwYZxLms8juTjX@yuki.lan/
> > 
> > 	filedescriptor that is >= 64 and set the nr_open to 64.
> > 
> > That would help to avoid using /proc/sys/fs/nr_open.
> > 
> 
> Thank you for this suggestion.
> 
> lufei, Can you look into this as a solution? Also the short log
> should include the subsystem: e.:
> 
> selftests:core: unshare_test: -----
> 
> thanks,
> -- Shuah
> 

Hi Shuah,

Thanks very much for reply.

I'll submit a v3 patch with dup a filedescriptor >= sizeof(long)*8 and
set nr_open to sizeof(long)*8 to trigger EMFILE.

Hi Petr, Shuah, I don't have a i686 environment, only on x86_64 has been
tested. Is this all right?

I'll re-write short log as asked in v3 patch.


