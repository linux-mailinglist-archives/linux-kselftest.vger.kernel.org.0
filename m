Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 845AB776C68
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Aug 2023 00:45:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231199AbjHIWph (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 9 Aug 2023 18:45:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233349AbjHIWpg (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 9 Aug 2023 18:45:36 -0400
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A67F1B6
        for <linux-kselftest@vger.kernel.org>; Wed,  9 Aug 2023 15:45:35 -0700 (PDT)
Received: by mail-ot1-x333.google.com with SMTP id 46e09a7af769-6bd0425ad4fso274720a34.2
        for <linux-kselftest@vger.kernel.org>; Wed, 09 Aug 2023 15:45:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1691621134; x=1692225934;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=IYXl3RrdquB9Ho5EWgj4Trb8iaNi5AAc7V62J8/U+2U=;
        b=g9IRPR3fNObWkuKpLaklAg2KwEj1yjDutI0rhuDEpK8jY96HuF2psgETqe/XrmnPhD
         jva8ORxrZEcvXDzSK6ywrvMf/BOF5kgQJoeYleP5Uh4JpvzThQzWGsA6RUWhsNeJXNhb
         dte2auuNnDHSjHOLS9xgL5q/yWasM5K/0kAfqoTJRPYa0PDluh7q9HLvDdOKTlJJfHto
         5PDPiHv5gn02yEggqEHSGPT4NdPuFZSBwP61bEbRpbLZtthJfw1UYCJiH1bc5vmQi21o
         9S9lL0wqEs5RXiEqUFrEpZt5+wDoWrrGF0fXP006pmFQX7ibAWrur8lTWaj0rGrkUXhM
         Z9OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691621134; x=1692225934;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IYXl3RrdquB9Ho5EWgj4Trb8iaNi5AAc7V62J8/U+2U=;
        b=k/xath8zn1mAGmqSUIJ+fgZtH472/aV2BA8Ojfu8GbIjqoNECYGytL5hq8K07oXMm+
         VkWI0StZdV0JoTNrmtoSX5CUQ3PsyaT30po5mCtakieR4GrdfdeX01Li9dQkJ06psY+k
         FZb6+MgU0LktP6gVvm5TFBgw/dwuwCJA/JBtXx49xbVwKwkCxaMwHq7rZlacr0VHAiQF
         sOwdhb92ninkUlHKZedVN7QiXAfZRbFYmRMVyyHphWK3MN8JVtkJJDHrxQI04WMOIDiU
         xR4l4Q4Zk1gbbgr0z+dA/WwRDCWts5STPCFXM4DPS9a6d6ABU6Kqg5H1dvac1GptOH5a
         oMcw==
X-Gm-Message-State: AOJu0Yx9sxZRruWWdjkOyzY3whIVCnslS/Q000oeenLvZAUGnjoA7DEx
        1gCoxlTZDMA/0a+ZfiQET2jDdg==
X-Google-Smtp-Source: AGHT+IH+4koeF0K3irmsPyfqmp0CgHhX+m/BeL70iUcm3M72Bf4Rf+ltNoovX0/mGJoR9LCbEeV95Q==
X-Received: by 2002:a9d:7306:0:b0:6bc:8a9a:35a6 with SMTP id e6-20020a9d7306000000b006bc8a9a35a6mr486662otk.9.1691621134736;
        Wed, 09 Aug 2023 15:45:34 -0700 (PDT)
Received: from ghost ([50.221.140.188])
        by smtp.gmail.com with ESMTPSA id x9-20020a656aa9000000b00563df2ba23bsm108226pgu.50.2023.08.09.15.45.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Aug 2023 15:45:34 -0700 (PDT)
Date:   Wed, 9 Aug 2023 15:45:31 -0700
From:   Charlie Jenkins <charlie@rivosinc.com>
To:     Conor Dooley <conor.dooley@microchip.com>
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        conor@kernel.org, paul.walmsley@sifive.com, palmer@rivosinc.com,
        aou@eecs.berkeley.edu, anup@brainfault.org,
        konstantin@linuxfoundation.org, linux-doc@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
        mick@ics.forth.gr, jrtc27@jrtc27.com, rdunlap@infradead.org,
        alexghiti@rivosinc.com
Subject: Re: [PATCH v9 0/4] RISC-V: mm: Make SV48 the default address space
Message-ID: <ZNQXC+UQ+a0s69Bs@ghost>
References: <20230809015110.3290774-1-charlie@rivosinc.com>
 <20230809-bobbing-unleaded-c3d5e1c57d96@wendy>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230809-bobbing-unleaded-c3d5e1c57d96@wendy>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Aug 09, 2023 at 08:42:58AM +0100, Conor Dooley wrote:
> On Tue, Aug 08, 2023 at 06:51:06PM -0700, Charlie Jenkins wrote:
> > Make sv48 the default address space for mmap as some applications
> > currently depend on this assumption. Users can now select a
> > desired address space using a non-zero hint address to mmap. Previously,
> > requesting the default address space from mmap by passing zero as the hint
> > address would result in using the largest address space possible. Some
> > applications depend on empty bits in the virtual address space, like Go and
> > Java, so this patch provides more flexibility for application developers.
> 
> This still does not build:
> ../fs/binfmt_flat.c:900:30: error: call to undeclared function 'is_compat_task'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
> 
> Reproduceable with allmodconfig.
> 
There is some weird interaction with compat.h. Moving the definitions
in pgtable.h into the #ifndef __ASSEMBLY__ guarded section resolves 
the compile error. I will send out another version with this change.

-Charlie
