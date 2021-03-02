Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC97732A7D9
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Mar 2021 18:26:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382776AbhCBQmr (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 2 Mar 2021 11:42:47 -0500
Received: from out30-44.freemail.mail.aliyun.com ([115.124.30.44]:46778 "EHLO
        out30-44.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1347484AbhCBFSC (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 2 Mar 2021 00:18:02 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=alimailimapcm10staff010182156082;MF=tianjia.zhang@linux.alibaba.com;NM=1;PH=DS;RN=12;SR=0;TI=SMTPD_---0UQ33OCN_1614661612;
Received: from B-455UMD6M-2027.local(mailfrom:tianjia.zhang@linux.alibaba.com fp:SMTPD_---0UQ33OCN_1614661612)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 02 Mar 2021 13:06:53 +0800
Subject: Re: [PATCH] selftests/sgx: fix EINIT failure dueto
 SGX_INVALID_SIGNATURE
To:     Jarkko Sakkinen <jarkko@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Sean Christopherson <seanjc@google.com>,
        Shuah Khan <shuah@kernel.org>, x86@kernel.org,
        linux-sgx@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Jia Zhang <zhang.jia@linux.alibaba.com>
References: <20210301051836.30738-1-tianjia.zhang@linux.alibaba.com>
 <YDy51R2Wva7s+k/x@kernel.org>
From:   Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
Message-ID: <3bcdcf04-4bed-ed95-84b6-790675f18240@linux.alibaba.com>
Date:   Tue, 2 Mar 2021 13:06:52 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <YDy51R2Wva7s+k/x@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org



On 3/1/21 5:54 PM, Jarkko Sakkinen wrote:
> On Mon, Mar 01, 2021 at 01:18:36PM +0800, Tianjia Zhang wrote:
>> q2 is not always 384-byte length. Sometimes it only has 383-byte.
> 
> What does determine this?
> 
>> In this case, the valid portion of q2 is reordered reversely for
>> little endian order, and the remaining portion is filled with zero.
> 
> I'm presuming that you want to say "In this case, q2 needs to be reversed because...".
> 
> I'm lacking these details:
> 
> 1. Why the length of Q2 can vary?
> 2. Why reversing the bytes is the correct measure to counter-measure
>     this variation?
> 
> /Jarkko
> 

When use openssl to generate a key instead of using the built-in 
sign_key.pem, there is a probability that will encounter this problem.

Here is a problematic key I encountered. The calculated q1 and q2 of 
this key are both 383 bytes, If the length is not processed, the 
hardware signature will fail.

-----BEGIN RSA PRIVATE KEY-----
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
-----END RSA PRIVATE KEY-----

good luck!

Tianjia

