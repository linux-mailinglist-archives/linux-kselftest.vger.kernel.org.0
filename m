Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1AB24281A56
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 Oct 2020 20:00:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387768AbgJBSAS (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 2 Oct 2020 14:00:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:59852 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387602AbgJBSAS (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 2 Oct 2020 14:00:18 -0400
Received: from gaia (unknown [95.149.105.49])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7D2FB206DD;
        Fri,  2 Oct 2020 18:00:16 +0000 (UTC)
Date:   Fri, 2 Oct 2020 19:00:14 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Amit Daniel Kachhap <amit.kachhap@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shuah Khan <shuah@kernel.org>, Will Deacon <will@kernel.org>,
        Vincenzo Frascino <Vincenzo.Frascino@arm.com>,
        Gabor Kertesz <gabor.kertesz@arm.com>
Subject: Re: [PATCH v2 0/6] kselftest: arm64/mte: Tests for user-space MTE
Message-ID: <20201002180013.GA6099@gaia>
References: <20201002115630.24683-1-amit.kachhap@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201002115630.24683-1-amit.kachhap@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Oct 02, 2020 at 05:26:24PM +0530, Amit Daniel Kachhap wrote:
> Amit Daniel Kachhap (6):
>   kselftest/arm64: Add utilities and a test to validate mte memory
>   kselftest/arm64: Verify mte tag inclusion via prctl
>   kselftest/arm64: Check forked child mte memory accessibility
>   kselftest/arm64: Verify all different mmap MTE options
>   kselftest/arm64: Verify KSM page merge for MTE pages
>   kselftest/arm64: Check mte tagged user address in kernel

Thanks Amit for respinning the series. Tested on FVP (some Qemu bugs get
in the way and they fail).

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
Tested-by: Catalin Marinas <catalin.marinas@arm.com>
