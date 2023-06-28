Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E68FE7415D9
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 Jun 2023 17:57:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231231AbjF1P4l (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 28 Jun 2023 11:56:41 -0400
Received: from dfw.source.kernel.org ([139.178.84.217]:36384 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230147AbjF1P4k (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 28 Jun 2023 11:56:40 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E8FD96129B
        for <linux-kselftest@vger.kernel.org>; Wed, 28 Jun 2023 15:56:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 492A7C433C8;
        Wed, 28 Jun 2023 15:56:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687967799;
        bh=G//ijS5G5PZHTk01cf4pUdRuLZqF8Qw9qSwmJRa3N0I=;
        h=Date:From:To:Cc:Subject:From;
        b=ONqcLawx86QMgSRremu7C4N5VPBWKb+JVqd8SDMcqB+5I2dX3u5F5dF8OMXb3GGFY
         ad73V24/5CSg+38eXicci5A//5sVorqsY35G55jAcROQ8+LaQE9uek7pORl+l8Lwp2
         QF5wBbszaIfX1EHsI0Kb+6Q5tV4oElB/XTPmTl8dn9nEzVkgeUJMAHPk4/5cqWNUId
         VCXLEBGaXXUexKXGuJ0S8pKFHJP84z+nVvoEZOuXRRzwNWt7MtBpBGwRmtpoDVPJ0i
         lnP4eRxM1VkWWS7EGsiivH+HUePKfI4g0ilnVVjl7Nq3lRGCjLdXmA/4fYvGKR53BA
         RyTI3/NJ43alA==
Date:   Wed, 28 Jun 2023 16:56:35 +0100
From:   Will Deacon <will@kernel.org>
To:     broonie@kernel.org
Cc:     catalin.marinas@arm.com, shuah@kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org
Subject: SSVE selftests failing unexpectedly
Message-ID: <20230628155633.GA22275@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Mark,

While debugging the SME issue reported in CI, I noticed that the
streaming SVE tests are failing on the fastmodel because of an
unexpected SIGILL. For example:

will:arm64/signal$ ./ssve_za_regs
# Streaming SVE registers :: Check that we get the right Streaming SVE registers reported
Registered handlers for all signals.
Detected MINSTKSIGSZ:4720
Required Features: [ SME ] supported
Incompatible Features: [] absent
Testcase initialized.
Testing VL 64
-- RX UNEXPECTED SIGNAL: 4
==>> completed. FAIL(0)

The signal is injected because we get an SME trap due to an fpsimd, sve
or sve2 instruction being used in streaming mode (ESR is 0x76000001).

I did a bit of digging and it looks like this is my libc using a vector
DUP instruction in memset:

#0  __memset_generic () at ../sysdeps/aarch64/memset.S:37
#1  0x0000aaaaaaaa1170 in get_current_context (dest_sz=131072,
    dest_uc=0xaaaaaeab6ba0 <context>, td=0xaaaaaaab50f0 <tde>)
    at ./test_signals_utils.h:69
#2  do_one_sme_vl (si=<optimized out>, uc=<optimized out>, vl=64,
    td=0xaaaaaaab50f0 <tde>) at testcases/ssve_za_regs.c:90
#3  sme_regs (td=0xaaaaaaab50f0 <tde>, si=<optimized out>, uc=<optimized out>)
    at testcases/ssve_za_regs.c:145
#4  0x0000aaaaaaaa0ed0 in main (argc=<optimized out>, argv=<optimized out>)
    at test_signals.c:21

Dump of assembler code for function __memset_generic:
=> 0x0000fffff7edfb00 <+0>:	dup	v0.16b, w1

The easy option would be to require FA64 for these tests, but I guess it
would be better to exit streaming mode.

Please can you have a look?

Thanks,

Will
