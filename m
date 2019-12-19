Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E85A91264A9
	for <lists+linux-kselftest@lfdr.de>; Thu, 19 Dec 2019 15:28:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726853AbfLSO2v (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 19 Dec 2019 09:28:51 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:54820 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726846AbfLSO2v (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 19 Dec 2019 09:28:51 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xBJEOrPF027558;
        Thu, 19 Dec 2019 14:28:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : in-reply-to : message-id : references : mime-version :
 content-type; s=corp-2019-08-05;
 bh=r7RfnXTuFfkY8vAtoiGIPwJLtZb07TPTTRS00Yuw7GU=;
 b=WOuUCuqOxgq5uMy1B8X37DDbK0cVBzRdtnsQdmWVK/yPyfUOIwx723kE74s+VuCeyFoT
 TklDY6dgFxqgMOP5mX9p4q3iWBm7BspeELYBXC0Q01zq8TzGjadQEWN+y2MVIZlm5OUN
 XR1JstRgX2oKXcmfS9zijwPahATlWSqb0B5pTN+j3BwmwdP0yQQ+Zth3ViqJhSBdRqjE
 BRiofkBHK+gFoJwmF/D6KXp8vIlrPE1vb/35F1KCxrgKpKvVWPwShMln0oq/C7/+uggj
 oLatMa9nASQEcsGlxq3p0Rjc0Y8VpjQriQ+SBbrN8/aNhM6wQ9riqG36wWyuF6kgFFBc gQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 2x01knk5e7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 19 Dec 2019 14:28:21 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xBJEOrcp115690;
        Thu, 19 Dec 2019 14:28:20 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3030.oracle.com with ESMTP id 2wyxqhs15s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 19 Dec 2019 14:28:20 +0000
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id xBJESCh6024551;
        Thu, 19 Dec 2019 14:28:12 GMT
Received: from dhcp-10-175-218-218.vpn.oracle.com (/10.175.218.218)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 19 Dec 2019 06:28:12 -0800
Date:   Thu, 19 Dec 2019 14:28:00 +0000 (GMT)
From:   Alan Maguire <alan.maguire@oracle.com>
X-X-Sender: alan@dhcp-10-175-218-218.vpn.oracle.com
To:     kbuild test robot <lkp@intel.com>
cc:     Alan Maguire <alan.maguire@oracle.com>, kbuild-all@lists.01.org,
        brendanhiggins@google.com, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, kunit-dev@googlegroups.com,
        keescook@chromium.org, yzaikin@google.com,
        akpm@linux-foundation.org, yamada.masahiro@socionext.com,
        catalin.marinas@arm.com, joe.lawrence@redhat.com,
        penguin-kernel@i-love.sakura.ne.jp, urezki@gmail.com,
        andriy.shevchenko@linux.intel.com, corbet@lwn.net,
        davidgow@google.com, adilger.kernel@dilger.ca, tytso@mit.edu,
        mcgrof@kernel.org, linux-doc@vger.kernel.org,
        Knut Omang <knut.omang@oracle.com>
Subject: Re: [PATCH v6 linux-kselftest-test 3/6] kunit: allow kunit tests to
 be loaded as a module
In-Reply-To: <201912190658.JKOfMs2i%lkp@intel.com>
Message-ID: <alpine.LRH.2.20.1912191424440.27984@dhcp-10-175-218-218.vpn.oracle.com>
References: <1575473234-5443-4-git-send-email-alan.maguire@oracle.com> <201912190658.JKOfMs2i%lkp@intel.com>
User-Agent: Alpine 2.20 (LRH 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9475 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-1912190122
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9475 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-1912190122
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, 19 Dec 2019, kbuild test robot wrote:

> Hi Alan,
> 
> Thank you for the patch! Yet something to improve:
> 
> [auto build test ERROR on linus/master]
> [also build test ERROR on linux/master v5.5-rc2 next-20191218]
> [cannot apply to ext4/dev]
> [if your patch is applied to the wrong git tree, please drop us a note to help
> improve the system. BTW, we also suggest to use '--base' option to specify the
> base tree in git format-patch, please see https://stackoverflow.com/a/37406982]
> 
> url:    https://github.com/0day-ci/linux/commits/Alan-Maguire/kunit-support-building-core-tests-as-modules/20191207-021244
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git b0d4beaa5a4b7d31070c41c2e50740304a3f1138
> config: x86_64-randconfig-e002-20191218 (attached as .config)
> compiler: gcc-7 (Debian 7.5.0-1) 7.5.0
> reproduce:
>         # save the attached .config to linux build tree
>         make ARCH=x86_64 
> 
> If you fix the issue, kindly add following tag
> Reported-by: kbuild test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>):
> 
>    drivers/base/power/qos-test.c:117:1: warning: data definition has no type or storage class
>     kunit_test_suite(pm_qos_test_module);
>     ^~~~~~~~~~~~~~~~

I hadn't thought about the possibility that other trees
would have added kunit tests in the interim; it probably
makes most sense to not retire the kunit_test_suite()
definition (it can be trivially defined via kunit_test_suites().
Converting the test suite isn't an option as it's not in
the kselftest-test tree.

I'll spin up a v7 patchset with that 1-line change to patch 3
as I don't _think_ these changes have been pulled in yet.

Apologies for the noise!

Alan
