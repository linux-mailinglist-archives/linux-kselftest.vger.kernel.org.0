Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D0596D589C
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Apr 2023 08:18:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233234AbjDDGSD (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 4 Apr 2023 02:18:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229621AbjDDGSC (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 4 Apr 2023 02:18:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0A2A2D70
        for <linux-kselftest@vger.kernel.org>; Mon,  3 Apr 2023 23:17:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 49EC462EB8
        for <linux-kselftest@vger.kernel.org>; Tue,  4 Apr 2023 06:17:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 975BFC433EF;
        Tue,  4 Apr 2023 06:17:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680589036;
        bh=hjkCVt0EVlkiuqCA7mtfB9O+NuKYtBkZDLarjAzmR18=;
        h=From:To:In-Reply-To:References:Subject:Date:From;
        b=uDhrkwJSCITIemWgSUbau4yVHoXU050V3LmFktSfjvWUX6x6AmKsSQaJUAEtmERsg
         INGzohqdVoRSEunbm/MpvpeEet2XyUSNRrPM8bB2KvmIacb+WbJ34Z/tuAspUk9vT1
         D+CT+6i5jvPIWySPDxHJB4ZiCrYoGhXGWNgFTcoi7IzsTZSzWzpxPAAHHLduHZIr1s
         XCEvUBLbGdI0LPUnThOJatbVvZRFmCCvdVk9tIap1L0FSfdsm563nz1V/oYu+KRED4
         4HP5GMbLrOqs8pXdQpXcq1CZTvZgBwAG6ARHLJXjlpfRhud83ZZzIWnwszcqzcqTyp
         Qm0zVHddF431Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 72E33C41671;
        Tue,  4 Apr 2023 06:17:16 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
From:   "Kernel.org Bugbot" <bugbot@kernel.org>
To:     bugs@lists.linux.dev, rdunlap@infradead.org,
        linux-kselftest@vger.kernel.org, skhan@linuxfoundation.org,
        shuah@kernel.org
Message-ID: <20230404-b217293c6-010748a08594@bugzilla.kernel.org>
In-Reply-To: <20230403-b217293c0-1e5391e4b7f5@bugzilla.kernel.org>
References: <20230403-b217293c0-1e5391e4b7f5@bugzilla.kernel.org>
Subject: Re: Kernel panic, CONFIG_FIPS_SIGNATURE_SELFTEST, missing
 dependency
X-Bugzilla-Product: Linux
X-Bugzilla-Component: Kernel
X-Mailer: peebz 0.1
Date:   Tue,  4 Apr 2023 06:17:16 +0000 (UTC)
X-Spam-Status: No, score=-0.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,PDS_FROM_NAME_TO_DOMAIN,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

o6irnndpcv7 writes via Kernel.org Bugzilla:

Hi Randy!

I submitted an example config. 
That config works fine for me, until I set: 

CONFIG_FIPS_SIGNATURE_SELFTEST=y

And it starts working well again if I set:

CONFIG_FIPS_SIGNATURE_SELFTEST=y
CONFIG_CRYPTO_SHA256=y

That's why I think it is related to FIPS_SIGNATURE_SELFTEST.


Thanks,
  sephora

View: https://bugzilla.kernel.org/show_bug.cgi?id=217293#c6
You can reply to this message to join the discussion.
-- 
Deet-doot-dot, I am a bot.
Kernel.org Bugzilla (peebz 0.1)

