Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DB53378F55
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 May 2021 15:53:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233028AbhEJNlN (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 10 May 2021 09:41:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:45540 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1350360AbhEJM5U (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 10 May 2021 08:57:20 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A18E461040;
        Mon, 10 May 2021 12:56:12 +0000 (UTC)
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Will Deacon <will@kernel.org>, Shuah Khan <shuah@kernel.org>,
        Mark Brown <broonie@kernel.org>
Cc:     linux-kselftest@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] kselftest/arm64: Add missing stddef.h include to BTI tests
Date:   Mon, 10 May 2021 13:56:10 +0100
Message-Id: <162065127243.15638.15273612840235752724.b4-ty@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210507162542.23149-1-broonie@kernel.org>
References: <20210507162542.23149-1-broonie@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, 7 May 2021 17:25:42 +0100, Mark Brown wrote:
> Explicitly include stddef.h when building the BTI tests so that we have
> a definition of NULL, with at least some toolchains this is not done
> implicitly by anything else:
> 
> test.c: In function ‘start’:
> test.c:214:25: error: ‘NULL’ undeclared (first use in this function)
>   214 |  sigaction(SIGILL, &sa, NULL);
>       |                         ^~~~
> test.c:20:1: note: ‘NULL’ is defined in header ‘<stddef.h>’; did you forget to ‘#include <stddef.h>’?

Applied to arm64 (for-next/fixes), thanks!

[1/1] kselftest/arm64: Add missing stddef.h include to BTI tests
      https://git.kernel.org/arm64/c/a1bed090fc56

-- 
Catalin

