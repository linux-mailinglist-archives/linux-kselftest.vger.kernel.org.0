Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57005621ADE
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Nov 2022 18:39:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234563AbiKHRjH (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 8 Nov 2022 12:39:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234573AbiKHRjG (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 8 Nov 2022 12:39:06 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE44350F3B
        for <linux-kselftest@vger.kernel.org>; Tue,  8 Nov 2022 09:39:05 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id E90F3CE1C21
        for <linux-kselftest@vger.kernel.org>; Tue,  8 Nov 2022 17:39:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B280C43140;
        Tue,  8 Nov 2022 17:39:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667929141;
        bh=MxrgM2gZnyNPORKkvopF3JErHgIzDJJ+N2SslHsLX3A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=olKCf1DLPJfd9aUDuyc6Dxj9hqIlazQaLOs/xaVLTGmcSDy0gJqIo8/tyQHhlCZk7
         vIbGvNmVOYAdDiZ91dljyf9PZn/XlciVQaTQMPg4TIIsUa/4wL5H43svRjd7HZ6lX8
         5wiR0xeUuWAJR/lFokJbPbrL1bYQOI8mV+qZweQCmOr+C/WBR0WQpglMw5Aa0K83V9
         U/wnsXeYJVgbjfS6hL18uu8+oUBkoPd+EZ0HBfC1rU5KhFSZ83gTjC6hsjv+jYW8it
         4Nq4W0elghDXRlV+nPY1K4EJeltOfeypv5WxyTiiQxKbaLjIzdkAZpTqavgGXnEFtx
         8hBA/uZ6q9S1A==
From:   Will Deacon <will@kernel.org>
To:     Mark Brown <broonie@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Shuah Khan <shuah@kernel.org>
Cc:     kernel-team@android.com, Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v1 0/2] kselftest/arm64: fp-stress output clarity improvements
Date:   Tue,  8 Nov 2022 17:38:40 +0000
Message-Id: <166792340012.1917391.5252664593626184773.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20221017144553.773176-1-broonie@kernel.org>
References: <20221017144553.773176-1-broonie@kernel.org>
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

On Mon, 17 Oct 2022 15:45:51 +0100, Mark Brown wrote:
> This series provides a couple of improvements to the output of
> fp-stress, making it easier to follow what's going on and our
> application of the timeout a bit more even.
> 
> Mark Brown (2):
>   kselftest/arm64: Check that all children are producing output in
>     fp-stress
>   kselftest/arm64: Provide progress messages when signalling children
> 
> [...]

Applied to arm64 (for-next/selftests), thanks!

[1/2] kselftest/arm64: Check that all children are producing output in fp-stress
      https://git.kernel.org/arm64/c/3a38ef2b3cb6
[2/2] kselftest/arm64: Provide progress messages when signalling children
      https://git.kernel.org/arm64/c/3e02f57bcc6a

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
