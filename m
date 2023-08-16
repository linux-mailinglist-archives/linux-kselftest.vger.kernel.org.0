Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0398F77E8A1
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Aug 2023 20:26:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234162AbjHPSZ6 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 16 Aug 2023 14:25:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345521AbjHPSZk (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 16 Aug 2023 14:25:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52BD410C1
        for <linux-kselftest@vger.kernel.org>; Wed, 16 Aug 2023 11:25:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CD83360AD7
        for <linux-kselftest@vger.kernel.org>; Wed, 16 Aug 2023 18:25:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4806C433C8;
        Wed, 16 Aug 2023 18:25:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692210335;
        bh=3OB+0jGpxFwrZAsIyEldxAoXpAeGJJFDaADP02UbZ6Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pLPA/M2b43PpYjHnx+0qs78n7RbS7ICWBdrhoE9miyi4i/k9arS1LhLlwomsWht9C
         QtnHQsjVLfI/T7zgbVKl204VS6bOCWFZJmnKQ8YhypCTl68mjXGGOJ8Kmx7fh+BpAR
         MW248OtcPR4ggqrZhhfLEqCjt9QiIaestczNAsnOZBaS/4l5OQOv7fVen6X9kTgG1v
         Vxvj5w/yfUjW37MCYaZUpA+I7BX286WkUUK4mMwq/HNDMNlhHa3fEktWtAlNirOmPP
         fX+Qz57JmZ5E0LC1dA0cEaYpQbayd8YhpMTttHEJF1sKqUy5jv2rJi0UbtyBAnYsql
         wo4XaatP2rv5w==
From:   Will Deacon <will@kernel.org>
To:     Andre Przywara <andre.przywara@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Shuah Khan <shuah@kernel.org>
Cc:     kernel-team@android.com, Will Deacon <will@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        linux-kselftest@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] kselftest/arm64: build BTI tests in output directory
Date:   Wed, 16 Aug 2023 19:25:23 +0100
Message-Id: <169219342837.1947103.11802774487228057167.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20230815145931.2522557-1-andre.przywara@arm.com>
References: <20230815145931.2522557-1-andre.przywara@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, 15 Aug 2023 15:59:31 +0100, Andre Przywara wrote:
> The arm64 BTI selftests are currently built in the source directory,
> then the generated binaries are copied to the output directory.
> This leaves the object files around in a potentially otherwise pristine
> source tree, tainting it for out-of-tree kernel builds.
> 
> Prepend $(OUTPUT) to every reference to an object file in the Makefile,
> and remove the extra handling and copying. This puts all generated files
> under the output directory.
> 
> [...]

Applied to arm64 (for-next/selftests), thanks!

[1/1] kselftest/arm64: build BTI tests in output directory
      https://git.kernel.org/arm64/c/e08302ee46c9

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
