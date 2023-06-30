Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 698E674442E
	for <lists+linux-kselftest@lfdr.de>; Fri, 30 Jun 2023 23:59:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232633AbjF3V7f (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 30 Jun 2023 17:59:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232301AbjF3V7e (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 30 Jun 2023 17:59:34 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 133A8A2;
        Fri, 30 Jun 2023 14:59:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=pLmKMTTWcPlhDJRThYi3vvzrndXSToTDlby8yODzt7M=; b=3y4C9XJ6gWEjENbGqKfEqJSwFZ
        RrWhpEwYxhDjnwHjTHEvqm+WAfr4mofAYqNQ79I7ZChH9uIq7Np+198LGuJUj51epWSkWI9fJ9ifj
        HcGUTeC+VtqbsIRibCJ7uSWRlcY82Gpt15uRV6n4Wu4Dxg0VerF9K4VaDp3qdd/pX9IP4a5GqwwNZ
        mSWVOGHFAtPJWFCol90HZkADoJPUBrK0EqPjlIzvvMaEv8zTaZhH95SrUxaUc3oR1CXOQMQJrTgxl
        ivXWPkl67MvlrrRlMIvxWH1a7yksSXW63kajdMwLEvGWhZfOFdE+D8MSk+NyPc7hszuz3Lj21u1Qz
        NGr2+mKA==;
Received: from [2601:1c2:980:9ec0::2764]
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qFM8o-004dcM-2U;
        Fri, 30 Jun 2023 21:58:58 +0000
Message-ID: <4bdcf4c9-a956-f053-17bb-719889c0211d@infradead.org>
Date:   Fri, 30 Jun 2023 14:58:57 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v1] Fix documentation of panic_on_warn
Content-Language: en-US
To:     Olaf Hering <olaf@aepfle.de>, Jonathan Corbet <corbet@lwn.net>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "Steven Rostedt (Google)" <rostedt@goodmis.org>,
        Kim Phillips <kim.phillips@amd.com>,
        Wyes Karny <wyes.karny@amd.com>,
        Tiezhu Yang <yangtiezhu@loongson.cn>,
        Prarit Bhargava <prarit@redhat.com>,
        Yasuaki Ishimatsu <isimatu.yasuaki@jp.fujitsu.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        rcu@vger.kernel.org, linux-kselftest@vger.kernel.org
Cc:     Josh Triplett <josh@joshtriplett.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Shuah Khan <shuah@kernel.org>
References: <20230630145307.25865-1-olaf@aepfle.de>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20230630145307.25865-1-olaf@aepfle.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Olaf,

On 6/30/23 07:53, Olaf Hering wrote:
> The kernel cmdline option panic_on_warn expects an integer, it is not a
> plain option as documented. A number of uses in the tree figured this
> already, and use panic_on_warn=1 for their purpose.
> 
> Adjust a comment which otherwise may mislead people in the future.
> 
> Fixes: 9e3961a097 ("kernel: add panic_on_warn")
> 
> Signed-off-by: Olaf Hering <olaf@aepfle.de>
> ---
>  Documentation/admin-guide/kernel-parameters.txt | 2 +-
>  tools/testing/selftests/rcutorture/bin/kvm.sh   | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index 9e5bab29685f..15196f84df49 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -4049,7 +4049,7 @@
>  			extra details on the taint flags that users can pick
>  			to compose the bitmask to assign to panic_on_taint.
>  
> -	panic_on_warn	panic() instead of WARN().  Useful to cause kdump
> +	panic_on_warn=1	panic() instead of WARN().  Useful to cause kdump
>  			on a WARN().
>  

It's declared as an int instead of a boolean, but it's only tested for 0 or
non-0.

In any case, this update needs to be done. Thanks.

Reviewed-by: Randy Dunlap <rdunlap@infradead.org>

>  	parkbd.port=	[HW] Parallel port number the keyboard adapter is
> diff --git a/tools/testing/selftests/rcutorture/bin/kvm.sh b/tools/testing/selftests/rcutorture/bin/kvm.sh
> index 62f3b0f56e4d..d3cdc2d33d4b 100755
> --- a/tools/testing/selftests/rcutorture/bin/kvm.sh
> +++ b/tools/testing/selftests/rcutorture/bin/kvm.sh
> @@ -655,4 +655,4 @@ fi
>  # Control buffer size: --bootargs trace_buf_size=3k
>  # Get trace-buffer dumps on all oopses: --bootargs ftrace_dump_on_oops
>  # Ditto, but dump only the oopsing CPU: --bootargs ftrace_dump_on_oops=orig_cpu
> -# Heavy-handed way to also dump on warnings: --bootargs panic_on_warn
> +# Heavy-handed way to also dump on warnings: --bootargs panic_on_warn=1

-- 
~Randy
