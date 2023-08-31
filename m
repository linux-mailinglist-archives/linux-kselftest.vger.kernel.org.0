Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E78078E5A9
	for <lists+linux-kselftest@lfdr.de>; Thu, 31 Aug 2023 07:32:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244088AbjHaFcG (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 31 Aug 2023 01:32:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243935AbjHaFcG (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 31 Aug 2023 01:32:06 -0400
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 11382E8;
        Wed, 30 Aug 2023 22:31:58 -0700 (PDT)
Received: (from willy@localhost)
        by mail.home.local (8.17.1/8.17.1/Submit) id 37V5VdZv004520;
        Thu, 31 Aug 2023 07:31:39 +0200
Date:   Thu, 31 Aug 2023 07:31:39 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     Zhangjin Wu <falcon@tinylab.org>
Cc:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux@weissschuh.net, shuah@kernel.org, tanyuan@tinylab.org
Subject: Re: [PATCH v2 0/2] nolibc: remove reliance on system headers
Message-ID: <ZPAluyQy1gYbmBnH@1wt.eu>
References: <ZO+rJv/ZNokkyWpL@1wt.eu>
 <20230831041202.5896-1-falcon@tinylab.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230831041202.5896-1-falcon@tinylab.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Aug 31, 2023 at 12:12:02PM +0800, Zhangjin Wu wrote:
> > Subject: [PATCH v2 1/2] tools/nolibc: add stdarg.h header
> > 
> > This allows nolic to work with `-nostdinc` avoiding any reliance on
> > system headers.
> >
> 
> A little typo in above commit message: nolic -> nolibc.

Yeah I noticed and forgot to fix it. Will probably do it next time I
have the opportunity to touch that branch ;-)

Willy
