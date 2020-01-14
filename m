Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0B4FD13AEF2
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Jan 2020 17:15:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727073AbgANQOw (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 14 Jan 2020 11:14:52 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:52306 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726839AbgANQOv (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 14 Jan 2020 11:14:51 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00EG9OZK070392;
        Tue, 14 Jan 2020 16:14:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : in-reply-to : message-id : references : mime-version :
 content-type; s=corp-2019-08-05;
 bh=Yno/8o3VD6Dg4efinphoYmptXGewwjphjyePJ/y+XUI=;
 b=jUqcROsPqrvy/K6MNQ9jmLIppBKSZG1NxL4fv7NUh1zoelNu9I0jZPD0/7sjPtmiv1RZ
 AZHuSEmtdOEspgBbGHAVPzt8b/XMqcZHVTK1vNktP0RMm7Wx+sQzqZ57B4pcg8C8lweY
 mDvAOhFBW0SugJp/z9WzB8oAm3gpN1OA8aVbWIw84RzrZp+nqWIhohCYkBcGnAuhpgha
 FmF0dGrVI7h3AzAkFmDOK7nDPoNXRRSzeqoWqQAfAchLlflEkDHPXtWETXZ0/4Qtbuf2
 nsOvM8q8aR4bPr6V264xnI0ZNP/TR39fp7jkquos0R93XY5Ga+v/CAg8YM3YUqFr5902 0w== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 2xf74s70h7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 Jan 2020 16:14:36 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00EG9RFh111084;
        Tue, 14 Jan 2020 16:14:35 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3030.oracle.com with ESMTP id 2xh2tny7fg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 Jan 2020 16:14:35 +0000
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 00EGEYEP007786;
        Tue, 14 Jan 2020 16:14:34 GMT
Received: from dhcp-10-175-171-251.vpn.oracle.com (/10.175.171.251)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 14 Jan 2020 08:14:34 -0800
Date:   Tue, 14 Jan 2020 16:14:22 +0000 (GMT)
From:   Alan Maguire <alan.maguire@oracle.com>
X-X-Sender: alan@dhcp-10-175-171-251.vpn.oracle.com
To:     Brendan Higgins <brendanhiggins@google.com>
cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        KUnit Development <kunit-dev@googlegroups.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Alan Maguire <alan.maguire@oracle.com>
Subject: Re: linux-next: Tree for Jan 13
 (drivers/base/test/property-entry-test.o)
In-Reply-To: <CAFd5g454Xgb-tnG-rBQ3fkCe2bsO7M8_dauOTpG3bxDjnxOX9A@mail.gmail.com>
Message-ID: <alpine.LRH.2.20.2001141612110.14991@dhcp-10-175-171-251.vpn.oracle.com>
References: <20200113181457.209ab4a5@canb.auug.org.au> <eddaa93c-3bde-a9ed-5ee7-766f3cd51a43@infradead.org> <20200114104049.5244f612@canb.auug.org.au> <CAFd5g454Xgb-tnG-rBQ3fkCe2bsO7M8_dauOTpG3bxDjnxOX9A@mail.gmail.com>
User-Agent: Alpine 2.20 (LRH 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9499 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-2001140137
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9499 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-2001140137
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, 13 Jan 2020, Brendan Higgins wrote:

> +KUnit Development
> +open list:KERNEL SELFTEST FRAMEWORK
> 
> On Mon, Jan 13, 2020 at 3:40 PM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> >
> > Hi Randy,
> >
> > On Mon, 13 Jan 2020 14:59:54 -0800 Randy Dunlap <rdunlap@infradead.org> wrote:
> > >
> > > on i386:
> > >
> > > WARNING: modpost: missing MODULE_LICENSE() in drivers/base/test/property-entry-test.o
> > > see include/linux/module.h for more information
> >
> > Sorry, I missed that yesterday.
> >
> > Caused by commit
> >
> >   c032ace71c29 ("software node: add basic tests for property entries")
> >
> > from the pm tree interacting with commit
> >
> >   9fe124bf1b77 ("kunit: allow kunit to be loaded as a module")
> >
> > from the kunit-next tree.
> 
> Yes, the problem seems to be that the property-entry-test is turned on
> when CONFIG_KUNIT is y or m.
> 
> From drivers/base/test/Makefile:
> ...
> obj-$(CONFIG_KUNIT) += property-entry-test.o
> 
> It seems we can fix it just by adding the missing MODULE_LICENSE, but
> I think there is a bigger question of whether we should let people do
> this. Do we want to just let people have their tests run whenever
> CONFIG_KUNIT is enabled? I am inclined to think no. It should be
> possible for people to run their test and their test only.
> 

I agree completely, CONFIG_KUNIT is too big a switch I
think, aside from the merge issues caused here. I've posted
a patch which introduces a per-test-suite CONFIG option:

https://lore.kernel.org/lkml/1579018183-14879-1-git-send-email-alan.maguire@oracle.com/T/#u

Brendan, do let me know if you want me to amend it to add a Suggested-by 
from you (didn't want to add it without your permission). Thanks!

Alan
