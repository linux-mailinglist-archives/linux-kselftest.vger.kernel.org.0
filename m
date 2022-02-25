Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3C264C3C87
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Feb 2022 04:42:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237117AbiBYDnL (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 24 Feb 2022 22:43:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237116AbiBYDnK (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 24 Feb 2022 22:43:10 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9135194A86
        for <linux-kselftest@vger.kernel.org>; Thu, 24 Feb 2022 19:42:38 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 75BA961504
        for <linux-kselftest@vger.kernel.org>; Fri, 25 Feb 2022 03:42:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 961F2C340E9;
        Fri, 25 Feb 2022 03:42:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1645760557;
        bh=JZCoydRhQbd5ynjiTJUqKGhOB0u3EUOlJHTgG/64KGw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=DUYSouvn1MTAZzvJbIBSXzipqyMXDfgrastK5SzAL2ZPAHKJzlCUmLdzYTQPIIHAB
         rmEXYi3pyTjPumH7Ghl5N6Qm0x5w3MALJ70CsMxWWg2HSyOu0KuZXVrwkBkqYpYebs
         SQ9AE4coybrHUNP/Mhi98KseHyKn+Tf0oEx2eBDA=
Date:   Thu, 24 Feb 2022 19:42:36 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Cc:     linux-mm@kvack.org, mpe@ellerman.id.au,
        linuxppc-dev@lists.ozlabs.org, Shuah Khan <shuah@kernel.org>,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v3 1/2] selftest/vm: Add util.h and and move helper
 functions there
Message-Id: <20220224194236.ce6b6c3576c254d751d9814a@linux-foundation.org>
In-Reply-To: <20220217083537.374160-1-aneesh.kumar@linux.ibm.com>
References: <20220217083537.374160-1-aneesh.kumar@linux.ibm.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, 17 Feb 2022 14:05:36 +0530 "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com> wrote:

> Avoid code duplication by adding util.h. No functional change
> in this patch.

Sorry, but changes in linux-next have messed this patch up a bit more
than I'm prepared to fix.  Could you please redo these two against
linux-next after it has settled down a little?  Next week would be
good, thanks.


