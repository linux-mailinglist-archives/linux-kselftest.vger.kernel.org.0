Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF88A74559F
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Jul 2023 08:52:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229932AbjGCGw2 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 3 Jul 2023 02:52:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbjGCGw1 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 3 Jul 2023 02:52:27 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AF44CC;
        Sun,  2 Jul 2023 23:52:23 -0700 (PDT)
X-QQ-mid: bizesmtp66t1688367129tk205027
Received: from linux-lab-host.localdomain ( [119.123.131.49])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Mon, 03 Jul 2023 14:52:07 +0800 (CST)
X-QQ-SSF: 01200000000000D0W000000A0000000
X-QQ-FEAT: q+EIYT+FhZovwwQ9UtCz+ef53Vic49SM1+XSIjkCcfjVyWFrS101WFtxEKffb
        A3IUDUUOTFUS7K4LUBvprOtoQpRcC/msnLgZ2eMhYT598GJOpJchy834gX2GQV2NxcivxsA
        akniKYjig6hlzE5Z3hY5YC98sY+hUurws6OvbvfN6eawIq7IbYMcYJ/IY81vradFLc6bDg+
        2TpQEAu6Apeft6s8t+Ia2Qqz1sr/tqLz73zWOXS0ltgg/ksglkxbTBfpY0uEA46SSlLHGhX
        dk1B8FneAS9DC3fxhwFoGsd4Gs4qiPUAxZqdzinmL0aLPzpkvZGTxIvERfXrp00x2/3IWju
        RRc3uHso9snGMZAQKW+d1xR/rN73DJmjtnDtwjBaDs+c+v5cVg=
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 3575837727353389164
From:   Zhangjin Wu <falcon@tinylab.org>
To:     w@1wt.eu
Cc:     arnd@arndb.de, david.laight@aculab.com, falcon@tinylab.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-riscv@lists.infradead.org, thomas@t-8ch.de
Subject: Re: [PATCH v5 11/14] tools/nolibc: clean up mmap() support
Date:   Mon,  3 Jul 2023 14:51:52 +0800
Message-Id: <20230703065152.488142-1-falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230702192347.GJ16233@1wt.eu>
References: <20230702192347.GJ16233@1wt.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrgz:qybglogicsvrgz5a-1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

> On Wed, Jun 28, 2023 at 09:41:13PM +0800, Zhangjin Wu wrote:
> >  static __attribute__((unused))
> >  void *mmap(void *addr, size_t length, int prot, int flags, int fd, off_t offset)
> >  {
> > -	void *ret = sys_mmap(addr, length, prot, flags, fd, offset);
> > -
> > -	if ((unsigned long)ret >= -4095UL) {
> > -		SET_ERRNO(-(long)ret);
> > -		ret = MAP_FAILED;
> > -	}
> > -	return ret;
> > +	return (void *)__sysret((unsigned long)sys_mmap(addr, length, prot, flags, fd, offset));
> >  }
> 
> One point regarding this one. By doing so, we're hard-coding the fact
> that we consider that MAP_FAILED is always -1. I'm not necessarily
> against it, but this implication can be confusing for those searching
> where it's being set. I would suggest putting a comment before the
> mmap() function saying:
> 
>  /* Note that on Linux MAP_FAILED is -1 so we can use the generic __sysret()
>   * which returns -1 upon error and still satisfy user land that checks for
>   * MAP_FAILED.
>   */
> 
> Since it's an assumed choice that theoretically could affect portability,
> it should be reflected in the commit message as well (and we all know it
> does not have any impact).
>

Yeah, we do need such a comment and commit message note, thanks.

Best regards,
Zhangjin

> Thanks!
> Willy
