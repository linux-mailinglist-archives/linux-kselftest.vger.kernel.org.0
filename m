Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94DB45AA301
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 Sep 2022 00:29:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231936AbiIAW3K (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 1 Sep 2022 18:29:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235240AbiIAW2V (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 1 Sep 2022 18:28:21 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F20F9AA353;
        Thu,  1 Sep 2022 15:26:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A4F7FB8293B;
        Thu,  1 Sep 2022 22:20:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCEA0C433C1;
        Thu,  1 Sep 2022 22:20:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662070814;
        bh=mbIy7pC35PrOJa2CP0A6d4IoNVjQHLiiPSWGzJbKUYc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Hl0CIhIp4usg8pqBMh8S2ZUpSRS3y4VBReRIf2IlwmJwXyw+4ucaKSiGccSheTR1C
         nsmhZUJBJxNS/U0jEN8Bj8kQXmCnvUVaf0Ss6AE6n1wWh1PMlFWI22i/oddI/SQszd
         OSIrF9Rs2+LUHc4P9QwnJcHy5vZvbzskmHznWleANbB5MDCHXMxHmJ4We0RcG7zswL
         qt3FZkvj+JCtcYsZcS/9YxrXfOzK14tF9UeBK8U2ogHibHnF8Md3fsARcVn2YCFLt4
         sBvO7zfNcP4d21Ayt0HaONSb6sMc6t9E+SIxMK4jTDUdLVwYkDNkJksyAUsNYhljf/
         SrE5zGMClGY8g==
Date:   Fri, 2 Sep 2022 01:20:09 +0300
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
Message-ID: <YxEwGU2bkM272+QA@kernel.org>
References: <20220830031206.13449-1-jarkko@kernel.org>
 <20220830031206.13449-7-jarkko@kernel.org>
 <e870df49-77ed-3222-086d-ae929107f33b@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e870df49-77ed-3222-086d-ae929107f33b@intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Aug 31, 2022 at 11:23:55AM -0700, Dave Hansen wrote:
> On 8/29/22 20:12, Jarkko Sakkinen wrote:
> > diff --git a/tools/testing/selftests/sgx/alloc-error.bt b/tools/testing/selftests/sgx/alloc-error.bt
> > new file mode 100644
> > index 000000000000..9268d50dea29
> > --- /dev/null
> > +++ b/tools/testing/selftests/sgx/alloc-error.bt
> > @@ -0,0 +1,7 @@
> > +kr:sgx_alloc_epc_page /(uint64)retval >= (uint64)(-4095)/ {
> > +		 printf("sgx_alloc_epc_page: retval=%d\n", (int64)retval);
> > +}
> > +
> > +kr:sgx_encl_page_alloc /(uint64)retval >= (uint64)(-4095)/ {
> > +		 printf("sgx_encl_page_alloc: retval=%d\n", (int64)retval);
> > +}
> 
> I guess this doesn't _hurt_, but it's also not exactly the easiest way
> to get this done.  You need a whole bpf toolchain.  You could also just do:
> 
> 	perf probe 'sgx_encl_page_alloc%return $retval'
> 
> Even *that* can be replicated in a few scant lines of shell code echoing
> into /sys/kernel/debug/tracing.

Thanks, I have not used perf that much. What if I replace
this with a shell script using perf? How do you use that
for two kretprobes?

BR, Jarkko
