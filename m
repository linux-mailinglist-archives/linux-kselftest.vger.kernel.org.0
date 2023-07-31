Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 734CC768FC4
	for <lists+linux-kselftest@lfdr.de>; Mon, 31 Jul 2023 10:14:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231927AbjGaIOB (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 31 Jul 2023 04:14:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232130AbjGaINQ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 31 Jul 2023 04:13:16 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [IPv6:2a01:4f8:c010:41de::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABAFD1723;
        Mon, 31 Jul 2023 01:10:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
        s=mail; t=1690791036;
        bh=VVBFsacjEVmUUG4a0c8yaWevpfLl40G7Jll0Zstz/vs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TXUNAYagpG6NiEnger4e6aCr8xHINobNmTVYGqfCmLXBAJ/hvoR94T3h6fZoDAgej
         +4WKDUw0OwmKtLchCuJJ45yqghfN91OEs6XD45QBcDusblHk1l/V3gAj4tMo1Zy6oL
         0LRAIAVe0p/fFYwXRziKMJ7b6FvTG2QcKyIa25I0=
Date:   Mon, 31 Jul 2023 10:10:36 +0200
From:   Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To:     Zhangjin Wu <falcon@tinylab.org>
Cc:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        shuah@kernel.org, tanyuan@tinylab.org, w@1wt.eu
Subject: Re: [PATCH 4/4] selftests/nolibc: enable -Wall compiler warnings
Message-ID: <940dcf77-05ae-4cf6-b5f0-5b8cf80adab6@t-8ch.de>
References: <20230731-nolibc-warnings-v1-4-74973d2a52d7@weissschuh.net>
 <20230731071718.21085-1-falcon@tinylab.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230731071718.21085-1-falcon@tinylab.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 2023-07-31 15:17:18+0800, Zhangjin Wu wrote:
> > It will help the developers to avoid cruft and detect some bugs.
> > 
> > Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
> > ---
> >  tools/testing/selftests/nolibc/Makefile | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/tools/testing/selftests/nolibc/Makefile b/tools/testing/selftests/nolibc/Makefile
> > index f42adef87e12..72227d75c6da 100644
> > --- a/tools/testing/selftests/nolibc/Makefile
> > +++ b/tools/testing/selftests/nolibc/Makefile
> > @@ -79,7 +79,7 @@ endif
> >  CFLAGS_s390 = -m64
> >  CFLAGS_mips = -EL
> >  CFLAGS_STACKPROTECTOR ?= $(call cc-option,-mstack-protector-guard=global $(call cc-option,-fstack-protector-all))
> > -CFLAGS  ?= -Os -fno-ident -fno-asynchronous-unwind-tables -std=c89 \
> > +CFLAGS  ?= -Os -fno-ident -fno-asynchronous-unwind-tables -std=c89 -Wall \
> 
> Very good static analyzer support.
> 
> What about further add more options?
> 
>     +CFLAGS  ?= -Os -fno-ident -fno-asynchronous-unwind-tables -std=c89 -Wall -Wextra -Werror\
> 
> A simple test shows, it can catch more issues.

-Wextra will need some further rework for 32bit architectures to avoid
some warnings.
(At least mips for which I tested it)

I don't think -Werror is appropriate. If we want to test the functioning
of nolibc with weird compilers these may very well add new warnings and
that shouldn't break the build.

> 
> Thanks,
> Zhangjin
> 
> >  		$(call cc-option,-fno-stack-protector) \
> >  		$(CFLAGS_$(ARCH)) $(CFLAGS_STACKPROTECTOR)
> >  LDFLAGS := -s
> > 
> > -- 
> > 2.41.0
