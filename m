Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C74C7699FE
	for <lists+linux-kselftest@lfdr.de>; Mon, 31 Jul 2023 16:47:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230063AbjGaOrb (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 31 Jul 2023 10:47:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229790AbjGaOra (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 31 Jul 2023 10:47:30 -0400
X-Greylist: delayed 577 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 31 Jul 2023 07:47:29 PDT
Received: from smtp-42a8.mail.infomaniak.ch (smtp-42a8.mail.infomaniak.ch [84.16.66.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0252FB6
        for <linux-kselftest@vger.kernel.org>; Mon, 31 Jul 2023 07:47:28 -0700 (PDT)
Received: from smtp-2-0001.mail.infomaniak.ch (unknown [10.5.36.108])
        by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4RF1701BX8zMpnpP;
        Mon, 31 Jul 2023 14:37:48 +0000 (UTC)
Received: from unknown by smtp-2-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4RF16z0yMvzMppKq;
        Mon, 31 Jul 2023 16:37:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
        s=20191114; t=1690814268;
        bh=FbRoEBv4cNjlnd0vcW71aYM/IRrHo21jzhNdZDTwq44=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CI1ICo9+HLi8IwHyaakN7dRo7jCy4c8k/q5rNIwffnSaoAXy2SAXvnnS2+1SjcMH4
         zQ5+mvMj9525CZTVCpdZWpTxAgv+rpfeUS0ojwF0GQgEfiTksXFa1IMDbxOrTnUhpI
         oTxnsQk3SHXxB5tDW2DW5uGk0lOcfk/oOFURevGc=
Date:   Mon, 31 Jul 2023 16:37:53 +0200
From:   =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To:     limin <limin100@huawei.com>, Jeff Xu <jeffxu@google.com>
Cc:     hannes@cmpxchg.org, mhocko@kernel.org, roman.gushchin@linux.dev,
        shakeelb@google.com, songmuchun@bytedance.com, tj@kernel.org,
        lizefan.x@bytedance.com, shuah@kernel.org,
        linux-kselftest@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Jorge Lucangeli Obes <jorgelo@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH -next] selftests/landlock: Fix selftest ptrace_test run
 fail
Message-ID: <20230731.ahcei5eP4aef@digikod.net>
References: <20221128020409.1545717-1-limin100@huawei.com>
 <1232e4f3-e4b8-ff23-61e8-5465c8406f6e@digikod.net>
 <7379a5fd-5593-c6ce-40fd-c543dcf70d2b@huawei.com>
 <e62a539b-614c-c008-873a-f9c57c7ecb33@digikod.net>
 <2bc18685-f975-497f-9c20-da99dbc296c0@huawei.com>
 <ed1f6874-0f24-8145-63d4-efe28545381b@digikod.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ed1f6874-0f24-8145-63d4-efe28545381b@digikod.net>
X-Infomaniak-Routing: alpha
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi limin,

Just to let you know that Jeff's patch was merged and is available since
Linux 6.3:
https://lore.kernel.org/all/20230114020306.1407195-1-jeffxu@google.com/

Regards,
 Mickaël

On Wed, Nov 30, 2022 at 08:32:41PM +0100, Mickaël Salaün wrote:
> I checked and the Landlock ptrace test failed because Yama is enabled, which
> is expected. You can check that with /proc/sys/kernel/yama/ptrace_scope
> 
> Jeff Xu sent a patch to fix this case but it is not ready yet:
> https://lore.kernel.org/r/20220628222941.2642917-1-jeffxu@google.com
> 
> Could you please send a new patch Jeff, and add Limin in Cc?
> 
> 
> On 29/11/2022 12:26, limin wrote:
> > cat /proc/cmdline
> > BOOT_IMAGE=/vmlinuz-6.1.0-next-20221116
> > root=UUID=a65b3a79-dc02-4728-8a0c-5cf24f4ae08b ro
> > systemd.unified_cgroup_hierarchy=1 cgroup_no_v1=all
> > 
> > 
> > config
> > 
> > #
> > # Automatically generated file; DO NOT EDIT.
> > # Linux/x86 6.1.0-rc6 Kernel Configuration
> > #
> 
> [...]
> 
> > CONFIG_SECURITY_YAMA=y
> 
> [...]
> 
> > CONFIG_LSM="landlock,lockdown,yama,integrity,apparmor"
> [...]
> > 
> > On 2022/11/29 19:03, Mickaël Salaün wrote:
> > > I tested with next-20221116 and all tests are OK. Could you share your
> > > kernel configuration with a link? What is the content of /proc/cmdline?
> > > 
> > > On 29/11/2022 02:42, limin wrote:
> > > > I run test on Linux ubuntu2204 6.1.0-next-20221116
> > > > 
> > > > I did't use yama.
> > > > 
> > > > you can reproduce by this step:
> > > > 
> > > > cd kernel_src
> > > > 
> > > > cd tools/testing/selftests/landlock/
> > > > make
> > > > ./ptrace_test
> > > > 
> > > > 
> > > > 
> > > > 
> > > > On 2022/11/29 3:44, Mickaël Salaün wrote:
> > > > > This patch changes the test semantic and then cannot work on my test
> > > > > environment. On which kernel did you run test? Do you use Yama or
> > > > > something similar?
> > > > > 
> > > > > On 28/11/2022 03:04, limin wrote:
> > > > > > Tests PTRACE_ATTACH and PTRACE_MODE_READ on the parent,
> > > > > > trace parent return -1 when child== 0
> > > > > > How to reproduce warning:
> > > > > > $ make -C tools/testing/selftests TARGETS=landlock run_tests
> > > > > > 
> > > > > > Signed-off-by: limin <limin100@huawei.com>
> > > > > > ---
> > > > > >     tools/testing/selftests/landlock/ptrace_test.c | 5 ++---
> > > > > >     1 file changed, 2 insertions(+), 3 deletions(-)
> > > > > > 
> > > > > > diff --git a/tools/testing/selftests/landlock/ptrace_test.c
> > > > > > b/tools/testing/selftests/landlock/ptrace_test.c
> > > > > > index c28ef98ff3ac..88c4dc63eea0 100644
> > > > > > --- a/tools/testing/selftests/landlock/ptrace_test.c
> > > > > > +++ b/tools/testing/selftests/landlock/ptrace_test.c
> > > > > > @@ -267,12 +267,11 @@ TEST_F(hierarchy, trace)
> > > > > >             /* Tests PTRACE_ATTACH and PTRACE_MODE_READ on the
> > > > > > parent. */
> > > > > >             err_proc_read = test_ptrace_read(parent);
> > > > > >             ret = ptrace(PTRACE_ATTACH, parent, NULL, 0);
> > > > > > +        EXPECT_EQ(-1, ret);
> > > > > > +        EXPECT_EQ(EPERM, errno);
> > > > > >             if (variant->domain_child) {
> > > > > > -            EXPECT_EQ(-1, ret);
> > > > > > -            EXPECT_EQ(EPERM, errno);
> > > > > >                 EXPECT_EQ(EACCES, err_proc_read);
> > > > > >             } else {
> > > > > > -            EXPECT_EQ(0, ret);
> > > > > >                 EXPECT_EQ(0, err_proc_read);
> > > > > >             }
> > > > > >             if (ret == 0) {
