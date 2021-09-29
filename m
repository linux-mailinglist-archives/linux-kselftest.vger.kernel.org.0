Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 898D141C889
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Sep 2021 17:35:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345262AbhI2Pg6 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 29 Sep 2021 11:36:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:42494 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1345157AbhI2Pg5 (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 29 Sep 2021 11:36:57 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 869F261406;
        Wed, 29 Sep 2021 15:35:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632929716;
        bh=Xj7c2Rh3uVbR0E/CHH2wBPB/kjfla4ZadgAwWwnGY4M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IZD2R1UxB4Il9pgByIemYLcmFaKARTo0YIIUZKBIRoxIfNZLdfsBvLNWyb57NpwPY
         /oeCPc8zoPUoj0RdwtpgFVsXWUj+9W+Ylms0oWoaqRzncBk7SNcT0FyQpRhRWHQdn4
         NwXZyoyYu/KNc4GLSJr4Kumf4PYScvLGWteMZFpXA9SvlGMYqkdcGQWR/4FGnC4rdX
         9O4kKqqED1PlD60fHu8FknvoXEZsO/WfLLgFEOuAir+lc4aftljzwdTO+b3UbSUYdk
         cvMPwEBLLbIai514zOhISXO9PigEv3B0zEyVCt/yHsvi+Xe5fBlsw/db/lUPY4EUhC
         zHix41M5KSf9A==
Date:   Wed, 29 Sep 2021 16:35:12 +0100
From:   Will Deacon <will@kernel.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Shuah Khan <shuah@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org, misono.tomohiro@fujitsu.com
Subject: Re: [PATCH v2 0/4] selftests: arm64: vec-syscfg updates
Message-ID: <20210929153511.GB22029@willie-the-truck>
References: <20210917120855.13858-1-broonie@kernel.org>
 <20210929143113.GA22029@willie-the-truck>
 <20210929144323.GQ4199@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210929144323.GQ4199@sirena.org.uk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Sep 29, 2021 at 03:43:23PM +0100, Mark Brown wrote:
> On Wed, Sep 29, 2021 at 03:31:14PM +0100, Will Deacon wrote:
> 
> > With this series applied, I see a test failing under qemu with:
> 
> > # selftests: arm64: vec-syscfg
> > # TAP version 13
> > # 1..10
> > # ok 1 SVE default vector length 64
> > # ok 2 # SKIP Need to be root to write to /proc
> > # ok 3 # SKIP Need to be root to write to /proc
> 
> AFAICT this is due to running as a non-root user, the testsuite was
> already having serious issues before then...
> 
> > # ok 4 SVE current VL is 64
> > # ok 5 SVE set VL 64 and have VL 64
> > # ok 6 # SKIP SVE only one VL supported
> > # ok 7 # SKIP SVE only one VL supported
> > # ok 8 # SKIP SVE only one VL supported
> > # ok 9 # SKIP SVE only one VL supported
> > # # SVE VL 272 returned 256 not maximum 0
> 
> ...as it's starting off by testing an interface that's only writable by
> root and then relying on that information, the existing tests were also
> not working usefully.  qemu by default supports way more than one vector
> length.  In any case it's just the test added by the last patch that's
> causing the output here, the first four patches should be fine and fix
> issues.
> 
> I'm not sure it's a particularly good idea to run kselftest as a
> non-root user TBH, it's going to cause you to skip a lot of tests.

Ah, thanks for pointing that out. It would probably be better to skip the
tests rather than fail them if they're not running with sufficient
permissions, but I'll go ahead and queue your v3 for now.

Will
