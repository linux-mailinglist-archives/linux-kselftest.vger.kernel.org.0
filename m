Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2C6F0100A4F
	for <lists+linux-kselftest@lfdr.de>; Mon, 18 Nov 2019 18:32:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726475AbfKRRcg (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 18 Nov 2019 12:32:36 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:60890 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726435AbfKRRcg (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 18 Nov 2019 12:32:36 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xAIHOlrR167573;
        Mon, 18 Nov 2019 17:31:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : in-reply-to : message-id : references : mime-version :
 content-type; s=corp-2019-08-05;
 bh=fWYXVHNMGwzk76eEZvx0wQOORGxMzV4ZZmWutwdTNzU=;
 b=Q5GHLqOYfoRD2LBmmxZ4kiwYWBh8AWPj0SB2Z3g4mFTDqRw9Flq35LRrJ2/t248iDQQ3
 vFuZ+0waQZOwR+Z3NE5LzA/MCdaVk/S6TF0cyXfeJa9Jyr5XyhE+vVf1zTAgzmfyI3jc
 FTLivj2WUYPiwMrv9u9TV8BrhJwDGUi5wVsEbuSTkvtx4Sl1x/EVZpddEDfaMpMS/6AF
 8qDwYjC66Grn3t32XQvuajrTDL9P6HwBLdpaAomWolKjE3zu7Rf9xXM37PKezu1lLVPj
 r6MhS7VO/vt3nw79XH3sd+Iyk7HPu2/pAa2lGkteW6E6MhK5WuJxJXzHle7btIyWPv4X gw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 2wa92phqga-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 18 Nov 2019 17:31:09 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xAIHOe7T174690;
        Mon, 18 Nov 2019 17:31:08 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3030.oracle.com with ESMTP id 2watjxwr9y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 18 Nov 2019 17:31:08 +0000
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id xAIHV3s9028994;
        Mon, 18 Nov 2019 17:31:03 GMT
Received: from dhcp-10-175-206-139.vpn.oracle.com (/10.175.206.139)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 18 Nov 2019 09:31:03 -0800
Date:   Mon, 18 Nov 2019 17:30:48 +0000 (GMT)
From:   Alan Maguire <alan.maguire@oracle.com>
X-X-Sender: alan@dhcp-10-175-206-139.vpn.oracle.com
To:     Stephen Boyd <sboyd@kernel.org>
cc:     Alan Maguire <alan.maguire@oracle.com>, brendanhiggins@google.com,
        linux-kselftest@vger.kernel.org, skhan@linuxfoundation.org,
        linux-kernel@vger.kernel.org, kunit-dev@googlegroups.com,
        keescook@chromium.org, yzaikin@google.com,
        akpm@linux-foundation.org, yamada.masahiro@socionext.com,
        catalin.marinas@arm.com, joe.lawrence@redhat.com,
        penguin-kernel@i-love.sakura.ne.jp, schowdary@nvidia.com,
        urezki@gmail.com, andriy.shevchenko@linux.intel.com,
        corbet@lwn.net, tytso@mit.edu, adilger.kernel@dilger.ca,
        mcgrof@kernel.org, changbin.du@intel.com,
        linux-ext4@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v4 linux-kselftest-test 2/6] kunit: hide unexported
 try-catch interface in try-catch-impl.h
In-Reply-To: <20191117013606.4541D207DD@mail.kernel.org>
Message-ID: <alpine.LRH.2.20.1911181728530.1562@dhcp-10-175-206-139.vpn.oracle.com>
References: <1573812972-10529-1-git-send-email-alan.maguire@oracle.com> <1573812972-10529-3-git-send-email-alan.maguire@oracle.com> <20191117013606.4541D207DD@mail.kernel.org>
User-Agent: Alpine 2.20 (LRH 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9445 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=3 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-1911180150
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9445 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=3 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-1911180150
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sat, 16 Nov 2019, Stephen Boyd wrote:
> Quoting Alan Maguire (2019-11-15 02:16:08)
> > diff --git a/lib/kunit/try-catch-impl.h b/lib/kunit/try-catch-impl.h
> > new file mode 100644
> > index 0000000..e308d5c
> > --- /dev/null
> > +++ b/lib/kunit/try-catch-impl.h
> > @@ -0,0 +1,28 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +/*
> > + * An API to allow a function, that may fail, to be executed, and recover in a
> 
> This file is not an API. Maybe just say "Internal kunit try catch
> implementation details to be shared with tests".
>

Thanks for the review! Will fix this, along with adding the
"Co-developed-by:" for Knut and will remove the unneeded
#include of linux/kernel.h in v5 mentioned in the patch
1 review. Thanks again!

Alan

> > + * controlled manner.
> > + *
> > + * Copyright (C) 2019, Google LLC.
> > + * Author: Brendan Higgins <brendanhiggins@google.com>
> > + */
> > +
> > +#ifndef _KUNIT_TRY_CATCH_IMPL_H
> > +#define _KUNIT_TRY_CATCH_IMPL_H
> > +
> > +#include <kunit/try-catch.h>
> > +#include <linux/types.h>
> > +
> > +struct kunit;
> > +
> > +static inline void kunit_try_catch_init(struct kunit_try_catch *try_catch,
> > +                                       struct kunit *test,
> > +                                       kunit_try_catch_func_t try,
> 
