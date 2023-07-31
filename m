Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E375C768B9D
	for <lists+linux-kselftest@lfdr.de>; Mon, 31 Jul 2023 08:13:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229722AbjGaGNT (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 31 Jul 2023 02:13:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229585AbjGaGNS (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 31 Jul 2023 02:13:18 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 842401BC;
        Sun, 30 Jul 2023 23:13:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=t-8ch.de; s=mail;
        t=1690783996; bh=7x/b5lpkHR1QpXm45EeiSae8vJL2D4YC92u3lFCHNG8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UKRtW4GlK8FsK3CmBElZHaeONjMyoXLJ7vg+5OAfPRHxgG/S98yYvTI9+5mDeOI+b
         uNe2pwST0rCI+pBJgAmsn9zGRqzeLdqb5HGqxW2Z5QSlFmcMVc5D9uiMIBtHTbdOxI
         qIUaUuaxbN7rMQnwcesJopblw3eUgUa4P9j2WveA=
Date:   Mon, 31 Jul 2023 08:13:15 +0200
From:   Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas@t-8ch.de>
To:     Yuan Tan <tanyuan@tinylab.org>
Cc:     w@1wt.eu, falcon@tinylab.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v2 0/2] tools/nolibc: add pipe(), pipe2() and their
 testcase
Message-ID: <f30d3620-cdeb-45be-ba2b-2298a478c5bd@t-8ch.de>
References: <cover.1690733545.git.tanyuan@tinylab.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1690733545.git.tanyuan@tinylab.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Yuan!

On 2023-07-31 13:50:31+0800, Yuan Tan wrote:
> Thanks to your advice and I really learned a lot from it.
> 
> V2 now uses pipe2() to wrap pipe(), and fixes the strcmp issue in test
> case.

Thanks!

I have some more comments for the patches.

For new revisions you should also link to the old revision.

> Best regards,
> Yuan Tan
> 
> Yuan Tan (2):
>   tools/nolibc: add pipe() and pipe2() support
>   selftests/nolibc: add testcase for pipe
> 
>  tools/include/nolibc/sys.h                   | 24 ++++++++++++++
>  tools/testing/selftests/nolibc/nolibc-test.c | 35 ++++++++++++++++++++
>  2 files changed, 59 insertions(+)
> 
> -- 
> 2.34.1
> 
