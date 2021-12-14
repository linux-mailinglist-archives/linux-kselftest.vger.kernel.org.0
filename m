Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01D78474BB1
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Dec 2021 20:16:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234703AbhLNTQj (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 14 Dec 2021 14:16:39 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:43932 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232433AbhLNTQi (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 14 Dec 2021 14:16:38 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 847D3616BB
        for <linux-kselftest@vger.kernel.org>; Tue, 14 Dec 2021 19:16:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEBF1C34600;
        Tue, 14 Dec 2021 19:16:36 +0000 (UTC)
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Mark Brown <broonie@kernel.org>, Will Deacon <will@kernel.org>,
        Shuah Khan <shuah@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH] kselftest/arm64: Add pidbench for floating point syscall cases
Date:   Tue, 14 Dec 2021 19:16:34 +0000
Message-Id: <163950938830.2458221.13707487818262719707.b4-ty@arm.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211202165107.1075259-1-broonie@kernel.org>
References: <20211202165107.1075259-1-broonie@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, 2 Dec 2021 16:51:07 +0000, Mark Brown wrote:
> Since it's likely to be useful for performance work with SVE let's have a
> pidbench that gives us some numbers for consideration. In order to ensure
> that we test exactly the scenario we want this is written in assembly - if
> system libraries use SVE this would stop us exercising the case where the
> process has never used SVE.
> 
> We exercise three cases:
> 
> [...]

Applied to arm64 (for-next/kselftest), thanks!

[1/1] kselftest/arm64: Add pidbench for floating point syscall cases
      https://git.kernel.org/arm64/c/2c94ebedc844

-- 
Catalin

