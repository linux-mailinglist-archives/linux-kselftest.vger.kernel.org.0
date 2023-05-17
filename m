Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A069F705BD2
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 May 2023 02:09:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231458AbjEQAJX (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 16 May 2023 20:09:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231452AbjEQAJW (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 16 May 2023 20:09:22 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFF00122
        for <linux-kselftest@vger.kernel.org>; Tue, 16 May 2023 17:09:20 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-4d9b2045e1cso696a12.1
        for <linux-kselftest@vger.kernel.org>; Tue, 16 May 2023 17:09:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684282159; x=1686874159;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R6+sA3glVwNYujyPfaMc+ARRP8ltGy3qBe8Uw1+V7f8=;
        b=4OwqK3P6d+8uCpUBN5+GlnVRSZ7+N/8GtPEUqUxg5irzupRwHMPWOqLLOfgTT9pFA9
         Wt9NzaziMW34EUwoTL/wY0W/Ygyz8wvLhrm1UmwKh8DOdzmQvPgQAnkA3XG1ld8NQK6m
         fZgIY6aIsnJu+nbYz/SX0ltNPasXQ2AvPzoJqZo2ifwS17FyZVaBXc7H5kgu89stkYoa
         wpqd30vHKgTtnT4+9WiNVVcx0zB+E0BPTli2KLUQx6wFVAcAbLlGAPooPty0YaxMubdp
         wJoJi/qTz+yj5C7VkuI7WWNcIB+TmDK407oQNiHSC/tCMwhwMhuZBfPomeOptbRQfMEu
         L4vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684282159; x=1686874159;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R6+sA3glVwNYujyPfaMc+ARRP8ltGy3qBe8Uw1+V7f8=;
        b=R1lEKnyjaSQf6AKyY2xTMHMOme7/Gn0kmO0vzteHhCdJYh3iCcP+RSRQOV9z4P9QB2
         oIZHdezpOB1ZSsQ1C70DOhEnG/TObDpZtiJ9payGD4qe3SG4XAN+DEWCiCKv6Woco3W2
         g8LFRKqbtCV9Tr07JkfjeGj0Fkgu7h06v67TxFMpiBc/C6GzkbL1qpV5VuPnJgAlRys8
         J/3vMdVYNVOZXqCcsniDSGWlOxBgOWEIzbdUHZbdiYiITTGDuaSAGnHrG8q6oIf6Q6n4
         AX8EP8D8qw5qyRApPIxJYm3y0g9SavV67CrMzXDs9c+ngSRAoosyn3fCSEzIZ0ct5V0a
         Ifmw==
X-Gm-Message-State: AC+VfDzTgLdoCfZpFA4rrHC8HAXKu/9Qkgk6/wf+VAh1YisqaW/OwxOP
        cau7DGxVKZw4shDAocf/9/cRxYP4R5hLVItsyyZbmA==
X-Google-Smtp-Source: ACHHUZ6DHEWoXAcS3gqSXdcAPxwYIzsFqlA3U40BHQD/hc3Ovr6xApDyft45NrvMujC4HgN2sonyY3noO8ubH+NBctc=
X-Received: by 2002:a50:d4d5:0:b0:50b:c48c:8a25 with SMTP id
 e21-20020a50d4d5000000b0050bc48c8a25mr54691edj.6.1684282159196; Tue, 16 May
 2023 17:09:19 -0700 (PDT)
MIME-Version: 1.0
References: <20230515130553.2311248-1-jeffxu@chromium.org> <20230515130553.2311248-6-jeffxu@chromium.org>
 <4f14a645-3569-2e3b-f55c-3b17b567845a@intel.com>
In-Reply-To: <4f14a645-3569-2e3b-f55c-3b17b567845a@intel.com>
From:   Jeff Xu <jeffxu@google.com>
Date:   Tue, 16 May 2023 17:08:42 -0700
Message-ID: <CALmYWFvcZ+fGrCjfdx6DWNbYj0WQCJ-i4HFKHgSCqRU6Q4YbBQ@mail.gmail.com>
Subject: Re: [PATCH 5/6] KEY: Apply PKEY_ENFORCE_API to munmap
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     jeffxu@chromium.org, luto@kernel.org, jorgelo@chromium.org,
        keescook@chromium.org, groeck@chromium.org, jannh@google.com,
        sroettger@google.com, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-mm@kvack.org, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, May 16, 2023 at 4:24=E2=80=AFPM Dave Hansen <dave.hansen@intel.com>=
 wrote:
>
> On 5/15/23 06:05, jeffxu@chromium.org wrote:
> > From: Jeff Xu <jeffxu@google.com>
> >
> > This patch enables PKEY_ENFORCE_API for the munmap
> > syscall.
>
> The basic problem here is how we know when the set of syscalls that are
> patched here is good enough and how we catch future functionality that
> might need to be captured as well.
>
> This mechanism really needs to be able to defend against *any* changes
> to the address space.  I assume that folks are using syscall filtering
> to prevent new syscalls from causing havoc, but is there anything that
> can be done for, say, things like madvise()?  I bet it was harmless for
> a long time until MADV_DONTNEED showed up and made it able to
> effectively zero memory.

Not any change, just a limited set of syscall from user space.
I think it is reasonable to hope that any kind of syscall ABI change that
affects VMA will get reviewed thoroughly from now on.

Also, if we continue to add mseal() to the kernel, we will have to pay more
attention to syscalls related to VMA.

Thanks
-Jeff Xu
