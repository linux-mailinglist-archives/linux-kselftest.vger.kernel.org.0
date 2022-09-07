Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CED255B0BDE
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Sep 2022 19:57:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229551AbiIGR50 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 7 Sep 2022 13:57:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbiIGR5Z (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 7 Sep 2022 13:57:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A85586705;
        Wed,  7 Sep 2022 10:57:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F2FAC61300;
        Wed,  7 Sep 2022 17:57:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6DE3C433D6;
        Wed,  7 Sep 2022 17:57:21 +0000 (UTC)
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Mark Brown <broonie@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Colin Ian King <colin.i.king@gmail.com>,
        Shuah Khan <shuah@kernel.org>, Will Deacon <will@kernel.org>,
        linux-kselftest@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] kselftest/arm64: Fix spelling misakes of signal names
Date:   Wed,  7 Sep 2022 18:57:19 +0100
Message-Id: <166257342260.3993131.13467056617252627882.b4-ty@arm.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220907170902.687340-1-colin.i.king@gmail.com>
References: <20220907170902.687340-1-colin.i.king@gmail.com>
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

On Wed, 7 Sep 2022 18:09:02 +0100, Colin Ian King wrote:
> There are a couple of spelling mistakes of signame names. Fix them.
> 
> 

Applied to arm64 (for-next/kselftest), thanks!

[1/1] kselftest/arm64: Fix spelling misakes of signal names
      https://git.kernel.org/arm64/c/537addee1e8e

-- 
Catalin

