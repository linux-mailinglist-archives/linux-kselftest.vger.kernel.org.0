Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 48A37F32EB
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Nov 2019 16:25:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730221AbfKGPY7 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 7 Nov 2019 10:24:59 -0500
Received: from mx2.suse.de ([195.135.220.15]:35940 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729829AbfKGPY7 (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 7 Nov 2019 10:24:59 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id B5B45B26E;
        Thu,  7 Nov 2019 15:24:57 +0000 (UTC)
Date:   Thu, 7 Nov 2019 16:24:57 +0100 (CET)
From:   Miroslav Benes <mbenes@suse.cz>
To:     Joe Lawrence <joe.lawrence@redhat.com>
cc:     live-patching@vger.kernel.org, linux-kselftest@vger.kernel.org,
        shuah@kernel.org
Subject: Re: [PATCH] selftests/livepatch: filter 'taints' from dmesg
 comparison
In-Reply-To: <c84834ae-2382-f1e7-6924-268e05df1bf3@redhat.com>
Message-ID: <alpine.LSU.2.21.1911071619380.21726@pobox.suse.cz>
References: <20191106222801.7541-1-joe.lawrence@redhat.com> <alpine.LSU.2.21.1911070939040.7917@pobox.suse.cz> <b0502d77-7f80-0d9b-d829-12a1039b89fe@redhat.com> <alpine.LSU.2.21.1911071549340.21726@pobox.suse.cz>
 <c84834ae-2382-f1e7-6924-268e05df1bf3@redhat.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, 7 Nov 2019, Joe Lawrence wrote:

> On 11/7/19 9:53 AM, Miroslav Benes wrote:
> > On Thu, 7 Nov 2019, Joe Lawrence wrote:
> > 
> >> On 11/7/19 3:42 AM, Miroslav Benes wrote:
> >>> On Wed, 6 Nov 2019, Joe Lawrence wrote:
> >>>
> >>>> The livepatch selftests compare expected dmesg output to verify kernel
> >>>> behavior.  They currently filter out "tainting kernel with
> >>>> TAINT_LIVEPATCH" messages which may be logged when loading livepatch
> >>>> modules.
> >>>>
> >>>> Further filter the log to also drop "loading out-of-tree module taints
> >>>> kernel" messages in case the klp_test modules have been build without
> >>>> the in-tree module flag.
> >>>
> >>> That is true, but "tainting kernel with TAINT_LIVEPATCH" should be printed
> >>> out even in this case. check_modinfo_livepatch() is called for all modules
> >>> and relies on MODINFO(livepatch, Y).
> >>>   > So either the bug is elsewhere or I need one more cup of tea.
> > 
> > Ok, the above is not relevant here.
> > 
> > I'm only wondering about the execution steps, because supporting modules
> > lib/livepatch/ should be built as in-tree. No?
> >   
> 
> Ah, I see.  Well as you noted they are modprobed, so theoretically they could
> come from anywhere OOT, right?

Yes.
 
> In my test, I had a kernel tree, but only wanted to build the test modules.
> Once I did a 'make modules SUBDIR=' or 'make M= ...' KBUILD_EXTMOD got flipped
> on and the modules lost in-tree status.  No amount of googling could tell me
> how to build a single in-tree directory of modules :(

"make lib/livepatch/test_klp_livepatch.ko" should do the trick. "make 
lib/livepatch/" only builds the object files and I haven't found a way to 
make it link .ko modules other than specifying them one by one directly.

> And then it seemed that
> opening the tests for OOT modules was reasonable anyway.

That's an interesting idea. If a module is in tree, it is under our 
control. So we know what "testing capabilities" it offers. I guess that 
with OOT testing modules the selftests would have to be smarter.

Miroslav
