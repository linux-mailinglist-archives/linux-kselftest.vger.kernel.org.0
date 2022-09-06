Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E54785AF307
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 Sep 2022 19:48:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229437AbiIFRsK (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 6 Sep 2022 13:48:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229580AbiIFRsJ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 6 Sep 2022 13:48:09 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16B5869F72
        for <linux-kselftest@vger.kernel.org>; Tue,  6 Sep 2022 10:48:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1E2AAB819ED
        for <linux-kselftest@vger.kernel.org>; Tue,  6 Sep 2022 17:47:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15514C433C1;
        Tue,  6 Sep 2022 17:47:41 +0000 (UTC)
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Shuah Khan <shuah@kernel.org>, Mark Brown <broonie@kernel.org>,
        Will Deacon <will@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org, Marc Zyngier <maz@kernel.org>,
        Zhang Lei <zhang.lei@jp.fujitsu.com>,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: (subset) [PATCH v3 0/3] arm64/sve: Document our actual SVE syscall ABI
Date:   Tue,  6 Sep 2022 18:47:39 +0100
Message-Id: <166248645521.3560121.16628754611809212536.b4-ty@arm.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220829162502.886816-1-broonie@kernel.org>
References: <20220829162502.886816-1-broonie@kernel.org>
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

On Mon, 29 Aug 2022 17:24:59 +0100, Mark Brown wrote:
> Currently our SVE syscall ABI documentation does not reflect the actual
> implemented ABI, it says that register state not shared with FPSIMD
> becomes undefined on syscall when in reality we always clear it. Since
> changing this would cause a change in the observed kernel behaviour
> there is a substantial desire to avoid taking advantage of the
> documented ABI so instead let's document what we actually do so it's
> clear that it is in reality an ABI.
> 
> [...]

Applied to arm64 (for-next/doc), thanks!

[2/3] arm64/sve: Document our actual ABI for clearing registers on syscall
      https://git.kernel.org/arm64/c/d09ee410a3c3

-- 
Catalin

