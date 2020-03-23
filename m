Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8003B18F8DE
	for <lists+linux-kselftest@lfdr.de>; Mon, 23 Mar 2020 16:44:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727119AbgCWPoO (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 23 Mar 2020 11:44:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:41488 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726049AbgCWPoO (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 23 Mar 2020 11:44:14 -0400
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C4245206C3;
        Mon, 23 Mar 2020 15:44:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584978254;
        bh=Lxs1vsxvJPrZpgeL7Xki1E2hhE/XAcSmUEDRkkA22CA=;
        h=Subject:To:References:From:Date:In-Reply-To:From;
        b=z0Zrs2wPiRM08heMG9dSapEEpyvwgenp68hEKkfQ0nJPELClcWewq24pQDcZrDDLi
         P65A8XAWpn5eaQpBUjdlGONYQ9l7hbyxcsXjiND4UyXJlksfdjQtlNiz/cZJqKJohT
         fMdLXOHVYnIDv7UqhIvzzqjIlu8H7nfRrRektLRw=
Subject: Re: [PATCH 0/2] Fix errors when try to build kvm selftests on
To:     Paolo Bonzini <pbonzini@redhat.com>,
        Xiaoyao Li <xiaoyao.li@intel.com>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, shuah <shuah@kernel.org>
References: <20200315093425.33600-1-xiaoyao.li@intel.com>
 <7f7a2945-300d-d62c-e5f5-de55c2e3fd2f@redhat.com>
From:   shuah <shuah@kernel.org>
Message-ID: <ed26428d-00bc-e90c-f2ee-ee7c0f874715@kernel.org>
Date:   Mon, 23 Mar 2020 09:44:13 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <7f7a2945-300d-d62c-e5f5-de55c2e3fd2f@redhat.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 3/18/20 7:13 AM, Paolo Bonzini wrote:
> On 15/03/20 10:34, Xiaoyao Li wrote:
>> I attempted to build KVM selftests on a specified dir, unfortunately
>> neither	"make O=~/mydir TARGETS=kvm" in tools/testing/selftests, nor
>> "make OUTPUT=~/mydir" in tools/testing/selftests/kvm work.
>>
>> This series aims to make both work.
>>
>> Xiaoyao Li (2):
>>    kvm: selftests: Fix no directory error when OUTPUT specified

This definitely isn't thr right fix for this issue.

>>    selftests: export INSTALL_HDR_PATH if using "O" to specify output dir

Might be okay, but hard to find problems with the limited testing
done just on the kvm test.

>>
>>   tools/testing/selftests/Makefile     | 6 +++++-
>>   tools/testing/selftests/kvm/Makefile | 3 ++-
>>   2 files changed, 7 insertions(+), 2 deletions(-)
>>
> 
> Queued, thanks.
> 
> Paolo
> 
>
Can you please drop these for your queue. I would like to make sure
they work with other patches queued in kselftest next and would like
these go through kselftest tree.

It will be easier to find regressions when tested with other patches
to framework as opposed to limited testing on just the kvm test.

thanks,
-- Shuah
