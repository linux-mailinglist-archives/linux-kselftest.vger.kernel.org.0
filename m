Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F23FCD69A3
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Oct 2019 20:43:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730857AbfJNSlJ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 14 Oct 2019 14:41:09 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:37318 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728931AbfJNSlJ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 14 Oct 2019 14:41:09 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9EIcuif104747;
        Mon, 14 Oct 2019 18:41:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : subject
 : from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=corp-2019-08-05;
 bh=fwHUKuWdq5i3WupNwi0IERGmIT76mMVKPnSqLNltDps=;
 b=lpdTKvFFFU+EhRU1o96AaA6OxDzLVEl0Lgbij7vOUL+hIJvdKAJxwiYXri+ZmFtZXPkm
 LJuWN3UQkgPDPp5TagxxgyettKIM8QVkac4qds4MAhQ1/1AAFMsOQYVdeGLitsw5kEcH
 S8VQAuxdmaH1ia7WehQgyyzm22TeY7mYNRwsEk47BtgGBhLTvmZYyZMTomSEyNEmaoRZ
 6H6EhycUURM2uo24AMNC+7HO6CiKOsohvIdVLpR2uVQSFIAN8bJrr0CUBhjBcX7fEfGO
 yEEZNFT0iPDTG3nHYZVVoKwqawFA3aoFBYNHbxEzWk/VuvkBy8WFlFWUVUl6cR/9a7zZ kw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 2vk6sqau7q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 14 Oct 2019 18:41:03 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9EIbvvC095061;
        Mon, 14 Oct 2019 18:39:03 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3020.oracle.com with ESMTP id 2vkrbkcemb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 14 Oct 2019 18:39:02 +0000
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x9EId0FL022897;
        Mon, 14 Oct 2019 18:39:01 GMT
Received: from asu (/92.220.18.196)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 14 Oct 2019 18:39:00 +0000
Message-ID: <9212e0fb58683df4781c52e6ad0abd8eb496a452.camel@oracle.com>
Subject: Re: Plan for hybrid testing
From:   Knut Omang <knut.omang@oracle.com>
To:     Luis Chamberlain <mcgrof@kernel.org>,
        Brendan Higgins <brendanhiggins@google.com>
Cc:     Shuah Khan <shuah@kernel.org>, kunit-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org,
        Alan Maguire <alan.maguire@oracle.com>
Date:   Mon, 14 Oct 2019 20:38:57 +0200
In-Reply-To: <20191014104243.GD16384@42.do-not-panic.com>
References: <20190913210247.GA86838@google.com>
         <20191014104243.GD16384@42.do-not-panic.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9410 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=915
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1910140151
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9410 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1910140151
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, 2019-10-14 at 10:42 +0000, Luis Chamberlain wrote:
> On Fri, Sep 13, 2019 at 02:02:47PM -0700, Brendan Higgins wrote:
> > Hey Knut and Shuah,
> > 
> > Following up on our offline discussion on Wednesday night:
> > 
> > We decided that it would make sense for Knut to try to implement Hybrid
> > Testing (testing that crosses the kernel userspace boundary) that he
> > introduced here[1] on top of the existing KUnit infrastructure.
> > 
> > We discussed several possible things in the kernel that Knut could test
> > with the new Hybrid Testing feature as an initial example. Those were
> > (in reverse order of expected difficulty):
> > 
> > 1. RDS (Reliable Datagram Sockets) - We decided that, although this was
> >    one of the more complicated subsystems to work with, it was probably
> >    the best candidate for Knut to start with because it was in desperate
> >    need of better testing, much of the testing would require crossing
> >    the kernel userspace boundary to be effective, and Knut has access to
> >    RDS (since he works at Oracle).
> > 
> > 2. KMOD - Probably much simpler than RDS, and the maintainer, Luis
> >    Chamberlain (CC'ed) would like to see better testing here, but
> >    probably still not as good as RDS because it is in less dire need of
> >    testing, collaboration on this would be more difficult, and Luis is
> >    currently on an extended vacation. Luis and I had already been
> >    discussing testing KMOD here[2].
> 
> I'm back!
> 
> I'm also happy and thrilled to help review the infrastructure in great
> detail given I have lofty future objectives with testing in the kernel.
> Also, kmod is a bit more complex to test, if Knut wants a simpler *easy*
> target I think test_sysctl.c would be a good target. I think the goal
> there would be to add probes for a few of the sysctl callers, and then
> test them through userspace somehow, for instance?

That sounds like a good case for the hybrid tests.
The challenge in a kunit setting would be that it relies on a significant part of KTF
to work as we have used it so far:

- module support - Alan has been working on this 
- netlink approach from KTF (to allow user space execution of kernel 
  part of test, and gathering reporting in one place)
- probe infrastructure 

> The complexities with testing kmod is the threading aspect. So that is
> more of a challenge for a test infrastructure as a whole. However kmod
> also already has a pretty sound kthread solution which could be used
> as basis for any sound kernel multithread test solution.
> 
> Curious, what was decided with the regards to the generic netlink approach?

I think in some way functionality similar to the netlink support is needed 
for the features in KTF that we discussed, so I get it is a "yes" to add 
support for it?

Knut

>   Luis

