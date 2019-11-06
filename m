Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7F33EF1AA6
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Nov 2019 17:00:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728373AbfKFQAj (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 6 Nov 2019 11:00:39 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:57102 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727192AbfKFQAj (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 6 Nov 2019 11:00:39 -0500
Received: from [213.220.153.21] (helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1iSNjY-0003JQ-Ax; Wed, 06 Nov 2019 16:00:36 +0000
Date:   Wed, 6 Nov 2019 17:00:35 +0100
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Adrian Reber <areber@redhat.com>
Cc:     Shuah Khan <shuah@kernel.org>,
        Eugene Syromiatnikov <esyr@redhat.com>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] selftests: add tests for clone3()
Message-ID: <20191106160034.73wla62ndojfz4rq@wittgenstein>
References: <20191104131846.1076814-1-areber@redhat.com>
 <20191106155914.hzolyolz2w4hcn7w@wittgenstein>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191106155914.hzolyolz2w4hcn7w@wittgenstein>
User-Agent: NeoMutt/20180716
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Nov 06, 2019 at 04:59:14PM +0100, Christian Brauner wrote:
> On Mon, Nov 04, 2019 at 02:18:46PM +0100, Adrian Reber wrote:
> > This adds tests for clone3() with different values and sizes
> > of struct clone_args.
> > 
> > This selftest was initially part of of the clone3() with PID selftest.
> > After that patch was almost merged Eugene sent out a couple of patches
> > to fix problems with these test.
> > 
> > This commit now only contains the clone3() selftest after the LPC
> > decision to rework clone3() with PID to allow setting the PID in
> > multiple PID namespaces including all of Eugene's patches.
> > 
> > Signed-off-by: Eugene Syromiatnikov <esyr@redhat.com>
> > Signed-off-by: Adrian Reber <areber@redhat.com>
> 
> Resending, since mutt messed-up the quoting due to a new configuration I
> was testing.
> 
> A few more comments below.
> 
> Also, would you be open to adding tests here for the newly added .stack
> and .stack_size API (cf. [1])?

Actually, forget that part for now. We can do this later in a separate
patchset.

Christian
