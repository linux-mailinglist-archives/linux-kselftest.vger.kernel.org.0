Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C9893B3637
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Sep 2019 10:12:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727897AbfIPIMx (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 16 Sep 2019 04:12:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38260 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726075AbfIPIMx (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 16 Sep 2019 04:12:53 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id F025830A7B81;
        Mon, 16 Sep 2019 08:12:52 +0000 (UTC)
Received: from dcbz.redhat.com (ovpn-116-67.ams2.redhat.com [10.36.116.67])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 5EC425D772;
        Mon, 16 Sep 2019 08:12:49 +0000 (UTC)
Date:   Mon, 16 Sep 2019 10:12:47 +0200
From:   Adrian Reber <areber@redhat.com>
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     Eugene Syromiatnikov <esyr@redhat.com>,
        linux-kernel@vger.kernel.org,
        Christian Brauner <christian@brauner.io>,
        Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v2 0/6] Update clone3 self-tests
Message-ID: <20190916081247.GC26734@dcbz.redhat.com>
References: <cover.1568138393.git.esyr@redhat.com>
 <20190916074933.j33qc2z3hynpj2gf@wittgenstein>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190916074933.j33qc2z3hynpj2gf@wittgenstein>
X-Operating-System: Linux (5.2.9-200.fc30.x86_64)
X-Load-Average: 1.27 1.13 1.00
X-Unexpected: The Spanish Inquisition
X-GnuPG-Key: gpg --recv-keys D3C4906A
Organization: Red Hat
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.47]); Mon, 16 Sep 2019 08:12:53 +0000 (UTC)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Sep 16, 2019 at 09:49:34AM +0200, Christian Brauner wrote:
> On Tue, Sep 10, 2019 at 07:01:30PM +0100, Eugene Syromiatnikov wrote:
> > Hello.
> > 
> > This patch set updates clone3 selftest in several aspects:
> >  - adding checks for exit_signal invalid values handling;
> >  - adding clone3 to selftests targets;
> >  - enabling clone3 tests on all architectures;
> >  - minor cleanups of the clone3 test.
> > 
> > Applied on top of brauer/linux.git/for-next.
> 
> So I like this series a lot! Testing is very important.
> And thanks for catching the clone3() exit_signal problem. This way we
> got to release a non-broken kernel. :)
> 
> Some notes: I dropped the set_tid extension from the core process
> updates for 5.4 because we ended up in a discussion that made it clear
> we potentially need the ability to restore pids in multiple pid
> namespaces. This means we need some more discussion and the patchset is
> delayed for at least one release.
> Unfortunately, this also means the test that you have based yours upon
> does not exist anymore. However, the tests should not be blocked on
> this. I'd encourage you to talk to Adrian (who is Cced here anyway) and
> come up with a clone3() test suite I can merge. You can very likely do a
> Co-Developed-by so no-ones work gets dropped. :)
> 
> Ideally I'd like to see:
> - verifying passing different struct sizes works correctly
> - verify that flag combinations work correctly
> - verify that struct members have correct values etc. pp.
> 
> We definitely want the exit_signal test as a regression test so it
> doesn't bite us again!
> 
> (Oh, please also add tool/test/selftests/clone3/ to the pidfd/core
>  process MAINTAINERS entry.)

Eugene and I have already discussed this. We will resubmit the clone3()
selftests in the next few days with all our changes combined.

		Adrian
