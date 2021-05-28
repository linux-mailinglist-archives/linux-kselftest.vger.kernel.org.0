Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CC5C394080
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 May 2021 11:59:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235292AbhE1KB3 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 28 May 2021 06:01:29 -0400
Received: from mga05.intel.com ([192.55.52.43]:50367 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234926AbhE1KB3 (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 28 May 2021 06:01:29 -0400
IronPort-SDR: T0bRRp4wg1V2FPDwg946Stt0fRu0QUGx/sL12P4djw0uF7vRHvBRhNSyP7LAFWrULbY5rxjZUp
 7u70TSHsAJ9Q==
X-IronPort-AV: E=McAfee;i="6200,9189,9997"; a="288523799"
X-IronPort-AV: E=Sophos;i="5.83,229,1616482800"; 
   d="gz'50?scan'50,208,50";a="288523799"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2021 02:59:54 -0700
IronPort-SDR: p6mmTAnxCdN5D1XCx/m1uM2lHUfquvvFpK39LRNS2v73a+fvmNaPiFG7NTRfqaLT48bsPNZ3LW
 Y2UygmABQvYw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,229,1616482800"; 
   d="gz'50?scan'50,208,50";a="436888407"
Received: from lkp-server02.sh.intel.com (HELO 1ec8406c5392) ([10.239.97.151])
  by orsmga007.jf.intel.com with ESMTP; 28 May 2021 02:59:50 -0700
Received: from kbuild by 1ec8406c5392 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lmZHR-0003Hv-Kw; Fri, 28 May 2021 09:59:49 +0000
Date:   Fri, 28 May 2021 17:59:27 +0800
From:   kernel test robot <lkp@intel.com>
To:     David Gow <davidgow@google.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        Alan Maguire <alan.maguire@oracle.com>
Cc:     kbuild-all@lists.01.org, David Gow <davidgow@google.com>,
        Daniel Latypov <dlatypov@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Marco Elver <elver@google.com>, kunit-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/4] kunit: Support skipped tests
Message-ID: <202105281752.5y5mdcLp-lkp@intel.com>
References: <20210528075932.347154-1-davidgow@google.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="3MwIy2ne0vdjdPXF"
Content-Disposition: inline
In-Reply-To: <20210528075932.347154-1-davidgow@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


--3MwIy2ne0vdjdPXF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi David,

I love your patch! Yet something to improve:

[auto build test ERROR on linus/master]
[also build test ERROR on v5.13-rc3 next-20210527]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/David-Gow/kunit-Support-skipped-tests/20210528-160224
base:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 97e5bf604b7a0d6e1b3e00fe31d5fd4b9bffeaae
config: x86_64-rhel-8.3 (attached as .config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce (this is a W=1 build):
        # https://github.com/0day-ci/linux/commit/a464519206cd4484f64540020093cb45ef8e272e
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review David-Gow/kunit-Support-skipped-tests/20210528-160224
        git checkout a464519206cd4484f64540020093cb45ef8e272e
        # save the attached .config to linux build tree
        make W=1 ARCH=x86_64 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from include/linux/kernel.h:15,
                    from include/kunit/assert.h:13,
                    from include/kunit/test.h:12,
                    from lib/kunit/kunit-test.c:8:
   lib/kunit/kunit-test.c: In function 'kunit_status_mark_skipped_test':
   include/linux/minmax.h:20:28: warning: comparison of distinct pointer types lacks a cast
      20 |  (!!(sizeof((typeof(x) *)1 == (typeof(y) *)1)))
         |                            ^~
   include/kunit/test.h:834:9: note: in expansion of macro '__typecheck'
     834 |  ((void)__typecheck(__left, __right));           \
         |         ^~~~~~~~~~~
   include/kunit/test.h:858:2: note: in expansion of macro 'KUNIT_BASE_BINARY_ASSERTION'
     858 |  KUNIT_BASE_BINARY_ASSERTION(test,           \
         |  ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/kunit/test.h:947:2: note: in expansion of macro 'KUNIT_BASE_EQ_MSG_ASSERTION'
     947 |  KUNIT_BASE_EQ_MSG_ASSERTION(test,           \
         |  ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/kunit/test.h:957:2: note: in expansion of macro 'KUNIT_BINARY_EQ_MSG_ASSERTION'
     957 |  KUNIT_BINARY_EQ_MSG_ASSERTION(test,           \
         |  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/kunit/test.h:1320:2: note: in expansion of macro 'KUNIT_BINARY_EQ_ASSERTION'
    1320 |  KUNIT_BINARY_EQ_ASSERTION(test, KUNIT_EXPECTATION, left, right)
         |  ^~~~~~~~~~~~~~~~~~~~~~~~~
   lib/kunit/kunit-test.c:458:2: note: in expansion of macro 'KUNIT_EXPECT_EQ'
     458 |  KUNIT_EXPECT_EQ(test, fake.status, KUNIT_SUCCESS);
         |  ^~~~~~~~~~~~~~~
   In file included from lib/kunit/kunit-test.c:8:
>> include/kunit/test.h:1188:24: error: invalid initializer
    1188 |  typeof(left) __left = (left);            \
         |                        ^
   include/kunit/test.h:1211:2: note: in expansion of macro 'KUNIT_BINARY_STR_ASSERTION'
    1211 |  KUNIT_BINARY_STR_ASSERTION(test,           \
         |  ^~~~~~~~~~~~~~~~~~~~~~~~~~
   include/kunit/test.h:1218:2: note: in expansion of macro 'KUNIT_BINARY_STR_EQ_MSG_ASSERTION'
    1218 |  KUNIT_BINARY_STR_EQ_MSG_ASSERTION(test,           \
         |  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/kunit/test.h:1502:2: note: in expansion of macro 'KUNIT_BINARY_STR_EQ_ASSERTION'
    1502 |  KUNIT_BINARY_STR_EQ_ASSERTION(test, KUNIT_EXPECTATION, left, right)
         |  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   lib/kunit/kunit-test.c:459:2: note: in expansion of macro 'KUNIT_EXPECT_STREQ'
     459 |  KUNIT_EXPECT_STREQ(test, fake.status_comment, "");
         |  ^~~~~~~~~~~~~~~~~~
>> include/kunit/test.h:1188:24: error: invalid initializer
    1188 |  typeof(left) __left = (left);            \
         |                        ^
   include/kunit/test.h:1211:2: note: in expansion of macro 'KUNIT_BINARY_STR_ASSERTION'
    1211 |  KUNIT_BINARY_STR_ASSERTION(test,           \
         |  ^~~~~~~~~~~~~~~~~~~~~~~~~~
   include/kunit/test.h:1218:2: note: in expansion of macro 'KUNIT_BINARY_STR_EQ_MSG_ASSERTION'
    1218 |  KUNIT_BINARY_STR_EQ_MSG_ASSERTION(test,           \
         |  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/kunit/test.h:1502:2: note: in expansion of macro 'KUNIT_BINARY_STR_EQ_ASSERTION'
    1502 |  KUNIT_BINARY_STR_EQ_ASSERTION(test, KUNIT_EXPECTATION, left, right)
         |  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   lib/kunit/kunit-test.c:466:2: note: in expansion of macro 'KUNIT_EXPECT_STREQ'
     466 |  KUNIT_EXPECT_STREQ(test, fake.status_comment, "Accepts format string: YES");
         |  ^~~~~~~~~~~~~~~~~~


vim +1188 include/kunit/test.h

73cda7bb8bfb1d Brendan Higgins 2019-09-23   849  
73cda7bb8bfb1d Brendan Higgins 2019-09-23   850  #define KUNIT_BASE_EQ_MSG_ASSERTION(test,				       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23   851  				    assert_class,			       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23   852  				    ASSERT_CLASS_INIT,			       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23   853  				    assert_type,			       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23   854  				    left,				       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23   855  				    right,				       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23   856  				    fmt,				       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23   857  				    ...)				       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23   858  	KUNIT_BASE_BINARY_ASSERTION(test,				       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23   859  				    assert_class,			       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23   860  				    ASSERT_CLASS_INIT,			       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23   861  				    assert_type,			       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23   862  				    left, ==, right,			       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23   863  				    fmt,				       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23   864  				    ##__VA_ARGS__)
73cda7bb8bfb1d Brendan Higgins 2019-09-23   865  
73cda7bb8bfb1d Brendan Higgins 2019-09-23   866  #define KUNIT_BASE_NE_MSG_ASSERTION(test,				       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23   867  				    assert_class,			       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23   868  				    ASSERT_CLASS_INIT,			       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23   869  				    assert_type,			       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23   870  				    left,				       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23   871  				    right,				       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23   872  				    fmt,				       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23   873  				    ...)				       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23   874  	KUNIT_BASE_BINARY_ASSERTION(test,				       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23   875  				    assert_class,			       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23   876  				    ASSERT_CLASS_INIT,			       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23   877  				    assert_type,			       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23   878  				    left, !=, right,			       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23   879  				    fmt,				       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23   880  				    ##__VA_ARGS__)
73cda7bb8bfb1d Brendan Higgins 2019-09-23   881  
73cda7bb8bfb1d Brendan Higgins 2019-09-23   882  #define KUNIT_BASE_LT_MSG_ASSERTION(test,				       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23   883  				    assert_class,			       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23   884  				    ASSERT_CLASS_INIT,			       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23   885  				    assert_type,			       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23   886  				    left,				       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23   887  				    right,				       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23   888  				    fmt,				       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23   889  				    ...)				       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23   890  	KUNIT_BASE_BINARY_ASSERTION(test,				       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23   891  				    assert_class,			       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23   892  				    ASSERT_CLASS_INIT,			       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23   893  				    assert_type,			       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23   894  				    left, <, right,			       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23   895  				    fmt,				       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23   896  				    ##__VA_ARGS__)
73cda7bb8bfb1d Brendan Higgins 2019-09-23   897  
73cda7bb8bfb1d Brendan Higgins 2019-09-23   898  #define KUNIT_BASE_LE_MSG_ASSERTION(test,				       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23   899  				    assert_class,			       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23   900  				    ASSERT_CLASS_INIT,			       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23   901  				    assert_type,			       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23   902  				    left,				       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23   903  				    right,				       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23   904  				    fmt,				       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23   905  				    ...)				       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23   906  	KUNIT_BASE_BINARY_ASSERTION(test,				       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23   907  				    assert_class,			       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23   908  				    ASSERT_CLASS_INIT,			       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23   909  				    assert_type,			       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23   910  				    left, <=, right,			       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23   911  				    fmt,				       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23   912  				    ##__VA_ARGS__)
73cda7bb8bfb1d Brendan Higgins 2019-09-23   913  
73cda7bb8bfb1d Brendan Higgins 2019-09-23   914  #define KUNIT_BASE_GT_MSG_ASSERTION(test,				       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23   915  				    assert_class,			       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23   916  				    ASSERT_CLASS_INIT,			       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23   917  				    assert_type,			       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23   918  				    left,				       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23   919  				    right,				       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23   920  				    fmt,				       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23   921  				    ...)				       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23   922  	KUNIT_BASE_BINARY_ASSERTION(test,				       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23   923  				    assert_class,			       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23   924  				    ASSERT_CLASS_INIT,			       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23   925  				    assert_type,			       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23   926  				    left, >, right,			       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23   927  				    fmt,				       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23   928  				    ##__VA_ARGS__)
73cda7bb8bfb1d Brendan Higgins 2019-09-23   929  
73cda7bb8bfb1d Brendan Higgins 2019-09-23   930  #define KUNIT_BASE_GE_MSG_ASSERTION(test,				       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23   931  				    assert_class,			       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23   932  				    ASSERT_CLASS_INIT,			       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23   933  				    assert_type,			       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23   934  				    left,				       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23   935  				    right,				       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23   936  				    fmt,				       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23   937  				    ...)				       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23   938  	KUNIT_BASE_BINARY_ASSERTION(test,				       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23   939  				    assert_class,			       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23   940  				    ASSERT_CLASS_INIT,			       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23   941  				    assert_type,			       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23   942  				    left, >=, right,			       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23   943  				    fmt,				       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23   944  				    ##__VA_ARGS__)
73cda7bb8bfb1d Brendan Higgins 2019-09-23   945  
73cda7bb8bfb1d Brendan Higgins 2019-09-23   946  #define KUNIT_BINARY_EQ_MSG_ASSERTION(test, assert_type, left, right, fmt, ...)\
73cda7bb8bfb1d Brendan Higgins 2019-09-23   947  	KUNIT_BASE_EQ_MSG_ASSERTION(test,				       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23   948  				    kunit_binary_assert,		       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23   949  				    KUNIT_INIT_BINARY_ASSERT_STRUCT,	       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23   950  				    assert_type,			       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23   951  				    left,				       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23   952  				    right,				       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23   953  				    fmt,				       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23   954  				    ##__VA_ARGS__)
73cda7bb8bfb1d Brendan Higgins 2019-09-23   955  
73cda7bb8bfb1d Brendan Higgins 2019-09-23   956  #define KUNIT_BINARY_EQ_ASSERTION(test, assert_type, left, right)	       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23   957  	KUNIT_BINARY_EQ_MSG_ASSERTION(test,				       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23   958  				      assert_type,			       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23   959  				      left,				       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23   960  				      right,				       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23   961  				      NULL)
73cda7bb8bfb1d Brendan Higgins 2019-09-23   962  
73cda7bb8bfb1d Brendan Higgins 2019-09-23   963  #define KUNIT_BINARY_PTR_EQ_MSG_ASSERTION(test,				       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23   964  					  assert_type,			       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23   965  					  left,				       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23   966  					  right,			       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23   967  					  fmt,				       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23   968  					  ...)				       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23   969  	KUNIT_BASE_EQ_MSG_ASSERTION(test,				       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23   970  				    kunit_binary_ptr_assert,		       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23   971  				    KUNIT_INIT_BINARY_PTR_ASSERT_STRUCT,       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23   972  				    assert_type,			       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23   973  				    left,				       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23   974  				    right,				       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23   975  				    fmt,				       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23   976  				    ##__VA_ARGS__)
73cda7bb8bfb1d Brendan Higgins 2019-09-23   977  
73cda7bb8bfb1d Brendan Higgins 2019-09-23   978  #define KUNIT_BINARY_PTR_EQ_ASSERTION(test, assert_type, left, right)	       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23   979  	KUNIT_BINARY_PTR_EQ_MSG_ASSERTION(test,				       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23   980  					  assert_type,			       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23   981  					  left,				       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23   982  					  right,			       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23   983  					  NULL)
73cda7bb8bfb1d Brendan Higgins 2019-09-23   984  
73cda7bb8bfb1d Brendan Higgins 2019-09-23   985  #define KUNIT_BINARY_NE_MSG_ASSERTION(test, assert_type, left, right, fmt, ...)\
73cda7bb8bfb1d Brendan Higgins 2019-09-23   986  	KUNIT_BASE_NE_MSG_ASSERTION(test,				       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23   987  				    kunit_binary_assert,		       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23   988  				    KUNIT_INIT_BINARY_ASSERT_STRUCT,	       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23   989  				    assert_type,			       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23   990  				    left,				       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23   991  				    right,				       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23   992  				    fmt,				       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23   993  				    ##__VA_ARGS__)
73cda7bb8bfb1d Brendan Higgins 2019-09-23   994  
73cda7bb8bfb1d Brendan Higgins 2019-09-23   995  #define KUNIT_BINARY_NE_ASSERTION(test, assert_type, left, right)	       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23   996  	KUNIT_BINARY_NE_MSG_ASSERTION(test,				       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23   997  				      assert_type,			       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23   998  				      left,				       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23   999  				      right,				       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23  1000  				      NULL)
73cda7bb8bfb1d Brendan Higgins 2019-09-23  1001  
73cda7bb8bfb1d Brendan Higgins 2019-09-23  1002  #define KUNIT_BINARY_PTR_NE_MSG_ASSERTION(test,				       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23  1003  					  assert_type,			       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23  1004  					  left,				       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23  1005  					  right,			       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23  1006  					  fmt,				       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23  1007  					  ...)				       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23  1008  	KUNIT_BASE_NE_MSG_ASSERTION(test,				       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23  1009  				    kunit_binary_ptr_assert,		       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23  1010  				    KUNIT_INIT_BINARY_PTR_ASSERT_STRUCT,       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23  1011  				    assert_type,			       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23  1012  				    left,				       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23  1013  				    right,				       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23  1014  				    fmt,				       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23  1015  				    ##__VA_ARGS__)
73cda7bb8bfb1d Brendan Higgins 2019-09-23  1016  
73cda7bb8bfb1d Brendan Higgins 2019-09-23  1017  #define KUNIT_BINARY_PTR_NE_ASSERTION(test, assert_type, left, right)	       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23  1018  	KUNIT_BINARY_PTR_NE_MSG_ASSERTION(test,				       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23  1019  					  assert_type,			       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23  1020  					  left,				       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23  1021  					  right,			       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23  1022  					  NULL)
73cda7bb8bfb1d Brendan Higgins 2019-09-23  1023  
73cda7bb8bfb1d Brendan Higgins 2019-09-23  1024  #define KUNIT_BINARY_LT_MSG_ASSERTION(test, assert_type, left, right, fmt, ...)\
73cda7bb8bfb1d Brendan Higgins 2019-09-23  1025  	KUNIT_BASE_LT_MSG_ASSERTION(test,				       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23  1026  				    kunit_binary_assert,		       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23  1027  				    KUNIT_INIT_BINARY_ASSERT_STRUCT,	       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23  1028  				    assert_type,			       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23  1029  				    left,				       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23  1030  				    right,				       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23  1031  				    fmt,				       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23  1032  				    ##__VA_ARGS__)
73cda7bb8bfb1d Brendan Higgins 2019-09-23  1033  
73cda7bb8bfb1d Brendan Higgins 2019-09-23  1034  #define KUNIT_BINARY_LT_ASSERTION(test, assert_type, left, right)	       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23  1035  	KUNIT_BINARY_LT_MSG_ASSERTION(test,				       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23  1036  				      assert_type,			       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23  1037  				      left,				       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23  1038  				      right,				       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23  1039  				      NULL)
73cda7bb8bfb1d Brendan Higgins 2019-09-23  1040  
73cda7bb8bfb1d Brendan Higgins 2019-09-23  1041  #define KUNIT_BINARY_PTR_LT_MSG_ASSERTION(test,				       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23  1042  					  assert_type,			       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23  1043  					  left,				       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23  1044  					  right,			       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23  1045  					  fmt,				       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23  1046  					  ...)				       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23  1047  	KUNIT_BASE_LT_MSG_ASSERTION(test,				       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23  1048  				    kunit_binary_ptr_assert,		       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23  1049  				    KUNIT_INIT_BINARY_PTR_ASSERT_STRUCT,       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23  1050  				    assert_type,			       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23  1051  				    left,				       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23  1052  				    right,				       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23  1053  				    fmt,				       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23  1054  				    ##__VA_ARGS__)
73cda7bb8bfb1d Brendan Higgins 2019-09-23  1055  
73cda7bb8bfb1d Brendan Higgins 2019-09-23  1056  #define KUNIT_BINARY_PTR_LT_ASSERTION(test, assert_type, left, right)	       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23  1057  	KUNIT_BINARY_PTR_LT_MSG_ASSERTION(test,				       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23  1058  					  assert_type,			       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23  1059  					  left,				       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23  1060  					  right,			       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23  1061  					  NULL)
73cda7bb8bfb1d Brendan Higgins 2019-09-23  1062  
73cda7bb8bfb1d Brendan Higgins 2019-09-23  1063  #define KUNIT_BINARY_LE_MSG_ASSERTION(test, assert_type, left, right, fmt, ...)\
73cda7bb8bfb1d Brendan Higgins 2019-09-23  1064  	KUNIT_BASE_LE_MSG_ASSERTION(test,				       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23  1065  				    kunit_binary_assert,		       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23  1066  				    KUNIT_INIT_BINARY_ASSERT_STRUCT,	       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23  1067  				    assert_type,			       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23  1068  				    left,				       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23  1069  				    right,				       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23  1070  				    fmt,				       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23  1071  				    ##__VA_ARGS__)
73cda7bb8bfb1d Brendan Higgins 2019-09-23  1072  
73cda7bb8bfb1d Brendan Higgins 2019-09-23  1073  #define KUNIT_BINARY_LE_ASSERTION(test, assert_type, left, right)	       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23  1074  	KUNIT_BINARY_LE_MSG_ASSERTION(test,				       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23  1075  				      assert_type,			       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23  1076  				      left,				       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23  1077  				      right,				       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23  1078  				      NULL)
73cda7bb8bfb1d Brendan Higgins 2019-09-23  1079  
73cda7bb8bfb1d Brendan Higgins 2019-09-23  1080  #define KUNIT_BINARY_PTR_LE_MSG_ASSERTION(test,				       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23  1081  					  assert_type,			       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23  1082  					  left,				       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23  1083  					  right,			       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23  1084  					  fmt,				       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23  1085  					  ...)				       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23  1086  	KUNIT_BASE_LE_MSG_ASSERTION(test,				       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23  1087  				    kunit_binary_ptr_assert,		       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23  1088  				    KUNIT_INIT_BINARY_PTR_ASSERT_STRUCT,       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23  1089  				    assert_type,			       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23  1090  				    left,				       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23  1091  				    right,				       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23  1092  				    fmt,				       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23  1093  				    ##__VA_ARGS__)
73cda7bb8bfb1d Brendan Higgins 2019-09-23  1094  
73cda7bb8bfb1d Brendan Higgins 2019-09-23  1095  #define KUNIT_BINARY_PTR_LE_ASSERTION(test, assert_type, left, right)	       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23  1096  	KUNIT_BINARY_PTR_LE_MSG_ASSERTION(test,				       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23  1097  					  assert_type,			       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23  1098  					  left,				       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23  1099  					  right,			       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23  1100  					  NULL)
73cda7bb8bfb1d Brendan Higgins 2019-09-23  1101  
73cda7bb8bfb1d Brendan Higgins 2019-09-23  1102  #define KUNIT_BINARY_GT_MSG_ASSERTION(test, assert_type, left, right, fmt, ...)\
73cda7bb8bfb1d Brendan Higgins 2019-09-23  1103  	KUNIT_BASE_GT_MSG_ASSERTION(test,				       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23  1104  				    kunit_binary_assert,		       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23  1105  				    KUNIT_INIT_BINARY_ASSERT_STRUCT,	       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23  1106  				    assert_type,			       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23  1107  				    left,				       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23  1108  				    right,				       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23  1109  				    fmt,				       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23  1110  				    ##__VA_ARGS__)
73cda7bb8bfb1d Brendan Higgins 2019-09-23  1111  
73cda7bb8bfb1d Brendan Higgins 2019-09-23  1112  #define KUNIT_BINARY_GT_ASSERTION(test, assert_type, left, right)	       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23  1113  	KUNIT_BINARY_GT_MSG_ASSERTION(test,				       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23  1114  				      assert_type,			       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23  1115  				      left,				       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23  1116  				      right,				       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23  1117  				      NULL)
73cda7bb8bfb1d Brendan Higgins 2019-09-23  1118  
73cda7bb8bfb1d Brendan Higgins 2019-09-23  1119  #define KUNIT_BINARY_PTR_GT_MSG_ASSERTION(test,				       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23  1120  					  assert_type,			       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23  1121  					  left,				       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23  1122  					  right,			       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23  1123  					  fmt,				       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23  1124  					  ...)				       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23  1125  	KUNIT_BASE_GT_MSG_ASSERTION(test,				       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23  1126  				    kunit_binary_ptr_assert,		       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23  1127  				    KUNIT_INIT_BINARY_PTR_ASSERT_STRUCT,       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23  1128  				    assert_type,			       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23  1129  				    left,				       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23  1130  				    right,				       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23  1131  				    fmt,				       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23  1132  				    ##__VA_ARGS__)
73cda7bb8bfb1d Brendan Higgins 2019-09-23  1133  
73cda7bb8bfb1d Brendan Higgins 2019-09-23  1134  #define KUNIT_BINARY_PTR_GT_ASSERTION(test, assert_type, left, right)	       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23  1135  	KUNIT_BINARY_PTR_GT_MSG_ASSERTION(test,				       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23  1136  					  assert_type,			       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23  1137  					  left,				       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23  1138  					  right,			       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23  1139  					  NULL)
73cda7bb8bfb1d Brendan Higgins 2019-09-23  1140  
73cda7bb8bfb1d Brendan Higgins 2019-09-23  1141  #define KUNIT_BINARY_GE_MSG_ASSERTION(test, assert_type, left, right, fmt, ...)\
73cda7bb8bfb1d Brendan Higgins 2019-09-23  1142  	KUNIT_BASE_GE_MSG_ASSERTION(test,				       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23  1143  				    kunit_binary_assert,		       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23  1144  				    KUNIT_INIT_BINARY_ASSERT_STRUCT,	       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23  1145  				    assert_type,			       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23  1146  				    left,				       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23  1147  				    right,				       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23  1148  				    fmt,				       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23  1149  				    ##__VA_ARGS__)
73cda7bb8bfb1d Brendan Higgins 2019-09-23  1150  
73cda7bb8bfb1d Brendan Higgins 2019-09-23  1151  #define KUNIT_BINARY_GE_ASSERTION(test, assert_type, left, right)	       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23  1152  	KUNIT_BINARY_GE_MSG_ASSERTION(test,				       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23  1153  				      assert_type,			       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23  1154  				      left,				       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23  1155  				      right,				       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23  1156  				      NULL)
73cda7bb8bfb1d Brendan Higgins 2019-09-23  1157  
73cda7bb8bfb1d Brendan Higgins 2019-09-23  1158  #define KUNIT_BINARY_PTR_GE_MSG_ASSERTION(test,				       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23  1159  					  assert_type,			       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23  1160  					  left,				       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23  1161  					  right,			       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23  1162  					  fmt,				       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23  1163  					  ...)				       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23  1164  	KUNIT_BASE_GE_MSG_ASSERTION(test,				       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23  1165  				    kunit_binary_ptr_assert,		       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23  1166  				    KUNIT_INIT_BINARY_PTR_ASSERT_STRUCT,       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23  1167  				    assert_type,			       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23  1168  				    left,				       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23  1169  				    right,				       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23  1170  				    fmt,				       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23  1171  				    ##__VA_ARGS__)
73cda7bb8bfb1d Brendan Higgins 2019-09-23  1172  
73cda7bb8bfb1d Brendan Higgins 2019-09-23  1173  #define KUNIT_BINARY_PTR_GE_ASSERTION(test, assert_type, left, right)	       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23  1174  	KUNIT_BINARY_PTR_GE_MSG_ASSERTION(test,				       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23  1175  					  assert_type,			       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23  1176  					  left,				       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23  1177  					  right,			       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23  1178  					  NULL)
73cda7bb8bfb1d Brendan Higgins 2019-09-23  1179  
73cda7bb8bfb1d Brendan Higgins 2019-09-23  1180  #define KUNIT_BINARY_STR_ASSERTION(test,				       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23  1181  				   assert_type,				       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23  1182  				   left,				       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23  1183  				   op,					       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23  1184  				   right,				       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23  1185  				   fmt,					       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23  1186  				   ...)					       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23  1187  do {									       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23 @1188  	typeof(left) __left = (left);					       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23  1189  	typeof(right) __right = (right);				       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23  1190  									       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23  1191  	KUNIT_ASSERTION(test,						       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23  1192  			strcmp(__left, __right) op 0,			       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23  1193  			kunit_binary_str_assert,			       \
3084db0e0d5076 Daniel Latypov  2020-11-02  1194  			KUNIT_INIT_BINARY_STR_ASSERT_STRUCT(test,	       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23  1195  							assert_type,	       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23  1196  							#op,		       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23  1197  							#left,		       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23  1198  							__left,		       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23  1199  							#right,		       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23  1200  							__right),	       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23  1201  			fmt,						       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23  1202  			##__VA_ARGS__);					       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23  1203  } while (0)
73cda7bb8bfb1d Brendan Higgins 2019-09-23  1204  

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--3MwIy2ne0vdjdPXF
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
hDwTLoD/B3imaOlaqAIA

--3MwIy2ne0vdjdPXF--
