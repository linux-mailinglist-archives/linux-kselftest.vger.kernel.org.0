Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 156368BE1B
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 Aug 2019 18:19:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727592AbfHMQTf (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 13 Aug 2019 12:19:35 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:33022 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727211AbfHMQTf (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 13 Aug 2019 12:19:35 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x7DG8mQW196607;
        Tue, 13 Aug 2019 16:19:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : subject
 : from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=corp-2019-08-05;
 bh=HTb/5J0BxVV9yBflGge7ur7d2g2RQgG9Szn5YAC5Qi4=;
 b=YxnsGrUDIMQnzffjadT6wZJ1O7v7EcxMSFdST2astU26n1dhaoXZ+dGbGYWFWGsMpCn4
 iiXWn0sd+JxeRckdCxllKWddBRgCpFVkShEuBQt7czpK6EZCBjX8WLScT1s3VdyBetU+
 NhYwMeKuhZIouo2tua4Kprwfqvk7A09fWLasW8wcCmr8kYtOlsGyyqc3Ct6k2u4mZAQz
 RRcXVUzlyPOkAWQ0apgOv7imzoixgU16YIVkVQfAV2J7elRl0ecQP3/ecbL1Y4urLMVO
 D9qCZKaYKz7qX7LUBXaPd4wwL+TNnQYJTNX1+HKFJn9ncjC8v4lM67zvSTIQ5/1TjZR/ Vw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 2u9nvp7ffp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 13 Aug 2019 16:19:10 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x7DG8PSe111097;
        Tue, 13 Aug 2019 16:19:10 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3030.oracle.com with ESMTP id 2ubwrg68be-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 13 Aug 2019 16:19:10 +0000
Received: from abhmp0002.oracle.com (abhmp0002.oracle.com [141.146.116.8])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x7DGJ7xS032677;
        Tue, 13 Aug 2019 16:19:07 GMT
Received: from asu (/92.220.18.196)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 13 Aug 2019 09:19:06 -0700
Message-ID: <14b99d26a4cff1c813c92818dc1234007fa06fc9.camel@oracle.com>
Subject: Re: [RFC 01/19] kbuild: Fixes to rules for host-cshlib and
 host-cxxshlib
From:   Knut Omang <knut.omang@oracle.com>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Shuah Khan <shuah@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Michal Marek <michal.lkml@markovi.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
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
Date:   Tue, 13 Aug 2019 18:19:01 +0200
In-Reply-To: <CAK7LNASX4jPRxRxD+JafAfKqjck=x27HuHZgPV1VFfW8MzcwZA@mail.gmail.com>
References: <cover.92d76bb4f6dcedc971d0b72a49e8e459a98bca54.1565676440.git-series.knut.omang@oracle.com>
         <be2c361eac49ded2848b2a555b75e30cc3c24e71.1565676440.git-series.knut.omang@oracle.com>
         <CAK7LNASX4jPRxRxD+JafAfKqjck=x27HuHZgPV1VFfW8MzcwZA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9348 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1908130161
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9348 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1908130161
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, 2019-08-13 at 23:01 +0900, Masahiro Yamada wrote:
> On Tue, Aug 13, 2019 at 3:13 PM Knut Omang <knut.omang@oracle.com> wrote:
> >
> > C++ libraries interfacing to C APIs might sometimes need some glue
> > logic more easily written in C.
> > Allow a C++ library to also contain 0 or more C objects.
> >
> > Also fix rules for both C and C++ shared libraries:
> > - C++ shared libraries depended on .c instead of .cc files
> > - Rules were referenced as -objs instead of the intended
> >   -cobjs and -cxxobjs following the pattern from hostprogs*.
> >
> > Signed-off-by: Knut Omang <knut.omang@oracle.com>
> 
> 
> How is this patch related to the rest of this series?

This is just my (likely naive) way I to get what I had working 
using autotools in the Github version of KTF) translated into something 
comparable using kbuild only. We need to build a shared library consisting 
of a few C++ files and a very simple C file, and a couple of simple binaries, 
and the rule in there does seem to take .c files and subject them to the 
C++ compiler, which makes this difficult to achieve?

> This patch breaks GCC-plugins.
> Did you really compile-test this patch before the submission?

Sorry for my ignorance here:
I ran through the kernel build and installed the resulting kernel 
on a VM that I used to test this, if that's what you are asking 
about?

Do I need some unusual .config options or run a special make target 
to trigger the problem you see?

I used a recent Fedora config with default values for new options,
and ran the normal default make target (also with O=) and make selftests 
to test the patch itself.

Thanks,
Knut

> --
> Best Regards
> 
> Masahiro Yamada

