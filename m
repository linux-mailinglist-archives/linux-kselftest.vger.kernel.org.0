Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDD9D6D3831
	for <lists+linux-kselftest@lfdr.de>; Sun,  2 Apr 2023 16:03:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229565AbjDBODv (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 2 Apr 2023 10:03:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjDBODu (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 2 Apr 2023 10:03:50 -0400
Received: from 1wt.eu (wtarreau.pck.nerim.net [62.212.114.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 583F7FF0A;
        Sun,  2 Apr 2023 07:03:47 -0700 (PDT)
Received: (from willy@localhost)
        by mail.home.local (8.17.1/8.17.1/Submit) id 332E3ciM019674;
        Sun, 2 Apr 2023 16:03:38 +0200
Date:   Sun, 2 Apr 2023 16:03:38 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc:     Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v2 2/3] tools/nolibc: implement fd-based FILE streams
Message-ID: <ZCmLOruMPQDbfTyH@1wt.eu>
References: <20230328-nolibc-printf-test-v2-0-f72bdf210190@weissschuh.net>
 <20230328-nolibc-printf-test-v2-2-f72bdf210190@weissschuh.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230328-nolibc-printf-test-v2-2-f72bdf210190@weissschuh.net>
X-Spam-Status: No, score=-0.0 required=5.0 tests=SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sun, Apr 02, 2023 at 01:02:46PM +0000, Thomas Weißschuh wrote:
> Willy:
> 
> This uses intptr_t instead of uintptr_t as proposed because uintptr_t
> can not be negative.

Ah yes good point.

> +/* provides the fd from of stream. */
> +static __attribute__((unused))
> +int fileno(FILE *stream)
> +{
> +	intptr_t i = (intptr_t)stream;
> +
> +	if (i > 0) {

If you don't mind I'll change this to "if (i >= 0)" since we also want
to set errno on NULL.


> +		SET_ERRNO(EBADF);
> +		return -1;
> +	}
> +	return ~i;
> +}

OK for the rest of the series.

Thanks!
Willy
