Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B75F0746C72
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Jul 2023 10:55:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230492AbjGDIzO (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 4 Jul 2023 04:55:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230477AbjGDIzN (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 4 Jul 2023 04:55:13 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1FD0115;
        Tue,  4 Jul 2023 01:55:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688460913; x=1719996913;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=/i2oSBocuVBzuMPrP1+dQUATQqxsM/cZlogRxGtMF7g=;
  b=SWGLExA39sviPVKSZqHYSVaVe1kOS/nGGX4JLsHl3CxiHBPE4UmKpX6O
   HRIvStzSvTkxc3SFafUphy+FG0OK9JniGQtFeri5p9xzQQSwibPHLJK/P
   EZAmN2Sq0x9fKbzNomMPzecDBdp2JNMeoJrmuCcXxzoJtHDH+plS55UVz
   M1SaT+ws72f2/8Z7ZQbLg1gZZN4l8KJ2/na3dUiHSG/3dkGxFrdv99PB+
   8lKeaDH/X31Ai4JNh/mNPsDvyKs4V8ZGWZp098C+TlS5PStO2Hxo9vj2w
   WlCwhXFgJ1x9VvPeIXv4ANyJftfHE/OqmjHfEbVLEK/aGGVmfNine4Djw
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10760"; a="365645432"
X-IronPort-AV: E=Sophos;i="6.01,180,1684825200"; 
   d="scan'208";a="365645432"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jul 2023 01:55:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10760"; a="808862255"
X-IronPort-AV: E=Sophos;i="6.01,180,1684825200"; 
   d="scan'208";a="808862255"
Received: from guoqingz-mobl1.ger.corp.intel.com (HELO [10.252.42.140]) ([10.252.42.140])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jul 2023 01:55:06 -0700
Message-ID: <2901d37a-6b5a-9076-1423-0db95b4c12d3@linux.intel.com>
Date:   Tue, 4 Jul 2023 11:55:03 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 2/2] selftests/bpf: Add test for bpf_rdtsc
Content-Language: en-US
To:     John Fastabend <john.fastabend@gmail.com>, shuah@kernel.org,
        tglx@linutronix.de, x86@kernel.org, bp@alien8.de,
        dave.hansen@linux.intel.com, mingo@redhat.com
Cc:     ast@kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, bpf@vger.kernel.org
References: <20230703105745.1314475-1-tero.kristo@linux.intel.com>
 <20230703105745.1314475-3-tero.kristo@linux.intel.com>
 <64a3450a2a062_65205208a9@john.notmuch>
From:   Tero Kristo <tero.kristo@linux.intel.com>
In-Reply-To: <64a3450a2a062_65205208a9@john.notmuch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


On 04/07/2023 01:00, John Fastabend wrote:
> Tero Kristo wrote:
>> Add selftest for bpf_rdtsc() which reads the TSC (Time Stamp Counter) on
>> x86_64 architectures. The test reads the TSC from both userspace and the
>> BPF program, and verifies the TSC values are in incremental order as
>> expected. The test is automatically skipped on architectures that do not
>> support the feature.
>>
>> Signed-off-by: Tero Kristo <tero.kristo@linux.intel.com>
>> ---
>>   .../selftests/bpf/prog_tests/test_rdtsc.c     | 67 +++++++++++++++++++
>>   .../testing/selftests/bpf/progs/test_rdtsc.c  | 21 ++++++
>>   2 files changed, 88 insertions(+)
>>   create mode 100644 tools/testing/selftests/bpf/prog_tests/test_rdtsc.c
>>   create mode 100644 tools/testing/selftests/bpf/progs/test_rdtsc.c
>>
>> diff --git a/tools/testing/selftests/bpf/prog_tests/test_rdtsc.c b/tools/testing/selftests/bpf/prog_tests/test_rdtsc.c
>> new file mode 100644
>> index 000000000000..2b26deb5b35a
>> --- /dev/null
>> +++ b/tools/testing/selftests/bpf/prog_tests/test_rdtsc.c
>> @@ -0,0 +1,67 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/* Copyright(c) 2023 Intel Corporation */
>> +
>> +#include "test_progs.h"
>> +#include "test_rdtsc.skel.h"
>> +
>> +#ifdef __x86_64__
>> +
>> +static inline u64 _rdtsc(void)
>> +{
>> +	u32 low, high;
>> +
>> +	__asm__ __volatile__("rdtscp" : "=a" (low), "=d" (high));
> I think its ok but note this could fail if user doesn't have
> access to rdtscp and iirc that can be restricted?

It is possible to restrict RDTSC access from userspace by enabling the 
TSD bit in CR4 register, and it will cause the userspace process to trap 
with general protection fault.

However, the usage of RDTSC appears to be built-in to C standard 
libraries (probably some timer routines) and enabling the CR4 TSD makes 
the system near unusable. Things like sshd + systemd also start 
generating the same general protection faults if RDTSC is blocked. Also, 
attempting to run anything at all with the BPF selftest suite causes the 
same general protection fault; not only the rdtsc test.

I tried this with couple of setups, one system running a minimalistic 
buildroot and another one running a fedora37 installation and the 
results were similar.

-Tero

>
>> +	return ((u64)high << 32) | low;
>> +}
