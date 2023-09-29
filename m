Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2927F7B2BF7
	for <lists+linux-kselftest@lfdr.de>; Fri, 29 Sep 2023 07:47:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232697AbjI2FrW (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 29 Sep 2023 01:47:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232625AbjI2FrV (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 29 Sep 2023 01:47:21 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 179391A8;
        Thu, 28 Sep 2023 22:47:18 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27795C433C7;
        Fri, 29 Sep 2023 05:47:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1695966437;
        bh=ayyx6diQFCE4/i0OyR9K661Xi1vAvQH2euXiaM8yNm4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=xbCONu0+/vj0XFwkoWnsf2TqByO3ktsHf/PXDV9pN7tSCIJIk9tQjl2vEa+B1nWTE
         A5+tlUezN5/nVv+6n4/7lauCZWcYaK8Cgaf3WxWx9rzg9KglKnlNYsXTHhbAG3HpyB
         7R4QkY8n+gydjVqvK/axYi6fjN1pv3aGeGBtNdf4=
Date:   Fri, 29 Sep 2023 07:47:12 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Yuanhe Shu <xiangzao@linux.alibaba.com>, jirislaby@kernel.org,
        tony.luck@intel.com, gpiccoli@igalia.com, shuah@kernel.org,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-hardening@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 0/5] pstore: add tty frontend and multi-backend
Message-ID: <2023092919-buccaneer-ibuprofen-7834@gregkh>
References: <20230928024244.257687-1-xiangzao@linux.alibaba.com>
 <202309282030.8CE179EBB@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202309282030.8CE179EBB@keescook>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Sep 28, 2023 at 08:49:02PM -0700, Kees Cook wrote:
> On Thu, Sep 28, 2023 at 10:42:39AM +0800, Yuanhe Shu wrote:
> - I'd like to check with the TTY folks to see if this is the "right"
>   place to hook to get a copy of what's being written.

It depends on what you want to get.  What exact data are you looking
for here?  I couldn't figure it out and I think I already asked it in my
review of the "hook" location.

thanks,

greg k-h
