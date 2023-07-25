Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F26EC761FBF
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Jul 2023 19:04:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229509AbjGYREv (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 25 Jul 2023 13:04:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232488AbjGYREu (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 25 Jul 2023 13:04:50 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.155.65.254])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAF05FE;
        Tue, 25 Jul 2023 10:04:47 -0700 (PDT)
X-QQ-mid: bizesmtp66t1690304667tqzlii4e
Received: from linux-lab-host.localdomain ( [61.141.78.189])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Wed, 26 Jul 2023 01:04:26 +0800 (CST)
X-QQ-SSF: 01200000000000D0X000000A0000000
X-QQ-FEAT: v5d6m16HONVi2D/QeLQOKtGgpX/AUGXaSND1+kSKQFYjN89qSTQodb0JNIgXI
        7n9GYT7eLSDNcJH3WFIoAh/0hSRRBispqoAeWGFym4zq4GXcs/6Tx4bi9gCoU6U6UpufbmJ
        MTsX8kYizOK95mlkYom5kOQ3qf321p/e2GXOJQLE4dbLfC/PkGpIA1en4InBENVY9TJm9jd
        skSjRif1qay3YsIAwBfrHbuWj2E74Q2Xb3ajnUmn/5trsbpv3BPcIkpJhsYWvPNJoGPhiBW
        kCYCuj2tf8qWGn46pC9oyZyy2YS7j2FgilnVjWysR5Ueo4K+w0hCLn0qZiy0pmQqtmse44s
        HbVvkr8yG1WoHFnALPKneWG0VfkUJzv64PmcABkQxi6MJWBqWmI+8ivGfPjDg==
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 11331428478429360439
From:   Zhangjin Wu <falcon@tinylab.org>
To:     ammarfaizi2@gnuweeb.org
Cc:     arnd@arndb.de, falcon@tinylab.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, svens@linux.ibm.com,
        thomas@t-8ch.de, w@1wt.eu
Subject: Re: [PATCH v1 1/8] tools/nolibc: add support for powerpc
Date:   Wed, 26 Jul 2023 01:04:26 +0800
Message-Id: <20230725170426.58050-1-falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <ZL/gAORYFijgjfvH@biznet-home.integral.gnuweeb.org>
References: <ZL/gAORYFijgjfvH@biznet-home.integral.gnuweeb.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrgz:qybglogicsvrgz5a-1
X-Spam-Status: No, score=1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,RCVD_IN_VALIDITY_RPBL,SORTED_RECIPS,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi,

> Hi Zhangjin, 
> 
> On Tue, Jul 25, 2023 at 07:02:55PM +0800, Zhangjin Wu wrote:
> > Btw, have checked "=r" instead of "=a" works on i386 too for we already
> > bind the _ret variable with "RET" register, but still need to check if
> > "=a" is necessary?
> 
> I need to tell you that syscall6() for i386 can't use "r" and "=r"
> because there was a historical bug that made GCC stuck in a loop forever
> when compiling the nolibc code. It's already fixed in the latest version
> of GCC, but we should still support older compilers.
>

Thanks very much, this information is really important.

My old 'reply' is not rigorous, since the syscall6() uses stack to pass
the 6th argument, so, our new syscall.h didn't support it currently,
the syscalls I have tested about "=r" instead of "=a" were only syscall1-5().

> Ref: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=105032
> 
> I discovered that bug in 2022 in the latest version of GCC at that time,
> so it's pretty new, and those buggy versions are very likely still in
> the wild today.

Ok, so, with the new syscalls.h proposed, we'd better keep i386
syscall6() as-is.

For the left syscall1-5(), is there any risk when use '=r' instead of 'r'?

Thanks,
Zhangjin

> 
> -- 
> Ammar Faizi
