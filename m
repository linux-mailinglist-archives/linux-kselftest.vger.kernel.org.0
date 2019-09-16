Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 55C86B35E7
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Sep 2019 09:49:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730040AbfIPHtf (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 16 Sep 2019 03:49:35 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:59276 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726648AbfIPHtf (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 16 Sep 2019 03:49:35 -0400
Received: from static-dcd-cqq-121001.business.bouyguestelecom.com ([212.194.121.1] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1i9llO-0003jD-Ll; Mon, 16 Sep 2019 07:49:34 +0000
Date:   Mon, 16 Sep 2019 09:49:34 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Eugene Syromiatnikov <esyr@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        Christian Brauner <christian@brauner.io>,
        Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
        Adrian Reber <areber@redhat.com>
Subject: Re: [PATCH v2 0/6] Update clone3 self-tests
Message-ID: <20190916074933.j33qc2z3hynpj2gf@wittgenstein>
References: <cover.1568138393.git.esyr@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1568138393.git.esyr@redhat.com>
User-Agent: NeoMutt/20180716
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Sep 10, 2019 at 07:01:30PM +0100, Eugene Syromiatnikov wrote:
> Hello.
> 
> This patch set updates clone3 selftest in several aspects:
>  - adding checks for exit_signal invalid values handling;
>  - adding clone3 to selftests targets;
>  - enabling clone3 tests on all architectures;
>  - minor cleanups of the clone3 test.
> 
> Applied on top of brauer/linux.git/for-next.

So I like this series a lot! Testing is very important.
And thanks for catching the clone3() exit_signal problem. This way we
got to release a non-broken kernel. :)

Some notes: I dropped the set_tid extension from the core process
updates for 5.4 because we ended up in a discussion that made it clear
we potentially need the ability to restore pids in multiple pid
namespaces. This means we need some more discussion and the patchset is
delayed for at least one release.
Unfortunately, this also means the test that you have based yours upon
does not exist anymore. However, the tests should not be blocked on
this. I'd encourage you to talk to Adrian (who is Cced here anyway) and
come up with a clone3() test suite I can merge. You can very likely do a
Co-Developed-by so no-ones work gets dropped. :)

Ideally I'd like to see:
- verifying passing different struct sizes works correctly
- verify that flag combinations work correctly
- verify that struct members have correct values etc. pp.

We definitely want the exit_signal test as a regression test so it
doesn't bite us again!

(Oh, please also add tool/test/selftests/clone3/ to the pidfd/core
 process MAINTAINERS entry.)

Thanks!
Christian
