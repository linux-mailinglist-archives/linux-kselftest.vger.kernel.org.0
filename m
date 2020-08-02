Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DC22235720
	for <lists+linux-kselftest@lfdr.de>; Sun,  2 Aug 2020 15:35:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728373AbgHBNfB (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 2 Aug 2020 09:35:01 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:56877 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726578AbgHBNfB (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 2 Aug 2020 09:35:01 -0400
Received: by ozlabs.org (Postfix, from userid 1034)
        id 4BKMSz4l3Vz9sTK; Sun,  2 Aug 2020 23:34:59 +1000 (AEST)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Thadeu Lima de Souza Cascardo <cascardo@canonical.com>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, Shuah Khan <shuah@kernel.org>
In-Reply-To: <20200728155039.401445-1-cascardo@canonical.com>
References: <20200728155039.401445-1-cascardo@canonical.com>
Subject: Re: [PATCH] selftests/powerpc: return skip code for spectre_v2
Message-Id: <159637523453.42190.2614653860464292630.b4-ty@ellerman.id.au>
Date:   Sun,  2 Aug 2020 23:34:59 +1000 (AEST)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, 28 Jul 2020 12:50:39 -0300, Thadeu Lima de Souza Cascardo wrote:
> When running under older versions of qemu of under newer versions with old
> machine types, some security features will not be reported to the guest.
> This will lead the guest OS to consider itself Vulnerable to spectre_v2.
> 
> So, spectre_v2 test fails in such cases when the host is mitigated and miss
> predictions cannot be detected as expected by the test.
> 
> [...]

Applied to powerpc/next.

[1/1] selftests/powerpc: Return skip code for spectre_v2
      https://git.kernel.org/powerpc/c/f3054ffd71b5afd44832b2207e6e90267e1cd2d1

cheers
