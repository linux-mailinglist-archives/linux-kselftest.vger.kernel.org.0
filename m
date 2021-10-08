Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE91942620B
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Oct 2021 03:32:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230402AbhJHBeC (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 7 Oct 2021 21:34:02 -0400
Received: from mga02.intel.com ([134.134.136.20]:9978 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229524AbhJHBeC (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 7 Oct 2021 21:34:02 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10130"; a="213551682"
X-IronPort-AV: E=Sophos;i="5.85,356,1624345200"; 
   d="scan'208";a="213551682"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2021 18:32:07 -0700
X-IronPort-AV: E=Sophos;i="5.85,356,1624345200"; 
   d="scan'208";a="439751495"
Received: from rongch2-mobl.ccr.corp.intel.com (HELO [10.249.172.35]) ([10.249.172.35])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2021 18:32:03 -0700
Subject: Re: [kbuild-all] Re: [PATCH v1 19/38] arm64/sme: Implement vector
 length configuration prctl()s
To:     Mark Brown <broonie@kernel.org>, kernel test robot <lkp@intel.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        kbuild-all@lists.01.org, Alan Hayward <alan.hayward@arm.com>,
        Luis Machado <luis.machado@arm.com>,
        Salil Akerkar <Salil.Akerkar@arm.com>,
        Basant Kumar Dwivedi <Basant.KumarDwivedi@arm.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org
References: <20210930181144.10029-20-broonie@kernel.org>
 <202110011351.yhJYSPTs-lkp@intel.com> <20211001124014.GB5080@sirena.org.uk>
From:   "Chen, Rong A" <rong.a.chen@intel.com>
Message-ID: <a033745b-c5d0-d56a-bf0a-95b93f7f4bab@intel.com>
Date:   Fri, 8 Oct 2021 09:32:01 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20211001124014.GB5080@sirena.org.uk>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org



On 10/1/2021 8:40 PM, Mark Brown wrote:
> On Fri, Oct 01, 2021 at 01:20:12PM +0800, kernel test robot wrote:
> 
>> config: arc-randconfig-r043-20210930 (attached as .config)
>> compiler: arc-elf-gcc (GCC) 11.2.0
> 
> I suspect you're reporting architectures in alphabetical order - can I
> suggest making a priority list of widely used architectures?  I know I
> tend to zone out issues which look like they only occur on less actively
> maintained architectures as some of them have odd architecture specific
> issues that really need to be fixed at the architecture level.
> 
> 

Hi Mark,

Thanks for your advice, we run the tests on different architectures
randomly for now, and we'll consider a priority list of widely used
architectures.

Best Regards,
Rong Chen




