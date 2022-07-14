Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 733BB57582D
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Jul 2022 01:51:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232445AbiGNXvn (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 14 Jul 2022 19:51:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbiGNXvm (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 14 Jul 2022 19:51:42 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CD126D9EB;
        Thu, 14 Jul 2022 16:51:41 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id a15so4267130pjs.0;
        Thu, 14 Jul 2022 16:51:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=WQOJ87cxhZVY+IyP6bEM7D5o/BRipLCrV6YOLHFhk1w=;
        b=IIMJ1246IIPKa4Fs/STJlOe4IyjgfiAckNmuhbjPtUIO1nj4eRzEmX0f/jDfkBJXM5
         r7E6CEGq5UqqbXoicOFChB8yFFa9MNdXKs7zON/jTEW7lvcVeAw4lQh/X1oRNTLeQzSW
         Wsf7d0XV+lcxH2oeQGXCXj4bOx+fHApevwf7BSbDKrVPLASQSRFeINMBHfI6T7lo1gwD
         tn8dxzX14KsS14Mo97QiTwIdJLrPCkzw1VC745ROPwvcond6xyH40n5ReE4NADUTbAse
         vAxo+f7u3jJ1gmPb2xJ/fw+RBT9GxVsEaPE/2hDyyg1iH/EhZ9g2L/pG4qg7HtaVF1gd
         0CqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to;
        bh=WQOJ87cxhZVY+IyP6bEM7D5o/BRipLCrV6YOLHFhk1w=;
        b=XIb9ELWtwHZCwszS/86xknNd39OaY2ezkluATFKCyUihqq97SVus9jpe1ZhJ7Y6yv+
         GjVXfixeWgg1+waxGYX7xbr0KFGj0aDaowE15o0eY3mq/cTnb7Sr+nRtIG/ZKr3A/RXQ
         4JzsxC9e6kqXTxpe8W4rvIA8O4SwpHmEhG5XzYd8F3Gpjm3CD7DF7ps6vlPCRHT4KTkh
         N6oNIDAPjQnIcP1+jlQ6KP+j0lMeO/Jkjz1FbM3lMqBZc7dd3XV31IivOA/AuaQB4Zrb
         BKkZP6vLqhe5JUgiWqMBF8AomXtBZIcutQ5U94T3NgteXd2mZEAqGc44/v4gZl83MmZ2
         uXZA==
X-Gm-Message-State: AJIora/0kBft/m03EZ1DiI8ElY6NQMiHGATbtAEdifLu/FDJsC1O9OJq
        vVgodr9fiug1BFopfjYfvoY=
X-Google-Smtp-Source: AGRyM1teLs417YHFJ/t2owHCD+vGs4Qr7DfmKbJT20i1kDWBwhWfbe5Bg5RlLbs0eGYr/5Q7QmTJjA==
X-Received: by 2002:a17:90b:19d3:b0:1f0:addf:8ff4 with SMTP id nm19-20020a17090b19d300b001f0addf8ff4mr8732227pjb.191.1657842700547;
        Thu, 14 Jul 2022 16:51:40 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id t3-20020a6549c3000000b00411acdb1625sm1857442pgs.92.2022.07.14.16.51.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jul 2022 16:51:38 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Thu, 14 Jul 2022 16:51:37 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     =?iso-8859-1?Q?Ma=EDra?= Canal <maira.canal@usp.br>
Cc:     Isabella Basso <isabbasso@riseup.net>, magalilemes00@gmail.com,
        tales.aparecida@gmail.com, mwen@igalia.com, andrealmeid@riseup.net,
        siqueirajordao@riseup.net, Trevor Woerner <twoerner@gmail.com>,
        leandro.ribeiro@collabora.com, n@nfraprado.net,
        Daniel Vetter <daniel@ffwll.ch>,
        Shuah Khan <skhan@linuxfoundation.org>,
        David Airlie <airlied@linux.ie>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        michal.winiarski@intel.com,
        Javier Martinez Canillas <javierm@redhat.com>,
        =?iso-8859-1?Q?Jos=E9_Exp=F3sito?= <jose.exposito89@gmail.com>,
        David Gow <davidgow@google.com>,
        Daniel Latypov <dlatypov@google.com>,
        brendanhiggins@google.com, kunit-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 4/9] drm: selftest: convert drm_format selftest to
 KUnit
Message-ID: <20220714235137.GA485839@roeck-us.net>
References: <20220708203052.236290-1-maira.canal@usp.br>
 <20220708203052.236290-5-maira.canal@usp.br>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220708203052.236290-5-maira.canal@usp.br>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Jul 08, 2022 at 05:30:47PM -0300, Maíra Canal wrote:
> Considering the current adoption of the KUnit framework, convert the
> DRM format selftest to the KUnit API.
> 
> Tested-by: David Gow <davidgow@google.com>
> Acked-by: Daniel Latypov <dlatypov@google.com>
> Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>
> Signed-off-by: Maíra Canal <maira.canal@usp.br>

This patch results in:

Building powerpc:allmodconfig ... failed
--------------
Error log:
drivers/gpu/drm/tests/drm_format_test.c: In function 'igt_check_drm_format_min_pitch':
drivers/gpu/drm/tests/drm_format_test.c:271:1: error: the frame size of 3712 bytes is larger than 2048 bytes

presumably due to function nesting.

Guenter
