Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D0392F6869
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Jan 2021 18:55:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728612AbhANRyl (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 14 Jan 2021 12:54:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:39654 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729246AbhANRyk (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 14 Jan 2021 12:54:40 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6266423A59;
        Thu, 14 Jan 2021 17:53:59 +0000 (UTC)
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Mark Brown <broonie@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc:     Will Deacon <will@kernel.org>, Dave Martin <Dave.Martin@arm.com>,
        linux-kselftest@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] arm64: selftests: Fix spelling of 'Mismatch'
Date:   Thu, 14 Jan 2021 17:53:57 +0000
Message-Id: <161064683418.30788.10111193455763198611.b4-ty@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210108183144.673-1-broonie@kernel.org>
References: <20210108183144.673-1-broonie@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, 8 Jan 2021 18:31:44 +0000, Mark Brown wrote:
> The SVE and FPSIMD stress tests have a spelling mistake in the output, fix
> it.

Applied to arm64 (for-next/fixes), thanks!

[1/1] arm64: selftests: Fix spelling of 'Mismatch'
      https://git.kernel.org/arm64/c/73a7c155a2b2

-- 
Catalin

