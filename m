Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C11779BC93
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Sep 2023 02:14:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235584AbjIKVT5 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 11 Sep 2023 17:19:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239704AbjIKO0t (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 11 Sep 2023 10:26:49 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [IPv6:2a01:4f8:c010:41de::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7DE5F0;
        Mon, 11 Sep 2023 07:26:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
        s=mail; t=1694442402;
        bh=9rPJIR7/VgE+oucqSz8LYVPUYWIRRxuJj69m2jQ5Bvc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VJ1T6FelW+WTp3Jopa4eVc0iMD5D01qDNlZRt0+NLASd/ha+T13HxPEw0aMN7IVK3
         +L5ncUei0oQahGrWfywu1gYUXurwcuQKT73gn3QGCund/1GURYDDzN5oTjktHd53Wx
         1Tll16QTsAC90HCo+UJIaRBNKD2mCj2bmQLmgExM=
Date:   Mon, 11 Sep 2023 16:26:41 +0200
From:   Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To:     Willy Tarreau <w@1wt.eu>
Cc:     Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftests/nolibc: libc-test: avoid -Wstringop-overflow
 warnings
Message-ID: <cf5a2308-e241-4146-85c6-67ad924fb67c@t-8ch.de>
References: <20230910-nolibc-poll-fault-v1-1-2b7a16f48259@weissschuh.net>
 <ZP6uAT0jmseRHkzG@1wt.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZP6uAT0jmseRHkzG@1wt.eu>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Willy!

On 2023-09-11 08:04:49+0200, Willy Tarreau wrote:
> On Sun, Sep 10, 2023 at 09:29:01PM +0200, Thomas Weißschuh wrote:
> > Newer versions of glibc annotate the poll() function with
> > __attribute__(access) which triggers a compiler warning inside the
> > testcase poll_fault.
> > Avoid this by using a plain NULL which is enough for the testcase.
> > To avoid potential future warnings also adapt the other EFAULT
> > testcases, except select_fault as NULL is a valid value for its
> > argument.
> (...)
> 
> Looks good to me. I wouldn't be surprised if we're soon forced to do
> the same with select() on some archs where it might be emulated.
> 
> Feel free to push it to the shared repo.

Thanks, I pushed it to the "next" branch.

I'd also like to rebase the next branch onto v6.6-rc1, any objections?


Thomas
