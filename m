Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1FAE42504D
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Oct 2021 11:48:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232625AbhJGJuQ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 7 Oct 2021 05:50:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:55916 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231797AbhJGJuQ (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 7 Oct 2021 05:50:16 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9109A61019;
        Thu,  7 Oct 2021 09:48:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633600102;
        bh=CyxYwfYpIh6ykWnZ6yQGfxvl5rQCbrw5thd3YY84SPo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pUs/MkX+0VKWx8/H+fP6mk9zwkHYDcxMY9MstP/3mFpnQE1PuNk9UV9bfXCemX5Dt
         4+NQ82fhlOyu/VqzjGqI/dLtsK5x7C15zuP+88r8usSDkmYkWQQMrLp24M3sV52vcf
         wiCdTT9FCDtpxcyf8l8WkfB07XAP9atBvc5Pc3Pv490/HAz+cKO7zQjKETH5/alFz+
         8plW3rBlmmUe2yxIT/60vi0pyLKyiSYwECgp4Pwq3BMdkUQeUh55Hzm77/gqq3lLY1
         YCJgBCvbG9CrdINZbXbnv+fe6S+jh9PO9AQnz0Gem2r3nLmMpCY8P8OMm82UvS4+L6
         QdPRo3d1yr1QQ==
From:   Will Deacon <will@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Shuah Khan <shuah@kernel.org>, Mark Brown <broonie@kernel.org>
Cc:     kernel-team@android.com, Will Deacon <will@kernel.org>,
        linux-kselftest@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] selftests: arm64: Add coverage of ptrace flags for SVE VL inheritance
Date:   Thu,  7 Oct 2021 10:48:15 +0100
Message-Id: <163359485294.3122542.18124730362213850943.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20211005123537.976795-1-broonie@kernel.org>
References: <20211005123537.976795-1-broonie@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, 5 Oct 2021 13:35:37 +0100, Mark Brown wrote:
> Add a test that covers enabling and disabling of SVE vector length
> inheritance via the ptrace interface.
> 
> 

Applied to arm64 (for-next/kselftest), thanks!

[1/1] selftests: arm64: Add coverage of ptrace flags for SVE VL inheritance
      https://git.kernel.org/arm64/c/0ba1ce1e8605

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
