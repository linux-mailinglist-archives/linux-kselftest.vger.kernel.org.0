Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF19175E054
	for <lists+linux-kselftest@lfdr.de>; Sun, 23 Jul 2023 09:47:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229597AbjGWHrw (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 23 Jul 2023 03:47:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbjGWHrv (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 23 Jul 2023 03:47:51 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [IPv6:2a01:4f8:c010:41de::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A14BFB1;
        Sun, 23 Jul 2023 00:47:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=t-8ch.de; s=mail;
        t=1690098467; bh=g0OZWrRlhCMtvOX5qfEUwUDGKGHp1k7RvsZjfcI9DME=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mkZuO69xfI2VjIvTXB66PqeEseKFM6IVWSciBfEAGGQAUN2yE1CscnvjpHB8ip2KA
         u9fgYHG6lKx5lWcHdYqW4RKHL84cIfi9nMJQJvgrdEZNWAGW4qcGedhwGxF/cMI1mA
         Oo3N/I5SOGSkeTKTjg/+Xd7OAsFFvPDOr/MYhR2o=
Date:   Sun, 23 Jul 2023 09:47:46 +0200
From:   Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas@t-8ch.de>
To:     Zhangjin Wu <falcon@tinylab.org>
Cc:     w@1wt.eu, arnd@arndb.de, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v1 0/8] tools/nolibc: add 32/64-bit powerpc support
Message-ID: <506c9765-768d-4c24-a5b1-9d9f82072a6c@t-8ch.de>
References: <cover.1689713175.git.falcon@tinylab.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1689713175.git.falcon@tinylab.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 2023-07-19 05:09:42+0800, Zhangjin Wu wrote:
> Here is the powerpc support, includes 32-bit big-endian powerpc, 64-bit
> little endian and big endian powerpc.
> 
> [..]
> 
> Zhangjin Wu (8):
>   tools/nolibc: add support for powerpc
>   tools/nolibc: add support for powerpc64
>   selftests/nolibc: select_null: fix up for big endian powerpc64
>   selftests/nolibc: add extra config file customize support
>   selftests/nolibc: add XARCH and ARCH mapping support
>   selftests/nolibc: add test support for powerpc
>   selftests/nolibc: add test support for powerpc64le
>   selftests/nolibc: add test support for powerpc64

For the full series, after comment for patch 1 is addressed:

Reviewed-by: Thomas Weißschuh <linux@weissschuh.net>
