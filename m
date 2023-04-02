Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9114F6D3604
	for <lists+linux-kselftest@lfdr.de>; Sun,  2 Apr 2023 10:00:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230133AbjDBIAL (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 2 Apr 2023 04:00:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjDBIAL (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 2 Apr 2023 04:00:11 -0400
Received: from 1wt.eu (wtarreau.pck.nerim.net [62.212.114.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 06F3FFF0D;
        Sun,  2 Apr 2023 01:00:09 -0700 (PDT)
Received: (from willy@localhost)
        by mail.home.local (8.17.1/8.17.1/Submit) id 332805sn018362;
        Sun, 2 Apr 2023 10:00:05 +0200
Date:   Sun, 2 Apr 2023 10:00:05 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc:     Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 3/3] tools/nolibc: add testcases for vfprintf
Message-ID: <ZCk2BSCDE8ssl8fz@1wt.eu>
References: <20230328-nolibc-printf-test-v1-0-d7290ec893dd@weissschuh.net>
 <20230328-nolibc-printf-test-v1-3-d7290ec893dd@weissschuh.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230328-nolibc-printf-test-v1-3-d7290ec893dd@weissschuh.net>
X-Spam-Status: No, score=-0.0 required=5.0 tests=SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Mar 28, 2023 at 09:01:31PM +0000, Thomas Weißschuh wrote:
> +	fd = memfd_create("vfprintf", 0);
> +	if (fd == -1) {
> +		pad_spc(llen, 64, "[FAIL]\n");
> +		return 1;
> +	}

Also for this you'll need to include <sys/mman.h> in the part where nolibc
is not detected so that it continues to work with regular libcs (at least
glibc so that we have one reference to compare against).

Thanks,
Willy
