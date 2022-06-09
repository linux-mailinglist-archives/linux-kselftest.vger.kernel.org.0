Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1264D545684
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 Jun 2022 23:36:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229862AbiFIVgN (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 9 Jun 2022 17:36:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230205AbiFIVgM (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 9 Jun 2022 17:36:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD5B43B33AE
        for <linux-kselftest@vger.kernel.org>; Thu,  9 Jun 2022 14:36:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2DD9961F2B
        for <linux-kselftest@vger.kernel.org>; Thu,  9 Jun 2022 21:36:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EC5BC34114;
        Thu,  9 Jun 2022 21:36:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654810569;
        bh=XJJ/5y/Rym0unnupmr2A6evLeJY/jKvBFpg6j2Eut/I=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=V9W9OjELRWYIZ+oRLfuDLo3nbIVLPYuUg2U2pxDYp4IzDVNIpCj5WaBk50SIjsluS
         fVBmqLSk3/JX7Uyyt4gZejuWg+b5iGcC7soz8p9S4pYro8hqyNb6q8p+7vy2hJEbLR
         igxRfRBdsGHkf0HSpCf1aSIB+sVr+LiRwToBBFq+b6VEANQIZQB5eFRj/CrlUhGiCx
         su+/KruK9NmxUxEORrX8iJBV/qgTKYfIqaoYyli+iZ1rmP2C0OnDmEgSxAnaMYi/6f
         dOQhVSDGw8mj+6Jycq4Ax291teFZviqCiTASKxQgsuLEuLqdW7/OQCV0zPkSag8TDA
         6LaRepuUSEBFA==
Date:   Thu, 9 Jun 2022 14:36:07 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     shuah@kernel.org, keescook@chromium.org, luto@amacapital.net,
        wad@chromium.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH] testing: kselftest_harness: add filtering and
 enumerating tests
Message-ID: <20220609143607.2aec9bb8@kernel.org>
In-Reply-To: <a360b5e0-4b56-6d90-4060-6760934f7dd8@linuxfoundation.org>
References: <20220609202458.1715942-1-kuba@kernel.org>
        <a360b5e0-4b56-6d90-4060-6760934f7dd8@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, 9 Jun 2022 14:59:18 -0600 Shuah Khan wrote:
> Change this to use getopt() to simplify argument parsing and make
> it easier to maintain.

Sure thing! Do the options themselves make sense? I wasn't sure if
there are some restrictions or standards since the output is TAP
compatible, AFAIU. Or maybe someone has better ideas.
