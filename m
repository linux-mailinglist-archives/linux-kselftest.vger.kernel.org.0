Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 929FC8E918
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Aug 2019 12:36:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731059AbfHOKgJ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 15 Aug 2019 06:36:09 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:49000 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730996AbfHOKgJ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 15 Aug 2019 06:36:09 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x7FAYPJD122956;
        Thu, 15 Aug 2019 10:35:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : subject
 : from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=corp-2019-08-05;
 bh=B844NRkiFX/nARJ/+oFK5xLBlkISe3Mkaclr3CxPrX0=;
 b=n5uEtNR+N/27rSpNgw4NCJ6G1jIOoey/GiYCBampeHs4mDc6iyH5SAYswmxPAMCWX/3P
 TP8OmJCr5lLn6bbe1IMBGh1ojBznCYMIH6s8vyIPODzb+qnBZpgQqeSZfJ74B0dJxZqd
 svyMJ/+7JResOTqrba2CKsbIdH3E21nhhsabAIBYSn1xHc1tVGE5k5cHSYrUgZ3EDIxR
 WtOejxOSSDIVQki45mzRw/6vK3b5U0qt1zjBYgTqEzxtiB/LnoiYoAYBaZuxZnaS4mcQ
 s4M5lZhSpKbk6JNHueCQmfrat9RwygXYwQ+zBTkMXAUgTQw6PvCFcIInDs8RUQI4aevW zA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 2u9nvpj7ys-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 15 Aug 2019 10:35:39 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x7FAXFfa104652;
        Thu, 15 Aug 2019 10:35:38 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3030.oracle.com with ESMTP id 2ucmwjj2wg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 15 Aug 2019 10:35:38 +0000
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x7FAZVdP032402;
        Thu, 15 Aug 2019 10:35:31 GMT
Received: from abi.no.oracle.com (/141.143.213.43)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 15 Aug 2019 03:35:30 -0700
Message-ID: <9629068a41a160de0145a18dd22924bce70f37fe.camel@oracle.com>
Subject: Re: [RFC 06/19] ktf: A simple debugfs interface to test results
From:   Knut Omang <knut.omang@oracle.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kbuild@vger.kernel.org,
        Shuah Khan <shuah@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Shreyans Devendra Doshi <0xinfosect0r@gmail.com>,
        Alan Maguire <alan.maguire@oracle.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Hidenori Yamaji <hidenori.yamaji@sony.com>,
        Frank Rowand <frowand.list@gmail.com>,
        Timothy Bird <Tim.Bird@sony.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        "Theodore Ts'o" <tytso@mit.edu>, Daniel Vetter <daniel@ffwll.ch>,
        Stephen Boyd <sboyd@kernel.org>
Date:   Thu, 15 Aug 2019 12:35:26 +0200
In-Reply-To: <20190815084921.GE3512@kroah.com>
References: <cover.92d76bb4f6dcedc971d0b72a49e8e459a98bca54.1565676440.git-series.knut.omang@oracle.com>
         <ae6c38384e2338aa3cfb8a4e4dd1002833789253.1565676440.git-series.knut.omang@oracle.com>
         <20190813082152.GA17627@kroah.com>
         <a63bea757e02656a38463cc794da7da15273dd16.camel@oracle.com>
         <20190815084921.GE3512@kroah.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9349 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1908150113
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9349 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1908150113
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, 2019-08-15 at 10:49 +0200, Greg Kroah-Hartman wrote:
> On Wed, Aug 14, 2019 at 07:17:07PM +0200, Knut Omang wrote:
> > I notice the discussion and your response here: 
> > http://linux-kernel.2935.n7.nabble.com/debugfs-and-module-unloading-td865175.html
> > I assume that means that protection against module unload while a debugfs file
> > is open is now safe.
> 
> It should be, if you set the *owner field of your file_operations
> properly.  Try it and see!

Might be a case for a KTF selftest to play with the timing to increase the chance :)
Wasn't able to make it crash with these simple, short files.

I notice I had set the .owner field correctly myself in that driver 
code I referred to, so that's a "copy regression".

> > On older kernels, having this code in place is far better than an unprotected 
> > debugfs entry/exit - I have tested it extensively in the past :-)
> 
> Yes, it seems to work, but again, it really is racy and will fail.
> Please don't use it.
> 
> > I perfectly agree with you that reducing the hole for a race condition 
> > is generally a bad idea, but from the above mail thread 
> > it seems that's the only available choice for older kernels?
> 
> I have no idea, but please, do not use that pattern of code as it is
> racy in all kernels, from all of time.

Ok, will remove it :-)

I tried in vain to find the commit from Al Viro that made the code safe,
to identify which kernels that are safe from this issue,
but he has a **lot** of commits, do you have a clue for what/where to look?

It will be good to have a mention/comment on this for future reference, 
like the earliest kernel version where this is safe.

Maybe we can even get rid of some more of the remaining of these too..
(I notice there's 65 cases of 'if (!try_module_get(THIS_MODULE))'
right now)

Thanks!
Knut

> 
> thanks,
> 
> greg k-h

