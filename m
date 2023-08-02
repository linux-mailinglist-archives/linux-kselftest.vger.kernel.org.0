Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A325376C17A
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Aug 2023 02:26:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231225AbjHBA0r (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 1 Aug 2023 20:26:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230159AbjHBA0q (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 1 Aug 2023 20:26:46 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD8262113
        for <linux-kselftest@vger.kernel.org>; Tue,  1 Aug 2023 17:26:45 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-686f94328a4so261606b3a.0
        for <linux-kselftest@vger.kernel.org>; Tue, 01 Aug 2023 17:26:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1690936005; x=1691540805;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ncHraoviZc3rMsglYeHEXiGJaPKUwsQ2j0eLs4ZTVeE=;
        b=R3UYo3wpgXgWXbhhdS+7cytaSoCT/qI6YRh811BRTzij/CB7G4G5cE+yeihxnWegTs
         vEhb34Ps7flQIOfysvRWZdZKjyqierWxL/QzK3jHbPYP1cOG/fdreanLhDcRJ5ELygMG
         H0rhTvQmNngRG2+qASYMWxFkHA6VtBqrbVH64=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690936005; x=1691540805;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ncHraoviZc3rMsglYeHEXiGJaPKUwsQ2j0eLs4ZTVeE=;
        b=fgvZek02WfuiBHFDrL0sWrTtISWoOzIZENQokDcNhf9HXo4P9qPmudpSC/rrRyGWkR
         b0TVtQyPn3tUFeB8yKXf7sOJdOLEpzj4JG+VI5JjwkIyaU1+UHSSMrMSJbgdzlcs8W6o
         P1SfWIU8LtpeuSzHA2aq9mLbL1nPf/K1otDkKN1YvXRw/tmp5NRMKmWG1gGvSSF9jzDG
         hgdJHraWYdk2sqMCLeZiJmdlfbYcyIzGYs83rFwXRU1W/nH2+T6+EzWhDwHqBZTPKwTO
         WKt//xteekoGRP8tn2E9O0SVPuexgrJFqnE7g1Ie3vtohURxG7h9VpY07/srPCjAU3Jj
         lYWA==
X-Gm-Message-State: ABy/qLa6xqDd3KYHpCrIFRyvJeYL4oiXU/VrTp4BzxDypJXPGoewm+cV
        5deygHgS8cGFczyq8kEeLfCojg==
X-Google-Smtp-Source: APBJJlF32qL/mI7cDAGBT/q8Fvj9Jh1MeZmPhhge7nH1COqcQqKkfK0BDXFwQZbWHLXguXTHHPQcCw==
X-Received: by 2002:a05:6a20:3d8a:b0:132:ce08:1e28 with SMTP id s10-20020a056a203d8a00b00132ce081e28mr20906787pzi.22.1690936005376;
        Tue, 01 Aug 2023 17:26:45 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id c21-20020aa78e15000000b0063b898b3502sm9840848pfr.153.2023.08.01.17.26.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Aug 2023 17:26:44 -0700 (PDT)
Date:   Tue, 1 Aug 2023 17:26:44 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Ricardo =?iso-8859-1?Q?Ca=F1uelo?= <ricardo.canuelo@collabora.com>
Cc:     kernel@collabora.com, shuah@kernel.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH] selftests/lkdtm: Disable CONFIG_UBSAN_TRAP in test config
Message-ID: <202308011724.C76E2B90@keescook>
References: <20230801094329.1878928-1-ricardo.canuelo@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230801094329.1878928-1-ricardo.canuelo@collabora.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Aug 01, 2023 at 11:43:29AM +0200, Ricardo Cañuelo wrote:
> The lkdtm selftest config fragment enables CONFIG_UBSAN_TRAP to make the
> ARRAY_BOUNDS test kill the calling process when an out-of-bound access
> is detected by UBSAN. However, after this [1] commit, UBSAN is triggered
> under many new scenarios that weren't detected before, such as in struct
> definitions with fixed-size trailing arrays used as flexible arrays. As
> a result, CONFIG_UBSAN_TRAP=y has become a very aggressive option to
> enable except for specific situations.

Yeah, that's fair. We need to actually get these issues reported and
TRAP doesn't help with that.

> 
> `make kselftest-merge` applies CONFIG_UBSAN_TRAP=y to the kernel config
> for all selftests, which makes many of them fail because of system hangs
> during boot.
> 
> This change removes the config option from the lkdtm kselftest and also
> the ARRAY_BOUNDS test to skip it rather than have it failing. If
> out-of-bound array accesses need to be checked, there's
> CONFIG_TEST_UBSAN for that.

I *think* instead, we can turn off TRAP but retain the ARRAY_BOUNDS
kselftest by looking for either WARN or TRAP results:

-ARRAY_BOUNDS
+ARRAY_BOUNDS call trace:|UBSAN: array-index-out-of-bounds

Can test that and send a v2?

-Kees

-- 
Kees Cook
