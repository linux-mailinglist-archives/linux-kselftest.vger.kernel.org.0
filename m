Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6A174102DE8
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Nov 2019 22:05:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727148AbfKSVFy (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 19 Nov 2019 16:05:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:36076 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726711AbfKSVFy (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 19 Nov 2019 16:05:54 -0500
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2FEBD222DC;
        Tue, 19 Nov 2019 21:05:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574197553;
        bh=DBpI4iM5O9hiEAhz6mGIcdSDeSA9Ihp/Rvjf2ZJbcLI=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=hSiQRdVHF3+EHNwjY/mdNQlbamgaIc5j6OhNJbroNTcJtsnX4A56h3aT7Huk764qO
         tgSL6z8A2ZJuWBEcy7zI6PzcXFDtvFYeCv3Pyqw2qajXLZv47bijKbsVezggXA2BX3
         PMGzrrOHlsxXaUmQEQmV1bBCRK8FgvfomObdDJ5w=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1573812972-10529-4-git-send-email-alan.maguire@oracle.com>
References: <1573812972-10529-1-git-send-email-alan.maguire@oracle.com> <1573812972-10529-4-git-send-email-alan.maguire@oracle.com>
Subject: Re: [PATCH v4 linux-kselftest-test 3/6] kunit: allow kunit tests to be loaded as a module
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-kernel@vger.kernel.org, kunit-dev@googlegroups.com,
        keescook@chromium.org, yzaikin@google.com,
        akpm@linux-foundation.org, yamada.masahiro@socionext.com,
        catalin.marinas@arm.com, joe.lawrence@redhat.com,
        penguin-kernel@i-love.sakura.ne.jp, schowdary@nvidia.com,
        urezki@gmail.com, andriy.shevchenko@linux.intel.com,
        corbet@lwn.net, tytso@mit.edu, adilger.kernel@dilger.ca,
        mcgrof@kernel.org, changbin.du@intel.com,
        linux-ext4@vger.kernel.org, linux-doc@vger.kernel.org,
        Alan Maguire <alan.maguire@oracle.com>,
        Knut Omang <knut.omang@oracle.com>
To:     Alan Maguire <alan.maguire@oracle.com>, brendanhiggins@google.com,
        linux-kselftest@vger.kernel.org, skhan@linuxfoundation.org
User-Agent: alot/0.8.1
Date:   Tue, 19 Nov 2019 13:05:52 -0800
Message-Id: <20191119210553.2FEBD222DC@mail.kernel.org>
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Quoting Alan Maguire (2019-11-15 02:16:09)
> As tests are added to kunit, it will become less feasible to execute
> all built tests together.  By supporting modular tests we provide
> a simple way to do selective execution on a running system; specifying
>=20
> CONFIG_KUNIT=3Dy
> CONFIG_KUNIT_EXAMPLE_TEST=3Dm
>=20
> ...means we can simply "insmod example-test.ko" to run the tests.
>=20
> To achieve this we need to do the following:
>=20
> o export the required symbols in kunit
> o string-stream tests utilize non-exported symbols so for now we skip
>   building them when CONFIG_KUNIT_TEST=3Dm.
> o support a new way of declaring test suites.  Because a module cannot
>   do multiple late_initcall()s, we provide a kunit_test_suites() macro
>   to declare multiple suites within the same module at once.
> o some test module names would have been too general ("test-test"
>   and "example-test" for kunit tests, "inode-test" for ext4 tests);
>   rename these as appropriate ("kunit-test", "kunit-example-test"
>   and "ext4-inode-test" respectively).
>=20
> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
> Signed-off-by: Knut Omang <knut.omang@oracle.com>
> ---
>  fs/ext4/Kconfig                |   2 +-
>  fs/ext4/Makefile               |   5 +
>  fs/ext4/inode-test.c           |   4 +-
>  include/kunit/test.h           |  35 +++--
>  kernel/sysctl-test.c           |   4 +-
>  lib/Kconfig.debug              |   4 +-
>  lib/kunit/Kconfig              |   4 +-
>  lib/kunit/Makefile             |  10 +-
>  lib/kunit/assert.c             |   8 +
>  lib/kunit/example-test.c       |  88 -----------
>  lib/kunit/kunit-example-test.c |  90 +++++++++++
>  lib/kunit/kunit-test.c         | 334 +++++++++++++++++++++++++++++++++++=
++++++
>  lib/kunit/string-stream-test.c |   2 +-
>  lib/kunit/test-test.c          | 333 -----------------------------------=
-----
>  lib/kunit/test.c               |   8 +
>  lib/kunit/try-catch.c          |   2 +
>  lib/list-test.c                |   4 +-

Can you generate your patches with -M or -C? Hopefully that will find
copies and only show us the diff between the two files.

>  17 files changed, 494 insertions(+), 443 deletions(-)
>  delete mode 100644 lib/kunit/example-test.c
>  create mode 100644 lib/kunit/kunit-example-test.c
>  create mode 100644 lib/kunit/kunit-test.c
>  delete mode 100644 lib/kunit/test-test.c
