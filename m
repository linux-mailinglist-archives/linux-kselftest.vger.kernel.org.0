Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C521C7441B5
	for <lists+linux-kselftest@lfdr.de>; Fri, 30 Jun 2023 20:01:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230118AbjF3SBm (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 30 Jun 2023 14:01:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbjF3SBl (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 30 Jun 2023 14:01:41 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.155.65.254])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E34735AA;
        Fri, 30 Jun 2023 11:01:38 -0700 (PDT)
X-QQ-mid: bizesmtp63t1688148087t9jegpmu
Received: from linux-lab-host.localdomain ( [119.123.131.49])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Sat, 01 Jul 2023 02:01:26 +0800 (CST)
X-QQ-SSF: 01200000000000D0W000B00A0000000
X-QQ-FEAT: QHkcO4X2U8huFrHo8l1YK+jN0cAN0mWcsFrfhBkNFui2ooTsOzApWJKLYaQfv
        DewwEYMQS98eLS0mEe5UW1f1j3adkztnHPKP0dp6DUCg8w+0Ml9OO9zRU3K2IOKwIHZb+/T
        qGcfS6AyofwJwhZlPv+B7syeNUTQ6jkRNHQ3ssBrQuxJ6Vm0SKntrGHJRgABuakUrYpw7Qa
        bcemkVGjDtoPntNLRlYHBUkJD5H7GrOQUrp/9Vb1zrtvMTOJGmN6ZAYZfof0aovYvVOgwcg
        IXGIX0Cce3cQgzN3uXwiEwFcvOuw+3bxPW44iI0Lu4GwpUMs/Rkv5XbCnUCJldhSeu17U8B
        uTInhUZGn2AXfze0xrR/aAk6bDHCWy7rxlUxnNZ
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 17191169669005312733
From:   Zhangjin Wu <falcon@tinylab.org>
To:     arnd@arndb.de
Cc:     falcon@tinylab.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux@weissschuh.net,
        thomas@t-8ch.de, w@1wt.eu
Subject: Re: [PATCH v3 03/14] selftests/nolibc: add _LARGEFILE64_SOURCE for musl
Date:   Sat,  1 Jul 2023 02:01:26 +0800
Message-Id: <20230630180126.283419-1-falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <dc7b8b17-4338-424f-a1f1-c12fb7ea08bd@app.fastmail.com>
References: <dc7b8b17-4338-424f-a1f1-c12fb7ea08bd@app.fastmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrgz:qybglogicsvrgz5a-1
X-Spam-Status: No, score=0.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi, Arnd

> On Fri, Jun 30, 2023, at 16:44, Zhangjin Wu wrote:
> > _GNU_SOURCE Implies _LARGEFILE64_SOURCE in glibc, but in musl, the
> > default configuration doesn't enable _LARGEFILE64_SOURCE.
> >
> > From include/dirent.h of musl, getdents64 is provided as getdents when
> > _LARGEFILE64_SOURCE is defined.
> >
> >     #if defined(_LARGEFILE64_SOURCE)
> >     ...
> >     #define getdents64 getdents
> >     #endif
> >
> > Let's define _LARGEFILE64_SOURCE to fix up this compile error:
> 
> I think a better solution would be to use the normal getdents() instead
> of glibc getdents64(), but then define _FILE_OFFSET_BITS=64 to tell
> glibc to use the modern version of all filesystem syscalls.
> 

Just checked the getdents manpage[1] and the nolibc code, both of glibc and
nolibc don't provide the getdents() library routine but both of them provide
the getdents64(), only musl provide getdents() by default.

And as the manpage shows, it is not easy to call getdents() with glibc, we
need manually call syscall() and define the 'dirent' struct ourselves:

    glibc does not provide a wrapper for getdents(); call getdents()
    using syscall(2).  In that case you will need to define the
    linux_dirent or linux_dirent64 structure yourself.

And for nolibc, a getdents64() with linux_dirent64 struct (with int64_t offset)
is provided, there is either no getdents() currently.

This patch aims to let nolibc-test at least compile for musl and therefore we
can easily check the new tests for musl, glibc and nolibc together.

For the 64bit offset related stuff, we'd better delay it in another patchset
(part of full rv32 support), which will convert the off_t to 64bit by default.

Thanks,
Zhangjin

[1]: https://man7.org/linux/man-pages/man2/getdents.2.html

>      Arnd
