Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D077D318512
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Feb 2021 07:12:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229457AbhBKGMf (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 11 Feb 2021 01:12:35 -0500
Received: from out30-43.freemail.mail.aliyun.com ([115.124.30.43]:60152 "EHLO
        out30-43.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229451AbhBKGMe (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 11 Feb 2021 01:12:34 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04395;MF=tianjia.zhang@linux.alibaba.com;NM=1;PH=DS;RN=12;SR=0;TI=SMTPD_---0UOP3L98_1613023910;
Received: from 30.27.210.10(mailfrom:tianjia.zhang@linux.alibaba.com fp:SMTPD_---0UOP3L98_1613023910)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 11 Feb 2021 14:11:51 +0800
Subject: Re: [PATCH v4 4/5] x86/sgx: Allows ioctl PROVISION to execute before
 CREATE
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
 <20210201132653.35690-5-tianjia.zhang@linux.alibaba.com>
 <YBnKtF5irw3vImmh@kernel.org>
From:   Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
Message-ID: <7533917d-da77-68a5-f1ba-194a1d4a4f68@linux.alibaba.com>
Date:   Thu, 11 Feb 2021 14:11:50 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <YBnKtF5irw3vImmh@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org



On 2/3/21 5:57 AM, Jarkko Sakkinen wrote:
> On Mon, Feb 01, 2021 at 09:26:52PM +0800, Tianjia Zhang wrote:
>> In the function sgx_create_enclave(), the direct assignment
>> operation of attributes_mask determines that the ioctl PROVISION
>> operation must be executed after the ioctl CREATE operation,
>> which will limit the flexibility of sgx developers.
> 
> Please write acronyms correctly. It's not 'sgx'. It's 'SGX'.
> 
> Who are the "sgx developers" and how do they benefit from this?
> 
> /Jarkko
> 

It mainly refers to application developers based on SGX technology.

One of the benefits that this brings is that the PROVISION operation can 
be called before or after the enclave is created, compared to the 
previous PROVISION operation can only be executed after the enclave is 
created.

Thanks,
Tianjia
