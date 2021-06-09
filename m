Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F36E03A1E79
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Jun 2021 23:02:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229578AbhFIVEB (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 9 Jun 2021 17:04:01 -0400
Received: from mga04.intel.com ([192.55.52.120]:31842 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229527AbhFIVEB (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 9 Jun 2021 17:04:01 -0400
IronPort-SDR: yEL0uN0AFKMIk7vSjLiDQAonYoh9ocREkYIn8SaAgwl1BCo5qDWuMXp6EY7pcnr+w9zN2Ygyww
 5lUrN2z5NaDg==
X-IronPort-AV: E=McAfee;i="6200,9189,10010"; a="203318086"
X-IronPort-AV: E=Sophos;i="5.83,261,1616482800"; 
   d="scan'208";a="203318086"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2021 14:02:03 -0700
IronPort-SDR: jHK67i9aVAMOUFtnOpvYzyujkhLXNudEvJVUQ2XksTgiVkFABi3gEh1Y8kAZDcstheXu0bKGPe
 Uzb3PnyrXPnA==
X-IronPort-AV: E=Sophos;i="5.83,261,1616482800"; 
   d="scan'208";a="448438389"
Received: from rchatre-mobl3.amr.corp.intel.com (HELO [10.209.9.119]) ([10.209.9.119])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2021 14:02:01 -0700
Subject: Re: [PATCH v7 1/4] selftests/sgx: Rename 'eenter' and 'sgx_call_vdso'
To:     Jarkko Sakkinen <jarkko@kernel.org>
Cc:     shuah@kernel.org, linux-kselftest@vger.kernel.org,
        linux-sgx@vger.kernel.org,
        Dave Hansen <dave.hansen@linux.intel.com>,
        linux-kernel@vger.kernel.org
References: <20210526124740.16783-1-jarkko@kernel.org>
 <dddeda6a-0f76-8e5a-6ca8-2ad67f6411ea@intel.com>
 <20210609130030.34jkpz5pq2iumzkj@kernel.org>
From:   Reinette Chatre <reinette.chatre@intel.com>
Message-ID: <845b4145-6990-c466-86e7-93011777556c@intel.com>
Date:   Wed, 9 Jun 2021 14:02:00 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210609130030.34jkpz5pq2iumzkj@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Jarkko,

On 6/9/2021 6:00 AM, Jarkko Sakkinen wrote:
> On Mon, Jun 07, 2021 at 09:28:56AM -0700, Reinette Chatre wrote:
>> Hi Jarkko,
>>
>> On 5/26/2021 5:47 AM, Jarkko Sakkinen wrote:
>>> diff --git a/tools/testing/selftests/sgx/main.h b/tools/testing/selftests/sgx/main.h
>>> index 67211a708f04..68672fd86cf9 100644
>>> --- a/tools/testing/selftests/sgx/main.h
>>> +++ b/tools/testing/selftests/sgx/main.h
>>> @@ -35,7 +35,7 @@ bool encl_load(const char *path, struct encl *encl);
>>>    bool encl_measure(struct encl *encl);
>>>    bool encl_build(struct encl *encl);
>>> -int sgx_call_vdso(void *rdi, void *rsi, long rdx, u32 function, void *r8, void *r9,
>>> -		  struct sgx_enclave_run *run);
>>> +int sgx_enter_enclave(void *rdi, void *rsi, long rdx, u32 function, void *r8, void *r9,
>>> +		      struct sgx_enclave_run *run);
>>
>> Is there a reason why all registers except rdx are "void *"?
> 
> Evolution? It's test code.
> 
> There's neither reason to change this for no reason.
> 

One reason would be to make the code consistent. This would reduce 
confusion.

Reinette
