Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6AE2049D1AB
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Jan 2022 19:25:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237445AbiAZSY7 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 26 Jan 2022 13:24:59 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:56426 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237412AbiAZSY6 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 26 Jan 2022 13:24:58 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id CCA371F3AF;
        Wed, 26 Jan 2022 18:24:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1643221497;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IoNCbcwyxnv6CxKL/uuKLe5hgsTrflJcuZ0lUaBY4Xw=;
        b=CDJ8SJfqLfzlJvW887PQ9qXRLTfNiRoSGkqof4hsIyOB2EYkjuIi9V5XZywCF64oXefHFF
        xBjlLLKSITIWSaJhCGB7EkA6s9ERjHj6HEMvyWVgn2oJSxxwUAJWrrhKudQPibPr7i9ByF
        l48J8JZmB8ytxfSOc2rnmHH98ogAhU4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1643221497;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IoNCbcwyxnv6CxKL/uuKLe5hgsTrflJcuZ0lUaBY4Xw=;
        b=IVflkwyY72ut2OljZVidqhMoUJZEZEN2SyFj+QE3uB04AVewm9TWjOe3VMAuD5X/u8tzHY
        kv+tOLvcWU44HMDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6F77013E2C;
        Wed, 26 Jan 2022 18:24:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id qDbAGPmR8WGddgAAMHmgww
        (envelope-from <pvorel@suse.cz>); Wed, 26 Jan 2022 18:24:57 +0000
Date:   Wed, 26 Jan 2022 19:24:55 +0100
From:   Petr Vorel <pvorel@suse.cz>
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "shuah@kernel.org" <shuah@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "naresh.kamboju@linaro.org" <naresh.kamboju@linaro.org>,
        "aleksei.kodanev@bell-sw.com" <aleksei.kodanev@bell-sw.com>
Subject: Re: [PATCH 1/3] selftests/zram: Remove obsolete max_comp_streams
 interface
Message-ID: <YfGR9xZ2EuMXyAzb@pevik>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <1639562171-4434-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <1146337d-718e-a369-1012-224f06bc9c2f@linuxfoundation.org>
 <61F0D9F7.1080200@fujitsu.com>
 <YfD0hiUSf40jX82d@pevik>
 <590c1f1c-2da1-583a-d055-83c15969cf80@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <590c1f1c-2da1-583a-d055-83c15969cf80@linuxfoundation.org>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

> On 1/26/22 12:13 AM, Petr Vorel wrote:
> > Hi all,

> > > on 2022/1/26 4:33, Shuah Khan wrote :
> > > > On 12/15/21 2:56 AM, Yang Xu wrote:
> > > > > Since kernel commit 43209ea2d17a ("zram: remove max_comp_streams
> > > > > internals"), zram has
> > > > > switched to per-cpu streams. Even kernel still keep this interface for
> > > > > some reasons, but
> > > > > writing to max_comp_stream doesn't take any effect. So remove it.

> > > > I get that max_comp_stream doesn't do anything since this referenced
> > > > commit. Don't we need this test on older kernels since older kernels
> > > > still support max_comp_stream?

> > > I read the following info from kernel selftest documentation
> > > https://www.kernel.org/doc/html/latest/dev-tools/kselftest.html

> > > "The kernel contains a set of “self tests” under the
> > > tools/testing/selftests/ directory. These are intended to be small tests
> > > to exercise individual code paths in the kernel. Tests are intended to
> > > be run after building, installing and booting a kernel."

> > > So, we can build older kernel(use older kernel source) if we want to
> > > test older kernel.

> > > IMO, kernel selftest is different from other testsuit(ie ltp, this
> > > shuould think about api changes because ltp may test on different kernel).
> > Yes, that's how I understand the difference with approach of in kselftest - the
> > kernel tree testsuite and LTP - the out-of-tree testsuite.


> Removing max_comp_stream test appears to be motivated by the fact it isn't
> needed on newer kernels.

> Kselftest from mainline can be run on older stable kernels. This is a use-case
> for a lot test rings. The idea is that when a new test gets added for older
> code to regression test a bug, we should be able to run that test on an older
> kernel. This is the reason why we don't remove code that can still test an older
> kernel and make sure it skips gracefully.

Thanks for clarifying this approach. It might be worth of documenting it in
dev-tools/kselftest.rst.

Kind regards,
Petr

> Hence, I won't be taking this patch.

> thanks,
> -- Shuah
