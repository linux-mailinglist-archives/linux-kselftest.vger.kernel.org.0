Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 913DF29CD5F
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 Oct 2020 02:49:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725968AbgJ1BiX (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 27 Oct 2020 21:38:23 -0400
Received: from mga03.intel.com ([134.134.136.65]:63209 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1833058AbgJ0Xut (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 27 Oct 2020 19:50:49 -0400
IronPort-SDR: oyWIDbvb8v8glFKcJUpH/7Xilx6ijArkwDeSgMu//DezOAX4JeHJEEkq0ItTIYa5dwECfqYmbt
 IksJS7C8jlew==
X-IronPort-AV: E=McAfee;i="6000,8403,9787"; a="168278312"
X-IronPort-AV: E=Sophos;i="5.77,424,1596524400"; 
   d="gz'50?scan'50,208,50";a="168278312"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2020 16:50:44 -0700
IronPort-SDR: 5PuHbGyNcBZ3WsGlgbIjfUqiReCZEJ3hjXCTa52r8C61fQGZyDtdoWIKsvGKLEpRL4SJuxjlll
 p+DdH/4TFobg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,424,1596524400"; 
   d="gz'50?scan'50,208,50";a="394647403"
Received: from lkp-server02.sh.intel.com (HELO 74b0a1e0e619) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 27 Oct 2020 16:50:41 -0700
Received: from kbuild by 74b0a1e0e619 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kXYjh-00009k-1U; Tue, 27 Oct 2020 23:50:41 +0000
Date:   Wed, 28 Oct 2020 07:49:42 +0800
From:   kernel test robot <lkp@intel.com>
To:     Arpitha Raghunandan <98.arpi@gmail.com>, brendanhiggins@google.com,
        skhan@linuxfoundation.org, elver@google.com, yzaikin@google.com,
        tytso@mit.edu, adilger.kernel@dilger.ca
Cc:     kbuild-all@lists.01.org, Arpitha Raghunandan <98.arpi@gmail.com>,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/2] fs: ext4: Modify inode-test.c to use KUnit
 parameterized testing feature
Message-ID: <202010280748.WUyq8OoJ-lkp@intel.com>
References: <20201027174726.85284-1-98.arpi@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="dDRMvlgZJXvWKvBx"
Content-Disposition: inline
In-Reply-To: <20201027174726.85284-1-98.arpi@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


--dDRMvlgZJXvWKvBx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Arpitha,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on ext4/dev]
[also build test WARNING on linus/master v5.10-rc1 next-20201027]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Arpitha-Raghunandan/kunit-Support-for-Parameterized-Testing/20201028-015018
base:   https://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git dev
config: mips-randconfig-r016-20201027 (attached as .config)
compiler: mipsel-linux-gcc (GCC) 9.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/2de1e52708cd83d1dc4c718876683f6809045a98
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Arpitha-Raghunandan/kunit-Support-for-Parameterized-Testing/20201028-015018
        git checkout 2de1e52708cd83d1dc4c718876683f6809045a98
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross ARCH=mips 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from fs/ext4/inode-test.c:7:
   fs/ext4/inode-test.c: In function 'ext4_inode_gen_params':
>> include/kunit/test.h:1735:58: warning: return discards 'const' qualifier from pointer target type [-Wdiscarded-qualifiers]
    1735 |   return __next - (array) < ARRAY_SIZE((array)) ? __next : NULL;   \
   fs/ext4/inode-test.c:214:1: note: in expansion of macro 'KUNIT_ARRAY_PARAM'
     214 | KUNIT_ARRAY_PARAM(ext4_inode, test_data);
         | ^~~~~~~~~~~~~~~~~

vim +/const +1735 include/kunit/test.h

73cda7bb8bfb1d Brendan Higgins     2019-09-23  1154  
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1155  #define KUNIT_PTR_NOT_ERR_OR_NULL_ASSERTION(test, assert_type, ptr)	       \
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1156  	KUNIT_PTR_NOT_ERR_OR_NULL_MSG_ASSERTION(test,			       \
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1157  						assert_type,		       \
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1158  						ptr,			       \
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1159  						NULL)
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1160  
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1161  /**
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1162   * KUNIT_EXPECT_TRUE() - Causes a test failure when the expression is not true.
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1163   * @test: The test context object.
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1164   * @condition: an arbitrary boolean expression. The test fails when this does
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1165   * not evaluate to true.
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1166   *
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1167   * This and expectations of the form `KUNIT_EXPECT_*` will cause the test case
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1168   * to fail when the specified condition is not met; however, it will not prevent
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1169   * the test case from continuing to run; this is otherwise known as an
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1170   * *expectation failure*.
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1171   */
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1172  #define KUNIT_EXPECT_TRUE(test, condition) \
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1173  	KUNIT_TRUE_ASSERTION(test, KUNIT_EXPECTATION, condition)
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1174  
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1175  #define KUNIT_EXPECT_TRUE_MSG(test, condition, fmt, ...)		       \
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1176  	KUNIT_TRUE_MSG_ASSERTION(test,					       \
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1177  				 KUNIT_EXPECTATION,			       \
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1178  				 condition,				       \
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1179  				 fmt,					       \
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1180  				 ##__VA_ARGS__)
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1181  
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1182  /**
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1183   * KUNIT_EXPECT_FALSE() - Makes a test failure when the expression is not false.
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1184   * @test: The test context object.
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1185   * @condition: an arbitrary boolean expression. The test fails when this does
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1186   * not evaluate to false.
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1187   *
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1188   * Sets an expectation that @condition evaluates to false. See
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1189   * KUNIT_EXPECT_TRUE() for more information.
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1190   */
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1191  #define KUNIT_EXPECT_FALSE(test, condition) \
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1192  	KUNIT_FALSE_ASSERTION(test, KUNIT_EXPECTATION, condition)
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1193  
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1194  #define KUNIT_EXPECT_FALSE_MSG(test, condition, fmt, ...)		       \
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1195  	KUNIT_FALSE_MSG_ASSERTION(test,					       \
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1196  				  KUNIT_EXPECTATION,			       \
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1197  				  condition,				       \
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1198  				  fmt,					       \
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1199  				  ##__VA_ARGS__)
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1200  
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1201  /**
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1202   * KUNIT_EXPECT_EQ() - Sets an expectation that @left and @right are equal.
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1203   * @test: The test context object.
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1204   * @left: an arbitrary expression that evaluates to a primitive C type.
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1205   * @right: an arbitrary expression that evaluates to a primitive C type.
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1206   *
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1207   * Sets an expectation that the values that @left and @right evaluate to are
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1208   * equal. This is semantically equivalent to
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1209   * KUNIT_EXPECT_TRUE(@test, (@left) == (@right)). See KUNIT_EXPECT_TRUE() for
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1210   * more information.
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1211   */
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1212  #define KUNIT_EXPECT_EQ(test, left, right) \
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1213  	KUNIT_BINARY_EQ_ASSERTION(test, KUNIT_EXPECTATION, left, right)
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1214  
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1215  #define KUNIT_EXPECT_EQ_MSG(test, left, right, fmt, ...)		       \
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1216  	KUNIT_BINARY_EQ_MSG_ASSERTION(test,				       \
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1217  				      KUNIT_EXPECTATION,		       \
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1218  				      left,				       \
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1219  				      right,				       \
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1220  				      fmt,				       \
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1221  				      ##__VA_ARGS__)
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1222  
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1223  /**
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1224   * KUNIT_EXPECT_PTR_EQ() - Expects that pointers @left and @right are equal.
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1225   * @test: The test context object.
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1226   * @left: an arbitrary expression that evaluates to a pointer.
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1227   * @right: an arbitrary expression that evaluates to a pointer.
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1228   *
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1229   * Sets an expectation that the values that @left and @right evaluate to are
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1230   * equal. This is semantically equivalent to
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1231   * KUNIT_EXPECT_TRUE(@test, (@left) == (@right)). See KUNIT_EXPECT_TRUE() for
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1232   * more information.
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1233   */
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1234  #define KUNIT_EXPECT_PTR_EQ(test, left, right)				       \
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1235  	KUNIT_BINARY_PTR_EQ_ASSERTION(test,				       \
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1236  				      KUNIT_EXPECTATION,		       \
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1237  				      left,				       \
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1238  				      right)
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1239  
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1240  #define KUNIT_EXPECT_PTR_EQ_MSG(test, left, right, fmt, ...)		       \
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1241  	KUNIT_BINARY_PTR_EQ_MSG_ASSERTION(test,				       \
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1242  					  KUNIT_EXPECTATION,		       \
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1243  					  left,				       \
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1244  					  right,			       \
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1245  					  fmt,				       \
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1246  					  ##__VA_ARGS__)
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1247  
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1248  /**
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1249   * KUNIT_EXPECT_NE() - An expectation that @left and @right are not equal.
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1250   * @test: The test context object.
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1251   * @left: an arbitrary expression that evaluates to a primitive C type.
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1252   * @right: an arbitrary expression that evaluates to a primitive C type.
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1253   *
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1254   * Sets an expectation that the values that @left and @right evaluate to are not
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1255   * equal. This is semantically equivalent to
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1256   * KUNIT_EXPECT_TRUE(@test, (@left) != (@right)). See KUNIT_EXPECT_TRUE() for
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1257   * more information.
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1258   */
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1259  #define KUNIT_EXPECT_NE(test, left, right) \
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1260  	KUNIT_BINARY_NE_ASSERTION(test, KUNIT_EXPECTATION, left, right)
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1261  
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1262  #define KUNIT_EXPECT_NE_MSG(test, left, right, fmt, ...)		       \
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1263  	KUNIT_BINARY_NE_MSG_ASSERTION(test,				       \
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1264  				      KUNIT_EXPECTATION,		       \
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1265  				      left,				       \
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1266  				      right,				       \
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1267  				      fmt,				       \
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1268  				      ##__VA_ARGS__)
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1269  
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1270  /**
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1271   * KUNIT_EXPECT_PTR_NE() - Expects that pointers @left and @right are not equal.
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1272   * @test: The test context object.
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1273   * @left: an arbitrary expression that evaluates to a pointer.
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1274   * @right: an arbitrary expression that evaluates to a pointer.
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1275   *
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1276   * Sets an expectation that the values that @left and @right evaluate to are not
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1277   * equal. This is semantically equivalent to
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1278   * KUNIT_EXPECT_TRUE(@test, (@left) != (@right)). See KUNIT_EXPECT_TRUE() for
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1279   * more information.
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1280   */
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1281  #define KUNIT_EXPECT_PTR_NE(test, left, right)				       \
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1282  	KUNIT_BINARY_PTR_NE_ASSERTION(test,				       \
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1283  				      KUNIT_EXPECTATION,		       \
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1284  				      left,				       \
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1285  				      right)
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1286  
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1287  #define KUNIT_EXPECT_PTR_NE_MSG(test, left, right, fmt, ...)		       \
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1288  	KUNIT_BINARY_PTR_NE_MSG_ASSERTION(test,				       \
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1289  					  KUNIT_EXPECTATION,		       \
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1290  					  left,				       \
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1291  					  right,			       \
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1292  					  fmt,				       \
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1293  					  ##__VA_ARGS__)
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1294  
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1295  /**
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1296   * KUNIT_EXPECT_LT() - An expectation that @left is less than @right.
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1297   * @test: The test context object.
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1298   * @left: an arbitrary expression that evaluates to a primitive C type.
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1299   * @right: an arbitrary expression that evaluates to a primitive C type.
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1300   *
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1301   * Sets an expectation that the value that @left evaluates to is less than the
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1302   * value that @right evaluates to. This is semantically equivalent to
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1303   * KUNIT_EXPECT_TRUE(@test, (@left) < (@right)). See KUNIT_EXPECT_TRUE() for
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1304   * more information.
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1305   */
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1306  #define KUNIT_EXPECT_LT(test, left, right) \
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1307  	KUNIT_BINARY_LT_ASSERTION(test, KUNIT_EXPECTATION, left, right)
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1308  
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1309  #define KUNIT_EXPECT_LT_MSG(test, left, right, fmt, ...)		       \
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1310  	KUNIT_BINARY_LT_MSG_ASSERTION(test,				       \
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1311  				      KUNIT_EXPECTATION,		       \
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1312  				      left,				       \
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1313  				      right,				       \
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1314  				      fmt,				       \
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1315  				      ##__VA_ARGS__)
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1316  
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1317  /**
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1318   * KUNIT_EXPECT_LE() - Expects that @left is less than or equal to @right.
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1319   * @test: The test context object.
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1320   * @left: an arbitrary expression that evaluates to a primitive C type.
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1321   * @right: an arbitrary expression that evaluates to a primitive C type.
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1322   *
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1323   * Sets an expectation that the value that @left evaluates to is less than or
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1324   * equal to the value that @right evaluates to. Semantically this is equivalent
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1325   * to KUNIT_EXPECT_TRUE(@test, (@left) <= (@right)). See KUNIT_EXPECT_TRUE() for
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1326   * more information.
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1327   */
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1328  #define KUNIT_EXPECT_LE(test, left, right) \
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1329  	KUNIT_BINARY_LE_ASSERTION(test, KUNIT_EXPECTATION, left, right)
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1330  
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1331  #define KUNIT_EXPECT_LE_MSG(test, left, right, fmt, ...)		       \
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1332  	KUNIT_BINARY_LE_MSG_ASSERTION(test,				       \
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1333  				      KUNIT_EXPECTATION,		       \
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1334  				      left,				       \
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1335  				      right,				       \
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1336  				      fmt,				       \
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1337  				      ##__VA_ARGS__)
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1338  
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1339  /**
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1340   * KUNIT_EXPECT_GT() - An expectation that @left is greater than @right.
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1341   * @test: The test context object.
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1342   * @left: an arbitrary expression that evaluates to a primitive C type.
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1343   * @right: an arbitrary expression that evaluates to a primitive C type.
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1344   *
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1345   * Sets an expectation that the value that @left evaluates to is greater than
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1346   * the value that @right evaluates to. This is semantically equivalent to
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1347   * KUNIT_EXPECT_TRUE(@test, (@left) > (@right)). See KUNIT_EXPECT_TRUE() for
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1348   * more information.
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1349   */
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1350  #define KUNIT_EXPECT_GT(test, left, right) \
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1351  	KUNIT_BINARY_GT_ASSERTION(test, KUNIT_EXPECTATION, left, right)
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1352  
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1353  #define KUNIT_EXPECT_GT_MSG(test, left, right, fmt, ...)		       \
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1354  	KUNIT_BINARY_GT_MSG_ASSERTION(test,				       \
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1355  				      KUNIT_EXPECTATION,		       \
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1356  				      left,				       \
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1357  				      right,				       \
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1358  				      fmt,				       \
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1359  				      ##__VA_ARGS__)
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1360  
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1361  /**
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1362   * KUNIT_EXPECT_GE() - Expects that @left is greater than or equal to @right.
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1363   * @test: The test context object.
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1364   * @left: an arbitrary expression that evaluates to a primitive C type.
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1365   * @right: an arbitrary expression that evaluates to a primitive C type.
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1366   *
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1367   * Sets an expectation that the value that @left evaluates to is greater than
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1368   * the value that @right evaluates to. This is semantically equivalent to
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1369   * KUNIT_EXPECT_TRUE(@test, (@left) >= (@right)). See KUNIT_EXPECT_TRUE() for
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1370   * more information.
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1371   */
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1372  #define KUNIT_EXPECT_GE(test, left, right) \
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1373  	KUNIT_BINARY_GE_ASSERTION(test, KUNIT_EXPECTATION, left, right)
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1374  
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1375  #define KUNIT_EXPECT_GE_MSG(test, left, right, fmt, ...)		       \
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1376  	KUNIT_BINARY_GE_MSG_ASSERTION(test,				       \
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1377  				      KUNIT_EXPECTATION,		       \
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1378  				      left,				       \
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1379  				      right,				       \
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1380  				      fmt,				       \
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1381  				      ##__VA_ARGS__)
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1382  
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1383  /**
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1384   * KUNIT_EXPECT_STREQ() - Expects that strings @left and @right are equal.
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1385   * @test: The test context object.
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1386   * @left: an arbitrary expression that evaluates to a null terminated string.
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1387   * @right: an arbitrary expression that evaluates to a null terminated string.
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1388   *
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1389   * Sets an expectation that the values that @left and @right evaluate to are
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1390   * equal. This is semantically equivalent to
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1391   * KUNIT_EXPECT_TRUE(@test, !strcmp((@left), (@right))). See KUNIT_EXPECT_TRUE()
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1392   * for more information.
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1393   */
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1394  #define KUNIT_EXPECT_STREQ(test, left, right) \
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1395  	KUNIT_BINARY_STR_EQ_ASSERTION(test, KUNIT_EXPECTATION, left, right)
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1396  
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1397  #define KUNIT_EXPECT_STREQ_MSG(test, left, right, fmt, ...)		       \
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1398  	KUNIT_BINARY_STR_EQ_MSG_ASSERTION(test,				       \
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1399  					  KUNIT_EXPECTATION,		       \
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1400  					  left,				       \
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1401  					  right,			       \
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1402  					  fmt,				       \
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1403  					  ##__VA_ARGS__)
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1404  
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1405  /**
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1406   * KUNIT_EXPECT_STRNEQ() - Expects that strings @left and @right are not equal.
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1407   * @test: The test context object.
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1408   * @left: an arbitrary expression that evaluates to a null terminated string.
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1409   * @right: an arbitrary expression that evaluates to a null terminated string.
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1410   *
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1411   * Sets an expectation that the values that @left and @right evaluate to are
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1412   * not equal. This is semantically equivalent to
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1413   * KUNIT_EXPECT_TRUE(@test, strcmp((@left), (@right))). See KUNIT_EXPECT_TRUE()
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1414   * for more information.
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1415   */
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1416  #define KUNIT_EXPECT_STRNEQ(test, left, right) \
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1417  	KUNIT_BINARY_STR_NE_ASSERTION(test, KUNIT_EXPECTATION, left, right)
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1418  
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1419  #define KUNIT_EXPECT_STRNEQ_MSG(test, left, right, fmt, ...)		       \
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1420  	KUNIT_BINARY_STR_NE_MSG_ASSERTION(test,				       \
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1421  					  KUNIT_EXPECTATION,		       \
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1422  					  left,				       \
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1423  					  right,			       \
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1424  					  fmt,				       \
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1425  					  ##__VA_ARGS__)
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1426  
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1427  /**
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1428   * KUNIT_EXPECT_NOT_ERR_OR_NULL() - Expects that @ptr is not null and not err.
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1429   * @test: The test context object.
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1430   * @ptr: an arbitrary pointer.
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1431   *
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1432   * Sets an expectation that the value that @ptr evaluates to is not null and not
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1433   * an errno stored in a pointer. This is semantically equivalent to
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1434   * KUNIT_EXPECT_TRUE(@test, !IS_ERR_OR_NULL(@ptr)). See KUNIT_EXPECT_TRUE() for
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1435   * more information.
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1436   */
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1437  #define KUNIT_EXPECT_NOT_ERR_OR_NULL(test, ptr) \
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1438  	KUNIT_PTR_NOT_ERR_OR_NULL_ASSERTION(test, KUNIT_EXPECTATION, ptr)
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1439  
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1440  #define KUNIT_EXPECT_NOT_ERR_OR_NULL_MSG(test, ptr, fmt, ...)		       \
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1441  	KUNIT_PTR_NOT_ERR_OR_NULL_MSG_ASSERTION(test,			       \
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1442  						KUNIT_EXPECTATION,	       \
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1443  						ptr,			       \
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1444  						fmt,			       \
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1445  						##__VA_ARGS__)
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1446  
e4aea8f8532b55 Brendan Higgins     2019-09-23  1447  #define KUNIT_ASSERT_FAILURE(test, fmt, ...) \
e4aea8f8532b55 Brendan Higgins     2019-09-23  1448  	KUNIT_FAIL_ASSERTION(test, KUNIT_ASSERTION, fmt, ##__VA_ARGS__)
e4aea8f8532b55 Brendan Higgins     2019-09-23  1449  
e4aea8f8532b55 Brendan Higgins     2019-09-23  1450  /**
e4aea8f8532b55 Brendan Higgins     2019-09-23  1451   * KUNIT_ASSERT_TRUE() - Sets an assertion that @condition is true.
e4aea8f8532b55 Brendan Higgins     2019-09-23  1452   * @test: The test context object.
e4aea8f8532b55 Brendan Higgins     2019-09-23  1453   * @condition: an arbitrary boolean expression. The test fails and aborts when
e4aea8f8532b55 Brendan Higgins     2019-09-23  1454   * this does not evaluate to true.
e4aea8f8532b55 Brendan Higgins     2019-09-23  1455   *
e4aea8f8532b55 Brendan Higgins     2019-09-23  1456   * This and assertions of the form `KUNIT_ASSERT_*` will cause the test case to
e4aea8f8532b55 Brendan Higgins     2019-09-23  1457   * fail *and immediately abort* when the specified condition is not met. Unlike
e4aea8f8532b55 Brendan Higgins     2019-09-23  1458   * an expectation failure, it will prevent the test case from continuing to run;
e4aea8f8532b55 Brendan Higgins     2019-09-23  1459   * this is otherwise known as an *assertion failure*.
e4aea8f8532b55 Brendan Higgins     2019-09-23  1460   */
e4aea8f8532b55 Brendan Higgins     2019-09-23  1461  #define KUNIT_ASSERT_TRUE(test, condition) \
e4aea8f8532b55 Brendan Higgins     2019-09-23  1462  	KUNIT_TRUE_ASSERTION(test, KUNIT_ASSERTION, condition)
e4aea8f8532b55 Brendan Higgins     2019-09-23  1463  
e4aea8f8532b55 Brendan Higgins     2019-09-23  1464  #define KUNIT_ASSERT_TRUE_MSG(test, condition, fmt, ...)		       \
e4aea8f8532b55 Brendan Higgins     2019-09-23  1465  	KUNIT_TRUE_MSG_ASSERTION(test,					       \
e4aea8f8532b55 Brendan Higgins     2019-09-23  1466  				 KUNIT_ASSERTION,			       \
e4aea8f8532b55 Brendan Higgins     2019-09-23  1467  				 condition,				       \
e4aea8f8532b55 Brendan Higgins     2019-09-23  1468  				 fmt,					       \
e4aea8f8532b55 Brendan Higgins     2019-09-23  1469  				 ##__VA_ARGS__)
e4aea8f8532b55 Brendan Higgins     2019-09-23  1470  
e4aea8f8532b55 Brendan Higgins     2019-09-23  1471  /**
e4aea8f8532b55 Brendan Higgins     2019-09-23  1472   * KUNIT_ASSERT_FALSE() - Sets an assertion that @condition is false.
e4aea8f8532b55 Brendan Higgins     2019-09-23  1473   * @test: The test context object.
e4aea8f8532b55 Brendan Higgins     2019-09-23  1474   * @condition: an arbitrary boolean expression.
e4aea8f8532b55 Brendan Higgins     2019-09-23  1475   *
e4aea8f8532b55 Brendan Higgins     2019-09-23  1476   * Sets an assertion that the value that @condition evaluates to is false. This
e4aea8f8532b55 Brendan Higgins     2019-09-23  1477   * is the same as KUNIT_EXPECT_FALSE(), except it causes an assertion failure
e4aea8f8532b55 Brendan Higgins     2019-09-23  1478   * (see KUNIT_ASSERT_TRUE()) when the assertion is not met.
e4aea8f8532b55 Brendan Higgins     2019-09-23  1479   */
e4aea8f8532b55 Brendan Higgins     2019-09-23  1480  #define KUNIT_ASSERT_FALSE(test, condition) \
e4aea8f8532b55 Brendan Higgins     2019-09-23  1481  	KUNIT_FALSE_ASSERTION(test, KUNIT_ASSERTION, condition)
e4aea8f8532b55 Brendan Higgins     2019-09-23  1482  
e4aea8f8532b55 Brendan Higgins     2019-09-23  1483  #define KUNIT_ASSERT_FALSE_MSG(test, condition, fmt, ...)		       \
e4aea8f8532b55 Brendan Higgins     2019-09-23  1484  	KUNIT_FALSE_MSG_ASSERTION(test,					       \
e4aea8f8532b55 Brendan Higgins     2019-09-23  1485  				  KUNIT_ASSERTION,			       \
e4aea8f8532b55 Brendan Higgins     2019-09-23  1486  				  condition,				       \
e4aea8f8532b55 Brendan Higgins     2019-09-23  1487  				  fmt,					       \
e4aea8f8532b55 Brendan Higgins     2019-09-23  1488  				  ##__VA_ARGS__)
e4aea8f8532b55 Brendan Higgins     2019-09-23  1489  
e4aea8f8532b55 Brendan Higgins     2019-09-23  1490  /**
e4aea8f8532b55 Brendan Higgins     2019-09-23  1491   * KUNIT_ASSERT_EQ() - Sets an assertion that @left and @right are equal.
e4aea8f8532b55 Brendan Higgins     2019-09-23  1492   * @test: The test context object.
e4aea8f8532b55 Brendan Higgins     2019-09-23  1493   * @left: an arbitrary expression that evaluates to a primitive C type.
e4aea8f8532b55 Brendan Higgins     2019-09-23  1494   * @right: an arbitrary expression that evaluates to a primitive C type.
e4aea8f8532b55 Brendan Higgins     2019-09-23  1495   *
e4aea8f8532b55 Brendan Higgins     2019-09-23  1496   * Sets an assertion that the values that @left and @right evaluate to are
e4aea8f8532b55 Brendan Higgins     2019-09-23  1497   * equal. This is the same as KUNIT_EXPECT_EQ(), except it causes an assertion
e4aea8f8532b55 Brendan Higgins     2019-09-23  1498   * failure (see KUNIT_ASSERT_TRUE()) when the assertion is not met.
e4aea8f8532b55 Brendan Higgins     2019-09-23  1499   */
e4aea8f8532b55 Brendan Higgins     2019-09-23  1500  #define KUNIT_ASSERT_EQ(test, left, right) \
e4aea8f8532b55 Brendan Higgins     2019-09-23  1501  	KUNIT_BINARY_EQ_ASSERTION(test, KUNIT_ASSERTION, left, right)
e4aea8f8532b55 Brendan Higgins     2019-09-23  1502  
e4aea8f8532b55 Brendan Higgins     2019-09-23  1503  #define KUNIT_ASSERT_EQ_MSG(test, left, right, fmt, ...)		       \
e4aea8f8532b55 Brendan Higgins     2019-09-23  1504  	KUNIT_BINARY_EQ_MSG_ASSERTION(test,				       \
e4aea8f8532b55 Brendan Higgins     2019-09-23  1505  				      KUNIT_ASSERTION,			       \
e4aea8f8532b55 Brendan Higgins     2019-09-23  1506  				      left,				       \
e4aea8f8532b55 Brendan Higgins     2019-09-23  1507  				      right,				       \
e4aea8f8532b55 Brendan Higgins     2019-09-23  1508  				      fmt,				       \
e4aea8f8532b55 Brendan Higgins     2019-09-23  1509  				      ##__VA_ARGS__)
e4aea8f8532b55 Brendan Higgins     2019-09-23  1510  
e4aea8f8532b55 Brendan Higgins     2019-09-23  1511  /**
e4aea8f8532b55 Brendan Higgins     2019-09-23  1512   * KUNIT_ASSERT_PTR_EQ() - Asserts that pointers @left and @right are equal.
e4aea8f8532b55 Brendan Higgins     2019-09-23  1513   * @test: The test context object.
e4aea8f8532b55 Brendan Higgins     2019-09-23  1514   * @left: an arbitrary expression that evaluates to a pointer.
e4aea8f8532b55 Brendan Higgins     2019-09-23  1515   * @right: an arbitrary expression that evaluates to a pointer.
e4aea8f8532b55 Brendan Higgins     2019-09-23  1516   *
e4aea8f8532b55 Brendan Higgins     2019-09-23  1517   * Sets an assertion that the values that @left and @right evaluate to are
e4aea8f8532b55 Brendan Higgins     2019-09-23  1518   * equal. This is the same as KUNIT_EXPECT_EQ(), except it causes an assertion
e4aea8f8532b55 Brendan Higgins     2019-09-23  1519   * failure (see KUNIT_ASSERT_TRUE()) when the assertion is not met.
e4aea8f8532b55 Brendan Higgins     2019-09-23  1520   */
e4aea8f8532b55 Brendan Higgins     2019-09-23  1521  #define KUNIT_ASSERT_PTR_EQ(test, left, right) \
e4aea8f8532b55 Brendan Higgins     2019-09-23  1522  	KUNIT_BINARY_PTR_EQ_ASSERTION(test, KUNIT_ASSERTION, left, right)
e4aea8f8532b55 Brendan Higgins     2019-09-23  1523  
e4aea8f8532b55 Brendan Higgins     2019-09-23  1524  #define KUNIT_ASSERT_PTR_EQ_MSG(test, left, right, fmt, ...)		       \
e4aea8f8532b55 Brendan Higgins     2019-09-23  1525  	KUNIT_BINARY_PTR_EQ_MSG_ASSERTION(test,				       \
e4aea8f8532b55 Brendan Higgins     2019-09-23  1526  					  KUNIT_ASSERTION,		       \
e4aea8f8532b55 Brendan Higgins     2019-09-23  1527  					  left,				       \
e4aea8f8532b55 Brendan Higgins     2019-09-23  1528  					  right,			       \
e4aea8f8532b55 Brendan Higgins     2019-09-23  1529  					  fmt,				       \
e4aea8f8532b55 Brendan Higgins     2019-09-23  1530  					  ##__VA_ARGS__)
e4aea8f8532b55 Brendan Higgins     2019-09-23  1531  
e4aea8f8532b55 Brendan Higgins     2019-09-23  1532  /**
e4aea8f8532b55 Brendan Higgins     2019-09-23  1533   * KUNIT_ASSERT_NE() - An assertion that @left and @right are not equal.
e4aea8f8532b55 Brendan Higgins     2019-09-23  1534   * @test: The test context object.
e4aea8f8532b55 Brendan Higgins     2019-09-23  1535   * @left: an arbitrary expression that evaluates to a primitive C type.
e4aea8f8532b55 Brendan Higgins     2019-09-23  1536   * @right: an arbitrary expression that evaluates to a primitive C type.
e4aea8f8532b55 Brendan Higgins     2019-09-23  1537   *
e4aea8f8532b55 Brendan Higgins     2019-09-23  1538   * Sets an assertion that the values that @left and @right evaluate to are not
e4aea8f8532b55 Brendan Higgins     2019-09-23  1539   * equal. This is the same as KUNIT_EXPECT_NE(), except it causes an assertion
e4aea8f8532b55 Brendan Higgins     2019-09-23  1540   * failure (see KUNIT_ASSERT_TRUE()) when the assertion is not met.
e4aea8f8532b55 Brendan Higgins     2019-09-23  1541   */
e4aea8f8532b55 Brendan Higgins     2019-09-23  1542  #define KUNIT_ASSERT_NE(test, left, right) \
e4aea8f8532b55 Brendan Higgins     2019-09-23  1543  	KUNIT_BINARY_NE_ASSERTION(test, KUNIT_ASSERTION, left, right)
e4aea8f8532b55 Brendan Higgins     2019-09-23  1544  
e4aea8f8532b55 Brendan Higgins     2019-09-23  1545  #define KUNIT_ASSERT_NE_MSG(test, left, right, fmt, ...)		       \
e4aea8f8532b55 Brendan Higgins     2019-09-23  1546  	KUNIT_BINARY_NE_MSG_ASSERTION(test,				       \
e4aea8f8532b55 Brendan Higgins     2019-09-23  1547  				      KUNIT_ASSERTION,			       \
e4aea8f8532b55 Brendan Higgins     2019-09-23  1548  				      left,				       \
e4aea8f8532b55 Brendan Higgins     2019-09-23  1549  				      right,				       \
e4aea8f8532b55 Brendan Higgins     2019-09-23  1550  				      fmt,				       \
e4aea8f8532b55 Brendan Higgins     2019-09-23  1551  				      ##__VA_ARGS__)
e4aea8f8532b55 Brendan Higgins     2019-09-23  1552  
e4aea8f8532b55 Brendan Higgins     2019-09-23  1553  /**
e4aea8f8532b55 Brendan Higgins     2019-09-23  1554   * KUNIT_ASSERT_PTR_NE() - Asserts that pointers @left and @right are not equal.
e4aea8f8532b55 Brendan Higgins     2019-09-23  1555   * KUNIT_ASSERT_PTR_EQ() - Asserts that pointers @left and @right are equal.
e4aea8f8532b55 Brendan Higgins     2019-09-23  1556   * @test: The test context object.
e4aea8f8532b55 Brendan Higgins     2019-09-23  1557   * @left: an arbitrary expression that evaluates to a pointer.
e4aea8f8532b55 Brendan Higgins     2019-09-23  1558   * @right: an arbitrary expression that evaluates to a pointer.
e4aea8f8532b55 Brendan Higgins     2019-09-23  1559   *
e4aea8f8532b55 Brendan Higgins     2019-09-23  1560   * Sets an assertion that the values that @left and @right evaluate to are not
e4aea8f8532b55 Brendan Higgins     2019-09-23  1561   * equal. This is the same as KUNIT_EXPECT_NE(), except it causes an assertion
e4aea8f8532b55 Brendan Higgins     2019-09-23  1562   * failure (see KUNIT_ASSERT_TRUE()) when the assertion is not met.
e4aea8f8532b55 Brendan Higgins     2019-09-23  1563   */
e4aea8f8532b55 Brendan Higgins     2019-09-23  1564  #define KUNIT_ASSERT_PTR_NE(test, left, right) \
e4aea8f8532b55 Brendan Higgins     2019-09-23  1565  	KUNIT_BINARY_PTR_NE_ASSERTION(test, KUNIT_ASSERTION, left, right)
e4aea8f8532b55 Brendan Higgins     2019-09-23  1566  
e4aea8f8532b55 Brendan Higgins     2019-09-23  1567  #define KUNIT_ASSERT_PTR_NE_MSG(test, left, right, fmt, ...)		       \
e4aea8f8532b55 Brendan Higgins     2019-09-23  1568  	KUNIT_BINARY_PTR_NE_MSG_ASSERTION(test,				       \
e4aea8f8532b55 Brendan Higgins     2019-09-23  1569  					  KUNIT_ASSERTION,		       \
e4aea8f8532b55 Brendan Higgins     2019-09-23  1570  					  left,				       \
e4aea8f8532b55 Brendan Higgins     2019-09-23  1571  					  right,			       \
e4aea8f8532b55 Brendan Higgins     2019-09-23  1572  					  fmt,				       \
e4aea8f8532b55 Brendan Higgins     2019-09-23  1573  					  ##__VA_ARGS__)
e4aea8f8532b55 Brendan Higgins     2019-09-23  1574  /**
e4aea8f8532b55 Brendan Higgins     2019-09-23  1575   * KUNIT_ASSERT_LT() - An assertion that @left is less than @right.
e4aea8f8532b55 Brendan Higgins     2019-09-23  1576   * @test: The test context object.
e4aea8f8532b55 Brendan Higgins     2019-09-23  1577   * @left: an arbitrary expression that evaluates to a primitive C type.
e4aea8f8532b55 Brendan Higgins     2019-09-23  1578   * @right: an arbitrary expression that evaluates to a primitive C type.
e4aea8f8532b55 Brendan Higgins     2019-09-23  1579   *
e4aea8f8532b55 Brendan Higgins     2019-09-23  1580   * Sets an assertion that the value that @left evaluates to is less than the
e4aea8f8532b55 Brendan Higgins     2019-09-23  1581   * value that @right evaluates to. This is the same as KUNIT_EXPECT_LT(), except
e4aea8f8532b55 Brendan Higgins     2019-09-23  1582   * it causes an assertion failure (see KUNIT_ASSERT_TRUE()) when the assertion
e4aea8f8532b55 Brendan Higgins     2019-09-23  1583   * is not met.
e4aea8f8532b55 Brendan Higgins     2019-09-23  1584   */
e4aea8f8532b55 Brendan Higgins     2019-09-23  1585  #define KUNIT_ASSERT_LT(test, left, right) \
e4aea8f8532b55 Brendan Higgins     2019-09-23  1586  	KUNIT_BINARY_LT_ASSERTION(test, KUNIT_ASSERTION, left, right)
e4aea8f8532b55 Brendan Higgins     2019-09-23  1587  
e4aea8f8532b55 Brendan Higgins     2019-09-23  1588  #define KUNIT_ASSERT_LT_MSG(test, left, right, fmt, ...)		       \
e4aea8f8532b55 Brendan Higgins     2019-09-23  1589  	KUNIT_BINARY_LT_MSG_ASSERTION(test,				       \
e4aea8f8532b55 Brendan Higgins     2019-09-23  1590  				      KUNIT_ASSERTION,			       \
e4aea8f8532b55 Brendan Higgins     2019-09-23  1591  				      left,				       \
e4aea8f8532b55 Brendan Higgins     2019-09-23  1592  				      right,				       \
e4aea8f8532b55 Brendan Higgins     2019-09-23  1593  				      fmt,				       \
e4aea8f8532b55 Brendan Higgins     2019-09-23  1594  				      ##__VA_ARGS__)
e4aea8f8532b55 Brendan Higgins     2019-09-23  1595  /**
e4aea8f8532b55 Brendan Higgins     2019-09-23  1596   * KUNIT_ASSERT_LE() - An assertion that @left is less than or equal to @right.
e4aea8f8532b55 Brendan Higgins     2019-09-23  1597   * @test: The test context object.
e4aea8f8532b55 Brendan Higgins     2019-09-23  1598   * @left: an arbitrary expression that evaluates to a primitive C type.
e4aea8f8532b55 Brendan Higgins     2019-09-23  1599   * @right: an arbitrary expression that evaluates to a primitive C type.
e4aea8f8532b55 Brendan Higgins     2019-09-23  1600   *
e4aea8f8532b55 Brendan Higgins     2019-09-23  1601   * Sets an assertion that the value that @left evaluates to is less than or
e4aea8f8532b55 Brendan Higgins     2019-09-23  1602   * equal to the value that @right evaluates to. This is the same as
e4aea8f8532b55 Brendan Higgins     2019-09-23  1603   * KUNIT_EXPECT_LE(), except it causes an assertion failure (see
e4aea8f8532b55 Brendan Higgins     2019-09-23  1604   * KUNIT_ASSERT_TRUE()) when the assertion is not met.
e4aea8f8532b55 Brendan Higgins     2019-09-23  1605   */
e4aea8f8532b55 Brendan Higgins     2019-09-23  1606  #define KUNIT_ASSERT_LE(test, left, right) \
e4aea8f8532b55 Brendan Higgins     2019-09-23  1607  	KUNIT_BINARY_LE_ASSERTION(test, KUNIT_ASSERTION, left, right)
e4aea8f8532b55 Brendan Higgins     2019-09-23  1608  
e4aea8f8532b55 Brendan Higgins     2019-09-23  1609  #define KUNIT_ASSERT_LE_MSG(test, left, right, fmt, ...)		       \
e4aea8f8532b55 Brendan Higgins     2019-09-23  1610  	KUNIT_BINARY_LE_MSG_ASSERTION(test,				       \
e4aea8f8532b55 Brendan Higgins     2019-09-23  1611  				      KUNIT_ASSERTION,			       \
e4aea8f8532b55 Brendan Higgins     2019-09-23  1612  				      left,				       \
e4aea8f8532b55 Brendan Higgins     2019-09-23  1613  				      right,				       \
e4aea8f8532b55 Brendan Higgins     2019-09-23  1614  				      fmt,				       \
e4aea8f8532b55 Brendan Higgins     2019-09-23  1615  				      ##__VA_ARGS__)
e4aea8f8532b55 Brendan Higgins     2019-09-23  1616  
e4aea8f8532b55 Brendan Higgins     2019-09-23  1617  /**
e4aea8f8532b55 Brendan Higgins     2019-09-23  1618   * KUNIT_ASSERT_GT() - An assertion that @left is greater than @right.
e4aea8f8532b55 Brendan Higgins     2019-09-23  1619   * @test: The test context object.
e4aea8f8532b55 Brendan Higgins     2019-09-23  1620   * @left: an arbitrary expression that evaluates to a primitive C type.
e4aea8f8532b55 Brendan Higgins     2019-09-23  1621   * @right: an arbitrary expression that evaluates to a primitive C type.
e4aea8f8532b55 Brendan Higgins     2019-09-23  1622   *
e4aea8f8532b55 Brendan Higgins     2019-09-23  1623   * Sets an assertion that the value that @left evaluates to is greater than the
e4aea8f8532b55 Brendan Higgins     2019-09-23  1624   * value that @right evaluates to. This is the same as KUNIT_EXPECT_GT(), except
e4aea8f8532b55 Brendan Higgins     2019-09-23  1625   * it causes an assertion failure (see KUNIT_ASSERT_TRUE()) when the assertion
e4aea8f8532b55 Brendan Higgins     2019-09-23  1626   * is not met.
e4aea8f8532b55 Brendan Higgins     2019-09-23  1627   */
e4aea8f8532b55 Brendan Higgins     2019-09-23  1628  #define KUNIT_ASSERT_GT(test, left, right) \
e4aea8f8532b55 Brendan Higgins     2019-09-23  1629  	KUNIT_BINARY_GT_ASSERTION(test, KUNIT_ASSERTION, left, right)
e4aea8f8532b55 Brendan Higgins     2019-09-23  1630  
e4aea8f8532b55 Brendan Higgins     2019-09-23  1631  #define KUNIT_ASSERT_GT_MSG(test, left, right, fmt, ...)		       \
e4aea8f8532b55 Brendan Higgins     2019-09-23  1632  	KUNIT_BINARY_GT_MSG_ASSERTION(test,				       \
e4aea8f8532b55 Brendan Higgins     2019-09-23  1633  				      KUNIT_ASSERTION,			       \
e4aea8f8532b55 Brendan Higgins     2019-09-23  1634  				      left,				       \
e4aea8f8532b55 Brendan Higgins     2019-09-23  1635  				      right,				       \
e4aea8f8532b55 Brendan Higgins     2019-09-23  1636  				      fmt,				       \
e4aea8f8532b55 Brendan Higgins     2019-09-23  1637  				      ##__VA_ARGS__)
e4aea8f8532b55 Brendan Higgins     2019-09-23  1638  
e4aea8f8532b55 Brendan Higgins     2019-09-23  1639  /**
e4aea8f8532b55 Brendan Higgins     2019-09-23  1640   * KUNIT_ASSERT_GE() - Assertion that @left is greater than or equal to @right.
e4aea8f8532b55 Brendan Higgins     2019-09-23  1641   * @test: The test context object.
e4aea8f8532b55 Brendan Higgins     2019-09-23  1642   * @left: an arbitrary expression that evaluates to a primitive C type.
e4aea8f8532b55 Brendan Higgins     2019-09-23  1643   * @right: an arbitrary expression that evaluates to a primitive C type.
e4aea8f8532b55 Brendan Higgins     2019-09-23  1644   *
e4aea8f8532b55 Brendan Higgins     2019-09-23  1645   * Sets an assertion that the value that @left evaluates to is greater than the
e4aea8f8532b55 Brendan Higgins     2019-09-23  1646   * value that @right evaluates to. This is the same as KUNIT_EXPECT_GE(), except
e4aea8f8532b55 Brendan Higgins     2019-09-23  1647   * it causes an assertion failure (see KUNIT_ASSERT_TRUE()) when the assertion
e4aea8f8532b55 Brendan Higgins     2019-09-23  1648   * is not met.
e4aea8f8532b55 Brendan Higgins     2019-09-23  1649   */
e4aea8f8532b55 Brendan Higgins     2019-09-23  1650  #define KUNIT_ASSERT_GE(test, left, right) \
e4aea8f8532b55 Brendan Higgins     2019-09-23  1651  	KUNIT_BINARY_GE_ASSERTION(test, KUNIT_ASSERTION, left, right)
e4aea8f8532b55 Brendan Higgins     2019-09-23  1652  
e4aea8f8532b55 Brendan Higgins     2019-09-23  1653  #define KUNIT_ASSERT_GE_MSG(test, left, right, fmt, ...)		       \
e4aea8f8532b55 Brendan Higgins     2019-09-23  1654  	KUNIT_BINARY_GE_MSG_ASSERTION(test,				       \
e4aea8f8532b55 Brendan Higgins     2019-09-23  1655  				      KUNIT_ASSERTION,			       \
e4aea8f8532b55 Brendan Higgins     2019-09-23  1656  				      left,				       \
e4aea8f8532b55 Brendan Higgins     2019-09-23  1657  				      right,				       \
e4aea8f8532b55 Brendan Higgins     2019-09-23  1658  				      fmt,				       \
e4aea8f8532b55 Brendan Higgins     2019-09-23  1659  				      ##__VA_ARGS__)
e4aea8f8532b55 Brendan Higgins     2019-09-23  1660  
e4aea8f8532b55 Brendan Higgins     2019-09-23  1661  /**
e4aea8f8532b55 Brendan Higgins     2019-09-23  1662   * KUNIT_ASSERT_STREQ() - An assertion that strings @left and @right are equal.
e4aea8f8532b55 Brendan Higgins     2019-09-23  1663   * @test: The test context object.
e4aea8f8532b55 Brendan Higgins     2019-09-23  1664   * @left: an arbitrary expression that evaluates to a null terminated string.
e4aea8f8532b55 Brendan Higgins     2019-09-23  1665   * @right: an arbitrary expression that evaluates to a null terminated string.
e4aea8f8532b55 Brendan Higgins     2019-09-23  1666   *
e4aea8f8532b55 Brendan Higgins     2019-09-23  1667   * Sets an assertion that the values that @left and @right evaluate to are
e4aea8f8532b55 Brendan Higgins     2019-09-23  1668   * equal. This is the same as KUNIT_EXPECT_STREQ(), except it causes an
e4aea8f8532b55 Brendan Higgins     2019-09-23  1669   * assertion failure (see KUNIT_ASSERT_TRUE()) when the assertion is not met.
e4aea8f8532b55 Brendan Higgins     2019-09-23  1670   */
e4aea8f8532b55 Brendan Higgins     2019-09-23  1671  #define KUNIT_ASSERT_STREQ(test, left, right) \
e4aea8f8532b55 Brendan Higgins     2019-09-23  1672  	KUNIT_BINARY_STR_EQ_ASSERTION(test, KUNIT_ASSERTION, left, right)
e4aea8f8532b55 Brendan Higgins     2019-09-23  1673  
e4aea8f8532b55 Brendan Higgins     2019-09-23  1674  #define KUNIT_ASSERT_STREQ_MSG(test, left, right, fmt, ...)		       \
e4aea8f8532b55 Brendan Higgins     2019-09-23  1675  	KUNIT_BINARY_STR_EQ_MSG_ASSERTION(test,				       \
e4aea8f8532b55 Brendan Higgins     2019-09-23  1676  					  KUNIT_ASSERTION,		       \
e4aea8f8532b55 Brendan Higgins     2019-09-23  1677  					  left,				       \
e4aea8f8532b55 Brendan Higgins     2019-09-23  1678  					  right,			       \
e4aea8f8532b55 Brendan Higgins     2019-09-23  1679  					  fmt,				       \
e4aea8f8532b55 Brendan Higgins     2019-09-23  1680  					  ##__VA_ARGS__)
e4aea8f8532b55 Brendan Higgins     2019-09-23  1681  
e4aea8f8532b55 Brendan Higgins     2019-09-23  1682  /**
e4aea8f8532b55 Brendan Higgins     2019-09-23  1683   * KUNIT_ASSERT_STRNEQ() - Expects that strings @left and @right are not equal.
e4aea8f8532b55 Brendan Higgins     2019-09-23  1684   * @test: The test context object.
e4aea8f8532b55 Brendan Higgins     2019-09-23  1685   * @left: an arbitrary expression that evaluates to a null terminated string.
e4aea8f8532b55 Brendan Higgins     2019-09-23  1686   * @right: an arbitrary expression that evaluates to a null terminated string.
e4aea8f8532b55 Brendan Higgins     2019-09-23  1687   *
e4aea8f8532b55 Brendan Higgins     2019-09-23  1688   * Sets an expectation that the values that @left and @right evaluate to are
e4aea8f8532b55 Brendan Higgins     2019-09-23  1689   * not equal. This is semantically equivalent to
e4aea8f8532b55 Brendan Higgins     2019-09-23  1690   * KUNIT_ASSERT_TRUE(@test, strcmp((@left), (@right))). See KUNIT_ASSERT_TRUE()
e4aea8f8532b55 Brendan Higgins     2019-09-23  1691   * for more information.
e4aea8f8532b55 Brendan Higgins     2019-09-23  1692   */
e4aea8f8532b55 Brendan Higgins     2019-09-23  1693  #define KUNIT_ASSERT_STRNEQ(test, left, right) \
e4aea8f8532b55 Brendan Higgins     2019-09-23  1694  	KUNIT_BINARY_STR_NE_ASSERTION(test, KUNIT_ASSERTION, left, right)
e4aea8f8532b55 Brendan Higgins     2019-09-23  1695  
e4aea8f8532b55 Brendan Higgins     2019-09-23  1696  #define KUNIT_ASSERT_STRNEQ_MSG(test, left, right, fmt, ...)		       \
e4aea8f8532b55 Brendan Higgins     2019-09-23  1697  	KUNIT_BINARY_STR_NE_MSG_ASSERTION(test,				       \
e4aea8f8532b55 Brendan Higgins     2019-09-23  1698  					  KUNIT_ASSERTION,		       \
e4aea8f8532b55 Brendan Higgins     2019-09-23  1699  					  left,				       \
e4aea8f8532b55 Brendan Higgins     2019-09-23  1700  					  right,			       \
e4aea8f8532b55 Brendan Higgins     2019-09-23  1701  					  fmt,				       \
e4aea8f8532b55 Brendan Higgins     2019-09-23  1702  					  ##__VA_ARGS__)
e4aea8f8532b55 Brendan Higgins     2019-09-23  1703  
e4aea8f8532b55 Brendan Higgins     2019-09-23  1704  /**
e4aea8f8532b55 Brendan Higgins     2019-09-23  1705   * KUNIT_ASSERT_NOT_ERR_OR_NULL() - Assertion that @ptr is not null and not err.
e4aea8f8532b55 Brendan Higgins     2019-09-23  1706   * @test: The test context object.
e4aea8f8532b55 Brendan Higgins     2019-09-23  1707   * @ptr: an arbitrary pointer.
e4aea8f8532b55 Brendan Higgins     2019-09-23  1708   *
e4aea8f8532b55 Brendan Higgins     2019-09-23  1709   * Sets an assertion that the value that @ptr evaluates to is not null and not
e4aea8f8532b55 Brendan Higgins     2019-09-23  1710   * an errno stored in a pointer. This is the same as
e4aea8f8532b55 Brendan Higgins     2019-09-23  1711   * KUNIT_EXPECT_NOT_ERR_OR_NULL(), except it causes an assertion failure (see
e4aea8f8532b55 Brendan Higgins     2019-09-23  1712   * KUNIT_ASSERT_TRUE()) when the assertion is not met.
e4aea8f8532b55 Brendan Higgins     2019-09-23  1713   */
e4aea8f8532b55 Brendan Higgins     2019-09-23  1714  #define KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ptr) \
e4aea8f8532b55 Brendan Higgins     2019-09-23  1715  	KUNIT_PTR_NOT_ERR_OR_NULL_ASSERTION(test, KUNIT_ASSERTION, ptr)
e4aea8f8532b55 Brendan Higgins     2019-09-23  1716  
e4aea8f8532b55 Brendan Higgins     2019-09-23  1717  #define KUNIT_ASSERT_NOT_ERR_OR_NULL_MSG(test, ptr, fmt, ...)		       \
e4aea8f8532b55 Brendan Higgins     2019-09-23  1718  	KUNIT_PTR_NOT_ERR_OR_NULL_MSG_ASSERTION(test,			       \
e4aea8f8532b55 Brendan Higgins     2019-09-23  1719  						KUNIT_ASSERTION,	       \
e4aea8f8532b55 Brendan Higgins     2019-09-23  1720  						ptr,			       \
e4aea8f8532b55 Brendan Higgins     2019-09-23  1721  						fmt,			       \
e4aea8f8532b55 Brendan Higgins     2019-09-23  1722  						##__VA_ARGS__)
e4aea8f8532b55 Brendan Higgins     2019-09-23  1723  
ae68283f3e666a Arpitha Raghunandan 2020-10-27  1724  /**
ae68283f3e666a Arpitha Raghunandan 2020-10-27  1725   * KUNIT_ARRAY_PARAM() - Helper method for test parameter generators
ae68283f3e666a Arpitha Raghunandan 2020-10-27  1726   * 			 required in parameterized tests.
ae68283f3e666a Arpitha Raghunandan 2020-10-27  1727   * @name:  prefix of the name for the test parameter generator function.
ae68283f3e666a Arpitha Raghunandan 2020-10-27  1728   *	   It will be suffixed by "_gen_params".
ae68283f3e666a Arpitha Raghunandan 2020-10-27  1729   * @array: a user-supplied pointer to an array of test parameters.
ae68283f3e666a Arpitha Raghunandan 2020-10-27  1730   */
ae68283f3e666a Arpitha Raghunandan 2020-10-27  1731  #define KUNIT_ARRAY_PARAM(name, array)								\
ae68283f3e666a Arpitha Raghunandan 2020-10-27  1732  	static void *name##_gen_params(void *prev)						\
ae68283f3e666a Arpitha Raghunandan 2020-10-27  1733  	{											\
ae68283f3e666a Arpitha Raghunandan 2020-10-27  1734  		typeof((array)[0]) * __next = prev ? ((typeof(__next)) prev) + 1 : (array);	\
ae68283f3e666a Arpitha Raghunandan 2020-10-27 @1735  		return __next - (array) < ARRAY_SIZE((array)) ? __next : NULL;			\
ae68283f3e666a Arpitha Raghunandan 2020-10-27  1736  	}
ae68283f3e666a Arpitha Raghunandan 2020-10-27  1737  

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--dDRMvlgZJXvWKvBx
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
819et5HYoPEBAA==

--dDRMvlgZJXvWKvBx--
