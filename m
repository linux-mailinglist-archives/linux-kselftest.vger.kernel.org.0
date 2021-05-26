Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 328D0390D5D
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 May 2021 02:36:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232433AbhEZAhw (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 25 May 2021 20:37:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:48630 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232290AbhEZAhv (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 25 May 2021 20:37:51 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 337B961417;
        Wed, 26 May 2021 00:36:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621989380;
        bh=RBMGbeZu4A2cx68tY/JJKgbT/nI1ZhbnRdLIZCYQX5g=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=UcBEfJHmGEVSVZuptkZyVUdiMQLyZq+Aib3/HRZ/zpBqn7/s+WyKw8ZVC9V3qo6br
         Q6A0Zuppcfawd9EMdDnBIZxiwu8mDPuNNaI69fgt2NGYBHCFVeK6qi+nXILtskanih
         NO1qJHbY9k9Bk4JlnoNEG8doIy6O5pigyyotAgaxedBNVCMZFVxGCSKyYBVaipSlt+
         XipKLPmHWWyYEpJKVycnAre/bSxXGSNbOAld6GB6xd04gz0gCS+aVPhMliT+Weeoyj
         IMVZSGYlQqiAkEs2qb1Ni1ASGyhFlteQA5Gf2MCXlbfSNRPYEDKHo1mfYqIqQJH6N4
         i4AlpWr1pDYdQ==
Subject: Re: x86/fpu/xsave: protection key test failures
To:     Babu Moger <babu.moger@amd.com>, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        hpa@zytor.com, dave.hansen@linux.intel.com, peterz@infradead.org,
        shuah@kernel.org, jroedel@suse.de, ubizjak@gmail.com,
        viro@zeniv.linux.org.uk, jpa@git.mail.kapsi.fi,
        fenghua.yu@intel.com, kan.liang@linux.intel.com,
        akpm@linux-foundation.org, rppt@kernel.org, Fan_Yang@sjtu.edu.cn,
        anshuman.khandual@arm.com, b.thiel@posteo.de, jgross@suse.com,
        keescook@chromium.org, seanjc@google.com, mh@glandium.org,
        sashal@kernel.org, krisman@collabora.com, chang.seok.bae@intel.com,
        0x7f454c46@gmail.com, jhubbard@nvidia.com, sandipan@linux.ibm.com,
        ziy@nvidia.com, kirill.shutemov@linux.intel.com,
        suxingxing@loongson.cn, harish@linux.ibm.com,
        rong.a.chen@intel.com, linuxram@us.ibm.com, bauerman@linux.ibm.com,
        dave.kleikamp@oracle.com
References: <b2e0324a-9125-bb34-9e76-81817df27c48@amd.com>
From:   Andy Lutomirski <luto@kernel.org>
Message-ID: <a08f2575-af91-8b08-6286-be5ac80c67e5@kernel.org>
Date:   Tue, 25 May 2021 17:36:18 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <b2e0324a-9125-bb34-9e76-81817df27c48@amd.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 5/25/21 2:37 PM, Babu Moger wrote:

> Investigation so far.
> 1. The test fails on AMD(Milan) systems. Test appears to pass on Intel
> systems. Tested on old Intel system available here.

Ten cents says that you have discovered that AMD returns a synthesized
value for XINUSE[PKRU] and that write_pkru() is buggy.

Any volunteers to fix the if (!pk) case in write_pkru() and see if the
problem goes away?  (Or at least to print something for the if (!pk)
case and seee if it gets printed?)

--Andy
