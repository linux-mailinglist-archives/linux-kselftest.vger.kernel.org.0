Return-Path: <linux-kselftest+bounces-7809-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 173DA8A3124
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Apr 2024 16:44:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A0EF1C20F96
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Apr 2024 14:44:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0D1F14386D;
	Fri, 12 Apr 2024 14:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hziH+W09"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D875213C9B9;
	Fri, 12 Apr 2024 14:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712933086; cv=none; b=qti0SuTfplFCi1Hliu57DMaBiIpqsUufqxD+mXg/3l6Cj/PUDC6itSZxiqfqbADs/xSytF1fBYmI40x1SHQHzcHlluq+yicSJzZcPZuNlvdQfbLPdTtkXhjzGg2489IpYkEJMFO5a/nhKkVL0+2F/eyc+pcE1QzIn6KucviQmXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712933086; c=relaxed/simple;
	bh=/27W4DpK6bm6LK7sKH9qasHWmiyh/v2gPTVYEgX1MA8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EFeh5u7oxNTGQw04fUJgrFXQzRv7QIoXeItiawo1TtRA4dz8lmuM231Wd9drZzngSKpCQQTEvyvNN3cBROP6s2Qri8h0fwItba0rLge/xHw3hxj1f32yktGFGZMX/Ad+awr9d261ERm/RlootB+e1usOL5hgiXMqvaEKragpzOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hziH+W09; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712933085; x=1744469085;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=/27W4DpK6bm6LK7sKH9qasHWmiyh/v2gPTVYEgX1MA8=;
  b=hziH+W09nMOfdiUcXPvtn1l/PH7EK832ZzFBpYGx4KhynoGsnEAgJjSo
   4X2EWLQ2LYi3j8mnaHjRO0MQqd8hTp/Iy9f2OPpvJSRbuBDd50AstW/q5
   ei0njLGCrVgT4KdSvWH6rgAqzK8LISVoxAUBVxCosV4g5hWVVwBlWDhiO
   7A9AGiz0vjp992gv4XWGqHqZtB0DsZNu0fEL/nq3rpCh1Gmfk8CuRSCD/
   NFWTTdewi2fOgT6pJRwWbzgbPZzHyADpPvW5nDQkz8MDhoYB4cyyCNQvH
   dfEJS3yy8mdGkpxHZwJvvtm9q27OsEM6Spa3WCPuV6KbsBUKdT4QcQOrE
   g==;
X-CSE-ConnectionGUID: XLvtH7GESQSfeaPbbev3hw==
X-CSE-MsgGUID: LzmUQ09SQh+qZNyUbl9R9g==
X-IronPort-AV: E=McAfee;i="6600,9927,11042"; a="8245408"
X-IronPort-AV: E=Sophos;i="6.07,196,1708416000"; 
   d="scan'208";a="8245408"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2024 07:44:44 -0700
X-CSE-ConnectionGUID: TmtMmztsQmaNnVyTO82zCQ==
X-CSE-MsgGUID: T0wQPY3cQIa8GTKycwqySw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,196,1708416000"; 
   d="scan'208";a="21161233"
Received: from lkp-server01.sh.intel.com (HELO e61807b1d151) ([10.239.97.150])
  by orviesa010.jf.intel.com with ESMTP; 12 Apr 2024 07:44:38 -0700
Received: from kbuild by e61807b1d151 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rvI8p-0009qL-1l;
	Fri, 12 Apr 2024 14:44:35 +0000
Date: Fri, 12 Apr 2024 22:44:22 +0800
From: kernel test robot <lkp@intel.com>
To: Charlie Jenkins <charlie@rivosinc.com>, Conor Dooley <conor@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Guo Ren <guoren@kernel.org>,
	Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Evan Green <evan@rivosinc.com>,
	=?iso-8859-1?Q?Cl=E9ment_L=E9ger?= <cleger@rivosinc.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev, linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Charlie Jenkins <charlie@rivosinc.com>
