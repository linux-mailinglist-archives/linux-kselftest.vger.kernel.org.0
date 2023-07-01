Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FEB074462E
	for <lists+linux-kselftest@lfdr.de>; Sat,  1 Jul 2023 05:25:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229484AbjGADZ1 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 30 Jun 2023 23:25:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjGADZ0 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 30 Jun 2023 23:25:26 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5A2055A7;
        Fri, 30 Jun 2023 20:25:24 -0700 (PDT)
Received: from dggpeml500012.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4QtH161LqyzqSKx;
        Sat,  1 Jul 2023 10:57:46 +0800 (CST)
Received: from localhost.localdomain (10.67.175.61) by
 dggpeml500012.china.huawei.com (7.185.36.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Sat, 1 Jul 2023 10:58:06 +0800
From:   Zheng Yejian <zhengyejian1@huawei.com>
To:     <keescook@chromium.org>
CC:     <bernd.edlinger@hotmail.de>, <ebiederm@xmission.com>,
        <limin100@huawei.com>, <linux-kernel@vger.kernel.org>,
        <linux-kselftest@vger.kernel.org>, <lizefan.x@bytedance.com>,
        <shuah@kernel.org>, <songmuchun@bytedance.com>,
        <zhengyejian1@huawei.com>
Subject: Re: [PATCH -next] selftests/ptrace: Fix Test terminated by timeout in ptrace_attach
Date:   Sat, 1 Jul 2023 22:58:33 +0800
Message-ID: <20230701145833.3604187-1-zhengyejian1@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <202212011638.31BBB562B@keescook>
References: <202212011638.31BBB562B@keescook>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.175.61]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpeml500012.china.huawei.com (7.185.36.15)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_06_12,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, 1 Dec 2022 16:48:20 -0800, Kees Cook wrote:
> On Mon, Nov 28, 2022 at 08:56:09AM +0100, Bernd Edlinger wrote:
> > thanks for cleaning this up.
>
> Oh, hm, I never saw the original email -- I'll check my Spam folder, it
> gets overly excited sometimes.
>
> > Just for completenes:
> >
> > I have actually two patches submitted a while ago, but did not get any response so far,
> > one that would make the test case work as it is:
> >
> > [PATCH v10] exec: Fix dead-lock in de_thread with ptrace_attach
> > https://lore.kernel.org/lkml/AM8PR10MB470801D01A0CF24BC32C25E7E40E9@AM8PR10MB4708.EURPRD10.PROD.OUTLOOK.COM/
> >
> > and my favorite one, that would fix the dead-lock altogether (and adjust the test case accordingly):
> >
> > [PATCH v11] exec: Fix dead-lock in de_thread with ptrace_attach
> > https://lore.kernel.org/lkml/AM8PR10MB470875B22B4C08BEAEC3F77FE4169@AM8PR10MB4708.EURPRD10.PROD.OUTLOOK.COM/
>
> This fell off my radar, but let's look at it again. Is this still an
> existing race after Eric's various refactorings? I assume so. Eric, can
> you looked at this case?
>

Kindly ping :)

This discussion suspended for half a year, but testcase 'tools/testing/selftests/ptrace/vmaccess.c'
still can not pass on the newest v6.4 kernel.

Would you continue to work it out?

:)

---

Thanks,
Zheng Yejian

> --
> Kees Cook
>
