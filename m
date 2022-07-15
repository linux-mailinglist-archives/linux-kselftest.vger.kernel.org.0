Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBD5C5763D1
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Jul 2022 16:45:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232688AbiGOOpb (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 15 Jul 2022 10:45:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbiGOOp2 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 15 Jul 2022 10:45:28 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29DE976943;
        Fri, 15 Jul 2022 07:45:28 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id DDF5A3420D;
        Fri, 15 Jul 2022 14:45:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1657896326; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=g3G4pjuQJk8lM1lZvIkd7VaTLGAghx6NIIRxNx5WBZY=;
        b=t8h0+QL9Czviq/wpBHlQRgZX0LqVA95ZsU3mP3c7enrgp4tIc1mMyrwhi1xVQEUPxI4bgx
        uIzLChQEqKJo21aPf/AbtljWPqt+eSl8ka5Zvx3yJzjBF+ZKhKXVk7E7PpJTHbaW4ezB4Q
        zoVZRJDQTikkbAv0/DwsFsgaILDEofU=
Received: from suse.cz (pathway.suse.cz [10.100.12.24])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id C124B2C141;
        Fri, 15 Jul 2022 14:45:26 +0000 (UTC)
Date:   Fri, 15 Jul 2022 16:45:26 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     Miroslav Benes <mbenes@suse.cz>,
        Marcos Paulo de Souza <mpdesouza@suse.com>,
        live-patching@vger.kernel.org, linux-kselftest@vger.kernel.org,
        shuah@kernel.org, jpoimboe@redhat.com, joe.lawrence@redhat.com
Subject: Re: [PATCH v2 0/2] livepatch: Move tests from lib/livepatch to
 selftests/livepatch
Message-ID: <20220715144526.GF2737@pathway.suse.cz>
References: <20220630141226.2802-1-mpdesouza@suse.com>
 <3f9f91a3-4c08-52f4-1d3c-79f835271222@linuxfoundation.org>
 <alpine.LSU.2.21.2207010931270.13603@pobox.suse.cz>
 <8ff95ef5-db76-171d-4c4c-a84d9981290d@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8ff95ef5-db76-171d-4c4c-a84d9981290d@linuxfoundation.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri 2022-07-01 16:13:50, Shuah Khan wrote:
> On 7/1/22 1:48 AM, Miroslav Benes wrote:
> > On Thu, 30 Jun 2022, Shuah Khan wrote:
> > > 
> > > Sorry Nack on this. Let's not add modules under selftests. Any usage of
> > > module_init()
> > > doesn't belong under selftests.
> 
> Yes I did and after reviewing and thinking about it some more, I decided this
> is the right direction go down on.

Do you have some particular reason why building modules in selftests
directory might cause problems, please?

IMHO, the reason that the test modules are in lib is because the
modules were there before selftests. Developers historically loaded them
manually or they were built-in. Selftest were added later and are just
another way how the module can be loaded. This is the case,
for example, for lib/test_printf.c.

Otherwise, I do not see any big difference between building binaries
and modules under tools/tests/selftests. As I said, in the older
thread, IMHO, it makes more sense to have the selftest sources
self-contained.


There actually seems to be a principal problem in the following use
case:

--- cut Documentation/dev-tools/kselftest.rst ---
Kselftest from mainline can be run on older stable kernels. Running tests
from mainline offers the best coverage. Several test rings run mainline
kselftest suite on stable releases. The reason is that when a new test
gets added to test existing code to regression test a bug, we should be
able to run that test on an older kernel. Hence, it is important to keep
code that can still test an older kernel and make sure it skips the test
gracefully on newer releases.
--- cut Documentation/dev-tools/kselftest.rst ---

together with

--- cut Documentation/dev-tools/kselftest.rst ---
 * First use the headers inside the kernel source and/or git repo, and then the
   system headers.  Headers for the kernel release as opposed to headers
   installed by the distro on the system should be the primary focus to be able
   to find regressions.
--- cut Documentation/dev-tools/kselftest.rst ---

It means that selftests should support running binaries built against
newer kernel sources on system running older kernel. But this might
be pretty hard to achieve and maintain.

The normal kernel rules are exactly the opposite. Old binaries must
be able to run on newer kernels. The old binaries were built against
older headers.

IMHO, the testing of stable kernels makes perfect sense. And if we
want to support it seriously than we need to allow building new
selftests against headers from the old to-be-tested kernel. And
it will be possible only when the selftests sources are as much
selfcontained as possible.

Does this makes any sense, please?

Best Regards,
Petr
