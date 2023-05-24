Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3F3270FF04
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 May 2023 22:16:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236201AbjEXUQI (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 24 May 2023 16:16:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232845AbjEXUQH (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 24 May 2023 16:16:07 -0400
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 948D0113
        for <linux-kselftest@vger.kernel.org>; Wed, 24 May 2023 13:16:01 -0700 (PDT)
Received: by mail-oi1-x22e.google.com with SMTP id 5614622812f47-38bed577755so313210b6e.0
        for <linux-kselftest@vger.kernel.org>; Wed, 24 May 2023 13:16:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1684959361; x=1687551361;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=esoimroWkrL9UG9uMCk43F+mfgKePk35ZCciJnQDAkc=;
        b=jR0U4eVs+HCQeyO0rmH9Zxj+N0VyaYsQvTzC7psBsfJbGQ6nS5u9eJT0i0j85cIHvk
         czRu1HV2uwA/KDRFg1j5fn/Dd4R9z5b6aw90ZBdWflA6NG0Z5ske/4njAKixpkB17Kox
         /Eugws1hC6JcHmeJ6WEozM+6Sl2LdLs6LJ2ns=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684959361; x=1687551361;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=esoimroWkrL9UG9uMCk43F+mfgKePk35ZCciJnQDAkc=;
        b=Vqecu6yZ9wJCNZ0KzSztSG8qY1l7xDRRacLpzrWyFNM1BPWQB1nM5o5Sy4NpNlhLKp
         PTJOsqw9CWNx2lV7y2HGcq66m1IoGUUZiD/MBEnC/EwN0K+fI0A+43zKehWpVOU47QTG
         XS6+DQo3AyAf+Ry5Ei8fIX6hlofrcH7GiIYyBVDT6/TgkGF7IWA/Vg9iH/N5TNutQ/oV
         r39qBXT0UDYTU0JIs/gQbXKUmwVc5i5Pm+UODhbIAyKVE4rgBlMgLARXPfQ1Fdrq/Z3p
         3cHK0tWKURJ8+sdgyvW/5M2snysTjMqaAIopv+WVYgGKTvxqMgKOcbHvr8tpOFcNIv/p
         pIzw==
X-Gm-Message-State: AC+VfDxQkWVXZWzaIELs8EJXFYY5Sg4yl5/ED7jKoUxEyDMTh3626D/2
        3d6NzzLFRoxZBhaP6R1RgiiO+HK8Wxw/dwWpL17/rA==
X-Google-Smtp-Source: ACHHUZ4vEvWyW3CX9DBeFwy4Iuv22tTqCB/I2KaWZyvUNUxdCQPP/KLsw7NzO3Qpm9DIvGHyd/tz++Pg5pVjG53Rskk=
X-Received: by 2002:a54:480b:0:b0:398:105b:530b with SMTP id
 j11-20020a54480b000000b00398105b530bmr5216910oij.33.1684959360986; Wed, 24
 May 2023 13:16:00 -0700 (PDT)
MIME-Version: 1.0
References: <20230515130553.2311248-1-jeffxu@chromium.org> <2bcffc9f-9244-0362-2da9-ece230055320@intel.com>
 <CAEAAPHYdRyZEMp97919errF7SDuYBJoSrD5i1wrTx1sMdr_ZdQ@mail.gmail.com>
 <fbe53dcf-6e21-e4cf-c632-4da8369d7e83@intel.com> <CAEAAPHa=zYyjV5RqvPryRsW7VqY9cJC_-CJW6HKczY0iVsy-bg@mail.gmail.com>
 <d8f2d5c2-6650-c2a6-3a20-25583eee579b@intel.com> <CALmYWFsnGjniVseJKuhKO6eet10Onyk_C0=KNe6ZzXoCiBKZOw@mail.gmail.com>
 <b69f6809-b483-158f-8be9-4976fad918d8@intel.com> <CALmYWFs5Vgosz2JUYWkoc4YwDbiB0tT32MFpo-y6aX4kwuoz8Q@mail.gmail.com>
 <2b14036e-aed8-4212-bc0f-51ec4fe5a5c1@intel.com> <CALmYWFuSTc5Q7Hrra8FijE11+Y1KiROa=xCZWL1D3ifthrrDMQ@mail.gmail.com>
 <9d64c949-6d5f-06c0-47ef-caade67477e5@intel.com>
In-Reply-To: <9d64c949-6d5f-06c0-47ef-caade67477e5@intel.com>
From:   Jeff Xu <jeffxu@chromium.org>
Date:   Wed, 24 May 2023 13:15:50 -0700
Message-ID: <CABi2SkUzwdBGyjHjXtyFK5dtLVB2keKCpZpkpiuaStd6b2cEWA@mail.gmail.com>
Subject: Re: [PATCH 0/6] Memory Mapping (VMA) protection using PKU - set 1
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Jeff Xu <jeffxu@google.com>,
        =?UTF-8?Q?Stephen_R=C3=B6ttger?= <sroettger@google.com>,
        luto@kernel.org, jorgelo@chromium.org, keescook@chromium.org,
        groeck@chromium.org, jannh@google.com, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-mm@kvack.org, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Thanks for bringing this to my attention. Regarding io_uring:
>
> io_uring fundamentally doesn't have the same checks.  The kernel side
> work can be done from an asynchronous kernel thread.  That kernel thread
> doesn't have a meaningful PKRU value.  The register has a value, but
> it's not really related to the userspace threads that are sending it
> requests.
>

I asked the question to the io_uring list [1].  io_uring thread will
respect PKRU of the user thread, async or not,  the behavior is the
same as regular syscall. There will be no issue for io_uring, i.e if
it decides to add more memory mapping syscalls to supported cmd in
future.

[1] https://lore.kernel.org/io-uring/CABi2SkUp45HEt7eQ6a47Z7b3LzW=4m3xAakG35os7puCO2dkng@mail.gmail.com/

Thanks.
-Jeff
