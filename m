Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E3E667F6B6
	for <lists+linux-kselftest@lfdr.de>; Sat, 28 Jan 2023 10:30:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233841AbjA1Jad (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 28 Jan 2023 04:30:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231234AbjA1Jac (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 28 Jan 2023 04:30:32 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BB4012F13;
        Sat, 28 Jan 2023 01:30:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674898231; x=1706434231;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=U72XuZly3Iu4fc1HHUfpwce/DIyiZRJ7N299SwsNygI=;
  b=JnM5vfpKj2pcNAU9Q0H/2tYjtbQ5lq7+D2yj+gy75jXwkis8MNBbni8n
   23O7OdRSudgYeukvWe77p/9pUs2yj8vT/MZiPAsZXL48f3tUwKf9pFjxr
   QAG02lRzV8G1SZ36p25WDP5nRxA1wq6IakojALbMJqjODjaWBWCJWoXQg
   IOMLvITfngcbAO7BXN9W+ayz9DbZDr2iNNTpzUyrqzwXPy5viRmV4gVOT
   S1npw3x1vy0xjmkbVcjhqN4eqxBljMBeW5ZP6Pwm/+I0q5J8TBDRvQy2j
   ZCdpijWVOUQDXaZB/zgQesKhMRknEZJsjzaxJ7Wpp7jv/6mEw570eTDje
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10603"; a="329405279"
X-IronPort-AV: E=Sophos;i="5.97,253,1669104000"; 
   d="scan'208";a="329405279"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2023 01:30:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10603"; a="665530690"
X-IronPort-AV: E=Sophos;i="5.97,253,1669104000"; 
   d="scan'208";a="665530690"
Received: from lkp-server01.sh.intel.com (HELO ffa7f14d1d0f) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 28 Jan 2023 01:30:25 -0800
Received: from kbuild by ffa7f14d1d0f with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pLhXU-0000Yf-2R;
        Sat, 28 Jan 2023 09:30:24 +0000
Date:   Sat, 28 Jan 2023 17:29:32 +0800
From:   kernel test robot <lkp@intel.com>
To:     Janis Schoetterl-Glausch <scgl@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>
Cc:     oe-kbuild-all@lists.linux.dev,
        Janis Schoetterl-Glausch <scgl@linux.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>, kvm@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-s390@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Sven Schnelle <svens@linux.ibm.com>
Subject: Re: [PATCH v6 12/14] KVM: s390: Extend MEM_OP ioctl by storage key
 checked cmpxchg
Message-ID: <202301281752.6gSopuWh-lkp@intel.com>
References: <20230125212608.1860251-13-scgl@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230125212608.1860251-13-scgl@linux.ibm.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Janis,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on kvm/queue]
[also build test ERROR on lwn/docs-next linus/master]
[cannot apply to kvms390/next kvm/linux-next]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Janis-Schoetterl-Glausch/KVM-s390-selftest-memop-Pass-mop_desc-via-pointer/20230128-132603
base:   https://git.kernel.org/pub/scm/virt/kvm/kvm.git queue
patch link:    https://lore.kernel.org/r/20230125212608.1860251-13-scgl%40linux.ibm.com
patch subject: [PATCH v6 12/14] KVM: s390: Extend MEM_OP ioctl by storage key checked cmpxchg
config: s390-allyesconfig (https://download.01.org/0day-ci/archive/20230128/202301281752.6gSopuWh-lkp@intel.com/config)
compiler: s390-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/6e6b3d99b9978a70b148b989d46b039feda3a3c3
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Janis-Schoetterl-Glausch/KVM-s390-selftest-memop-Pass-mop_desc-via-pointer/20230128-132603
        git checkout 6e6b3d99b9978a70b148b989d46b039feda3a3c3
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=s390 olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=s390 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   arch/s390/kvm/gaccess.c: In function 'cmpxchg_guest_abs_with_key':
>> arch/s390/kvm/gaccess.c:1217:23: error: implicit declaration of function 'cmpxchg_user_key'; did you mean 'copy_to_user_key'? [-Werror=implicit-function-declaration]
    1217 |                 ret = cmpxchg_user_key((u8 *)hva, &old, *old_addr, new, access_key);
         |                       ^~~~~~~~~~~~~~~~
         |                       copy_to_user_key
   cc1: some warnings being treated as errors


vim +1217 arch/s390/kvm/gaccess.c

  1163	
  1164	/**
  1165	 * cmpxchg_guest_abs_with_key() - Perform cmpxchg on guest absolute address.
  1166	 * @kvm: Virtual machine instance.
  1167	 * @gpa: Absolute guest address of the location to be changed.
  1168	 * @len: Operand length of the cmpxchg, required: 1 <= len <= 16. Providing a
  1169	 *       non power of two will result in failure.
  1170	 * @old_addr: Pointer to old value. If the location at @gpa contains this value,
  1171	 *            the exchange will succeed. After calling cmpxchg_guest_abs_with_key()
  1172	 *            *@old_addr contains the value at @gpa before the attempt to
  1173	 *            exchange the value.
  1174	 * @new: The value to place at @gpa.
  1175	 * @access_key: The access key to use for the guest access.
  1176	 * @success: output value indicating if an exchange occurred.
  1177	 *
  1178	 * Atomically exchange the value at @gpa by @new, if it contains *@old.
  1179	 * Honors storage keys.
  1180	 *
  1181	 * Return: * 0: successful exchange
  1182	 *         * a program interruption code indicating the reason cmpxchg could
  1183	 *           not be attempted
  1184	 *         * -EINVAL: address misaligned or len not power of two
  1185	 *         * -EAGAIN: transient failure (len 1 or 2)
  1186	 *         * -EOPNOTSUPP: read-only memslot (should never occur)
  1187	 */
  1188	int cmpxchg_guest_abs_with_key(struct kvm *kvm, gpa_t gpa, int len,
  1189				       __uint128_t *old_addr, __uint128_t new,
  1190				       u8 access_key, bool *success)
  1191	{
  1192		gfn_t gfn = gpa >> PAGE_SHIFT;
  1193		struct kvm_memory_slot *slot = gfn_to_memslot(kvm, gfn);
  1194		bool writable;
  1195		hva_t hva;
  1196		int ret;
  1197	
  1198		if (!IS_ALIGNED(gpa, len))
  1199			return -EINVAL;
  1200	
  1201		hva = gfn_to_hva_memslot_prot(slot, gfn, &writable);
  1202		if (kvm_is_error_hva(hva))
  1203			return PGM_ADDRESSING;
  1204		/*
  1205		 * Check if it's a read-only memslot, even though that cannot occur
  1206		 * since those are unsupported.
  1207		 * Don't try to actually handle that case.
  1208		 */
  1209		if (!writable)
  1210			return -EOPNOTSUPP;
  1211	
  1212		hva += offset_in_page(gpa);
  1213		switch (len) {
  1214		case 1: {
  1215			u8 old;
  1216	
> 1217			ret = cmpxchg_user_key((u8 *)hva, &old, *old_addr, new, access_key);
  1218			*success = !ret && old == *old_addr;
  1219			*old_addr = old;
  1220			break;
  1221		}
  1222		case 2: {
  1223			u16 old;
  1224	
  1225			ret = cmpxchg_user_key((u16 *)hva, &old, *old_addr, new, access_key);
  1226			*success = !ret && old == *old_addr;
  1227			*old_addr = old;
  1228			break;
  1229		}
  1230		case 4: {
  1231			u32 old;
  1232	
  1233			ret = cmpxchg_user_key((u32 *)hva, &old, *old_addr, new, access_key);
  1234			*success = !ret && old == *old_addr;
  1235			*old_addr = old;
  1236			break;
  1237		}
  1238		case 8: {
  1239			u64 old;
  1240	
  1241			ret = cmpxchg_user_key((u64 *)hva, &old, *old_addr, new, access_key);
  1242			*success = !ret && old == *old_addr;
  1243			*old_addr = old;
  1244			break;
  1245		}
  1246		case 16: {
  1247			__uint128_t old;
  1248	
  1249			ret = cmpxchg_user_key((__uint128_t *)hva, &old, *old_addr, new, access_key);
  1250			*success = !ret && old == *old_addr;
  1251			*old_addr = old;
  1252			break;
  1253		}
  1254		default:
  1255			return -EINVAL;
  1256		}
  1257		mark_page_dirty_in_slot(kvm, slot, gfn);
  1258		/*
  1259		 * Assume that the fault is caused by protection, either key protection
  1260		 * or user page write protection.
  1261		 */
  1262		if (ret == -EFAULT)
  1263			ret = PGM_PROTECTION;
  1264		return ret;
  1265	}
  1266	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