Subject: Re: [PATCH 06/19] riscv: Extend cpufeature.c to detect vendor
 extensions
Message-ID: <202404122206.TkXKhj29-lkp@intel.com>
References: <20240411-dev-charlie-support_thead_vector_6_9-v1-6-4af9815ec746@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240411-dev-charlie-support_thead_vector_6_9-v1-6-4af9815ec746@rivosinc.com>

Hi Charlie,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 4cece764965020c22cff7665b18a012006359095]

url:    https://github.com/intel-lab-lkp/linux/commits/Charlie-Jenkins/dt-bindings-riscv-Add-vendorid-and-archid/20240412-121709
base:   4cece764965020c22cff7665b18a012006359095
patch link:    https://lore.kernel.org/r/20240411-dev-charlie-support_thead_vector_6_9-v1-6-4af9815ec746%40rivosinc.com
patch subject: [PATCH 06/19] riscv: Extend cpufeature.c to detect vendor extensions
config: riscv-defconfig (https://download.01.org/0day-ci/archive/20240412/202404122206.TkXKhj29-lkp@intel.com/config)
compiler: clang version 19.0.0git (https://github.com/llvm/llvm-project 8b3b4a92adee40483c27f26c478a384cd69c6f05)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240412/202404122206.TkXKhj29-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202404122206.TkXKhj29-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from arch/riscv/kernel/cpufeature.c:20:
   In file included from arch/riscv/include/asm/cacheflush.h:9:
   In file included from include/linux/mm.h:2208:
   include/linux/vmstat.h:522:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
     522 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
         |                               ~~~~~~~~~~~ ^ ~~~
>> arch/riscv/kernel/cpufeature.c:395:4: warning: label followed by a declaration is a C23 extension [-Wc23-extensions]
     395 |                         bool found;
         |                         ^
   2 warnings generated.


vim +395 arch/riscv/kernel/cpufeature.c

   370	
   371	static void __init riscv_parse_isa_string(unsigned long *this_hwcap, struct riscv_isainfo *isainfo,
   372						struct riscv_isainfo *isavendorinfo, unsigned long vendorid,
   373						unsigned long *isa2hwcap, const char *isa)
   374	{
   375		/*
   376		 * For all possible cpus, we have already validated in
   377		 * the boot process that they at least contain "rv" and
   378		 * whichever of "32"/"64" this kernel supports, and so this
   379		 * section can be skipped.
   380		 */
   381		isa += 4;
   382	
   383		while (*isa) {
   384			const char *ext = isa++;
   385			const char *ext_end = isa;
   386			bool ext_long = false, ext_err = false;
   387			struct riscv_isainfo *selected_isainfo = isainfo;
   388			const struct riscv_isa_ext_data *selected_riscv_isa_ext = riscv_isa_ext;
   389			size_t selected_riscv_isa_ext_count = riscv_isa_ext_count;
   390			unsigned int id_offset = 0;
   391	
   392			switch (*ext) {
   393			case 'x':
   394			case 'X':
 > 395				bool found;
   396	
   397				found = get_isa_vendor_ext(vendorid,
   398							   &selected_riscv_isa_ext,
   399							   &selected_riscv_isa_ext_count);
   400				selected_isainfo = isavendorinfo;
   401				id_offset = RISCV_ISA_VENDOR_EXT_BASE;
   402				if (!found) {
   403					pr_warn("No associated vendor extensions with vendor id: %lx\n",
   404						vendorid);
   405					for (; *isa && *isa != '_'; ++isa)
   406						;
   407					ext_err = true;
   408					break;
   409				}
   410				fallthrough;
   411			case 's':
   412				/*
   413				 * Workaround for invalid single-letter 's' & 'u' (QEMU).
   414				 * No need to set the bit in riscv_isa as 's' & 'u' are
   415				 * not valid ISA extensions. It works unless the first
   416				 * multi-letter extension in the ISA string begins with
   417				 * "Su" and is not prefixed with an underscore.
   418				 */
   419				if (ext[-1] != '_' && ext[1] == 'u') {
   420					++isa;
   421					ext_err = true;
   422					break;
   423				}
   424				fallthrough;
   425			case 'S':
   426			case 'z':
   427			case 'Z':
   428				/*
   429				 * Before attempting to parse the extension itself, we find its end.
   430				 * As multi-letter extensions must be split from other multi-letter
   431				 * extensions with an "_", the end of a multi-letter extension will
   432				 * either be the null character or the "_" at the start of the next
   433				 * multi-letter extension.
   434				 *
   435				 * Next, as the extensions version is currently ignored, we
   436				 * eliminate that portion. This is done by parsing backwards from
   437				 * the end of the extension, removing any numbers. This may be a
   438				 * major or minor number however, so the process is repeated if a
   439				 * minor number was found.
   440				 *
   441				 * ext_end is intended to represent the first character *after* the
   442				 * name portion of an extension, but will be decremented to the last
   443				 * character itself while eliminating the extensions version number.
   444				 * A simple re-increment solves this problem.
   445				 */
   446				ext_long = true;
   447				for (; *isa && *isa != '_'; ++isa)
   448					if (unlikely(!isalnum(*isa)))
   449						ext_err = true;
   450	
   451				ext_end = isa;
   452				if (unlikely(ext_err))
   453					break;
   454	
   455				if (!isdigit(ext_end[-1]))
   456					break;
   457	
   458				while (isdigit(*--ext_end))
   459					;
   460	
   461				if (tolower(ext_end[0]) != 'p' || !isdigit(ext_end[-1])) {
   462					++ext_end;
   463					break;
   464				}
   465	
   466				while (isdigit(*--ext_end))
   467					;
   468	
   469				++ext_end;
   470				break;
   471			default:
   472				/*
   473				 * Things are a little easier for single-letter extensions, as they
   474				 * are parsed forwards.
   475				 *
   476				 * After checking that our starting position is valid, we need to
   477				 * ensure that, when isa was incremented at the start of the loop,
   478				 * that it arrived at the start of the next extension.
   479				 *
   480				 * If we are already on a non-digit, there is nothing to do. Either
   481				 * we have a multi-letter extension's _, or the start of an
   482				 * extension.
   483				 *
   484				 * Otherwise we have found the current extension's major version
   485				 * number. Parse past it, and a subsequent p/minor version number
   486				 * if present. The `p` extension must not appear immediately after
   487				 * a number, so there is no fear of missing it.
   488				 *
   489				 */
   490				if (unlikely(!isalpha(*ext))) {
   491					ext_err = true;
   492					break;
   493				}
   494	
   495				if (!isdigit(*isa))
   496					break;
   497	
   498				while (isdigit(*++isa))
   499					;
   500	
   501				if (tolower(*isa) != 'p')
   502					break;
   503	
   504				if (!isdigit(*++isa)) {
   505					--isa;
   506					break;
   507				}
   508	
   509				while (isdigit(*++isa))
   510					;
   511	
   512				break;
   513			}
   514	
   515			/*
   516			 * The parser expects that at the start of an iteration isa points to the
   517			 * first character of the next extension. As we stop parsing an extension
   518			 * on meeting a non-alphanumeric character, an extra increment is needed
   519			 * where the succeeding extension is a multi-letter prefixed with an "_".
   520			 */
   521			if (*isa == '_')
   522				++isa;
   523	
   524			if (unlikely(ext_err))
   525				continue;
   526			if (!ext_long) {
   527				int nr = tolower(*ext) - 'a';
   528	
   529				if (riscv_isa_extension_check(nr)) {
   530					*this_hwcap |= isa2hwcap[nr];
   531					set_bit(nr, isainfo->isa);
   532				}
   533			} else {
   534				for (int i = 0; i < selected_riscv_isa_ext_count; i++)
   535					match_isa_ext(&selected_riscv_isa_ext[i], ext,
   536						      ext_end, selected_isainfo,
   537						      id_offset);
   538			}
   539		}
   540	}
   541	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

