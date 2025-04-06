Return-Path: <linux-kselftest+bounces-30170-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 907B1A7D069
	for <lists+linux-kselftest@lfdr.de>; Sun,  6 Apr 2025 22:43:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 158DC3AE1B2
	for <lists+linux-kselftest@lfdr.de>; Sun,  6 Apr 2025 20:42:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 385851AF0A4;
	Sun,  6 Apr 2025 20:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RCfRAANi"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13FF718C03F;
	Sun,  6 Apr 2025 20:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743972182; cv=none; b=ScDb9wdm8vhDYnWHxSYImlky+V+Zx2VIC9Bryxrz5wFK1XXi3yzzuoDE9D7qCPDdAQoPItMfuqTUZvZbWAlgcoCukO4AyIvr+CA+sZEmP8QcTCekTB3C/RXmgsa19GeEsiwORc6v9jE+jypydz6R8CL+7ybpj5w5ZWSABsYsNak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743972182; c=relaxed/simple;
	bh=ucTOR97qFqJDSGh++Oi8YunL4fytJwroFSyVVKXhxw8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QQ9t1/62a5eKuYzuXh/FdA4cUzJNxHJ8LJodOuU3h3wwVncndjDxQJ47FYAbd+VPw6ZSvBO1SoNrJazgQcCsA9nV4QtFMIa78EzOsk0ktko5V32A3iDeBv31M4SkV0oiFxHdwsIvq917+emS7/+yS5utoa0xZZnMZzd7vZiQXz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RCfRAANi; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1743972180; x=1775508180;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ucTOR97qFqJDSGh++Oi8YunL4fytJwroFSyVVKXhxw8=;
  b=RCfRAANiFlsffxsLkeOrf3D2ZxEdUtpkJ7iUEcGjAYGGPvkwsIydz1Fl
   4Fcdra37AWaAzXnc7mtm8SV0gjrTuOcaOQ3NvmykOBiJo71gtMg2NhanK
   0YY9JmBAcZSmDiUlg9e6lpAaaZbmNRnsez8C9syFOQ9Y+f9fhNDG82/Lt
   cE0amL0ZwPPLmALE0ts9ebCRM9R3V4yiOKac6HszOgbG1m2aZLVMNlb/v
   Ay6V/fkQy9bVdgBpWVE1HbkcI/IJBq+xIF6XgHxQexJb3u9UKwsUomWhG
   HCzyuKbowCSBZxBxWXct4hGXQJnwoKm0Fq2zKP3meO6/1KTmgT9wAnnWX
   w==;
X-CSE-ConnectionGUID: T6WPsuguRsaw4+xAPBrnFA==
X-CSE-MsgGUID: z+EiWtdLSdGJW8Guhc1I0w==
X-IronPort-AV: E=McAfee;i="6700,10204,11396"; a="62893348"
X-IronPort-AV: E=Sophos;i="6.15,193,1739865600"; 
   d="scan'208";a="62893348"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Apr 2025 13:42:59 -0700
X-CSE-ConnectionGUID: 7A1SZ+9HQaeEOp+zSzOO2A==
X-CSE-MsgGUID: 1Mu686fJRWm6vbVCtSdAXQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,193,1739865600"; 
   d="scan'208";a="128624589"
Received: from lkp-server01.sh.intel.com (HELO b207828170a5) ([10.239.97.150])
  by fmviesa009.fm.intel.com with ESMTP; 06 Apr 2025 13:42:53 -0700
Received: from kbuild by b207828170a5 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1u1WpO-0002lj-2N;
	Sun, 06 Apr 2025 20:42:50 +0000
Date: Mon, 7 Apr 2025 04:42:09 +0800
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
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	netdev@vger.kernel.org
Subject: Re: [PATCH v2 security-next 1/4] security: Hornet LSM
Message-ID: <202504070413.eDHSjWGP-lkp@intel.com>
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
config: s390-allmodconfig (https://download.01.org/0day-ci/archive/20250407/202504070413.eDHSjWGP-lkp@intel.com/config)
compiler: clang version 18.1.8 (https://github.com/llvm/llvm-project 3b5b5c1ec4a3095ab096dd780e84d7ab81f3d7ff)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250407/202504070413.eDHSjWGP-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202504070413.eDHSjWGP-lkp@intel.com/

All errors (new ones prefixed by >>):

>> security/hornet/hornet_lsm.c:221:31: error: incompatible function pointer types initializing 'int (*)(struct bpf_prog *, union bpf_attr *, struct bpf_token *)' with an expression of type 'int (struct bpf_prog *, union bpf_attr *, struct bpf_token *, bool)' (aka 'int (struct bpf_prog *, union bpf_attr *, struct bpf_token *, _Bool)') [-Wincompatible-function-pointer-types]
     221 |         LSM_HOOK_INIT(bpf_prog_load, hornet_bpf_prog_load),
         |                                      ^~~~~~~~~~~~~~~~~~~~
   include/linux/lsm_hooks.h:136:21: note: expanded from macro 'LSM_HOOK_INIT'
     136 |                 .hook = { .NAME = HOOK }                \
         |                                   ^~~~
   1 error generated.


vim +221 security/hornet/hornet_lsm.c

   219	
   220	static struct security_hook_list hornet_hooks[] __ro_after_init = {
 > 221		LSM_HOOK_INIT(bpf_prog_load, hornet_bpf_prog_load),
   222	};
   223	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

