Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 193DD59F2F2
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Aug 2022 07:07:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232883AbiHXFGd (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 24 Aug 2022 01:06:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234420AbiHXFGc (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 24 Aug 2022 01:06:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5BBA5A826;
        Tue, 23 Aug 2022 22:06:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8144E61871;
        Wed, 24 Aug 2022 05:06:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 541C3C433C1;
        Wed, 24 Aug 2022 05:06:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1661317590;
        bh=MJmfzyDbLyVhiQ2UBncs/RdvNWSOViacvfQF4pgqg7E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ip7utQv8xRPWw/1voHN46cazjPr7hYnZCK2AXudVDCib8huCBjV60QYJYXH1BKyu0
         8L3OSk1ay0Z+LxT3vui9GN3yARFOQOxAalXzvKJClH9vVS6wW+SHvXnHLpR0+m0REl
         z9JOcBBFgWP4d+D2tfmFQ3BNz1H5kUglO8MK9Uyg=
Date:   Wed, 24 Aug 2022 07:06:27 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Andrew Delgadilo <adelg@google.com>
Cc:     Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, dylanbhatch@google.com,
        sashalevin@google.com, gthelen@google.com
Subject: Re: [PATCH] selftests: Add a taint selftest
Message-ID: <YwWx07EbaB90jDUN@kroah.com>
References: <20220823211958.2519055-1-adelg@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220823211958.2519055-1-adelg@google.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Aug 23, 2022 at 09:19:58PM +0000, Andrew Delgadilo wrote:
> From: Andrew Delgadillo <adelg@google.com>
> 
> When testing a kernel, one of the earliest signals one can get is if a
> kernel has become tainted. For example, an organization might be
> interested in mass testing commits on their hardware. An obvious first
> step would be to make sure every commit boots, and a next step would be
> to make sure there are no warnings/crashes/lockups, hence the utility of
> a taint test.

What's wrong with the tools/debugging/kernel-chktaint script?

Why do we need another "get what the taint status is" program?

thanks,

greg k-h
