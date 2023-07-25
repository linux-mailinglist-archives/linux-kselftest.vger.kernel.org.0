Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6E9E761C1C
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Jul 2023 16:45:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230416AbjGYOpe (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 25 Jul 2023 10:45:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230409AbjGYOpa (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 25 Jul 2023 10:45:30 -0400
Received: from gnuweeb.org (gnuweeb.org [51.81.211.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE56E136;
        Tue, 25 Jul 2023 07:45:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gnuweeb.org;
        s=default; t=1690296328;
        bh=qfLPbANydfZtLDamJGw6N6/UaIZpchJEnQHYcHeVAWo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=XpLKFaAEJVIt1Tuc0ro0FSpbI+0RtPuNhrG/A5a7ENuy+kgouBpOedMLDWKxnxOD8
         2WF7SMm9mS8a0F6mRvZ/dt6dE1fDlht+zOFQ0kLLWrirto2L3TBtNhJskeYHuvbzPC
         sMVkEMI0Z66ypgnhGeUru0AgOmIgkTVwdmQbSGTkdMckzeZsgBI7y/SmBUbeZHsYQq
         ZnMGI9s51Y6stf4Lxo/wO+ejNAz7UYsKtznxR9BMa2HzZXPEpVqdgOJKBcPcG37scR
         wpDI3eAx4IOoVwTjWWgWbIXhy1Ey1auPTpgT8R7/+vFjx0DJJplBJCZsGKzgT/xZMU
         BL3k7Y/1aJbLA==
Received: from biznet-home.integral.gnuweeb.org (unknown [182.253.126.67])
        by gnuweeb.org (Postfix) with ESMTPSA id 76FD824AF96;
        Tue, 25 Jul 2023 21:45:25 +0700 (WIB)
Date:   Tue, 25 Jul 2023 21:45:20 +0700
From:   Ammar Faizi <ammarfaizi2@gnuweeb.org>
To:     Zhangjin Wu <falcon@tinylab.org>
Cc:     Willy Tarreau <w@1wt.eu>, Arnd Bergmann <arnd@arndb.de>,
        Sven Schnelle <svens@linux.ibm.com>,
        Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas@t-8ch.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Kselftest Mailing List 
        <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH v1 1/8] tools/nolibc: add support for powerpc
Message-ID: <ZL/gAORYFijgjfvH@biznet-home.integral.gnuweeb.org>
References: <ZL9r5B9KBNl1va8i@1wt.eu>
 <20230725110255.20575-1-falcon@tinylab.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230725110255.20575-1-falcon@tinylab.org>
X-Bpl:  hUx9VaHkTWcLO7S8CQCslj6OzqBx2hfLChRz45nPESx5VSB/xuJQVOKOB1zSXE3yc9ntP27bV1M1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Zhangjin, 

On Tue, Jul 25, 2023 at 07:02:55PM +0800, Zhangjin Wu wrote:
> Btw, have checked "=r" instead of "=a" works on i386 too for we already
> bind the _ret variable with "RET" register, but still need to check if
> "=a" is necessary?

I need to tell you that syscall6() for i386 can't use "r" and "=r"
because there was a historical bug that made GCC stuck in a loop forever
when compiling the nolibc code. It's already fixed in the latest version
of GCC, but we should still support older compilers.

Ref: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=105032

I discovered that bug in 2022 in the latest version of GCC at that time,
so it's pretty new, and those buggy versions are very likely still in
the wild today.

-- 
Ammar Faizi

