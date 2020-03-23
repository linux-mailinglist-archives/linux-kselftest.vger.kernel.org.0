Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8FC9318F8D1
	for <lists+linux-kselftest@lfdr.de>; Mon, 23 Mar 2020 16:40:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727231AbgCWPk1 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 23 Mar 2020 11:40:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:40874 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726049AbgCWPk1 (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 23 Mar 2020 11:40:27 -0400
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BBB5420409;
        Mon, 23 Mar 2020 15:40:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584978027;
        bh=aEPoTGtrihRR9CH44YGoaszH2LRi7APPappXtHmIFNk=;
        h=Subject:To:References:From:Cc:Date:In-Reply-To:From;
        b=KNgh82obI3osbkUxHnuobfS9X7n1lCRLSiAiWlyeFI9Yc+/taXeC72yNyrqn0o0Sb
         IJHCafFadCeJiyrWniexKrnkgZYeWzY/KeLph4cThEXqPbV32P1qPXx4D3VNK6oV5g
         BbikkzEiPRzSs3VmfhhDHFOzAezxobj46Ii2/Ce8=
Subject: Re: [PATCH 1/2] kvm: selftests: Fix no directory error when OUTPUT
 specified
To:     Xiaoyao Li <xiaoyao.li@intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
References: <20200315093425.33600-1-xiaoyao.li@intel.com>
 <20200315093425.33600-2-xiaoyao.li@intel.com>
From:   shuah <shuah@kernel.org>
Cc:     shuah <shuah@kernel.org>
Message-ID: <99584925-69e7-7dab-7dd9-ee920ac343a0@kernel.org>
Date:   Mon, 23 Mar 2020 09:40:26 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200315093425.33600-2-xiaoyao.li@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 3/15/20 3:34 AM, Xiaoyao Li wrote:
> When build kvm selftests to an specified directory with
> 
> 	make OUTPUT=~/kvm-selftests
> 
> it encouters following error：

btw lib.mk can't handle relative paths yet. The problems
you are seeing are related to that as well. This relative
path issue should be fixed in lib.mk and not in individual
tests.

> 
> /usr/bin/ld: cannot open output file
> /home/lxy/kvm-selftests/x86_64/cr4_cpuid_sync_test: No such file or
> directory
> collect2: error: ld returned 1 exit status
> make: *** [../lib.mk:141:
> /home/lxy/kvm-selftests/x86_64/cr4_cpuid_sync_test] Error 1
> 
> Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
> ---
>   tools/testing/selftests/kvm/Makefile | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/tools/testing/selftests/kvm/Makefile b/tools/testing/selftests/kvm/Makefile
> index d91c53b726e6..86797e0242d4 100644
> --- a/tools/testing/selftests/kvm/Makefile
> +++ b/tools/testing/selftests/kvm/Makefile
> @@ -66,6 +66,7 @@ LDFLAGS += -pthread $(no-pie-option) $(pgste-option)
>   # After inclusion, $(OUTPUT) is defined and
>   # $(TEST_GEN_PROGS) starts with $(OUTPUT)/
>   include ../lib.mk
> +x := $(shell mkdir -p $(sort $(dir $(TEST_GEN_PROGS))))

lib.mk would have created the directory.

thanks,
-- Shuah

