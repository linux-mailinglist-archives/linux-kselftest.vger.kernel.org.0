Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 755264B7B1E
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Feb 2022 00:18:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244779AbiBOXTD (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 15 Feb 2022 18:19:03 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:35956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244791AbiBOXTC (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 15 Feb 2022 18:19:02 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88E1BF94C2
        for <linux-kselftest@vger.kernel.org>; Tue, 15 Feb 2022 15:18:51 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id D5293CE2150
        for <linux-kselftest@vger.kernel.org>; Tue, 15 Feb 2022 23:18:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2027C340F5;
        Tue, 15 Feb 2022 23:18:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644967128;
        bh=nxuvU3M/Qng0e7071QMVgxAU31oog2T42pvp4Kia2TU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SymAOB1qGGZ+/uzy/4Ep/6+XyXYpJq+PfVS6flLERSvUxf77BkvhzdGtZW6x2y39l
         cLKQY2KBsMfA1yazI4W0rUnx0J5jvWKdel18KoUG9AYgHri+soFVMmb/WbPK/EZpWv
         y/6W8LQjJUS8DZqyL5TbZMhhRnk7QEheCKKfk3T9o139ZZEjqRcWz1YwtRCT5Emtwi
         EU/aZqumqRPGj9mEtDXTmJOcAPJ5lRRqAiuJA9QWgGwPSP3M5Gph+dL2RBUTTGesnT
         V54lKfy1vugntIIzpr++0iC2iHJNo+rJdgvjl/xbZh7uv77fYnNsFyLphj4yT7LQTF
         0o3K6ndYX1pdw==
From:   Will Deacon <will@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Shuah Khan <shuah@kernel.org>, Mark Brown <broonie@kernel.org>
Cc:     kernel-team@android.com, Will Deacon <will@kernel.org>,
        linux-kselftest@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] kselftest/arm64: Remove local ARRAY_SIZE() definitions
Date:   Tue, 15 Feb 2022 23:18:25 +0000
Message-Id: <164494074126.1780873.9232103158382846688.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220124171748.2195875-1-broonie@kernel.org>
References: <20220124171748.2195875-1-broonie@kernel.org>
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

On Mon, 24 Jan 2022 17:17:48 +0000, Mark Brown wrote:
> An ARRAY_SIZE() has been added to kselftest.h so remove the local versions
> in some of the arm64 selftests.
> 
> 

Applied to arm64 (for-next/kselftest), thanks!

[1/1] kselftest/arm64: Remove local ARRAY_SIZE() definitions
      https://git.kernel.org/arm64/c/3673d4b9cf68

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
