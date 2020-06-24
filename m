Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFE262074F5
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Jun 2020 15:55:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389544AbgFXNze (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 24 Jun 2020 09:55:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:42522 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389484AbgFXNzd (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 24 Jun 2020 09:55:33 -0400
Received: from localhost.localdomain (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4BADB20724;
        Wed, 24 Jun 2020 13:55:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593006933;
        bh=vEGClZXBGO66MibJHZLdYrvndiev8/JfZBUoPk7jgAs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=shx+pOvLd9887u2dxjiSdP7t0yxXzx3j8ChpX+PLA1h9gcjd+egQl0raNOCIvqUlZ
         Zrt7hti/NH0WvFLNSyoyD23gLYisa8cABuhZmTrSbSQuh7KcBsX1YsmF/9mwICiqh4
         f7GeBmQBEuHsIbB/nLz2uSAHP5aHVAVUSWCfRkms=
From:   Will Deacon <will@kernel.org>
To:     Mark Brown <broonie@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Shuah Khan <shuah@kernel.org>
Cc:     kernel-team@android.com, Will Deacon <will@kernel.org>,
        linux-kselftest@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] kselftest: arm64: Remove redundant clean target
Date:   Wed, 24 Jun 2020 14:54:50 +0100
Message-Id: <159300517676.57548.17647708479973577600.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200624104933.21125-1-broonie@kernel.org>
References: <20200624104933.21125-1-broonie@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, 24 Jun 2020 11:49:33 +0100, Mark Brown wrote:
> The arm64 signal tests generate warnings during build since both they and
> the toplevel lib.mk define a clean target:
> 
> Makefile:25: warning: overriding recipe for target 'clean'
> ../../lib.mk:126: warning: ignoring old recipe for target 'clean'
> 
> Since the inclusion of lib.mk is in the signal Makefile there is no
> situation where this warning could be avoided so just remove the redundant
> clean target.

Applied to arm64 (for-next/fixes), thanks!

[1/1] kselftest: arm64: Remove redundant clean target
      https://git.kernel.org/arm64/c/cb944f02d0d8

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
