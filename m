Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4809E3466D2
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Mar 2021 18:55:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230305AbhCWRy3 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 23 Mar 2021 13:54:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:40350 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230370AbhCWRyR (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 23 Mar 2021 13:54:17 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2C4B3619AE;
        Tue, 23 Mar 2021 17:54:16 +0000 (UTC)
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Will Deacon <will@kernel.org>, Mark Brown <broonie@kernel.org>,
        Shuah Khan <shuah@kernel.org>
Cc:     linux-kselftest@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Dave Martin <Dave.Martin@arm.com>
Subject: Re: [PATCH] kselftest: arm64: Add BTI tests
Date:   Tue, 23 Mar 2021 17:54:14 +0000
Message-Id: <161652203084.28887.3191390288288441689.b4-ty@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210309193731.57247-1-broonie@kernel.org>
References: <20210309193731.57247-1-broonie@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, 9 Mar 2021 19:37:31 +0000, Mark Brown wrote:
> Add some tests that verify that BTI functions correctly for static binaries
> built with and without BTI support, verifying that SIGILL is generated when
> expected and is not generated in other situations.
> 
> Since BTI support is still being rolled out in distributions these tests
> are built entirely free standing, no libc support is used at all so none
> of the standard helper functions for kselftest can be used and we open
> code everything. This also means we aren't testing the kernel support for
> the dynamic linker, though the test program can be readily adapted for
> that once it becomes something that we can reliably build and run.
> 
> [...]

Applied to arm64 (for-next/kselftest), thanks!

[1/1] kselftest: arm64: Add BTI tests
      https://git.kernel.org/arm64/c/d15723c0cbae

-- 
Catalin

