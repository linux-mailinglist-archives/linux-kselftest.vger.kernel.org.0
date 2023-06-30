Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A200743936
	for <lists+linux-kselftest@lfdr.de>; Fri, 30 Jun 2023 12:18:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232418AbjF3KSa (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 30 Jun 2023 06:18:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230436AbjF3KSV (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 30 Jun 2023 06:18:21 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 128F61FE7;
        Fri, 30 Jun 2023 03:18:17 -0700 (PDT)
X-QQ-mid: bizesmtp68t1688120287t3nc41p8
Received: from linux-lab-host.localdomain ( [119.123.131.49])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Fri, 30 Jun 2023 18:18:06 +0800 (CST)
X-QQ-SSF: 01200000000000D0W000000A0000000
X-QQ-FEAT: CR3LFp2JE4kVeLKB/IGQ9/HRtzlNKysqzzw7EbOOaZ8+pWgGPgTrhbXB+Omb0
        rtWnq8zftwEPlSqt6c/gxeuuQuVIoG9+wbdtU+z8IIyaZHVTr0Yh7aDX+qs9sFbRIeorAkt
        yPtt+gU2anILKtVnuIWaOTwsTX52PX1/HqBzqKiEZg1ckDWXQba3c03WgwGJophNIzGaHoe
        /Xk1Pa+94BwABp0FVAIN0wwxWhPESgBSYfo53FvyuuvOVN/gqta8heEL2B3B5cDeLGyJ0Km
        L6kYSzFKjxJCAs2N1LbKE02HcCINrz/Tt3jMOPoFgyBY3zNKByx8cxBdOzwExt2s1Bs3vde
        gAZvLfQwAI4E7yYbzRRNMTTx3q8KUdWm7A5ZhxKOVBxRYOdgfPLHHs2qmOqiw==
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 15246571303830046503
From:   Zhangjin Wu <falcon@tinylab.org>
To:     thomas@t-8ch.de
Cc:     arnd@arndb.de, falcon@tinylab.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, w@1wt.eu
Subject: Re: [PATCH v2 11/15] selftests/nolibc: prepare /tmp for tmpfs or ramfs
Date:   Fri, 30 Jun 2023 18:18:05 +0800
Message-Id: <20230630101805.192734-1-falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <457759dc-cd95-4474-a184-242bdb028445@t-8ch.de>
References: <457759dc-cd95-4474-a184-242bdb028445@t-8ch.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrgz:qybglogicsvrgz5a-1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi, Thomas

> On 2023-06-30 07:52:03+0800, Zhangjin Wu wrote:
> > Let's create a /tmp directory and mount tmpfs there, if tmpfs is not
> > mountable, use ramfs as tmpfs.
> > 
> > tmpfs will be used instead of procfs for some tests.
> > 
> > Signed-off-by: Zhangjin Wu <falcon@tinylab.org>
> > ---
> >  tools/testing/selftests/nolibc/nolibc-test.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> > 
> > diff --git a/tools/testing/selftests/nolibc/nolibc-test.c b/tools/testing/selftests/nolibc/nolibc-test.c
> > index c0f5302ada5d..8e3e2792f5e3 100644
> > --- a/tools/testing/selftests/nolibc/nolibc-test.c
> > +++ b/tools/testing/selftests/nolibc/nolibc-test.c
> > @@ -1054,6 +1054,10 @@ int prepare(void)
> >  		}
> >  	}
> >  
> > +	/* try to mount /tmp if not mounted, if not mountable, use ramfs as tmpfs */
> > +	if (stat("/tmp/.", &stat_buf) == 0 || mkdir("/tmp", 0755) == 0)
> > +		mount("none", "/tmp", "tmpfs", 0, 0);
> > +
> 
> mkdir()
> mount()
> 
> without any error checking should do the same and be easier to read.
>

Yeah, will apply it, it saves a call for us.

Perhaps the other codes in prepare() can be cleaned up with the same method in the future too.

Thanks,
Zhangjin

> >  	return 0;
> >  }
> >  
> > -- 
> > 2.25.1
> > 
