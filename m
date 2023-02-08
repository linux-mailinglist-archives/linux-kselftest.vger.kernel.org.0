Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67E6F68F48E
	for <lists+linux-kselftest@lfdr.de>; Wed,  8 Feb 2023 18:30:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231336AbjBHRao (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 8 Feb 2023 12:30:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230376AbjBHRan (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 8 Feb 2023 12:30:43 -0500
Received: from out-34.mta1.migadu.com (out-34.mta1.migadu.com [95.215.58.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FA2E7D91
        for <linux-kselftest@vger.kernel.org>; Wed,  8 Feb 2023 09:30:39 -0800 (PST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1675877434;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=X+yte8eb31ZZav0dAk5ErL0EElBKHz03ThUS5kMkHwc=;
        b=Ljkux1gUkccdk+TEnrfsZeMk1NB9IgZ/RZIJb7U1uJdzQjCed1roZD5vL3ILzexqSoMfP2
        hMQfRiJCxf4S7VNxXcmRSoNTGQRGvc/8iuHJy6yDjuNjn2O98xL5vXsed27hNrP19eH4JJ
        2S3vG4lew7E06cmmscM3RuevAGqS4zk=
From:   Oliver Upton <oliver.upton@linux.dev>
To:     Mark Brown <broonie@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Shuah Khan <shuah@kernel.org>
Cc:     Oliver Upton <oliver.upton@linux.dev>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH] KVM: selftests: Enable USERFAULTFD
Date:   Wed,  8 Feb 2023 17:30:19 +0000
Message-Id: <167587739431.1104197.3869091380114541350.b4-ty@linux.dev>
In-Reply-To: <20230202-kvm-selftest-userfaultfd-v1-1-8186ac5a33a5@kernel.org>
References: <20230202-kvm-selftest-userfaultfd-v1-1-8186ac5a33a5@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, 02 Feb 2023 21:01:36 +0000, Mark Brown wrote:
> The page_fault_test KVM selftest requires userfaultfd but the config
> fragment for the KVM selftests does not enable it, meaning that those tests
> are skipped in CI systems that rely on appropriate settings in the config
> fragments except on S/390 which happens to have it in defconfig. Enable
> the option in the config fragment so that the tests get run.
> 
> 
> [...]

Applied to kvmarm/next, thanks!

[1/1] KVM: selftests: Enable USERFAULTFD
      https://git.kernel.org/kvmarm/kvmarm/c/d23650547819

--
Best,
Oliver
