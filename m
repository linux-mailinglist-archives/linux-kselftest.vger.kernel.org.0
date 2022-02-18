Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F35F44BBC38
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Feb 2022 16:32:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236723AbiBRPc1 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 18 Feb 2022 10:32:27 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:46462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235943AbiBRPc0 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 18 Feb 2022 10:32:26 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6037411C27;
        Fri, 18 Feb 2022 07:32:09 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: usama.anjum)
        with ESMTPSA id B4CD21F4413F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1645198328;
        bh=HfevSReZxZGWn6yf7ymhC/9L8F+5m58D+RzaRi/vLLo=;
        h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
        b=cvrS6XR95aY1ZkOp2AvpNUgrUv1OAzzsDPPHrl7vmTORbnqzBgZiUXZGYKlCkpIdO
         5/lgywIdinUxx0FfbYUgdCUP+OPF/9Zm12csOkYFxDX+XYl+bTs4GbnfTWVBogC79o
         Py8Q2dRq4T8Q7jiPLZh5SnCAbRtDSWdmvFcdVnTAq096PhFI2qsXu7ABa71dH9zFRX
         osx37eyssIxGb3Jg23QY3e8v5yVAoObHHExwRWiR7kAmiJFTMmxiJnCvf/Kdzs+BCk
         0T6tp8tJ/RAiv0m87IAEjbdVDU8Uzh09nVgkHZUOZPqi6UwvgxBJlu6y1coS2sZrfL
         +Hf5MOuE1hIAQ==
Message-ID: <03ac8b04-15bb-d4a9-d09b-e5711bed1811@collabora.com>
Date:   Fri, 18 Feb 2022 20:32:01 +0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Cc:     usama.anjum@collabora.com, kernel@collabora.com,
        kernelci@groups.io, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] selftests/lkdtm: add config
Content-Language: en-US
To:     Kees Cook <keescook@chromium.org>, Shuah Khan <shuah@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <20220217205620.2512094-1-usama.anjum@collabora.com>
 <20220217205620.2512094-2-usama.anjum@collabora.com>
From:   Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <20220217205620.2512094-2-usama.anjum@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SCC_BODY_URI_ONLY,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 2/18/22 1:56 AM, Muhammad Usama Anjum wrote:
> Add config option which is needed for SLAB_LINEAR_OVERFLOW test. It
> needs KASAN enabled.
> 
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Fixes: 9c4f6ebc3665 ("lkdtm/heap: Add vmalloc linear overflow test")
> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
Reported-by: "kernelci.org bot" <bot@kernelci.org>
