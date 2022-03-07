Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07EFA4D0A74
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Mar 2022 23:03:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237731AbiCGWEo (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 7 Mar 2022 17:04:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234991AbiCGWEm (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 7 Mar 2022 17:04:42 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F16E237BC4
        for <linux-kselftest@vger.kernel.org>; Mon,  7 Mar 2022 14:03:47 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8D82E60E71
        for <linux-kselftest@vger.kernel.org>; Mon,  7 Mar 2022 22:03:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84472C340EF;
        Mon,  7 Mar 2022 22:03:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646690627;
        bh=ox/njy+08b7l9v2HxLaqR59FOuBTQE/l47GHFUdlPfs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IPzjyYfoDm0UIbdw8oaA9bs2YIFaNayaUaID/LBhyuL8UW8AGxjNSvfpG8FF+8B4X
         H4y0wJFnVgSqZiSoctYoNzXXiwJDiExkhMaOCeR/EX6AIne/HWSBNTPKX3s0VwsPDp
         F+UajGqyhAgH6XoL0XiF/mjJEYW+NYKeIVL89GQGCq2kpLE1/+CYKmN7IeQOv941nA
         Znf9uQcENXI0iObHvkCPIF6i+Om40fUdkFu2ksGinfyx37SkweLtO8iQ/KSZ/YLAq/
         nTT8mXSWXQ8zihobT9ARMvEiUr16aou9i7nuJiobYJEGavTHV+Q1K/XTNeIZS4KZgQ
         D0ph99BKy9CzQ==
From:   Will Deacon <will@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Shuah Khan <shuah@kernel.org>, Mark Brown <broonie@kernel.org>
Cc:     kernel-team@android.com, Will Deacon <will@kernel.org>,
        linux-kselftest@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] kselftest/arm64: Log the PIDs of the parent and child in sve-ptrace
Date:   Mon,  7 Mar 2022 22:03:26 +0000
Message-Id: <164668961745.3277508.13240370651410942379.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220303192817.2732509-1-broonie@kernel.org>
References: <20220303192817.2732509-1-broonie@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, 3 Mar 2022 19:28:17 +0000, Mark Brown wrote:
> If the test triggers a problem it may well result in a log message from
> the kernel such as a WARN() or BUG(). If these include a PID it can help
> with debugging to know if it was the parent or child process that triggered
> the issue, since the test is just creating a new thread the process name
> will be the same either way. Print the PIDs of the parent and child on
> startup so users have this information to hand should it be needed.
> 
> [...]

Applied to arm64 (for-next/kselftest), thanks!

[1/1] kselftest/arm64: Log the PIDs of the parent and child in sve-ptrace
      https://git.kernel.org/arm64/c/e2dc49ef6c6b

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
