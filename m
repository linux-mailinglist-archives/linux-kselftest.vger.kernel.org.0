Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3865275C50C
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Jul 2023 12:53:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230290AbjGUKxr (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 21 Jul 2023 06:53:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230137AbjGUKxp (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 21 Jul 2023 06:53:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB26D19B5;
        Fri, 21 Jul 2023 03:53:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 64678618AC;
        Fri, 21 Jul 2023 10:53:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA831C433CB;
        Fri, 21 Jul 2023 10:53:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689936822;
        bh=PUu1mRQt3T22zjX88DmuovtcHn+0glC3+quGyZC83uw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iWwH+0qrZTgn46bC3FBmWidk6FqLq7fL6TEUvVYiP0rlMFSAw6sf0nRko5NPjx2zV
         iNCKN5ymoXXSHrFVWhN5ilgGWOXV+f0DNGCPSoyTPEQpJeSLc4R51o/7LGtEopngVL
         hJgY/hIm0hhHCK/BL8ahFhjqmWpCrzG6d5Fl6hIlhSRVZ/7gdzkYwQtsY5s8kd8jlc
         QStGzTB8UWYPZzA7DpUaSQ2L5vlrZ2Ek0qhmskvr6PCBoNTJWvBukpdtnPRLBFwDYO
         7y5WutezWDd2LsITnKKQSS31aL3uvchLMk8k2JuMkodYkpFsl8pbu1xjsQaKfOlvDC
         2q3+V6aJmbvUg==
From:   Will Deacon <will@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Shuah Khan <shuah@kernel.org>, Mark Brown <broonie@kernel.org>
Cc:     kernel-team@android.com, Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        David Spickett <David.Spickett@arm.com>,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v2 0/3] arm64/fpsimd: Fix use after free in SME when changing SVE VL
Date:   Fri, 21 Jul 2023 11:53:37 +0100
Message-Id: <168993427004.3198018.6269673577220774335.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20230720-arm64-fix-sve-sme-vl-change-v2-0-8eea06b82d57@kernel.org>
References: <20230720-arm64-fix-sve-sme-vl-change-v2-0-8eea06b82d57@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, 20 Jul 2023 19:38:57 +0100, Mark Brown wrote:
> This series fixes an issue which David Spickett found where if we change
> the SVE VL while SME is in use we can end up attempting to save state to
> an unallocated buffer and adds testing coverage for that plus a bit more
> coverage of VL changes, just for paranioa.
> 
> 

Applied first patch to arm64 (for-next/fixes), thanks!

[1/3] arm64/fpsimd: Ensure SME storage is allocated after SVE VL changes
      https://git.kernel.org/arm64/c/d4d5be94a878

I'll look at the selftests stuff for 6.6 when I get to that (probably
next week).

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
