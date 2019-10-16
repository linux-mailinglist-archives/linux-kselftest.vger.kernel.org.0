Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AA915D8EA3
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Oct 2019 12:52:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729748AbfJPKwX (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 16 Oct 2019 06:52:23 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:33270 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726083AbfJPKwX (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 16 Oct 2019 06:52:23 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9GAnChp106191;
        Wed, 16 Oct 2019 10:52:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : subject
 : from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=corp-2019-08-05;
 bh=whFL7P/x79lVaXmcCFGQmM1bEmdxGl+4tQ/StglrKDI=;
 b=j8FiPAb+uj1qFOtBLeGi6/PvYqWJ9Yn6inVHCqSjtOchN9VID4q5P624Ytzx3Q0rZKPW
 fIxx3mCYlsrWINkE4oz8Hj2f22TqRE5RZHyIPLTYgHPMGoV5lIZmbaO9ucnpg//Sj0rN
 vsV+HtNZ3srmrRL+aegW909It68ArNbXmyEtKuIzA06m8qoTDF4mfOYypfd2XhztFMXL
 QARmMKFIZzfC4vxiJf+IcVL/BcDduw7bGWponhuejcgRRJV6MAbEET79oAnExGUlyGuo
 MrrtrI0dLmxRerEpuoTMdISW4tVNEPWTQz+fnCejWLcs3X5jmD7BgIV/OQhfNFSZhJZ8 vg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 2vk7frdufw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 16 Oct 2019 10:52:17 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9GAhsmn077090;
        Wed, 16 Oct 2019 10:52:17 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3030.oracle.com with ESMTP id 2vnf7t5b94-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 16 Oct 2019 10:52:17 +0000
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x9GAqFYn004706;
        Wed, 16 Oct 2019 10:52:15 GMT
Received: from asu (/92.220.18.196)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 16 Oct 2019 10:52:15 +0000
Message-ID: <40941b19855134b5032379ab4b8023a3299bd06a.camel@oracle.com>
Subject: Re: Plan for hybrid testing
From:   Knut Omang <knut.omang@oracle.com>
To:     shuah <shuah@kernel.org>, Luis Chamberlain <mcgrof@kernel.org>,
        Brendan Higgins <brendanhiggins@google.com>
Cc:     kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        Alan Maguire <alan.maguire@oracle.com>
Date:   Wed, 16 Oct 2019 12:52:12 +0200
In-Reply-To: <869165ea-f7d6-10cf-c74a-14a33b584938@kernel.org>
References: <20190913210247.GA86838@google.com>
         <20191014104243.GD16384@42.do-not-panic.com>
         <9212e0fb58683df4781c52e6ad0abd8eb496a452.camel@oracle.com>
         <869165ea-f7d6-10cf-c74a-14a33b584938@kernel.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9411 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1910160097
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9411 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1910160098
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, 2019-10-14 at 13:01 -0600, shuah wrote:
> On 10/14/19 12:38 PM, Knut Omang wrote:
> > On Mon, 2019-10-14 at 10:42 +0000, Luis Chamberlain wrote:
> > > On Fri, Sep 13, 2019 at 02:02:47PM -0700, Brendan Higgins wrote:
> > > > Hey Knut and Shuah,
> > > > 
> > > > Following up on our offline discussion on Wednesday night:
> > > > 
> > > > We decided that it would make sense for Knut to try to implement Hybrid
> > > > Testing (testing that crosses the kernel userspace boundary) that he
> > > > introduced here[1] on top of the existing KUnit infrastructure.
> > > > 
> > > > We discussed several possible things in the kernel that Knut could test
> > > > with the new Hybrid Testing feature as an initial example. Those were
> > > > (in reverse order of expected difficulty):
> > > > 
> > > > 1. RDS (Reliable Datagram Sockets) - We decided that, although this was
> > > >     one of the more complicated subsystems to work with, it was probably
> > > >     the best candidate for Knut to start with because it was in desperate
> > > >     need of better testing, much of the testing would require crossing
> > > >     the kernel userspace boundary to be effective, and Knut has access to
> > > >     RDS (since he works at Oracle).
> > > > 
> 
> Any update on if you are able to explore this work.

I am working on this, but it's going to take some time, as this ties in 
with internal projects at Oracle. Basing work on RDS or RDS related tests
(such as generic socket etc) is the best option for us, since that allows 
progress on our internal deliverables as well ;-)

> > > > 2. KMOD - Probably much simpler than RDS, and the maintainer, Luis
> > > >     Chamberlain (CC'ed) would like to see better testing here, but
> > > >     probably still not as good as RDS because it is in less dire need of
> > > >     testing, collaboration on this would be more difficult, and Luis is
> > > >     currently on an extended vacation. Luis and I had already been
> > > >     discussing testing KMOD here[2].
> > > 
> > > I'm back!
> > > 
> > > I'm also happy and thrilled to help review the infrastructure in great
> > > detail given I have lofty future objectives with testing in the kernel.
> > > Also, kmod is a bit more complex to test, if Knut wants a simpler *easy*
> > > target I think test_sysctl.c would be a good target. I think the goal
> > > there would be to add probes for a few of the sysctl callers, and then
> > > test them through userspace somehow, for instance?
> > 
> > That sounds like a good case for the hybrid tests.
> > The challenge in a kunit setting would be that it relies on a significant part of KTF
> > to work as we have used it so far:
> > 
> > - module support - Alan has been working on this
> 
> I see the patches. Thanks for working on this.
> 
> > - netlink approach from KTF (to allow user space execution of kernel
> >    part of test, and gathering reporting in one place)
> > - probe infrastructure
> > 
> > > The complexities with testing kmod is the threading aspect. So that is
> > > more of a challenge for a test infrastructure as a whole. However kmod
> > > also already has a pretty sound kthread solution which could be used
> > > as basis for any sound kernel multithread test solution.
> > > 
> > > Curious, what was decided with the regards to the generic netlink approach?
> 
> Can this work be be done without netlink approach? At least some of it.
> I would like to see some patches and would like to get a better feel
> for the dependency on generic netlink.

A flexible out-of-band communication channel is needed for several of the 
features, and definitely for hybrid tests. It does not need to be netlink 
in principle, but that has served the purpose well so far in KTF, and
reimplementing something will be at the cost of the core task of getting more 
and better tests, which after all is the goal of this effort.

It would be really good if more people had a closer look at the KTF patch 
set before we embark on significant work of porting it to Kunit.

For reference, the netlink code in KTF:
https://lkml.org/lkml/2019/8/13/92

Note that unlike kunit, in KTF no tests are executed by default, 
instead KTF provides an API to query about, set up and trigger execution of 
tests and test parts in the kernel, and leave the actual initiation 
to user space tools.

Thanks!
Knut

> > I think in some way functionality similar to the netlink support is needed
> > for the features in KTF that we discussed, so I get it is a "yes" to add
> > support for it?
> > 
> 
> See above.
> 
> thanks,
> -- Shuah
> 



