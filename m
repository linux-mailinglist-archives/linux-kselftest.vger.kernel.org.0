Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFC4B7BC873
	for <lists+linux-kselftest@lfdr.de>; Sat,  7 Oct 2023 16:53:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233967AbjJGOxb (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 7 Oct 2023 10:53:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229824AbjJGOxb (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 7 Oct 2023 10:53:31 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38C2DB9;
        Sat,  7 Oct 2023 07:53:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
        s=mail; t=1696690406;
        bh=a9vEKJsdm/M+YAteaGhnGDccj6jl9ttAVbziLu4NzGs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AKANiCr9vpS8JlHnLSmSAcKrU/wHEuijF95i6sIgjZ1FeRdjm8BlvcKeW01dl7YWx
         LyjeQAhkf/AbewuVcalmmDOan3XDu1BAf8CLJwpHgKncVVDIqlt4jxOr2Tp/6QbcSy
         KF93MTu6A5O3tYag91KSBEvqtzJWaMRisyHSMk2Y=
Date:   Sat, 7 Oct 2023 16:53:26 +0200
From:   Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To:     Zhangjin Wu <falcon@tinylab.org>
Cc:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        shuah@kernel.org, stable@vger.kernel.org, w@1wt.eu
Subject: Re: [PATCH] Re: tools/nolibc: drop test for getauxval(AT_PAGESZ)
Message-ID: <8bb681ef-d324-4eb2-81bd-346af19ad7fc@t-8ch.de>
References: <20231007-nolibc-auxval-pagesz-v1-1-af00804edead@weissschuh.net>
 <20231007134202.6766-1-falcon@tinylab.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231007134202.6766-1-falcon@tinylab.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Zhangjin,

On 2023-10-07 21:42:02+0800, Zhangjin Wu wrote:
> > The test will not work for systems with pagesize != 4096 like aarch64
> > and some others.
> >
> 
> We have used EXPECT_GE() instead of EXPECT_EQ(), so this should not
> fail, do I miss something ?;-)

Indeed, I missed that, sorry for the noise.

IMO we can still remove the testcase, but drop it from the
fixes branch and adapt the commit message and Fixes tag.

> Thanks,
> Zhangjin Wu
> 
> > Other testcases are already testing the same functionality:
> > * auxv_AT_UID tests getauxval() in general.
> > * test_getpagesize() tests pagesize() which directly calls
> >   getauxval(AT_PAGESZ).
> > 
> > Fixes: 48967b73f8fe ("selftests/nolibc: add testcases for startup code")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>

> [..]
