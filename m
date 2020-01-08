Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6EDB5133E33
	for <lists+linux-kselftest@lfdr.de>; Wed,  8 Jan 2020 10:21:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727200AbgAHJVD (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 8 Jan 2020 04:21:03 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:42168 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726913AbgAHJVD (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 8 Jan 2020 04:21:03 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 0089EDZV060798;
        Wed, 8 Jan 2020 09:20:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : in-reply-to : message-id : references : mime-version :
 content-type; s=corp-2019-08-05;
 bh=a65yAYGnmoHEn76tPwG8Kydxo0KhuItVUm5enQXNU5k=;
 b=U+csACo57iPN2oPObXKksaR1PRmZuhuqDPLs4pCMcR/2VisUDp8D92G3iM/j7fkD3JVr
 a8PDtWbN9PrTef7Sw0jWBfEfJFxWkOHoWAo8N3XRQXw69PaoEZJLDg5G77KADZM3I5OY
 vjr93X+wXKwYfd5KBttzHeczX5+Rcn29Cw1JPx+nagprrfni2m/5wTNgUhOrIdoXbfC1
 XgW5pcy4Onhq+BzCUAxk9M+SkuqPMCiWaZulkOBp9mIDIiCIPj5VGy0KY3AOrhAcI5ql
 GPCSXmC4fsGByMLxrGMb5Y2UTgDu+SVaSJC7+AToudJXGpfti7lkBO+mddQC5YywlVT7 RA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 2xakbqtj93-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 08 Jan 2020 09:20:36 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 0089JX3U144172;
        Wed, 8 Jan 2020 09:20:36 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3030.oracle.com with ESMTP id 2xcjvf6tnm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 08 Jan 2020 09:20:35 +0000
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 0089KQ3n008089;
        Wed, 8 Jan 2020 09:20:26 GMT
Received: from dhcp-10-175-161-204.vpn.oracle.com (/10.175.161.204)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 08 Jan 2020 01:20:26 -0800
Date:   Wed, 8 Jan 2020 09:20:16 +0000 (GMT)
From:   Alan Maguire <alan.maguire@oracle.com>
X-X-Sender: alan@dhcp-10-175-161-204.vpn.oracle.com
To:     shuah <shuah@kernel.org>
cc:     Alan Maguire <alan.maguire@oracle.com>, brendanhiggins@google.com,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        kunit-dev@googlegroups.com, keescook@chromium.org,
        yzaikin@google.com, akpm@linux-foundation.org,
        yamada.masahiro@socionext.com, catalin.marinas@arm.com,
        joe.lawrence@redhat.com, penguin-kernel@i-love.sakura.ne.jp,
        urezki@gmail.com, andriy.shevchenko@linux.intel.com,
        corbet@lwn.net, davidgow@google.com, adilger.kernel@dilger.ca,
        tytso@mit.edu, mcgrof@kernel.org, linux-doc@vger.kernel.org,
        Knut Omang <knut.omang@oracle.com>
Subject: Re: [RESEND PATCH v7 linux-kselftest-test 3/6] kunit: allow kunit
 tests to be loaded as a module
In-Reply-To: <6634211a-7ecc-378e-bc78-82c80e24d579@kernel.org>
Message-ID: <alpine.LRH.2.20.2001080913410.19442@dhcp-10-175-161-204.vpn.oracle.com>
References: <1578349703-15650-1-git-send-email-alan.maguire@oracle.com> <1578349703-15650-4-git-send-email-alan.maguire@oracle.com> <6634211a-7ecc-378e-bc78-82c80e24d579@kernel.org>
User-Agent: Alpine 2.20 (LRH 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9493 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=3 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-2001080080
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9493 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=3 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-2001080080
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, 7 Jan 2020, shuah wrote:

> Hi Alan,
> 
> Thanks for the resend.
> 
> On 1/6/20 3:28 PM, Alan Maguire wrote:
> > As tests are added to kunit, it will become less feasible to execute
> > all built tests together.  By supporting modular tests we provide
> > a simple way to do selective execution on a running system; specifying
> > 
> > CONFIG_KUNIT=y
> > CONFIG_KUNIT_EXAMPLE_TEST=m
> > 
> > ...means we can simply "insmod example-test.ko" to run the tests.
> > 
> > To achieve this we need to do the following:
> > 
> > o export the required symbols in kunit
> > o string-stream tests utilize non-exported symbols so for now we skip
> >    building them when CONFIG_KUNIT_TEST=m.
> > o drivers/base/power/qos-test.c contains a few unexported interface
> >    references, namely freq_qos_read_value() and freq_constraints_init().
> >    Both of these could be potentially defined as static inline functions
> >    in include/linux/pm_qos.h, but for now we simply avoid supporting
> >    module build for that test suite.
> > o support a new way of declaring test suites.  Because a module cannot
> >    do multiple late_initcall()s, we provide a kunit_test_suites() macro
> >    to declare multiple suites within the same module at once.
> > o some test module names would have been too general ("test-test"
> >    and "example-test" for kunit tests, "inode-test" for ext4 tests);
> >    rename these as appropriate ("kunit-test", "kunit-example-test"
> >    and "ext4-inode-test" respectively).
> > 
> > Also define kunit_test_suite() via kunit_test_suites()
> > as callers in other trees may need the old definition.
> > 
> > Co-developed-by: Knut Omang <knut.omang@oracle.com>
> > Signed-off-by: Knut Omang <knut.omang@oracle.com>
> > Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
> > Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
> > Acked-by: Theodore Ts'o <tytso@mit.edu> # for ext4 bits
> > Acked-by: David Gow <davidgow@google.com> # For list-test
> > Reported-by: kbuild test robot <lkp@intel.com>
> > ---
> >   drivers/base/power/qos-test.c                      |  2 +-
> >   fs/ext4/Kconfig                                    |  2 +-
> >   fs/ext4/Makefile                                   |  3 +-
> >   fs/ext4/inode-test.c                               |  4 ++-
> >   include/kunit/test.h                               | 37
> >   ++++++++++++++++------
> >   kernel/sysctl-test.c                               |  4 ++-
> >   lib/Kconfig.debug                                  |  4 +--
> >   lib/kunit/Kconfig                                  |  4 +--
> >   lib/kunit/Makefile                                 | 10 ++++--
> >   lib/kunit/assert.c                                 |  8 +++++
> >   lib/kunit/{example-test.c => kunit-example-test.c} |  4 ++-
> >   lib/kunit/{test-test.c => kunit-test.c}            |  5 +--
> >   lib/kunit/string-stream-test.c                     |  2 +-
> >   lib/kunit/test.c                                   |  8 +++++
> >   lib/kunit/try-catch.c                              |  2 ++
> >   lib/list-test.c                                    |  4 ++-
> >   16 files changed, 76 insertions(+), 27 deletions(-)
> >   rename lib/kunit/{example-test.c => kunit-example-test.c} (97%)
> >   rename lib/kunit/{test-test.c => kunit-test.c} (98%)
> > 
> > diff --git a/drivers/base/power/qos-test.c b/drivers/base/power/qos-test.c
> > index 3115db0..79fc6c4 100644
> > --- a/drivers/base/power/qos-test.c
> > +++ b/drivers/base/power/qos-test.c
> > @@ -114,4 +114,4 @@ static void freq_qos_test_readd(struct kunit *test)
> >    .name = "qos-kunit-test",
> >    .test_cases = pm_qos_test_cases,
> >   };
> > -kunit_test_suite(pm_qos_test_module);
> > +kunit_test_suites(&pm_qos_test_module);
> > diff --git a/fs/ext4/Kconfig b/fs/ext4/Kconfig
> > index ef42ab0..435510f 100644
> > --- a/fs/ext4/Kconfig
> > +++ b/fs/ext4/Kconfig
> > @@ -108,7 +108,7 @@ config EXT4_DEBUG
> >     echo 1 > /sys/module/ext4/parameters/mballoc_debug
> >   
> >   config EXT4_KUNIT_TESTS
> > -	bool "KUnit tests for ext4"
> > +	tristate "KUnit tests for ext4"
> >    select EXT4_FS
> >    depends on KUNIT
> >    help
> > diff --git a/fs/ext4/Makefile b/fs/ext4/Makefile
> > index 840b91d..4ccb3c9 100644
> > --- a/fs/ext4/Makefile
> > +++ b/fs/ext4/Makefile
> > @@ -13,5 +13,6 @@ ext4-y	:= balloc.o bitmap.o block_validity.o dir.o
> > ext4_jbd2.o extents.o \
> >   
> >   ext4-$(CONFIG_EXT4_FS_POSIX_ACL)	+= acl.o
> >   ext4-$(CONFIG_EXT4_FS_SECURITY)		+= xattr_security.o
> > -ext4-$(CONFIG_EXT4_KUNIT_TESTS)		+= inode-test.o
> > +ext4-inode-test-objs			+= inode-test.o
> > +obj-$(CONFIG_EXT4_KUNIT_TESTS)		+= ext4-inode-test.o
> >   ext4-$(CONFIG_FS_VERITY)		+= verity.o
> > diff --git a/fs/ext4/inode-test.c b/fs/ext4/inode-test.c
> > index 92a9da1..95620bf 100644
> > --- a/fs/ext4/inode-test.c
> > +++ b/fs/ext4/inode-test.c
> > @@ -269,4 +269,6 @@ static void inode_test_xtimestamp_decoding(struct kunit
> > *test)
> >   	.test_cases = ext4_inode_test_cases,
> >   };
> >   
> > -kunit_test_suite(ext4_inode_test_suite);
> > +kunit_test_suites(&ext4_inode_test_suite);
> > +
> > +MODULE_LICENSE("GPL v2");
> > diff --git a/include/kunit/test.h b/include/kunit/test.h
> > index dba4830..2dfb550 100644
> > --- a/include/kunit/test.h
> > +++ b/include/kunit/test.h
> > @@ -12,6 +12,7 @@
> >   #include <kunit/assert.h>
> >   #include <kunit/try-catch.h>
> >   #include <linux/kernel.h>
> > +#include <linux/module.h>
> >   #include <linux/slab.h>
> >   #include <linux/types.h>
> >   
> > @@ -197,31 +198,47 @@ struct kunit {
> >   int kunit_run_tests(struct kunit_suite *suite);
> >   
> >   /**
> > - * kunit_test_suite() - used to register a &struct kunit_suite with KUnit.
> > + * kunit_test_suites() - used to register one or more &struct kunit_suite
> > + *			 with KUnit.
> >    *
> > - * @suite: a statically allocated &struct kunit_suite.
> > + * @suites: a statically allocated list of &struct kunit_suite.
> >    *
> > - * Registers @suite with the test framework. See &struct kunit_suite for
> > + * Registers @suites with the test framework. See &struct kunit_suite for
> >    * more information.
> >    *
> > - * NOTE: Currently KUnit tests are all run as late_initcalls; this means
> > + * When builtin,  KUnit tests are all run as late_initcalls; this means
> >    * that they cannot test anything where tests must run at a different init
> >    * phase. One significant restriction resulting from this is that KUnit
> >    * cannot reliably test anything that is initialize in the late_init
> >    phase;
> >    * another is that KUnit is useless to test things that need to be run in
> >    * an earlier init phase.
> >    *
> > + * An alternative is to build the tests as a module.  Because modules
> > + * do not support multiple late_initcall()s, we need to initialize an
> > + * array of suites for a module.
> > + *
> >    * TODO(brendanhiggins@google.com): Don't run all KUnit tests as
> >    * late_initcalls.  I have some future work planned to dispatch all KUnit
> >    * tests from the same place, and at the very least to do so after
> >    * everything else is definitely initialized.
> >    */
> > -#define kunit_test_suite(suite)
> > \
> > -	static int kunit_suite_init##suite(void)
> > \
> > -	{
> > \
> > -		return kunit_run_tests(&suite);
> > \
> > -	}
> > \
> > -	late_initcall(kunit_suite_init##suite)
> > +#define kunit_test_suites(...)
> > \
> > +	static struct kunit_suite *suites[] = { __VA_ARGS__, NULL};	\
> > +	static int kunit_test_suites_init(void)				\
> > +	{								\
> > +		unsigned int i;						\
> > +		for (i = 0; suites[i] != NULL; i++)			\
> > +			kunit_run_tests(suites[i]);			\
> > +		return 0;						\
> > +	}								\
> > +	late_initcall(kunit_test_suites_init);				\
> > +	static void __exit kunit_test_suites_exit(void)			\
> > +	{								\
> > +		return;							\
> > +	}								\
> > +	module_exit(kunit_test_suites_exit)
> > +
> > +#define kunit_test_suite(suite)	kunit_test_suites(&suite)
> 
> This macro is getting more and more complex. Is there a good reason
> for this code to stay as a macro?
>

I'm not sure if there's a better way, but by keeping it as a macro
we get to define init/exit functions in context that will be used when the 
code is built as a module, and not otherwise.  The body of 
kunit_test_suites_init()/kunit_test_suites_exit() will likely evolve, and 
when they do we could  take the oppportunity to simplify those functions 
to just call kunit functions to do the init/cleanup. 

Thanks!

Alan

> thanks,
> -- Shuah
> 
