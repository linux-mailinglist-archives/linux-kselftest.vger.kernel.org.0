Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 382F339F2E3
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Jun 2021 11:51:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231263AbhFHJxe (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 8 Jun 2021 05:53:34 -0400
Received: from mga14.intel.com ([192.55.52.115]:30288 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231259AbhFHJxe (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 8 Jun 2021 05:53:34 -0400
IronPort-SDR: LzsLblC+VXI30Pt1o0/R8ICjcfCfPAu3Pk8nFpdv9pG125ee7dsWhjHUCH6utzPlKRXIGb4rtb
 mjDeOdEYlFtg==
X-IronPort-AV: E=McAfee;i="6200,9189,10008"; a="204626266"
X-IronPort-AV: E=Sophos;i="5.83,257,1616482800"; 
   d="gz'50?scan'50,208,50";a="204626266"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2021 02:51:41 -0700
IronPort-SDR: 92ktGQbg8x4eR71YiJDzBuuIKXXc0aCnwg4elMXqfXRqt2Ckm0HVk39p/nUHD60P2PprA7tM71
 PatLAUoXhDlQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,257,1616482800"; 
   d="gz'50?scan'50,208,50";a="449465076"
Received: from lkp-server02.sh.intel.com (HELO 1ec8406c5392) ([10.239.97.151])
  by fmsmga008.fm.intel.com with ESMTP; 08 Jun 2021 02:51:38 -0700
Received: from kbuild by 1ec8406c5392 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lqYOX-0008wu-Kr; Tue, 08 Jun 2021 09:51:37 +0000
Date:   Tue, 8 Jun 2021 17:51:00 +0800
From:   kernel test robot <lkp@intel.com>
To:     David Gow <davidgow@google.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        Alan Maguire <alan.maguire@oracle.com>
Cc:     kbuild-all@lists.01.org, David Gow <davidgow@google.com>,
        Daniel Latypov <dlatypov@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Marco Elver <elver@google.com>, kunit-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/4] kunit: Support skipped tests
Message-ID: <202106081707.pl7giH76-lkp@intel.com>
References: <20210608064852.609327-1-davidgow@google.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="ReaqsoxgOBHFXBhH"
Content-Disposition: inline
In-Reply-To: <20210608064852.609327-1-davidgow@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


--ReaqsoxgOBHFXBhH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi David,

I love your patch! Yet something to improve:

[auto build test ERROR on linus/master]
[also build test ERROR on v5.13-rc5 next-20210607]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/David-Gow/kunit-Support-skipped-tests/20210608-145216
base:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 614124bea77e452aa6df7a8714e8bc820b489922
config: i386-randconfig-s002-20210607 (attached as .config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.3-341-g8af24329-dirty
        # https://github.com/0day-ci/linux/commit/616d7103da7386e89d71208b4df68453790e30ad
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review David-Gow/kunit-Support-skipped-tests/20210608-145216
        git checkout 616d7103da7386e89d71208b4df68453790e30ad
        # save the attached .config to linux build tree
        make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' W=1 ARCH=i386 

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
   include/kunit/test.h:839:9: note: in expansion of macro '__typecheck'
     839 |  ((void)__typecheck(__left, __right));           \
         |         ^~~~~~~~~~~
   include/kunit/test.h:863:2: note: in expansion of macro 'KUNIT_BASE_BINARY_ASSERTION'
     863 |  KUNIT_BASE_BINARY_ASSERTION(test,           \
         |  ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/kunit/test.h:952:2: note: in expansion of macro 'KUNIT_BASE_EQ_MSG_ASSERTION'
     952 |  KUNIT_BASE_EQ_MSG_ASSERTION(test,           \
         |  ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/kunit/test.h:962:2: note: in expansion of macro 'KUNIT_BINARY_EQ_MSG_ASSERTION'
     962 |  KUNIT_BINARY_EQ_MSG_ASSERTION(test,           \
         |  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/kunit/test.h:1325:2: note: in expansion of macro 'KUNIT_BINARY_EQ_ASSERTION'
    1325 |  KUNIT_BINARY_EQ_ASSERTION(test, KUNIT_EXPECTATION, left, right)
         |  ^~~~~~~~~~~~~~~~~~~~~~~~~
   lib/kunit/kunit-test.c:458:2: note: in expansion of macro 'KUNIT_EXPECT_EQ'
     458 |  KUNIT_EXPECT_EQ(test, fake.status, KUNIT_SUCCESS);
         |  ^~~~~~~~~~~~~~~
   In file included from lib/kunit/kunit-test.c:8:
>> include/kunit/test.h:1193:24: error: invalid initializer
    1193 |  typeof(left) __left = (left);            \
         |                        ^
   include/kunit/test.h:1216:2: note: in expansion of macro 'KUNIT_BINARY_STR_ASSERTION'
    1216 |  KUNIT_BINARY_STR_ASSERTION(test,           \
         |  ^~~~~~~~~~~~~~~~~~~~~~~~~~
   include/kunit/test.h:1223:2: note: in expansion of macro 'KUNIT_BINARY_STR_EQ_MSG_ASSERTION'
    1223 |  KUNIT_BINARY_STR_EQ_MSG_ASSERTION(test,           \
         |  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/kunit/test.h:1507:2: note: in expansion of macro 'KUNIT_BINARY_STR_EQ_ASSERTION'
    1507 |  KUNIT_BINARY_STR_EQ_ASSERTION(test, KUNIT_EXPECTATION, left, right)
         |  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   lib/kunit/kunit-test.c:459:2: note: in expansion of macro 'KUNIT_EXPECT_STREQ'
     459 |  KUNIT_EXPECT_STREQ(test, fake.status_comment, "");
         |  ^~~~~~~~~~~~~~~~~~
>> include/kunit/test.h:1193:24: error: invalid initializer
    1193 |  typeof(left) __left = (left);            \
         |                        ^
   include/kunit/test.h:1216:2: note: in expansion of macro 'KUNIT_BINARY_STR_ASSERTION'
    1216 |  KUNIT_BINARY_STR_ASSERTION(test,           \
         |  ^~~~~~~~~~~~~~~~~~~~~~~~~~
   include/kunit/test.h:1223:2: note: in expansion of macro 'KUNIT_BINARY_STR_EQ_MSG_ASSERTION'
    1223 |  KUNIT_BINARY_STR_EQ_MSG_ASSERTION(test,           \
         |  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/kunit/test.h:1507:2: note: in expansion of macro 'KUNIT_BINARY_STR_EQ_ASSERTION'
    1507 |  KUNIT_BINARY_STR_EQ_ASSERTION(test, KUNIT_EXPECTATION, left, right)
         |  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   lib/kunit/kunit-test.c:466:2: note: in expansion of macro 'KUNIT_EXPECT_STREQ'
     466 |  KUNIT_EXPECT_STREQ(test, fake.status_comment, "Accepts format string: YES");
         |  ^~~~~~~~~~~~~~~~~~


vim +1193 include/kunit/test.h

73cda7bb8bfb1d Brendan Higgins 2019-09-23   854  
73cda7bb8bfb1d Brendan Higgins 2019-09-23   855  #define KUNIT_BASE_EQ_MSG_ASSERTION(test,				       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23   856  				    assert_class,			       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23   857  				    ASSERT_CLASS_INIT,			       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23   858  				    assert_type,			       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23   859  				    left,				       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23   860  				    right,				       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23   861  				    fmt,				       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23   862  				    ...)				       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23   863  	KUNIT_BASE_BINARY_ASSERTION(test,				       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23   864  				    assert_class,			       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23   865  				    ASSERT_CLASS_INIT,			       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23   866  				    assert_type,			       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23   867  				    left, ==, right,			       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23   868  				    fmt,				       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23   869  				    ##__VA_ARGS__)
73cda7bb8bfb1d Brendan Higgins 2019-09-23   870  
73cda7bb8bfb1d Brendan Higgins 2019-09-23   871  #define KUNIT_BASE_NE_MSG_ASSERTION(test,				       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23   872  				    assert_class,			       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23   873  				    ASSERT_CLASS_INIT,			       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23   874  				    assert_type,			       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23   875  				    left,				       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23   876  				    right,				       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23   877  				    fmt,				       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23   878  				    ...)				       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23   879  	KUNIT_BASE_BINARY_ASSERTION(test,				       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23   880  				    assert_class,			       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23   881  				    ASSERT_CLASS_INIT,			       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23   882  				    assert_type,			       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23   883  				    left, !=, right,			       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23   884  				    fmt,				       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23   885  				    ##__VA_ARGS__)
73cda7bb8bfb1d Brendan Higgins 2019-09-23   886  
73cda7bb8bfb1d Brendan Higgins 2019-09-23   887  #define KUNIT_BASE_LT_MSG_ASSERTION(test,				       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23   888  				    assert_class,			       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23   889  				    ASSERT_CLASS_INIT,			       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23   890  				    assert_type,			       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23   891  				    left,				       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23   892  				    right,				       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23   893  				    fmt,				       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23   894  				    ...)				       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23   895  	KUNIT_BASE_BINARY_ASSERTION(test,				       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23   896  				    assert_class,			       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23   897  				    ASSERT_CLASS_INIT,			       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23   898  				    assert_type,			       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23   899  				    left, <, right,			       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23   900  				    fmt,				       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23   901  				    ##__VA_ARGS__)
73cda7bb8bfb1d Brendan Higgins 2019-09-23   902  
73cda7bb8bfb1d Brendan Higgins 2019-09-23   903  #define KUNIT_BASE_LE_MSG_ASSERTION(test,				       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23   904  				    assert_class,			       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23   905  				    ASSERT_CLASS_INIT,			       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23   906  				    assert_type,			       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23   907  				    left,				       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23   908  				    right,				       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23   909  				    fmt,				       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23   910  				    ...)				       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23   911  	KUNIT_BASE_BINARY_ASSERTION(test,				       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23   912  				    assert_class,			       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23   913  				    ASSERT_CLASS_INIT,			       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23   914  				    assert_type,			       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23   915  				    left, <=, right,			       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23   916  				    fmt,				       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23   917  				    ##__VA_ARGS__)
73cda7bb8bfb1d Brendan Higgins 2019-09-23   918  
73cda7bb8bfb1d Brendan Higgins 2019-09-23   919  #define KUNIT_BASE_GT_MSG_ASSERTION(test,				       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23   920  				    assert_class,			       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23   921  				    ASSERT_CLASS_INIT,			       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23   922  				    assert_type,			       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23   923  				    left,				       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23   924  				    right,				       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23   925  				    fmt,				       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23   926  				    ...)				       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23   927  	KUNIT_BASE_BINARY_ASSERTION(test,				       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23   928  				    assert_class,			       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23   929  				    ASSERT_CLASS_INIT,			       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23   930  				    assert_type,			       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23   931  				    left, >, right,			       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23   932  				    fmt,				       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23   933  				    ##__VA_ARGS__)
73cda7bb8bfb1d Brendan Higgins 2019-09-23   934  
73cda7bb8bfb1d Brendan Higgins 2019-09-23   935  #define KUNIT_BASE_GE_MSG_ASSERTION(test,				       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23   936  				    assert_class,			       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23   937  				    ASSERT_CLASS_INIT,			       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23   938  				    assert_type,			       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23   939  				    left,				       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23   940  				    right,				       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23   941  				    fmt,				       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23   942  				    ...)				       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23   943  	KUNIT_BASE_BINARY_ASSERTION(test,				       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23   944  				    assert_class,			       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23   945  				    ASSERT_CLASS_INIT,			       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23   946  				    assert_type,			       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23   947  				    left, >=, right,			       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23   948  				    fmt,				       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23   949  				    ##__VA_ARGS__)
73cda7bb8bfb1d Brendan Higgins 2019-09-23   950  
73cda7bb8bfb1d Brendan Higgins 2019-09-23   951  #define KUNIT_BINARY_EQ_MSG_ASSERTION(test, assert_type, left, right, fmt, ...)\
73cda7bb8bfb1d Brendan Higgins 2019-09-23   952  	KUNIT_BASE_EQ_MSG_ASSERTION(test,				       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23   953  				    kunit_binary_assert,		       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23   954  				    KUNIT_INIT_BINARY_ASSERT_STRUCT,	       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23   955  				    assert_type,			       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23   956  				    left,				       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23   957  				    right,				       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23   958  				    fmt,				       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23   959  				    ##__VA_ARGS__)
73cda7bb8bfb1d Brendan Higgins 2019-09-23   960  
73cda7bb8bfb1d Brendan Higgins 2019-09-23   961  #define KUNIT_BINARY_EQ_ASSERTION(test, assert_type, left, right)	       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23   962  	KUNIT_BINARY_EQ_MSG_ASSERTION(test,				       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23   963  				      assert_type,			       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23   964  				      left,				       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23   965  				      right,				       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23   966  				      NULL)
73cda7bb8bfb1d Brendan Higgins 2019-09-23   967  
73cda7bb8bfb1d Brendan Higgins 2019-09-23   968  #define KUNIT_BINARY_PTR_EQ_MSG_ASSERTION(test,				       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23   969  					  assert_type,			       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23   970  					  left,				       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23   971  					  right,			       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23   972  					  fmt,				       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23   973  					  ...)				       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23   974  	KUNIT_BASE_EQ_MSG_ASSERTION(test,				       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23   975  				    kunit_binary_ptr_assert,		       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23   976  				    KUNIT_INIT_BINARY_PTR_ASSERT_STRUCT,       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23   977  				    assert_type,			       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23   978  				    left,				       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23   979  				    right,				       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23   980  				    fmt,				       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23   981  				    ##__VA_ARGS__)
73cda7bb8bfb1d Brendan Higgins 2019-09-23   982  
73cda7bb8bfb1d Brendan Higgins 2019-09-23   983  #define KUNIT_BINARY_PTR_EQ_ASSERTION(test, assert_type, left, right)	       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23   984  	KUNIT_BINARY_PTR_EQ_MSG_ASSERTION(test,				       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23   985  					  assert_type,			       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23   986  					  left,				       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23   987  					  right,			       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23   988  					  NULL)
73cda7bb8bfb1d Brendan Higgins 2019-09-23   989  
73cda7bb8bfb1d Brendan Higgins 2019-09-23   990  #define KUNIT_BINARY_NE_MSG_ASSERTION(test, assert_type, left, right, fmt, ...)\
73cda7bb8bfb1d Brendan Higgins 2019-09-23   991  	KUNIT_BASE_NE_MSG_ASSERTION(test,				       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23   992  				    kunit_binary_assert,		       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23   993  				    KUNIT_INIT_BINARY_ASSERT_STRUCT,	       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23   994  				    assert_type,			       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23   995  				    left,				       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23   996  				    right,				       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23   997  				    fmt,				       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23   998  				    ##__VA_ARGS__)
73cda7bb8bfb1d Brendan Higgins 2019-09-23   999  
73cda7bb8bfb1d Brendan Higgins 2019-09-23  1000  #define KUNIT_BINARY_NE_ASSERTION(test, assert_type, left, right)	       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23  1001  	KUNIT_BINARY_NE_MSG_ASSERTION(test,				       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23  1002  				      assert_type,			       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23  1003  				      left,				       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23  1004  				      right,				       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23  1005  				      NULL)
73cda7bb8bfb1d Brendan Higgins 2019-09-23  1006  
73cda7bb8bfb1d Brendan Higgins 2019-09-23  1007  #define KUNIT_BINARY_PTR_NE_MSG_ASSERTION(test,				       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23  1008  					  assert_type,			       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23  1009  					  left,				       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23  1010  					  right,			       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23  1011  					  fmt,				       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23  1012  					  ...)				       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23  1013  	KUNIT_BASE_NE_MSG_ASSERTION(test,				       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23  1014  				    kunit_binary_ptr_assert,		       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23  1015  				    KUNIT_INIT_BINARY_PTR_ASSERT_STRUCT,       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23  1016  				    assert_type,			       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23  1017  				    left,				       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23  1018  				    right,				       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23  1019  				    fmt,				       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23  1020  				    ##__VA_ARGS__)
73cda7bb8bfb1d Brendan Higgins 2019-09-23  1021  
73cda7bb8bfb1d Brendan Higgins 2019-09-23  1022  #define KUNIT_BINARY_PTR_NE_ASSERTION(test, assert_type, left, right)	       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23  1023  	KUNIT_BINARY_PTR_NE_MSG_ASSERTION(test,				       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23  1024  					  assert_type,			       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23  1025  					  left,				       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23  1026  					  right,			       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23  1027  					  NULL)
73cda7bb8bfb1d Brendan Higgins 2019-09-23  1028  
73cda7bb8bfb1d Brendan Higgins 2019-09-23  1029  #define KUNIT_BINARY_LT_MSG_ASSERTION(test, assert_type, left, right, fmt, ...)\
73cda7bb8bfb1d Brendan Higgins 2019-09-23  1030  	KUNIT_BASE_LT_MSG_ASSERTION(test,				       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23  1031  				    kunit_binary_assert,		       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23  1032  				    KUNIT_INIT_BINARY_ASSERT_STRUCT,	       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23  1033  				    assert_type,			       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23  1034  				    left,				       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23  1035  				    right,				       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23  1036  				    fmt,				       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23  1037  				    ##__VA_ARGS__)
73cda7bb8bfb1d Brendan Higgins 2019-09-23  1038  
73cda7bb8bfb1d Brendan Higgins 2019-09-23  1039  #define KUNIT_BINARY_LT_ASSERTION(test, assert_type, left, right)	       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23  1040  	KUNIT_BINARY_LT_MSG_ASSERTION(test,				       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23  1041  				      assert_type,			       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23  1042  				      left,				       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23  1043  				      right,				       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23  1044  				      NULL)
73cda7bb8bfb1d Brendan Higgins 2019-09-23  1045  
73cda7bb8bfb1d Brendan Higgins 2019-09-23  1046  #define KUNIT_BINARY_PTR_LT_MSG_ASSERTION(test,				       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23  1047  					  assert_type,			       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23  1048  					  left,				       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23  1049  					  right,			       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23  1050  					  fmt,				       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23  1051  					  ...)				       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23  1052  	KUNIT_BASE_LT_MSG_ASSERTION(test,				       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23  1053  				    kunit_binary_ptr_assert,		       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23  1054  				    KUNIT_INIT_BINARY_PTR_ASSERT_STRUCT,       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23  1055  				    assert_type,			       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23  1056  				    left,				       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23  1057  				    right,				       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23  1058  				    fmt,				       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23  1059  				    ##__VA_ARGS__)
73cda7bb8bfb1d Brendan Higgins 2019-09-23  1060  
73cda7bb8bfb1d Brendan Higgins 2019-09-23  1061  #define KUNIT_BINARY_PTR_LT_ASSERTION(test, assert_type, left, right)	       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23  1062  	KUNIT_BINARY_PTR_LT_MSG_ASSERTION(test,				       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23  1063  					  assert_type,			       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23  1064  					  left,				       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23  1065  					  right,			       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23  1066  					  NULL)
73cda7bb8bfb1d Brendan Higgins 2019-09-23  1067  
73cda7bb8bfb1d Brendan Higgins 2019-09-23  1068  #define KUNIT_BINARY_LE_MSG_ASSERTION(test, assert_type, left, right, fmt, ...)\
73cda7bb8bfb1d Brendan Higgins 2019-09-23  1069  	KUNIT_BASE_LE_MSG_ASSERTION(test,				       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23  1070  				    kunit_binary_assert,		       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23  1071  				    KUNIT_INIT_BINARY_ASSERT_STRUCT,	       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23  1072  				    assert_type,			       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23  1073  				    left,				       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23  1074  				    right,				       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23  1075  				    fmt,				       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23  1076  				    ##__VA_ARGS__)
73cda7bb8bfb1d Brendan Higgins 2019-09-23  1077  
73cda7bb8bfb1d Brendan Higgins 2019-09-23  1078  #define KUNIT_BINARY_LE_ASSERTION(test, assert_type, left, right)	       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23  1079  	KUNIT_BINARY_LE_MSG_ASSERTION(test,				       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23  1080  				      assert_type,			       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23  1081  				      left,				       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23  1082  				      right,				       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23  1083  				      NULL)
73cda7bb8bfb1d Brendan Higgins 2019-09-23  1084  
73cda7bb8bfb1d Brendan Higgins 2019-09-23  1085  #define KUNIT_BINARY_PTR_LE_MSG_ASSERTION(test,				       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23  1086  					  assert_type,			       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23  1087  					  left,				       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23  1088  					  right,			       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23  1089  					  fmt,				       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23  1090  					  ...)				       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23  1091  	KUNIT_BASE_LE_MSG_ASSERTION(test,				       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23  1092  				    kunit_binary_ptr_assert,		       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23  1093  				    KUNIT_INIT_BINARY_PTR_ASSERT_STRUCT,       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23  1094  				    assert_type,			       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23  1095  				    left,				       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23  1096  				    right,				       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23  1097  				    fmt,				       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23  1098  				    ##__VA_ARGS__)
73cda7bb8bfb1d Brendan Higgins 2019-09-23  1099  
73cda7bb8bfb1d Brendan Higgins 2019-09-23  1100  #define KUNIT_BINARY_PTR_LE_ASSERTION(test, assert_type, left, right)	       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23  1101  	KUNIT_BINARY_PTR_LE_MSG_ASSERTION(test,				       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23  1102  					  assert_type,			       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23  1103  					  left,				       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23  1104  					  right,			       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23  1105  					  NULL)
73cda7bb8bfb1d Brendan Higgins 2019-09-23  1106  
73cda7bb8bfb1d Brendan Higgins 2019-09-23  1107  #define KUNIT_BINARY_GT_MSG_ASSERTION(test, assert_type, left, right, fmt, ...)\
73cda7bb8bfb1d Brendan Higgins 2019-09-23  1108  	KUNIT_BASE_GT_MSG_ASSERTION(test,				       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23  1109  				    kunit_binary_assert,		       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23  1110  				    KUNIT_INIT_BINARY_ASSERT_STRUCT,	       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23  1111  				    assert_type,			       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23  1112  				    left,				       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23  1113  				    right,				       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23  1114  				    fmt,				       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23  1115  				    ##__VA_ARGS__)
73cda7bb8bfb1d Brendan Higgins 2019-09-23  1116  
73cda7bb8bfb1d Brendan Higgins 2019-09-23  1117  #define KUNIT_BINARY_GT_ASSERTION(test, assert_type, left, right)	       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23  1118  	KUNIT_BINARY_GT_MSG_ASSERTION(test,				       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23  1119  				      assert_type,			       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23  1120  				      left,				       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23  1121  				      right,				       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23  1122  				      NULL)
73cda7bb8bfb1d Brendan Higgins 2019-09-23  1123  
73cda7bb8bfb1d Brendan Higgins 2019-09-23  1124  #define KUNIT_BINARY_PTR_GT_MSG_ASSERTION(test,				       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23  1125  					  assert_type,			       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23  1126  					  left,				       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23  1127  					  right,			       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23  1128  					  fmt,				       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23  1129  					  ...)				       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23  1130  	KUNIT_BASE_GT_MSG_ASSERTION(test,				       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23  1131  				    kunit_binary_ptr_assert,		       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23  1132  				    KUNIT_INIT_BINARY_PTR_ASSERT_STRUCT,       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23  1133  				    assert_type,			       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23  1134  				    left,				       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23  1135  				    right,				       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23  1136  				    fmt,				       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23  1137  				    ##__VA_ARGS__)
73cda7bb8bfb1d Brendan Higgins 2019-09-23  1138  
73cda7bb8bfb1d Brendan Higgins 2019-09-23  1139  #define KUNIT_BINARY_PTR_GT_ASSERTION(test, assert_type, left, right)	       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23  1140  	KUNIT_BINARY_PTR_GT_MSG_ASSERTION(test,				       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23  1141  					  assert_type,			       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23  1142  					  left,				       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23  1143  					  right,			       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23  1144  					  NULL)
73cda7bb8bfb1d Brendan Higgins 2019-09-23  1145  
73cda7bb8bfb1d Brendan Higgins 2019-09-23  1146  #define KUNIT_BINARY_GE_MSG_ASSERTION(test, assert_type, left, right, fmt, ...)\
73cda7bb8bfb1d Brendan Higgins 2019-09-23  1147  	KUNIT_BASE_GE_MSG_ASSERTION(test,				       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23  1148  				    kunit_binary_assert,		       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23  1149  				    KUNIT_INIT_BINARY_ASSERT_STRUCT,	       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23  1150  				    assert_type,			       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23  1151  				    left,				       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23  1152  				    right,				       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23  1153  				    fmt,				       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23  1154  				    ##__VA_ARGS__)
73cda7bb8bfb1d Brendan Higgins 2019-09-23  1155  
73cda7bb8bfb1d Brendan Higgins 2019-09-23  1156  #define KUNIT_BINARY_GE_ASSERTION(test, assert_type, left, right)	       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23  1157  	KUNIT_BINARY_GE_MSG_ASSERTION(test,				       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23  1158  				      assert_type,			       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23  1159  				      left,				       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23  1160  				      right,				       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23  1161  				      NULL)
73cda7bb8bfb1d Brendan Higgins 2019-09-23  1162  
73cda7bb8bfb1d Brendan Higgins 2019-09-23  1163  #define KUNIT_BINARY_PTR_GE_MSG_ASSERTION(test,				       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23  1164  					  assert_type,			       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23  1165  					  left,				       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23  1166  					  right,			       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23  1167  					  fmt,				       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23  1168  					  ...)				       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23  1169  	KUNIT_BASE_GE_MSG_ASSERTION(test,				       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23  1170  				    kunit_binary_ptr_assert,		       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23  1171  				    KUNIT_INIT_BINARY_PTR_ASSERT_STRUCT,       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23  1172  				    assert_type,			       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23  1173  				    left,				       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23  1174  				    right,				       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23  1175  				    fmt,				       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23  1176  				    ##__VA_ARGS__)
73cda7bb8bfb1d Brendan Higgins 2019-09-23  1177  
73cda7bb8bfb1d Brendan Higgins 2019-09-23  1178  #define KUNIT_BINARY_PTR_GE_ASSERTION(test, assert_type, left, right)	       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23  1179  	KUNIT_BINARY_PTR_GE_MSG_ASSERTION(test,				       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23  1180  					  assert_type,			       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23  1181  					  left,				       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23  1182  					  right,			       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23  1183  					  NULL)
73cda7bb8bfb1d Brendan Higgins 2019-09-23  1184  
73cda7bb8bfb1d Brendan Higgins 2019-09-23  1185  #define KUNIT_BINARY_STR_ASSERTION(test,				       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23  1186  				   assert_type,				       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23  1187  				   left,				       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23  1188  				   op,					       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23  1189  				   right,				       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23  1190  				   fmt,					       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23  1191  				   ...)					       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23  1192  do {									       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23 @1193  	typeof(left) __left = (left);					       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23  1194  	typeof(right) __right = (right);				       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23  1195  									       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23  1196  	KUNIT_ASSERTION(test,						       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23  1197  			strcmp(__left, __right) op 0,			       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23  1198  			kunit_binary_str_assert,			       \
3084db0e0d5076 Daniel Latypov  2020-11-02  1199  			KUNIT_INIT_BINARY_STR_ASSERT_STRUCT(test,	       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23  1200  							assert_type,	       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23  1201  							#op,		       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23  1202  							#left,		       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23  1203  							__left,		       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23  1204  							#right,		       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23  1205  							__right),	       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23  1206  			fmt,						       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23  1207  			##__VA_ARGS__);					       \
73cda7bb8bfb1d Brendan Higgins 2019-09-23  1208  } while (0)
73cda7bb8bfb1d Brendan Higgins 2019-09-23  1209  

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--ReaqsoxgOBHFXBhH
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

H4sICFwwv2AAAy5jb25maWcAjDxJc9y20vf8iinnkhySaLEVp77SASTBGWRIggbAWXRhyfLY
UT1LyhtJL/G//7oBLgDYnCQHR9PdaGyN3tDg9999v2CvL08Pty/3d7dfv35bfDk8Ho63L4dP
i8/3Xw//t8jkopJmwTNhfgbi4v7x9e9f7i/fXy3e/Xx++fPZT8e7d4v14fh4+LpInx4/3395
heb3T4/fff9dKqtcLNs0bTdcaSGr1vCduX7z5e7up98WP2SHj/e3j4vffkY2Fxc/ur/eeM2E
bpdpev2tBy1HVte/nV2enQ20BauWA2oAM21ZVM3IAkA92cXlu7OLHl5kSJrk2UgKIJrUQ5x5
o01Z1RaiWo8cPGCrDTMiDXArGAzTZbuURpIIUUFTPqKE+tBupfJ6SBpRZEaUvDUsKXirpTIj
1qwUZzCxKpfwD5BobAo78/1iaff56+L58PL657hXiZJrXrWwVbqsvY4rYVpebVqmYP6iFOb6
8gK49EOWZS2gd8O1Wdw/Lx6fXpDxsGAyZUW/Ym/eUOCWNf4a2Gm1mhXGo1+xDW/XXFW8aJc3
whuej0kAc0GjipuS0ZjdzVwLOYd4SyNutEERGpbGG6+/MjHejvoUAY79FH53Qyx8MIspx7en
GOJECJYZz1lTGCsR3t704JXUpmIlv37zw+PT4+HHgUBvmbdheq83ok4nAPx/agp/tLXUYteW
HxrecHK8W2bSVTuPT5XUui15KdW+ZcawdEXSNZoXIiFRrAH1RyyG3XimoHtLgYNnRdEfMTit
i+fXj8/fnl8OD+MRW/KKK5Haw1wrmXjn20fpldzSGFH9zlODZ8mTQJUBSsMyt4prXmWh0shk
yURFwdqV4AqnsKc7Q25qw7C7tpRZpIxyqVKedXpGVEtvQ2umNEcimm/Gk2aZa7vTh8dPi6fP
0XqNql2may0b6MhtdSa9buzi+yRWLr9RjTesEBkzvC2YNm26Twti5a0q3YwbGaEtP77hldEn
kW0JK8uy3xttCLpS6rapcSyRDnGyntaNHYfSVmNHGv8kjZU7c/9wOD5TogcGaA26nYNseeOq
ZLu6QR1eWpEapB6ANQxYZiIlZN+1Epm/ihYWsBDLFYpQN9bwcHXbPhnuYATqPFofDqD2d7vB
dqbwM5jm0C/SdZtIHuiODzmekOmw7IrzsjYwRWuQR/XUwTeyaCrD1J7sr6MilrFvn0po3s8L
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
hW8PX4LIffQk753ALHEP9f8LYV9ahuwBAA==

--ReaqsoxgOBHFXBhH--
