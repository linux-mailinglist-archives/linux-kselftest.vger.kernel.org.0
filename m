Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 13CD9F4EB7
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Nov 2019 15:50:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725941AbfKHOuY (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 8 Nov 2019 09:50:24 -0500
Received: from foss.arm.com ([217.140.110.172]:45032 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725883AbfKHOuY (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 8 Nov 2019 09:50:24 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 93E4E46A;
        Fri,  8 Nov 2019 06:50:23 -0800 (PST)
Received: from arrakis.emea.arm.com (arrakis.cambridge.arm.com [10.1.197.42])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 768A53F71A;
        Fri,  8 Nov 2019 06:50:22 -0800 (PST)
Date:   Fri, 8 Nov 2019 14:50:20 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Cristian Marussi <cristian.marussi@arm.com>
Cc:     linux-kselftest@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, shuah@kernel.org,
        amit.kachhap@arm.com, andreyknvl@google.com, dave.martin@arm.com,
        suzuki.poulose@arm.com
Subject: Re: [PATCH v10 00/12] Add arm64/signal initial kselftest support
Message-ID: <20191108145020.GF22834@arrakis.emea.arm.com>
References: <20191025175717.15154-1-cristian.marussi@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191025175717.15154-1-cristian.marussi@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Cristian, Shuah,

On Fri, Oct 25, 2019 at 06:57:05PM +0100, Cristian Marussi wrote:
> Cristian Marussi (12):
>   kselftest: arm64: extend toplevel skeleton Makefile
>   kselftest: arm64: mangle_pstate_invalid_compat_toggle and common utils
>   kselftest: arm64: mangle_pstate_invalid_daif_bits
>   kselftest: arm64: mangle_pstate_invalid_mode_el[123][ht]
>   kselftest: arm64: extend test_init functionalities
>   kselftest: arm64: add helper get_current_context
>   kselftest: arm64: fake_sigreturn_bad_magic
>   kselftest: arm64: fake_sigreturn_bad_size_for_magic0
>   kselftest: arm64: fake_sigreturn_missing_fpsimd
>   kselftest: arm64: fake_sigreturn_duplicated_fpsimd
>   kselftest: arm64: fake_sigreturn_bad_size
>   kselftest: arm64: fake_sigreturn_misaligned_sp

I queued these patches through the arm64 tree and plan to send them to
Linus for 5.5. Please let me know if there are any objections.

I'd also like to propose the maintainers update below for the arm64
specific selftests:

------------------------8<-------------------------------
From 629ac5665380c0c65e44e0aaf717090905204555 Mon Sep 17 00:00:00 2001
From: Catalin Marinas <catalin.marinas@arm.com>
Date: Fri, 8 Nov 2019 14:46:54 +0000
Subject: [PATCH] MAINTAINERS: Add arm64 selftests to the ARM64 PORT entry

Since these are tests specific to the arm64 architecture, it makes sense
for the arm64 maintainers to gatekeep the corresponding changes.

Cc: Shuah Khan <shuah@kernel.org>
Cc: Will Deacon <will@kernel.org>
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index a69e6db80c79..553c64308060 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2609,6 +2609,7 @@ S:	Maintained
 F:	arch/arm64/
 X:	arch/arm64/boot/dts/
 F:	Documentation/arm64/
+F:	tools/testing/selftests/arm64/
 
 AS3645A LED FLASH CONTROLLER DRIVER
 M:	Sakari Ailus <sakari.ailus@iki.fi>
