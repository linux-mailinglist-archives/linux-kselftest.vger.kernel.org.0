Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DA1836EBD9
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 Apr 2021 16:03:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239774AbhD2ODf (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 29 Apr 2021 10:03:35 -0400
Received: from ozlabs.org ([203.11.71.1]:58025 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239973AbhD2ODf (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 29 Apr 2021 10:03:35 -0400
Received: by ozlabs.org (Postfix, from userid 1034)
        id 4FWHJQ73ngz9tD5; Fri, 30 Apr 2021 00:02:46 +1000 (AEST)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     mpe@ellerman.id.au, Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Cc:     shuah@kernel.org, mikey@neuling.org,
        linux-kselftest@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        dja@axtens.net
In-Reply-To: <20210412112218.128183-1-ravi.bangoria@linux.ibm.com>
References: <20210412112218.128183-1-ravi.bangoria@linux.ibm.com>
Subject: Re: [PATCH v3 0/4] powerpc/selftests: Add Power10 2nd DAWR selftests
Message-Id: <161970488433.4033873.12531351983196456423.b4-ty@ellerman.id.au>
Date:   Fri, 30 Apr 2021 00:01:24 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, 12 Apr 2021 16:52:14 +0530, Ravi Bangoria wrote:
> Power10 introduced 2nd watchpoint (DAWR). ISA 3.1, Book 3S, Ch 9 -
> 'Debug Facilities' covers the feature in detail. Kernel patches to
> enable the 2nd DAWR are already in[1], including kvm enablement[2].
> These patches adds selftests for 2nd DAWR.
> 
> [1]: https://git.kernel.org/torvalds/c/deb2bd9bcc8428d4b65b6ba640ba8b57c1b20b17
> [2]: https://git.kernel.org/torvalds/c/bd1de1a0e6eff4bde5ceae969673b85b8446fd6a
> 
> [...]

Applied to powerpc/next.

[1/4] powerpc/selftests/ptrace-hwbreak: Add testcases for 2nd DAWR
      https://git.kernel.org/powerpc/c/dae4ff8031b49af4721101d6298fc14cb9c16a4c
[2/4] powerpc/selftests/perf-hwbreak: Coalesce event creation code
      https://git.kernel.org/powerpc/c/c9cb0afb4eaa03801322f48dad4093979ff45e88
[3/4] powerpc/selftests/perf-hwbreak: Add testcases for 2nd DAWR
      https://git.kernel.org/powerpc/c/c65c64cc7bbd273121edf96a7a5a0269038ab454
[4/4] powerpc/selftests: Add selftest to test concurrent perf/ptrace events
      https://git.kernel.org/powerpc/c/290f7d8ce2b1eea5413bb120e0d9d610675b7fba

cheers
