Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BBA94CAB33
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Mar 2022 18:11:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236626AbiCBRME (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 2 Mar 2022 12:12:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243713AbiCBRL7 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 2 Mar 2022 12:11:59 -0500
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F11A3CCC6A
        for <linux-kselftest@vger.kernel.org>; Wed,  2 Mar 2022 09:11:12 -0800 (PST)
Received: by mail-io1-xd2a.google.com with SMTP id c23so2663920ioi.4
        for <linux-kselftest@vger.kernel.org>; Wed, 02 Mar 2022 09:11:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=83q6+noTFJybB0WC25LHakrKQfUwn6wf6lgLZohu98A=;
        b=QvvgZIEo83Y2mSPBpsqp1FRHGnpYMU1vq+2AxLele4vi8X1pEooqlwshsloDWuFrF7
         GIytW+itFjRuh12+SRepk/ybzqHfmS5fBbHMHw9am1wEtDR6pKyGEVJw9kLsU2h1gqbP
         A9N9M+CgnBXAA59iO0JyPMotF9Od1StE46W4Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=83q6+noTFJybB0WC25LHakrKQfUwn6wf6lgLZohu98A=;
        b=KDTnCuUJpHolOTOQuBbraBMnP3OV3AooRd38eSCk+gKBRM0dmUwaJjLx17wcbgmYzi
         LqgP+br0gR4TteUm6yxWU6nMTNyzsXM0QF58MW020NxRT2yGOU497OHppRzyRP8Z2Zav
         kr4dQ9ZDxPsbPVg18FHOr2+F/EzvXkg6lW+4Le8DazU0Wf7eXYHSMAjMwGT0gyNi3SEu
         jWU42YPRiIk0kEghz99hi4QwFMnCSQ6dqyACvfcf3aZG42u2kybrjtzcFaSrAYeY9cz4
         9ynhxz0MfWoRDx+d3W3JO7xUewpwYd9Z4HL++px4USpYYzbc/4MEZWSz78RfQSuw40gS
         6eAA==
X-Gm-Message-State: AOAM531OvkmM5l4dPKtOAJ0K4Kz/DfS+qASvraOBEtliVUTLGtNit9DI
        OFEeBVBzrtgSSxT8C8+kNE8ZJQ==
X-Google-Smtp-Source: ABdhPJxkmmXrMrFVWsVoGnaNrgluPrrPS3v8LhMLAPArYve/4Zidy/vtyywO1shIJvMB/7lqUQGbhQ==
X-Received: by 2002:a05:6602:1409:b0:5e7:487:133c with SMTP id t9-20020a056602140900b005e70487133cmr23700342iov.196.1646241072120;
        Wed, 02 Mar 2022 09:11:12 -0800 (PST)
Received: from [192.168.1.128] ([71.205.29.0])
        by smtp.gmail.com with ESMTPSA id c7-20020a92dc87000000b002c2ed8cc0d1sm5265419iln.10.2022.03.02.09.11.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Mar 2022 09:11:11 -0800 (PST)
Subject: Re: [PATCH v2] selftests: netfilter: fix a build error on openSUSE
To:     Geliang Tang <geliang.tang@suse.com>,
        Shuah Khan <shuah@kernel.org>, pablo@netfilter.org
Cc:     linux-kselftest@vger.kernel.org, Kai Liu <kai.liu@suse.com>,
        Shuah Khan <skhan@linuxfoundation.org>
References: <5ee95e93a11a239df8e09d059da25a4eaa5725ba.1646198836.git.geliang.tang@suse.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <8cbf1231-0da5-c8a0-d66b-1488633d9895@linuxfoundation.org>
Date:   Wed, 2 Mar 2022 10:11:11 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <5ee95e93a11a239df8e09d059da25a4eaa5725ba.1646198836.git.geliang.tang@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 3/1/22 10:29 PM, Geliang Tang wrote:
> This patch fixed the following build error on openSUSE Leap 15.3:
> 
> =======================================================================
>   gcc     nf-queue.c -lmnl -o tools/testing/selftests/netfilter/nf-queue
>   nf-queue.c:13:10: fatal error: libmnl/libmnl.h: No such file or directory
>    #include <libmnl/libmnl.h>
>             ^~~~~~~~~~~~~~~~~
>   compilation terminated.
> =======================================================================
> 
> It is because libmnl.h is put in the directory of
> "/usr/include/libmnl/libmnl/" on openSUSE, not "/usr/include/libmnl/":
> 
>   > rpm -ql libmnl-devel
>   /usr/include/libmnl
>   /usr/include/libmnl/libmnl
>   /usr/include/libmnl/libmnl/libmnl.h
>   /usr/lib64/libmnl.so
>   /usr/lib64/pkgconfig/libmnl.pc
> 
> Suggested-by: Kai Liu <kai.liu@suse.com>
> Signed-off-by: Geliang Tang <geliang.tang@suse.com>
> ---
> v2:
>   - use pkg-config
> ---
>   tools/testing/selftests/netfilter/Makefile | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/tools/testing/selftests/netfilter/Makefile b/tools/testing/selftests/netfilter/Makefile
> index e4f845dd942b..8136c1fab7ab 100644
> --- a/tools/testing/selftests/netfilter/Makefile
> +++ b/tools/testing/selftests/netfilter/Makefile
> @@ -8,6 +8,7 @@ TEST_PROGS := nft_trans_stress.sh nft_fib.sh nft_nat.sh bridge_brouter.sh \
>   	ipip-conntrack-mtu.sh conntrack_tcp_unreplied.sh \
>   	conntrack_vrf.sh nft_synproxy.sh
>   
> +CFLAGS += $(shell pkg-config --cflags libmnl 2>/dev/null || echo "-I/usr/include/libmnl")
>   LDLIBS = -lmnl
>   TEST_GEN_FILES =  nf-queue
>   
> 

Adding Pablo to the thread.

Pablo,

This looks good to me. I can take this through linux-kselftest tree.
Let me know either way.

Or if it is going through netfilter tree:
Reviewed-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah




