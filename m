Return-Path: <linux-kselftest+bounces-11044-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 548AA8D6951
	for <lists+linux-kselftest@lfdr.de>; Fri, 31 May 2024 20:58:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A2BB1F26CBD
	for <lists+linux-kselftest@lfdr.de>; Fri, 31 May 2024 18:58:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8662B7F47B;
	Fri, 31 May 2024 18:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="HHYVz9wH"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF3BF7D40E;
	Fri, 31 May 2024 18:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717181931; cv=none; b=Tn9Y+R6LJx0iJm/vu+bKM12lhKFk9WPjmnOH/Xtx0R13gM5SqY1Ci976zHqugju9ybE47Zajth5hxjcKM8J/1uAosWfYDLOc76pOBKbOzSmbi2oPEhkGt4I7bl4wazgHyCBlhMfJHrajMh+1kWdFzN7R6zqm4SvJFH6hkA4o2dc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717181931; c=relaxed/simple;
	bh=mJQDp5OVE52hSetYA8xq+qtJdIpr+7mUyWY61xiyUKs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dL1Hpytp/D5SdO2N2P6IUzbZF9iVAn2dCNfanbepinnpbTuQ9LIQmUMZqB1nX1iTSm8zZBWOeD01zqvIQLY4oETSTyPsXBNSvT4DI0HuskkF6Na1h/vrbqWkAGfggNIMV4rp0EGiAdmdRyHdjEVeLk0N4I+chO5uLVesmHQ3Zyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=HHYVz9wH; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=Content-Type:MIME-Version:Message-ID:Subject:From:Date:From
	:Subject; bh=J00hHbCv0tmWX3RsYRCdEYWH/PP4cQcPiWZYM0T92ck=; b=HHYVz9wHuEJdBcIo
	WMaLl2zl1miSHNW8SWzfQ8zlbKPhzpnTRYCbSGom/Qg84Tce6JSpQ6CnsZqflASI4sKeFpCyID1Xq
	2SDmzBFq0j6VcYuYM/+Uu+w48NyfzNz2ZZiPVBtyvVvaQ9oKVH2LeIqClHL8YpvHGgN0WdTr5gsVa
	tI/MGPmrflJGKPGpDw5TojQwAlSaeYphyvD3j+9JybofM9SdtevWaBpav+5+4tx/h4vdSejXMX/Ol
	WgnNnhn/Ea3x7Gwh2Qw+0va46CTBTClrDiTLXivI1fw/rqGZsTlCakCzbBe1b6HDHr6utrhGHfeBk
	D2Q0XVuDBIOu1lu6qQ==;
Received: from dg by mx.treblig.org with local (Exim 4.96)
	(envelope-from <dg@treblig.org>)
	id 1sD7Sf-003drn-1k;
	Fri, 31 May 2024 18:58:45 +0000
Date: Fri, 31 May 2024 18:58:45 +0000
From: "Dr. David Alan Gilbert" <linux@treblig.org>
To: Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc: davidgow@google.com, linux-kselftest@vger.kernel.org,
	kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] list: test: remove unused struct 'klist_test_struct'
Message-ID: <Zlod5TMzmXinDu2X@gallifrey>
References: <20240531151801.128792-1-linux@treblig.org>
 <89e07c93-a54d-4cc2-8ee1-664389ffcdd7@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <89e07c93-a54d-4cc2-8ee1-664389ffcdd7@collabora.com>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/6.1.0-21-amd64 (x86_64)
X-Uptime: 18:57:18 up 23 days,  6:11,  1 user,  load average: 0.15, 0.03, 0.01
User-Agent: Mutt/2.2.12 (2023-09-09)

* Muhammad Usama Anjum (usama.anjum@collabora.com) wrote:
> On 5/31/24 8:18 PM, linux@treblig.org wrote:
> > From: "Dr. David Alan Gilbert" <linux@treblig.org>
> > 
> > 'klist_test_struct' has been unused since the original
> > commit 57b4f760f94d ("list: test: Test the klist structure").
> Probably a fixes by tag would be needed here.

I'm generally avoiding fixes tags in this set of changes, since
  a) They have no behavioural change at all.
  b) Downstream and stable kernel people use fixes tags to indicate
     stuff they should pick up if they have the original, and there's
     no need for them to do that with this cleanup.

Dave

> > 
> > Remove it.
> > 
> > Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
> > ---
> >  lib/list-test.c | 6 ------
> >  1 file changed, 6 deletions(-)
> > 
> > diff --git a/lib/list-test.c b/lib/list-test.c
> > index 0cc27de9cec8..383ee0ad582e 100644
> > --- a/lib/list-test.c
> > +++ b/lib/list-test.c
> > @@ -1201,12 +1201,6 @@ static struct kunit_suite hlist_test_module = {
> >  };
> >  
> >  
> > -struct klist_test_struct {
> > -	int data;
> > -	struct klist klist;
> > -	struct klist_node klist_node;
> > -};
> > -
> >  static int node_count;
> >  static struct klist_node *last_node;
> >  
> 
> -- 
> BR,
> Muhammad Usama Anjum
-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/

