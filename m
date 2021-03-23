Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EEABD3455EF
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Mar 2021 04:09:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229537AbhCWDIl (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 22 Mar 2021 23:08:41 -0400
Received: from out30-57.freemail.mail.aliyun.com ([115.124.30.57]:40940 "EHLO
        out30-57.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229545AbhCWDIa (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 22 Mar 2021 23:08:30 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04420;MF=tianjia.zhang@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0UT12C85_1616468905;
Received: from B-455UMD6M-2027.local(mailfrom:tianjia.zhang@linux.alibaba.com fp:SMTPD_---0UT12C85_1616468905)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 23 Mar 2021 11:08:26 +0800
Subject: Re: [PATCH v6] selftests/x86: Use getauxval() to simplify the code in
 sgx
To:     Shuah Khan <shuah@kernel.org>, Borislav Petkov <bp@alien8.de>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Sean Christopherson <seanjc@google.com>,
        Shuah Khan <shuah@kernel.org>, x86@kernel.org,
        linux-sgx@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Jia Zhang <zhang.jia@linux.alibaba.com>
References: <20210314111621.68428-1-tianjia.zhang@linux.alibaba.com>
 <YE9ayBnFIpwGiVVr@kernel.org>
From:   Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
Message-ID: <53c94119-bdc3-a24c-91be-6d0444c46d64@linux.alibaba.com>
Date:   Tue, 23 Mar 2021 11:08:25 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <YE9ayBnFIpwGiVVr@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi,

On 3/15/21 9:02 PM, Jarkko Sakkinen wrote:
> On Sun, Mar 14, 2021 at 07:16:21PM +0800, Tianjia Zhang wrote:
>> Simplify the sgx code implemntation by using library function
>> getauxval() instead of a custom function to get the base address
>> of vDSO.
>>
>> Signed-off-by: Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
>> Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
>> Acked-by: Shuah Khan <skhan@linuxfoundation.org>
> 
> Shuah, Boris, which tree this should be picked?
> 
> /Jarkko
> 

Take time to look at this.

Best regards,
Tianjia
