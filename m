Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E0653A2802
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Jun 2021 11:14:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229993AbhFJJQI (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 10 Jun 2021 05:16:08 -0400
Received: from mga18.intel.com ([134.134.136.126]:54770 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230201AbhFJJQH (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 10 Jun 2021 05:16:07 -0400
IronPort-SDR: Ayf+1JNF8Lva0pZXNgcoX/dFJYxc1b9m11XptDAjMpRdppyKP1pyknaxpu5GG3oYBdBfrb7ty+
 xgvx53N8D0iA==
X-IronPort-AV: E=McAfee;i="6200,9189,10010"; a="192577962"
X-IronPort-AV: E=Sophos;i="5.83,263,1616482800"; 
   d="scan'208";a="192577962"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2021 02:14:05 -0700
IronPort-SDR: p5N3I7jmtnH/kcXT1MOWh1aqoleSR/qsHi/7TQBhDm0AQjy48YaIOzGpWAztUj5A1WpfYpEgpb
 LprCGKIcsX0Q==
X-IronPort-AV: E=Sophos;i="5.83,263,1616482800"; 
   d="scan'208";a="402797595"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2021 02:14:01 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1lrGlC-0015yn-Cy; Thu, 10 Jun 2021 12:13:58 +0300
Date:   Thu, 10 Jun 2021 12:13:58 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     =?iso-8859-1?Q?Andr=E9?= Almeida <andrealmeid@collabora.com>
Cc:     Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org,
        Brendan Higgins <brendanhiggins@google.com>,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        Shuah Khan <shuah@kernel.org>, ~lkcamp/patches@lists.sr.ht,
        nfraprado@collabora.com, leandro.ribeiro@collabora.com,
        Vitor Massaru Iha <vitor@massaru.org>, lucmaga@gmail.com,
        David Gow <davidgow@google.com>,
        Daniel Latypov <dlatypov@google.com>, tales.aparecida@gmail.com
Subject: Re: [PATCH v2 0/1] lib: Convert UUID runtime test to KUnit
Message-ID: <YMHX1mKuqoRCiHAF@smile.fi.intel.com>
References: <20210609233730.164082-1-andrealmeid@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210609233730.164082-1-andrealmeid@collabora.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Jun 09, 2021 at 08:37:29PM -0300, André Almeida wrote:
> Hi,
> 
> This patch converts existing UUID runtime test to use KUnit framework.
> 
> Below, there's a comparison between the old output format and the new
> one. Keep in mind that even if KUnit seems very verbose, this is the
> corner case where _every_ test has failed.
> 
> * This is how the current output looks like in success:
> 
>   test_uuid: all 18 tests passed
> 
> * And when it fails:
> 
>   test_uuid: conversion test #1 failed on LE data: 'c33f4995-3701-450e-9fbf-206a2e98e576'
>   test_uuid: cmp test #2 failed on LE data: 'c33f4995-3701-450e-9fbf-206a2e98e576'
>   test_uuid: cmp test #2 actual data: 'c33f4995-3701-450e-9fbf-206a2e98e576'
>   test_uuid: conversion test #3 failed on BE data: 'c33f4995-3701-450e-9fbf-206a2e98e576'
>   test_uuid: cmp test #4 failed on BE data: 'c33f4995-3701-450e-9fbf-206a2e98e576'
>   test_uuid: cmp test #4 actual data: 'c33f4995-3701-450e-9fbf-206a2e98e576'
>   test_uuid: conversion test #5 failed on LE data: '64b4371c-77c1-48f9-8221-29f054fc023b'
>   test_uuid: cmp test #6 failed on LE data: '64b4371c-77c1-48f9-8221-29f054fc023b'
>   test_uuid: cmp test #6 actual data: '64b4371c-77c1-48f9-8221-29f054fc023b'
>   test_uuid: conversion test #7 failed on BE data: '64b4371c-77c1-48f9-8221-29f054fc023b'
>   test_uuid: cmp test #8 failed on BE data: '64b4371c-77c1-48f9-8221-29f054fc023b'
>   test_uuid: cmp test #8 actual data: '64b4371c-77c1-48f9-8221-29f054fc023b'
>   test_uuid: conversion test #9 failed on LE data: '0cb4ddff-a545-4401-9d06-688af53e7f84'
>   test_uuid: cmp test #10 failed on LE data: '0cb4ddff-a545-4401-9d06-688af53e7f84'
>   test_uuid: cmp test #10 actual data: '0cb4ddff-a545-4401-9d06-688af53e7f84'
>   test_uuid: conversion test #11 failed on BE data: '0cb4ddff-a545-4401-9d06-688af53e7f84'
>   test_uuid: cmp test #12 failed on BE data: '0cb4ddff-a545-4401-9d06-688af53e7f84'
>   test_uuid: cmp test #12 actual data: '0cb4ddff-a545-4401-9d06-688af53e7f84'
>   test_uuid: negative test #13 passed on wrong LE data: 'c33f4995-3701-450e-9fbf206a2e98e576 '
>   test_uuid: negative test #14 passed on wrong BE data: 'c33f4995-3701-450e-9fbf206a2e98e576 '
>   test_uuid: negative test #15 passed on wrong LE data: '64b4371c-77c1-48f9-8221-29f054XX023b'
>   test_uuid: negative test #16 passed on wrong BE data: '64b4371c-77c1-48f9-8221-29f054XX023b'
>   test_uuid: negative test #17 passed on wrong LE data: '0cb4ddff-a545-4401-9d06-688af53e'
>   test_uuid: negative test #18 passed on wrong BE data: '0cb4ddff-a545-4401-9d06-688af53e'
>   test_uuid: failed 18 out of 18 tests
> 
> 
> * Now, here's how it looks like with KUnit:
> 
>   ======== [PASSED] uuid ========
>   [PASSED] uuid_correct_be
>   [PASSED] uuid_correct_le
>   [PASSED] uuid_wrong_be
>   [PASSED] uuid_wrong_le
> 
> * And if every test fail with KUnit:
> 
>   ======== [FAILED] uuid ========
>   [FAILED] uuid_correct_be
>       # uuid_correct_be: ASSERTION FAILED at lib/test_uuid.c:57
>       Expected uuid_parse(data->uuid, &be) == 1, but
>           uuid_parse(data->uuid, &be) == 0
>   
>   failed to parse 'c33f4995-3701-450e-9fbf-206a2e98e576'
>       # uuid_correct_be: not ok 1 - c33f4995-3701-450e-9fbf-206a2e98e576
>       # uuid_correct_be: ASSERTION FAILED at lib/test_uuid.c:57
>       Expected uuid_parse(data->uuid, &be) == 1, but
>           uuid_parse(data->uuid, &be) == 0
>   
>   failed to parse '64b4371c-77c1-48f9-8221-29f054fc023b'
>       # uuid_correct_be: not ok 2 - 64b4371c-77c1-48f9-8221-29f054fc023b
>       # uuid_correct_be: ASSERTION FAILED at lib/test_uuid.c:57
>       Expected uuid_parse(data->uuid, &be) == 1, but
>           uuid_parse(data->uuid, &be) == 0
>   
>   failed to parse '0cb4ddff-a545-4401-9d06-688af53e7f84'
>       # uuid_correct_be: not ok 3 - 0cb4ddff-a545-4401-9d06-688af53e7f84
>       not ok 1 - uuid_correct_be
>   
>   [FAILED] uuid_correct_le
>       # uuid_correct_le: ASSERTION FAILED at lib/test_uuid.c:46
>       Expected guid_parse(data->uuid, &le) == 1, but
>           guid_parse(data->uuid, &le) == 0
>   
>   failed to parse 'c33f4995-3701-450e-9fbf-206a2e98e576'
>       # uuid_correct_le: not ok 1 - c33f4995-3701-450e-9fbf-206a2e98e576
>       # uuid_correct_le: ASSERTION FAILED at lib/test_uuid.c:46
>       Expected guid_parse(data->uuid, &le) == 1, but
>           guid_parse(data->uuid, &le) == 0
>   
>   failed to parse '64b4371c-77c1-48f9-8221-29f054fc023b'
>       # uuid_correct_le: not ok 2 - 64b4371c-77c1-48f9-8221-29f054fc023b
>       # uuid_correct_le: ASSERTION FAILED at lib/test_uuid.c:46
>       Expected guid_parse(data->uuid, &le) == 1, but
>           guid_parse(data->uuid, &le) == 0
>   
>   failed to parse '0cb4ddff-a545-4401-9d06-688af53e7f84'
>       # uuid_correct_le: not ok 3 - 0cb4ddff-a545-4401-9d06-688af53e7f84
>       not ok 2 - uuid_correct_le
>   
>   [FAILED] uuid_wrong_be
>       # uuid_wrong_be: ASSERTION FAILED at lib/test_uuid.c:77
>       Expected uuid_parse(*data, &be) == 0, but
>           uuid_parse(*data, &be) == -22
>   
>   parsing of 'c33f4995-3701-450e-9fbf206a2e98e576 ' should've failed
>       # uuid_wrong_be: not ok 1 - c33f4995-3701-450e-9fbf206a2e98e576
>       # uuid_wrong_be: ASSERTION FAILED at lib/test_uuid.c:77
>       Expected uuid_parse(*data, &be) == 0, but
>           uuid_parse(*data, &be) == -22
>   
>   parsing of '64b4371c-77c1-48f9-8221-29f054XX023b' should've failed
>       # uuid_wrong_be: not ok 2 - 64b4371c-77c1-48f9-8221-29f054XX023b
>       # uuid_wrong_be: ASSERTION FAILED at lib/test_uuid.c:77
>       Expected uuid_parse(*data, &be) == 0, but
>           uuid_parse(*data, &be) == -22
>   
>   parsing of '0cb4ddff-a545-4401-9d06-688af53e' should've failed
>       # uuid_wrong_be: not ok 3 - 0cb4ddff-a545-4401-9d06-688af53e
>       not ok 3 - uuid_wrong_be
>   
>   [FAILED] uuid_wrong_le
>       # uuid_wrong_le: ASSERTION FAILED at lib/test_uuid.c:68
>       Expected guid_parse(*data, &le) == 0, but
>           guid_parse(*data, &le) == -22
>   
>   parsing of 'c33f4995-3701-450e-9fbf206a2e98e576 ' should've failed
>       # uuid_wrong_le: not ok 1 - c33f4995-3701-450e-9fbf206a2e98e576
>       # uuid_wrong_le: ASSERTION FAILED at lib/test_uuid.c:68
>       Expected guid_parse(*data, &le) == 0, but
>           guid_parse(*data, &le) == -22
>   
>   parsing of '64b4371c-77c1-48f9-8221-29f054XX023b' should've failed
>       # uuid_wrong_le: not ok 2 - 64b4371c-77c1-48f9-8221-29f054XX023b
>       # uuid_wrong_le: ASSERTION FAILED at lib/test_uuid.c:68
>       Expected guid_parse(*data, &le) == 0, but
>           guid_parse(*data, &le) == -22
>   
>   parsing of '0cb4ddff-a545-4401-9d06-688af53e' should've failed
>       # uuid_wrong_le: not ok 3 - 0cb4ddff-a545-4401-9d06-688af53e
>       not ok 4 - uuid_wrong_le

Thanks!

It's not your fault but I think we need to defer this until KUnit gains support
of the run statistics. My guts telling me if we allow more and more conversions
like this the point will vanish and nobody will care.

I like the code, but I can give my tag after KUnit prints some kind of this:

 * This is how the current output looks like in success:

   test_uuid: all 18 tests passed

 * And when it fails:

   test_uuid: failed 18 out of 18 tests

> Changes from v1:
>  - Test suite name: uuid_test -> uuid
>  - Config name: TEST_UUID -> UUID_KUNIT_TEST
>  - Config entry in the Kconfig file left where it is
>  - Converted tests to use _MSG variant
> 
> André Almeida (1):
>   lib: Convert UUID runtime test to KUnit
> 
>  lib/Kconfig.debug |  11 +++-
>  lib/Makefile      |   2 +-
>  lib/test_uuid.c   | 137 +++++++++++++++++++---------------------------
>  3 files changed, 67 insertions(+), 83 deletions(-)
> 
> -- 
> 2.31.1
> 

-- 
With Best Regards,
Andy Shevchenko


