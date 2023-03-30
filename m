Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DF6C6D0DDA
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 Mar 2023 20:37:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231194AbjC3She (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 30 Mar 2023 14:37:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231280AbjC3She (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 30 Mar 2023 14:37:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F0654681
        for <linux-kselftest@vger.kernel.org>; Thu, 30 Mar 2023 11:37:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3A94E6216B
        for <linux-kselftest@vger.kernel.org>; Thu, 30 Mar 2023 18:37:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9880AC433EF;
        Thu, 30 Mar 2023 18:37:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680201452;
        bh=KgOv3E/krfjtQY57qqjjtIIwp1aANMzPi+769qf8brY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ryzESI5xatZjiSzT2r8zRFQk66CLGSB5Y6PS4iHYCyvK5ncbdqaUvW9vn8sAiCFi1
         8xyHUpe5j4YBHHBqgWIV0dVkIh1aRVE2+yInLNOJ9Cc7ivuw3gzynI7mw9tkn2kdx1
         PmtQkWQXml3oIVYncpbrNyCtDt+K/E7FeR+4+QmaDbiHlTbdoCh5KufGrQViko0g5n
         MSYz1F9Ep+3apFRTJJgbH+xvCOCaw3CJN2Xb3gjbQwpI3ETBUqIigrjZ7vzZ0EtD4I
         R9XPPECjF1QM7J6HWAaBtPLaQTdidus4WJWlOIXIhAQdaEUPYxYfPdTgWSDLa5Ryon
         mBBfdLLJsBd0A==
Received: from sofa.misterjones.org ([185.219.108.64] helo=valley-girl.lan)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.95)
        (envelope-from <maz@kernel.org>)
        id 1phx9O-004T1T-SP;
        Thu, 30 Mar 2023 19:37:30 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     Ryan Roberts <ryan.roberts@arm.com>,
        Oliver Upton <oliver.upton@linux.dev>
Cc:     Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>, kvmarm@lists.linux.dev
Subject: Re: [PATCH v2 0/3] KVM: selftests: Fixes for broken tests
Date:   Thu, 30 Mar 2023 19:37:28 +0100
Message-Id: <168020143222.2928926.5454772168751993745.b4-ty@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230308110948.1820163-1-ryan.roberts@arm.com>
References: <20230308110948.1820163-1-ryan.roberts@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: ryan.roberts@arm.com, oliver.upton@linux.dev, shuah@kernel.org, linux-kselftest@vger.kernel.org, pbonzini@redhat.com, kvmarm@lists.linux.dev
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, 8 Mar 2023 11:09:45 +0000, Ryan Roberts wrote:
> Here is a respin of the KVM selftests fixes, with your nits addressed; I've
> fixed the footer whitespace issue and I'm now using FIELD_GET() in the place
> where you suggested and a couple of other places too. I've also included the 3rd
> patch in this series (the ttbr0_el1 fix), which I originally sent separately -
> this is now using FIELD_GET() too.
> 
> So this series superceeds [1] and [2].
> 
> [...]

Applied to next, thanks!

[1/3] KVM: selftests: Fixup config fragment for access_tracking_perf_test
      commit: a2bed39057b434c4fd816005d1b950fefc61569d
[2/3] KVM: selftests: arm64: Fix pte encode/decode for PA bits > 48
      commit: e659babfc5a693553cf9473470840464f0ed5d77
[3/3] KVM: selftests: arm64: Fix ttbr0_el1 encoding for PA bits > 48
      commit: e17071754cf50e5f6ff8ebee077e0e4114d3bea5

Cheers,

	M.
-- 
Without deviation from the norm, progress is not possible.


