Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 328BC40E0BE
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Sep 2021 18:27:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240718AbhIPQXt (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 16 Sep 2021 12:23:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:59316 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241602AbhIPQVu (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 16 Sep 2021 12:21:50 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 390CA6142A;
        Thu, 16 Sep 2021 16:15:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631808909;
        bh=hdXYr5+Jn6SgmJ/m5Ma7DClQAoZf6w3aXYAdXsVTmzc=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=MDucwDB+7b1cPokcWpY4ZmNnFn0nTILjk8M0+EsNxxFULxMvCRbAYlM/f1S5+wMm6
         eOEYL8W+fqjs2Z8yxIGFbproVUVQ9lC+aLpFNaNFNvYhqtzdIniE9aoKSk6N8Y5UDk
         /DFBnohxBDmCil5mx0ylzvcj33YZI5ROUr1k1E3pwZPVBfJ+Y6jCPvMnb3/fEodRwj
         9dAaYosimyPfQarV+6H53m7KDuAftiI09lyuQFL67p2atT7znGL5klWB1sSISIbMhn
         V6E6nEojnIzHdRu1GyKCqsD9M8ZHirvFc+2pb/9x/sFYAqmFND8tpJ0Q2k644kq5A/
         v1jgqqg2RVXtw==
Message-ID: <a5e299138611104928efc7ad1b26c36131ba445f.camel@kernel.org>
Subject: Re: [PATCH 00/14] selftests/sgx: Oversubscription, page permission,
 thread entry
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Reinette Chatre <reinette.chatre@intel.com>,
        linux-sgx@vger.kernel.org, shuah@kernel.org
Cc:     seanjc@google.com, bp@alien8.de, dave.hansen@linux.intel.com,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>
Date:   Thu, 16 Sep 2021 19:15:07 +0300
In-Reply-To: <cover.1631731214.git.reinette.chatre@intel.com>
References: <cover.1631731214.git.reinette.chatre@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, 2021-09-15 at 13:30 -0700, Reinette Chatre wrote:
> Hi Everybody,
>=20
> This series consists out of outstanding SGX selftests changes, rebased
> and gathered in a single series that is more easily merged for testing
> and development, and a few more changes added to expand the existing test=
s.
>=20
> The outstanding SGX selftest changes included in this series that have al=
ready
> been submitted separately are:
>=20
> * An almost two year old patch fixing a benign linker warning that is sti=
ll
>   present today:
>   https://lore.kernel.org/linux-sgx/20191017030340.18301-2-sean.j.christo=
pherson@intel.com/
>   The original patch is added intact and not all email addresses
>   within are valid.
>=20
> * Latest (v4) of Jarkko Sakkinen's series to add an oversubscription test=
:
>   https://lore.kernel.org/linux-sgx/20210809093127.76264-1-jarkko@kernel.=
org/
>=20
> * Latest (v2) of Jarkko Sakkinen's patch that provides provide per-op
>   parameter structs for the test enclave:
>   https://lore.kernel.org/linux-sgx/20210812224645.90280-1-jarkko@kernel.=
org/
>=20
> The reason why most of these patches are outstanding is that they depend
> on a kernel change that is still under discussion. Decision to wait in:
> https://lore.kernel.org/linux-sgx/f8674dac5579a8a424de1565f7ffa2b5bf2f8e3=
6.camel@kernel.org/
> The original patch for this kernel dependency continues to be included in
> this series as a placeholder until the ongoing discussions are concluded.
>=20
> The new changes introduced in this series builds on Jarkko's outstanding
> SGX selftest changes and adds new tests for page permissions, exception
> handling, and thread entry.
>=20
> Reinette
>=20
> Jarkko Sakkinen (9):
>   x86/sgx: Add /sys/kernel/debug/x86/sgx_total_mem
>   selftests/sgx: Assign source for each segment
>   selftests/sgx: Make data measurement for an enclave segment optional
>   selftests/sgx: Create a heap for the test enclave
>   selftests/sgx: Dump segments and /proc/self/maps only on failure
>   selftests/sgx: Encpsulate the test enclave creation
>   selftests/sgx: Move setup_test_encl() to each TEST_F()
>   selftests/sgx: Add a new kselftest: unclobbered_vdso_oversubscribed
>   selftests/sgx: Provide per-op parameter structs for the test enclave
>=20
> Reinette Chatre (4):
>   selftests/sgx: Rename test properties in preparation for more enclave
>     tests
>   selftests/sgx: Add page permission and exception test
>   selftests/sgx: Enable multiple thread support
>   selftests/sgx: Add test for multiple TCS entry
> Sean Christopherson (1):
>   selftests/x86/sgx: Fix a benign linker warning
>=20
>  Documentation/x86/sgx.rst                     |   6 +
>  arch/x86/kernel/cpu/sgx/main.c                |  10 +-
>  tools/testing/selftests/sgx/Makefile          |   2 +-
>  tools/testing/selftests/sgx/defines.h         |  33 +-
>  tools/testing/selftests/sgx/load.c            |  40 +-
>  tools/testing/selftests/sgx/main.c            | 341 +++++++++++++++---
>  tools/testing/selftests/sgx/main.h            |   7 +-
>  tools/testing/selftests/sgx/sigstruct.c       |  12 +-
>  tools/testing/selftests/sgx/test_encl.c       |  60 ++-
>  .../selftests/sgx/test_encl_bootstrap.S       |  21 +-
>  10 files changed, 445 insertions(+), 87 deletions(-)
>=20

One test that would be also nice to have at some point would
be vepc test. It's not exceptionally hard to ramp up KVM:

https://lwn.net/Articles/658511/

Hmm... perhaps this type of kselftest should be part of the
series that Paolo is upstreaming because otherwise we are
dependent on non-upstream QEMU to test those changes.

Looking back, this would have been already good idea to ramp
up when the original KVM-SGX series was upstreamed because not
that many have motivation to self-compile QEMU (I did but thinking
about potential larger coverage).

/Jarkko
