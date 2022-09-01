Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A4385AA2FF
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 Sep 2022 00:28:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235349AbiIAW2Q (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 1 Sep 2022 18:28:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231936AbiIAW1q (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 1 Sep 2022 18:27:46 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B22847199D;
        Thu,  1 Sep 2022 15:25:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 121C7B8293A;
        Thu,  1 Sep 2022 22:24:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A03BC433D6;
        Thu,  1 Sep 2022 22:24:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662071049;
        bh=Hm8DwC0GrmApv2fYWEKeBc4h9nbEKqLf6rw3zQeK5LE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BRA5/HQdm95Mz2LfUa1n1wgpWrWr62tXwr21FmiNChxR3dk+tR7La0ns1/+OmLFH3
         qDj402hH2s4HI487xv3vXDtSJvUF/ZV8nazEmw8XomiGMfM37tsQCfkixZ5zI61FqN
         5y/11INJwlGfRNus2snrc8q2AfxMr9jaX29i1ctdJbbKzHyzwHOzOnOikY0HsMLFJY
         2MohBNhBbATg+1QniClgBEJB+K3wvaTdj86gwW+9Igs718Q21dBhrwIdeJbD3Xq818
         p01Pywux+4/9M02DGDd1MgVxBvorbC+omZMb/Avmx0t3/ABylTHV3Z39qAjD5kZvU8
         pR3cnmCaM+WWQ==
Date:   Fri, 2 Sep 2022 01:24:04 +0300
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Reinette Chatre <reinette.chatre@intel.com>
Cc:     linux-sgx@vger.kernel.org,
        Haitao Huang <haitao.huang@linux.intel.com>,
        Vijay Dhanraj <vijay.dhanraj@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Paul Menzel <pmenzel@molgen.mpg.de>,
        Shuah Khan <shuah@kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH v2 6/6] selftests/sgx: Add a bpftrace script for tracking
 allocation errors
Message-ID: <YxExBGYLGihU9jpC@kernel.org>
References: <20220831173829.126661-1-jarkko@kernel.org>
 <20220831173829.126661-7-jarkko@kernel.org>
 <048cdd4c-0454-1fb2-ebac-3bdb4cde792b@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <048cdd4c-0454-1fb2-ebac-3bdb4cde792b@intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Aug 31, 2022 at 01:09:21PM -0700, Reinette Chatre wrote:
> Hi Jarkko,
> 
> On 8/31/2022 10:38 AM, Jarkko Sakkinen wrote:
> > Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
> > ---
> > v2:
> > * Added comments.
> > ---
> >  tools/testing/selftests/sgx/alloc-error.bt | 9 +++++++++
> >  1 file changed, 9 insertions(+)
> >  create mode 100644 tools/testing/selftests/sgx/alloc-error.bt
> > 
> > diff --git a/tools/testing/selftests/sgx/alloc-error.bt b/tools/testing/selftests/sgx/alloc-error.bt
> > new file mode 100644
> > index 000000000000..0cc8b2e41852
> > --- /dev/null
> > +++ b/tools/testing/selftests/sgx/alloc-error.bt
> > @@ -0,0 +1,9 @@
> > +/* EPC allocation */
> > +kr:sgx_alloc_epc_page /(uint64)retval >= (uint64)(-4095)/ {
> > +		 printf("sgx_alloc_epc_page: retval=%d\n", (int64)retval);
> > +}
> > +
> > +/* kzalloc for struct sgx_encl_page */
> > +kr:sgx_encl_page_alloc /(uint64)retval >= (uint64)(-4095)/ {
> > +		 printf("sgx_encl_page_alloc: retval=%d\n", (int64)retval);
> > +}
> 
> I did see you response in [1]. I continue to find this
> addition very cryptic in that it assumes global familiarity
> with BPF scripting which I do not think can be assumed. I
> still think this script can benefit from a comment to describe
> what the script does and how to use it.


I think I follow Dave's advice to use perf here. I'll
make a header which explains what the script does.

BR, Jarkko
