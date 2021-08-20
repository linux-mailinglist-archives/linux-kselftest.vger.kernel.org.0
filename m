Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6AD0A3F2A0E
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 Aug 2021 12:21:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238967AbhHTKWK (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 20 Aug 2021 06:22:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:58664 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237840AbhHTKWK (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 20 Aug 2021 06:22:10 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B37CC60F58;
        Fri, 20 Aug 2021 10:21:31 +0000 (UTC)
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Will Deacon <will@kernel.org>, Mark Brown <broonie@kernel.org>,
        Shuah Khan <shuah@kernel.org>
Cc:     linux-kselftest@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Amit Daniel Kachhap <amit.kachhap@arm.com>
Subject: Re: [PATCH] kselftest/arm64: mte: Fix misleading output when skipping tests
Date:   Fri, 20 Aug 2021 11:21:20 +0100
Message-Id: <162945486488.9629.5209865978733012612.b4-ty@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210819172902.56211-1-broonie@kernel.org>
References: <20210819172902.56211-1-broonie@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, 19 Aug 2021 18:29:02 +0100, Mark Brown wrote:
> When skipping the tests due to a lack of system support for MTE we
> currently print a message saying FAIL which makes it look like the test
> failed even though the test did actually report KSFT_SKIP, creating some
> confusion. Change the error message to say SKIP instead so things are
> clearer.

Applied to arm64 (for-next/kselftest), thanks!

[1/1] kselftest/arm64: mte: Fix misleading output when skipping tests
      https://git.kernel.org/arm64/c/83e5dcbece4e

-- 
Catalin

