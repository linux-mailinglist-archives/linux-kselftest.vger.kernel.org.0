Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 27C6A103C8B
	for <lists+linux-kselftest@lfdr.de>; Wed, 20 Nov 2019 14:49:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728267AbfKTNth (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 20 Nov 2019 08:49:37 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:60286 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727794AbfKTNth (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 20 Nov 2019 08:49:37 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xAKDmZKI129712;
        Wed, 20 Nov 2019 13:49:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : in-reply-to : message-id : references : mime-version :
 content-type; s=corp-2019-08-05;
 bh=+eyLSsZJmPcn6jglSF0/ytOzJ+jBBtYLNIFOJ/rTJ6U=;
 b=FLW8JeXaxKVlBJc1oIPmEDsoPL2RJpjHH6xeYA7J4k9JO0MGn5v3mtzPCs05aKtszPbj
 g5oD+RqOanIE9hBEjQ8icRgtmWnZXicVkv/ibXHOrpep4Ua8OFZnoRuFxxN16PE2ldPq
 WOI8GRiL4AIC5TC6vmqhP5vV87C8aNMXG4dDwtgXJ5C31kkezmf3OnEE5QDB2kVDnVRU
 rXvYwmjjErS1lZhFIxLUuOuwJtSrTyJgoCkh45UZ/bkPVXaT4XKe1dnyx7Jv2wqUDCR9
 LM2W5GXvcGU/LbxDQoSfn+CoFkZEVb87ufk0XyVzYHV+A9y0kKzEmWUzrbRhDG/kBHlz 8Q== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 2wa92pwm45-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Nov 2019 13:49:07 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xAKDkvO0041546;
        Wed, 20 Nov 2019 13:47:07 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3030.oracle.com with ESMTP id 2wd47v6d2u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Nov 2019 13:47:06 +0000
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id xAKDkE0o001401;
        Wed, 20 Nov 2019 13:46:14 GMT
Received: from dhcp-10-175-162-125.vpn.oracle.com (/10.175.162.125)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 20 Nov 2019 05:46:14 -0800
Date:   Wed, 20 Nov 2019 13:46:00 +0000 (GMT)
From:   Alan Maguire <alan.maguire@oracle.com>
X-X-Sender: alan@dhcp-10-175-162-125.vpn.oracle.com
To:     Stephen Boyd <sboyd@kernel.org>
cc:     Alan Maguire <alan.maguire@oracle.com>, brendanhiggins@google.com,
        linux-kselftest@vger.kernel.org, skhan@linuxfoundation.org,
        linux-kernel@vger.kernel.org, kunit-dev@googlegroups.com,
        keescook@chromium.org, yzaikin@google.com,
        akpm@linux-foundation.org, yamada.masahiro@socionext.com,
        catalin.marinas@arm.com, joe.lawrence@redhat.com,
        penguin-kernel@i-love.sakura.ne.jp, urezki@gmail.com,
        andriy.shevchenko@linux.intel.com, corbet@lwn.net, tytso@mit.edu,
        adilger.kernel@dilger.ca, mcgrof@kernel.org,
        linux-ext4@vger.kernel.org, linux-doc@vger.kernel.org,
        Knut Omang <knut.omang@oracle.com>
Subject: Re: [PATCH v4 linux-kselftest-test 5/6] kunit: allow kunit to be
 loaded as a module
In-Reply-To: <20191119211315.4EFC6223E4@mail.kernel.org>
Message-ID: <alpine.LRH.2.20.1911201144520.19458@dhcp-10-175-162-125.vpn.oracle.com>
References: <1573812972-10529-1-git-send-email-alan.maguire@oracle.com> <1573812972-10529-6-git-send-email-alan.maguire@oracle.com> <20191119211315.4EFC6223E4@mail.kernel.org>
User-Agent: Alpine 2.20 (LRH 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9446 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=3 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-1911200123
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9446 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=3 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-1911200124
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, 19 Nov 2019, Stephen Boyd wrote:

> Quoting Alan Maguire (2019-11-15 02:16:11)
> > diff --git a/lib/kunit/test.c b/lib/kunit/test.c
> > index 87b5cf1..41ef71a 100644
> > --- a/lib/kunit/test.c
> > +++ b/lib/kunit/test.c
> > @@ -486,3 +486,16 @@ void kunit_cleanup(struct kunit *test)
> >         }
> >  }
> >  EXPORT_SYMBOL_GPL(kunit_cleanup);
> > +
> > +static int kunit_init(void)
> 
> Missing __init?
>

Oops, will fix.
 
> > +{
> > +       return 0;
> > +}
> > +late_initcall(kunit_init);
> 
> It looks pretty weird that this doesn't do anything in the module init
> or exit path. How does it work? And why does it need to be late init if
> nothing is called from here?
>

I used a late_initcall() here because if there is initialization code in 
the future (say setting up debugfs, sysctl tables etc), it will get run 
irrespective of whether kunit is built as a module or not.  For the module
case, we need init/exit to ensure the module can be unloaded 
successfully.

> > +
> > +static void __exit kunit_exit(void)
> > +{
> > +}
> > +module_exit(kunit_exit);
> > +
> > +MODULE_LICENSE("GPL");
> 
> I guess should be "GPL v2"?
> 

Good catch, will fix here and elsewhere, thanks!

BTW in replying to your review of patch 1 I made a mistake; we do in fact 
need to add the "#include <linux/kernel.h>" in assert.h as we are removing 
the "#include <kunit/string-stream.h>".  The latter indirectly includes 
linux/kernel.h which allows us to find definition for "struct va_format"
used in the struct kunit_assert definition. Apologies about this.

I'll have a go at generating v5 using -C as requested. Thanks again for 
the careful review!

Alan
