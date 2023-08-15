Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F108777D033
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Aug 2023 18:35:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232927AbjHOQfP (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 15 Aug 2023 12:35:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238528AbjHOQfE (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 15 Aug 2023 12:35:04 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 679AD10D1;
        Tue, 15 Aug 2023 09:35:00 -0700 (PDT)
X-QQ-mid: bizesmtp66t1692117282tw997xya
Received: from linux-lab-host.localdomain ( [116.30.128.116])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Wed, 16 Aug 2023 00:34:41 +0800 (CST)
X-QQ-SSF: 01200000000000E0Y000000A0000000
X-QQ-FEAT: swyrzWPvyR1HaG6kWpZ2vB7hvs6Pz5JUZ5mp3W47yEcIUd4WjD96Ch7hUE+Wd
        F4QSHoOBCsCsx3C0xx0OMIhclFOl/0f4Fg6Mw25oZch8PK8ou8YIE7+Fk5rMruY2S2zY8NZ
        vqXLKdF3xCwzRj0T4G0+K4x3oeUAV6GdOUtDEEBhPyNVBiV3kQCbCMXLtFnEyjEuXlHicHt
        rJ0J3fAT9HNwTz6jH74izgruDXxqIX/rZ8VM3uhyFD1eLMUYfZHFPpX/iQaxaD9Duhbe+nM
        FbldypaxiWsmRA3HBYHAE8iKC25bOMi+QxVEsV0sJ6gB1EX2lQK8ofhBn4T37ai+r0c0qJq
        nm0v6IAL4rH2QYZ6k0=
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 5255109492887261266
From:   Zhangjin Wu <falcon@tinylab.org>
To:     w@1wt.eu
Cc:     arnd@arndb.de, david.laight@aculab.com, falcon@tinylab.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        tanyuan@tinylab.org, thomas@t-8ch.de
Subject: Re: [PATCH v6 2/2] tools/nolibc: fix up size inflate regression
Date:   Wed, 16 Aug 2023 00:34:36 +0800
Message-Id: <20230815163436.652522-1-falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <ZNtszQeigYuItaKA@1wt.eu>
References: <ZNtszQeigYuItaKA@1wt.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrgz:qybglogicsvrgz5a-1
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,RCVD_IN_VALIDITY_RPBL,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

> On Sun, Aug 13, 2023 at 09:39:44PM +0800, Zhangjin Wu wrote:
> > > And we're done, you can then keep the simplified __sysret() macro for all
> > > other call places.
> > > 
> > 
> > Now, this issue is near to the end ;-)
> 
> I've now pushed the simplified fix (without changing the SET_ERRNO()
> macro, enough last minute breaking changes for now) in branch
> 20230815-for-6.6-2.
> 
> The tests pass and riscv/loongarch are even very slightly smaller than
> before (~8 bytes) but again that doesn't count as it depends on how the
> compiler decides to arrange if/else branches.
>

Tested 20230815-for-6.6-2 with latest Arnd's gcc 13.2.0 (left: old, right:
new), no warning, no failure:

    // run-user
    $ for arch in ${ARCHS[@]}; do printf "%9s: " $arch; make run-user XARCH=$arch | grep status | tr '\n' ' '; \
	size nolibc-test | tail -1 | tr '\t' ' ' | tr -s ' ' | cut -d ' ' -f2; done
         i386: 160 test(s): 158 passed,   2 skipped,   0 failed => status: warning 19654 > 19508
       x86_64: 160 test(s): 158 passed,   2 skipped,   0 failed => status: warning 22337 > 22011
        arm64: 160 test(s): 158 passed,   2 skipped,   0 failed => status: warning 26292 > 25868
          arm: 160 test(s): 158 passed,   2 skipped,   0 failed => status: warning 23140 > 23112
         mips: 160 test(s): 157 passed,   3 skipped,   0 failed => status: warning 23164 > 22924   // mips-linux- has smaller size, here uses mips64
          ppc: 160 test(s): 158 passed,   2 skipped,   0 failed => status: warning 26812 > 26628
        ppc64: 160 test(s): 158 passed,   2 skipped,   0 failed => status: warning 27380 > 27204
      ppc64le: 160 test(s): 158 passed,   2 skipped,   0 failed => status: warning 28004 > 27828
        riscv: 160 test(s): 158 passed,   2 skipped,   0 failed => status: warning 22062 > 21794
         s390: 160 test(s): 157 passed,   3 skipped,   0 failed => status: warning 22592 > 22192


    // kernel build + run
           arch/board | result
          ------------|------------
      arm/vexpress-a9 | 160 test(s): 159 passed,   1 skipped,   0 failed => status: warning.
             arm/virt | 160 test(s): 156 passed,   4 skipped,   0 failed => status: warning.
         aarch64/virt | 160 test(s): 159 passed,   1 skipped,   0 failed => status: warning.
          ppc/g3beige | 160 test(s): 159 passed,   1 skipped,   0 failed => status: warning.
          ppc/ppce500 | 160 test(s): 159 passed,   1 skipped,   0 failed => status: warning.
      ppc64le/pseries | 160 test(s): 159 passed,   1 skipped,   0 failed => status: warning.
      ppc64le/powernv | 160 test(s): 159 passed,   1 skipped,   0 failed => status: warning.
        ppc64/pseries | 160 test(s): 159 passed,   1 skipped,   0 failed => status: warning.
        ppc64/powernv | 160 test(s): 159 passed,   1 skipped,   0 failed => status: warning.
              i386/pc | 160 test(s): 159 passed,   1 skipped,   0 failed => status: warning.
            x86_64/pc | 160 test(s): 159 passed,   1 skipped,   0 failed => status: warning.
         mipsel/malta | 160 test(s): 159 passed,   1 skipped,   0 failed => status: warning.
     loongarch64/virt | 160 test(s): 159 passed,   1 skipped,   0 failed => status: warning.
         riscv64/virt | 160 test(s): 159 passed,   1 skipped,   0 failed => status: warning.
s390x/s390-ccw-virtio | 160 test(s): 159 passed,   1 skipped,   0 failed => status: warning.

Thanks,
Zhangjin

> I'll let Shuah know about these late fixes.
> 
> Regards,
> Willy
