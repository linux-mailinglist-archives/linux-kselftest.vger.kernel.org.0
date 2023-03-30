Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9485E6D0DD5
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 Mar 2023 20:36:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231409AbjC3Sgv (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 30 Mar 2023 14:36:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231376AbjC3Sgv (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 30 Mar 2023 14:36:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34ABFD314;
        Thu, 30 Mar 2023 11:36:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BF5EF62152;
        Thu, 30 Mar 2023 18:36:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16401C433D2;
        Thu, 30 Mar 2023 18:36:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680201409;
        bh=bDY5rMs3EMNNr0c5/9StmA62vm5rG0gFVS3lgmEhvO8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ATvrpXso0THNvABmZWz6bq2h5GqmAwXi3P9K4nAmpqXARwN+wYkFHcZP9Jw/WkK/j
         4/DzOmXYt5GSKL+iQuVuyIk4XQ6XFCvIKvTHW5KhXfsngNi6Kp96SnxzQN2saXGBdw
         nv9BCe0CVYEXXPM3iQOeKL50O0Mxuckkvwd0LJnYF70qnI7lYDQUymR/LOt89ZZOm7
         bReTTt3VPmlpZ2RvgF+BviuVVRouWl81R6AON3htM9HUNCeMkVArR6JC0PahrHREMb
         k3XMtnlpvVijIcneJjIXE8p+mnMlU3u5gtb34vAoBLyWSYbJ0QnbFOvvUUQOhFjzxi
         qX3IiD8AwGWBw==
Received: from sofa.misterjones.org ([185.219.108.64] helo=valley-girl.lan)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.95)
        (envelope-from <maz@kernel.org>)
        id 1phx8h-004Szu-1L;
        Thu, 30 Mar 2023 19:36:47 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     Shuah Khan <shuah@kernel.org>, James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Mark Brown <broonie@kernel.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Oliver Upton <oliver.upton@linux.dev>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     kvmarm@lists.cs.columbia.edu, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kvm@vger.kernel.org, kvmarm@lists.linux.dev
Subject: Re: [PATCH] KVM: selftests: Comment newly defined aarch64 ID registers
Date:   Thu, 30 Mar 2023 19:36:40 +0100
Message-Id: <168020137263.2928811.17818643951034936761.b4-ty@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230210-kvm-arm64-getreg-comments-v1-1-a16c73be5ab4@kernel.org>
References: <20230210-kvm-arm64-getreg-comments-v1-1-a16c73be5ab4@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: shuah@kernel.org, james.morse@arm.com, alexandru.elisei@arm.com, broonie@kernel.org, suzuki.poulose@arm.com, oliver.upton@linux.dev, pbonzini@redhat.com, kvmarm@lists.cs.columbia.edu, linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, kvm@vger.kernel.org, kvmarm@lists.linux.dev
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

On Mon, 06 Mar 2023 16:15:07 +0000, Mark Brown wrote:
> All otherwise unspecified aarch64 ID registers should be read as zero so
> we cover the whole ID register space in the get-reg-list test but we've
> added comments for those that have been named. Add comments for
> ID_AA64PFR2_EL1, ID_AA64SMFR0_EL1, ID_AA64ISAR2_EL1, ID_AA64MMFR3_EL1
> and ID_AA64MMFR4_EL1 which have been defined since the comments were
> added so someone looking for them will see that they are covered.

Applied to next, thanks!

[1/1] KVM: selftests: Comment newly defined aarch64 ID registers
      commit: 767cc0501bbb51f2daad35d1bc4f6eaa857ed057

Cheers,

	M.
-- 
Without deviation from the norm, progress is not possible.


