Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8BA75CF9FE
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Oct 2019 14:37:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730906AbfJHMhT (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 8 Oct 2019 08:37:19 -0400
Received: from mx2.suse.de ([195.135.220.15]:35626 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730605AbfJHMhT (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 8 Oct 2019 08:37:19 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 0DAE7B123;
        Tue,  8 Oct 2019 12:37:18 +0000 (UTC)
References: <CACT4Y+YjOxmOzzPt_xaYE44QNZfq9haNfbnVBrTnPXe7zuSEfA@mail.gmail.com>
User-agent: mu4e 1.2.0; emacs 26.3
From:   Richard Palethorpe <rpalethorpe@suse.de>
To:     automated-testing@yoctoproject.org
Cc:     Shuah Khan <shuah@kernel.org>,
        "open list\:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, kernelci@groups.io,
        syzkaller <syzkaller@googlegroups.com>
Subject: Re: [Automated-testing] syzkaller reproducers
Reply-To: rpalethorpe@suse.de
In-reply-to: <CACT4Y+YjOxmOzzPt_xaYE44QNZfq9haNfbnVBrTnPXe7zuSEfA@mail.gmail.com>
Date:   Tue, 08 Oct 2019 14:37:17 +0200
Message-ID: <87zhibwgzm.fsf@rpws.prws.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hello,

Dmitry Vyukov <dvyukov@google.com> writes:

> Hi Shuah,
>
> We discussed collecting and uploading all syzkaller reproducers
> somewhere. You wanted to see how they look. I've uploaded all current
> reproducers here:
> https://github.com/dvyukov/syzkaller-repros
> Minimalistic build/run scripts are included.
> +some testing mailing lists too as this can be used as a test suite
> If you have any potential uses for this, you are welcome to use it.
> But then we probably need to find some more official and shared place
> for them than my private github.
> The test programs can also be bulk updated if necessary, because all
> of this is auto-generated.
>
> Thanks

I discussed this a bit with Metan. We think it would be fairly trivial
to create an LTP wrapper for these.

So we just create an LTP test which forks and execs one of these
reproducers then checks for kernel taints after the child completes or
is killed. It can take the reproducer path as an argument and we can
generate a runtest file with all the reproducers in that we are able to
compile.

I imagine a lot of these reproducers will not work on older kernels, so
this would just be a best efforts basis. We would ignore any problems
during execution unless there is a kernel error.

This should work with existing LTP runners with maybe a minor change or
two to building and configuration.

I will start experimenting with this and post the results to the LTP
mailing list.

--
Thank you,
Richard.
