Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CBD3712433
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 May 2023 12:08:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242591AbjEZKIF (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 26 May 2023 06:08:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229956AbjEZKIE (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 26 May 2023 06:08:04 -0400
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1FA519E;
        Fri, 26 May 2023 03:08:02 -0700 (PDT)
Received: (from willy@localhost)
        by mail.home.local (8.17.1/8.17.1/Submit) id 34QA6Oum011800;
        Fri, 26 May 2023 12:06:24 +0200
Date:   Fri, 26 May 2023 12:06:24 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Zhangjin Wu <falcon@tinylab.org>, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-riscv@lists.infradead.org,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>, thomas@t-8ch.de
Subject: Re: [PATCH 04/13] selftests/nolibc: syscall_args: use __NR_statx for
 rv32
Message-ID: <ZHCEoKXHSDlDvI5u@1wt.eu>
References: <cover.1684949267.git.falcon@tinylab.org>
 <b306ae7b53d67acad6d1e2f63d43505d79f81241.1684949267.git.falcon@tinylab.org>
 <ee8b1f02-ded1-488b-a3a5-68774f0349b5@app.fastmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ee8b1f02-ded1-488b-a3a5-68774f0349b5@app.fastmail.com>
X-Spam-Status: No, score=0.6 required=5.0 tests=BAYES_00,SORTED_RECIPS,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Arnd,

On Fri, May 26, 2023 at 11:21:02AM +0200, Arnd Bergmann wrote:
> On Wed, May 24, 2023, at 19:48, Zhangjin Wu wrote:
> 
> > 
> > +static int test_syscall_args(void)
> > +{
> > +#ifdef __NR_fstat
> > +	return syscall(__NR_fstat, 0, NULL);
> > +#elif defined(__NR_statx)
> > +	return syscall(__NR_statx, 0, NULL, 0, 0, NULL);
> > +#else
> > +#error Neither __NR_fstat nor __NR_statx defined, cannot implement 
> > syscall_args test
> > +#endif
> > +}
> 
> Does this need to work on old kernels? My impression was that
> this is only intended to be used with the kernel that ships the
> copy, so you can just rely on statx to be defined and drop
> the old fallbacks (same as for pselect6_time64 as I commented).

Yes, as much as possible this is desirable because the purpose is
clearly to simplify the build of applications. The reason is that
some applications might want to run as well on older kernels, but
may miss some syscalls on the nolibc shipped with these older ones.
Since the project is quite young, it lags a lot behind what each
kernel supports, so it's expected that users will take the most
recent nolibc version to benefit from support of syscalls that were
already present in older ones.

The alternative would be to take the project out of the kernel as it
was before but this would likely complicate contributions.

However the selftest code is clearly specific to a kernel IMHO, since
its goal is to be used to check that the shipped version of nolibc works
on this kernel.

As such, my view on this is that as long as it doesn't require
unreasonable efforts to support older kernels for the userland code,
we should try. If sometimes it's a big pain, we should not insist too
much, but at least making sure that only the feature in question will
not work would be desirable.

Thanks,
Willy
