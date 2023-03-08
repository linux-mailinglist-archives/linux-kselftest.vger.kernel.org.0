Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72A1D6B057C
	for <lists+linux-kselftest@lfdr.de>; Wed,  8 Mar 2023 12:10:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229717AbjCHLKW (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 8 Mar 2023 06:10:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231360AbjCHLKR (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 8 Mar 2023 06:10:17 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 25A309E066
        for <linux-kselftest@vger.kernel.org>; Wed,  8 Mar 2023 03:10:16 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 36EBE106F;
        Wed,  8 Mar 2023 03:10:59 -0800 (PST)
Received: from e125769.cambridge.arm.com (e125769.cambridge.arm.com [10.1.196.26])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BE95B3F71A;
        Wed,  8 Mar 2023 03:10:14 -0800 (PST)
From:   Ryan Roberts <ryan.roberts@arm.com>
To:     Oliver Upton <oliver.upton@linux.dev>
Cc:     Ryan Roberts <ryan.roberts@arm.com>, Marc Zyngier <maz@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
        kvmarm@lists.linux.dev
Subject: [PATCH v2 0/3] KVM: selftests: Fixes for broken tests
Date:   Wed,  8 Mar 2023 11:09:45 +0000
Message-Id: <20230308110948.1820163-1-ryan.roberts@arm.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Oliver,

Here is a respin of the KVM selftests fixes, with your nits addressed; I've
fixed the footer whitespace issue and I'm now using FIELD_GET() in the place
where you suggested and a couple of other places too. I've also included the 3rd
patch in this series (the ttbr0_el1 fix), which I originally sent separately -
this is now using FIELD_GET() too.

So this series superceeds [1] and [2].

Thanks,
Ryan

[1] https://lore.kernel.org/kvmarm/e8ed178a-0c67-3e00-a085-1d88fb3cb41f@arm.com/
[2] https://lore.kernel.org/kvmarm/20230302152033.242073-1-ryan.roberts@arm.com/

Ryan Roberts (3):
  KVM: selftests: Fixup config fragment for access_tracking_perf_test
  KVM: selftests: arm64: Fix pte encode/decode for PA bits > 48
  KVM: selftests: arm64: Fix ttbr0_el1 encoding for PA bits > 48

 tools/testing/selftests/kvm/config            |  1 +
 .../selftests/kvm/lib/aarch64/processor.c     | 39 ++++++++++++++-----
 2 files changed, 30 insertions(+), 10 deletions(-)

--
2.25.1

