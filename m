Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 899A75467A3
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 Jun 2022 15:50:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244305AbiFJNuM (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 10 Jun 2022 09:50:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245415AbiFJNuK (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 10 Jun 2022 09:50:10 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1371E3B3CC;
        Fri, 10 Jun 2022 06:50:09 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id C2BCE22111;
        Fri, 10 Jun 2022 13:50:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1654869007; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=a+K6MpiFGLuX9L3kdxaOcEIxTP9iemcfqAFm7Gyr7G8=;
        b=CTJXOEwHX2TQ9aDWRygSdieTWqcDMJnJzhMBysDS2H1CYxdWtdHMFXIxr07aS8iu4ZWKAi
        0rXBYgoGTr7MHzUnI2EIO0cPhSE2LACWU6h096kTarn0wkTcPkp9KgMruu7aqzA0IR+Nl6
        T68PBxidJKw3tdSPRGQkikc33nsXszU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1654869007;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=a+K6MpiFGLuX9L3kdxaOcEIxTP9iemcfqAFm7Gyr7G8=;
        b=fRLqNWaWw3o5tB9xNfS0tsXGidfZfA1umwkgAzB6slDNr0HXoAM69HmcIosSYsH/uXnIgh
        yWiIq/y1da3so1Aw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 736C3139ED;
        Fri, 10 Jun 2022 13:50:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 4FINDg1Mo2KAUwAAMHmgww
        (envelope-from <mpdesouza@suse.de>); Fri, 10 Jun 2022 13:50:05 +0000
Date:   Fri, 10 Jun 2022 10:50:01 -0300
From:   Marcos Paulo de Souza <mpdesouza@suse.de>
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     Marcos Paulo de Souza <mpdesouza@suse.com>,
        live-patching@vger.kernel.org, linux-kselftest@vger.kernel.org,
        shuah@kernel.org, jpoimboe@redhat.com, mbenes@suse.cz,
        pmladek@suse.com
Subject: Re: [PATCH 0/2] livepatch: Move tests from lib/livepatch to
 selftests/livepatch
Message-ID: <20220610135001.pzyfothg2wetylf4@daedalus>
References: <20220603143242.870-1-mpdesouza@suse.com>
 <c5dc436e-2e3f-db2c-5cd5-215a9af19152@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c5dc436e-2e3f-db2c-5cd5-215a9af19152@linuxfoundation.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Jun 09, 2022 at 02:16:34PM -0600, Shuah Khan wrote:
> On 6/3/22 8:32 AM, Marcos Paulo de Souza wrote:
> > Hi there,
> > 
> > The first patch moves the current livepatch tests to selftests, allowing it
> > be better suited to contain more complex tests, like using userspace C code
> > to use the livepatched kernel code. As a bonus it allows to use
> > "gen_tar" to export the livepatch selftests, rebuild the modules by
> > running make in selftests/livepatch directory and simplifies the process
> > of creating and debugging new selftests.
> > 
> 
> In general selftests don't include modules. We keep test modules under lib.
> One of the reasons is that modules have dependencies on the kernel and should
> be built when kernel is built.
> 
> I don't fully buy the argument that moving modules under selftest would simplify
> the process.

As mentioned by Joe in other reply, epbf also contains a kernel module.

> 
> > It keeps the ability to execute the tests by running the shell scripts,
> > like "test-livepatch.sh", but beware that the kernel modules
> > might not be up-to-date.
> > 
> 
> I am not what you mean by this.

The plan is to upstream some tests that SUSE is using: https://github.com/lpechacek/qa_test_klp/

The current patchset implement the tc_3 from the above repository.

> 
> > The second patch includes a new test to exercise the functionality to livepatch
> > a heavy hammered function. The test uses getpid in this case.
> > 
> > I tested the changes by running the tests within the kernel source tree and running
> > from the gen_tar extracted directory.
> > 
> 
> I would like to understand the negatives of continuing to keep modules under lib?

Along with the ability to test different kernel versions by exporting the tests,
the plan is to have a template kernel module, for building them on the fly. Such
approach would benefit porting more tests from this repository.

One example is the testcase 5, which applies successive livepatches one after
another, just changing it's name. The current patchset makes this move easier in
the future.

> 
> thanks,
> -- Shuah
