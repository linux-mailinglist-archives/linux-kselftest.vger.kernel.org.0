Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 742B42701EA
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Sep 2020 18:17:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726250AbgIRQRZ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 18 Sep 2020 12:17:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:59226 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726200AbgIRQRZ (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 18 Sep 2020 12:17:25 -0400
Received: from localhost.localdomain (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 54B1F20795;
        Fri, 18 Sep 2020 16:17:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600445844;
        bh=5iF9yKzD7Xb2xJQE4OZeKA+iY8mdao501/QH7NziaMg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZUjmUb3IZ3odj6AJqkIopl3zQHZMcKpviI2Gtcp1f2UHFIMMJLz7INeEAN9izA2j4
         NL68EYbcZNPzOIlAxrWKCvMNa6a6zPSKoNMSkpv2dVgJm+pY7N1zIBA1vBodIDp/vT
         ugeg5jUJ6+R9vNRLRcK6+LY8ZJcugCdaKHeHu9TI=
From:   Will Deacon <will@kernel.org>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        Boyan Karatotev <boian4o1@gmail.com>
Cc:     catalin.marinas@arm.com, kernel-team@android.com,
        Will Deacon <will@kernel.org>,
        Vincenzo Frascino <Vincenzo.Frascino@arm.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Shuah Khan <shuah@kernel.org>,
        Amit Daniel Kachhap <amit.kachhap@arm.com>,
        Boyan Karatotev <boyan.karatotev@arm.com>
Subject: Re: [PATCH v3 0/4] kselftests/arm64: add PAuth tests
Date:   Fri, 18 Sep 2020 17:17:12 +0100
Message-Id: <160043444117.3782204.2915694292164930857.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200918104715.182310-1-boian4o1@gmail.com>
References: <20200918104715.182310-1-boian4o1@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, 18 Sep 2020 11:47:11 +0100, Boyan Karatotev wrote:
> Pointer Authentication (PAuth) is a security feature introduced in ARMv8.3.
> It introduces instructions to sign addresses and later check for potential
> corruption using a second modifier value and one of a set of keys. The
> signature, in the form of the Pointer Authentication Code (PAC), is stored
> in some of the top unused bits of the virtual address (e.g. [54: 49] if
> TBID0 is enabled and TnSZ is set to use a 48 bit VA space). A set of
> controls are present to enable/disable groups of instructions (which use
> certain keys) for compatibility with libraries that do not utilize the
> feature. PAuth is used to verify the integrity of return addresses on the
> stack with less memory than the stack canary.
> 
> [...]

Applied to arm64 (for-next/selftests), thanks!

[1/4] kselftests/arm64: add a basic Pointer Authentication test
      https://git.kernel.org/arm64/c/e74e1d557285
[2/4] kselftests/arm64: add nop checks for PAuth tests
      https://git.kernel.org/arm64/c/766d95b1ed93
[3/4] kselftests/arm64: add PAuth test for whether exec() changes keys
      https://git.kernel.org/arm64/c/806a15b2545e
[4/4] kselftests/arm64: add PAuth tests for single threaded consistency and differently initialized keys
      https://git.kernel.org/arm64/c/d21435e9670b

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
