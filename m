Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 51C8CDD8BE
	for <lists+linux-kselftest@lfdr.de>; Sat, 19 Oct 2019 14:56:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725883AbfJSM4r (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 19 Oct 2019 08:56:47 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:52786 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725812AbfJSM4r (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 19 Oct 2019 08:56:47 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9JCmho8063860;
        Sat, 19 Oct 2019 12:56:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : in-reply-to : message-id : references : mime-version :
 content-type; s=corp-2019-08-05;
 bh=aYLRWpfL1Vz6cb5bmcY4y8jfwnHj32sBl0+aCwtNA40=;
 b=AsUELhBF0y0oGgyt1hNjcpO5YKOcikvCFt6Jj9NNBuYR3AC4w7FlC2wOMZK2XqAP0+T5
 bc0nvlSXOTXHNwyfcakSO4Hy+xz8hHTzEmMh3wDRhVMS1mC7CZIiiMVBTitun77FbDs/
 yeZgOTu6Gi2eFSrZf/OcPjhMLlozbvF9HI9JRl3rm0tHDO8FwA9fJfshl5P2IQalY09m
 HyZc8oJSJTNkJ95I/sZ3tszlPpeh1avoxrPkOGOstLvWu6R9CP2WhXCx0hE5syuDwhoY
 hvEAPB4AppY3IC9WI/VOj8j4yuLuB0BIl6O1R1Q79RsIWxEZ6VQnlv9TpzaBEa6BvGT8 nw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 2vqu4q8xxa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 19 Oct 2019 12:56:21 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9JCnAUt024498;
        Sat, 19 Oct 2019 12:56:21 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3030.oracle.com with ESMTP id 2vqqmhmjb1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 19 Oct 2019 12:56:20 +0000
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x9JCuCtB002409;
        Sat, 19 Oct 2019 12:56:13 GMT
Received: from dhcp-10-175-221-34.vpn.oracle.com (/10.175.221.34)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sat, 19 Oct 2019 12:56:12 +0000
Date:   Sat, 19 Oct 2019 13:56:01 +0100 (BST)
From:   Alan Maguire <alan.maguire@oracle.com>
X-X-Sender: alan@dhcp-10-175-221-34.vpn.oracle.com
To:     Luis Chamberlain <mcgrof@kernel.org>
cc:     Brendan Higgins <brendanhiggins@google.com>,
        Matthias Maennich <maennich@google.com>, shuah@kernel.org,
        john.johansen@canonical.com, jmorris@namei.org, serge@hallyn.com,
        keescook@chromium.org, alan.maguire@oracle.com, yzaikin@google.com,
        davidgow@google.com, tytso@mit.edu, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org,
        Mike Salvatore <mike.salvatore@canonical.com>
Subject: Re: [PATCH linux-kselftest/test v1] apparmor: add AppArmor KUnit
 tests for policy unpack
In-Reply-To: <20191018122949.GD11244@42.do-not-panic.com>
Message-ID: <alpine.LRH.2.20.1910191348280.11804@dhcp-10-175-221-34.vpn.oracle.com>
References: <20191018001816.94460-1-brendanhiggins@google.com> <20191018122949.GD11244@42.do-not-panic.com>
User-Agent: Alpine 2.20 (LRH 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9414 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=887
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1910190118
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9414 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1910190118
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, 18 Oct 2019, Luis Chamberlain wrote:

> On Thu, Oct 17, 2019 at 05:18:16PM -0700, Brendan Higgins wrote:
> > From: Mike Salvatore <mike.salvatore@canonical.com>
> > 
> > In order to write the tests against the policy unpacking code, some
> > static functions needed to be exposed for testing purposes. One of the
> > goals of this patch is to establish a pattern for which testing these
> > kinds of functions should be done in the future.
> 
> And you'd run into the same situation expressed elsewhere with kunit of
> an issue of the kunit test as built-in working but if built as a module
> then it would not work, given the lack of exports. Symbols namespaces
> should resolve this [0], and we'd be careful where a driver imports this
> namespace.
> 
> [0] https://lwn.net/Articles/798254/
>

Thanks for the link! Looks interesting for us definitely!

WRT adding tests, I think what we're aiming at is a set of best practices 
to advise test developers using KUnit, while attempting to minimize 
side-effects of any changes we need to make to support testability.

One aspect of this we probably have to consider is inlining of code. For 
cases like this where the functions are small and are called in a small 
number of cases, any testability changes we make may push a 
previously-inlined function to not be inlined, with potential performance 
side-effects for the subsystem.  In such cases, I wonder if the right 
answer would be to suggest actually defining the functions as 
inline in the header file? That way the compiler still gets to decide (as 
opposed to __always_inline), and we don't perturb performance too much.

Thanks!

Alan

>   Luis
> 
