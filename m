Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 00767D11CF
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Oct 2019 16:54:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729865AbfJIOyT (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 9 Oct 2019 10:54:19 -0400
Received: from mx2.suse.de ([195.135.220.15]:43450 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729491AbfJIOyT (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 9 Oct 2019 10:54:19 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id C4390AD6D;
        Wed,  9 Oct 2019 14:54:17 +0000 (UTC)
Date:   Wed, 9 Oct 2019 16:54:16 +0200
From:   Cyril Hrubis <chrubis@suse.cz>
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     Richard Palethorpe <richard.palethorpe@suse.com>,
        syzkaller <syzkaller@googlegroups.com>, kernelci@groups.io,
        shuah <shuah@kernel.org>, ltp@lists.linux.it,
        George Kennedy <george.kennedy@oracle.com>,
        Cyril Hrubis <chrubis@suse.com>,
        "open list : KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        automated-testing@yoctoproject.org
Subject: Re: [RFC PATCH] LTP Wrapper for Syzkaller reproducers
Message-ID: <20191009145416.GA5014@rei.lan>
References: <20191009142446.6997-1-rpalethorpe@suse.com>
 <CACT4Y+b0tTAQ0r_2gCVjjRh--Xwv=aLzh6MY=ciXMMrK+cAQsA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACT4Y+b0tTAQ0r_2gCVjjRh--Xwv=aLzh6MY=ciXMMrK+cAQsA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi!
> I don't have prior experience with LTP tests, but from reading the
> code it looks reasonable to me.
> 
> I assume that .needs_tmpdir = 1 ensures that each test runs in its own
> new temp dir, which is later removed.

Indeed, it's removed recursively by the test library.

> I've stared for a while at "rem / exec_time_start < 0.98" trying to
> understand what is that tst_timeout_remaining() returns that we want
> to kill that process when the ratio is < 0.98... provided that we
> convert 1 to float but not the other var. I failed to come up with the
> answer. I have potential answers for "<0.02" and ">0.98". But I assume
> you know what you are doing :)

The tst_timeout_remaining() returns remaining test timeout, so at test
start it returns something close to 300 seconds, since that is a default
for a LTP tests, so this would probably kill a process quite fast, if
I'm reading right, after a bit more than five seconds. I guess that this
is something intended for a quick v1 hack rather than for later use.

> Re tst_res(TINFO, "Timeout; killing reproducer"). Not sure how much it
> pollutes output on 3000 tests. If it is, it can make sense to remove
> it. Lots of tests run forever, killing it is not something of
> particular interest generally.

I guess so.

-- 
Cyril Hrubis
chrubis@suse.cz
