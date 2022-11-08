Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DBFA621AE1
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Nov 2022 18:39:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234562AbiKHRjN (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 8 Nov 2022 12:39:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234050AbiKHRjL (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 8 Nov 2022 12:39:11 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F2624FF99
        for <linux-kselftest@vger.kernel.org>; Tue,  8 Nov 2022 09:39:10 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 20413B81BE2
        for <linux-kselftest@vger.kernel.org>; Tue,  8 Nov 2022 17:39:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E880C4347C;
        Tue,  8 Nov 2022 17:39:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667929147;
        bh=DWuMsiMOy2LvOTL46RZ8rtpD5Fam79MnYqNv+vIN8to=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=U2VNJixcuPwi+xYjzUWoAqZTBXTglY2H9Q5cpVU8O8QuMZvspaiD6H4BDcgWO3k7/
         rX1lAJabnDKwvT8mHIOYDetCDPxqKRxpNKbm+RCcYT9qWZMpfqchBRapo4kh7qMuTp
         cfmZs8+9rhYY33DbKjXsTR13QNOlOD6WJF8Kic2f7g6QlmyArOQIIcTiTvK3y/3WN+
         jBkG0vUCgBhd2zDqKUgkNHbCndrNJaajQJjMsIgMe1ACIQ4PSJ6Ja0iEVIL1LqY/Ud
         5Fs+glvqUCh613gOPCMX3CxosY6c79s9LWiAjseiVGe/NuQvC0f9T59AAjvgmPF3oh
         M9r0LC+6wh9ZQ==
From:   Will Deacon <will@kernel.org>
To:     Shuah Khan <skhan@linuxfoundation.org>,
        Mark Brown <broonie@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Shuah Khan <shuah@kernel.org>
Cc:     kernel-team@android.com, Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v1] kselftest/arm64: Remove validation of extra_context from TODO
Date:   Tue,  8 Nov 2022 17:38:43 +0000
Message-Id: <166792343522.1917599.824046189071510906.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20221027110324.33802-1-broonie@kernel.org>
References: <20221027110324.33802-1-broonie@kernel.org>
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

On Thu, 27 Oct 2022 12:03:24 +0100, Mark Brown wrote:
> When fixing up support for extra_context in the signal handling tests I
> didn't notice that there is a TODO file in the directory which lists this
> as a thing to be done. Since it's been done remove it from the list.
> 
> 

Applied to arm64 (for-next/selftests), thanks!

[1/1] kselftest/arm64: Remove validation of extra_context from TODO
      https://git.kernel.org/arm64/c/2004734fb3fe

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
