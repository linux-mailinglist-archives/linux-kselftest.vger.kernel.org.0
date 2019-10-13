Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 26A49D57CA
	for <lists+linux-kselftest@lfdr.de>; Sun, 13 Oct 2019 21:30:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729486AbfJMTaZ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 13 Oct 2019 15:30:25 -0400
Received: from mga03.intel.com ([134.134.136.65]:4203 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729374AbfJMTaZ (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 13 Oct 2019 15:30:25 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Oct 2019 12:30:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,293,1566889200"; 
   d="gz'50?scan'50,208,50";a="199212867"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 13 Oct 2019 12:30:16 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1iJjZH-000GYk-RT; Mon, 14 Oct 2019 03:30:15 +0800
Date:   Mon, 14 Oct 2019 03:29:34 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Changbin Du <changbin.du@gmail.com>
Cc:     kbuild-all@lists.01.org, Jonathan Corbet <corbet@lwn.net>,
        linux-pci@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-crypto@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-wireless@vger.kernel.org, linux-fpga@vger.kernel.org,
        linux-usb@vger.kernel.org, dri-devel@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org,
        Changbin Du <changbin.du@gmail.com>
Subject: Re: [PATCH] kernel-doc: rename the kernel-doc directive 'functions'
 to 'specific'
Message-ID: <201910140347.fy4EKE69%lkp@intel.com>
References: <20191013055359.23312-1-changbin.du@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="lquivkdwamayvc2f"
Content-Disposition: inline
In-Reply-To: <20191013055359.23312-1-changbin.du@gmail.com>
X-Patchwork-Hint: ignore
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


--lquivkdwamayvc2f
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Changbin,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on linus/master]
[cannot apply to v5.4-rc2 next-20191010]
[if your patch is applied to the wrong git tree, please drop us a note to help
improve the system. BTW, we also suggest to use '--base' option to specify the
base tree in git format-patch, please see https://stackoverflow.com/a/37406982]

url:    https://github.com/0day-ci/linux/commits/Changbin-Du/kernel-doc-rename-the-kernel-doc-directive-functions-to-specific/20191014-013215
reproduce: make htmldocs

If you fix the issue, kindly add following tag
Reported-by: kbuild test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   Warning: The Sphinx 'sphinx_rtd_theme' HTML theme was not found. Make sure you have the theme installed to produce pretty HTML output. Falling back to the default theme.
   WARNING: dot(1) not found, for better output quality install graphviz from http://www.graphviz.org
   WARNING: convert(1) not found, for SVG to PDF conversion install ImageMagick (https://www.imagemagick.org)
   Error: Cannot open file drivers/dma-buf/reservation.c
   Error: Cannot open file drivers/dma-buf/reservation.c
   Error: Cannot open file drivers/dma-buf/reservation.c
   Error: Cannot open file include/linux/reservation.h
   Error: Cannot open file include/linux/reservation.h
>> include/linux/regulator/machine.h:196: warning: struct member 'max_uV_step' not described in 'regulation_constraints'
>> include/linux/regulator/driver.h:223: warning: struct member 'resume' not described in 'regulator_ops'
>> include/linux/i2c.h:337: warning: struct member 'init_irq' not described in 'i2c_client'
   drivers/gpio/gpiolib-of.c:92: warning: Excess function parameter 'dev' description in 'of_gpio_need_valid_mask'
>> include/linux/spi/spi.h:190: warning: struct member 'driver_override' not described in 'spi_device'
   mm/util.c:1: warning: 'get_user_pages_fast' not found
>> mm/slab.c:4215: warning: function parameter 'objp' not described in '__ksize'
   drivers/usb/typec/bus.c:1: warning: 'typec_altmode_register_driver' not found
   drivers/usb/typec/bus.c:1: warning: 'typec_altmode_unregister_driver' not found
   drivers/usb/typec/class.c:1: warning: 'typec_altmode_unregister_notifier' not found
   drivers/usb/typec/class.c:1: warning: 'typec_altmode_register_notifier' not found
>> include/linux/w1.h:277: warning: struct member 'of_match_table' not described in 'w1_family'
   drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c:335: warning: Excess function parameter 'dev' description in 'amdgpu_gem_prime_export'
   drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c:336: warning: Excess function parameter 'dev' description in 'amdgpu_gem_prime_export'
>> drivers/gpu/drm/amd/amdgpu/amdgpu_mn.c:142: warning: function parameter 'blockable' not described in 'amdgpu_mn_read_lock'
   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c:347: warning: cannot understand function prototype: 'struct amdgpu_vm_pt_cursor '
   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c:348: warning: cannot understand function prototype: 'struct amdgpu_vm_pt_cursor '
>> drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c:494: warning: function parameter 'start' not described in 'amdgpu_vm_pt_first_dfs'
>> drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c:546: warning: function parameter 'adev' not described in 'for_each_amdgpu_vm_pt_dfs_safe'
>> drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c:546: warning: function parameter 'vm' not described in 'for_each_amdgpu_vm_pt_dfs_safe'
>> drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c:546: warning: function parameter 'start' not described in 'for_each_amdgpu_vm_pt_dfs_safe'
>> drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c:546: warning: function parameter 'cursor' not described in 'for_each_amdgpu_vm_pt_dfs_safe'
>> drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c:546: warning: function parameter 'entry' not described in 'for_each_amdgpu_vm_pt_dfs_safe'
>> drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c:821: warning: function parameter 'level' not described in 'amdgpu_vm_bo_param'
>> drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c:1283: warning: function parameter 'params' not described in 'amdgpu_vm_update_flags'
>> drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c:1283: warning: function parameter 'bo' not described in 'amdgpu_vm_update_flags'
>> drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c:1283: warning: function parameter 'level' not described in 'amdgpu_vm_update_flags'
>> drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c:1283: warning: function parameter 'pe' not described in 'amdgpu_vm_update_flags'
>> drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c:1283: warning: function parameter 'addr' not described in 'amdgpu_vm_update_flags'
>> drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c:1283: warning: function parameter 'count' not described in 'amdgpu_vm_update_flags'

vim +1207 drivers/gpu/drm/i915/i915_drv.h

eec688e1420da5 Robert Bragg          2016-11-07  1069  
16d98b31f80775 Robert Bragg          2016-12-07  1070  /**
16d98b31f80775 Robert Bragg          2016-12-07  1071   * struct i915_perf_stream - state for a single open stream FD
16d98b31f80775 Robert Bragg          2016-12-07  1072   */
eec688e1420da5 Robert Bragg          2016-11-07  1073  struct i915_perf_stream {
16d98b31f80775 Robert Bragg          2016-12-07  1074  	/**
16d98b31f80775 Robert Bragg          2016-12-07  1075  	 * @dev_priv: i915 drm device
16d98b31f80775 Robert Bragg          2016-12-07  1076  	 */
eec688e1420da5 Robert Bragg          2016-11-07  1077  	struct drm_i915_private *dev_priv;
eec688e1420da5 Robert Bragg          2016-11-07  1078  
16d98b31f80775 Robert Bragg          2016-12-07  1079  	/**
16d98b31f80775 Robert Bragg          2016-12-07  1080  	 * @link: Links the stream into ``&drm_i915_private->streams``
16d98b31f80775 Robert Bragg          2016-12-07  1081  	 */
eec688e1420da5 Robert Bragg          2016-11-07  1082  	struct list_head link;
eec688e1420da5 Robert Bragg          2016-11-07  1083  
6d2438c8233bd0 Chris Wilson          2019-01-15  1084  	/**
6d2438c8233bd0 Chris Wilson          2019-01-15  1085  	 * @wakeref: As we keep the device awake while the perf stream is
6d2438c8233bd0 Chris Wilson          2019-01-15  1086  	 * active, we track our runtime pm reference for later release.
6d2438c8233bd0 Chris Wilson          2019-01-15  1087  	 */
6619c0075f784d Chris Wilson          2019-01-14  1088  	intel_wakeref_t wakeref;
6619c0075f784d Chris Wilson          2019-01-14  1089  
16d98b31f80775 Robert Bragg          2016-12-07  1090  	/**
16d98b31f80775 Robert Bragg          2016-12-07  1091  	 * @sample_flags: Flags representing the `DRM_I915_PERF_PROP_SAMPLE_*`
16d98b31f80775 Robert Bragg          2016-12-07  1092  	 * properties given when opening a stream, representing the contents
16d98b31f80775 Robert Bragg          2016-12-07  1093  	 * of a single sample as read() by userspace.
16d98b31f80775 Robert Bragg          2016-12-07  1094  	 */
eec688e1420da5 Robert Bragg          2016-11-07  1095  	u32 sample_flags;
16d98b31f80775 Robert Bragg          2016-12-07  1096  
16d98b31f80775 Robert Bragg          2016-12-07  1097  	/**
16d98b31f80775 Robert Bragg          2016-12-07  1098  	 * @sample_size: Considering the configured contents of a sample
16d98b31f80775 Robert Bragg          2016-12-07  1099  	 * combined with the required header size, this is the total size
16d98b31f80775 Robert Bragg          2016-12-07  1100  	 * of a single sample record.
16d98b31f80775 Robert Bragg          2016-12-07  1101  	 */
d79651522e89c4 Robert Bragg          2016-11-07  1102  	int sample_size;
eec688e1420da5 Robert Bragg          2016-11-07  1103  
16d98b31f80775 Robert Bragg          2016-12-07  1104  	/**
16d98b31f80775 Robert Bragg          2016-12-07  1105  	 * @ctx: %NULL if measuring system-wide across all contexts or a
16d98b31f80775 Robert Bragg          2016-12-07  1106  	 * specific context that is being monitored.
16d98b31f80775 Robert Bragg          2016-12-07  1107  	 */
eec688e1420da5 Robert Bragg          2016-11-07  1108  	struct i915_gem_context *ctx;
16d98b31f80775 Robert Bragg          2016-12-07  1109  
16d98b31f80775 Robert Bragg          2016-12-07  1110  	/**
16d98b31f80775 Robert Bragg          2016-12-07  1111  	 * @enabled: Whether the stream is currently enabled, considering
16d98b31f80775 Robert Bragg          2016-12-07  1112  	 * whether the stream was opened in a disabled state and based
16d98b31f80775 Robert Bragg          2016-12-07  1113  	 * on `I915_PERF_IOCTL_ENABLE` and `I915_PERF_IOCTL_DISABLE` calls.
16d98b31f80775 Robert Bragg          2016-12-07  1114  	 */
eec688e1420da5 Robert Bragg          2016-11-07  1115  	bool enabled;
eec688e1420da5 Robert Bragg          2016-11-07  1116  
16d98b31f80775 Robert Bragg          2016-12-07  1117  	/**
16d98b31f80775 Robert Bragg          2016-12-07  1118  	 * @ops: The callbacks providing the implementation of this specific
16d98b31f80775 Robert Bragg          2016-12-07  1119  	 * type of configured stream.
16d98b31f80775 Robert Bragg          2016-12-07  1120  	 */
d79651522e89c4 Robert Bragg          2016-11-07  1121  	const struct i915_perf_stream_ops *ops;
701f8231a2fe17 Lionel Landwerlin     2017-08-03  1122  
701f8231a2fe17 Lionel Landwerlin     2017-08-03  1123  	/**
701f8231a2fe17 Lionel Landwerlin     2017-08-03  1124  	 * @oa_config: The OA configuration used by the stream.
701f8231a2fe17 Lionel Landwerlin     2017-08-03  1125  	 */
701f8231a2fe17 Lionel Landwerlin     2017-08-03  1126  	struct i915_oa_config *oa_config;
a37f08a882b01a Umesh Nerlige Ramappa 2019-08-06  1127  
a37f08a882b01a Umesh Nerlige Ramappa 2019-08-06  1128  	/**
a37f08a882b01a Umesh Nerlige Ramappa 2019-08-06 @1129  	 * The OA context specific information.
a37f08a882b01a Umesh Nerlige Ramappa 2019-08-06  1130  	 */
a37f08a882b01a Umesh Nerlige Ramappa 2019-08-06  1131  	struct intel_context *pinned_ctx;
a37f08a882b01a Umesh Nerlige Ramappa 2019-08-06  1132  	u32 specific_ctx_id;
a37f08a882b01a Umesh Nerlige Ramappa 2019-08-06  1133  	u32 specific_ctx_id_mask;
a37f08a882b01a Umesh Nerlige Ramappa 2019-08-06  1134  
a37f08a882b01a Umesh Nerlige Ramappa 2019-08-06  1135  	struct hrtimer poll_check_timer;
a37f08a882b01a Umesh Nerlige Ramappa 2019-08-06  1136  	wait_queue_head_t poll_wq;
a37f08a882b01a Umesh Nerlige Ramappa 2019-08-06  1137  	bool pollin;
a37f08a882b01a Umesh Nerlige Ramappa 2019-08-06  1138  
a37f08a882b01a Umesh Nerlige Ramappa 2019-08-06  1139  	bool periodic;
a37f08a882b01a Umesh Nerlige Ramappa 2019-08-06  1140  	int period_exponent;
a37f08a882b01a Umesh Nerlige Ramappa 2019-08-06  1141  
a37f08a882b01a Umesh Nerlige Ramappa 2019-08-06  1142  	/**
a37f08a882b01a Umesh Nerlige Ramappa 2019-08-06 @1143  	 * State of the OA buffer.
a37f08a882b01a Umesh Nerlige Ramappa 2019-08-06  1144  	 */
a37f08a882b01a Umesh Nerlige Ramappa 2019-08-06  1145  	struct {
a37f08a882b01a Umesh Nerlige Ramappa 2019-08-06  1146  		struct i915_vma *vma;
a37f08a882b01a Umesh Nerlige Ramappa 2019-08-06  1147  		u8 *vaddr;
a37f08a882b01a Umesh Nerlige Ramappa 2019-08-06  1148  		u32 last_ctx_id;
a37f08a882b01a Umesh Nerlige Ramappa 2019-08-06  1149  		int format;
a37f08a882b01a Umesh Nerlige Ramappa 2019-08-06  1150  		int format_size;
a37f08a882b01a Umesh Nerlige Ramappa 2019-08-06  1151  		int size_exponent;
a37f08a882b01a Umesh Nerlige Ramappa 2019-08-06  1152  
a37f08a882b01a Umesh Nerlige Ramappa 2019-08-06  1153  		/**
a37f08a882b01a Umesh Nerlige Ramappa 2019-08-06 @1154  		 * Locks reads and writes to all head/tail state
a37f08a882b01a Umesh Nerlige Ramappa 2019-08-06  1155  		 *
a37f08a882b01a Umesh Nerlige Ramappa 2019-08-06  1156  		 * Consider: the head and tail pointer state needs to be read
a37f08a882b01a Umesh Nerlige Ramappa 2019-08-06  1157  		 * consistently from a hrtimer callback (atomic context) and
a37f08a882b01a Umesh Nerlige Ramappa 2019-08-06  1158  		 * read() fop (user context) with tail pointer updates happening
a37f08a882b01a Umesh Nerlige Ramappa 2019-08-06  1159  		 * in atomic context and head updates in user context and the
a37f08a882b01a Umesh Nerlige Ramappa 2019-08-06  1160  		 * (unlikely) possibility of read() errors needing to reset all
a37f08a882b01a Umesh Nerlige Ramappa 2019-08-06  1161  		 * head/tail state.
a37f08a882b01a Umesh Nerlige Ramappa 2019-08-06  1162  		 *
a37f08a882b01a Umesh Nerlige Ramappa 2019-08-06  1163  		 * Note: Contention/performance aren't currently a significant
a37f08a882b01a Umesh Nerlige Ramappa 2019-08-06  1164  		 * concern here considering the relatively low frequency of
a37f08a882b01a Umesh Nerlige Ramappa 2019-08-06  1165  		 * hrtimer callbacks (5ms period) and that reads typically only
a37f08a882b01a Umesh Nerlige Ramappa 2019-08-06  1166  		 * happen in response to a hrtimer event and likely complete
a37f08a882b01a Umesh Nerlige Ramappa 2019-08-06  1167  		 * before the next callback.
a37f08a882b01a Umesh Nerlige Ramappa 2019-08-06  1168  		 *
a37f08a882b01a Umesh Nerlige Ramappa 2019-08-06  1169  		 * Note: This lock is not held *while* reading and copying data
a37f08a882b01a Umesh Nerlige Ramappa 2019-08-06  1170  		 * to userspace so the value of head observed in htrimer
a37f08a882b01a Umesh Nerlige Ramappa 2019-08-06  1171  		 * callbacks won't represent any partial consumption of data.
a37f08a882b01a Umesh Nerlige Ramappa 2019-08-06  1172  		 */
a37f08a882b01a Umesh Nerlige Ramappa 2019-08-06  1173  		spinlock_t ptr_lock;
a37f08a882b01a Umesh Nerlige Ramappa 2019-08-06  1174  
a37f08a882b01a Umesh Nerlige Ramappa 2019-08-06  1175  		/**
a37f08a882b01a Umesh Nerlige Ramappa 2019-08-06 @1176  		 * One 'aging' tail pointer and one 'aged' tail pointer ready to
a37f08a882b01a Umesh Nerlige Ramappa 2019-08-06  1177  		 * used for reading.
a37f08a882b01a Umesh Nerlige Ramappa 2019-08-06  1178  		 *
a37f08a882b01a Umesh Nerlige Ramappa 2019-08-06  1179  		 * Initial values of 0xffffffff are invalid and imply that an
a37f08a882b01a Umesh Nerlige Ramappa 2019-08-06  1180  		 * update is required (and should be ignored by an attempted
a37f08a882b01a Umesh Nerlige Ramappa 2019-08-06  1181  		 * read)
a37f08a882b01a Umesh Nerlige Ramappa 2019-08-06  1182  		 */
a37f08a882b01a Umesh Nerlige Ramappa 2019-08-06  1183  		struct {
a37f08a882b01a Umesh Nerlige Ramappa 2019-08-06  1184  			u32 offset;
a37f08a882b01a Umesh Nerlige Ramappa 2019-08-06  1185  		} tails[2];
a37f08a882b01a Umesh Nerlige Ramappa 2019-08-06  1186  
a37f08a882b01a Umesh Nerlige Ramappa 2019-08-06  1187  		/**
a37f08a882b01a Umesh Nerlige Ramappa 2019-08-06 @1188  		 * Index for the aged tail ready to read() data up to.
a37f08a882b01a Umesh Nerlige Ramappa 2019-08-06  1189  		 */
a37f08a882b01a Umesh Nerlige Ramappa 2019-08-06  1190  		unsigned int aged_tail_idx;
a37f08a882b01a Umesh Nerlige Ramappa 2019-08-06  1191  
a37f08a882b01a Umesh Nerlige Ramappa 2019-08-06  1192  		/**
a37f08a882b01a Umesh Nerlige Ramappa 2019-08-06 @1193  		 * A monotonic timestamp for when the current aging tail pointer
a37f08a882b01a Umesh Nerlige Ramappa 2019-08-06  1194  		 * was read; used to determine when it is old enough to trust.
a37f08a882b01a Umesh Nerlige Ramappa 2019-08-06  1195  		 */
a37f08a882b01a Umesh Nerlige Ramappa 2019-08-06  1196  		u64 aging_timestamp;
a37f08a882b01a Umesh Nerlige Ramappa 2019-08-06  1197  
a37f08a882b01a Umesh Nerlige Ramappa 2019-08-06  1198  		/**
a37f08a882b01a Umesh Nerlige Ramappa 2019-08-06 @1199  		 * Although we can always read back the head pointer register,
a37f08a882b01a Umesh Nerlige Ramappa 2019-08-06  1200  		 * we prefer to avoid trusting the HW state, just to avoid any
a37f08a882b01a Umesh Nerlige Ramappa 2019-08-06  1201  		 * risk that some hardware condition could * somehow bump the
a37f08a882b01a Umesh Nerlige Ramappa 2019-08-06  1202  		 * head pointer unpredictably and cause us to forward the wrong
a37f08a882b01a Umesh Nerlige Ramappa 2019-08-06  1203  		 * OA buffer data to userspace.
a37f08a882b01a Umesh Nerlige Ramappa 2019-08-06  1204  		 */
a37f08a882b01a Umesh Nerlige Ramappa 2019-08-06  1205  		u32 head;
a37f08a882b01a Umesh Nerlige Ramappa 2019-08-06  1206  	} oa_buffer;
d79651522e89c4 Robert Bragg          2016-11-07 @1207  };
d79651522e89c4 Robert Bragg          2016-11-07  1208  

:::::: The code at line 1207 was first introduced by commit
:::::: d79651522e89c4ffa8992b48dfe449f0c583f809 drm/i915: Enable i915 perf stream for Haswell OA unit

:::::: TO: Robert Bragg <robert@sixbynine.org>
:::::: CC: Daniel Vetter <daniel.vetter@ffwll.ch>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

--lquivkdwamayvc2f
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--lquivkdwamayvc2f--
