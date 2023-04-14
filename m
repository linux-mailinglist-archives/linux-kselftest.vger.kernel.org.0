Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7E446E28F4
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Apr 2023 19:07:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230013AbjDNRHE (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 14 Apr 2023 13:07:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjDNRHE (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 14 Apr 2023 13:07:04 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B7B935AA
        for <linux-kselftest@vger.kernel.org>; Fri, 14 Apr 2023 10:07:02 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 81-20020a251854000000b00b8f5b60b760so5554790yby.19
        for <linux-kselftest@vger.kernel.org>; Fri, 14 Apr 2023 10:07:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1681492021; x=1684084021;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=wDseySW9a2X7Qw1Sb9G9CgyISJMWN8rI1x6WKWTmJyo=;
        b=ElymJGTZORqnkdX+LifBKgFphfCEVEy1d024fr+67V4qBmQ2e3LHA1P4/5AFoTDrAK
         n7IeTEglCOD5+s9Yyf7odF0sgQBJAOceEBCkvOHysK1Dl26uWwXNooa3Ve2maOAA+EXa
         RuG5yhvYFWVUEF2SNkkNkyGCSoP5fSF3F5I/76n4M6162VODJGGMZh3WfS0G6zfGm7Y9
         MsflPZu+G+dRHRXNjxtOZ0Nk5BXHPlKlQuEeFvKDpRjhsJAVq8hLlE0vYdYy+AOavLsM
         4VdepFJFp2OlkznQwbrZjvSXw35seTJPYZzNYNMwxIHzTUisJ4Fh7Yf6H2VC4/aVs3kX
         33Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681492021; x=1684084021;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wDseySW9a2X7Qw1Sb9G9CgyISJMWN8rI1x6WKWTmJyo=;
        b=QQpjAoHgy9DUBk1/NYy13+I+ZHRKoBnrCyPx3TUOqK+TRYG1Djh6p7OTI6yitG63bB
         H+TC+K5CzaGf5rhQ4oJYV2fj8DpNrgThkgT4b0ONEHdZmfksGvk5OeXV7Z5t2QLDtvt/
         PKgGNEP2bgnxTXEe2/Qtnhudn3vzfnMmVUpeit50rFK/Z24kr1NGW4xQPJnBnzfj3dcN
         qe/PworlY0364dS8Jf927d4baKUyCPkjEYxiTt5Taiey4E4HWS5nHAIVcsIThnSFk8oI
         CAQPS1lthL+4ppaaHxRIYTtPxulKPkk/GtPxDOihDJVmbVSKUAG2H06U7LtxDfPpjgpz
         +L4w==
X-Gm-Message-State: AAQBX9dnN3s2AuLNS1+i8+v4uvVRH+TvXghDug5/ovMpqssK2HQJeJ6J
        P6N3qmMXCy/jevFI+HLqMQgrkrAK1GU=
X-Google-Smtp-Source: AKy350Yat8GT3+tQtPKHn5QSYC3aQP0t7/vwRLFqPeHO7FhubHdEiGDN4FLO5CLDgp8jDvHiAI4diwo8Szo=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a25:d28a:0:b0:b8f:359f:2a20 with SMTP id
 j132-20020a25d28a000000b00b8f359f2a20mr3369573ybg.10.1681492021711; Fri, 14
 Apr 2023 10:07:01 -0700 (PDT)
Date:   Fri, 14 Apr 2023 10:05:28 -0700
In-Reply-To: <20230414080809.1678603-1-colin.i.king@gmail.com>
Mime-Version: 1.0
References: <20230414080809.1678603-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.40.0.634.g4ca3ef3211-goog
Message-ID: <168149189684.1511520.17004133772489176964.b4-ty@google.com>
Subject: Re: [PATCH][next] KVM: selftests: Fix spelling mistake "perrmited" -> "permitted"
From:   Sean Christopherson <seanjc@google.com>
To:     Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Shuah Khan <shuah@kernel.org>, kvm@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        Colin Ian King <colin.i.king@gmail.com>
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, 14 Apr 2023 09:08:09 +0100, Colin Ian King wrote:
> There is a spelling mistake in a test report message. Fix it.

Once again, your spell checker laughs dirisively at my futile attempts.

Applied to kvm-x86 selftests, thanks!

[1/1] KVM: selftests: Fix spelling mistake "perrmited" -> "permitted"
      https://github.com/kvm-x86/linux/commit/20aef201dafb

--
https://github.com/kvm-x86/linux/tree/next
https://github.com/kvm-x86/linux/tree/fixes
