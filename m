Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15D9472546C
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Jun 2023 08:38:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234682AbjFGGit (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 7 Jun 2023 02:38:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234201AbjFGGir (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 7 Jun 2023 02:38:47 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13C51172B;
        Tue,  6 Jun 2023 23:38:45 -0700 (PDT)
X-QQ-mid: bizesmtp83t1686119915tg8q219l
Received: from linux-lab-host.localdomain ( [61.141.77.49])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Wed, 07 Jun 2023 14:38:34 +0800 (CST)
X-QQ-SSF: 01200000000000D0V000000A0000000
X-QQ-FEAT: iDzLjIm7mlarxQ37HSKAlRkd6wcQobjGCjiAbDfTqoqi3jOnoDZE+XK6RTrbj
        ObGHhN42g8PUfzZBPuXUpkjvQbCXiokReJGKITQvmx9NFIHzBMiof7y51esDkWycvc0Wx6T
        qycIvqDxO8q+UvKHl1YuFjunWlujYL/1EGYBB3cE6/qAn+4KwLtPfgGfWyhhtxQBwIl4GHn
        0A9k2ZhUxjBZqf8/TVPgga22YCZ1oxV/4ZrFqA5N20iLvuZYloklbV6AJj8eOKQwFjlPoLf
        cadevjho7qWVHw12tmGvDk8YOw+IKwM7L3BNBvttDMrp2vf/W3SZjiUk+87UN4Lf2De2E/D
        /Nd+gcq5qKYyOF4d4ShWPYRcBSwdYGx0vzm1n80Iel2wuQJDeMQfVIQzQgofg==
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 5675149324483682908
From:   Zhangjin Wu <falcon@tinylab.org>
To:     thomas@t-8ch.de
Cc:     arnd@arndb.de, falcon@tinylab.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-riscv@lists.infradead.org,
        w@1wt.eu
Subject: Re: [PATCH v2 4/4] tools/nolibc: sys.h: apply __syscall() helper
Date:   Wed,  7 Jun 2023 14:38:34 +0800
Message-Id: <20230607063834.671562-1-falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <793fc122-1409-4092-b39c-ea348de8ba14@t-8ch.de>
References: <793fc122-1409-4092-b39c-ea348de8ba14@t-8ch.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrsz:qybglogicsvrsz3a-3
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

> Hi Zhangjin,
> 
> On 2023-06-07 13:39:20+0800, Zhangjin Wu wrote:
> > 
> > As a summary, will use 'sysret()' and something like:
> > 
> >    static __attribute__((unused))
> >    int chdir(const char *path)
> >    {
> >    	return sysret(chdir(path));
> >    }
> > 
> > to renew the syscall helper patchset, Thanks you very much.
> 
> But please to use the "__" prefix.
> Otherwise it could conflict with user code.
>

Ok, not yet to modify the code, will reserve the '__sysret()' and convert the
left parts to this style: '__sysret(chdir(path))', a simple sed script may help
to do so.

Thanks a lot.
Zhangjin

> Thomas
