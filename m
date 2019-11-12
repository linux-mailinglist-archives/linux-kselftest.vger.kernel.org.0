Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AA431F8DAB
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Nov 2019 12:10:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727032AbfKLLKl (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 12 Nov 2019 06:10:41 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:47295 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725865AbfKLLKk (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 12 Nov 2019 06:10:40 -0500
Received: from [185.81.136.22] (helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1iUU4C-0007qy-HD; Tue, 12 Nov 2019 11:10:36 +0000
Date:   Tue, 12 Nov 2019 12:10:33 +0100
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Adrian Reber <areber@redhat.com>
Cc:     Shuah Khan <shuah@kernel.org>,
        Eugene Syromiatnikov <esyr@redhat.com>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] selftests: add tests for clone3()
Message-ID: <20191112111032.ncbbnd24lejujgxf@wittgenstein>
References: <20191112095851.811884-1-areber@redhat.com>
 <20191112102814.xkml5etvogzsr7xq@wittgenstein>
 <20191112104505.66653mgk2da7rwyh@wittgenstein>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191112104505.66653mgk2da7rwyh@wittgenstein>
User-Agent: NeoMutt/20180716
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Nov 12, 2019 at 11:45:05AM +0100, Christian Brauner wrote:
> On Tue, Nov 12, 2019 at 11:28:14AM +0100, Christian Brauner wrote:
> > On Tue, Nov 12, 2019 at 10:58:51AM +0100, Adrian Reber wrote:
> > > This adds tests for clone3() with different values and sizes
> > > of struct clone_args.
> > > 
> > > This selftest was initially part of of the clone3() with PID selftest.
> > > After that patch was almost merged Eugene sent out a couple of patches
> > > to fix problems with these test.
> > > 
> > > This commit now only contains the clone3() selftest after the LPC
> > > decision to rework clone3() with PID to allow setting the PID in
> > > multiple PID namespaces including all of Eugene's patches.
> > > 
> > > Signed-off-by: Eugene Syromiatnikov <esyr@redhat.com>
> > > Signed-off-by: Adrian Reber <areber@redhat.com>
> > 
> > Queuing up for 5.5.
> > Thanks, Adrian!
> > 
> > Reviewed-by: Christian Brauner <christian.brauner@ubuntu.com>
> 
> One thing, can you tell me what the base tree for your commit is,
> please? Given that this is just one commit it should be enough if you
> give me the "base-commit" line from the end of the patch created via:
> git format-patch --base=HEAD~1 HEAD~1

Ok, merge base commit seems to have been v5.4-rc7. I've resolved a minor
merge conflict (cf. [2]) when applying this commit to [1].

Christian

[1]: https://git.kernel.org/pub/scm/linux/kernel/git/brauner/linux.git/log/?h=pidfd
[2]:

diff --cc tools/testing/selftests/clone3/.gitignore
index 6c9f98097774,85d9d3ba2524..000000000000
--- a/tools/testing/selftests/clone3/.gitignore
+++ b/tools/testing/selftests/clone3/.gitignore
@@@ -1,1 -1,1 +1,2 @@@
+ clone3
 +clone3_clear_sighand
diff --cc tools/testing/selftests/clone3/Makefile
index e6f259321e16,ea922c014ae4..000000000000
--- a/tools/testing/selftests/clone3/Makefile
+++ b/tools/testing/selftests/clone3/Makefile
@@@ -1,6 -1,7 +1,6 @@@
- # SPDX-License-Identifier: GPL-2.0-only
+ # SPDX-License-Identifier: GPL-2.0
 +CFLAGS += -g -I../../../../usr/include/

- TEST_GEN_PROGS := clone3_clear_sighand
 -CFLAGS += -I../../../../usr/include/
 -
 -TEST_GEN_PROGS := clone3
++TEST_GEN_PROGS := clone3 clone3_clear_sighand

  include ../lib.mk
