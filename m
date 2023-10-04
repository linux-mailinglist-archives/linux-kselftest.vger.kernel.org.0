Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D1637B838F
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Oct 2023 17:29:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233163AbjJDP3W (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 4 Oct 2023 11:29:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233085AbjJDP3V (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 4 Oct 2023 11:29:21 -0400
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C254BD;
        Wed,  4 Oct 2023 08:29:18 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id af79cd13be357-77386822cfbso155807885a.0;
        Wed, 04 Oct 2023 08:29:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696433357; x=1697038157; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1pp3fcQ7FJOqborLPqxKyTwdh4X5c9UMKg0BftM+5OM=;
        b=D0cRnCZ6EAgPJJsIAD+Vrb8LGO2ZPCO+UiOdXvcAim2+sy4id9KYk/shwA4wqqB6fE
         oy5WfigpF/YMsmlbg3X7RQGPqbF+xEvGfdllnxJUIqCQix5t0JIo5R1jyW8jq16xeEuP
         Mpdq6KBDeVbBUCXoF5t7rVzWqijbBODpaCcBCmSf5KomrGVP0+cZLhhB5Ctfwfe8oeTi
         n5uoLFzODcG2cjVP4zhO6Tn4URQC0S6Qc6NTZ/kfFduY1VbDHuZ6lBVztJR/GP5jd2Rc
         B0uCqXAgX4jAP8AbI0gMdL8S2WR7i94wH3nknK0xS+wPik+b+qKpX4CRcEcsSJ7Y1VC6
         6ZSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696433357; x=1697038157;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1pp3fcQ7FJOqborLPqxKyTwdh4X5c9UMKg0BftM+5OM=;
        b=JOcI8GTrn1nIbimKr0brncOwBYSg1phdodruHKB0/a1Zp3P9rRTus+kpAKO9Tmsi0q
         qnw07Q6akgZZLWCoQyZdM73ZuCMLfms2ssCBNWp0FZGlEQIygHqQ33VwOYGMpjl9Fsjq
         eW6Vj0RVRc2kwgWP7dP+dS15mUXOuW6dieo1pfRNY88/OHkKPzDMWV4zEn4OW7rhB11+
         BMrGRP+YR+Z59QaguIveb5ZReJxdibp3KpBDDhdyndEN2tHMqZ579A9rwMw5qzbtOZlH
         X6oLIdKpG8pBogHqRNF8nWTNlknTL3tja8KzUkgWosjbKQT0rp8Hwyj999DPdkOzWm38
         IuFQ==
X-Gm-Message-State: AOJu0YzIV0qn07AIwhp/CGBK2bXeTehnXF+GEm2nVSNOlUssTfhPdscP
        ivIQ1GpTD/QFY+LBudqVdZM=
X-Google-Smtp-Source: AGHT+IErN77YwXwvT/7yy4wgBAH4cMWdYh0XlJUsosZnTUdal8Ue3ccamEsrM08lCtZNGjyn4NScDw==
X-Received: by 2002:a05:6214:3019:b0:65b:150e:604b with SMTP id ke25-20020a056214301900b0065b150e604bmr2806646qvb.49.1696433357301;
        Wed, 04 Oct 2023 08:29:17 -0700 (PDT)
Received: from luigi.stachecki.net ([65.115.226.163])
        by smtp.gmail.com with ESMTPSA id c12-20020a0cca0c000000b0065b21b232bfsm1389520qvk.138.2023.10.04.08.29.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Oct 2023 08:29:16 -0700 (PDT)
Date:   Wed, 4 Oct 2023 11:29:13 -0400
From:   Tyler Stachecki <stachecki.tyler@gmail.com>
To:     Sean Christopherson <seanjc@google.com>
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
Subject: Re: [PATCH 0/5] KVM: x86: Fix breakage in KVM_SET_XSAVE's ABI
Message-ID: <ZR2EyUULbRpXW8wK@luigi.stachecki.net>
References: <20230928001956.924301-1-seanjc@google.com>
 <ZR0QOGo5DftkRWsr@redhat.com>
 <ZR1Yt6Z+dhMbn/FJ@luigi.stachecki.net>
 <ZR175enUCh3KkAU6@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZR175enUCh3KkAU6@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Oct 04, 2023 at 07:51:17AM -0700, Sean Christopherson wrote:
> KVM's ABI has no formal notion of guest boot=>shutdown or live migration.  The
> myriad KVM_GET_* APIs allow taking a snapshot of guest state, and the KVM_SET_*
> APIs allow loading a snapshot of guest state.  Live migration is probably the most
> common use of those APIs, but there are other use cases.

I think the lightbulb just clicked, it is really this:

> No, the VM will not have less features, because KVM_SET_XSAVE loads *data*, not
> features [...]

I think I'm conflating the data vs. features aspect here and will have to
revisit my understanding of the code...

> > Ultimately, this problem is not really fixable if said features cannot be
> > removed.

> It's not about removing features.  The change you're asking for is to have KVM
> *silently* drop data.  Aside from the fact that such a change would break KVM's
> ABI, silently ignoring data that userspace has explicitly requested be loaded for
> a vCPU is incredibly dangerous.

Sorry if it came off that way - I fully understand and am resigned to the "you
break it, you keep both halves" nature of what I had initially proposed and
that it is not a generally tractable solution.

That being said, I genuinely appreciate your jump to action on this problem!

Thanks,
Tyler
