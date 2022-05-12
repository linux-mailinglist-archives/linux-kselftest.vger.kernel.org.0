Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97A4452556E
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 May 2022 21:13:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357911AbiELTN1 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 12 May 2022 15:13:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357897AbiELTN0 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 12 May 2022 15:13:26 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4721D1A0AF3
        for <linux-kselftest@vger.kernel.org>; Thu, 12 May 2022 12:13:23 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id dk23so12097046ejb.8
        for <linux-kselftest@vger.kernel.org>; Thu, 12 May 2022 12:13:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vuedgba30Don+8g7BBmGtQ0hkDbxYA+az5+QnS6Qsjw=;
        b=DIzeQRQ/qAVrXwyxtcFzM9hbNSXWZqhZgz8a4xI+O9mkJX+vTyKxnNMJUPkpBoQ6f7
         YOIq9XnUqRC2POGGXaFpj70M5JdedD2tSoiphS6+F7nBA96io3unIm28PTlZH7nzTGjl
         mkJwltZaE1d3AQcMRYkx+Y1xy/PwILa0wln1fl3kcjL7Bmg4ZtkiSadg0qi8ByZr2xOk
         65VNbJPlII/G0nKnoHtz01hzp/jXY35sHBp71+O7xGQ3x3rB+aLkI9tY91siT7CbGgng
         LeJ3pm9X//nj3QDci8Wtb6OhLjOqK9RWlJt4IejAEgF4vvrk8ZDeTzyS3RzIsEpf7Bx1
         5yuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vuedgba30Don+8g7BBmGtQ0hkDbxYA+az5+QnS6Qsjw=;
        b=zeVUaXX3ZxZ5zo5HuOGOvPa22nYPJBA8Ow4FkwHcINlMdWkuvWnECYeocVLVst9JEa
         igxAcGGkET9WUa9eOLBDH7pZmJqrD9nyIw/1cAGNJ0zgDpUAzEjPtHCyd+tCCWG/m4fC
         4gHWyDocsGSuakYF0aQRJCjo7BECi8bUtjYm5JUGoRiY7sTgLX0iWCKGjx4uZU2iHt9F
         enK0iUrengNVn3ZsQGzwymVz2GQSpkRttomQYUBlKwpwlHfxNwVGyLf0zlefItVhh+mW
         SbpyPzrXHsvc3r2mHiIMiL4rlQ//sS/zrsHM5SJOwM7EhdaaxCfiaOIeuKMJW0QIdzVh
         vreQ==
X-Gm-Message-State: AOAM530hmyN7unVhiv8XcMqQuaGAzUFxw+bp9YT0h67mn4ohHXRRJoRr
        MJVIEZznjHcgwqllKUhrXlCBHhfCfKqyobxEv4xx9w==
X-Google-Smtp-Source: ABdhPJxLlr+cjU4IkClCioRW6wr7jXKyxnOi1jUInafmHhiwdSd40Rhod3BBhzh/dPi3NbHLjUhRIaks4O0quULJlb4=
X-Received: by 2002:a17:906:8696:b0:6f3:a043:6ea7 with SMTP id
 g22-20020a170906869600b006f3a0436ea7mr1197718ejx.387.1652382801441; Thu, 12
 May 2022 12:13:21 -0700 (PDT)
MIME-Version: 1.0
References: <20220430045639.839186-1-davidgow@google.com>
In-Reply-To: <20220430045639.839186-1-davidgow@google.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Thu, 12 May 2022 15:13:10 -0400
Message-ID: <CAFd5g47GNFwFVmWoYQ5Tv7YeSp2vETs9BqfS21bRUW4XOqyFaw@mail.gmail.com>
Subject: Re: [PATCH] kunit: tool: Add list of all valid test configs on UML
To:     David Gow <davidgow@google.com>
Cc:     Daniel Latypov <dlatypov@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
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

On Sat, Apr 30, 2022 at 12:56 AM David Gow <davidgow@google.com> wrote:
>
> It's often desirable (particularly in test automation) to run as many
> tests as possible. This config enables all the tests which work as
> builtins under UML at present, increasing the total tests run from 156
> to 342 (not counting 36 'skipped' tests).
>
> They can be run with:
> ./tools/testing/kunit/kunit.py run
> --kunitconfig=./tools/testing/kunit/configs/all_tests_uml.config
>
> This acts as an in-between point between the KUNIT_ALL_TESTS config
> (which enables only tests whose dependencies are already enabled), and
> the kunit_tool --alltests option, which tries to use allyesconfig,
> taking a very long time to build and breaking very often.
>
> Signed-off-by: David Gow <davidgow@google.com>

Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
