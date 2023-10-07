Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B0A57BC6DB
	for <lists+linux-kselftest@lfdr.de>; Sat,  7 Oct 2023 12:37:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343835AbjJGKhK (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 7 Oct 2023 06:37:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343815AbjJGKhJ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 7 Oct 2023 06:37:09 -0400
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id F3324102;
        Sat,  7 Oct 2023 03:37:05 -0700 (PDT)
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 397AaxPL023933;
        Sat, 7 Oct 2023 12:36:59 +0200
Date:   Sat, 7 Oct 2023 12:36:59 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc:     Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v2] tools/nolibc: add support for constructors and
 destructors
Message-ID: <20231007103659.GC23812@1wt.eu>
References: <20231007-nolibc-constructors-v2-1-ef84693efbc1@weissschuh.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231007-nolibc-constructors-v2-1-ef84693efbc1@weissschuh.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sat, Oct 07, 2023 at 12:01:39PM +0200, Thomas Weiﬂschuh wrote:
> With the startup code moved to C, implementing support for
> constructors and deconstructors is fairly easy to implement.
> 
> Examples for code size impact:
> 
>    text	   data	    bss	    dec	    hex	filename
>   21837	    104	     88	  22029	   560d	nolibc-test.before
>   22135	    120	     88	  22343	   5747	nolibc-test.after
>   21970	    104	     88	  22162	   5692 nolibc-test.after-only-crt.h-changes
> 
> The sections are defined by [0].
> 
> [0] https://refspecs.linuxfoundation.org/elf/gabi4+/ch5.dynamic.html
> 
> Signed-off-by: Thomas Weiﬂschuh <linux@weissschuh.net>

Acked-by: Willy Tarreau <w@1wt.eu>

Thanks!
Willy
