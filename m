Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 126DC5FF28F
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Oct 2022 18:51:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231276AbiJNQvQ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 14 Oct 2022 12:51:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231209AbiJNQvH (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 14 Oct 2022 12:51:07 -0400
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A98D92E69D
        for <linux-kselftest@vger.kernel.org>; Fri, 14 Oct 2022 09:50:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=gnz1ad7jl8qhcwTYVPHX8w7YgaebH5W9lRkH4P+dvBM=; b=VfWLra12v3bAtEyZ5TM620mPLE
        ZHCltY1CA31WxHwFX9BopzYFLrB3jR1wfVe0JmIVguxWjtPi4xVktKfqyLtQ+q2s81rfZbwXnTESx
        FnRdxnCB/IQ3Oc5HtzJxNipM23UloOsWATn4ex8mfZY/03b1vkWfv3uF+LUY1DIwOimCiduwnvJJA
        CQcgnKqhiK79eEeTETYk17qwAz/yp/HP5XzfoEhQ+3+jUUD/Fq0FspXE62SmMKEOgDpjpagF4B8Wb
        XFGm5fbnkC2MAInpIdFuH+tBCgR1zWbfnB4sQVGg3h/1U3VyuR0D01hY9VKR2gW+pKxmxAfEeGGR9
        ObLhn0FQ==;
Received: from [187.57.106.242] (helo=[192.168.1.111])
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
        id 1ojNtK-001Vsl-T0; Fri, 14 Oct 2022 18:50:35 +0200
Message-ID: <77a5bf0b-fa72-8ef8-0d39-2056384760ee@igalia.com>
Date:   Fri, 14 Oct 2022 13:50:15 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [RESEND PATCH] selftests/futex: fix build for clang
Content-Language: en-US
To:     =?UTF-8?Q?Ricardo_Ca=c3=b1uelo?= <ricardo.canuelo@collabora.com>
Cc:     dvhart@infradead.org, shuah@kernel.org, kernel@collabora.com,
        linux-kselftest@vger.kernel.org
References: <20221010063702.1323118-1-ricardo.canuelo@collabora.com>
From:   =?UTF-8?Q?Andr=c3=a9_Almeida?= <andrealmeid@igalia.com>
In-Reply-To: <20221010063702.1323118-1-ricardo.canuelo@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 10/10/22 03:37, Ricardo Cañuelo wrote:
> Don't use the test-specific header files as source files to force a
> target dependency, as clang will complain if more than one source file
> is used for a compile command with a single '-o' flag.
> 
> Use the proper Makefile variables instead as defined in
> tools/testing/selftests/lib.mk.
> 
> Signed-off-by: Ricardo Cañuelo <ricardo.canuelo@collabora.com>
> ---

Reviewed-by: André Almeida <andrealmeid@igalia.com>

Thanks for the patch!
