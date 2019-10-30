Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C2C87E9A41
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Oct 2019 11:42:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726082AbfJ3Kmk (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 30 Oct 2019 06:42:40 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:46204 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726046AbfJ3Kmj (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 30 Oct 2019 06:42:39 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9UAYOTG136921;
        Wed, 30 Oct 2019 10:42:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=815j/YhDXDAGFJ0kuShibnrAaDqoW4eFgfJomjo90O8=;
 b=SidofrJwdWQhlAzf1RZSI9aljJMP0+RalQW6KdLntrTTjr0vU4EIpx4gt0hsV06MbSRf
 pLHAwlfVdAuM33XJAEzJb/sNMUk/hPM2B4po67eYYUQ93EOVI34XB23tJvoVRVLAJ0vI
 zbckmhEOAuoJcgcOMwJkRf4SqlKnZFqoh6ErhqLVqmXj374e+qXPJu6JwYeF+buGbI5T
 POH6Dch1rsb2MCFfd2K4Cfd8I5YsIGyqlxVu4DWBarzpb2IqjZ/mDKcgxNjGW1GZKJBs
 ACZR2XHV0IxqsighpcCSkJxCR8/h2ioi5KiN1/GwBFvOmuVdrnc8hPzBrRHddiNghjc7 2g== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 2vxwhfb3xt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 30 Oct 2019 10:42:30 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9UAcpIo058307;
        Wed, 30 Oct 2019 10:42:29 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3030.oracle.com with ESMTP id 2vxwhvt2qd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 30 Oct 2019 10:42:28 +0000
Received: from abhmp0022.oracle.com (abhmp0022.oracle.com [141.146.116.28])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x9UAgRCO020665;
        Wed, 30 Oct 2019 10:42:27 GMT
Received: from kadam (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 30 Oct 2019 03:42:26 -0700
Date:   Wed, 30 Oct 2019 13:42:17 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     David Gow <davidgow@google.com>
Cc:     shuah <shuah@kernel.org>,
        Brendan Higgins <brendanhiggins@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH linux-kselftest/test v6] lib/list-test: add a test for
 the 'list' doubly linked list
Message-ID: <20191030104217.GA18421@kadam>
References: <20191024224631.118656-1-davidgow@google.com>
 <0cb1d948-0da3-eb0f-c58f-ae3a785dd0dd@kernel.org>
 <CABVgOSmCHbGjZBjeWSbPEZbJw22SaBQnoO77xxNzN_ugAwzNiQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABVgOSmCHbGjZBjeWSbPEZbJw22SaBQnoO77xxNzN_ugAwzNiQ@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9425 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1910300106
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9425 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1910300106
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Oct 30, 2019 at 01:02:11AM -0700, David Gow wrote:
> > ERROR: that open brace { should be on the previous line
> > #869: FILE: lib/list-test.c:680:
> > +static void list_test_list_for_each_entry_reverse(struct kunit *test)
> > +{
> >
> >
> > I am seeing these error and warns. As per our hallway conversation, the
> > "for_each*" in the test naming is tripping up checkpatch.pl
> >
> > For now you can change the name a bit to not trip checkpatch and maybe
> > explore fixing checkpatch to differentiate between function names
> > with "for_each" in them vs. the actual for_each usages in the code.
> 
> Thanks, Shuah.
> 
> Yes, the problem here is that checkpatch.pl believes that anything
> with "for_each" in its name must be a loop, so expects that the open
> brace is placed on the same line as for a for loop.
> 
> Longer term, I think it'd be nicer, naming-wise, to fix or work around
> this issue in checkpatch.pl itself, as that'd allow the tests to
> continue to follow a naming pattern of "list_test_[x]", where [x] is
> the name of the function/macro being tested. Of course, short of
> trying to fit a whole C parser in checkpatch.pl, that's going to
> involve some compromises as well.

Just make it a black list of the 5 most common for_each macros.

> 
> In the meantime, I'm sending out v7 which replaces "for_each" with
> "for__each" (adding the extra underscore), so that checkpatch is
> happy.

It's better to ignore checkpatch and other scripts when they are wrong.
(unless the warning message inspires you to make the code more readable
for humans).

regards,
dan carpenter

