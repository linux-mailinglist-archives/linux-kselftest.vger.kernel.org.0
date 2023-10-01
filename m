Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E47877B4584
	for <lists+linux-kselftest@lfdr.de>; Sun,  1 Oct 2023 08:07:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234302AbjJAGHa (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 1 Oct 2023 02:07:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233612AbjJAGHa (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 1 Oct 2023 02:07:30 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 890C6D3;
        Sat, 30 Sep 2023 23:07:28 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4E93C433C8;
        Sun,  1 Oct 2023 06:07:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696140448;
        bh=HVu55sj8diVEf0YD7PLaNXoZSow64mVKxB6UDNxUVbU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=f5JndhUwISOai3W73L76bzvRwg46SINIy30ZohMcdf2KhyXeqlCr+h0dzVtCpPqUw
         a83j2KMErhppxh2mHOXHKHP6pp/fjrOpkby+HvGO4zoBzJxQMOqJiZ0KLLvsAqc0x7
         J4js6k0JClsUvvOCzD/WzYnCHXSuTPbuN13wjZN4=
Date:   Sun, 1 Oct 2023 08:07:25 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Abhinav <singhabhinav9051571833@gmail.com>
Cc:     shuah@kernel.org, linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH] Added missing TARGETS in kselftest top level Makefile
Message-ID: <2023100135-stiffen-depress-8121@gregkh>
References: <20230930194106.1379527-1-singhabhinav9051571833@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230930194106.1379527-1-singhabhinav9051571833@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sun, Oct 01, 2023 at 01:11:06AM +0530, Abhinav wrote:
> Some TARGETS were missing in selftests top level Makefile.Added those.
> Signed-off-by: Abhinav <singhabhinav9051571833@gmail.com>

You need a blank line here please.

Also, why make this change, you are saying what you did, but not why?
Have you tested to verify that these targets were actually missing and
needed to be added?  If so, for what reason?

thanks,

greg k-h
