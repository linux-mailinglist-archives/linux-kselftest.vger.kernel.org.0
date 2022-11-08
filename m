Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 134E1621AE6
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Nov 2022 18:39:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234600AbiKHRjd (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 8 Nov 2022 12:39:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234598AbiKHRj3 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 8 Nov 2022 12:39:29 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77A9950F3B;
        Tue,  8 Nov 2022 09:39:24 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 70988CE1C21;
        Tue,  8 Nov 2022 17:39:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F5CAC433D7;
        Tue,  8 Nov 2022 17:39:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667929158;
        bh=A+yK/02yatVBnycUQBwnGzfkSw56+Z6kErXtkQPw0SA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lBFcwn5baqCPPd4mS/HNN6tSt6821nraYsvwwA738kkv+jRo10SFgPGAnzbvxAn3Q
         cnxraYRZTi3oGFgc9aPOKMFoBMTyEUU19XP0vsqFaMf3EA3Ob3rokH9jm4Ywpz0uq8
         xr0llnsJBXJWnFs3bHe+Zxjc+7jb/4db0Co6kKWC9dFFRPe/j6+P1u5UxcqcEC4v4u
         ziZ9+40pEj/rH1NJpHW9bj1x7/aDiefv52UpLRTSeFs/ZKT6CwqVo7PKHnMdy5FqmZ
         FZvxvkA++2tvbGo/eWn5u04+NTS8ZvARs1juDOEVpzeliNn2ltt9MRNUlAPieZ/Oqc
         HsLNcUO9uuw9A==
From:   Will Deacon <will@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Kang Minchul <tegongkang@gmail.com>,
        Shuah Khan <shuah@kernel.org>
Cc:     kernel-team@android.com, Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH] kselftest/arm64: fix array_size.cocci warning
Date:   Tue,  8 Nov 2022 17:38:49 +0000
Message-Id: <166792353216.1918523.3389940333424617925.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20221105073143.78521-1-tegongkang@gmail.com>
References: <20221105073143.78521-1-tegongkang@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sat, 5 Nov 2022 16:31:43 +0900, Kang Minchul wrote:
> Use ARRAY_SIZE to fix the following coccicheck warnings:
> tools/testing/selftests/arm64/mte/check_buffer_fill.c:341:20-21:
> WARNING: Use ARRAY_SIZE
> tools/testing/selftests/arm64/mte/check_buffer_fill.c:35:20-21:
> WARNING: Use ARRAY_SIZE
> tools/testing/selftests/arm64/mte/check_buffer_fill.c:168:20-21:
> WARNING: Use ARRAY_SIZE
> tools/testing/selftests/arm64/mte/check_buffer_fill.c:72:20-21:
> WARNING: Use ARRAY_SIZE
> tools/testing/selftests/arm64/mte/check_buffer_fill.c:369:25-26:
> WARNING: Use ARRAY_SIZE
> 
> [...]

Applied to arm64 (for-next/selftests), thanks!

[1/1] kselftest/arm64: fix array_size.cocci warning
      https://git.kernel.org/arm64/c/a0fa0b63131b

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
