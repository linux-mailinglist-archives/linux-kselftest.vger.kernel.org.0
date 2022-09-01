Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10BE65AA3F5
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 Sep 2022 01:55:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234321AbiIAXzw (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 1 Sep 2022 19:55:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233404AbiIAXzv (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 1 Sep 2022 19:55:51 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6D8F60521;
        Thu,  1 Sep 2022 16:55:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AAD78B82897;
        Thu,  1 Sep 2022 23:55:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0D4AC433D6;
        Thu,  1 Sep 2022 23:55:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662076546;
        bh=hlKF/c1q2pYEpxcRsPclintcggkXHRGlNMmrn+1h++4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pSTqy+uaYNWeoqqQuKaodnQ2nvpxHo84JildhRBzQ1WtyxTXJrUfcfwFVysWv0bLp
         jhNCW2nmNueqjNtQzh8KfSfyjJlZL7PHtPk900cnn0u5RNPD1R5c4Bq9DLvEFq6RIX
         ce77kjY7wg6dKxPg3JHJGMjSgBW+NdFkGFAv+kq9sqeWjvAIwAUogG3tlUq1wcZLy8
         4tjDAR1aUkkNR6MmO39DJfM8mKGzO4JnYCKqfwgLVzz6leRAB1DIbivs8T/EAvWaXq
         JPhYV/LWKFMmi3SQP7DZX2E/XzA47PMZp1JbWvyUp+yDYZcq3hhRoabnk8BGSb4j4i
         WYF1/YVm/v96Q==
Date:   Fri, 2 Sep 2022 02:55:40 +0300
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     linux-sgx@vger.kernel.org,
        Haitao Huang <haitao.huang@linux.intel.com>,
        Vijay Dhanraj <vijay.dhanraj@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Shuah Khan <shuah@kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH 6/6] selftests/sgx: Add a bpftrace script for tracking
 allocation errors
Message-ID: <YxFGb2387CC3vOHb@kernel.org>
References: <20220830031206.13449-1-jarkko@kernel.org>
 <20220830031206.13449-7-jarkko@kernel.org>
 <e870df49-77ed-3222-086d-ae929107f33b@intel.com>
 <YxEwGU2bkM272+QA@kernel.org>
 <85d6c3ed-665f-879e-0889-efbddba3c000@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <85d6c3ed-665f-879e-0889-efbddba3c000@intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Sep 01, 2022 at 03:34:49PM -0700, Dave Hansen wrote:
> On 9/1/22 15:20, Jarkko Sakkinen wrote:
> >>> +kr:sgx_alloc_epc_page /(uint64)retval >= (uint64)(-4095)/ {
> >>> +		 printf("sgx_alloc_epc_page: retval=%d\n", (int64)retval);
> >>> +}
> >>> +
> >>> +kr:sgx_encl_page_alloc /(uint64)retval >= (uint64)(-4095)/ {
> >>> +		 printf("sgx_encl_page_alloc: retval=%d\n", (int64)retval);
> >>> +}
> >> I guess this doesn't _hurt_, but it's also not exactly the easiest way
> >> to get this done.  You need a whole bpf toolchain.  You could also just do:
> >>
> >> 	perf probe 'sgx_encl_page_alloc%return $retval'
> >>
> >> Even *that* can be replicated in a few scant lines of shell code echoing
> >> into /sys/kernel/debug/tracing.
> > Thanks, I have not used perf that much. What if I replace
> > this with a shell script using perf? How do you use that
> > for two kretprobes?
> 
> The manpage is pretty good.
> 
> But, I'd proably be doing something along these lines:
> 
> 	perf probe 'sgx_encl_page_alloc%return ret=$retval'
> 	perf record -e probe:sgx_encl_page_alloc -aR	\
> 		--filter='ret >= 0xwhatever' sleep 1
> 	perf script
> 
> There are probably shorter ways to do it, but I'm pretty sure that works.

Thanks, will give it a shot.

BR, Jarkko
