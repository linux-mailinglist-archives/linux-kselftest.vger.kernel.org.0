Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E42AD558A2C
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Jun 2022 22:34:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230175AbiFWUef (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 23 Jun 2022 16:34:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230107AbiFWUee (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 23 Jun 2022 16:34:34 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2831E60E02
        for <linux-kselftest@vger.kernel.org>; Thu, 23 Jun 2022 13:34:32 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id d129so483021pgc.9
        for <linux-kselftest@vger.kernel.org>; Thu, 23 Jun 2022 13:34:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=VV9cljBvBFHor9Hsmi3I2V+2UnCkisvxO/5bxp9iuO0=;
        b=TVePn525gz1XLdYPkgwNoXqcj14LJor7LSwXlZWvK+7XGD1ZD4uIy8qd7M8reu2WHE
         phe8hp+0H402nxdcKG7yIb5RYp0AHL64lzETS64Xv9XEjlVjE1BA1ltUi+jyBBqN2qTc
         N1WRXTm+pbum/QZS6WaGMwNNFJnSXxmgAgc7tyLwtZxse4XxIFiihF3sjdqdX0Oisdvn
         2Z2fQgYWko0tGAnQuqmzieEJCdqD/55dJ/62RZEJRrDxQcrMAH4b77CaPucpni+sQE6y
         ga6vTEzEe/vYMj1ayGv0icjAJ36ljYfM2Q5r9LlYVJ6EAeFx8ZLPtOf11AoGxl3cY6S6
         MXQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=VV9cljBvBFHor9Hsmi3I2V+2UnCkisvxO/5bxp9iuO0=;
        b=PgIRm9HKqGrmUf65TR2aQtqLlIcvOKCI0ico0luFMuRmGsF7AxdtdG36fl2GfcDDil
         XvrCVPT2aa2jgQODiKBwbS1lJsUI2Z1PKlXWCRKCLDJnt8GFfT07Frgk9eT4Vq2yGX3F
         3hu7rvYtcVWXEhp+ulvIO8jGlmrorZDuEo3Nx0xxetO7AgJY6KwFNqfY7mA0UktUrWMo
         W6icuEP9CMeecPCVP5p235gMuW7/C5HDvdhcN1bZu1oK0n3TdzCDXSEPmp1KOiUfTdmZ
         CZUIhmp0CBLKHw9bl3EOasNMQZNMXEvmuA8KdAge2dpNEX3apwl/d+X9I8fffnS2K0no
         6JEg==
X-Gm-Message-State: AJIora9Nya7hDdFhI76uyKelD0iODTtN7TQwpO3Nd6bP08hTSLkLvaRx
        3FdlJiEf6TR9T30RIZn+JURokA==
X-Google-Smtp-Source: AGRyM1upbFHe5dNWeaInTDpiZf5i80ia/03IiaYuju8VaHMiLBdaK0ZnQif7xXzrfPW9Z/RJsEscPg==
X-Received: by 2002:a63:5c56:0:b0:3fc:824d:fc57 with SMTP id n22-20020a635c56000000b003fc824dfc57mr9060291pgm.561.1656016471539;
        Thu, 23 Jun 2022 13:34:31 -0700 (PDT)
Received: from google.com (123.65.230.35.bc.googleusercontent.com. [35.230.65.123])
        by smtp.gmail.com with ESMTPSA id t14-20020a17090340ce00b00163bddfb109sm237949pld.10.2022.06.23.13.34.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jun 2022 13:34:31 -0700 (PDT)
Date:   Thu, 23 Jun 2022 20:34:27 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Chao Gao <chao.gao@intel.com>
Cc:     Zeng Guang <guang.zeng@intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Venkatesh Srinivas <venkateshs@chromium.org>
Subject: Re: [PATCH v2] KVM: selftest: Enhance handling WRMSR ICR register in
 x2APIC mode
Message-ID: <YrTOU1QHHpGpe0ym@google.com>
References: <20220623094511.26066-1-guang.zeng@intel.com>
 <20220623103314.GA14006@gao-cwp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220623103314.GA14006@gao-cwp>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

+Venkatesh

On Thu, Jun 23, 2022, Chao Gao wrote:
> On Thu, Jun 23, 2022 at 05:45:11PM +0800, Zeng Guang wrote:
> >Hardware would directly write x2APIC ICR register instead of software
> >emulation in some circumstances, e.g when Intel IPI virtualization is
> >enabled. This behavior requires normal reserved bits checking to ensure
> >them input as zero, otherwise it will cause #GP. So we need mask out
> >those reserved bits from the data written to vICR register.
> 
> OK. One open is:
> 
> Current KVM doesn't emulate this #GP. Is there any historical reason?
> if no, we will fix KVM and add some tests to verify this #GP is
> correctly emulated.

It's a bug.  There are patches posted[*], but they need to be refreshed to fix a
rebase goof.

Venkatesh, are you planning on sending a v3 soonish?

[*] https://lore.kernel.org/all/20220525173933.1611076-1-venkateshs@chromium.org
