Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D5A5347460
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Mar 2021 10:18:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231727AbhCXJS0 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 24 Mar 2021 05:18:26 -0400
Received: from out30-44.freemail.mail.aliyun.com ([115.124.30.44]:36578 "EHLO
        out30-44.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234618AbhCXJSI (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 24 Mar 2021 05:18:08 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04426;MF=tianjia.zhang@linux.alibaba.com;NM=1;PH=DS;RN=12;SR=0;TI=SMTPD_---0UT9hB1v_1616577484;
Received: from B-455UMD6M-2027.local(mailfrom:tianjia.zhang@linux.alibaba.com fp:SMTPD_---0UT9hB1v_1616577484)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 24 Mar 2021 17:18:04 +0800
Subject: Re: [PATCH v6] selftests/x86: Use getauxval() to simplify the code in
 sgx
To:     Borislav Petkov <bp@alien8.de>, Shuah Khan <shuah@kernel.org>
Cc:     Shuah Khan <shuah@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Sean Christopherson <seanjc@google.com>, x86@kernel.org,
        linux-sgx@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Jia Zhang <zhang.jia@linux.alibaba.com>,
        Jarkko Sakkinen <jarkko@kernel.org>
References: <20210314111621.68428-1-tianjia.zhang@linux.alibaba.com>
 <YE9ayBnFIpwGiVVr@kernel.org>
 <53c94119-bdc3-a24c-91be-6d0444c46d64@linux.alibaba.com>
 <20210323185125.GF4729@zn.tnic>
From:   Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
Message-ID: <54c62bc7-f52b-0a77-f0f9-974605ade55d@linux.alibaba.com>
Date:   Wed, 24 Mar 2021 17:18:03 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210323185125.GF4729@zn.tnic>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi,

On 3/24/21 2:51 AM, Borislav Petkov wrote:
> On Tue, Mar 23, 2021 at 11:08:25AM +0800, Tianjia Zhang wrote:
>> Take time to look at this.
> 
> A "please" wouldn't hurt.
> 

I'm very sorry that my mistake caused your hurt. Please take time to 
look at this, which tree this should be picked?

Best regards,
Tianjia
