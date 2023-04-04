Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFB416D586C
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Apr 2023 08:06:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233635AbjDDGGp (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 4 Apr 2023 02:06:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233639AbjDDGGo (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 4 Apr 2023 02:06:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CF752706
        for <linux-kselftest@vger.kernel.org>; Mon,  3 Apr 2023 23:06:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id ADAB462E62
        for <linux-kselftest@vger.kernel.org>; Tue,  4 Apr 2023 06:06:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 14554C433B3;
        Tue,  4 Apr 2023 06:06:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680588402;
        bh=uPcNtYZDh0YsmfMamh+i8UXHd3zjJ0TT+bGdoiBnPFQ=;
        h=From:To:In-Reply-To:References:Subject:Date:From;
        b=TdwONufaYxzIrXibw5dhNymABvndl20LPhJapyLfYdC1BT/gBf9eCcbaOA70bMxKw
         7O+b1BG5AKu+Ttpg1Yx3rszLOxxmDI7mu/3dOGKyNGk6LyB0I7cUzKoXRkNIhtiNmW
         lLgMQ++GyV1NGmweZICxRJp2EN+0s9rLGPpUdX6SfOg0KuJGRY2TtLn20cx6bdJ6nf
         crbOkeOszhlvWCfxCo8StrOfcSiUnlSTAqDC1eESVhI4rjZFy1hWhkAvSigRN2u/RZ
         my+vLe9RmSdmLoyJ8NN4ZDpa5t1r2JGK6dUPDWjEt4+Nf5h6PILGVw1rEiIs3NQRXP
         IMuVJgLvgZHVw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id EF9A6C41671;
        Tue,  4 Apr 2023 06:06:41 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
From:   "Kernel.org Bugbot" <bugbot@kernel.org>
To:     rdunlap@infradead.org, shuah@kernel.org, bugs@lists.linux.dev,
        linux-kselftest@vger.kernel.org, skhan@linuxfoundation.org
Message-ID: <20230404-b217293c5-472ddc47f867@bugzilla.kernel.org>
In-Reply-To: <20230403-b217293c0-1e5391e4b7f5@bugzilla.kernel.org>
References: <20230403-b217293c0-1e5391e4b7f5@bugzilla.kernel.org>
Subject: Re: Kernel panic, CONFIG_FIPS_SIGNATURE_SELFTEST, missing
 dependency
X-Bugzilla-Product: Linux
X-Bugzilla-Component: Kernel
X-Mailer: peebz 0.1
Date:   Tue,  4 Apr 2023 06:06:41 +0000 (UTC)
X-Spam-Status: No, score=-0.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,PDS_FROM_NAME_TO_DOMAIN,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

o6irnndpcv7 added a new attachment via Kernel.org Bugzilla.
You can download it by following the link below.

File: .config_03042023 (text/plain)
Size: 108.68 KiB
Link: https://bugzilla.kernel.org/attachment.cgi?id=304083
---
Kernel config for 6.2.9

You can reply to this message to join the discussion.
-- 
Deet-doot-dot, I am a bot.
Kernel.org Bugzilla (peebz 0.1)

