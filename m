Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D82E762B3C
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Jul 2023 08:16:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232014AbjGZGQy (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 26 Jul 2023 02:16:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232012AbjGZGQ0 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 26 Jul 2023 02:16:26 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 041092723;
        Tue, 25 Jul 2023 23:16:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=t-8ch.de; s=mail;
        t=1690352163; bh=LQw/aqdgtVz/FiNBkYIr2Th093iZ0yLrcqZsdB/xiFg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Q2wv1iYlao1E/Wnhxf0Je7F5VBoE3foujuOrPEZS1nSSD0H9cYcXy8xaR5j99WN26
         QVXWbONcWk4M5HmJnfkOQ8dCNYqpYFbrcXxcEqV1qN7d2uZzp8sDMoLiFEo8+4KKwq
         H38clx1zuq7yQhUDCPt/oG6Hz05jSlUUb6eZKqbE=
Date:   Wed, 26 Jul 2023 08:16:02 +0200
From:   Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas@t-8ch.de>
To:     Zhangjin Wu <falcon@tinylab.org>
Cc:     w@1wt.eu, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH] selftests/nolibc: mmap_munmap_good: fix up return value
Message-ID: <22a7d455-347b-4435-a494-428edab771e3@t-8ch.de>
References: <20230725164336.57767-1-falcon@tinylab.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230725164336.57767-1-falcon@tinylab.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 2023-07-26 00:43:36+0800, Zhangjin Wu wrote:
> The other tests use 1 as failure, mmap_munmap_good uses -1 as failure,
> let's fix up this.
> 
> Signed-off-by: Zhangjin Wu <falcon@tinylab.org>

Reviewed-by: Thomas Weißschuh <linux@weissschuh.net>

> ---
> 
> Willy, if it is ok for you, please merge this one to our old queued commit:
> 
> commit 6b3e54d01905 ("selftests/nolibc: add mmap_munmap_good test case")
> 
> ---
>  tools/testing/selftests/nolibc/nolibc-test.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
