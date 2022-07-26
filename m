Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 531E0580FA8
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Jul 2022 11:15:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232807AbiGZJPe (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 26 Jul 2022 05:15:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231864AbiGZJPd (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 26 Jul 2022 05:15:33 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1A4819283;
        Tue, 26 Jul 2022 02:15:28 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id o20-20020a17090aac1400b001f2da729979so3106910pjq.0;
        Tue, 26 Jul 2022 02:15:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc;
        bh=0j/CpGXKe7sVMOBe2DZtsJr4T7C6tDvY9rvYNX7f95s=;
        b=OObUGvCKkozG5KjhKKozg1IFDbufiCE6rpQ/XUM+a49Ryd7XzIYC5t7zXK4+VK9a56
         mwyqqLOnanTZwWZsevvlwAD5DE6Fyi/0654TDNUGMfc+KItEKPEDHPcF/bGjBYqe/D+d
         CAbcPm8YcV1JMd92EWFD8O5U9PIpMy3XuQfhjV5LjHslduw+sLlAs5SYWD35Dv2Pg0+J
         VJmBK1gIk4vvmOZzkd/wz0oyQ0IvlR54o4G7rsohzqKEcVQXujxTQSTzRDZdcaH6a9sx
         mb0O7TjizfPBhuiy8M1NWxDbjvmGd2c5X6RU04f4vSTx8pSDlDUH//v9WyJM+dM4Rc42
         ThZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc;
        bh=0j/CpGXKe7sVMOBe2DZtsJr4T7C6tDvY9rvYNX7f95s=;
        b=Y45wH23+XRYChvCz8gipK29k8O7ECy7DbuAWBvJEcw78qEQ32R1rpbHk8dvqr0uARp
         ZlU13XpV2mHMa3mmX4dzhl96KtIGKjEwkUjEaHobw3ALIUYHOMJGPF4WHv2dw9ApD+Fy
         mID6+AQ8sDgjo3qoSwa6SUHAVwpGDp5HwLado/+Uvt95tUCixWMtISka+iD4O3mjgosF
         pKmqHG+nMc93kXrVb7NU9PBw6ObFxeZ1tEeysYB1VhM/6N0W2bk21uPHdZf721RDwPHW
         sUEEushsId4fNMkxium/ASpOxg547L2G+IH0vicS2JDU1LjqG9eVhuPWfoMcQixqocrA
         VmbQ==
X-Gm-Message-State: AJIora8UBg2HEFmiGiJ9VbgO2qgMEQq1BMYsBe6OO7ctITeAb+W5bhIR
        dakSINiNUliKw9a01VQxyWLEuGsOVKw=
X-Google-Smtp-Source: AGRyM1uwn5yVpn8Yv1zzdz0ddlbaY+6ubjzGIZTBo4yS39uc8sLi81/DhgUbozJtabPKK+hPN1Vcdg==
X-Received: by 2002:a17:90a:d983:b0:1f2:2d63:be98 with SMTP id d3-20020a17090ad98300b001f22d63be98mr18065804pjv.219.1658826928501;
        Tue, 26 Jul 2022 02:15:28 -0700 (PDT)
Received: from debian.me (subs32-116-206-28-51.three.co.id. [116.206.28.51])
        by smtp.gmail.com with ESMTPSA id iw17-20020a170903045100b0015e8d4eb26esm10831883plb.184.2022.07.26.02.15.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jul 2022 02:15:28 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id D72E9103B08; Tue, 26 Jul 2022 16:15:23 +0700 (WIB)
Date:   Tue, 26 Jul 2022 16:15:23 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Sadiya Kazi <sadiyakazi@google.com>
Cc:     brendanhiggins@google.com, davidgow@google.com,
        skhan@linuxfoundation.org, corbet@lwn.net, mairacanal@riseup.net,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel test robot <lkp@intel.com>,
        Daniel Latypov <dlatypov@google.com>
Subject: Re: [PATCH v4] Documentation: kunit: Add CLI args for kunit_tool
Message-ID: <Yt+wq+xo2Tp6oEF/@debian.me>
References: <20220726041250.1905521-1-sadiyakazi@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220726041250.1905521-1-sadiyakazi@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Jul 26, 2022 at 04:12:50AM +0000, Sadiya Kazi wrote:
> Some kunit_tool command line arguments are missing in run_wrapper.rst.
> Document them.
> 
> Reported-by: Bagas Sanjaya <bagasdotme@gmail.com>
> Reported-by: kernel test robot <lkp@intel.com>
> Reviewed-by: David Gow <davidgow@google.com>
> Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
> Reviewed-by: Daniel Latypov <dlatypov@google.com>
> Reviewed-by: Maíra Canal <mairacanal@riseup.net>
> Signed-off-by: Sadiya Kazi <sadiyakazi@google.com>

I think Reported-by should only be used when submitting patches that
fixes build warnings/failure pointed to the code that is already in the
tree (like mainline).

Otherwise, the documentation builds succesfully without new warnings.

Reviewed-by: Bagas Sanjaya <bagasdotme@gmail.com>
Tested-by: Bagas Sanjaya <bagasdotme@gmail.com>

-- 
An old man doll... just what I always wanted! - Clara
