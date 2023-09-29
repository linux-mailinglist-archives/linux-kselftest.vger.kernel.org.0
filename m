Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70B497B29F6
	for <lists+linux-kselftest@lfdr.de>; Fri, 29 Sep 2023 02:48:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232366AbjI2As2 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 28 Sep 2023 20:48:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231880AbjI2As0 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 28 Sep 2023 20:48:26 -0400
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9A13139
        for <linux-kselftest@vger.kernel.org>; Thu, 28 Sep 2023 17:48:24 -0700 (PDT)
Received: by mail-qk1-x735.google.com with SMTP id af79cd13be357-7741bffd123so838253585a.0
        for <linux-kselftest@vger.kernel.org>; Thu, 28 Sep 2023 17:48:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1695948504; x=1696553304; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=iXnFgtnhV35/5nraOkVV+b+6GuFhRtwpj0ASChSU/YM=;
        b=ALTONi2r10C1tLFqLVzhzodgP0OhBfUi3t0DeVZ915RU8AFcZvjfIF1uAU1R0MFG5p
         MmoYx2Jqj6ujfcwgREf6HCobJ3RLt7R3k/AkRyOftwUnYDx0ttYjAnKND8j6H3DM7/VL
         AlyjxQPFl1LUZ/O7S0oRlPUU7tqWrCMoxCqWA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695948504; x=1696553304;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iXnFgtnhV35/5nraOkVV+b+6GuFhRtwpj0ASChSU/YM=;
        b=tBLNE9vkemodiGNnqQrDgwzx2hmUFFJf8RuyYlD++PJC2I+WlI4zXoogHvyM45JayQ
         CROqIFOSOpye6KfLVakeLppj09QdcxPh92cGrjRvmqBfxPGPTBGh0gRe3Fo7LAciLdP/
         Rira1SfDfx8Temqm8spAJsCHJJLSRTDlbfE6Hfn1USjimk4Yd9uqa649c3xavyQjgUcK
         ZNvz5L7cA4R0oULoHe6fXXQ1+JkKr0TIYiTdb8rE2kMUMa3VQT1BljVvs2czZmXfByEc
         ph4PE85Jroz3mnjHiJAm1jB6UJpCbPEYCnpeNseA8R4H222rYWtTKEVgBx4TYNFXxfpd
         aBQQ==
X-Gm-Message-State: AOJu0YxmLvqBUNAzMYI7TxxJs2OZure8ADVp904B50URtb31rNLK4nMN
        nLaZ3JkD9SYloPLz0V4PDujX7KcSOXk9grup0FQ=
X-Google-Smtp-Source: AGHT+IE83wxkVeKmbXMfPZtwhbMZP6G2xuz6158Pb6qsN4X25QL/jHQ9mWomvJzOpwl0T2tBq93Mbw==
X-Received: by 2002:a05:620a:893:b0:773:eeb1:ed1 with SMTP id b19-20020a05620a089300b00773eeb10ed1mr2724234qka.51.1695948503850;
        Thu, 28 Sep 2023 17:48:23 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id j26-20020aa7801a000000b0068c10187dc3sm13893826pfi.168.2023.09.28.17.48.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Sep 2023 17:48:23 -0700 (PDT)
Date:   Thu, 28 Sep 2023 17:48:22 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     Shuah Khan <shuah@kernel.org>,
        Eric Biederman <ebiederm@xmission.com>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH 1/2] kselftest: Add a ksft_perror() helper
Message-ID: <202309281747.594B3352@keescook>
References: <20230928-ktap-exec-v1-0-1013a2db0426@kernel.org>
 <20230928-ktap-exec-v1-1-1013a2db0426@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230928-ktap-exec-v1-1-1013a2db0426@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Sep 28, 2023 at 04:38:11PM +0200, Mark Brown wrote:
> The standard library perror() function provides a convenient way to print
> an error message based on the current errno but this doesn't play nicely
> with KTAP output. Provide a helper which does an equivalent thing in a KTAP
> compatible format.
> 
> nolibc doesn't have a strerror() and adding the table of strings required
> doesn't seem like a good fit for what it's trying to do so when we're using
> that only print the errno.
> 
> Signed-off-by: Mark Brown <broonie@kernel.org>

Oh, interesting... what environment ends up without strerror()?

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
