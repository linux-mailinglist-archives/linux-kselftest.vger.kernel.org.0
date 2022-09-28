Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5891D5EE0E8
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 Sep 2022 17:53:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234016AbiI1Px4 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 28 Sep 2022 11:53:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbiI1Pxz (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 28 Sep 2022 11:53:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 837B9D4318;
        Wed, 28 Sep 2022 08:53:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1E67061F0E;
        Wed, 28 Sep 2022 15:53:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FBAFC433C1;
        Wed, 28 Sep 2022 15:53:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664380432;
        bh=nBPunl5TlQZD8jgaoQw53yxRscbk/pyS0FZr8ut3NwU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BkP2ThbW79wrrZlsNPqDWK6C5y0ON+cYFY7t1veHGr+vAuwHnB2g5G2fM0ur9yVma
         TNyzihtbiLsBAdUAPDNvmf5Qe7IVktW+eqecxOIkhGnjrlMu1632Hu5qB4UQBP/xVk
         h91daEoeyxbLJKDBU6BcYTqPUtYRnJSJ9yKawAFi6F7d31AkRyInHo2nWtaonYhfHo
         Cq2i9WqXVDeuZwG19toxnPU7xbZxFE3voxOcDOOSMeMBbGmjEMLNcOqpYndfT6TXrQ
         9O9q85rkhlv/W9ry9/maKNZDzGtcIGylq2cCYTwErBs766kPdBUJxAAv1b45K6pJtI
         CH6BY1C7LqMeQ==
Received: from sofa.misterjones.org ([185.219.108.64] helo=valley-girl.lan)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.95)
        (envelope-from <maz@kernel.org>)
        id 1odZNe-00DK8u-4K;
        Wed, 28 Sep 2022 16:53:50 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     Oliver Upton <oliver.upton@linux.dev>,
        James Morse <james.morse@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Shuah Khan <shuah@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kvmarm@lists.cs.columbia.edu, kvm@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [RESEND PATCH] KVM: selftests: Update top-of-file comment in psci_test
Date:   Wed, 28 Sep 2022 16:53:46 +0100
Message-Id: <166438042059.3795682.3522181061739798083.b4-ty@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220819162100.213854-1-oliver.upton@linux.dev>
References: <20220819162100.213854-1-oliver.upton@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: oliver.upton@linux.dev, james.morse@arm.com, suzuki.poulose@arm.com, pbonzini@redhat.com, alexandru.elisei@arm.com, shuah@kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu, kvm@vger.kernel.org, linux-kselftest@vger.kernel.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, 19 Aug 2022 16:21:00 +0000, Oliver Upton wrote:
> Fix the comment to accurately describe the test and recently added
> SYSTEM_SUSPEND test case.
> 
> What was once psci_cpu_on_test was renamed and extended to squeeze in a
> test case for PSCI SYSTEM_SUSPEND. Nonetheless, the author of those
> changes (whoever they may be...) failed to update the file comment to
> reflect what had changed.

Applied to next, thanks!

[1/1] KVM: selftests: Update top-of-file comment in psci_test
      commit: 448e711693e48d03f7933ab3673334701b0c3f41

Cheers,

	M.
-- 
Without deviation from the norm, progress is not possible.


