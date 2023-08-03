Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D7FC76E255
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Aug 2023 10:02:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234293AbjHCICM (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 3 Aug 2023 04:02:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232519AbjHCIA7 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 3 Aug 2023 04:00:59 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB8B549C5;
        Thu,  3 Aug 2023 00:51:36 -0700 (PDT)
X-QQ-mid: bizesmtp63t1691049082t37lovh4
Received: from linux-lab-host.localdomain ( [116.30.131.233])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Thu, 03 Aug 2023 15:51:21 +0800 (CST)
X-QQ-SSF: 01200000000000E0X000000A0000000
X-QQ-FEAT: q+EIYT+FhZpJNnQZqE13UO0u+lKWcobXuNSUyobgDPkR8n5tc51SRyUG83dCj
        EaAODalCOPJ0Y8eYCeuOoPrGTA9n7ym8gi8axHTk+HW3JtQh8KJ+8+k3+3Ag/Kwf3LWAOMR
        xG4SyySoWR78Oy7cj7MN0KTQZT6Cs/5qPN1w7SRKorM3g2t6EHTDVOXntFLU/39gjD6XNuV
        J0a0vI2PdO0u9BM6Id0w3Q3q5qXOgOcVIc9uNuOE0irr8/LLJjovA4KU5s+8/eojb3S8T5m
        v9nXZlfjuBTwatjba7v/+y8So2lQnkojeICFhGtNQvYyyylETpBN5fKr1ofddqsvMefrenZ
        tgz4/vIG0v5NgokY1k9Fc1H21BZpJ/dg1jITvVLL6KbN/QfZhdfQwndlihW6MUcr7Uy6K2a
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 8175652093103281820
From:   Zhangjin Wu <falcon@tinylab.org>
To:     w@1wt.eu
Cc:     arnd@arndb.de, falcon@tinylab.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, tanyuan@tinylab.org,
        thomas@t-8ch.de
Subject: Re: [PATCH v4 08/12] selftests/nolibc: add test support for ppc
Date:   Thu,  3 Aug 2023 15:51:20 +0800
Message-Id: <20230803075120.76776-1-falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230803020533.GA23704@1wt.eu>
References: <20230803020533.GA23704@1wt.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrgz:qybglogicsvrgz5a-1
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,RCVD_IN_VALIDITY_RPBL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi, Willy

> On Thu, Aug 03, 2023 at 10:58:55AM +0800, Zhangjin Wu wrote:
> > Yes, ppc series at first, will renew it today. let's delay the whole tinyconfig
> > series (include part1) in v6.7, we have no enough time to test them carefully
> > for v6.6.
> 
> Thanks.
>

To even further simplify the ppc series merge progress, since Yuan have helped
me sending the standalone serial console enable patch for pmac32_defconfig [1],
and it has gotten a Reviewed-by line from the ppc maintainer, perhaps we can
safely expect it in v6.6, so, I plan to delay the nolibc-test-config related
stuff and minimize the whole ppc series to only these necessary patches:

    $ git log --reverse --oneline 813cab75752d9f2bbd71179b0c43c1052515cf48^..HEAD
    813cab75752d tools/nolibc: add support for powerpc
    122e2610c649 tools/nolibc: add support for powerpc64
    f31fe18cf2e2 selftests/nolibc: add XARCH and ARCH mapping support
    b25c71125154 selftests/nolibc: add test support for ppc
    27bc0026f1e7 selftests/nolibc: add test support for ppc64le
    d70649478ef8 (HEAD -> v6.6-nolibc-202308031233-pure-ppc-v5) selftests/nolibc: add test support for ppc64

After this ppc series, if you are still happy with parts of the left ones, I
will renew them.

[1]: https://lore.kernel.org/lkml/bb7b5f9958b3e3a20f6573ff7ce7c5dc566e7e32.1690982937.git.tanyuan@tinylab.org/

> 
> [...]
> > So, it is ok for us to simply ignore -O0 currently, let's work on them
> > in v6.7.
> 
> Yeah I'm fine with this. In the worst case those using -O0 can also avoid
> using stack-protector.
>

Yeah, let's ignore -O0 here.

but must clarify that, even with the default "-Os" from command line,
when using gcc 13.1.0, it has '__no_stack_protector' attribute but this
attribute breaks 'omit-frame-pointer' and result in segfaults. To avoid
touching the common code, I plan to let ppc32 uses its own
__no_stack_protector with '__optimize__("-fno-stack-protector")', I hope
it is fair enough now ;-)

Here is what I have added for arch-powerpc.h in the first patch of the series:

    /* FIXME: For ppc32, with newer gcc compilers (e.g. gcc 13.1.0),
     * "omit-frame-pointer" fails with __attribute__((no_stack_protector)) but
     * works with __attribute__((__optimize__("-fno-stack-protector")))
     */
    #ifdef __no_stack_protector
    #undef __no_stack_protector
    #define __no_stack_protector __attribute__((__optimize__("-fno-stack-protector")))
    #endif

If you are happy with this, v5 with come with it.

Thanks!

Best regards,
Zhangjin

> 
> Willy
