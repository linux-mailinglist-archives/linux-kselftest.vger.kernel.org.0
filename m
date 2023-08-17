Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 238E677FCF8
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Aug 2023 19:26:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353963AbjHQR0D (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 17 Aug 2023 13:26:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354020AbjHQRZu (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 17 Aug 2023 13:25:50 -0400
Received: from smtp-42ae.mail.infomaniak.ch (smtp-42ae.mail.infomaniak.ch [84.16.66.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3B3D30F0
        for <linux-kselftest@vger.kernel.org>; Thu, 17 Aug 2023 10:25:40 -0700 (PDT)
Received: from smtp-3-0001.mail.infomaniak.ch (unknown [10.4.36.108])
        by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4RRX2p6f4zzMpnXc;
        Thu, 17 Aug 2023 17:25:38 +0000 (UTC)
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4RRX2p3PLKzMpp9w;
        Thu, 17 Aug 2023 19:25:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
        s=20191114; t=1692293138;
        bh=PE0+Fe8t+qQGSm8O593mkNVlWvXM9VKTpTItNyLvIIE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=k2SgjlZ0puyBJ6Z/BDSFJjLkoKvAaHBqN7nq/UnmyP2wgPcngAjcVsvLrl9PzmjG9
         hDR3wXR43v4Hg231TQMRfIBU9bp4jWUdlrdC8orSdfEYXEd1CJVs+cPRjPsa/+diGr
         fqUrm21kJbVeLNgzD3tpqGaTBpCryW08ykTxcO0E=
Date:   Thu, 17 Aug 2023 19:25:32 +0200
From:   =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To:     Andre Przywara <andre.przywara@arm.com>
Cc:     Shuah Khan <shuah@kernel.org>,
        linux-security-module@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] selftests: landlock: fix runs on older systems
Message-ID: <20230817.geeciXohlu4c@digikod.net>
References: <20230809170435.1312162-1-andre.przywara@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230809170435.1312162-1-andre.przywara@arm.com>
X-Infomaniak-Routing: alpha
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Andre,

On Wed, Aug 09, 2023 at 06:04:33PM +0100, Andre Przywara wrote:
> When naively running all kselftests on some systems, it was observed
> that the landlock selftest is quite picky and reports failures, even
> though the system is fine.

Indeed, the current Landlock test suite only checks for the Landlock ABI
of the same source tree as the kselftest files, hence the strict
abi_version test.

> 
> Those two patches relax some tests to make them pass on older kernels:
> - The landlock ABI version is only "3" in recent kernels, so patch 1/2
>   relaxes the test to accept other numbers.
> - Older kernels or some defconfig based kernels might not implement
>   the landlock syscall at all. Patch 2/2 catches this.
> 
> I couldn't find an easy way to not check for the syscall availability in
> *every* test in base_test.c, short of not using TEST_HARNESS_MAIN at all.
> If someone has a better idea, I am all ears, especially as this approach
> will get quite annoying in fs_base.c.

I'd like to take such changes but we need to be more generic, and if
possible avoid being too verbose.

For the more generic part, tests should be skipped according to the
Landlock ABI of the running kernel: i.e. a test should pass iff
ABI >= N.

For the verbosity improvements, we can rely on new macros as explain in
the following email.

> 
> Cheers,
> Andre
> 
> Andre Przywara (2):
>   selftests: landlock: allow other ABI versions
>   selftests: landlock: skip all tests without landlock syscall
> 
>  tools/testing/selftests/landlock/base_test.c | 29 +++++++++++++++++++-
>  1 file changed, 28 insertions(+), 1 deletion(-)
> 
> -- 
> 2.25.1
> 
