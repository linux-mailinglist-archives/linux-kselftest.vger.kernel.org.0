Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AB9A70EF94
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 May 2023 09:38:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239573AbjEXHit (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 24 May 2023 03:38:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234173AbjEXHis (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 24 May 2023 03:38:48 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DD5391;
        Wed, 24 May 2023 00:38:47 -0700 (PDT)
Date:   Wed, 24 May 2023 09:38:44 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=t-8ch.de; s=mail;
        t=1684913925; bh=l2U6z7PQkaZlK/a39/OVvaeWodpKUCXYinZB8Rh2b7Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VBfXD8tL3kRjH8ETHuqwYV1svwW5hXTLe1qu85wjmySlWzRNiHyt88DEJ4RjDjiHu
         xK/+RCvDWRtyuhQBDgRJ6L5PeOwrOHpOR0lcUIJAY6+MvKRcXzzlkf1QMy0daKQfbz
         Fag+ImpunF+JwXeX5ApIi+c12IaROL9r8cDrvCpg=
From:   Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas@t-8ch.de>
To:     Willy Tarreau <w@1wt.eu>
Cc:     Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, Zhangjin Wu <falcon@tinylab.org>
Subject: Re: [PATCH 0/3] tools/nolibc: stack protector compatibility fixes
Message-ID: <cb3f0f8f-f067-450f-8d5b-9a1ad2a2cd7f@t-8ch.de>
References: <20230523-nolibc-stackprotector-gcc9-v1-0-3e4804235d50@weissschuh.net>
 <ZG2+QuD/tVDqyMyb@1wt.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZG2+QuD/tVDqyMyb@1wt.eu>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 2023-05-24 09:35:30+0200, Willy Tarreau wrote:
> Hi Thomas,
> 
> On Wed, May 24, 2023 at 08:44:41AM +0200, Thomas Weißschuh wrote:
> > Two fixes for nolibc to
> > * allow users to explicitly disable (or theoretically enable) when
> >   building the tests
> > * fix stackprotectors on GCC < 10.
> 
> Nice, thank you. Just tested with gcc 9.5, works both with and without
> stkp. Now pushed to branch 20230524-nolibc-rv32+stkp4. I've dropped my
> exp patch and the associated revert. I think your two patches that clean
> up the makefile options and the new one here that restores the cflags
> should be squashed since the latter just partially reverts the former,
> and that way the series remains bisectable. Just let me know if you're
> OK, I can just to that and re-push.

Sounds good to me!

Thomas
