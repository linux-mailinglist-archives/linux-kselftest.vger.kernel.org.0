Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D0374E9CC4
	for <lists+linux-kselftest@lfdr.de>; Mon, 28 Mar 2022 18:52:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244261AbiC1Qxq (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 28 Mar 2022 12:53:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244440AbiC1QxM (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 28 Mar 2022 12:53:12 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 627C15EBDD
        for <linux-kselftest@vger.kernel.org>; Mon, 28 Mar 2022 09:51:31 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id bi12so29999995ejb.3
        for <linux-kselftest@vger.kernel.org>; Mon, 28 Mar 2022 09:51:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TjNuhCXe+PjFnTXBHLrLoeoTTYDdDeH8ei+EheLHkDc=;
        b=MyfZrav6RgVjpKFdewxmvRPK3g8FVlWpFb0ATz57iua3B4pBl1QfVbGAhpJj+wif/X
         zTaSikLrHqFkPCcjkGeCg2uYN1eI+SzvtyKPbnerWds66SzTQYxlP4tvsakATAdmnvU6
         YPHyaWANcejF028m7vh50waXCYMhqqtAbmijQhm7hb+lVtsfKTnyrWWi47jlvP3Ux53D
         4yKpm1j5btuQDw53Iqud6mEVTKdXMZm09X1has8IrWks1DrRrOZwLduZ8vygERXf0dUN
         WWfAl4rn6WWHkw0/shVKhml2sHveGN6mTjNhMW9eZncM3wiza2Mn+LLb5Fz2NZWtOd6Z
         uJmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TjNuhCXe+PjFnTXBHLrLoeoTTYDdDeH8ei+EheLHkDc=;
        b=Or3gfYdr7NN40zZgKmiE4++ghqn7P5RiKZqHOet65N1HDvXNcBwCIpdYZFuKc09Jsm
         W9gRD25MgsVbpkqB3JapDZ4Y16Pd9WHnkktWileuyM/CuOWIZhcacWb5dxXm5gG55/cv
         5cHTZU19e4bDiS7gwY9AWtkE8We+AYd4QZWFoyVYqryR7wZSIP6HLsf6n+Z5g3s7bf/O
         XMF3zE5MTF3u8e+CVzBpxW6XQh9JhXDxE0BYzZcL9ilmlHNoV1AQv4PzV8UVJ88NVA4G
         J26Fu+qQUlj/le/Dg3jZuEO6Pfi8jlEKCIP6hGa1hSqFOdOAPQmeu48joUoC3uEn4R0N
         1MDA==
X-Gm-Message-State: AOAM5337RQhcHN+H74Dv+WhIRJ3kT0YZB3l2gIcT3weTXIfwOkrll3Dr
        K6uO8DyRaYVBstiuAjUEOEjT6l+Ftt5SpMivO9LyfQ==
X-Google-Smtp-Source: ABdhPJwQUeLnvUWh/kg8H2Rq1WHHdSozspFbhwqXozAWN0gl0KPOFdMJ3F7LoGB2Ee9TPuaDSOTzNmMBumWtUgfgTfU=
X-Received: by 2002:a17:907:c018:b0:6df:e31b:d912 with SMTP id
 ss24-20020a170907c01800b006dfe31bd912mr28886127ejc.196.1648486286570; Mon, 28
 Mar 2022 09:51:26 -0700 (PDT)
MIME-Version: 1.0
References: <20220326054414.637293-1-davidgow@google.com>
In-Reply-To: <20220326054414.637293-1-davidgow@google.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Mon, 28 Mar 2022 12:51:15 -0400
Message-ID: <CAFd5g44qS4Qy2zBvGK-OszKnNC22daC63SREvL1Noiu5dKeP-w@mail.gmail.com>
Subject: Re: [PATCH] Documentation: kunit: Fix cross-referencing warnings
To:     David Gow <davidgow@google.com>
Cc:     Jonathan Corbet <corbet@lwn.net>, Marco Elver <elver@google.com>,
        Daniel Latypov <dlatypov@google.com>,
        skhan@linuxfoundation.org, kunit-dev@googlegroups.com,
        linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
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

On Sat, Mar 26, 2022 at 1:45 AM David Gow <davidgow@google.com> wrote:
>
> The Architecture chapter of the KUnit documentation tried to include
> copies of the kernel-doc for a couple of things, despite these already
> existing in the API documentation. This lead to some warnings:
>
> architecture:31: ./include/kunit/test.h:3: WARNING: Duplicate C declaration, also defined at dev-tools/kunit/api/test:66.
> Declaration is '.. c:struct:: kunit_case'.
> architecture:163: ./include/kunit/test.h:1217: WARNING: Duplicate C declaration, also defined at dev-tools/kunit/api/test:1217.
> Declaration is '.. c:macro:: KUNIT_ARRAY_PARAM'.
> architecture.rst:3: WARNING: Duplicate C declaration, also defined at dev-tools/kunit/api/test:66.
> Declaration is '.. c:struct:: kunit_case'.
> architecture.rst:1217: WARNING: Duplicate C declaration, also defined at dev-tools/kunit/api/test:1217.
> Declaration is '.. c:macro:: KUNIT_ARRAY_PARAM'.
>
> Get rid of these, and cleanup the mentions of the struct and macro in
> question so that sphinx generates a link to the existing copy of the
> documentation in the api/test document.
>
> Fixes: bc145b370c ("Documentation: KUnit: Added KUnit Architecture")
> Signed-off-by: David Gow <davidgow@google.com>

Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
Tested-by: Brendan Higgins <brendanhiggins@google.com>
