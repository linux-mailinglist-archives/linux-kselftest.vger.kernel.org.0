Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD7B47DB593
	for <lists+linux-kselftest@lfdr.de>; Mon, 30 Oct 2023 10:01:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231953AbjJ3JBD (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 30 Oct 2023 05:01:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232209AbjJ3JBC (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 30 Oct 2023 05:01:02 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EE95AB;
        Mon, 30 Oct 2023 02:01:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698656460; x=1730192460;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=FSso9eWZebVLlGt8FVFbMUsI6oL0n+UfhWcKhse6/m0=;
  b=P2/LA7fqCT8rQc3RDdNIcAQOX60ZNQkjuAesxwFOX0qlAAtrcdnyfejS
   X3UL3MT7Zf8mtcvlLuST76YD4yS+TFmkU7X7yMWP5UuIvZUxQTJkkBKiq
   vq0tZsrXGKS/S9XQyhlG9kMU7/QaOkhOrz8dv+9VJ/T2amX9XOu+FStF1
   ujGoreKRnM/7Fpc5LSQzl4u+HGx13qTGDHCD1F8TxdDsX6FUNNAhyafnt
   ukTgGND4Et7Goi1oox4Ja7yq6c9euBjxSAMKQy2AJVozBQ+MVWwjPuRWK
   SCs6Q6mgRAtq2kf2mbLVO/a0rRT0aeBkLQLW89/G+N3g4JdehDjOuBw4j
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10878"; a="373088619"
X-IronPort-AV: E=Sophos;i="6.03,263,1694761200"; 
   d="scan'208";a="373088619"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2023 02:00:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,263,1694761200"; 
   d="scan'208";a="1461968"
Received: from lkp-server01.sh.intel.com (HELO 8917679a5d3e) ([10.239.97.150])
  by fmviesa002.fm.intel.com with ESMTP; 30 Oct 2023 02:00:52 -0700
Received: from kbuild by 8917679a5d3e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qxO8g-000D9B-0p;
        Mon, 30 Oct 2023 09:00:50 +0000
Date:   Mon, 30 Oct 2023 17:00:38 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bernd Edlinger <bernd.edlinger@hotmail.de>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Serge Hallyn <serge@hallyn.com>,
        James Morris <jamorris@linux.microsoft.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Suren Baghdasaryan <surenb@google.com>,
        YiFei Zhu <yifeifz2@illinois.edu>,
        Yafang Shao <laoar.shao@gmail.com>,
        Helge Deller <deller@gmx.de>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Adrian Reber <areber@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jens Axboe <axboe@kernel.dk>,
        Alexei Starovoitov <ast@kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-kselftest@vger.kernel.org,
        tiozhang <tiozhang@didiglobal.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        "Paulo Alcantara (SUSE)" <pc@manguebit.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Frederic Weisbecker <frederic@kernel.org>
Cc:     oe-kbuild-all@lists.linux.dev,
        Linux Memory Management List <linux-mm@kvack.org>
Subject: Re: [PATCH v12] exec: Fix dead-lock in de_thread with ptrace_attach
Message-ID: <202310301604.K866zRJ8-lkp@intel.com>
References: <AS8P193MB1285DF698D7524EDE22ABFA1E4A1A@AS8P193MB1285.EURP193.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AS8P193MB1285DF698D7524EDE22ABFA1E4A1A@AS8P193MB1285.EURP193.PROD.OUTLOOK.COM>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Bernd,

kernel test robot noticed the following build warnings:

[auto build test WARNING on kees/for-next/execve]
[also build test WARNING on kees/for-next/seccomp shuah-kselftest/next shuah-kselftest/fixes linus/master v6.6]
[cannot apply to next-20231030]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Bernd-Edlinger/exec-Fix-dead-lock-in-de_thread-with-ptrace_attach/20231030-133021
base:   https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git for-next/execve
patch link:    https://lore.kernel.org/r/AS8P193MB1285DF698D7524EDE22ABFA1E4A1A%40AS8P193MB1285.EURP193.PROD.OUTLOOK.COM
patch subject: [PATCH v12] exec: Fix dead-lock in de_thread with ptrace_attach
config: loongarch-randconfig-002-20231030 (https://download.01.org/0day-ci/archive/20231030/202310301604.K866zRJ8-lkp@intel.com/config)
compiler: loongarch64-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231030/202310301604.K866zRJ8-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202310301604.K866zRJ8-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> kernel/cred.c:443: warning: duplicate section name 'Return'


vim +/Return +443 kernel/cred.c

   435	
   436	/**
   437	 * is_dumpability_changed - Will changing creds from old to new
   438	 * affect the dumpability in commit_creds?
   439	 *
   440	 * Return: false - dumpability will not be changed in commit_creds.
   441	 * Return: true  - dumpability will be changed to non-dumpable.
   442	 *
 > 443	 * @old: The old credentials
   444	 * @new: The new credentials
   445	 */
   446	bool is_dumpability_changed(const struct cred *old, const struct cred *new)
   447	{
   448		if (!uid_eq(old->euid, new->euid) ||
   449		    !gid_eq(old->egid, new->egid) ||
   450		    !uid_eq(old->fsuid, new->fsuid) ||
   451		    !gid_eq(old->fsgid, new->fsgid) ||
   452		    !cred_cap_issubset(old, new))
   453			return true;
   454	
   455		return false;
   456	}
   457	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
