Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3ED26D35A4
	for <lists+linux-kselftest@lfdr.de>; Sun,  2 Apr 2023 07:47:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230113AbjDBFrg (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 2 Apr 2023 01:47:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjDBFrf (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 2 Apr 2023 01:47:35 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33C00448D;
        Sat,  1 Apr 2023 22:47:34 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id ix20so25185899plb.3;
        Sat, 01 Apr 2023 22:47:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680414453;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=I1Ip6H2C/SYRXcAheTsObvc2FbSTd1j6J7uDiWmAyq4=;
        b=gbOMl9Mq3LAbU0CJwPfTdmp52OVMO0usJ7HHRUWFmZliv5CsZZsWy62ZqMW39dnPPa
         D0rZyuVbHm4DNrUHmS//p+VsigfRz2nUOmlaOWcBVK1zfv/H4BLnDLjEPF9S22aR4BXS
         qVKI3qUm/2R8dGaamoBDJTor/zSza+JiXzI5cuEas/DWODlnx5Ln7lF4LFcCqCQW1tTU
         nqPECLt9Ut/R56ohmvm/XLFRSV+zVDtgt6lMLU3MudpbXXLa82evKhiD4JthnLnUanZ2
         6n/GYRvbNEjMzISHhaD7tS/K9bguUEAyInFN7EaI/+MumsH8FD2kuhefEF7QU5fcErHJ
         BE7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680414453;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I1Ip6H2C/SYRXcAheTsObvc2FbSTd1j6J7uDiWmAyq4=;
        b=GxwPMHYP5h+dJsOxfww1j9UVE96WcR6nhM9r/RAn0OJgUWYWjQMSrXzK9ebuljMw+E
         EaJzsX6j/apn6rsfxbNI/v6xzSsFCOras00pgELoiq5ppePa12OKqaBkWenuhjQOam3M
         Wn0AU8kDCYAyHM+QMNV8lxY7G6wUUnZt+/KGlgg3fuxmhocYIZKPA5zD3Mwb3JBegfH2
         LZn1J2Jjufhr8sLypmGSnbr0f8/t06vpYK8/jNzoTqun7dGljZGZNqc6jye/xpV9EpOU
         DcBXGVdODi6TjQ+hYdI31SVzV0Kk+QvTWsDIUyi94+X02BkknpocXqAtR7250mCEQgAm
         l6mw==
X-Gm-Message-State: AAQBX9drWcd1BEXLkK0CyjJGyzmWkOPD64ea988xSew5mMDVKEJpI0vX
        nl1PHrf1GCMgnHQEuGyEBcg=
X-Google-Smtp-Source: AKy350bNJXAUKZ4vbFeo52akfFyQRnzwCqGq8HRMK70EoXBMZPpZX0Nv0Cskg9Otz+EhKcFvKZdBZQ==
X-Received: by 2002:a17:902:d101:b0:19e:7b09:bd4d with SMTP id w1-20020a170902d10100b0019e7b09bd4dmr27098606plw.47.1680414453558;
        Sat, 01 Apr 2023 22:47:33 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:9a1d:5e0:d8f3:bc01])
        by smtp.gmail.com with ESMTPSA id jo17-20020a170903055100b001964c8164aasm4188348plb.129.2023.04.01.22.47.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Apr 2023 22:47:32 -0700 (PDT)
Date:   Sat, 1 Apr 2023 22:47:29 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Javier Martinez Canillas <javierm@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        Enric Balletbo i Serra <eballetbo@redhat.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        linux-kselftest@vger.kernel.org,
        =?iso-8859-1?Q?Ma=EDra?= Canal <mcanal@igalia.com>,
        David Gow <davidgow@google.com>,
        Daniel Latypov <dlatypov@google.com>,
        kunit-dev@googlegroups.com, Maxime Ripard <maxime@cerno.tech>,
        linux-input@vger.kernel.org
Subject: Re: [PATCH v2] Input: Add KUnit tests for some of the input core
 helper functions
Message-ID: <ZCkW8bFjy0GA0C34@google.com>
References: <20230330081831.2291351-1-javierm@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230330081831.2291351-1-javierm@redhat.com>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Mar 30, 2023 at 10:18:31AM +0200, Javier Martinez Canillas wrote:
> The input subsystem doesn't currently have any unit tests, let's add a
> CONFIG_INPUT_KUNIT_TEST option that builds a test suite to be executed
> with the KUnit test infrastructure.
> 
> For now, only three tests were added for some of the input core helper
> functions that are trivial to test:
> 
>   * input_test_polling: set/get poll interval and set-up a poll handler.
> 
>   * input_test_timestamp: set/get input event timestamps.
> 
>   * input_test_match_device_id: match a device by bus, vendor, product,
>                                 version and events capable of handling.
> 
> But having the minimal KUnit support allows to add more tests and suites
> as follow-up changes. The tests can be run with the following command:
> 
>   $ ./tools/testing/kunit/kunit.py run --kunitconfig=drivers/input/tests/
> 
> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
> Tested-by: Enric Balletbo i Serra <eballetbo@redhat.com>

Applied, thank you.

-- 
Dmitry
