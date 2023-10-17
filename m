Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FEE97CC827
	for <lists+linux-kselftest@lfdr.de>; Tue, 17 Oct 2023 17:54:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344172AbjJQPye (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 17 Oct 2023 11:54:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344312AbjJQPyd (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 17 Oct 2023 11:54:33 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B23BF9
        for <linux-kselftest@vger.kernel.org>; Tue, 17 Oct 2023 08:54:31 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id ca18e2360f4ac-7a66555061eso4485639f.0
        for <linux-kselftest@vger.kernel.org>; Tue, 17 Oct 2023 08:54:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1697558070; x=1698162870; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=S4G1qT6aCa9jONcb1w7B7j7yaP96Lr1tt891SPK3dpg=;
        b=chRCl3o1+2k5CG6tVkPUCropXXw3FE9EvyMSGwePxTxY5YZTblKzHa0xj1YCboHX3S
         xiT18ybQzG/QF2QH1CSFBwJyvy8KU+w/kkh1Pag74QhbvvdUIpnLtx+J8Af74WWqlbHq
         s4RPimf+nAAZAWXWwZQvcBruax0pgs1g1oMb0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697558070; x=1698162870;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=S4G1qT6aCa9jONcb1w7B7j7yaP96Lr1tt891SPK3dpg=;
        b=oBxhrrdfdeixMMMDnC9YJ6VTJUYMqgolT7/oaI80SULlQCNfIiazXhZnqZWMTJ/FDX
         VRzb3NYWZDNVszI7BhZsOG6Ic3E1ksNm6FEtaMgFGAduemnLtbONL+X/ARfSNl2xm5Ap
         L8DmfmNIJ5U4vlCDwMwTzKJPF3sfH+OG1cqhRA2YMWeEliW1J1vVNVfSBQqONySAZkcD
         rsTAx5zxwh+o2/NEDc8EEaoThV4TwGOh5ZoEKhiRi4XbTWo1OAkK2UsG2tYuGrzQNHs8
         8MqYgVQKR4NlR4k8yoDs/tGsot6HjFo7kwGbxvfhYwu4HHOr5hgm7/Y9NY/hYDNCauMZ
         wvJg==
X-Gm-Message-State: AOJu0YyJ00bvC+rcdNuUssWGxY/xFz7Q8UHVykIK7JnKqJ4TRzmB0kJd
        28LAQnxfG31PSwbQkHHUNilyithdhaJ5E32g/eE=
X-Google-Smtp-Source: AGHT+IE1gm5UPb4UgknT2djO05i1WKcZkMahvgNJZx0obMBFURyRnux/GWy/wHUc51MJlLYA/ThrrQ==
X-Received: by 2002:a05:6602:1513:b0:79f:a8c2:290d with SMTP id g19-20020a056602151300b0079fa8c2290dmr3370902iow.0.1697558070367;
        Tue, 17 Oct 2023 08:54:30 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id fj1-20020a056638634100b0042b4f9ddecasm597648jab.85.2023.10.17.08.54.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Oct 2023 08:54:30 -0700 (PDT)
Message-ID: <f1857ee6-1569-4a85-ba51-94c3d841cb61@linuxfoundation.org>
Date:   Tue, 17 Oct 2023 09:54:29 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests:modify the incorrect print format
Content-Language: en-US
To:     zhujun2 <zhujun2@cmss.chinamobile.com>, shuah@kernel.org
Cc:     nathan@kernel.org, ndesaulniers@google.com, trix@redhat.com,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, Shuah Khan <skhan@linuxfoundation.org>
References: <20231017020856.7003-1-zhujun2@cmss.chinamobile.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20231017020856.7003-1-zhujun2@cmss.chinamobile.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 10/16/23 20:08, zhujun2 wrote:
> when the argument type is 'unsigned int',printf '%u'
> in format string
> 

Please add how you found the problem to the commit log.

> Signed-off-by: zhujun2 <zhujun2@cmss.chinamobile.com>

thanks,
-- Shuah

