Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BE9963D1D5
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Nov 2022 10:29:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233224AbiK3J3A (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 30 Nov 2022 04:29:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233349AbiK3J27 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 30 Nov 2022 04:28:59 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C77A237231
        for <linux-kselftest@vger.kernel.org>; Wed, 30 Nov 2022 01:27:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669800476;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Zpmq/XpiWXbMOZEg66Zy7jVIb78OWdpjdWyyx9Qsyt0=;
        b=gKaEgE7SSHttqzJN8lMisT51+bpYyc1S9D31ehv/MSir8kheumjuYJdKYcMwLQ3Sai35K6
        i+IZSz84KfoAio2/yMFSuIXt896LQtLG4k3JDsEZK383LwhQ59fRBU9XkEy/5c2rfeSD91
        Uglutv45Pko5GX4FXxrI3od21ULxkVg=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-659-3no2mnttP-29uwbPTfKzAA-1; Wed, 30 Nov 2022 04:27:54 -0500
X-MC-Unique: 3no2mnttP-29uwbPTfKzAA-1
Received: by mail-wr1-f71.google.com with SMTP id l9-20020adfa389000000b00241f907e102so3342034wrb.8
        for <linux-kselftest@vger.kernel.org>; Wed, 30 Nov 2022 01:27:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Zpmq/XpiWXbMOZEg66Zy7jVIb78OWdpjdWyyx9Qsyt0=;
        b=B/2Tpi87kS1WF/D4ZNq5pBohQ6gljjbUlU37AVkLiqrQpR9HvxVTzXz5hf9Ij+cvfG
         +QdlWlxsbca5jpIgPX5ceAIhbLQERl2vkyrJjZsP+nRlv27ne6qbht27J/CKWIsX9LoW
         5NMLkkxAAMFqGK6NrP+7+g1O1fknskJcq5hCsdokYgKIZNgCWl0u2xdgfXKOXc06vB/w
         ZEgxd+QsCOsOYY8AqTjnTiMI7DRIaPhjSD8AraJ6laQ/4yCH0bqblHuC4aUyagzfMIgC
         cZDkOP5BbtrzMY2ILTkBB0EnZgEa3Mfc6MLa7DS3R6LA4t0LabD29VHaaAO+J46CgFYn
         2EjA==
X-Gm-Message-State: ANoB5pmkEAR36S4bjkaRkYU/RhqCKRW+H1FchvQBYOCbEPAyl01sSLzR
        cVC/bvBgSnH13lv/RT+tOgOMKvPbgHNusy3NaLt3p61DChfYgDZsHMEq9f7WkW5O4irT7nQJ7hw
        ulIWrWL1ltA7o/L8YgWArEwzd5hyI
X-Received: by 2002:a05:600c:3548:b0:3d0:4776:7b73 with SMTP id i8-20020a05600c354800b003d047767b73mr18743918wmq.40.1669800473518;
        Wed, 30 Nov 2022 01:27:53 -0800 (PST)
X-Google-Smtp-Source: AA0mqf5lMQdNez6CG3ydcQTzf9gZFREx6F1ll3xRE649QPAQacBdUj+444faNh8sCrwOukxHZKgLEw==
X-Received: by 2002:a05:600c:3548:b0:3d0:4776:7b73 with SMTP id i8-20020a05600c354800b003d047767b73mr18743910wmq.40.1669800473261;
        Wed, 30 Nov 2022 01:27:53 -0800 (PST)
Received: from [192.168.1.130] (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id n187-20020a1ca4c4000000b003d005aab31asm1684955wme.40.2022.11.30.01.27.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Nov 2022 01:27:52 -0800 (PST)
Message-ID: <d2e3752d-ce25-2f79-7022-fc1f4cfacc07@redhat.com>
Date:   Wed, 30 Nov 2022 10:27:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH v2 09/17] drm/tests: helpers: Allow to pass a custom
 drm_driver
Content-Language: en-US
To:     Maxime Ripard <maxime@cerno.tech>, Daniel Vetter <daniel@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        David Airlie <airlied@gmail.com>,
        Thomas Zimmermann <tzimmermann@suse.de>
Cc:     dri-devel@lists.freedesktop.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        kunit-dev@googlegroups.com, linux-media@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linaro-mm-sig@lists.linaro.org,
        Brendan Higgins <brendan.higgins@linux.dev>,
        =?UTF-8?Q?Ma=c3=adra_Canal?= <mairacanal@riseup.net>,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        linux-kernel@vger.kernel.org, David Gow <davidgow@google.com>
References: <20221123-rpi-kunit-tests-v2-0-efe5ed518b63@cerno.tech>
 <20221123-rpi-kunit-tests-v2-9-efe5ed518b63@cerno.tech>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <20221123-rpi-kunit-tests-v2-9-efe5ed518b63@cerno.tech>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 11/28/22 15:53, Maxime Ripard wrote:
> Some tests will need to provide their own drm_driver instead of relying
> on the dumb one in the helpers, so let's create a helper that allows to
> do so.
> 
> Signed-off-by: Maxime Ripard <maxime@cerno.tech>
> ---

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

