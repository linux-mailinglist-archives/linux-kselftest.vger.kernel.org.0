Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B73FE562CFE
	for <lists+linux-kselftest@lfdr.de>; Fri,  1 Jul 2022 09:48:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235195AbiGAHsK (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 1 Jul 2022 03:48:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235509AbiGAHsF (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 1 Jul 2022 03:48:05 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7210A6D56B;
        Fri,  1 Jul 2022 00:48:02 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id D38C51FAC9;
        Fri,  1 Jul 2022 07:48:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1656661680; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZWD8HIlDYdGdJ6mpl+S9OBb2c3fFloWoRrJwT7RJx5A=;
        b=IQxNEGKPfcvkZL7LiKQXAwXxAIfZJskM6AqrosF025vVRRzcAZFOjLFHmC06+UIeHsbTmB
        5hAF9ikm9t/pnuQaOG7imcalVSdef0RmTmpbUDMF0PCLKMx+K975t2SZShwwpV8yesz1Qf
        IEHQeCxjYGUfq8NqWHyPO4Nw6ackK2M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1656661680;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZWD8HIlDYdGdJ6mpl+S9OBb2c3fFloWoRrJwT7RJx5A=;
        b=sQbIL4b2cJtucmBs4mJ76xPZvKaRBKaNAc/Q5SZEOM0VFZpkXvxPepFFAS7eL8zANPy1Us
        fazr8I6hRlk/xdDw==
Received: from pobox.suse.cz (pobox.suse.cz [10.100.2.14])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id A900C2C141;
        Fri,  1 Jul 2022 07:48:00 +0000 (UTC)
Date:   Fri, 1 Jul 2022 09:48:00 +0200 (CEST)
From:   Miroslav Benes <mbenes@suse.cz>
To:     Shuah Khan <skhan@linuxfoundation.org>
cc:     Marcos Paulo de Souza <mpdesouza@suse.com>,
        live-patching@vger.kernel.org, linux-kselftest@vger.kernel.org,
        shuah@kernel.org, jpoimboe@redhat.com, pmladek@suse.com,
        joe.lawrence@redhat.com
Subject: Re: [PATCH v2 0/2] livepatch: Move tests from lib/livepatch to
 selftests/livepatch
In-Reply-To: <3f9f91a3-4c08-52f4-1d3c-79f835271222@linuxfoundation.org>
Message-ID: <alpine.LSU.2.21.2207010931270.13603@pobox.suse.cz>
References: <20220630141226.2802-1-mpdesouza@suse.com> <3f9f91a3-4c08-52f4-1d3c-79f835271222@linuxfoundation.org>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Shuah,

On Thu, 30 Jun 2022, Shuah Khan wrote:

> On 6/30/22 8:12 AM, Marcos Paulo de Souza wrote:
> > Hi there,
> > 
> > this is the v2 of the patchset. The v1 can be found at [1]. There is only
> > one
> > change in patch 1, which changed the target directory to build the test
> > modules.
> > All other changes happen in patch 2.
> > 
> > Thanks for reviewing!
> > 
> > Changes from v1:
> > # test_modules/Makefile
> >    * Build the test modules targeting /lib/modules, instead of ksrc when
> >    building
> >      from the kernel source.
> > 
> > # test_modules/test_klp_syscall.c
> >    * Added a parameter array to receive the pids that should transition to
> >    the
> >      new system call. (suggedted by Joe)
> >    * Create a new sysfs file /sys/kernel/test_klp_syscall/npids to show how
> >    many
> >      pids from the argument need to transition to the new state. (suggested
> >      by
> >      Joe)
> >    * Fix the PPC32 support by adding the syscall wrapper for archs that
> >    select it
> >      by default, without erroring out. PPC does not set SYSCALL_WRAPPER, so
> >      having it set in v1 was a mistake. (suggested by Joe)
> >    * The aarch64 syscall prefix was added too, since the livepatch support
> >    will come soon.
> > 
> > # test_binaries/test_klp-call_getpid.c
> >    * Change %d/%u in printf (suggested byu Joe)
> >    * Change run -> stop variable name, and inverted the assignments
> >    (suggested by
> >    * Joe).
> > 
> > # File test-syscall.sh
> >    * Fixed test-syscall.sh to call test_klp-call-getpid in test_binaries dir
> >    * Load test_klp_syscall passed the pids of the test_klp-call_getpid
> >    instances.
> >      Check the sysfs file from test_klp_syscall module to check that all
> >      pids
> >      transitioned correctly. (suggested by Joe)
> >    * Simplified the loop that calls test_klp-call_getpid. (suggested by Joe)
> >    * Removed the "success" comment from the script, as it's implicit that it
> >      succeed. Otherwise load_lp would error out. (suggested by Joe)
> > 
> > * Changed the commit message of patch 2 to further detail what means
> > "tricky"
> >    when livepatching syscalls. (suggested by Joe)
> > 
> > [1]: 20220603143242.870-1-mpdesouza@suse.com
> > 
> 
> Sorry Nack on this. Let's not add modules under selftests. Any usage of
> module_init()
> doesn't belong under selftests.

as mentioned before, that ship has already sailed with 
tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c. Anyway...

You wrote before that you did not have a problem with it. And you would 
not have a problem with Marcos' approach if modules can be compiled and if 
not, the tests would fail gracefully. What has changed? If you see a 
problem in the patch set regarding this, can we fix it?
 
> Leave these under lib and use KSTM_MODULE_LOADERS to load these modules that
> live under lib.

I may misunderstand but KSTM_MODULE_LOADERS does not seem to provide the 
flexibility we need (yes, it could be hacked around, but I do not think 
that the result would be nice). See what we have in 
tools/testing/selftests/livepatch/functions.sh to make sure that a live 
patch module is properly loaded and unloaded.

My main question is different though. As Marcos mentioned before, we would 
like to have our tests really flexible and a possibility to prepare and 
load different live patch modules based on a template is a part of it. 
What is your proposal regarding this? I can imagine having a template in 
lib/livepatch/ which would not be compilable and a script in 
tools/testing/selftests/livepatch/ would copy it many times, amend the 
copies (meaning parameters would be filled in with sed or the code would 
be changed), compile them and load them. But this sounds horrible to me, 
especially when compared to Marcos' approach in this patch set which is 
quite straightforward.

Then there is an opportunity which Joe described. To run the latest 
livepatch kselftests on an older kernel. Having test modules in lib/ is 
kind of an obstacle there.

Regards

Miroslav
