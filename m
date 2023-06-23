Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A84673B1FC
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 Jun 2023 09:46:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230338AbjFWHqa (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 23 Jun 2023 03:46:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230132AbjFWHq2 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 23 Jun 2023 03:46:28 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 475102735
        for <linux-kselftest@vger.kernel.org>; Fri, 23 Jun 2023 00:46:06 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-98862e7e3e6so33886866b.0
        for <linux-kselftest@vger.kernel.org>; Fri, 23 Jun 2023 00:46:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20221208.gappssmtp.com; s=20221208; t=1687506364; x=1690098364;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+iQJZz9hEg89sqi4PWoni97EtVUqEhCuQI2ITf4HAXA=;
        b=2TvXFALf689o+kg1n/BoUwKWd/3XYQin0SBUbtKYKNgUhCzzbJ+zHnhiPm5dgZWZAx
         QOV/GJ86Rl2FDFDbDPni5ZM0BkL37FEMoYPwXMiER9Sh9mD5ES/THtN/j9IgbyCSFV3e
         ef8aWCcaO4aza0Hid7+CB9HASZE3Y9IV1lpJPLMqLGErRJVeEuvHVQ3AGNST32knIj/s
         zLsnBn3JqlZw10Xqokx03IWjwM4pAI9pZJx+J/CwDEu+M+drvk3uudoNTX7B0xdkf6x8
         yEqmKo6VvFbXwWM6U0zfiTfV68+g8Eait/IWtuqpT0BnIAUkejeY9cOZSOOQfHLly9Jk
         MwqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687506364; x=1690098364;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+iQJZz9hEg89sqi4PWoni97EtVUqEhCuQI2ITf4HAXA=;
        b=ajr2TXrRQpkzJTCI2Fuk8BSprxHEwdeGKThn2+pJ8Z56uZoE7TWZY3AqJbsEpSGOuP
         guiwdbg9uiJJNMBym+xxLXTJ7f7WCuY6ob0W/6JcMMWptFzZ+hcmx+X/M9UrdBwe18U7
         mWAMwHhvL4hnjflqG99XI781DOYyV/RG8jXxhrvx1Hwbc/bjTnvucgDxq+kB4cpCSh3T
         ndrsvNzNdClmuyheaOxv95+3CnmqduyFAgK42qWFrXou4yoOMGRJv7WjAbr3ScmKNttT
         8m6pBQkz+bpovjBn6kbzbZl7r3fLZG03uZ8zIMlFusslnd0fVNnI9gRvQ8HRgVrjY6VW
         NKiA==
X-Gm-Message-State: AC+VfDzdIxBNKJQllWtGYMEXgfkDJaWCztLWfgRCQvHmzwfpkYfmskn3
        pDwBniLULwMwnF+aPtxQ6rt1IbJQRQZKeFOD3ce5zw==
X-Google-Smtp-Source: ACHHUZ5Uu/KXy31dWeHa3Pa3sMiSVMIOiEa5B6VK+4dppa1hGkleBn/K+E+EPKZ82KnSXCt3aO8F+Q==
X-Received: by 2002:a17:907:94c8:b0:987:33c3:e288 with SMTP id dn8-20020a17090794c800b0098733c3e288mr17120210ejc.29.1687506364243;
        Fri, 23 Jun 2023 00:46:04 -0700 (PDT)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id l17-20020a170906939100b0096f67b55b0csm5596839ejx.115.2023.06.23.00.46.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jun 2023 00:46:03 -0700 (PDT)
Date:   Fri, 23 Jun 2023 09:46:02 +0200
From:   Jiri Pirko <jiri@resnulli.us>
To:     Sabrina Dubroca <sd@queasysnail.net>
Cc:     netdev@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net] selftests: rtnetlink: remove netdevsim device after
 ipsec offload test
Message-ID: <ZJVNutrYRNFBe33L@nanopsycho>
References: <e1cb94f4f82f4eca4a444feec4488a1323396357.1687466906.git.sd@queasysnail.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e1cb94f4f82f4eca4a444feec4488a1323396357.1687466906.git.sd@queasysnail.net>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Thu, Jun 22, 2023 at 11:03:34PM CEST, sd@queasysnail.net wrote:
>On systems where netdevsim is built-in or loaded before the test
>starts, kci_test_ipsec_offload doesn't remove the netdevsim device it
>created during the test.
>
>Fixes: e05b2d141fef ("netdevsim: move netdev creation/destruction to dev probe")
>Signed-off-by: Sabrina Dubroca <sd@queasysnail.net>

Reviewed-by: Jiri Pirko <jiri@nvidia.com>

Thanks!
