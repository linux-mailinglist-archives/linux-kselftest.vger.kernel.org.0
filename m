Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 303D55691FE
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Jul 2022 20:38:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229379AbiGFSif (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 6 Jul 2022 14:38:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230329AbiGFSie (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 6 Jul 2022 14:38:34 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3BAC4DAE
        for <linux-kselftest@vger.kernel.org>; Wed,  6 Jul 2022 11:38:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657132712;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6bZNuL7RAHnFV67f4D5x/92+2WjgdYrP06Pk08jyQTU=;
        b=Xx0ZQAf/10hsoNZw5I3xj4/pbWhRPN523y7sy21aPFJLY4zTEWl68WsL9UycFEQIk+Dfdc
        yj9F4aS9axnUx8uv0syTbINtMolzeCKB3Pq6XptcMJN9KEJLBxOkMPV6Smpx2SCtUtW7F+
        XX05b2U0wbZ3vnsgyd13QgbA8yOB1LY=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-445-VkDBwIiSNSeC_heTlViTgA-1; Wed, 06 Jul 2022 14:38:31 -0400
X-MC-Unique: VkDBwIiSNSeC_heTlViTgA-1
Received: by mail-ej1-f70.google.com with SMTP id qf29-20020a1709077f1d00b00722e68806c4so4026072ejc.4
        for <linux-kselftest@vger.kernel.org>; Wed, 06 Jul 2022 11:38:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6bZNuL7RAHnFV67f4D5x/92+2WjgdYrP06Pk08jyQTU=;
        b=NqYL9NmSSaIn9qnbmGNxi3+EQG2L7aaUg8N2SEG+PD38PcNzmLSVQngBVic2ztkOl6
         /0l58+NhEnpqvM8bhZKWqTocvewwEWj0w3JXtGT0BAcC6RJytdYLdj3ZWf/hX09CAPwK
         wjdpHJIdDYxbzZUKxjGejziEFktpuOqOJnjl4yXTMuG/LsFHZCDSh8W/YS0hxNYVOEMS
         CTHbUp0f8sHCwqm7fDhqCFu3EIBEz1U4qPLiVuKyOdpDj7sFR448yF/+7+lmK+rdJ0ol
         fcMl3qydFq41DUf9D5bKKAVcCMuQyJt2i47oi2AZJ+tOvgb3oI4HAtLNq8XXcGkQJbxZ
         57cw==
X-Gm-Message-State: AJIora//MrI/LhiImLVdspqeOMA5nF3QyoBW8k0xv+bzPz4t4bgmwSkk
        KtCw7NWT5MhUHZS9d/tusgdOg4rL7u0k3r+aJOi65lQ+yPq7eg3XbBzywmPTZIgATXSdYgoakTI
        rwmK40lKyfDxVOheRaOwCZn7Rv7RVqRegYpdpBPPWfOXO
X-Received: by 2002:a05:6402:3514:b0:435:f24a:fbad with SMTP id b20-20020a056402351400b00435f24afbadmr54023792edd.311.1657132709526;
        Wed, 06 Jul 2022 11:38:29 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1vXkS+TeYM2iH5bLiOApP8aVSIv6LgG4byRceGi0vcWQ4mpyVXCApsVKw0zrZulmdTMksv1p49XD8lx8TzmptI=
X-Received: by 2002:a05:6402:3514:b0:435:f24a:fbad with SMTP id
 b20-20020a056402351400b00435f24afbadmr54023768edd.311.1657132709303; Wed, 06
 Jul 2022 11:38:29 -0700 (PDT)
MIME-Version: 1.0
References: <20220705185605.3889110-1-jsavitz@redhat.com> <20220705133456.d5572b2e36ebb36188369988@linux-foundation.org>
In-Reply-To: <20220705133456.d5572b2e36ebb36188369988@linux-foundation.org>
From:   Nico Pache <npache@redhat.com>
Date:   Wed, 6 Jul 2022 14:38:03 -0400
Message-ID: <CAA1CXcAFyMLBEi87A0+pBbUKtzfEeE-5uyqPugmHLmzgH8=w8w@mail.gmail.com>
Subject: Re: [PATCH] selftests/vm: enable running select groups of tests
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Joel Savitz <jsavitz@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Shuah Khan <shuah@kernel.org>, Linux MM <linux-mm@kvack.org>,
        linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Jul 5, 2022 at 4:35 PM Andrew Morton <akpm@linux-foundation.org> wrote:
>
> On Tue,  5 Jul 2022 14:56:05 -0400 Joel Savitz <jsavitz@redhat.com> wrote:
>
> > Add the ability to run one or more groups of vm tests (specified
> > by the environment variable TEST_ITEMS). Preserve existing default
> > behavior of running all tests when TEST_ITEMS is empty or "default".
>
Hi Andrew,

> What is the reason for this?  What's the use case?

The current design of vm selftests is all-or-none. We'd like to be
able to selectively run these tests (We settled for selective groups
of tests rather than individual tests).

The main reason for doing this is our efforts to expand RedHats MM CI
testing. There are two use cases for these changes that relate to our
reasoning:
1) Our current CI has overlapping tests between LTP and vm selftests,
so we'd like a way to prevent running the same test in two places.
2) We'd like the ability to skip a test if it is determined to be
unstable or requires certain hardware requirements.

By adding this functionality we are really expanding what we are able
to do with the stock vm-selftests.

> And why via the environment rather than via commandline args?
Just a design choice I suppose. I'm sure Joel would be willing to
implement it as a cmdline arg if you'd prefer that approach.

Cheers,
-- Nico

