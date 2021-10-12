Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C176842A2FD
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Oct 2021 13:18:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232791AbhJLLUL (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 12 Oct 2021 07:20:11 -0400
Received: from verein.lst.de ([213.95.11.211]:40992 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232665AbhJLLUK (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 12 Oct 2021 07:20:10 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 5B16267373; Tue, 12 Oct 2021 13:18:06 +0200 (CEST)
Date:   Tue, 12 Oct 2021 13:18:06 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     =?iso-8859-1?Q?Andr=E9?= Almeida <andrealmeid@collabora.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org,
        Brendan Higgins <brendanhiggins@google.com>,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        Shuah Khan <shuah@kernel.org>, ~lkcamp/patches@lists.sr.ht,
        nfraprado@collabora.com, leandro.ribeiro@collabora.com,
        lucmaga@gmail.com, David Gow <davidgow@google.com>,
        Daniel Latypov <dlatypov@google.com>
Subject: Re: [PATCH v6 0/1] lib: Convert UUID runtime test to KUnit
Message-ID: <20211012111806.GA2537@lst.de>
References: <20211006001345.73898-1-andrealmeid@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211006001345.73898-1-andrealmeid@collabora.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

It seems I only received the 0/1 but never the actual patch?

On Tue, Oct 05, 2021 at 09:13:44PM -0300, André Almeida wrote:
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
> 
> Changes from v5:
>  - Add reviewed-by Brendan
>  - Rebased on top of 5.15-rc4
> 
> Changes from v4:
>  - Add reviewed-by
> v4: https://lore.kernel.org/lkml/20210621133148.9226-1-andrealmeid@collabora.com/
> 
> Changes from v3:
>  - Drop unnecessary casts and braces.
>  - Simplify Kconfig entry
> v3: https://lore.kernel.org/lkml/20210610163959.71634-1-andrealmeid@collabora.com/
> 
> Changes from v2:
>  - Clarify in commit message the new test cases setup
> v2: https://lore.kernel.org/lkml/20210609233730.164082-1-andrealmeid@collabora.com/
> 
> Changes from v1:
>  - Test suite name: uuid_test -> uuid
>  - Config name: TEST_UUID -> UUID_KUNIT_TEST
>  - Config entry in the Kconfig file left where it is
>  - Converted tests to use _MSG variant
> v1: https://lore.kernel.org/lkml/20210605215215.171165-1-andrealmeid@collabora.com/
> 
> André Almeida (1):
>   lib: Convert UUID runtime test to KUnit
> 
>  lib/Kconfig.debug |   8 ++-
>  lib/Makefile      |   2 +-
>  lib/test_uuid.c   | 137 +++++++++++++++++++---------------------------
>  3 files changed, 64 insertions(+), 83 deletions(-)
> 
> -- 
> 2.33.0
---end quoted text---
