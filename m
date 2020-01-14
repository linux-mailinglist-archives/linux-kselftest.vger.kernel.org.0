Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A653B13AFB1
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Jan 2020 17:43:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728650AbgANQnM (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 14 Jan 2020 11:43:12 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:53862 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726379AbgANQnM (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 14 Jan 2020 11:43:12 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00EGXpUX071233;
        Tue, 14 Jan 2020 16:42:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : in-reply-to : message-id : references : mime-version :
 content-type; s=corp-2019-08-05;
 bh=CWF7k3UenyIwPtt3gZw5fAYDOXkVTUWe1i/V4e3zLSs=;
 b=QjPV36EzmmNo9gJpnhtE/8AYeSzi5dPWM3VNc5lWBk2piN5luEUOQkkJcJBo237LQ3Gz
 PgEyyNchTD5KP2roPD9+a98fYaNWP6QvNq+cBLhFW2pE/KQvetcaUBRf/jtQEg/3/Hay
 r6Dn5YOoTzv9LSUgg5h5iI7coGZrHxz4kp9YxGx44RdIKz7wX/5UmetlmJxrtwpPf2A1
 w8CZqQ5zztShH7io7O5yHrGi/crJC1tCIR+1t0sBppKdxxwcOwQpyur5rysOJ0rmEMlE
 VBteG1Ff6vdFJT+VQUK0PMghyMLJ//BldVVtpNtSt5Z3dBPEecrbPbH7jBFYvxhWJmaK DQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 2xf73yf6cc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 Jan 2020 16:42:51 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00EGXjSk086814;
        Tue, 14 Jan 2020 16:42:51 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3030.oracle.com with ESMTP id 2xh2scv2cq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 Jan 2020 16:42:49 +0000
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 00EGgmov027856;
        Tue, 14 Jan 2020 16:42:48 GMT
Received: from dhcp-10-175-171-251.vpn.oracle.com (/10.175.171.251)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 14 Jan 2020 08:42:48 -0800
Date:   Tue, 14 Jan 2020 16:42:37 +0000 (GMT)
From:   Alan Maguire <alan.maguire@oracle.com>
X-X-Sender: alan@dhcp-10-175-171-251.vpn.oracle.com
To:     Randy Dunlap <rdunlap@infradead.org>
cc:     Alan Maguire <alan.maguire@oracle.com>, brendanhiggins@google.com,
        gregkh@linuxfoundation.org, rjw@rjwysocki.net,
        dmitry.torokhov@gmail.com, sfr@canb.auug.org.au,
        linux-kernel@vger.kernel.org, linux-next@vger.kernel.org,
        linux-kselftest@vger.kernel.org, skhan@linuxfoundation.org
Subject: Re: [PATCH] software node: introduce CONFIG_KUNIT_DRIVER_PE_TEST
In-Reply-To: <2242e184-93a5-147d-d603-4017ca86eba9@infradead.org>
Message-ID: <alpine.LRH.2.20.2001141639240.15464@dhcp-10-175-171-251.vpn.oracle.com>
References: <1579018183-14879-1-git-send-email-alan.maguire@oracle.com> <2242e184-93a5-147d-d603-4017ca86eba9@infradead.org>
User-Agent: Alpine 2.20 (LRH 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9499 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=3 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-2001140138
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9499 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=3 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-2001140138
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, 14 Jan 2020, Randy Dunlap wrote:

> Hi Alan,
> 
> On 1/14/20 8:09 AM, Alan Maguire wrote:
> > currently the property entry kunit tests are built if CONFIG_KUNIT=y.
> > This will cause warnings when merged with the kunit tree that now
> > supports tristate CONFIG_KUNIT.  While the tests appear to compile
> > as a module, we get a warning about missing module license.
> > 
> > It's better to have a per-test suite CONFIG variable so that
> > we can do selective building of kunit-based suites, and can
> > also avoid merge issues like this.
> > 
> > Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> 
> Reported-by: Randy Dunlap <rdunlap@infradead.org>
>

Apologies for missing you out here.
 
> > Fixes: c032ace71c29 ("software node: add basic tests for property entries")
> > Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
> > ---
> >  drivers/base/test/Kconfig  | 3 +++
> >  drivers/base/test/Makefile | 2 +-
> >  2 files changed, 4 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/base/test/Kconfig b/drivers/base/test/Kconfig
> > index 86e85da..d29ae95 100644
> > --- a/drivers/base/test/Kconfig
> > +++ b/drivers/base/test/Kconfig
> > @@ -8,3 +8,6 @@ config TEST_ASYNC_DRIVER_PROBE
> >  	  The module name will be test_async_driver_probe.ko
> >  
> >  	  If unsure say N.
> > +config KUNIT_DRIVER_PE_TEST
> > +	bool "KUnit Tests for property entry API"
> > +	depends on KUNIT
> 
> Why is this bool instead of tristate?
>

The support for building kunit and kunit tests as modules has not merged 
into linux-next yet, so if we set the option to tristate the build would
fail for allmodconfig builds.   Once it's merged we can revisit though; I 
should have mentioned this, thanks for reminding me!

Alan
 
> > diff --git a/drivers/base/test/Makefile b/drivers/base/test/Makefile
> > index 2214310..3ca5636 100644
> > --- a/drivers/base/test/Makefile
> > +++ b/drivers/base/test/Makefile
> > @@ -1,4 +1,4 @@
> >  # SPDX-License-Identifier: GPL-2.0
> >  obj-$(CONFIG_TEST_ASYNC_DRIVER_PROBE)	+= test_async_driver_probe.o
> >  
> > -obj-$(CONFIG_KUNIT) += property-entry-test.o
> > +obj-$(CONFIG_KUNIT_DRIVER_PE_TEST) += property-entry-test.o
> > 
> 
> thanks.
> -- 
> ~Randy
> 
> 
