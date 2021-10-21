Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20F1B435F21
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Oct 2021 12:36:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230052AbhJUKix (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 21 Oct 2021 06:38:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:55290 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229567AbhJUKiw (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 21 Oct 2021 06:38:52 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7AA2561205;
        Thu, 21 Oct 2021 10:36:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634812596;
        bh=xKn9KJznrQG/3DQyRokl1bSd6VKmBTZtwp+MqdIMuAY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=o+2u/77VMmSORPliVa8egPrqnxM3bv8bBdHB8oMg/tyTOBwfFIdMRPOfsRMPJxuMS
         nRndx2R8v2eyUlJhpWnOF5BMLXmK2ebdr7e+NndhpPl9LNVVPKMTUGiEU1/gSIDoQ1
         uCVEcYGu8w3VvSaXrbeFJBRXMbs1Y/JzUooHvGcBf8L/Wlcd6JMaxNZmf3rchkVm64
         QFUAeWBAFca/gamUjWDLzBA890T1Czk0ETp+4vmcj0z9bYxeFtZuV1xpsRyDxIkpXD
         CRP3AsOgG0eDGmAka6vJWPeRXrQbCpR1cdcaxgOgtkhMWxKNHcfk7bSXY53ZIldXeX
         UQXPZl0B+jZZw==
From:   Will Deacon <will@kernel.org>
To:     Mark Brown <broonie@kernel.org>, Shuah Khan <shuah@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>
Cc:     kernel-team@android.com, Will Deacon <will@kernel.org>,
        linux-kselftest@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] selftests: arm64: Factor out utility functions for assembly FP tests
Date:   Thu, 21 Oct 2021 11:36:32 +0100
Message-Id: <163481108779.3657334.8833785606044125446.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20211019181851.3341232-1-broonie@kernel.org>
References: <20211019181851.3341232-1-broonie@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, 19 Oct 2021 19:18:51 +0100, Mark Brown wrote:
> The various floating point test programs written in assembly have a bunch
> of helper functions and macros which are cut'n'pasted between them. Factor
> them out into a separate source file which is linked into all of them.
> 
> We don't include memcmp() since it isn't as generic as it should be and
> directly branches to report an error in the programs.
> 
> [...]

Applied to arm64 (for-next/kselftest), thanks!

[1/1] selftests: arm64: Factor out utility functions for assembly FP tests
      https://git.kernel.org/arm64/c/260ea4ba94e8

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
