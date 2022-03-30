Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4406E4EC798
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Mar 2022 16:58:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347713AbiC3O7q (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 30 Mar 2022 10:59:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347217AbiC3O7m (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 30 Mar 2022 10:59:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0F466406;
        Wed, 30 Mar 2022 07:57:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1C719615E7;
        Wed, 30 Mar 2022 14:57:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F800C340EC;
        Wed, 30 Mar 2022 14:57:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648652272;
        bh=0ohAXybc8U6+eIxqZN8sbhR7Ie+atDMwd4Z+q/8cZrQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qOdNWakpz/tB38GgP8O5A5OkgxV+edpaqvyeXZJRKovfi9gcnM/Sfq2ktTdITpTa/
         AQKIdOXnQZW1SDESCygsZIEf86+xzsvfPN8GyAV5xPw70T1r8bTccgC2f9coijHJKr
         ZxvejzJKpznFwR+YPK/1Z24OvNTjZR1AAqsTfG2iQTTqt9Wzgyj5PP8Be4NbcSwGS4
         yNqunFW8MvG9dFtpXpe3TY1IurDIV78e9EL5ULfPbAGGyWRRCfHgJrZf9KWVqDUgCf
         7gVgHwd/LiXwi8gQsKHP+d8hePHK9ZAiDZpMcG/c5+8QZTqh/DT6QKd8PtNU6/H3tY
         jqHyp9RIRiEbg==
Date:   Wed, 30 Mar 2022 17:56:51 +0300
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Reinette Chatre <reinette.chatre@intel.com>
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Shuah Khan <shuah@kernel.org>,
        "open list:INTEL SGX" <linux-sgx@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/2] selftests/sgx: Use rip relative addressing for
 encl_stack
Message-ID: <YkRvs34K7yNt4Nz6@iki.fi>
References: <20220322074313.7444-1-jarkko@kernel.org>
 <7b7732ec-c7ff-cf92-510f-64c83ed985cd@intel.com>
 <YkRvFkEO8Ic1VdQ8@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YkRvFkEO8Ic1VdQ8@iki.fi>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Mar 30, 2022 at 05:54:18PM +0300, Jarkko Sakkinen wrote:
> On Mon, Mar 28, 2022 at 02:49:04PM -0700, Reinette Chatre wrote:
> > Hi Jarkko,
> > 
> > On 3/22/2022 12:43 AM, Jarkko Sakkinen wrote:
> > > Simplify the test_encl_bootstrap.S flow by using rip-relative addressing.
> > > Compiler does the right thing here, and this removes dependency on where
> > > TCS entries need to be located in the binary, i.e. allows the binary layout
> > > changed freely in the future.
> > > 
> > > Cc: Reinette Chatre <reinette.chatre@intel.com>
> > > Cc: Dave Hansen <dave.hansen@linux.intel.com>
> > > Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
> > > ---
> > >  tools/testing/selftests/sgx/test_encl_bootstrap.S | 6 +-----
> > >  1 file changed, 1 insertion(+), 5 deletions(-)
> > > 
> > > diff --git a/tools/testing/selftests/sgx/test_encl_bootstrap.S b/tools/testing/selftests/sgx/test_encl_bootstrap.S
> > > index 82fb0dfcbd23..1c1b5c6c4ffe 100644
> > > --- a/tools/testing/selftests/sgx/test_encl_bootstrap.S
> > > +++ b/tools/testing/selftests/sgx/test_encl_bootstrap.S
> > > @@ -40,11 +40,7 @@
> > >  	.text
> > >  
> > >  encl_entry:
> > > -	# RBX contains the base address for TCS, which is the first address
> > > -	# inside the enclave for TCS #1 and one page into the enclave for
> > > -	# TCS #2. By adding the value of encl_stack to it, we get
> > > -	# the absolute address for the stack.
> > > -	lea	(encl_stack)(%rbx), %rax
> > > +	lea	(encl_stack)(%rip), %rax
> > >  	xchg	%rsp, %rax
> > >  	push	%rax
> > >  
> > 
> > The goal of the above snippet is to set RSP to ensure that each thread has its own stack.
> > 
> > Since EENTER computes RIP as EnclaveBase + TCS.OENTRY, by using offset from RIP this
> > would result in all TCS with OENTRY of encl_entry to use the same stack, no?
> > 
> > Could you please consider the following as an alternative:
> > https://lore.kernel.org/lkml/65c137c875bd4da675eaba35316ff43d7cfd52f8.1644274683.git.reinette.chatre@intel.com/
> > 
> > The idea in that patch is that a new TCS would always need to be accompanied by a
> > dedicated stack so, at least for testing purposes, the TCS and stack can be dynamically
> > allocated together with the TCS page following its stack.  This seems much simpler
> > to me and also makes the following patch unnecessary.
> 
> There's no better alternative than use rip. Compiler will fix it up.
> 
> So, no, I won't consider that. This a dead obvious change.

How you organize TCS and stack is completely unrelated topic.

BR, Jarkko


