Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1520A77E68A
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Aug 2023 18:37:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344756AbjHPQgw (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 16 Aug 2023 12:36:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344795AbjHPQgi (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 16 Aug 2023 12:36:38 -0400
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D993F1BE6
        for <linux-kselftest@vger.kernel.org>; Wed, 16 Aug 2023 09:36:18 -0700 (PDT)
Received: by mail-il1-x12f.google.com with SMTP id e9e14a558f8ab-34aa1a145f1so3246925ab.0
        for <linux-kselftest@vger.kernel.org>; Wed, 16 Aug 2023 09:36:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1692203778; x=1692808578;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FN/upEJmNsYFJtZVN8lMQnLo54NIXhM++1meBoKNXZM=;
        b=K0n/GmAxF7DKTyDbmbfgai/i4wJY8ZTR/fghK7OpldRhzi6fB2lPzt4cxKBES9B4wP
         XwGZnw/RG4L8JpqX6GfjDiGKadcK/ogjDm+Imnv1IMPx02hZKE9kaD7RwJk35J9eu0+d
         B10SFihmKKNnqdG441htHiTOLQUYJaerZ7keE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692203778; x=1692808578;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FN/upEJmNsYFJtZVN8lMQnLo54NIXhM++1meBoKNXZM=;
        b=JBRPyuVJkB9MuR2mWnWR8qwb84CX+uQTZDyQyYgkMQdXujRQGT1DodHSotYFjJIN6G
         5Ht3WfQNRT8VbdpsnfDgM9L5LH56N7dM5c1qkyGltvbHF1FPhVL4DTAH+ZaFwWOuj2N4
         lek3TP+OQMiH2TKSTBnAgUosf4wmCBUncgJsoFME9tUzPin5dVZJIizznSsMKQJokTfD
         VxwRFcu+Js+Filn7ndIeXRDuVtwu5WLiPNrY1YycDCRd6KdIi2/s6Hfnf0OhqWskI4Fe
         6CXcykSPGc8tP5T17gWtlK71+wbiyMy62/91qzOv3qm2b3XyEdEpoezxIE2vBGGP1gnH
         gdIw==
X-Gm-Message-State: AOJu0YznQHLB16zGfh/CnL0cZoepmTP/+Z4eIddMLVA+FYoDfekmz/6D
        hZv6hE+JMRs8UOkwl5lysulzlQ==
X-Google-Smtp-Source: AGHT+IEdwz4imWwA6Pw8BHtQsUK/f2FIu/5l9LsGLf2orz4Te3OXr/3vNfHXxgOb3SRoxDz9/KhSGw==
X-Received: by 2002:a05:6602:2bfa:b0:783:6e76:6bc7 with SMTP id d26-20020a0566022bfa00b007836e766bc7mr3173022ioy.2.1692203778291;
        Wed, 16 Aug 2023 09:36:18 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id gm2-20020a0566382b8200b0043012f6139fsm4110044jab.32.2023.08.16.09.36.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Aug 2023 09:36:17 -0700 (PDT)
Message-ID: <6e56e4fc-255c-c958-5ac9-c28bdeab0a84@linuxfoundation.org>
Date:   Wed, 16 Aug 2023 10:36:17 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] selftests: Hook more tests into the build infrastructure
Content-Language: en-US
To:     Mark Brown <broonie@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Marco Elver <elver@google.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20230806-kselftest-perf-events-build-v1-1-0120e7a9cd72@kernel.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20230806-kselftest-perf-events-build-v1-1-0120e7a9cd72@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 8/5/23 17:14, Mark Brown wrote:
> We have some dmabuf-heaps and perf_events tests but they are not hooked
> up to the kselftest build infrastructure which is a bit of an obstacle
> to running them in systems with generic infrastructure for selftests.
> Add them to the top level kselftest Makefile so they get built as
> standard.
> 
> Signed-off-by: Mark Brown <broonie@kernel.org>
> ---

Thank you. Applied to linux-kselftest next for Linux 6.6-rc1.

thanks,
-- Shuah

