Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E9346C8784
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Mar 2023 22:33:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229441AbjCXVdP (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 24 Mar 2023 17:33:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230131AbjCXVdO (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 24 Mar 2023 17:33:14 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF33B1A64B
        for <linux-kselftest@vger.kernel.org>; Fri, 24 Mar 2023 14:33:08 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id j15-20020a17090a318f00b0023fe33f8825so947737pjb.9
        for <linux-kselftest@vger.kernel.org>; Fri, 24 Mar 2023 14:33:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1679693588;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=IwqIwv/tqLiASfdNBOtwEIEJYiaaWmQZ93Bhvs67JGQ=;
        b=OIPfQ5hZVDJHUQ1cSW77jctoIXVTpbXLH1is/tZE2O1XfProT+a3dvD8u1FzOEf5ZV
         JFU9CPp78hu4VYiSgoy029WjYqW36ZtPrMWPxAsT7DixBtPhRdWw4vEZjL9sEEzPdjYb
         Bu0ZOw44UuqO9JBpIlpZxPKvSvJAodiHrgTWqhM3fPwckbpT1XIwSjR93eegagK2oQqm
         4ZY1zTnoOATBSmFspDxOhLhOzGTMKg2nzVMkEhGcTZ9E6BSU+SsG7WzyQbkk9TT8G0Df
         sQCm3IeUWa6dZXbmf9R5WEBCbhw7wQaOKReZnC0x1Q/TSW3eGv6+xLk1+NAQ8hTPSH4c
         1hJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679693588;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IwqIwv/tqLiASfdNBOtwEIEJYiaaWmQZ93Bhvs67JGQ=;
        b=pSpklaP+i0mDKJtyQW2AMK2VjLLUFrX7QwP6Ij8erRF1GiXG23RHe58cEnAtt9+7XY
         SE6grDbB4GHYmopX0QYtWM7z4DvvWaxAXOiHKvXSqT0w9B5Ht+ZpmqEowLde3fEbKHYU
         4H38TZ1eId/OxUTQr9kI5Bva3/n1R0beOBjQvxzeuzYNsQ41hEO0mElhZDU9GAfv2wBt
         pc0TGCUKtwiv6OeDfP06+KAbH5llLnzyPxfJjga5jKVJukXVLK71GerDnZ93lIzHP6nT
         hggrwEAilnkI160kSRTnJ0s1k4mb+FDkmy7/l5GY+4TuMi29PhOK428lkpMFFhUMe4dj
         PP5A==
X-Gm-Message-State: AAQBX9fUnPMAw3GlFpYLSoYqR4QdkNZgQxBOaBtz7t4+ENTQujhHCuoX
        wFFp1N0vzvZFr7DHutGNYx4w4kGRCqk=
X-Google-Smtp-Source: AKy350aQM1Ru4OKWaay1ah7w1ErMxIg9e8pk6GVoOvCFEK9Q8i70sf+Y+u16TQBCc2MBGtY74ApaJs2UeT0=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6a00:2385:b0:5aa:310c:e65b with SMTP id
 f5-20020a056a00238500b005aa310ce65bmr2334505pfc.2.1679693588421; Fri, 24 Mar
 2023 14:33:08 -0700 (PDT)
Date:   Fri, 24 Mar 2023 14:32:48 -0700
In-Reply-To: <20230322144528.704077-1-ivan.orlov0322@gmail.com>
Mime-Version: 1.0
References: <20230322144528.704077-1-ivan.orlov0322@gmail.com>
X-Mailer: git-send-email 2.40.0.348.gf938b09366-goog
Message-ID: <167969290615.2764662.14384745948331970319.b4-ty@google.com>
Subject: Re: [PATCH] selftests: kvm: Add 'malloc' failure check in vcpu_save_state
From:   Sean Christopherson <seanjc@google.com>
To:     Sean Christopherson <seanjc@google.com>, pbonzini@redhat.com,
        shuah@kernel.org, dmatlack@google.com, vannapurve@google.com,
        Ivan Orlov <ivan.orlov0322@gmail.com>
Cc:     kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, himadrispandya@gmail.com,
        linux-kernel-mentees@lists.linuxfoundation.org
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-7.7 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, 22 Mar 2023 18:45:28 +0400, Ivan Orlov wrote:
> There is a 'malloc' call in vcpu_save_state function, which can
> be unsuccessful. This patch will add the malloc failure checking
> to avoid possible null dereference and give more information
> about test fail reasons.
> 
> 

Applied to kvm-x86 selftests, thanks!

[1/1] selftests: kvm: Add 'malloc' failure check in vcpu_save_state
      https://github.com/kvm-x86/linux/commit/735b0e0f2d00

--
https://github.com/kvm-x86/linux/tree/next
https://github.com/kvm-x86/linux/tree/fixes
