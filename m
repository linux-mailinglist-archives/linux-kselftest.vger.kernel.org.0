Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 558A74712CB
	for <lists+linux-kselftest@lfdr.de>; Sat, 11 Dec 2021 09:15:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229565AbhLKIPp (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 11 Dec 2021 03:15:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbhLKIPo (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 11 Dec 2021 03:15:44 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86474C061714;
        Sat, 11 Dec 2021 00:15:44 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 95EE3B81757;
        Sat, 11 Dec 2021 08:15:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3B0CC004DD;
        Sat, 11 Dec 2021 08:15:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639210541;
        bh=SNOLmotcVjEjYCsQ4JZybyVnOazI6yeZVcF5FaIuzaM=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=Z3PeOj0S0zk5PSICMaNtQ1KgTF7Veo/vIXtw+JiWREWwlAmr2D0UP4z0tBiRY2ewP
         F0kGXrKWCBaivpa4yqOMySH3fzd/CJwOvp9j9ZJ+whgbaMuZkBpqBxG/grDFePTgcn
         QmdvLL55ioZH2oeE8vRMonhjqm+MBUX31OT4iv9JQT5DogiUDf3OQAtz1bOq6oKIim
         lfT/1zeb9Qc8Hma2X/nZjoZjxJoH2jXhtLhvBqXTOl2XbSkrunmu3qSRdQBN5eFzWc
         IRb03l3QBds0tfsZueKWZqXMqtFN6KVQO8Hx6s3yXHgJ4SJj6Dv5hoav0Woxqjy5/W
         6excpRqvVP20g==
Message-ID: <003f62b2fbd37877f7dde9f6cdc693f8c35bf477.camel@kernel.org>
Subject: Re: [PATCH] selftests/sgx: Fix build error caused by missing
 dependency
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Reinette Chatre <reinette.chatre@intel.com>,
        dave.hansen@linux.intel.com, linux-sgx@vger.kernel.org,
        shuah@kernel.org
Cc:     linux-kselftest@vger.kernel.org
Date:   Sat, 11 Dec 2021 10:15:37 +0200
In-Reply-To: <797ff1331cfe540fc378fcc4a4a7b00ff5099fbe.1638905135.git.reinette.chatre@intel.com>
References: <797ff1331cfe540fc378fcc4a4a7b00ff5099fbe.1638905135.git.reinette.chatre@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.42.2 
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, 2021-12-07 at 11:40 -0800, Reinette Chatre wrote:
> Commit f0ff2447b861 ("selftests/sgx: Add a new kselftest:
> Unclobbered_vdso_oversubscribed") depends on __cpuid() without
> providing the dependency and thus introduces a build error:
>=20
> $ make
> gcc -Wall -Werror -g -I../../../../tools/include -fPIC -z noexecstack -c =
main.c -o /path/linux/tools/testing/selftests/sgx/main.o
> main.c: In function =E2=80=98get_total_epc_mem=E2=80=99:
> main.c:296:3: error: implicit declaration of function =E2=80=98__cpuid=E2=
=80=99 [-Werror=3Dimplicit-function-declaration]
>   296 |   __cpuid(&eax, &ebx, &ecx, &edx);
>       |   ^~~~~~~
> cc1: all warnings being treated as errors
> make: *** [Makefile:33: /path/linux/tools/testing/selftests/sgx/main.o] E=
rror 1
> $
>=20
> Make the kernel's __cpuid() available locally in support of the
> test's usage.

It's too abstract, rather

"Clone kernel's __cpuid() implementation to the self-test in order
 to make it available for the EPC enumeration code."

> Fixes: f0ff2447b861 ("selftests/sgx: Add a new kselftest: Unclobbered_vds=
o_oversubscribed")
> Reported-by: Jarkko Sakkinen <jarkko@kernel.org>
> Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>

The code change is acceptable.

/Jarkko
