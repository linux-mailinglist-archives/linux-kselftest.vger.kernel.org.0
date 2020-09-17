Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88A3A26D83D
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Sep 2020 12:00:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726410AbgIQKAS (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 17 Sep 2020 06:00:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726185AbgIQKAS (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 17 Sep 2020 06:00:18 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF14DC06174A;
        Thu, 17 Sep 2020 03:00:17 -0700 (PDT)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94)
        (envelope-from <johannes@sipsolutions.net>)
        id 1kIqi5-005Vc1-O3; Thu, 17 Sep 2020 12:00:13 +0200
Message-ID: <cfcb01c087fdd9f22a875721444a7659bceec05f.camel@sipsolutions.net>
Subject: Re: [PATCH] lib: kunit: add bitfield test conversion to KUnit
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Brendan Higgins <brendanhiggins@google.com>,
        Vitor Massaru Iha <vitor@massaru.org>
Cc:     KUnit Development <kunit-dev@googlegroups.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        kvalo@codeaurora.org
Date:   Thu, 17 Sep 2020 12:00:12 +0200
In-Reply-To: <CAFd5g47s09BfsqNx2RY1Zdp-TC4KbKgsMgr9-SHv1Nf6P9vAMQ@mail.gmail.com> (sfid-20200819_231025_419730_3D8DCC68)
References: <20200729175849.148332-1-vitor@massaru.org>
         <CAFd5g47s09BfsqNx2RY1Zdp-TC4KbKgsMgr9-SHv1Nf6P9vAMQ@mail.gmail.com>
         (sfid-20200819_231025_419730_3D8DCC68)
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, 2020-08-19 at 14:10 -0700, Brendan Higgins wrote:
> On Wed, Jul 29, 2020 at 10:58 AM Vitor Massaru Iha <vitor@massaru.org> wrote:
> > This adds the conversion of the runtime tests of test_bitfield,
> > from `lib/test_bitfield.c` to KUnit tests.
> > 
> > Please apply this commit first (linux-kselftest/kunit-fixes):
> > 3f37d14b8a3152441f36b6bc74000996679f0998 kunit: kunit_config: Fix parsing of CONFIG options with space
> > 
> > Code Style Documentation: [0]
> > 
> > Signed-off-by: Vitor Massaru Iha <vitor@massaru.org>
> > Link: [0] https://lore.kernel.org/linux-kselftest/20200620054944.167330-1-davidgow@google.com/T/#u
> 
> Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
> 
> Probably still want a review from Johannes though.

Huh, sorry, this slipped through the cracks.

Yeah, don't really care, looks fine to me? I'm not familiar with the
kunit infrastructure much yet.

Not sure I see much value in converting TEST_BITFIELD_COMPILE to a
KUNIT_CASE though, because anyway it will not compile if you enable
that? IOW, just leaving the function there without any KUNIT_CASE()
reference to it should be fine and saves you an ifdef ...

johannes

