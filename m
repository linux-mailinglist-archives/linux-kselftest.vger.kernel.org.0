Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E55B5AA329
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 Sep 2022 00:35:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234217AbiIAWe6 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 1 Sep 2022 18:34:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233260AbiIAWe5 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 1 Sep 2022 18:34:57 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44F092BD6;
        Thu,  1 Sep 2022 15:34:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662071696; x=1693607696;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=FA5qX/spTqfiCSpGqBr0iu3beDdEgHb4lIJPtXUU1oI=;
  b=LWGoRv8bbvXSn5guNuH7hCTYBe2IpfypG0/f2KOP4uLg7Paiut8aJmsW
   O0935zLdfwP1wzBydGZ+8vmif5ul7GLt+Ktlzs2qNS7atP/8kvYpMdwdx
   CIRnJ6F/WAUMX1MLT3tJsKM0FPcFeDeyosbDiDbpUHytUu7333As6udMm
   F6G+AoOGLFNbCst6pzPHOBjCJHXlHxrAyNG2UU00bOChaIKTeecGVwtnf
   Orx1vSfCosU6hYsfh//8pdhvBOTMbZeaZQDnh1NZyh8Bac9Lcb8Zgvkfs
   7pS2g6KNC1bLTfK0m/Spcc+diCyyy2Gnpmc4GSitenGdGn7KRVV28/W39
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10457"; a="296625238"
X-IronPort-AV: E=Sophos;i="5.93,281,1654585200"; 
   d="scan'208";a="296625238"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2022 15:34:54 -0700
X-IronPort-AV: E=Sophos;i="5.93,281,1654585200"; 
   d="scan'208";a="941043864"
Received: from juhongpa-mobl.amr.corp.intel.com (HELO [10.209.114.48]) ([10.209.114.48])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2022 15:34:50 -0700
Message-ID: <85d6c3ed-665f-879e-0889-efbddba3c000@intel.com>
Date:   Thu, 1 Sep 2022 15:34:49 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 6/6] selftests/sgx: Add a bpftrace script for tracking
 allocation errors
Content-Language: en-US
To:     Jarkko Sakkinen <jarkko@kernel.org>
Cc:     linux-sgx@vger.kernel.org,
        Haitao Huang <haitao.huang@linux.intel.com>,
        Vijay Dhanraj <vijay.dhanraj@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Shuah Khan <shuah@kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>
References: <20220830031206.13449-1-jarkko@kernel.org>
 <20220830031206.13449-7-jarkko@kernel.org>
 <e870df49-77ed-3222-086d-ae929107f33b@intel.com>
 <YxEwGU2bkM272+QA@kernel.org>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <YxEwGU2bkM272+QA@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 9/1/22 15:20, Jarkko Sakkinen wrote:
>>> +kr:sgx_alloc_epc_page /(uint64)retval >= (uint64)(-4095)/ {
>>> +		 printf("sgx_alloc_epc_page: retval=%d\n", (int64)retval);
>>> +}
>>> +
>>> +kr:sgx_encl_page_alloc /(uint64)retval >= (uint64)(-4095)/ {
>>> +		 printf("sgx_encl_page_alloc: retval=%d\n", (int64)retval);
>>> +}
>> I guess this doesn't _hurt_, but it's also not exactly the easiest way
>> to get this done.  You need a whole bpf toolchain.  You could also just do:
>>
>> 	perf probe 'sgx_encl_page_alloc%return $retval'
>>
>> Even *that* can be replicated in a few scant lines of shell code echoing
>> into /sys/kernel/debug/tracing.
> Thanks, I have not used perf that much. What if I replace
> this with a shell script using perf? How do you use that
> for two kretprobes?

The manpage is pretty good.

But, I'd proably be doing something along these lines:

	perf probe 'sgx_encl_page_alloc%return ret=$retval'
	perf record -e probe:sgx_encl_page_alloc -aR	\
		--filter='ret >= 0xwhatever' sleep 1
	perf script

There are probably shorter ways to do it, but I'm pretty sure that works.
	
