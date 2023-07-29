Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 332B6767D5D
	for <lists+linux-kselftest@lfdr.de>; Sat, 29 Jul 2023 10:53:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231325AbjG2Ixp (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 29 Jul 2023 04:53:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjG2Ixo (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 29 Jul 2023 04:53:44 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81F7B3AAC;
        Sat, 29 Jul 2023 01:53:42 -0700 (PDT)
X-QQ-mid: bizesmtp90t1690620812t9ydr0if
Received: from linux-lab-host.localdomain ( [61.141.77.223])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Sat, 29 Jul 2023 16:53:31 +0800 (CST)
X-QQ-SSF: 01200000000000E0X000000A0000000
X-QQ-FEAT: CR3LFp2JE4n6SVVfIXGwQratCiG2siFVOsRGJG7IryRP8BSgKRAWimrsaivU6
        6v0uB3y9xBvbzV/MNFljiVWwo6lLovkVYaZtPYFfQL8fRaXG3QjZ92ERmRs0vWUn166DAgV
        mTADFX6KQGgRgmxmqgtjpvAEVDu8QLm2uP9t72i6Gx5twsAHfBn4peb5uKJXLYLQbPc9KnV
        G/t0XqxeEtA3yl42JZypwCg1kXc/XH2QtKW/zlqkIGPYMkEWWrSZmNg0f9QK0K2kh0qvASe
        zew0/V0g2bMBLREdHg08ISlbTqfshX1QZFFJ+dnzC9hNXKxzHvKy8nU3rNvpYGnwgMaDxSl
        T85A0eT3pQ58YvbxT6CAxD+eYuiyWU8yIfY7AksSxNOV+YPK6s=
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 15812370495398295004
From:   Zhangjin Wu <falcon@tinylab.org>
To:     thomas@t-8ch.de
Cc:     arnd@arndb.de, falcon@tinylab.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, w@1wt.eu
Subject: Re: [PATCH v3 01/12] selftests/nolibc: allow report with existing test log
Date:   Sat, 29 Jul 2023 16:53:31 +0800
Message-Id: <20230729085331.7849-1-falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <aa604c61-281d-42b0-85dd-d7a08cdaee6d@t-8ch.de>
References: <aa604c61-281d-42b0-85dd-d7a08cdaee6d@t-8ch.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrgz:qybglogicsvrgz5a-1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

> On 2023-07-28 04:22:42+0800, Zhangjin Wu wrote:
> > After the tests finish, it is valuable to report and summarize with
> > existing test log.
> > 
> > This avoid rerun or run the tests again when not necessary.
> > 
> > Signed-off-by: Zhangjin Wu <falcon@tinylab.org>
> > ---
> >  tools/testing/selftests/nolibc/Makefile | 4 ++++
> >  1 file changed, 4 insertions(+)
> > 
> > diff --git a/tools/testing/selftests/nolibc/Makefile b/tools/testing/selftests/nolibc/Makefile
> > index 2e9694370913..75419b695f0d 100644
> > --- a/tools/testing/selftests/nolibc/Makefile
> > +++ b/tools/testing/selftests/nolibc/Makefile
> > @@ -207,6 +207,10 @@ rerun:
> >  	$(Q)qemu-system-$(QEMU_ARCH) -display none -no-reboot -kernel "$(srctree)/$(IMAGE)" -serial stdio $(QEMU_ARGS) > "$(CURDIR)/run.out"
> >  	$(Q)$(REPORT) $(CURDIR)/run.out
> >  
> > +# report with existing test log
> > +report:
> > +	$(Q)$(REPORT_RUN_OUT)
> 
> Isn't REPORT_RUN_OUT gone in this revision?
>

Yeah, I moved it as the first generic patch but forgot it have used a
later macro, and therefore no recheck in this revision, thanks a lot.

Thanks
Zhangjin

> > +
> >  clean:
> >  	$(call QUIET_CLEAN, sysroot)
> >  	$(Q)rm -rf sysroot
> > -- 
> > 2.25.1
> > 
