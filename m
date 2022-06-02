Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72BB153BEF9
	for <lists+linux-kselftest@lfdr.de>; Thu,  2 Jun 2022 21:41:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235060AbiFBTlc (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 2 Jun 2022 15:41:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238813AbiFBTlY (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 2 Jun 2022 15:41:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A800824BCE;
        Thu,  2 Jun 2022 12:41:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5D641617BF;
        Thu,  2 Jun 2022 19:41:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE438C385A5;
        Thu,  2 Jun 2022 19:41:04 +0000 (UTC)
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     linux-kselftest@vger.kernel.org,
        Cristian Marussi <cristian.marussi@arm.com>
Cc:     Will Deacon <will@kernel.org>, skhan@linuxfoundation.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Andre Przywara <andre.przywara@arm.com>,
        Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] kselftest/arm64: signal: Skip SVE signal test if not enough VLs supported
Date:   Thu,  2 Jun 2022 20:41:02 +0100
Message-Id: <165419885870.2681883.16583571077813960590.b4-ty@arm.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220524103149.2802-1-cristian.marussi@arm.com>
References: <20220524103149.2802-1-cristian.marussi@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, 24 May 2022 11:31:49 +0100, Cristian Marussi wrote:
> On platform where SVE is supported but there are less than 2 VLs available
> the signal SVE change test should be skipped instead of failing.
> 
> 

Applied to arm64 (for-next/core), thanks!

[1/1] kselftest/arm64: signal: Skip SVE signal test if not enough VLs supported
      https://git.kernel.org/arm64/c/78c09c0f4df8

-- 
Catalin

