Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AE0B63883F
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Nov 2022 12:06:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229909AbiKYLGb (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 25 Nov 2022 06:06:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbiKYLGa (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 25 Nov 2022 06:06:30 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 944204D5E3
        for <linux-kselftest@vger.kernel.org>; Fri, 25 Nov 2022 03:05:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669374334;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Kvo3ByqVNYtl4Gj5V4V1EtKWGChjY02VeHw9i+vXN5I=;
        b=R9blsbwbJ1QzGDChFtjT5iFse/7SI6fbWBkM+bZNXgAc4PgkUpZ7E1eXpbHeV7PshiyUku
        3tTZlkK8H2vuDV7v4jq0vIXNJrwHoJjkffTvQs2QsvEZTZbfOJkC559PAwYn0dLf5VI1/J
        9HLEYYP7TOBgEv+lT25NIyXtkMFQDsE=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-131-ie9fhN1FMzG4vOcfaVa-fw-1; Fri, 25 Nov 2022 06:05:33 -0500
X-MC-Unique: ie9fhN1FMzG4vOcfaVa-fw-1
Received: by mail-wm1-f71.google.com with SMTP id 1-20020a05600c028100b003cf7833293cso4046645wmk.3
        for <linux-kselftest@vger.kernel.org>; Fri, 25 Nov 2022 03:05:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Kvo3ByqVNYtl4Gj5V4V1EtKWGChjY02VeHw9i+vXN5I=;
        b=o3hnyw+Ztr9Bn5BLrNBHmno1EvZNkCUu5I/OHJU65w04bTt+PFO/52wQnDvtYTTS3h
         Wl4BiQ6hpUte59/4mRT4QzAZnr0J7MAeXfFjaUTFCAD5fAZBc3cmjrqHJgGiumIbjvdq
         FzwW8NmMdBrbijz2MlQ4w596cfil/rG7TVYMQhrkNSY2qnLAnFemo5RT/k5g3CJxK6+w
         TT9drG8xRHHKQD6ZfOhhUs82vh4ayRztQg1FNc+4AP1YNdAaDfDv4ZSavImKQp0xu8TT
         H9QqT8KAuU6q7KMAqFxh7ZLai6bdu4TFZxXUCHsfHiGioovuJZg+7ozoRamRrFbOgoIq
         mNAw==
X-Gm-Message-State: ANoB5pnp0t4EndHhZ0E9rc796AbxxNREnUHnFFINEYvT9t+8KlLp+faF
        Zo1JBaAmDU6oeB6mqFaF+87KA8qspznWWx2QP7e4AAjAiXrIdjknOdUwe9zpQ+JN6A7SgEYv6xM
        jIDAN2LsHQsAaEll55cQ7aAypsI0U
X-Received: by 2002:adf:ce05:0:b0:241:ea29:fa06 with SMTP id p5-20020adfce05000000b00241ea29fa06mr8120168wrn.594.1669374332184;
        Fri, 25 Nov 2022 03:05:32 -0800 (PST)
X-Google-Smtp-Source: AA0mqf6wTdp2+VuVoE5mvN2PyA3RkmkpVRnCk9tCcFb4MGlJIpqCV6lnFcIqScH72xr3oR/swXwGWw==
X-Received: by 2002:adf:ce05:0:b0:241:ea29:fa06 with SMTP id p5-20020adfce05000000b00241ea29fa06mr8120136wrn.594.1669374331867;
        Fri, 25 Nov 2022 03:05:31 -0800 (PST)
Received: from [192.168.1.130] (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id f13-20020a05600c4e8d00b003c6c182bef9sm11765978wmq.36.2022.11.25.03.05.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Nov 2022 03:05:30 -0800 (PST)
Message-ID: <0c5c0fa9-7223-2855-04e8-5ce264b873e6@redhat.com>
Date:   Fri, 25 Nov 2022 12:05:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH 13/24] drm/vc4: kms: Constify the HVS old/new state
 helpers
Content-Language: en-US
To:     Maxime Ripard <maxime@cerno.tech>,
        Maxime Ripard <mripard@kernel.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@gmail.com>,
        Thomas Zimmermann <tzimmermann@suse.de>
Cc:     David Gow <davidgow@google.com>, linaro-mm-sig@lists.linaro.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kselftest@vger.kernel.org,
        =?UTF-8?Q?Ma=c3=adra_Canal?= <mairacanal@riseup.net>,
        linux-media@vger.kernel.org, kunit-dev@googlegroups.com,
        dri-devel@lists.freedesktop.org,
        Brendan Higgins <brendan.higgins@linux.dev>,
        linux-kernel@vger.kernel.org,
        Dave Stevenson <dave.stevenson@raspberrypi.com>
References: <20221123-rpi-kunit-tests-v1-0-051a0bb60a16@cerno.tech>
 <20221123-rpi-kunit-tests-v1-13-051a0bb60a16@cerno.tech>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <20221123-rpi-kunit-tests-v1-13-051a0bb60a16@cerno.tech>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 11/23/22 16:25, Maxime Ripard wrote:
> The vc4_hvs_get_(old|new)_global_state functions don't modify the
> drm_atomic_state passed as an argument, so let's make it const.
> 
> Signed-off-by: Maxime Ripard <maxime@cerno.tech>
> ---

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

