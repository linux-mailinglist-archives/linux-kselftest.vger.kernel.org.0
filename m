Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9CB64AE3BA
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Sep 2019 08:30:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393422AbfIJGax (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 10 Sep 2019 02:30:53 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:56048 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726141AbfIJGax (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 10 Sep 2019 02:30:53 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x8A6TqNN083577;
        Tue, 10 Sep 2019 06:30:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : subject
 : from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=corp-2019-08-05;
 bh=nQaZxzczW4tza5Wbr0dtefaVBrArShMkDFsHCXd1Ri0=;
 b=sI2KEAGmaI5CRFosxf9kr1D+v3p3z4HZ+dLc+3NvFBFOy5zS8G7WgrOnQ4Cm5AGz0C0y
 kGmJ4Ala6OQfyyu6dCOgIHHUpGFJYcDDFOhcF5z4VCkIW0pzK/8AvIWDlf9/Yov0ZGPD
 CFCIossYWktU6JXJTAKOrrSB4m1TDUIJqI/0wMJFYy1SZfVtshqgKdJ4XAsxTtmkHgJj
 EXKs3/8Y8Z00NT0YsfTjH9xv/I2ahefqx1Xa7fuxQJJlLjxBQkxwTk9efbkk0OzNEKMA
 HOD+2e/uawWloaFvQ9VbxJIKxiXvZ68G4EdFWMsTfB+k/vgasN0vIumFqXSqRv/R7mos 0w== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 2uw1jy0y04-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 10 Sep 2019 06:30:35 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x8A6ThdK190282;
        Tue, 10 Sep 2019 06:30:35 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3020.oracle.com with ESMTP id 2uwqktb0c1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 10 Sep 2019 06:30:35 +0000
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x8A6UUDb013981;
        Tue, 10 Sep 2019 06:30:30 GMT
Received: from ovo (/148.69.85.38)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 09 Sep 2019 23:30:29 -0700
Message-ID: <644ff48481f3dd7295798dcef88b4abcc8695260.camel@oracle.com>
Subject: Re: [RFC 03/19] ktf: Introduce a generic netlink protocol for test
 result communication
From:   Knut Omang <knut.omang@oracle.com>
To:     Brendan Higgins <brendanhiggins@google.com>
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kbuild@vger.kernel.org,
        Shuah Khan <shuah@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Shreyans Devendra Doshi <0xinfosect0r@gmail.com>,
        Alan Maguire <alan.maguire@oracle.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Hidenori Yamaji <hidenori.yamaji@sony.com>,
        Frank Rowand <frowand.list@gmail.com>,
        Timothy Bird <Tim.Bird@sony.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        "Theodore Ts'o" <tytso@mit.edu>, Daniel Vetter <daniel@ffwll.ch>,
        Stephen Boyd <sboyd@kernel.org>
Date:   Tue, 10 Sep 2019 08:30:25 +0200
In-Reply-To: <20190909012837.GA33048@google.com>
References: <cover.92d76bb4f6dcedc971d0b72a49e8e459a98bca54.1565676440.git-series.knut.omang@oracle.com>
         <a29b3d27234a7ad3f5d6f7571d08167077dc0350.1565676440.git-series.knut.omang@oracle.com>
         <20190909012837.GA33048@google.com>
Organization: Oracle Inc
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9375 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1909100063
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9375 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1909100063
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sun, 2019-09-08 at 18:28 -0700, Brendan Higgins wrote:
> On Tue, Aug 13, 2019 at 08:09:18AM +0200, Knut Omang wrote:
> > The generic netlink protocol used to communicate between
> > kernel and user space about tests and test results, as well as some
> > means for configuring tests within the kernel.
> > 
> > Unlike other kernel side test code in the kernel, ktf does not print
> > anything from inside the kernel (except for optional debugging
> > features to help "internal" debugging of ktf or ktf tests).
> > Instead all test results are communicated back to the user space
> > frontend, which decides how to do the reporting.
> 
> So why netlink? Why not just a file interface?

Netlink allows more flexibility in that it is bidirectional and asynchronous.
User space may query the kernel for available tests and then decide which tests
to invoke. User land test frameworks like Googletest allows use of wildcards and
exceptions to select particular tests to run. This is in my opinion very
important functionality as we want the tests to be valuable as developer tools,
not just to check the code as part of a later QA cycle. 
Being able to run a single test or a small subset of the tests is very useful.

Wrt test reporting, the kernel side just dispatches off messages about test
results as they are gathered. Compare this to the complexities, side effects and
limitations of printk.

Besides, for hybrid tests, bidirectional communication allows a test to contain
a mix (or a function) of results gathered in the kernel and in user space.

We also use it for network tests, where user space needs to tell the kernel 
what peer(s) to communicate with, and for certain minimal configuration, such as
which device instance to use for device testing. Test nodes may vary in what
they offer of hardware. Although we'd like to minimize the need for
configuration, as results should be easily reproducable, sometimes there is no
good way around.

Thanks,
Knut

> [...]
> 
> Cheers

