Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D49385468CF
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 Jun 2022 16:49:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348865AbiFJOtp (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 10 Jun 2022 10:49:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349530AbiFJOtI (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 10 Jun 2022 10:49:08 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F206144BE4;
        Fri, 10 Jun 2022 07:48:37 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id D5DA422142;
        Fri, 10 Jun 2022 14:48:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1654872515; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=nzSWh5rBV1A+StTwCtLelwjw28JbYq11oZnaBq7FmbI=;
        b=LZzoM2o4ZAIu6Dv2Vy/H07nR9RoEf+fwvQ+Mbn+L297C863vNLm8oPArrA5w52MOafX/tZ
        86o0JWJVbXoZye2q903q+2tWkM5j+5M6tb5gJHAW8IIIqKPfa60WSyFBxoI1288BsVBS+A
        OJTvRy2tvEFKxOXrwP4MB9JvTbo+QvU=
Received: from suse.cz (unknown [10.100.201.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id B0C392C141;
        Fri, 10 Jun 2022 14:48:35 +0000 (UTC)
Date:   Fri, 10 Jun 2022 16:48:32 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Joe Lawrence <joe.lawrence@redhat.com>
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        Marcos Paulo de Souza <mpdesouza@suse.com>,
        live-patching@vger.kernel.org, linux-kselftest@vger.kernel.org,
        shuah@kernel.org, jpoimboe@redhat.com, mbenes@suse.cz
Subject: Re: [PATCH 0/2] livepatch: Move tests from lib/livepatch to
 selftests/livepatch
Message-ID: <YqNZwBWJmi5E/Nvo@alley>
References: <20220603143242.870-1-mpdesouza@suse.com>
 <c5dc436e-2e3f-db2c-5cd5-215a9af19152@linuxfoundation.org>
 <5966397b-5577-8075-ffdd-f32e5e4ca75a@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5966397b-5577-8075-ffdd-f32e5e4ca75a@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri 2022-06-10 09:06:16, Joe Lawrence wrote:
> On 6/9/22 4:16 PM, Shuah Khan wrote:
> > On 6/3/22 8:32 AM, Marcos Paulo de Souza wrote:
> >> Hi there,
> >>
> >> The first patch moves the current livepatch tests to selftests,
> >> allowing it
> >> be better suited to contain more complex tests, like using userspace C
> >> code
> >> to use the livepatched kernel code. As a bonus it allows to use
> >> "gen_tar" to export the livepatch selftests, rebuild the modules by
> >> running make in selftests/livepatch directory and simplifies the process
> >> of creating and debugging new selftests.
> >>
> > 
> > In general selftests don't include modules. We keep test modules under lib.
> > One of the reasons is that modules have dependencies on the kernel and
> > should
> > be built when kernel is built.
> > 
> > I don't fully buy the argument that moving modules under selftest would
> > simplify
> > the process.
> > 
> 
> Hi Shuah,
> 
> I see that there is tools/testing/selftests/bpf/bpf_testmod/ which
> claims to be a "conceptually out-of-tree module".  Would similarly
> moving livepatch test modules under tools/ give us flexibility to write
> them build for multiple kernel versions?  Then one could theoretically
> build and run the latest, greatest selftests against older kernels
> (assuming the associate script/module/kernel supports the idea)?

+1

Another motivation is that the new selftest also needs
an executable binary. It would be nice to handle both modules
and binaries the same way.

Honestly, lib/* is a mess. It mixes real functionality and test
modules. The relation between the modules and tools/testing/*
is far from clear. IMHO, it would be more clean to have the related
stuff together.

Of course, we could not move all test modules from lib/* easily.
Some of them might be used on its own or even as built-in
tests. But preventing the move looks like a step in
the wrong direction to me.

Best Regards,
Petr
