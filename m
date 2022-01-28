Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A260C49F13B
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Jan 2022 03:47:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345525AbiA1Crx (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 27 Jan 2022 21:47:53 -0500
Received: from mga02.intel.com ([134.134.136.20]:61627 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1345507AbiA1Crx (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 27 Jan 2022 21:47:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643338073; x=1674874073;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ZoXCdsrtsztluG+o4sm2fG3tQLVmbVv74lR9eawI9u4=;
  b=mVs1M3EGv6TQlom3M9+ykc9pwQjha0btgopZ1PlwRTCfhEepP6ONb9ZJ
   2F1q1+BOS9XUVCD/SlYTc8bEDvZeA/fzIdCt8FvfrZBmtt45m2a7zQDgk
   8WkiIk05GZ0pAwOenUpRVhOovvVYGHul3bzk/32Ur9l9OBJ+A3Q0aZ5bH
   kTfPpZXqgV4whcYm7QNHj6BtTGMDpXeVVRQqEUdv10k7L9mSwLUA09KCB
   ZUeFO6ZOjIJRwpU2OChMAAeYN95GGDPr8Fk/J8fcCGJjl5DudSxLxKCbX
   /3zzhl3CijmRB4fbdrBitQ2xw49mPq9Qt2GROLroOrsyiFBCbsRUtmNDC
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10240"; a="234403973"
X-IronPort-AV: E=Sophos;i="5.88,322,1635231600"; 
   d="scan'208";a="234403973"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2022 18:47:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,322,1635231600"; 
   d="scan'208";a="674949731"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 27 Jan 2022 18:47:50 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nDHIj-000NLK-P1; Fri, 28 Jan 2022 02:47:49 +0000
Date:   Fri, 28 Jan 2022 10:47:07 +0800
From:   kernel test robot <lkp@intel.com>
To:     James Morse <james.morse@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org
Cc:     kbuild-all@lists.01.org, Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Mark Brown <broonie@kernel.org>, james.morse@arm.com
Subject: Re: [PATCH 1/3] arm64: selftests: Generate all the possible logical
 immediates as a header
Message-ID: <202201281052.Nzl9wJM4-lkp@intel.com>
References: <20220127162127.2391947-2-james.morse@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220127162127.2391947-2-james.morse@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi James,

I love your patch! Perhaps something to improve:

[auto build test WARNING on arm64/for-next/core]
[also build test WARNING on arm/for-next xilinx-xlnx/master soc/for-next kvmarm/next v5.17-rc1 next-20220127]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/James-Morse/arm64-insn-Generate-64-bit-mask-immediates-correctly/20220128-002213
base:   https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-next/core
config: arm64-randconfig-p001-20220128 (https://download.01.org/0day-ci/archive/20220128/202201281052.Nzl9wJM4-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/1ead98d2c8c4c28ea27964dbf7b5b89a83b8e7ec
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review James-Morse/arm64-insn-Generate-64-bit-mask-immediates-correctly/20220128-002213
        git checkout 1ead98d2c8c4c28ea27964dbf7b5b89a83b8e7ec
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arm64 prepare

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   arch/arm64/tools/gen_logic_imm.c: In function 'validate':
>> arch/arm64/tools/gen_logic_imm.c:81:2: warning: ignoring return value of 'write' declared with attribute 'warn_unused_result' [-Wunused-result]
      81 |  write(fd, &insn, sizeof(insn));
         |  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
--
   arch/arm64/tools/gen_logic_imm.c: In function 'validate':
>> arch/arm64/tools/gen_logic_imm.c:81:2: warning: ignoring return value of 'write' declared with attribute 'warn_unused_result' [-Wunused-result]
      81 |  write(fd, &insn, sizeof(insn));
         |  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   arch/arm64/kernel/vdso/vgettimeofday.c:9:5: warning: no previous prototype for '__kernel_clock_gettime' [-Wmissing-prototypes]
       9 | int __kernel_clock_gettime(clockid_t clock,
         |     ^~~~~~~~~~~~~~~~~~~~~~
   arch/arm64/kernel/vdso/vgettimeofday.c:15:5: warning: no previous prototype for '__kernel_gettimeofday' [-Wmissing-prototypes]
      15 | int __kernel_gettimeofday(struct __kernel_old_timeval *tv,
         |     ^~~~~~~~~~~~~~~~~~~~~
   arch/arm64/kernel/vdso/vgettimeofday.c:21:5: warning: no previous prototype for '__kernel_clock_getres' [-Wmissing-prototypes]
      21 | int __kernel_clock_getres(clockid_t clock_id,
         |     ^~~~~~~~~~~~~~~~~~~~~


vim +81 arch/arm64/tools/gen_logic_imm.c

    55	
    56	#define PIPE_READ	0
    57	#define PIPE_WRITE	1
    58	/*
    59	 * Use objdump to decode the encoded instruction, and compare the immediate.
    60	 * On error, returns the bad instruction, otherwise returns 0.
    61	 */
    62	static int validate(u64 val, u32 immN, u32 imms, u32 immr, char *objdump)
    63	{
    64		pid_t child;
    65		char *immediate;
    66		char val_str[32];
    67		u32 insn = 0x12000000;
    68		char output[1024] = {0};
    69		int fd, pipefd[2], bytes;
    70		char filename[] = "validate_gen_logic_imm.XXXXXX";
    71	
    72		insn |= 1 << 31;
    73		insn |= (immN & 0x1)<<22;
    74		insn |= (immr & 0x3f)<<16;
    75		insn |= (imms & 0x3f)<<10;
    76	
    77		fd = mkstemp(filename);
    78		if (fd < 0)
    79			abort();
    80	
  > 81		write(fd, &insn, sizeof(insn));
    82		close(fd);
    83	
    84		if (pipe(pipefd))
    85			return 0;
    86	
    87		child = vfork();
    88		if (child) {
    89			close(pipefd[PIPE_WRITE]);
    90			waitpid(child, NULL, 0);
    91	
    92			bytes = read(pipefd[PIPE_READ], output, sizeof(output));
    93			close(pipefd[PIPE_READ]);
    94			if (!bytes || bytes == sizeof(output))
    95				return insn;
    96	
    97			immediate = strstr(output, "x0, x0, #");
    98			if (!immediate)
    99				return insn;
   100			immediate += strlen("x0, x0, #");
   101	
   102			/*
   103			 * strtoll() has its own ideas about overflow and underflow.
   104			 * Do a string comparison. immediate ends in a newline.
   105			 */
   106			snprintf(val_str, sizeof(val_str), "0x%lx", val);
   107			if (strncmp(val_str, immediate, strlen(val_str))) {
   108				fprintf(stderr, "Unexpected decode from objdump: %s\n",
   109					immediate);
   110				return insn;
   111			}
   112		} else {
   113			close(pipefd[PIPE_READ]);
   114			close(1);
   115			dup2(pipefd[PIPE_WRITE], 1);
   116			execl(objdump, objdump, "-b", "binary", "-m", "aarch64", "-D",
   117			      filename, (char *) NULL);
   118			abort();
   119		}
   120	
   121		unlink(filename);
   122		return 0;
   123	}
   124	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
