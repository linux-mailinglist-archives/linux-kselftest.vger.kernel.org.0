Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B73A589344
	for <lists+linux-kselftest@lfdr.de>; Wed,  3 Aug 2022 22:32:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237799AbiHCUcb (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 3 Aug 2022 16:32:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230499AbiHCUca (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 3 Aug 2022 16:32:30 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BD0D5B7AF
        for <linux-kselftest@vger.kernel.org>; Wed,  3 Aug 2022 13:32:27 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id m8so22830569edd.9
        for <linux-kselftest@vger.kernel.org>; Wed, 03 Aug 2022 13:32:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=f0bwgO5Y6DZvlx+aNQfiCPBi+5cjtr/D/YquyyJnj2Y=;
        b=YlLbkAWLnaGvgbUZknMUXGio9T544H9Q8guK7U9X3g5XNnPDRkYIs8s62FnCLUOTFL
         tXtP5R1mN4sIJqQiBO6t1CDgfdrsvNoSiVd9NbyQ3tRMGy4tvCoaHwCDHn0LFQlVwFIl
         y02noIyhQE/HQo3DM0vEUSn4eAdmq+fISCuvNApGaODeclvuCo9ynWDnK9cicFOtPKc1
         h8UN9z2fsIBphM1RGy/06PXlMIJncsKRMoPGwl229Q1+yOkKT2nm1tMvswHWFTOtbRB6
         fqgTfJC4t3G+TXzQm/sDNF5HFnsZJzyUr2SOFbdHW6X5EQqscyriJ+r+vSIAmRKnSe0O
         ghrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=f0bwgO5Y6DZvlx+aNQfiCPBi+5cjtr/D/YquyyJnj2Y=;
        b=HXtiZunHaJK/AN41sadD/yrFts510SgRoVKcPaA+1tVnRn/aYWoYjMyx5S49kVHHWG
         xu/d17mn3OSKlaphPrMmFbv/LzLF3sg6DIjanMyG6k1TE2UFH8mtSvvn+JoqsbDk9Y6D
         1bnTNmdq5FMOzUQZC/LaMAtk++k58Y5LbOsbHjE33EiZ1PVzw8T+a5dCxy/VFH5VfCOY
         y3rz2YL/+tESOaa/kBNEKoTTZj4F9bc8AP4U71yWsW7g7ex3CuRF6wQAGftjq/GU/JVf
         S22veph+F0MlvOERJhEcM8dwIUF6tVnmHNILTmo8Izp7kIH0POISO+gtk3g1UsvmUKGC
         LREg==
X-Gm-Message-State: ACgBeo14MNGzCyyeblQfcglXMNSLF2XGwJFHStOiQH98KzMLqmnDSeYO
        Dpvh3h0+Ak2ENA466yjFEY2uVeoboJvi1yaiS/ZNGw==
X-Google-Smtp-Source: AA6agR6HWU92GtJAYExC2AMgER8UwS9Iax4Ao3eTMs6yxLQvwgm+Tsb/m5yFI+dWOCBmPKO2p6CvihXc/q25NTwQfVo=
X-Received: by 2002:a05:6402:4302:b0:43e:18c7:e003 with SMTP id
 m2-20020a056402430200b0043e18c7e003mr7574346edc.198.1659558746011; Wed, 03
 Aug 2022 13:32:26 -0700 (PDT)
MIME-Version: 1.0
References: <20220713005221.1926290-1-davidgow@google.com>
In-Reply-To: <20220713005221.1926290-1-davidgow@google.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Wed, 3 Aug 2022 16:32:14 -0400
Message-ID: <CAFd5g46zd2wU6L1LUmxeS=adpukPyoD65yfopMeQCMpt9iYL0Q@mail.gmail.com>
Subject: Re: [PATCH] module: kunit: Load .kunit_test_suites section when CONFIG_KUNIT=m
To:     David Gow <davidgow@google.com>
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        Daniel Latypov <dlatypov@google.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Jeremy Kerr <jk@codeconstruct.com.au>,
        linux-modules@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
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

On Tue, Jul 12, 2022 at 8:52 PM David Gow <davidgow@google.com> wrote:
>
> The new KUnit module handling has KUnit test suites listed in a
> .kunit_test_suites section of each module. This should be loaded when
> the module is, but at the moment this only happens if KUnit is built-in.
>
> Also load this when KUnit is enabled as a module: it'll not be usable
> unless KUnit is loaded, but such modules are likely to depend on KUnit
> anyway, so it's unlikely to ever be loaded needlessly.
>
> Fixes: 3d6e44623841 ("kunit: unify module and builtin suite definitions")
> Signed-off-by: David Gow <davidgow@google.com>

Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
