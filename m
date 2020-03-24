Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8E308190367
	for <lists+linux-kselftest@lfdr.de>; Tue, 24 Mar 2020 02:51:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727149AbgCXBvg (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 23 Mar 2020 21:51:36 -0400
Received: from mga03.intel.com ([134.134.136.65]:24358 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727050AbgCXBvg (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 23 Mar 2020 21:51:36 -0400
IronPort-SDR: tkE7XLGiStJeunfMNR18/zUG/U6u16+BTsk4yH7oh29RhcIBSem9Jt10W4Z6Z9YZJMUVMr0QVr
 0sXll38iGOVg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2020 18:51:35 -0700
IronPort-SDR: DkSmitBcF1idFPhKegbkZgnxK8W+QAkDIhOiSETs6qESI5kdTSaQf+OUq6JqXOr0s7Gv0PwLaL
 Y7mHw/j3Tb7A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,298,1580803200"; 
   d="scan'208";a="270171921"
Received: from xiaoyaol-mobl.ccr.corp.intel.com (HELO [10.255.31.120]) ([10.255.31.120])
  by fmsmga004.fm.intel.com with ESMTP; 23 Mar 2020 18:51:33 -0700
Subject: Re: [PATCH 1/2] kvm: selftests: Fix no directory error when OUTPUT
 specified
To:     shuah <shuah@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
References: <20200315093425.33600-1-xiaoyao.li@intel.com>
 <20200315093425.33600-2-xiaoyao.li@intel.com>
 <99584925-69e7-7dab-7dd9-ee920ac343a0@kernel.org>
From:   Xiaoyao Li <xiaoyao.li@intel.com>
Message-ID: <cd5133e0-aafa-236e-1d08-67d4bf03c333@intel.com>
Date:   Tue, 24 Mar 2020 09:51:33 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <99584925-69e7-7dab-7dd9-ee920ac343a0@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 3/23/2020 11:40 PM, shuah wrote:
> On 3/15/20 3:34 AM, Xiaoyao Li wrote:
>> When build kvm selftests to an specified directory with
>>
>>     make OUTPUT=~/kvm-selftests
>>
>> it encouters following error：
> 
> btw lib.mk can't handle relative paths yet. The problems
> you are seeing are related to that as well.

I tried with absolute path as well. It didn't work.

> This relative
> path issue should be fixed in lib.mk and not in individual
> tests.

OK. I'll try to fix it in lib.mk

>>
>> /usr/bin/ld: cannot open output file
>> /home/lxy/kvm-selftests/x86_64/cr4_cpuid_sync_test: No such file or
>> directory
>> collect2: error: ld returned 1 exit status
>> make: *** [../lib.mk:141:
>> /home/lxy/kvm-selftests/x86_64/cr4_cpuid_sync_test] Error 1
>>
>> Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
>> ---
>>   tools/testing/selftests/kvm/Makefile | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/tools/testing/selftests/kvm/Makefile 
>> b/tools/testing/selftests/kvm/Makefile
>> index d91c53b726e6..86797e0242d4 100644
>> --- a/tools/testing/selftests/kvm/Makefile
>> +++ b/tools/testing/selftests/kvm/Makefile
>> @@ -66,6 +66,7 @@ LDFLAGS += -pthread $(no-pie-option) $(pgste-option)
>>   # After inclusion, $(OUTPUT) is defined and
>>   # $(TEST_GEN_PROGS) starts with $(OUTPUT)/
>>   include ../lib.mk
>> +x := $(shell mkdir -p $(sort $(dir $(TEST_GEN_PROGS))))
> 
> lib.mk would have created the directory.
> 
> thanks,
> -- Shuah
> 

