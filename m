Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EEE576D939
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Aug 2023 23:10:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231744AbjHBVKc (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 2 Aug 2023 17:10:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231745AbjHBVKZ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 2 Aug 2023 17:10:25 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [IPv6:2a01:4f8:c010:41de::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72E142D71;
        Wed,  2 Aug 2023 14:10:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
        s=mail; t=1691010618;
        bh=oTA4sFk3bKb9W5XPFGUOTn9eAXi1JwBusDe7257XUyQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Wj9uG0lcZEAduLgS4VVAhiEEUXvYq8JnbrQmhFzk8hUsybD8jYbNscZGIq1trymsP
         VIFyO0khGmAs8pm9GAqg+fhZPOKKoI+hl8J1dWmE2RUoVJF9k7etO+/P6QQGa+Ap9W
         9CfoFGRNo1DMShG/BmO4fs88djlVGXRJKW6ZwFc8=
Date:   Wed, 2 Aug 2023 23:10:17 +0200
From:   Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To:     Willy Tarreau <w@1wt.eu>
Cc:     Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, Yuan Tan <tanyuan@tinylab.org>,
        Zhangjin Wu <falcon@tinylab.org>
Subject: Re: [PATCH v2 00/10] tools/nolibc: enable compiler warnings
Message-ID: <40bfb455-80c4-4ab1-b36e-ba5cbd723198@t-8ch.de>
References: <20230801-nolibc-warnings-v2-0-1ba5ca57bd9b@weissschuh.net>
 <20230802202243.GA23256@1wt.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230802202243.GA23256@1wt.eu>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 2023-08-02 22:22:43+0200, Willy Tarreau wrote:
> Hi Thomas,
> 
> On Tue, Aug 01, 2023 at 07:30:07AM +0200, Thomas Weißschuh wrote:
> > To help the developers to avoid mistakes and keep the code smaller let's
> > enable compiler warnings.
> (...)
> 
> OK, that's overall OK to me, and I noted thta you'll likely update
> 6 and 9. Just let me know how you prefer to proceed, I hope to send
> the PR to Shuah this week-end so I want to be sure we avoid a last
> minute rush and the risks of breakage that comes with it.

I'm not yet sure when I can rework those patches.
Could you already pick up those you are fine with?
(And also leave out the final one to not have spurious warnings)

Thomas
