Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45DED4B7B23
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Feb 2022 00:19:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244789AbiBOXTS (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 15 Feb 2022 18:19:18 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:36116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238655AbiBOXTR (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 15 Feb 2022 18:19:17 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B56A8C1C9E
        for <linux-kselftest@vger.kernel.org>; Tue, 15 Feb 2022 15:19:05 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 3466FCE2428
        for <linux-kselftest@vger.kernel.org>; Tue, 15 Feb 2022 23:19:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B90EDC340F0;
        Tue, 15 Feb 2022 23:19:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644967142;
        bh=a28YIHSUOy9eOFEg+BnX1V/dUAmlqgrDdm7faAdVzFc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=e1rp+8+5gXaBRXYjRF+BaMZNC7vqgfQW/QTFAIZ8bCE3dEQkSlNyFeSsZmMz7aDXK
         PgzcIcVh6CVpMpEJzwhyuKoLx+KqqLLRgmUTQgnl1g3oD5AGD+n4v668LDWZpKClqo
         OOKx91uvKAvXB6WZE7E6n5HRj6BENQ7oX7DhOeyjv7k6AcpCwfedrDewsQWtRTpWYr
         M+pqCgt+2T3Lx6dJywwLAr38CT48jtmwRkVGx5uosMiOWgMy6+7NMPE4oGB3LZPjXa
         RRWuYqc9XL5v5Pe6+wdCy9jJVnCNRnIo3toE8YSndIdmY2AL5s1SaXy2L+NNbFyXbd
         /uImdp60QQFGA==
From:   Will Deacon <will@kernel.org>
To:     Joey Gouly <joey.gouly@arm.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     catalin.marinas@arm.com, kernel-team@android.com,
        Will Deacon <will@kernel.org>, shuah@kernel.org,
        skhan@linuxfoundation.org, linux-kselftest@vger.kernel.org,
        broonie@kernel.org, nd@arm.com
Subject: Re: [PATCH v3 0/6] add more test coverage to MTE kselftests
Date:   Tue, 15 Feb 2022 23:18:31 +0000
Message-Id: <164494427139.150360.10580448401712881711.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220209152240.52788-1-joey.gouly@arm.com>
References: <20220209152240.52788-1-joey.gouly@arm.com>
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

On Wed, 9 Feb 2022 15:22:34 +0000, Joey Gouly wrote:
> This is a series which refactors and then adds some extra tests for MTE
> in the kselftest framework.
> 
> The issue that these tests are for was was fixed by Robin in
> 295cf156231c ("arm64: Avoid premature usercopy failure") and based on a
> simplified example by Catalin [1].
> 
> [...]

Applied to arm64 (for-next/kselftest), thanks!

[1/6] kselftest/arm64: mte: user_mem: introduce tag_offset and tag_len
      https://git.kernel.org/arm64/c/d53f8f8dbe97
[2/6] kselftest/arm64: mte: user_mem: rework error handling
      https://git.kernel.org/arm64/c/ff0b9aba30ae
[3/6] kselftest/arm64: mte: user_mem: check different offsets and sizes
      https://git.kernel.org/arm64/c/682b064bae87
[4/6] kselftest/arm64: mte: user_mem: add test type enum
      https://git.kernel.org/arm64/c/b9fc700176f1
[5/6] kselftest/arm64: mte: user_mem: add more test types
      https://git.kernel.org/arm64/c/e8d3974f34fa
[6/6] kselftest/arm64: mte: user_mem: test a wider range of values
      https://git.kernel.org/arm64/c/0a775ccb8120

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
