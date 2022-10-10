Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 902B35FA264
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Oct 2022 19:05:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229671AbiJJRFQ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 10 Oct 2022 13:05:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbiJJRFP (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 10 Oct 2022 13:05:15 -0400
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37A485053B
        for <linux-kselftest@vger.kernel.org>; Mon, 10 Oct 2022 10:05:13 -0700 (PDT)
Received: by mail-io1-xd2e.google.com with SMTP id p186so8916386iof.5
        for <linux-kselftest@vger.kernel.org>; Mon, 10 Oct 2022 10:05:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=a3HDrNcv6yJNqd2s9JfcIqzKjT0PBMp/ObP9b2DnT34=;
        b=Gw1bdPu4POqdR2W/o+kM1gUWywopmxD35R2mAolUjUi9IKdc52Xoybkd6csHIszZNH
         JhmnoQ1xR8xm7v9OdnYIpSEgSefCOgLWGkCJRQgybukmwZFcn196fMp5MYwR66NfE8+q
         l4T8tYY9RqnpLi0d4QitWeed2k04TjYSoX+WA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=a3HDrNcv6yJNqd2s9JfcIqzKjT0PBMp/ObP9b2DnT34=;
        b=oPtYM14KbCdYIqcDoU43UGxYbZVNwCEH43IHEQsJLBAECgzX6dxYSkeR01Yfa2doLo
         rMr4kWcK6slYRlny0z3RQfQeCwS1zKN4CfjJudnG3K7+3yNY39z6EJeMoJibEkkYZ1n0
         uBPffB88ccjcp6bqY4mBzYka6AN4Tg2oSn/TcgUXdAMS13XSBRnf4y+Z3uUMnuLPgCR9
         6L/ebNj27gmAp7negclKayCszOYaKCBhfBici9K3blx6h5Wtpb3ge7JhLvC0BqXasOZP
         LxRzXT5ctz8AbLnPBHub7utRBsEntmfCpicbotgjhj0XDC1KvU8dL0G9ObjXc5GHEsRb
         1dcg==
X-Gm-Message-State: ACrzQf2ucNINEoj3JeP9YAH3tfh/EmLGpbfsU27mFECUzQ5+icRoRbye
        Rqe8YhkgW15lb+s+fDs3W2w5Iw==
X-Google-Smtp-Source: AMsMyM55Ez0CyLaCt0LS128gNRo473pv/PovXcmkJ+jAZ582t0++0GkmmRBa88aurkT2o6SqtCxKug==
X-Received: by 2002:a05:6638:4115:b0:35a:2729:fc6b with SMTP id ay21-20020a056638411500b0035a2729fc6bmr10788196jab.264.1665421512581;
        Mon, 10 Oct 2022 10:05:12 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id bm12-20020a05663842cc00b003638d00b759sm3865694jab.54.2022.10.10.10.05.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Oct 2022 10:05:12 -0700 (PDT)
Message-ID: <6137ddfb-a731-3fac-e3ac-4d2a00a00d4b@linuxfoundation.org>
Date:   Mon, 10 Oct 2022 11:05:11 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [RESEND PATCH] selftests/futex: fix build for clang
Content-Language: en-US
To:     =?UTF-8?Q?Ricardo_Ca=c3=b1uelo?= <ricardo.canuelo@collabora.com>,
        linux-kselftest@vger.kernel.org
Cc:     andrealmeid@igalia.com, dvhart@infradead.org, shuah@kernel.org,
        kernel@collabora.com, Shuah Khan <skhan@linuxfoundation.org>
References: <20221010063702.1323118-1-ricardo.canuelo@collabora.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20221010063702.1323118-1-ricardo.canuelo@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 10/10/22 00:37, Ricardo Cañuelo wrote:
> Don't use the test-specific header files as source files to force a
> target dependency, as clang will complain if more than one source file
> is used for a compile command with a single '-o' flag.
> 
> Use the proper Makefile variables instead as defined in
> tools/testing/selftests/lib.mk.
> 
> Signed-off-by: Ricardo Cañuelo <ricardo.canuelo@collabora.com>
> ---

I will apply this and other two patches right after the merge window for
rc2.

thanks,
-- Shuah

