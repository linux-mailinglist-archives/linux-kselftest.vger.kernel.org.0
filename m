Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33E9C6469F2
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 Dec 2022 08:52:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229763AbiLHHw5 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 8 Dec 2022 02:52:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229787AbiLHHwz (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 8 Dec 2022 02:52:55 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 283612C66C;
        Wed,  7 Dec 2022 23:52:54 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CE888B812A9;
        Thu,  8 Dec 2022 07:52:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03194C433D6;
        Thu,  8 Dec 2022 07:52:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670485971;
        bh=mzidjw17lLxadHdR3DfDkJvicQlgmwjH8rXmtGrwExA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=h8tkN2PQ0zV1OZiOzm+jHJBjlgxHwNhq7xED2TWcT06QTe1gyx/7oWjKGFesYEyvO
         D75UlrU+9EV1iYXEAASd0gkZemhz/tplLNM59i4997sfhTc0Fsm7YVTvp1vI9mJOB7
         XOU/uTcsvZ8omZ551x89buPIep8VNPwGseindYDfD94LMDCaX79Jj72sDroIwqtpk3
         uXgRI4uIjwbGTWqecJK+uCuTNkplJBFPmdvEToa5EjA5uYwQ8w89hyMWi3tTquuqYr
         W8EddTR0LeuDdxb2oPgCyO1jLkYZy1DxdBVVaU8+NrZZSD8yPRUTyY6dX4CdhbNZ5D
         luFH6D2+7n0Dg==
Date:   Thu, 8 Dec 2022 07:52:47 +0000
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     =?iso-8859-1?Q?N=EDcolas_F=2E_R=2E_A=2E?= Prado 
        <nfraprado@collabora.com>
Cc:     Shuah Khan <shuah@kernel.org>, kernel@collabora.com,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH] selftests/tpm2: Split async tests call to separate shell
 script runner
Message-ID: <Y5GXzyyc7cVhA48/@kernel.org>
References: <20221128220340.536558-1-nfraprado@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221128220340.536558-1-nfraprado@collabora.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Nov 28, 2022 at 05:03:40PM -0500, Nícolas F. R. A. Prado wrote:
> When the async test case was introduced, despite being a completely
> independent test case, the command to run it was added to the same shell
> script as the smoke test case. Since a shell script implicitly returns
> the error code from the last run command, this effectively caused the
> script to only return as error code the result from the async test case,
> hiding the smoke test result (which could then only be seen from the
> python unittest logs).
> 
> Move the async test case call to its own shell script runner to avoid
> the aforementioned issue. This also makes the output clearer to read,
> since each kselftest KTAP result now matches with one python unittest
> report.
> 
> While at it, also make it so the async test case is skipped if
> /dev/tpmrm0 doesn't exist, since commit 8335adb8f9d3 ("selftests: tpm:
> add async space test with noneexisting handle") added a test that relies
> on it.
> 
> Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>


[nix-shell:~/linux-tpmdd]$ sudo make -C tools/testing/selftests TARGETS=tpm2 run_tests
make: Entering directory '/home/nixos/linux-tpmdd/tools/testing/selftests'
make[1]: Entering directory '/home/nixos/linux-tpmdd/tools/testing/selftests/tpm2'
make[1]: Nothing to be done for 'all'.
make[1]: Leaving directory '/home/nixos/linux-tpmdd/tools/testing/selftests/tpm2'
make[1]: Entering directory '/home/nixos/linux-tpmdd/tools/testing/selftests/tpm2'
TAP version 13
1..3
# selftests: tpm2: test_smoke.sh
# test_read_partial_overwrite (tpm2_tests.SmokeTest) ... ok
# test_read_partial_resp (tpm2_tests.SmokeTest) ... ok
# test_seal_with_auth (tpm2_tests.SmokeTest) ... ok
# test_seal_with_policy (tpm2_tests.SmokeTest) ... ok
# test_seal_with_too_long_auth (tpm2_tests.SmokeTest) ... ok
# test_send_two_cmds (tpm2_tests.SmokeTest) ... ok
# test_too_short_cmd (tpm2_tests.SmokeTest) ... ok
# test_unseal_with_wrong_auth (tpm2_tests.SmokeTest) ... ok
# test_unseal_with_wrong_policy (tpm2_tests.SmokeTest) ... ok
#
# ----------------------------------------------------------------------
# Ran 9 tests in 82.385s
#
# OK
ok 1 selftests: tpm2: test_smoke.sh
# selftests: tpm2: test_space.sh
# test_flush_context (tpm2_tests.SpaceTest) ... ok
# test_get_handles (tpm2_tests.SpaceTest) ... ok
# test_invalid_cc (tpm2_tests.SpaceTest) ... ok
# test_make_two_spaces (tpm2_tests.SpaceTest) ... ok
#
# ----------------------------------------------------------------------
# Ran 4 tests in 73.287s
#
# OK
ok 2 selftests: tpm2: test_space.sh
# selftests: tpm2: test_async.sh
# test_async (tpm2_tests.AsyncTest) ... ok
# test_flush_invalid_context (tpm2_tests.AsyncTest) ... ok
#
# ----------------------------------------------------------------------
# Ran 2 tests in 0.018s
#
# OK
ok 3 selftests: tpm2: test_async.sh
make[1]: Leaving directory '/home/nixos/linux-tpmdd/tools/testing/selftests/tpm2'
make: Leaving directory '/home/nixos/linux-tpmdd/tools/testing/selftests'

[nix-shell:~/linux-tpmdd]$ lsmod|grep tpm
tpm_crb                20480  0
tpm_tis                16384  0
tpm_tis_core           32768  1 tpm_tis
tpm                    94208  3 tpm_tis,tpm_crb,tpm_tis_core
rng_core               20480  1 tpm

LGTM, thanks!

Tested-by: Jarkko Sakkinen <jarkko@kernel.org>
Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

BR, Jarkko
