Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5ADE9474F2D
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Dec 2021 01:27:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238500AbhLOA0x (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 14 Dec 2021 19:26:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238494AbhLOA0u (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 14 Dec 2021 19:26:50 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee2:21ea])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2711C06173F
        for <linux-kselftest@vger.kernel.org>; Tue, 14 Dec 2021 16:26:49 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4JDGJh0qycz4xRB;
        Wed, 15 Dec 2021 11:26:44 +1100 (AEDT)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     linuxppc-dev@lists.ozlabs.org,
        Thadeu Lima de Souza Cascardo <cascardo@canonical.com>
Cc:     linux-kselftest@vger.kernel.org, mpe@ellerman.id.au
In-Reply-To: <20211207130557.40566-1-cascardo@canonical.com>
References: <20211207130557.40566-1-cascardo@canonical.com>
Subject: Re: [PATCH] selftests/powerpc/spectre_v2: Return skip code when miss_percent is high
Message-Id: <163952788080.919625.5237049240642905738.b4-ty@ellerman.id.au>
Date:   Wed, 15 Dec 2021 11:24:40 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, 7 Dec 2021 10:05:57 -0300, Thadeu Lima de Souza Cascardo wrote:
> A mis-match between reported and actual mitigation is not restricted to the
> Vulnerable case. The guest might also report the mitigation as "Software
> count cache flush" and the host will still mitigate with branch cache
> disabled.
> 
> So, instead of skipping depending on the detected mitigation, simply skip
> whenever the detected miss_percent is the expected one for a fully
> mitigated system, that is, above 95%.
> 
> [...]

Applied to powerpc/next.

[1/1] selftests/powerpc/spectre_v2: Return skip code when miss_percent is high
      https://git.kernel.org/powerpc/c/3c42e9542050d49610077e083c7c3f5fd5e26820

cheers
