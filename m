Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E191549FE2E
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Jan 2022 17:36:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350156AbiA1Qgm (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 28 Jan 2022 11:36:42 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:40646 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350253AbiA1Qgi (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 28 Jan 2022 11:36:38 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3BA01B82421
        for <linux-kselftest@vger.kernel.org>; Fri, 28 Jan 2022 16:36:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B482C340E7;
        Fri, 28 Jan 2022 16:36:34 +0000 (UTC)
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Shuah Khan <shuah@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Mark Brown <broonie@kernel.org>, Will Deacon <will@kernel.org>
Cc:     linux-kselftest@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v1 0/2] kselftest/arm64: Small fixes for sve-ptrace test
Date:   Fri, 28 Jan 2022 16:36:32 +0000
Message-Id: <164338778361.1487778.11798631924947396189.b4-ty@arm.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220124175527.3260234-1-broonie@kernel.org>
References: <20220124175527.3260234-1-broonie@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, 24 Jan 2022 17:55:25 +0000, Mark Brown wrote:
> A couple of fairly minor fixes for the sve-ptrace test, one output thing
> and one for an issue which would generate spurious false positives.
> 
> Mark Brown (2):
>   kselftest/arm64: Skip VL_INHERIT tests for unsupported vector types
>   kselftest/arm64: Correct logging of FPSIMD register read via ptrace
> 
> [...]

Applied to arm64 (for-next/fixes), thanks!

[1/2] kselftest/arm64: Skip VL_INHERIT tests for unsupported vector types
      https://git.kernel.org/arm64/c/50806fd91428
[2/2] kselftest/arm64: Correct logging of FPSIMD register read via ptrace
      https://git.kernel.org/arm64/c/9ae279ecabe3

-- 
Catalin

