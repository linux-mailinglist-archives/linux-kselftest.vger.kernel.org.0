Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33DA27B85E8
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Oct 2023 18:55:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243546AbjJDQzB (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 4 Oct 2023 12:55:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243511AbjJDQzB (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 4 Oct 2023 12:55:01 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85333AB
        for <linux-kselftest@vger.kernel.org>; Wed,  4 Oct 2023 09:54:57 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-59f67676065so33540537b3.0
        for <linux-kselftest@vger.kernel.org>; Wed, 04 Oct 2023 09:54:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696438497; x=1697043297; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=v1SpCSVBVkGWfR+UVpLKMyMdKYaLIo/4ycal5KL0JmU=;
        b=BQCb8ij3zdhky/1vgEEKMhtBMsgfFAo6jps8xVr3wBICqOF/kjqhXaqdElAK2xI1bS
         U3cgOrlMvtFG5ECDU0wbJX7io9/m+60G84oEVcyPXvW5l+c99C+nkhMcjqMG06lAs64J
         JcsUd5KjOhbY3t9S2KlFc2Lqnf54zyOA4NMnRme9qoOxHc56ihSYzPgiCfXS1KTOHRLQ
         7vqXSS9ZrMAqfViGVSYkaeO1rOdjaapK3UjLBKajtx9Ig7L9WIYQPNjuJczk7iHBYs5+
         7Bb3NbuRQ1K4k+rGFvupZ64bfmUnyG8EH0+/Tr4Rp2z2ywod6gN4uoG6+3Y42syQheqN
         al7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696438497; x=1697043297;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=v1SpCSVBVkGWfR+UVpLKMyMdKYaLIo/4ycal5KL0JmU=;
        b=o7mmGr/gELRGCLXuI+zPknHq82X+hqIO0VD9iHEVLez3CKzevADjRhRJ0GaISeSmK4
         4HAfg1+2MhwYWK2WHKKKr+B95ez2Olpbi3JKWKhhEZJOkyfm4WxLokLV6mwxVq+bP1lU
         q1LjjrtAIUaS4arNMF2bxUcXMKSL2DZ0tH7Rb/TWTFjrLdxMI4EXT8TfPkPCA7CK+VIS
         c/pXEElcGSmvpmWWU+wadYcaCtecMJabABW9VnxVKHLoB2vRb+bPHuicrS9w2V4OBs6P
         wdaTNy5erMsuli2jOQ8XAoL6v6k8ck9sidRbKpfTI9LCjGp++lZ8LFiXcGY5xY0Yo8VD
         GWqQ==
X-Gm-Message-State: AOJu0YyhPauI+8XkUDMA5iLom8U/usB23KI+0YPC8GOJfKpbkiykVkbD
        hZ04xRcfjfpjQetv53CaRB1LNi0YfI8=
X-Google-Smtp-Source: AGHT+IF4i+oQKJd8u1V+TB1VPIOAogrhPtMWZdEvSZy8rU+jM1S65yQ94jKQ9NyvjRiXgJ/MLji9dcyTwZ4=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a81:a909:0:b0:59b:e97e:f7e3 with SMTP id
 g9-20020a81a909000000b0059be97ef7e3mr53564ywh.2.1696438496733; Wed, 04 Oct
 2023 09:54:56 -0700 (PDT)
Date:   Wed, 4 Oct 2023 09:54:55 -0700
In-Reply-To: <ZR2EyUULbRpXW8wK@luigi.stachecki.net>
Mime-Version: 1.0
References: <20230928001956.924301-1-seanjc@google.com> <ZR0QOGo5DftkRWsr@redhat.com>
 <ZR1Yt6Z+dhMbn/FJ@luigi.stachecki.net> <ZR175enUCh3KkAU6@google.com> <ZR2EyUULbRpXW8wK@luigi.stachecki.net>
Message-ID: <ZR2Y34hFpLmCYsUr@google.com>
Subject: Re: [PATCH 0/5] KVM: x86: Fix breakage in KVM_SET_XSAVE's ABI
From:   Sean Christopherson <seanjc@google.com>
To:     Tyler Stachecki <stachecki.tyler@gmail.com>
Cc:     Leonardo Bras <leobras@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Shuah Khan <shuah@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-kselftest@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Oct 04, 2023, Tyler Stachecki wrote:
> On Wed, Oct 04, 2023 at 07:51:17AM -0700, Sean Christopherson wrote:
 
> > It's not about removing features.  The change you're asking for is to have KVM
> > *silently* drop data.  Aside from the fact that such a change would break KVM's
> > ABI, silently ignoring data that userspace has explicitly requested be loaded for
> > a vCPU is incredibly dangerous.
> 
> Sorry if it came off that way

No need to apologise, you got bit by a nasty kernel bug and are trying to find a
solution.  There's nothing wrong with that.

> I fully understand and am resigned to the "you
> break it, you keep both halves" nature of what I had initially proposed and
> that it is not a generally tractable solution.

Yeah, the crux of the matter is that we have no control or even knowledge of who
all is using KVM, with what userspace VMM, on what hardware, etc.  E.g. if this
bug were affecting our fleet and for some reason we couldn't address the problem
in userspace, carrying a hack in KVM in our internal kernel would probably be a
viable option because we can do a proper risk assessment.  E.g. we know and control
exactly what userspace we're running, the underlying hardware in affected pools,
what features are exposed to the guest, etc.  And we could revert the hack once
all affected VMs had been sanitized.
