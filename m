Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9DFE7187B30
	for <lists+linux-kselftest@lfdr.de>; Tue, 17 Mar 2020 09:27:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725871AbgCQI1v (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 17 Mar 2020 04:27:51 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:43972 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725868AbgCQI1v (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 17 Mar 2020 04:27:51 -0400
Received: from ip5f5bf7ec.dynamic.kabel-deutschland.de ([95.91.247.236] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1jE7Zj-0005z9-NS; Tue, 17 Mar 2020 08:27:47 +0000
Date:   Tue, 17 Mar 2020 09:27:46 +0100
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Hridya Valsaraju <hridya@google.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Todd Kjos <tkjos@android.com>,
        LKML <linux-kernel@vger.kernel.org>, ard.biesheuvel@linaro.org,
        ardb@kernel.org,
        Arve =?utf-8?B?SGrDuG5uZXbDpWc=?= <arve@android.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        John Stultz <john.stultz@linaro.org>,
        Android Kernel Team <kernel-team@android.com>,
        linux-kselftest@vger.kernel.org, Martijn Coenen <maco@android.com>,
        naresh.kamboju@linaro.org, shuah@kernel.org
Subject: Re: [PATCH v2 3/3] binderfs: add stress test for binderfs binder
 devices
Message-ID: <20200317082746.boc247ieui6cxvsz@wittgenstein>
References: <20200312131531.3615556-1-christian.brauner@ubuntu.com>
 <20200313152420.138777-1-christian.brauner@ubuntu.com>
 <20200313152420.138777-3-christian.brauner@ubuntu.com>
 <202003131608.DA96ECE4D@keescook>
 <CA+wgaPNETmZHeiTeV4q1YkJU=yNXfN4hap5KS_cdR7YLJHnF5w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CA+wgaPNETmZHeiTeV4q1YkJU=yNXfN4hap5KS_cdR7YLJHnF5w@mail.gmail.com>
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Mar 16, 2020 at 03:44:44PM -0700, Hridya Valsaraju wrote:
> On Fri, Mar 13, 2020 at 4:08 PM Kees Cook <keescook@chromium.org> wrote:
> >
> > On Fri, Mar 13, 2020 at 04:24:20PM +0100, Christian Brauner wrote:
> > > This adds a stress test that should hopefully help us catch regressions
> > > for [1], [2], and [3].
> > >
> > > [1]: 2669b8b0c798 ("binder: prevent UAF for binderfs devices")
> > > [2]: f0fe2c0f050d ("binder: prevent UAF for binderfs devices II")
> > > [3]: 211b64e4b5b6 ("binderfs: use refcount for binder control devices too")
> > > Cc: Kees Cook <keescook@chromium.org>:
> > > Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
> >
> > Reviewed-by: Kees Cook <keescook@chromium.org>
> >
> > -Kees
> >
> 
> Thank you for creating these tests Christian! I was able to get them
> running on the cuttlefish platform with the ACK android-mainline
> branch.

Thank you, Hridya!
Christian
