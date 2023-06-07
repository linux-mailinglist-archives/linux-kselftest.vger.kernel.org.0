Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 333BF7253D5
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Jun 2023 08:05:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231970AbjFGGFd (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 7 Jun 2023 02:05:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229603AbjFGGFd (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 7 Jun 2023 02:05:33 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62E2983;
        Tue,  6 Jun 2023 23:05:32 -0700 (PDT)
Date:   Wed, 7 Jun 2023 08:05:30 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=t-8ch.de; s=mail;
        t=1686117930; bh=j87jB5tkNZ9EKrRf0GhAoecY1yef9wSw92FeK2xc91Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EP2x3rpqr3aSbklvJE5UgMnYNtD9PlRfBr397LFhzxNjaHx1xRnsandIkNnuj3kM7
         sAHh9noZ3/qtsX13MTIr6a4jLHgoFRHVKzfVOw8u/Kgq4tBn6jLtXKA4gdLgxJTEQO
         aUbazmyyAdnmYbDOl4FHdgjB0OSVrLjoU3VAVcEI=
From:   Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas@t-8ch.de>
To:     Zhangjin Wu <falcon@tinylab.org>
Cc:     w@1wt.eu, arnd@arndb.de, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: Re: [PATCH v2 4/4] tools/nolibc: sys.h: apply __syscall() helper
Message-ID: <793fc122-1409-4092-b39c-ea348de8ba14@t-8ch.de>
References: <ZIAB7bFYegCuXT9g@1wt.eu>
 <20230607053920.667272-1-falcon@tinylab.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230607053920.667272-1-falcon@tinylab.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Zhangjin,

On 2023-06-07 13:39:20+0800, Zhangjin Wu wrote:
> 
> As a summary, will use 'sysret()' and something like:
> 
>    static __attribute__((unused))
>    int chdir(const char *path)
>    {
>    	return sysret(chdir(path));
>    }
> 
> to renew the syscall helper patchset, Thanks you very much.

But please to use the "__" prefix.
Otherwise it could conflict with user code.

Thomas
