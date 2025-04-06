Return-Path: <linux-kselftest+bounces-30167-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B908A7CCBF
	for <lists+linux-kselftest@lfdr.de>; Sun,  6 Apr 2025 06:28:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F73E188F44B
	for <lists+linux-kselftest@lfdr.de>; Sun,  6 Apr 2025 04:28:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 045F31B87FD;
	Sun,  6 Apr 2025 04:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="R4equr5S"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06F292AEF5;
	Sun,  6 Apr 2025 04:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743913720; cv=none; b=MvB3RrCi/MmlIzovRY0nU4TNaEdGuuqXylNgxCF0MlBMwW+AF2SAhW2/h0r9vQXd1Q7LcJ3vP77ZzQu0sYZfKtOyKKXsziBYaLs6kphlptJTPM4RYX+4tDYjFT1P+CBkvU9rMgzmFvY+jeamX9QnWanrZfN5UN2m61F1RonJcC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743913720; c=relaxed/simple;
	bh=4BH94r9eFHWd7jK1gh/ArWcfPCsUQZMfgHuoqE5hS94=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LjZk9JjR4Yvbs0FKr831KTBps7VKG19zARsDUXwdhxm1eyKjsliPhlkJsKBU8Mo5j4NS05reIsy0aP/nKEvX57s8VRXmSNLF6WTW7Wre6gpM02vN7dqer5Gom/tdJ9ZmvAM+2UE20cRhvbW0OBDsV/L2wHUgM5SqHVCY9Q2d9Jk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=R4equr5S; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1743913719; x=1775449719;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=4BH94r9eFHWd7jK1gh/ArWcfPCsUQZMfgHuoqE5hS94=;
  b=R4equr5SQ1KHsLtMq8WXDlmeyZiPX3MpxZ4xVwRpd3AHN8sYJTO4uVS7
   58vYOnaP5i5fEz2OaopowPQDE+fSXqCOn2qZrI8k+LyBlcF7S44FLT8y+
   Ur+J/Q7FxkjyknrUkQLZ6tv2DRsPy9Nd4KGfasaG7zsWUI1p26iMLUKyd
   B2qQT84TFRlGnC6thAFYoqIjrhT6Vn4vmxjOLLdSgXN0Wr+o+Omx0DRuP
   YhBl+WFq8bNbhqIEt1uBm7LivzUiTAMnPi6k313EFl28jmZiJ51LSsn+c
   /Z+w2i84eMX/40RAFG1A7QG14JeLHvjq0c1rGFdoUjD4nHbcA7eBlQWHd
   Q==;
X-CSE-ConnectionGUID: BiwFMpqNR1GuNxWs2Pi9PQ==
X-CSE-MsgGUID: 2Kc/7TV6RQSHKWdeiZeidw==
X-IronPort-AV: E=McAfee;i="6700,10204,11395"; a="56681021"
X-IronPort-AV: E=Sophos;i="6.15,192,1739865600"; 
   d="scan'208";a="56681021"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2025 21:28:38 -0700
X-CSE-ConnectionGUID: 1bedKDMXRJKqCrYs7nazqw==
X-CSE-MsgGUID: acvAGZQMQzmFa8Oa3eIpPg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,192,1739865600"; 
   d="scan'208";a="158617337"
Received: from lkp-server01.sh.intel.com (HELO b207828170a5) ([10.239.97.150])
  by fmviesa001.fm.intel.com with ESMTP; 05 Apr 2025 21:28:31 -0700
Received: from kbuild by b207828170a5 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1u1HcT-0002RH-1k;
	Sun, 06 Apr 2025 04:28:29 +0000
Date: Sun, 6 Apr 2025 12:27:29 +0800
From: kernel test robot <lkp@intel.com>
To: Blaise Boscaccy <bboscaccy@linux.microsoft.com>,
	Jonathan Corbet <corbet@lwn.net>,
	David Howells <dhowells@redhat.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nicolas Schier <nicolas@fjasle.eu>,
	Shuah Khan <skhan@linuxfoundation.org>,
	=?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>,
	=?iso-8859-1?Q?G=FCnther?= Noack <gnoack@google.com>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Jan Stancek <jstancek@redhat.com>, Neal Gompa <neal@gompa.dev>,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	keyrings@vger.kernel.org, linux-crypto@vger.kernel.org,
	linux-security-module@vger.kernel.org, linux-kbuild@vger.kernel.org,
	linux-kselftest@vger.kernel.org, bpf@vger.kernel.org,
	llvm@lists.linux.dev
Cc: oe-kbuild-all@lists.linux.dev, netdev@vger.kernel.org
Subject: Re: [PATCH v2 security-next 1/4] security: Hornet LSM
Message-ID: <202504061441.FMnrO665-lkp@intel.com>
References: <20250404215527.1563146-2-bboscaccy@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250404215527.1563146-2-bboscaccy@linux.microsoft.com>

Hi Blaise,

kernel test robot noticed the following build errors:

[auto build test ERROR on shuah-kselftest/next]
[also build test ERROR on shuah-kselftest/fixes herbert-cryptodev-2.6/master herbert-crypto-2.6/master masahiroy-kbuild/for-next masahiroy-kbuild/fixes v6.14]
[cannot apply to linus/master next-20250404]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Blaise-Boscaccy/security-Hornet-LSM/20250405-055741
base:   https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest.git next
patch link:    https://lore.kernel.org/r/20250404215527.1563146-2-bboscaccy%40linux.microsoft.com
patch subject: [PATCH v2 security-next 1/4] security: Hornet LSM
config: sh-allmodconfig (https://download.01.org/0day-ci/archive/20250406/202504061441.FMnrO665-lkp@intel.com/config)
compiler: sh4-linux-gcc (GCC) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250406/202504061441.FMnrO665-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202504061441.FMnrO665-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from security/hornet/hornet_lsm.c:10:
>> security/hornet/hornet_lsm.c:221:38: error: initialization of 'int (*)(struct bpf_prog *, union bpf_attr *, struct bpf_token *)' from incompatible pointer type 'int (*)(struct bpf_prog *, union bpf_attr *, struct bpf_token *, bool)' {aka 'int (*)(struct bpf_prog *, union bpf_attr *, struct bpf_token *, _Bool)'} [-Wincompatible-pointer-types]
     221 |         LSM_HOOK_INIT(bpf_prog_load, hornet_bpf_prog_load),
         |                                      ^~~~~~~~~~~~~~~~~~~~
   include/linux/lsm_hooks.h:136:35: note: in definition of macro 'LSM_HOOK_INIT'
     136 |                 .hook = { .NAME = HOOK }                \
         |                                   ^~~~
   security/hornet/hornet_lsm.c:221:38: note: (near initialization for 'hornet_hooks[0].hook.bpf_prog_load')
     221 |         LSM_HOOK_INIT(bpf_prog_load, hornet_bpf_prog_load),
         |                                      ^~~~~~~~~~~~~~~~~~~~
   include/linux/lsm_hooks.h:136:35: note: in definition of macro 'LSM_HOOK_INIT'
     136 |                 .hook = { .NAME = HOOK }                \
         |                                   ^~~~


vim +221 security/hornet/hornet_lsm.c

   219	
   220	static struct security_hook_list hornet_hooks[] __ro_after_init = {
 > 221		LSM_HOOK_INIT(bpf_prog_load, hornet_bpf_prog_load),
   222	};
   223	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

