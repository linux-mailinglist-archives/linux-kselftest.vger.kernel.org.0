Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 28238F31CD
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Nov 2019 15:53:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733280AbfKGOx2 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 7 Nov 2019 09:53:28 -0500
Received: from mx2.suse.de ([195.135.220.15]:47536 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729450AbfKGOx2 (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 7 Nov 2019 09:53:28 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 9B44FB00D;
        Thu,  7 Nov 2019 14:53:26 +0000 (UTC)
Date:   Thu, 7 Nov 2019 15:53:26 +0100 (CET)
From:   Miroslav Benes <mbenes@suse.cz>
To:     Joe Lawrence <joe.lawrence@redhat.com>
cc:     live-patching@vger.kernel.org, linux-kselftest@vger.kernel.org,
        shuah@kernel.org
Subject: Re: [PATCH] selftests/livepatch: filter 'taints' from dmesg
 comparison
In-Reply-To: <b0502d77-7f80-0d9b-d829-12a1039b89fe@redhat.com>
Message-ID: <alpine.LSU.2.21.1911071549340.21726@pobox.suse.cz>
References: <20191106222801.7541-1-joe.lawrence@redhat.com> <alpine.LSU.2.21.1911070939040.7917@pobox.suse.cz> <b0502d77-7f80-0d9b-d829-12a1039b89fe@redhat.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, 7 Nov 2019, Joe Lawrence wrote:

> On 11/7/19 3:42 AM, Miroslav Benes wrote:
> > On Wed, 6 Nov 2019, Joe Lawrence wrote:
> > 
> >> The livepatch selftests compare expected dmesg output to verify kernel
> >> behavior.  They currently filter out "tainting kernel with
> >> TAINT_LIVEPATCH" messages which may be logged when loading livepatch
> >> modules.
> >>
> >> Further filter the log to also drop "loading out-of-tree module taints
> >> kernel" messages in case the klp_test modules have been build without
> >> the in-tree module flag.
> > 
> > That is true, but "tainting kernel with TAINT_LIVEPATCH" should be printed
> > out even in this case. check_modinfo_livepatch() is called for all modules
> > and relies on MODINFO(livepatch, Y).
> >  > So either the bug is elsewhere or I need one more cup of tea.

Ok, the above is not relevant here.

I'm only wondering about the execution steps, because supporting modules 
lib/livepatch/ should be built as in-tree. No?
 
> I'm only half a cup in this morning myself, but...
> 
> In my scenario, I saw in the kernel log:
> 
>   % modprobe test_klp_livepatch
>   test_klp_livepatch: loading out-of-tree module taints kernel.
>   test_klp_livepatch: module verification failed: signature and/or 
> required key missing - tainting kernel
>   ...

So modprobe here should not print anything like this.

> and because check_result() only removes 'tainting' with grep -v, the expected
> log message failed to match with the actual filtered message because of the
> first 'taints' message.
> 
> So this change just adds more to the filtered out strings:
> 
>   result = dmesg | grep -v <filtered out strings> | grep <interesting 
> strings>

The code is definitely correct. You can add my 

Acked-by: Miroslav Benes <mbenes@suse.cz>

M
