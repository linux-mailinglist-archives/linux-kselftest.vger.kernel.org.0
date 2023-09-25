Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFFBF7ADD9C
	for <lists+linux-kselftest@lfdr.de>; Mon, 25 Sep 2023 19:10:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229437AbjIYRKt (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 25 Sep 2023 13:10:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231395AbjIYRKs (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 25 Sep 2023 13:10:48 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12D2BBC;
        Mon, 25 Sep 2023 10:10:42 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F663C433C9;
        Mon, 25 Sep 2023 17:10:40 +0000 (UTC)
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Will Deacon <will@kernel.org>, Shuah Khan <shuah@kernel.org>,
        Mark Brown <broonie@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kselftest/arm64: Validate SVCR in streaming SVE stress test
Date:   Mon, 25 Sep 2023 18:10:38 +0100
Message-Id: <169566182997.219362.257797634025870120.b4-ty@arm.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230922-arm64-ssve-validate-svcr-v1-1-f518960eaeda@kernel.org>
References: <20230922-arm64-ssve-validate-svcr-v1-1-f518960eaeda@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, 22 Sep 2023 14:42:55 +0100, Mark Brown wrote:
> In the ZA and ZT test programs we explicitly validate that PSTATE.ZA is as
> expected on each loop but we do not do the equivalent for our streaming
> SVE test, add a check that we are still in streaming mode on every loop
> in case that goes wrong.
> 
> 

Applied to arm64 (for-next/kselftest), thanks!

[1/1] kselftest/arm64: Validate SVCR in streaming SVE stress test
      https://git.kernel.org/arm64/c/11a7a42ea76e

-- 
Catalin

