Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 827B831850E
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Feb 2021 07:08:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229493AbhBKGGm (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 11 Feb 2021 01:06:42 -0500
Received: from out30-43.freemail.mail.aliyun.com ([115.124.30.43]:50024 "EHLO
        out30-43.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229457AbhBKGGl (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 11 Feb 2021 01:06:41 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04420;MF=tianjia.zhang@linux.alibaba.com;NM=1;PH=DS;RN=12;SR=0;TI=SMTPD_---0UOPAUlr_1613023556;
Received: from 30.27.210.10(mailfrom:tianjia.zhang@linux.alibaba.com fp:SMTPD_---0UOPAUlr_1613023556)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 11 Feb 2021 14:05:57 +0800
Subject: Re: [PATCH v4 3/5] x86/sgx: Optimize the free_cnt count in
 sgx_epc_section
To:     Jarkko Sakkinen <jarkko@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Sean Christopherson <seanjc@google.com>,
        Shuah Khan <shuah@kernel.org>, x86@kernel.org,
        linux-sgx@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Jia Zhang <zhang.jia@linux.alibaba.com>
References: <20210201132653.35690-1-tianjia.zhang@linux.alibaba.com>
 <20210201132653.35690-4-tianjia.zhang@linux.alibaba.com>
 <YBnKAP2fIGs7F5Xm@kernel.org>
From:   Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
Message-ID: <b801ad31-5138-c68d-df9f-30f452cc3c4b@linux.alibaba.com>
Date:   Thu, 11 Feb 2021 14:05:56 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <YBnKAP2fIGs7F5Xm@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org



On 2/3/21 5:54 AM, Jarkko Sakkinen wrote:
> On Mon, Feb 01, 2021 at 09:26:51PM +0800, Tianjia Zhang wrote:
>> 'section->free_cnt' represents the free page in sgx_epc_section,
>> which is assigned once after initialization. In fact, just after the
>> initialization is completed, the pages are in the init_laundry_list
>> list and cannot be allocated. This needs to be recovered by EREMOVE
>> of function sgx_sanitize_section() before it can be used as a page
>> that can be allocated. The sgx_sanitize_section() will be called in
>> the kernel thread ksgxd.
>>
>> This patch moves the initialization of 'section->free_cnt' from the
>> initialization function sgx_setup_epc_section() to the function
>> sgx_sanitize_section(), and then accumulates the count after the
>> successful execution of EREMOVE. This seems to be more reasonable,
>> free_cnt will also truly reflect the allocatable free pages in EPC.
>>
>> Sined-off-by: Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
>> Reviewed-by: Sean Christopherson <seanjc@google.com>
> 
> I just copy-paste my earlier response to save time sice you  seem
> to save time by ignoring it and spamming with the same obviously
> illegit patch.
> 
> https://lore.kernel.org/linux-sgx/YBGlodsOaX4cWAtl@kernel.org/
> 
> /Jarkko
> 

Sorry for the late reply, I already responded in the original email.

Best regards,
Tianjia
