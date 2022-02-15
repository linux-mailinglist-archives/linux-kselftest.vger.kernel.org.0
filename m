Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E35F4B7B20
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Feb 2022 00:19:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244784AbiBOXTJ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 15 Feb 2022 18:19:09 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:36020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231588AbiBOXTI (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 15 Feb 2022 18:19:08 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A996F8B93
        for <linux-kselftest@vger.kernel.org>; Tue, 15 Feb 2022 15:18:58 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C9C7761565
        for <linux-kselftest@vger.kernel.org>; Tue, 15 Feb 2022 23:18:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F8B0C340F0;
        Tue, 15 Feb 2022 23:18:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644967137;
        bh=vJwgqHlTSVS2MaFXBwRnv90xILurIVswlRO3SZJ4PW8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NznsgA8VWDwJBGrcJqnU6VSL16vQd1VKlsXwmhPvyDkDhFfr8WSxM048cN5Io1tV7
         3j7lCJWMbDOfix6W6FAoVra3HCtqRYKYOHWQqJOsKWhVWNCKQKv1Z7UN2ZFCFdfblK
         yP0/Y0y/5Xjj1MxRMsbk/cRrGUG1//aliZc4LiEDGYB0ajCD5Jnzc3SIOvJJckV+ki
         V1fe5inaefV2ArFHOZaxYBOts+dvXD2bF+1HfF2UBqM42g5FYLeYhp0iCdLEnJmWbn
         U8Fj1eggF6zYZvx3SOkhz829QGgB9rJoIKdqPmXMA2lCdlkx7aMRSFd/GVqjLNWJdB
         1d+BTR1MLK01g==
From:   Will Deacon <will@kernel.org>
To:     linux-kselftest@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        James Morse <james.morse@arm.com>
Cc:     catalin.marinas@arm.com, kernel-team@android.com,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Shuah Khan <shuah@kernel.org>, Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 0/3] arm64: insn: Generate 64 bit mask immediates correctly
Date:   Tue, 15 Feb 2022 23:18:29 +0000
Message-Id: <164494031388.1780361.10975276520222127155.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220127162127.2391947-1-james.morse@arm.com>
References: <20220127162127.2391947-1-james.morse@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, 27 Jan 2022 16:21:24 +0000, James Morse wrote:
> aarch64_insn_gen_logical_immediate() is generating the wrong code if
> it is handed a 64bit immediate which has a single span of 1s (i.e. a
> mask), with bit 63 set, and 0s in the remaining upper 32 bits.
> Clear as mud. An example always helps: 0x800000003fffffff would be wrongly
> encoded, but 0x000000003fffffff is unaffected.
> 
> It would appear eBPF is unable to hit these cases, as build_insn()'s
> imm value is a s32, so when used with BPF_ALU64, the sign-extended
> u64 immediate would always have all-1s or all-0s in the upper 32 bits.
> 
> [...]

Applied to arm64 (for-next/insn), thanks!

[1/3] arm64: selftests: Generate all the possible logical immediates as a header
      (no commit info)
[2/3] arm64: insn: Add tests for aarch64_insn_gen_logical_immediate()
      (no commit info)
[3/3] arm64: insn: Generate 64 bit mask immediates correctly
      https://git.kernel.org/arm64/c/a6aab0188299

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
