Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1BCE313078
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Feb 2021 12:16:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231431AbhBHLPy (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 8 Feb 2021 06:15:54 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:50558 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232525AbhBHLNe (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 8 Feb 2021 06:13:34 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 118BAbgI025685;
        Mon, 8 Feb 2021 11:12:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=nvwahBSZXplQiMBwEr0U7duRvv9FAMET36RKzGB3kl8=;
 b=hiaVjMO43NnXDNgfE+kyJm9RWLNV++FYHnCUmZLJg9rYnpTJrCvPK2+7LutsxjtDKSOU
 DHlOGLkO4CBHCIn1Wp5ea3LvlpGpdf/Ce36+DA/LWiaG0tU63RybVuDxVTyF2EyYOeDo
 a3s0R6HzrdC/ujajhW07E96vewvfWmfqXC/5JA22S+r7O11duMK+hErV1haQLrtAG7e3
 HRHa4yiWiGH/oKbvGtRMCguo1TUk32toTJ7AUeDtC1uGn+q7n8T9sPYeM2b3J7kqiF6e
 /mp5e15AtQPEp7sGbuuF3v/KXglMLz70I8PePiLZjDSCUduwL5yX7v4U7tvi5iU6g86a iA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 36hjhqkhqy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 08 Feb 2021 11:12:35 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 118BBJc1131794;
        Mon, 8 Feb 2021 11:12:34 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3020.oracle.com with ESMTP id 36j50ymusx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 08 Feb 2021 11:12:34 +0000
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 118BCWRl014609;
        Mon, 8 Feb 2021 11:12:32 GMT
Received: from kadam (/102.36.221.92)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 08 Feb 2021 03:12:31 -0800
Date:   Mon, 8 Feb 2021 14:12:23 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Daniel Latypov <dlatypov@google.com>
Cc:     kbuild@lists.01.org, Brendan Higgins <brendanhiggins@google.com>,
        David Gow <davidgow@google.com>, lkp@intel.com,
        kbuild-all@lists.01.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
Subject: Re: [PATCH 1/3] kunit: add kunit.filter_glob cmdline option to
 filter suites
Message-ID: <20210208111223.GK20820@kadam>
References: <20210203234116.839819-2-dlatypov@google.com>
 <20210204071100.GB2696@kadam>
 <CAGS_qxpOWG_chZEAtKFPPbcfet=ZQYeo9_3k5tHSj4WHCfMToA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGS_qxpOWG_chZEAtKFPPbcfet=ZQYeo9_3k5tHSj4WHCfMToA@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-IMR: 1
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9888 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0 adultscore=0
 mlxlogscore=999 phishscore=0 spamscore=0 suspectscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102080075
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9888 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 impostorscore=0
 priorityscore=1501 bulkscore=0 suspectscore=0 mlxscore=0 phishscore=0
 lowpriorityscore=0 mlxlogscore=999 clxscore=1015 spamscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102080075
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Feb 04, 2021 at 09:30:43AM -0800, Daniel Latypov wrote:
> On Wed, Feb 3, 2021 at 11:13 PM Dan Carpenter <dan.carpenter@oracle.com> wrote:
> >
> > Hi Daniel,
> >
> > url:    https://github.com/0day-ci/linux/commits/Daniel-Latypov/kunit-support-running-subsets-of-test-suites-from/20210204-074405 
> > base:   88bb507a74ea7d75fa49edd421eaa710a7d80598
> > config: x86_64-randconfig-m001-20210202 (attached as .config)
> > compiler: gcc-9 (Debian 9.3.0-15) 9.3.0
> >
> > If you fix the issue, kindly add following tag as appropriate
> > Reported-by: kernel test robot <lkp@intel.com>
> > Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> >
> > smatch warnings:
> > lib/kunit/executor.c:110 kunit_run_all_tests() error: double free of 'suite_set.start'
> >
> > vim +110 lib/kunit/executor.c
> >
> > 8c0d884986ba22 Brendan Higgins 2020-08-04   96  int kunit_run_all_tests(void)
> > aac35468ca20a3 Alan Maguire    2020-08-04   97  {
> > aac35468ca20a3 Alan Maguire    2020-08-04   98          struct kunit_suite * const * const *suites;
> > aac35468ca20a3 Alan Maguire    2020-08-04   99
> > d5554dd78a454b Daniel Latypov  2021-02-03  100          struct suite_set suite_set = kunit_filter_suites();
> > 45dcbb6f5ef78b Brendan Higgins 2020-08-04  101
> > d5554dd78a454b Daniel Latypov  2021-02-03  102          kunit_print_tap_header(&suite_set);
> > d5554dd78a454b Daniel Latypov  2021-02-03  103
> > d5554dd78a454b Daniel Latypov  2021-02-03  104          for (suites = suite_set.start; suites < suite_set.end; suites++)
> > aac35468ca20a3 Alan Maguire    2020-08-04  105                  __kunit_test_suites_init(*suites);
> > aac35468ca20a3 Alan Maguire    2020-08-04  106
> > d5554dd78a454b Daniel Latypov  2021-02-03  107          if (filter_glob) { /* a copy was made of each array */
> > d5554dd78a454b Daniel Latypov  2021-02-03  108                  for (suites = suite_set.start; suites < suite_set.end; suites++)
> >                                                                      ^^^^^^^^^^^^^^^^^^^^^^^^
> > This will free "suite_set.start" will in the first iteration through the
> > loop
> 
> Ah, the loop is supposed to contain `kfree(*suites)`.
> I'll fix the patch and resend.
> 
> I'm not familiar with conventions but it feels like adding Reported-by
> on the amended patch would almost imply the report suggested the need
> for the ability to filter suites.
> So I'll add an informal attribution in the cover letter.
> 
> Thanks!

These emails are autogenerated by the kbuild bot and I just look them
over and hit forward.

regards,
dan carpenter

