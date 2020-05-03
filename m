Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62C461C2B27
	for <lists+linux-kselftest@lfdr.de>; Sun,  3 May 2020 12:10:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728086AbgECKKH (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 3 May 2020 06:10:07 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:43786 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728021AbgECKKG (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 3 May 2020 06:10:06 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 043A3XbN179569;
        Sun, 3 May 2020 10:09:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : in-reply-to : message-id : references : mime-version :
 content-type; s=corp-2020-01-29;
 bh=+3cvJANHAAeU4d22dlyULTuCEPl9tYfeqegQxmVM3JU=;
 b=pLQkLJM5wQOlBgB8xdx38a/BkDzOYcAzpnRvUXIMtcd2lScAjnye/aPeADLj5/VRl8dd
 dYRb7o9j+/vdK55hoxKqv/wuAoIFfJ7o+9jzq5jIdmczj6X0WOUsAFUere4xZCxBtejF
 kCJdUKV8+ajwls9ieN9jpKW+Pgodeg7qPWC0YZJjRyEMkqc/Kgj8GmWsqd5h1RJrXnCb
 8HSddZvuBGgJb+MGhvjZXfBxug3fpCLP0FpWL9vboY+LLc7qkMdW9A/a2DBAXVmb0lFX
 PZhmT9EpEaOEyqZ8BgqIKX0lyDThP85UJR/v7nidK53yBbfB4Au5CFcGbMOHld1WjOV7 4Q== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 30s09qu5e0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 03 May 2020 10:09:47 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 043A7XNR129168;
        Sun, 3 May 2020 10:09:47 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3030.oracle.com with ESMTP id 30sjbane2a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 03 May 2020 10:09:47 +0000
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 043A9d6c015487;
        Sun, 3 May 2020 10:09:45 GMT
Received: from dhcp-10-175-179-100.vpn.oracle.com (/10.175.179.100)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sun, 03 May 2020 10:09:38 +0000
Date:   Sun, 3 May 2020 11:09:30 +0100 (BST)
From:   Alan Maguire <alan.maguire@oracle.com>
X-X-Sender: alan@localhost
To:     David Gow <davidgow@google.com>
cc:     trishalfonso@google.com, brendanhiggins@google.com,
        aryabinin@virtuozzo.com, dvyukov@google.com, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, linux-kernel@vger.kernel.org,
        kasan-dev@googlegroups.com, kunit-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v7 0/5] KUnit-KASAN Integration
In-Reply-To: <20200424061342.212535-1-davidgow@google.com>
Message-ID: <alpine.LRH.2.21.2005031101130.20090@localhost>
References: <20200424061342.212535-1-davidgow@google.com>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9609 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 phishscore=0
 malwarescore=0 adultscore=0 spamscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2005030091
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9609 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0
 lowpriorityscore=0 spamscore=0 adultscore=0 clxscore=1011 suspectscore=0
 priorityscore=1501 malwarescore=0 mlxlogscore=999 phishscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2005030090
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, 23 Apr 2020, David Gow wrote:

> This patchset contains everything needed to integrate KASAN and KUnit.
> 
> KUnit will be able to:
> (1) Fail tests when an unexpected KASAN error occurs
> (2) Pass tests when an expected KASAN error occurs
> 
> Convert KASAN tests to KUnit with the exception of copy_user_test
> because KUnit is unable to test those.
> 
> Add documentation on how to run the KASAN tests with KUnit and what to
> expect when running these tests.
> 
> This patchset depends on:
> - "[PATCH v3 kunit-next 0/2] kunit: extend kunit resources API" [1]
> - "[PATCH v3 0/3] Fix some incompatibilites between KASAN and
>   FORTIFY_SOURCE" [2]
> 
> Changes from v6:
>  - Rebased on top of kselftest/kunit
>  - Rebased on top of Daniel Axtens' fix for FORTIFY_SOURCE
>    incompatibilites [2]
>  - Removed a redundant report_enabled() check.
>  - Fixed some places with out of date Kconfig names in the
>    documentation.
>

Sorry for the delay in getting to this; I retested the
series with the above patchsets pre-applied; all looks
good now, thanks!  Looks like Daniel's patchset has a v4
so I'm not sure if that will have implications for applying
your changes on top of it (haven't tested it yet myself).

For the series feel free to add

Tested-by: Alan Maguire <alan.maguire@oracle.com>

I'll try and take some time to review v7 shortly, but I wanted
to confirm the issues I saw went away first in case you're
blocked.  The only remaining issue I see is that we'd need the
named resource patchset to land first; it would be good
to ensure the API it provides is solid so you won't need to
respin.

Thanks!

Alan
 
> Changes from v5:
>  - Split out the panic_on_warn changes to a separate patch.
>  - Fix documentation to fewer to the new Kconfig names.
>  - Fix some changes which were in the wrong patch.
>  - Rebase on top of kselftest/kunit (currently identical to 5.7-rc1)
> 
> Changes from v4:
>  - KASAN no longer will panic on errors if both panic_on_warn and
>    kasan_multishot are enabled.
>  - As a result, the KASAN tests will no-longer disable panic_on_warn.
>  - This also means panic_on_warn no-longer needs to be exported.
>  - The use of temporary "kasan_data" variables has been cleaned up
>    somewhat.
>  - A potential refcount/resource leak should multiple KASAN errors
>    appear during an assertion was fixed.
>  - Some wording changes to the KASAN test Kconfig entries.
> 
> Changes from v3:
>  - KUNIT_SET_KASAN_DATA and KUNIT_DO_EXPECT_KASAN_FAIL have been
>  combined and included in KUNIT_DO_EXPECT_KASAN_FAIL() instead.
>  - Reordered logic in kasan_update_kunit_status() in report.c to be
>  easier to read.
>  - Added comment to not use the name "kasan_data" for any kunit tests
>  outside of KUNIT_EXPECT_KASAN_FAIL().
> 
> Changes since v2:
>  - Due to Alan's changes in [1], KUnit can be built as a module.
>  - The name of the tests that could not be run with KUnit has been
>  changed to be more generic: test_kasan_module.
>  - Documentation on how to run the new KASAN tests and what to expect
>  when running them has been added.
>  - Some variables and functions are now static.
>  - Now save/restore panic_on_warn in a similar way to kasan_multi_shot
>  and renamed the init/exit functions to be more generic to accommodate.
>  - Due to [3] in kasan_strings, kasan_memchr, and
>  kasan_memcmp will fail if CONFIG_AMD_MEM_ENCRYPT is enabled so return
>  early and print message explaining this circumstance.
>  - Changed preprocessor checks to C checks where applicable.
> 
> Changes since v1:
>  - Make use of Alan Maguire's suggestion to use his patch that allows
>    static resources for integration instead of adding a new attribute to
>    the kunit struct
>  - All KUNIT_EXPECT_KASAN_FAIL statements are local to each test
>  - The definition of KUNIT_EXPECT_KASAN_FAIL is local to the
>    test_kasan.c file since it seems this is the only place this will
>    be used.
>  - Integration relies on KUnit being builtin
>  - copy_user_test has been separated into its own file since KUnit
>    is unable to test these. This can be run as a module just as before,
>    using CONFIG_TEST_KASAN_USER
>  - The addition to the current task has been separated into its own
>    patch as this is a significant enough change to be on its own.
> 
> 
> [1] https://lore.kernel.org/linux-kselftest/1585313122-26441-1-git-send-email-alan.maguire@oracle.com/T/#t
> [2] https://lkml.org/lkml/2020/4/23/708
> [3] https://bugzilla.kernel.org/show_bug.cgi?id=206337
> 
> 
> 
> David Gow (1):
>   mm: kasan: Do not panic if both panic_on_warn and kasan_multishot set
> 
> Patricia Alfonso (4):
>   Add KUnit Struct to Current Task
>   KUnit: KASAN Integration
>   KASAN: Port KASAN Tests to KUnit
>   KASAN: Testing Documentation
> 
>  Documentation/dev-tools/kasan.rst |  70 +++
>  include/kunit/test.h              |   5 +
>  include/linux/kasan.h             |   6 +
>  include/linux/sched.h             |   4 +
>  lib/Kconfig.kasan                 |  18 +-
>  lib/Makefile                      |   3 +-
>  lib/kunit/test.c                  |  13 +-
>  lib/test_kasan.c                  | 688 +++++++++++++-----------------
>  lib/test_kasan_module.c           |  76 ++++
>  mm/kasan/report.c                 |  34 +-
>  10 files changed, 514 insertions(+), 403 deletions(-)
>  create mode 100644 lib/test_kasan_module.c
> 
> -- 
> 2.26.2.303.gf8c07b1a785-goog
> 
> 
