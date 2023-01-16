Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A8C666D006
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Jan 2023 21:18:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232686AbjAPUSZ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 16 Jan 2023 15:18:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233498AbjAPUSI (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 16 Jan 2023 15:18:08 -0500
Received: from smtpout.efficios.com (unknown [IPv6:2607:5300:203:b2ee::31e5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 452451EFD0;
        Mon, 16 Jan 2023 12:18:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
        s=smtpout1; t=1673900283;
        bh=RB/4hb5fSDHu6MiJ5tBqZgpdnlPyTlnDj4FHPZRfRig=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=VCjchUtGitaBNRA5iHqeq21e02/kEW0oYvWgLh771ew1gF4fgci0AVO/cK/nhITBY
         w68f5Q/tg3SAb2DABRAkCqnKO57K3QkFJcqzoQ1jEsrgcK/b/6ZfMkIwIDIpJ6n2Ol
         EWvzDnwoErYSSCgwuxKrxOGpQS/z5ql/pv2AvsX2Umbxz68ewE8UfjI/gMMammrezV
         4SatBqedMWoGK3ZO30Oy6sXtXTGTUWI1YxqwFW3q44L2Tkc+asp/GmCH/ojvX6pqPj
         nrSHXd8N432YmbQ5duu9tYZXUspYDoTZ55CdBIcwDM17YhJjKnKJz9lWc09qE/csqY
         2+NrUgBmFxqRA==
Received: from [172.16.0.101] (192-222-180-24.qc.cable.ebox.net [192.222.180.24])
        by smtpout.efficios.com (Postfix) with ESMTPSA id 4Nwjy35tVczgXn;
        Mon, 16 Jan 2023 15:18:03 -0500 (EST)
Message-ID: <bfa719c3-bd1f-5fc4-40ab-6dc6822b7628@efficios.com>
Date:   Mon, 16 Jan 2023 15:18:37 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [tip:sched/core 7/28] rseq.c:139:37: error: 'AT_RSEQ_ALIGN'
 undeclared; did you mean 'R_SH_ALIGN'?
Content-Language: en-US
To:     kernel test robot <lkp@intel.com>, Shuah Khan <shuah@kernel.org>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        x86@kernel.org, Peter Zijlstra <peterz@infradead.org>,
        linux-kselftest@vger.kernel.org
References: <202301170348.7WLKH1pl-lkp@intel.com>
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
In-Reply-To: <202301170348.7WLKH1pl-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RDNS_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 2023-01-16 14:40, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched/core
> head:   79ba1e607d68178db7d3fe4f6a4aa38f06805e7b
> commit: 03f5c0272d1b59343144e199becc911dae52c37e [7/28] selftests/rseq: Use ELF auxiliary vector for extensible rseq
> compiler: gcc-11 (Debian 11.3.0-8) 11.3.0
> reproduce:
>          # https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/commit/?id=03f5c0272d1b59343144e199becc911dae52c37e
>          git remote add tip https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
>          git fetch --no-tags tip sched/core
>          git checkout 03f5c0272d1b59343144e199becc911dae52c37e
>          make O=/tmp/kselftest headers
>          make O=/tmp/kselftest -C tools/testing/selftests
> 
> If you fix the issue, kindly add following tag where applicable
> | Reported-by: kernel test robot <lkp@intel.com>

In order to fix this, I need to change -I../../../../usr/include/ for 
$(KHDR_INCLUDES) in tools/testing/selftests/rseq/Makefile

I can find 25 odd uses of the same pattern in the kernel selftests. 
Should I fix them all in one go ?

grep -r "../../../../usr/include/" tools/testing/selftests/ | wc -l
25

AFAIU it typically works just because the build system happens to have 
recent enough kernel headers installed in the root environment.

Thanks,

Mathieu


> 
> All errors (new ones prefixed by >>):
> 
>     rseq.c: In function 'get_rseq_feature_size':
>>> rseq.c:139:37: error: 'AT_RSEQ_ALIGN' undeclared (first use in this function); did you mean 'R_SH_ALIGN'?
>       139 |         auxv_rseq_align = getauxval(AT_RSEQ_ALIGN);
>           |                                     ^~~~~~~~~~~~~
>           |                                     R_SH_ALIGN
>     rseq.c:139:37: note: each undeclared identifier is reported only once for each function it appears in
>>> rseq.c:142:44: error: 'AT_RSEQ_FEATURE_SIZE' undeclared (first use in this function); did you mean 'ORIG_RSEQ_FEATURE_SIZE'?
>       142 |         auxv_rseq_feature_size = getauxval(AT_RSEQ_FEATURE_SIZE);
>           |                                            ^~~~~~~~~~~~~~~~~~~~
>           |                                            ORIG_RSEQ_FEATURE_SIZE
> 

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

