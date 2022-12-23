Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D302655532
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 Dec 2022 23:36:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231793AbiLWWgc (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 23 Dec 2022 17:36:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229937AbiLWWgb (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 23 Dec 2022 17:36:31 -0500
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0AE25594
        for <linux-kselftest@vger.kernel.org>; Fri, 23 Dec 2022 14:36:30 -0800 (PST)
Received: by mail-qk1-x72b.google.com with SMTP id z17so2931394qki.11
        for <linux-kselftest@vger.kernel.org>; Fri, 23 Dec 2022 14:36:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=cqv6ukAe7n3WdU3prmY1TtPIP91KUSKKlSsncE//qT8=;
        b=rlNzMsI6IxVGMiw8F+R1DNaHN9CugTOl9IgmZAzgzCB2jnQ9BLDli+Fgyd7EExQLrg
         APzRAvrgB1VKgcraEpZFy8n7678xXQ3yzYkg+Y+VzuIj5m6GsiyTFh+961MOIPoFwAA/
         GfAMHyEfEFybgz8YjsxebQlrBi+9JevG6p2vA2NNw2Z3AcvNn2LWvwmjJ70Y+xU0YbQ/
         wB1QXgxGnDaiOj2FEzn0FEVrQnrdQ8pB5kNi7MgjS5H2ucg+WCJ3VYe940+llB+Wgrft
         92DxFNSTeja4KSYlvnK5P/TsI0bQ/3AQpDkGbf/N3xugfCQT8vuyjURSSWmcOan86Rsx
         KzqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cqv6ukAe7n3WdU3prmY1TtPIP91KUSKKlSsncE//qT8=;
        b=lt7Kr5we1Rp0IhT4hPgLNTAZUbMY1YzEZCrThL9w6nKa1CprVz1Ok+Koi0TrWcuJUp
         gdUDboWg91YAmXHlj5Vt7Hr2nUqkEChr61jhhwnGuvZHhSmjPKFBaU/gbSaqgMc61DaT
         blQrhJtAHaQ58prgWxUwtyD7ixvaPurfgY1x5IhnaAraBBOTwaZ6ksKGAoMqtC2+r7n5
         nGH+LquRs7S9H4exIAjZSQNIX7fWybK382EUkrDhxjC/Tp1+T1wEkKpDM3JFWuhsdOI1
         oJfj6l3a8HSzCqQeNth2lyks66NukPD19/5M/RYwSBnUrJjEYXSV9k4W6xJVmaN47o9H
         UXWw==
X-Gm-Message-State: AFqh2kohWRnKBcBd7bMEZRzi94YIs9NYAIyU4gWj6cmF4X8wzzxIjgQt
        O9lNuafimVC2pi0WILoIAMFiwCGSrkL0HRU7Eg4a2A==
X-Google-Smtp-Source: AMrXdXuRQCvY0uoZyyRRGYA+UsBd5fPA18lLwLNDzUkeizNc9wN9X/xF9w0EsZDZ0MYtKGR8waTSUNKvgMknHrVCy3E=
X-Received: by 2002:a05:620a:490a:b0:702:103e:c728 with SMTP id
 ed10-20020a05620a490a00b00702103ec728mr648073qkb.220.1671834989939; Fri, 23
 Dec 2022 14:36:29 -0800 (PST)
MIME-Version: 1.0
References: <20221222230458.3828342-1-vannapurve@google.com> <20221223173733.1624778-1-pbonzini@redhat.com>
In-Reply-To: <20221223173733.1624778-1-pbonzini@redhat.com>
From:   Vishal Annapurve <vannapurve@google.com>
Date:   Fri, 23 Dec 2022 14:36:18 -0800
Message-ID: <CAGtprH_3QoOBhTve2uC1tV9rg4C8tqfU4zATXW_DusjHXWaxdg@mail.gmail.com>
Subject: Re: [V3 PATCH 0/2] Execute hypercalls from guests according to cpu
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     x86@kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, shuah@kernel.org,
        bgardon@google.com, seanjc@google.com, oupton@google.com,
        peterx@redhat.com, vkuznets@redhat.com, dmatlack@google.com,
        pgonda@google.com, andrew.jones@linux.dev
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Dec 23, 2022 at 9:38 AM Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> > This series adds support of executing hypercall as per the native cpu
> > type queried using cpuid instruction. CPU vendor type is stored after
> > one time execution of cpuid instruction to be reused later.
>
> Makes sense, are you going to add more patches that use the new function?
>
> Paolo
>
>

Yeah, another series [1] uploaded recently, uses this newly added function.

[1] https://lore.kernel.org/lkml/20221223001352.3873203-1-vannapurve@google.com/

- Vishal
