Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B837341C6BA
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Sep 2021 16:31:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344493AbhI2OdA (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 29 Sep 2021 10:33:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:59736 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1344491AbhI2OdA (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 29 Sep 2021 10:33:00 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id DCF20610CC;
        Wed, 29 Sep 2021 14:31:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632925879;
        bh=TPQtX6XHYQ53fqndnwbaqt5bCqHmnEL9FXx/KOdAC3I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UlxwqVKeYq4z1IS0nmgc1xQ5zsYaYh7gMb3V2FkwKOC8RVoCDtJ9G/EMir1muOHZG
         cYWzOcnsQE68svhZK4KeehZ5KLV4yCoPDJDGgZumRqZezObnJuN8+AijRP8E7ecSWo
         nyrWd1O2BSuhuQIj/eZjvYCKcl3ZL/IOoy9UpTU4VKXgJRbaYS/hzhW3OAieWrm9WU
         j+R8L+LYbq1OaKJh/v3MVtX67ESnGHyKqBGFEuAcxGL7UUkGdCuVwbBZSSDcjPhdrL
         8rwVCIyDnA5L3L7WdowAzq7w8aFsiGKOCt+JothggyOR5PUiOpNLPBoKazakOvcK7w
         T5PdY88Lvm1ng==
Date:   Wed, 29 Sep 2021 15:31:14 +0100
From:   Will Deacon <will@kernel.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Shuah Khan <shuah@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org, misono.tomohiro@fujitsu.com
Subject: Re: [PATCH v2 0/4] selftests: arm64: vec-syscfg updates
Message-ID: <20210929143113.GA22029@willie-the-truck>
References: <20210917120855.13858-1-broonie@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210917120855.13858-1-broonie@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Sep 17, 2021 at 01:08:51PM +0100, Mark Brown wrote:
> This series fixes up a few issues introduced into vec-syscfg during
> refactoring in the review process, then adds a new test which ensures
> that the behaviour when we attempt to set a vector length which is not
> supported by the current system matches what is documented in the SVE
> ABI documentation.
> 
> v2:
>  - Fix handling of missing VLs when checking that vector length setting
>    works as expected.

With this series applied, I see a test failing under qemu with:

# selftests: arm64: vec-syscfg
# TAP version 13
# 1..10
# ok 1 SVE default vector length 64
# ok 2 # SKIP Need to be root to write to /proc
# ok 3 # SKIP Need to be root to write to /proc
# ok 4 SVE current VL is 64
# ok 5 SVE set VL 64 and have VL 64
# ok 6 # SKIP SVE only one VL supported
# ok 7 # SKIP SVE only one VL supported
# ok 8 # SKIP SVE only one VL supported
# ok 9 # SKIP SVE only one VL supported
# # SVE VL 272 returned 256 not maximum 0
# # SVE VL 288 returned 256 not maximum 0
# # SVE VL 304 returned 256 not maximum 0
# # SVE VL 320 returned 256 not maximum 0
# # SVE VL 336 returned 256 not maximum 0
# # SVE VL 352 returned 256 not maximum 0

[repeat similar messages for ages]

  # SVE VL 8160 returned 256 not maximum 0
# # SVE VL 8176 returned 256 not maximum 0
# # SVE VL 8192 returned 256 not maximum 0
# not ok 10 SVE prctl() set all VLs, 496 errors
# # Totals: pass:3 fail:1 xfail:0 xpass:0 skip:6 error:0

Will
