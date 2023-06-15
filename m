Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3210A73207F
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Jun 2023 21:51:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229648AbjFOTvB (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 15 Jun 2023 15:51:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbjFOTvB (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 15 Jun 2023 15:51:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82FCE268A;
        Thu, 15 Jun 2023 12:51:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1964861F6A;
        Thu, 15 Jun 2023 19:51:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34B69C433C8;
        Thu, 15 Jun 2023 19:50:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686858659;
        bh=2bbMoNJtloMz3PN/dxm0qKq6WULxG+X/hxRiIP+tqBA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=GY2VS4p1gihCnSa+b5ubgxIJ2tz+Snm7goYwKeO/zGCMQZf88nskdr5qxw4i/G1Ks
         Htjmwe36iune2mFu0ZGLtkbEa12+g5o38JEcSvS3lYL3toFBg9DCwaJgEu6JM9XS4W
         IYEBcziahUPoc3bUeTz31IBpKYejKAI8lyFrVWQDI5NuqSgWwOgQFF52FadnC00fZp
         xRz5prEdD+kN2LK33SgNJ9qlTDqWSYAyZI+Jp9RtJ4KqvSBzviouQOokfBTaj9C+9r
         h8JxFKVsKqDMCsQJjyhbpLPu66E1JLUHahYpZtm94KHoD+GHEj0JE2zt5dSee4nbaj
         /5AY0zvnvYc1w==
Date:   Thu, 15 Jun 2023 12:50:58 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Pavan Chebbi <pavan.chebbi@broadcom.com>
Cc:     Alex Maftei <alex.maftei@amd.com>, richardcochran@gmail.com,
        shuah@kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH] selftests/ptp: Fix timestamp printf format for
 PTP_SYS_OFFSET
Message-ID: <20230615125058.369367a6@kernel.org>
In-Reply-To: <CALs4sv2+nb3i8VQKNsqLzrCR0Sq6oHPwrzxYdeAaMVX+1-Z+VA@mail.gmail.com>
References: <20230615083404.57112-1-alex.maftei@amd.com>
        <CALs4sv2+nb3i8VQKNsqLzrCR0Sq6oHPwrzxYdeAaMVX+1-Z+VA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, 15 Jun 2023 15:13:27 +0530 Pavan Chebbi wrote:
> Change looks good but can you mark this for "net" correctly and get
> CI/sanity checks done.

It may be failing path selection, bot needs some changes in what it
considers "networking", tools/testing/selftests/ptp is not on the list.

If you have a few cycles feel free to extend this list:
https://github.com/kuba-moo/nipa/blob/master/netdev/tree_match.py#L47
post a PR on GH, I'll merge it in.

The patch is just a test fix, not worth reposting, IMHO.
