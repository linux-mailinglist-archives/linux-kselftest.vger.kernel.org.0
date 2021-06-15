Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A108B3A7EDB
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Jun 2021 15:14:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230225AbhFONQH (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 15 Jun 2021 09:16:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:51284 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230120AbhFONQG (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 15 Jun 2021 09:16:06 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id F150A6109D;
        Tue, 15 Jun 2021 13:14:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623762842;
        bh=N25V56ZNFxMcTgXxICE35+kBB2VSHlw2jmt7OjHwc6k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KbV8j2HcS4zNvTLQHaYKQNi4f6OmU5HjkPocRoHwm7Y87mSizgoJ+e2CcWKqhAe8q
         QrSiznHrSV4d3m0AHJLfMXKYx4iwotB2dGDJgSwtG0gvgi4RrF5F7Qoi87CMxzcggN
         zIB9Ijnx29/Ajwet9Em8dfS7xYQSD+7WBVb++oEZopEregQdX0mqx+zb99toqk5JMR
         jz7d8LmQI/LEPn04xX+6yKP26qRKphKdMfyMM7yPTWwskdiHgbfNLg6oEPkf99sFWs
         FH//FF0qucptTJSmDlzFEciqAcYPe8KuOwC+bLKeXI/wYvCscvhdVdpAB51dAeuviT
         L4ewkJDbCgv1A==
Date:   Tue, 15 Jun 2021 16:13:59 +0300
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     shuah@kernel.org, linux-kselftest@vger.kernel.org,
        linux-sgx@vger.kernel.org,
        Reinette Chatre <reinette.chatre@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 5/5] selftests/sgx: Refine the test enclave to have
 storage
Message-ID: <20210615131359.zrfvi36sjdpxghzl@kernel.org>
References: <20210610083021.392269-1-jarkko@kernel.org>
 <20210610083021.392269-5-jarkko@kernel.org>
 <b1bf69f5-e203-d69e-d15d-3fb5e98b63dd@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b1bf69f5-e203-d69e-d15d-3fb5e98b63dd@linuxfoundation.org>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Jun 14, 2021 at 02:16:15PM -0600, Shuah Khan wrote:
> On 6/10/21 2:30 AM, Jarkko Sakkinen wrote:
> > Extend the enclave to have two operations: ENCL_OP_PUT and ENCL_OP_GET.
> > ENCL_OP_PUT stores value inside the enclave address space and
> > ENCL_OP_GET reads it. The internal buffer can be later extended to be
> > variable size, and allow reclaimer tests.
> > 
> > Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
> > ---
> >   tools/testing/selftests/sgx/defines.h     | 10 ++++
> >   tools/testing/selftests/sgx/main.c        | 57 ++++++++++++++++++-----
> >   tools/testing/selftests/sgx/test_encl.c   | 19 +++++++-
> >   tools/testing/selftests/sgx/test_encl.lds |  3 +-
> >   4 files changed, 74 insertions(+), 15 deletions(-)
> > 
> 
> Test output before applying the series:
> 
> TAP version 13
> 1..1
> # selftests: sgx: test_sgx
> # Unable to open /dev/sgx_enclave: No such file or directory
> # 1..0 # SKIP cannot load enclaves
> ok 1 selftests: sgx: test_sgx # SKIP
> 
> Test output after applying second patch
> 
> selftests/sgx: Migrate to kselftest harness
> 
> Output changes to the following. It doesn't look like the second
> patch adds any new tests. What is the point in running the tests
> that fail if /dev/sgx_enclave is missing.
> 
> Unfortunately this series doesn't have a cover letter that explains
> what this series is doing. I don't like the fact that the test
> output and behavior changes when migrating the test to kselftest
> harness. Shouldn't the output stay the same as in skip the tests
> if /dev/sgx_enclave fails.

I get what you are saying but actually I do not know how with
fixtures I can skip "the rest" when FIXTURE_SETUP() fails.

The reason for the output below is that with fixtures for all
tests enclave is initialized for each test case. And it kind of
makes sense because all tests start from the clean expected
state.

I don't how to do that with zero change in the output.

The reason to do this change is to make it easy to add more tests,
and return correct status codes to the framework.

> TAP version 13
> 1..1
> # selftests: sgx: test_sgx
> # TAP version 13
> # 1..3
> # # Starting 3 tests from 2 test cases.
> # #  RUN           enclave.unclobbered_vdso ...
> # Unable to open /dev/sgx_enclave: No such file or directory
> # ok 2 # SKIP cannot load enclaves
> # # Planned tests != run tests (3 != 1)
> # # Totals: pass:0 fail:0 xfail:0 xpass:0 skip:1 error:0
> # # unclobbered_vdso: Test failed at step #4
> # #          FAIL  enclave.unclobbered_vdso
> # not ok 1 enclave.unclobbered_vdso
> # #  RUN           enclave.clobbered_vdso ...
> # Unable to open /dev/sgx_enclave: No such file or directory
> # ok 3 # SKIP cannot load enclaves
> # # Planned tests != run tests (3 != 2)
> # # Totals: pass:0 fail:1 xfail:0 xpass:0 skip:1 error:0
> # # clobbered_vdso: Test failed at step #4
> # #          FAIL  enclave.clobbered_vdso
> # not ok 2 enclave.clobbered_vdso
> # #  RUN           enclave.clobbered_vdso_and_user_function ...
> # Unable to open /dev/sgx_enclave: No such file or directory
> # ok 4 # SKIP cannot load enclaves
> # # Totals: pass:0 fail:2 xfail:0 xpass:0 skip:1 error:0
> # # clobbered_vdso_and_user_function: Test failed at step #4
> # #          FAIL  enclave.clobbered_vdso_and_user_function
> # not ok 3 enclave.clobbered_vdso_and_user_function
> # # FAILED: 0 / 3 tests passed.
> # # Totals: pass:0 fail:3 xfail:0 xpass:0 skip:0 error:0
> not ok 1 selftests: sgx: test_sgx # exit=1
> 
> thanks,
> -- Shuah

/Jarkko
