Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F4AE6AB1A1
	for <lists+linux-kselftest@lfdr.de>; Sun,  5 Mar 2023 19:00:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229668AbjCESAo (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 5 Mar 2023 13:00:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbjCESAn (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 5 Mar 2023 13:00:43 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC94CD518;
        Sun,  5 Mar 2023 10:00:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678039241; x=1709575241;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=QE6+X0t0qr1Xce3NWsaYovK34zD80dqy8fScs/jetB4=;
  b=dPb6NbPlfRb/dGXA2IfYKZT0EDO2Gq9/89/TI5oki8pdnXLtGA0hG+aJ
   y3d3qPtJG0Vl4nDyZuqZwISp402KoO7HzdKTO65RhoDDzgc6nv9k97Lof
   h09ZwfGbuTcXKB9cc9CosJPmtu4wWCSNdi8QIvaQv5dTH8F8HbbrhYRsw
   FIMCafMKIdtZJ1TbTrWLOnx2Lycx+sK8WvAS9cOZOFysSp/PBvUaUFhXN
   cTsTASgxGYBI2z/DfhXa35HW+Y/9apFIcWlRGgx9nnL6Of3ipskd/baTg
   t5VKVADNpZlWZMt+gq4mamlABLerrSZln6yT9bq+rwDXfjryixMpgIuJy
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10640"; a="421681526"
X-IronPort-AV: E=Sophos;i="5.98,236,1673942400"; 
   d="scan'208";a="421681526"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2023 10:00:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10640"; a="675928398"
X-IronPort-AV: E=Sophos;i="5.98,236,1673942400"; 
   d="scan'208";a="675928398"
Received: from lkp-server01.sh.intel.com (HELO 776573491cc5) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 05 Mar 2023 10:00:36 -0800
Received: from kbuild by 776573491cc5 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pYsey-0002x0-0Q;
        Sun, 05 Mar 2023 18:00:36 +0000
Date:   Mon, 6 Mar 2023 02:00:31 +0800
From:   kernel test robot <lkp@intel.com>
To:     Xu Kuohai <xukuohai@huaweicloud.com>, bpf@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Mykola Lysenko <mykolal@fb.com>,
        Shuah Khan <skhan@linuxfoundation.org>
Subject: Re: [PATCH bpf-next 1/2] bpf: add bound tracking for BPF_MOD
Message-ID: <202303060155.cNDEo1Br-lkp@intel.com>
References: <20230306033119.2634976-2-xukuohai@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230306033119.2634976-2-xukuohai@huaweicloud.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Xu,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on bpf-next/master]

url:    https://github.com/intel-lab-lkp/linux/commits/Xu-Kuohai/bpf-add-bound-tracking-for-BPF_MOD/20230305-223257
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git master
patch link:    https://lore.kernel.org/r/20230306033119.2634976-2-xukuohai%40huaweicloud.com
patch subject: [PATCH bpf-next 1/2] bpf: add bound tracking for BPF_MOD
config: arm-randconfig-r025-20230305 (https://download.01.org/0day-ci/archive/20230306/202303060155.cNDEo1Br-lkp@intel.com/config)
compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project 67409911353323ca5edf2049ef0df54132fa1ca7)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm cross compiling tool for clang build
        # apt-get install binutils-arm-linux-gnueabi
        # https://github.com/intel-lab-lkp/linux/commit/e66c7bbd32e375af92c776a2b9f51be4c515ad71
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Xu-Kuohai/bpf-add-bound-tracking-for-BPF_MOD/20230305-223257
        git checkout e66c7bbd32e375af92c776a2b9f51be4c515ad71
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash kernel/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202303060155.cNDEo1Br-lkp@intel.com/

All errors (new ones prefixed by >>):

   kernel/bpf/verifier.c:10298:24: warning: array index 16 is past the end of the array (that has type 'u32[16]' (aka 'unsigned int[16]')) [-Warray-bounds]
                                      meta.func_id == special_kfunc_list[KF_bpf_dynptr_slice_rdwr]) {
                                                      ^                  ~~~~~~~~~~~~~~~~~~~~~~~~
   kernel/bpf/verifier.c:9150:1: note: array 'special_kfunc_list' declared here
   BTF_ID_LIST(special_kfunc_list)
   ^
   include/linux/btf_ids.h:207:27: note: expanded from macro 'BTF_ID_LIST'
   #define BTF_ID_LIST(name) static u32 __maybe_unused name[16];
                             ^
   kernel/bpf/verifier.c:11622:13: warning: comparison of distinct pointer types ('typeof ((umax)) *' (aka 'unsigned int *') and 'uint64_t *' (aka 'unsigned long long *')) [-Wcompare-distinct-pointer-types]
           umax_rem = do_div(umax, val);
                      ^~~~~~~~~~~~~~~~~
   include/asm-generic/div64.h:222:28: note: expanded from macro 'do_div'
           (void)(((typeof((n)) *)0) == ((uint64_t *)0));  \
                  ~~~~~~~~~~~~~~~~~~ ^  ~~~~~~~~~~~~~~~
>> kernel/bpf/verifier.c:11622:13: error: incompatible pointer types passing 'u32 *' (aka 'unsigned int *') to parameter of type 'uint64_t *' (aka 'unsigned long long *') [-Werror,-Wincompatible-pointer-types]
           umax_rem = do_div(umax, val);
                      ^~~~~~~~~~~~~~~~~
   include/asm-generic/div64.h:238:22: note: expanded from macro 'do_div'
                   __rem = __div64_32(&(n), __base);       \
                                      ^~~~
   arch/arm/include/asm/div64.h:24:45: note: passing argument to parameter 'n' here
   static inline uint32_t __div64_32(uint64_t *n, uint32_t base)
                                               ^
   kernel/bpf/verifier.c:11623:13: warning: comparison of distinct pointer types ('typeof ((umin)) *' (aka 'unsigned int *') and 'uint64_t *' (aka 'unsigned long long *')) [-Wcompare-distinct-pointer-types]
           umin_rem = do_div(umin, val);
                      ^~~~~~~~~~~~~~~~~
   include/asm-generic/div64.h:222:28: note: expanded from macro 'do_div'
           (void)(((typeof((n)) *)0) == ((uint64_t *)0));  \
                  ~~~~~~~~~~~~~~~~~~ ^  ~~~~~~~~~~~~~~~
   kernel/bpf/verifier.c:11623:13: error: incompatible pointer types passing 'u32 *' (aka 'unsigned int *') to parameter of type 'uint64_t *' (aka 'unsigned long long *') [-Werror,-Wincompatible-pointer-types]
           umin_rem = do_div(umin, val);
                      ^~~~~~~~~~~~~~~~~
   include/asm-generic/div64.h:238:22: note: expanded from macro 'do_div'
                   __rem = __div64_32(&(n), __base);       \
                                      ^~~~
   arch/arm/include/asm/div64.h:24:45: note: passing argument to parameter 'n' here
   static inline uint32_t __div64_32(uint64_t *n, uint32_t base)
                                               ^
   kernel/bpf/verifier.c:11622:13: warning: shift count >= width of type [-Wshift-count-overflow]
           umax_rem = do_div(umax, val);
                      ^~~~~~~~~~~~~~~~~
   include/asm-generic/div64.h:234:25: note: expanded from macro 'do_div'
           } else if (likely(((n) >> 32) == 0)) {          \
                                  ^  ~~
   include/linux/compiler.h:77:40: note: expanded from macro 'likely'
   # define likely(x)      __builtin_expect(!!(x), 1)
                                               ^
   kernel/bpf/verifier.c:11623:13: warning: shift count >= width of type [-Wshift-count-overflow]
           umin_rem = do_div(umin, val);
                      ^~~~~~~~~~~~~~~~~
   include/asm-generic/div64.h:234:25: note: expanded from macro 'do_div'
           } else if (likely(((n) >> 32) == 0)) {          \
                                  ^  ~~
   include/linux/compiler.h:77:40: note: expanded from macro 'likely'
   # define likely(x)      __builtin_expect(!!(x), 1)
                                               ^
   5 warnings and 2 errors generated.


vim +11622 kernel/bpf/verifier.c

 11606	
 11607	static void scalar32_min_max_mod(struct bpf_reg_state *dst_reg,
 11608					 struct bpf_reg_state *src_reg)
 11609	{
 11610		u32 val = (u32)src_reg->var_off.value; /* src_reg is const */
 11611		u32 umax = dst_reg->u32_max_value;
 11612		u32 umin = dst_reg->u32_min_value;
 11613		u32 umax_rem, umin_rem;
 11614	
 11615		/* dst_reg is 32-bit truncated when mod32 zero, since
 11616		 * adjust_scalar_min_max_vals calls zext_32_to_64 to do truncation for
 11617		 * all alu32 ops, here we do nothing and just return.
 11618		 */
 11619		if (!val)
 11620			return;
 11621	
 11622		umax_rem = do_div(umax, val);
 11623		umin_rem = do_div(umin, val);
 11624	
 11625		/* no winding */
 11626		if (umax - umin < val && umin_rem <= umax_rem) {
 11627			dst_reg->var_off = tnum_range(umin_rem, umax_rem);
 11628			dst_reg->u32_min_value = umin_rem;
 11629			dst_reg->u32_max_value = umax_rem;
 11630		} else {
 11631			dst_reg->var_off = tnum_range(0, val - 1);
 11632			dst_reg->u32_min_value = 0;
 11633			dst_reg->u32_max_value = val - 1;
 11634		}
 11635	
 11636		/* cross the sign boundary */
 11637		if ((s32)dst_reg->u32_min_value > (s32)dst_reg->u32_max_value) {
 11638			dst_reg->s32_min_value = S32_MIN;
 11639			dst_reg->s32_max_value = S32_MAX;
 11640		} else {
 11641			dst_reg->s32_min_value = (s32)dst_reg->u32_min_value;
 11642			dst_reg->s32_max_value = (s32)dst_reg->u32_max_value;
 11643		}
 11644	
 11645		/* mark reg64 unbounded to deduce 64-bit bounds from var_off */
 11646		__mark_reg64_unbounded(dst_reg);
 11647	}
 11648	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
