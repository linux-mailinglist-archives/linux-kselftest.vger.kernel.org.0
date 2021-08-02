Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A44D33DDEE6
	for <lists+linux-kselftest@lfdr.de>; Mon,  2 Aug 2021 20:06:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229551AbhHBSGc (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 2 Aug 2021 14:06:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:47854 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229537AbhHBSGc (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 2 Aug 2021 14:06:32 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7437960EE8;
        Mon,  2 Aug 2021 18:06:20 +0000 (UTC)
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Shuah Khan <shuah@kernel.org>, Will Deacon <will@kernel.org>,
        Mark Brown <broonie@kernel.org>
Cc:     linux-kselftest@vger.kernel.org,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] kselftest/arm64: Ignore check_gcr_el1_cswitch binary
Date:   Mon,  2 Aug 2021 19:06:17 +0100
Message-Id: <162792757024.21283.7196137698585667043.b4-ty@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210728173539.6231-1-broonie@kernel.org>
References: <20210728173539.6231-1-broonie@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, 28 Jul 2021 18:35:39 +0100, Mark Brown wrote:
> We added check_gcr_el1_cswitch but did not ignore the generated binary,
> add it.

Applied to arm64 (for-next/kselftest), thanks!

[1/1] kselftest/arm64: Ignore check_gcr_el1_cswitch binary
      https://git.kernel.org/arm64/c/dac3ce63bffe

-- 
Catalin

