Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F8EA4E7719
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Mar 2022 16:25:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376525AbiCYP1B (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 25 Mar 2022 11:27:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378797AbiCYPZy (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 25 Mar 2022 11:25:54 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C10056C97C;
        Fri, 25 Mar 2022 08:21:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6CACCB82865;
        Fri, 25 Mar 2022 15:21:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4764DC340E9;
        Fri, 25 Mar 2022 15:21:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648221682;
        bh=fZLSxkTLgAiK9WvG/RQ0cuXLjxC/5xxA+lzUtuM4vbQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=e5Pr1ZZivo0GKdqsTwQFKfIXZ4ecCjak/7T2iCGT4MofX3nAXY/l6i2lzSogxDS6q
         53yg2BmTDLsypt60JV/wlPHvNCKxF7x0kEkMFm6I0Din0rI2/llOni42XCch1X2juu
         gT0xMrelTdPWZH8ha1FT6P8ZuCG5K+V0NwCiwH1i8I8Z677HtCguQrkAJmha2OCeSZ
         ZX/GJt7vLr7CDFMKDPusEtwIcJ8GBzi3o6P98lZ5Iu/rAMaajteJ6C+9boROuHqyhN
         BhHikS5GS6CZ8pHG5C5O6fRoyhZo0fVvNTsnfXrkAb7ccNHCpXuE9qwHcuUTAzEoa0
         N7MhAsDICTMGg==
Date:   Fri, 25 Mar 2022 16:21:17 +0100
From:   Christian Brauner <brauner@kernel.org>
To:     Axel Rasmussen <axelrasmussen@google.com>
Cc:     Shuah Khan <shuah@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        llvm@lists.linux.dev
Subject: Re: [PATCH 2/2] selftests: fix an unused variable warning in pidfd
 selftest
Message-ID: <20220325152117.mxp35mdfxcgsow6a@wittgenstein>
References: <20220324223929.1893741-1-axelrasmussen@google.com>
 <20220324223929.1893741-2-axelrasmussen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220324223929.1893741-2-axelrasmussen@google.com>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Mar 24, 2022 at 03:39:29PM -0700, Axel Rasmussen wrote:
> I fixed a few warnings like this in commit e2aa5e650b07
> ("selftests: fixup build warnings in pidfd / clone3 tests"), but I
> missed this one by mistake. Since this variable is unused, remove it.
> 
> Signed-off-by: Axel Rasmussen <axelrasmussen@google.com>
> ---

Looks good,
Reviewed-by: Christian Brauner <brauner@kernel.org>
