Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC9846C8723
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Mar 2023 21:59:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229921AbjCXU7C (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 24 Mar 2023 16:59:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230350AbjCXU7B (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 24 Mar 2023 16:59:01 -0400
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EE2C49E1
        for <linux-kselftest@vger.kernel.org>; Fri, 24 Mar 2023 13:59:00 -0700 (PDT)
Received: by mail-pj1-x104a.google.com with SMTP id kx3-20020a17090b228300b0023cfd09ed94so2764461pjb.4
        for <linux-kselftest@vger.kernel.org>; Fri, 24 Mar 2023 13:59:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1679691540;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=F2jYHK/36TTMGEf+vUZdYHNzyGqkJ5Ut4lpXrQmPUN4=;
        b=WD/eHEOV/becNPQA71fYe7CPx2SDa8IZ+QG3ASaKl7+Aa/2W0ww1EY/gB9ZWKyci3p
         awCYEYlpxMq7X8XrumGblllXOlMgGRob/laJDJS1gfeE2XN1sJ8+RghqgDGovCekmZfR
         EGwvQudUon9uVCIls89hXeI3n29h+73DJEIRCwiNnpIFMuaRrB4k/jKpV1h/C+lUz+as
         w/sKZKslPqC9gfaeoklMz5sQ3D5T0Wz2nOAitEZh3ogu9aZLDj4noZGKzW/P7Bj0PjSK
         WZR9gWnE+0jmkqzM0Kr2as3bgAkNr7b4GVejTY1iCBeumXPfh4SeL5B4zX+RusagJFYs
         PGrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679691540;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=F2jYHK/36TTMGEf+vUZdYHNzyGqkJ5Ut4lpXrQmPUN4=;
        b=K8cbOL+9YQhdBFuzHTQtJ6LLBEiMvv3FTKcOEu4kByeywwGqYqGhks8aZBlrGYfEci
         xFELlBqsQOIylzV0kq+5U2azbGkskeMYIhYG8gBiEbq6o+Ij7s7XCpJkra6J5gOQtgha
         fhRYZn43WR5xF8SiJRLM+6ACH/+NZl120bIWVevoNgs4mu0WAltoYyN1qRc1LnFzlssN
         2IDlEiJczuiojz9Q5P6ykc4848MWFn0D+edfPXgjU9MgbRW86Ta+0zjIl5Qe6+pU63Aj
         Ja4lKXsLY8bUIrLxg9RdTYoI1CU+XzXm5D6wUmfTQgAB6tkgNiAGzkPPQq3H3uBbWJD9
         YHlw==
X-Gm-Message-State: AAQBX9cP71dh9I7Wv/+/PLiB/Et7rZ4zXuwtoxPaP8Pn4Lwov0ZAIsx5
        o+F2DNWTyM+11yNoDzTgIjO2g928Wis=
X-Google-Smtp-Source: AKy350Y3xcbcFFUnq+w4Ndb7082cuFccfrfVnHhv4ZqLR+MOeMlh9xUkjDKUT3SIxVbp3tyi/oKZIfX6H9Q=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a63:4d52:0:b0:507:68f8:4369 with SMTP id
 n18-20020a634d52000000b0050768f84369mr1010865pgl.12.1679691539968; Fri, 24
 Mar 2023 13:58:59 -0700 (PDT)
Date:   Fri, 24 Mar 2023 13:58:46 -0700
In-Reply-To: <20230227180601.104318-1-ackerleytng@google.com>
Mime-Version: 1.0
References: <20230227180601.104318-1-ackerleytng@google.com>
X-Mailer: git-send-email 2.40.0.348.gf938b09366-goog
Message-ID: <167969137156.2756401.15618241992481271147.b4-ty@google.com>
Subject: Re: [PATCH v2 1/1] KVM: selftests: Adjust VM's initial stack address
 to align with SysV ABI spec
From:   Sean Christopherson <seanjc@google.com>
To:     Sean Christopherson <seanjc@google.com>, pbonzini@redhat.com,
        shuah@kernel.org, dmatlack@google.com, kvm@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ackerley Tng <ackerleytng@google.com>
Cc:     erdemaktas@google.com, vannapurve@google.com, sagis@google.com,
        mail@maciej.szmigiero.name
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

On Mon, 27 Feb 2023 18:06:01 +0000, Ackerley Tng wrote:
> Align the guest stack to match calling sequence requirements in
> section "The Stack Frame" of the System V ABI AMD64 Architecture
> Processor Supplement, which requires the value (%rsp + 8), NOT %rsp,
> to be a multiple of 16 when control is transferred to the function
> entry point. I.e. in a normal function call, %rsp needs to be 16-byte
> aligned _before_ CALL, not after.
> 
> [...]

Applied to kvm-x86 selftests, thanks!

[1/1] KVM: selftests: Adjust VM's initial stack address to align with SysV ABI spec
      https://github.com/kvm-x86/linux/commit/1982754bd2a7

--
https://github.com/kvm-x86/linux/tree/next
https://github.com/kvm-x86/linux/tree/fixes
