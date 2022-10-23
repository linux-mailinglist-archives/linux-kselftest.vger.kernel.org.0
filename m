Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB8C7609339
	for <lists+linux-kselftest@lfdr.de>; Sun, 23 Oct 2022 15:08:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230043AbiJWNIN (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 23 Oct 2022 09:08:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229707AbiJWNIM (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 23 Oct 2022 09:08:12 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C47C36DCE;
        Sun, 23 Oct 2022 06:08:11 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id q1so6537250pgl.11;
        Sun, 23 Oct 2022 06:08:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+l0QpWjgbpwI354rKJV/rkqR6xzz5YmulbQglgXlqwo=;
        b=PVeitBNC7+FP13r/Q8oZgE7n5XjweMXdzZRvqXkdQ1tefjnYMbiQNPxAnLRgHZVhXS
         MW9bzLkJzVrp8xTaGEp+2ZZStMXfi1Vm6hfvVaFYTikAJOAD6DSXhcrT5ua8NmghL5y3
         XTaAVfbHW0zwwVPif6Gxv/MY4ZI8tiAYPsmzKmVZ1MIxcvDyh4OB1m+IvjED96vCHpap
         LITI793KCuwekLjPV9awffKWERzvX9MUWOavAJqWDbJF4m47axorAp5ReTqFDmWlHNuv
         qgy2JsWORwegruBe4IDj0ihK01d8nSiEW5B8EvRMGN1V0PdDXZGFfz3ZDO3H6pHvujR8
         ww1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+l0QpWjgbpwI354rKJV/rkqR6xzz5YmulbQglgXlqwo=;
        b=IytCvCEE1g0iRBkN1eWXh4/BplzNaqDRDH6WV26ja2Jio7XgEYCgImqcihxR0YonIR
         m5Q/o3Qvt0wZUXfl8rvWSzZ5L1jNz+/TIW0oxTKVzRauM2dgTGUfV5QaLnTexAMWQVER
         sP8KPLUz4u+Hljz+pTQ1k0eRLr3cEhgQUbfPnuZi9iOKVWZo+7FZBtauEEtvYt/CCRyu
         KdkmCM9aBeOH8I8j5WgNTvYhMiOjNm9SodtTrH0N9jPOn77J6nOA0GhxizQkjutn5Ly/
         1HP4dYdpBVfTpSMloEKvhH9oC9Bo3MtOXeeEwGKq17kx0ENyG0tSMyw8pxM4Nr532eu8
         jrJw==
X-Gm-Message-State: ACrzQf3d9mYBvfVr82PjAjshLGl9/criIkteh2zqW2P5HmGE/sAyX1yK
        x+2Sr8eROQKwo2hk06E+byyU8XSNgjKPvw==
X-Google-Smtp-Source: AMsMyM4lWP0T/ypzsxjrbwl2revCYhfU72GYP6b0uZT6Y3ZS8s4XCaMQXG5qeJhaLydYwRPMvzOxIw==
X-Received: by 2002:a63:5a44:0:b0:431:fa3a:f92c with SMTP id k4-20020a635a44000000b00431fa3af92cmr24867859pgm.471.1666530490816;
        Sun, 23 Oct 2022 06:08:10 -0700 (PDT)
Received: from [192.168.43.80] (subs02-180-214-232-1.three.co.id. [180.214.232.1])
        by smtp.gmail.com with ESMTPSA id z18-20020aa79592000000b0053e2b61b714sm18181300pfj.114.2022.10.23.06.08.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 23 Oct 2022 06:08:10 -0700 (PDT)
Message-ID: <d6fbe2e6-6e5a-823e-462d-19a8e18fbb40@gmail.com>
Date:   Sun, 23 Oct 2022 20:08:05 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH 7/7] Documentation: kunit: rewrite usage
Content-Language: en-US
To:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Brendan Higgins <brendan.higgins@linux.dev>,
        David Gow <davidgow@google.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Khalid Masum <khalid.masum.92@gmail.com>,
        Sadiya Kazi <sadiyakazi@google.com>
References: <20221023125414.60961-1-bagasdotme@gmail.com>
 <20221023125414.60961-8-bagasdotme@gmail.com>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <20221023125414.60961-8-bagasdotme@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 10/23/22 19:54, Bagas Sanjaya wrote:
> Rewrite the documentation for clarity. Major points:
> 
>   * Switch to third person point of view
>   * Briefly describe code examples before giving them out
>   * Use "base" and "derived" terminology on class inheritance
> 
> Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>

Oops, duplicate patch sent. Please ignore this series.

-- 
An old man doll... just what I always wanted! - Clara

