Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30789575873
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Jul 2022 02:05:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241076AbiGOAFB (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 14 Jul 2022 20:05:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241053AbiGOAFA (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 14 Jul 2022 20:05:00 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16B6073594;
        Thu, 14 Jul 2022 17:05:00 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id g4so3002662pgc.1;
        Thu, 14 Jul 2022 17:05:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=aLkKRaOcJkecC7a7hCUl2f3zvdxWOhT4lQJMyspC0FM=;
        b=IqeRqPZ3qF8cGKCO52T4NT7b0KClEh8Mtu298guXjrnlWQAtq0lDeurmiocTHaLH77
         FFwBhHmHZpa8IhF6c5ZBXzSpG+IQpozgVAyYpbYVpHUhPW6pcfLRkxkNdjA3WP8q6si8
         jU91uyXqS6KOTRFDGmFoaU91W+yPsnbsRnCXNFMCAZTxTHoPHyjMm5cfo3S873x/p90k
         FYgD90AeidbGiba/MSFxzd/hKmJpROhaF/CvP5C/jUv8/40lVT2wIxFa/ixlFBpJb1h3
         662CpB1q40lEoqvNRNcZ9W7TYJAbIWVXaBzs4oh4z65c4wUATKcvCoNiNhqMzHOXeOUy
         W1JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to;
        bh=aLkKRaOcJkecC7a7hCUl2f3zvdxWOhT4lQJMyspC0FM=;
        b=PrAQ4fJBiGgkNoBp2yJvlsQBpTj4UsewmD8uKg8ms9ktJihbsNoi+fqZ+FUgRuLBw/
         qKr8EOfGCxK73LB/UxKOkjIUM7gHOyvHQO38LfqZkWdMoweZkQjcBKuVFLHk55pZ5lkF
         PxNCzTTxRbwD1ffQkDe+nMrY6YCvqvyAfVUmG51CwPXtpAXzE8PR3IFTPB0kIq5bR0HA
         541NSuzUhnWeQX9SIy2aIFFfGLL2CG4DnTnT4kg99Prd9ABnvOjJGLJ+z/3VoU6NNBsC
         MWJw3r/GrQE4jQYra5w5BrS0BlH6Puw9w0ci51Ergc9FVbV3Pvylpeh1cXnPZz+0OHbh
         9/Vg==
X-Gm-Message-State: AJIora8qboCtM8Neh36wbctJH3nEeN1LG5ZCu31qpyKjpMrDh3tiGYvk
        FsNS/iTQaxv7I+2VdRbgjZM=
X-Google-Smtp-Source: AGRyM1txesrCDgR42eBBij0RG2Z8x5Rlh9hy1SdbxF1Y4yW+++AjNOqM6ckBYKqRJg5/k6yZszigMQ==
X-Received: by 2002:a05:6a00:198f:b0:52a:dc25:cc78 with SMTP id d15-20020a056a00198f00b0052adc25cc78mr10815233pfl.20.1657843499626;
        Thu, 14 Jul 2022 17:04:59 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id g30-20020aa79dde000000b005251b9102dbsm2355500pfq.144.2022.07.14.17.04.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jul 2022 17:04:59 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Thu, 14 Jul 2022 17:04:58 -0700
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
Message-ID: <20220715000458.GA537048@roeck-us.net>
References: <20220708203052.236290-1-maira.canal@usp.br>
 <20220708203052.236290-5-maira.canal@usp.br>
 <20220714235137.GA485839@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220714235137.GA485839@roeck-us.net>
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

On Thu, Jul 14, 2022 at 04:51:40PM -0700, Guenter Roeck wrote:
> On Fri, Jul 08, 2022 at 05:30:47PM -0300, Maíra Canal wrote:
> > Considering the current adoption of the KUnit framework, convert the
> > DRM format selftest to the KUnit API.
> > 
> > Tested-by: David Gow <davidgow@google.com>
> > Acked-by: Daniel Latypov <dlatypov@google.com>
> > Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>
> > Signed-off-by: Maíra Canal <maira.canal@usp.br>
> 
> This patch results in:
> 
> Building powerpc:allmodconfig ... failed
> --------------
> Error log:
> drivers/gpu/drm/tests/drm_format_test.c: In function 'igt_check_drm_format_min_pitch':
> drivers/gpu/drm/tests/drm_format_test.c:271:1: error: the frame size of 3712 bytes is larger than 2048 bytes
> 

Also seen with i386:allyesconfig:

drivers/gpu/drm/tests/drm_format_test.c: In function 'igt_check_drm_format_min_pitch':
drivers/gpu/drm/tests/drm_format_test.c:271:1: error: the frame size of 2572 bytes is larger than 2048 bytes

Guenter
