Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D34EE49301B
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Jan 2022 22:47:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349614AbiARVrh (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 18 Jan 2022 16:47:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349603AbiARVrb (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 18 Jan 2022 16:47:31 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBFADC061401
        for <linux-kselftest@vger.kernel.org>; Tue, 18 Jan 2022 13:47:30 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id u21so1557766edd.5
        for <linux-kselftest@vger.kernel.org>; Tue, 18 Jan 2022 13:47:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=FGas2wsR5I0Xu3XQ1U1PiZH1Bz7IfFmMtPMkpY3JwQs=;
        b=bHC3qhzpOqwOWsCGU8nz/CY903WoUbR/4FZT4/aIJcI4EqWCgfGUrf3LyKcJeKtLid
         Q8RY17Vn3luA9tgNnrXNKQFlw1gTVaeL+PBN1xq/WedQbqeHj4IYNfcQ+ostX61hSqb8
         i341vsk8ERHVLt84Xex8CLe20cZFCrOnf0vqZoZWK1xnkT1M8YZ+pQey2uqK+z0+hBOs
         rRHHHenkdNM0tjVouFF3BUCoeAEg+bHm2RsZSeceRSslAUA3KSqyKxg8XkzsgUkJiKrY
         IxBrPVT4JI2nNFNuDKE/p3m5JSnu+WYkT9hnvaffodmZtg4QKzpeI5dLaKZRP3wnOa7n
         Sdjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=FGas2wsR5I0Xu3XQ1U1PiZH1Bz7IfFmMtPMkpY3JwQs=;
        b=tQDlY3VdOOG/wKT0M1W87HSggSc8tdME86OYBGd9tLX0l+wT/BNqRNRX/6bBgtXHwn
         6JM8yeaI9sT2oJSoj+82i/xvyrw7B/aqz8JyOc8vHYaCbiE54570IFgS1K8ggGZKpM9D
         WeNSH4U61oYA/YMtpTNdMEDVHZej9l501v7XS0Pqax0RsXYZt+9l5JVHtaPFJAhtXBc2
         FNdMU/8YKVqK3zdDMyVe3Fjf423tdKktLq3o5FTU/TG+zrZdBQdAoG3W2Dwdi+t/eIPI
         FvYdvoTJuhGBnotpWmUHeJhko+1j6Ahv3+lCt9EdpkjTArSuO6SZ9qrXj1IPCC1mWZ+B
         c5lw==
X-Gm-Message-State: AOAM533zfnfJxczDDJFC22INmqQ6/ij34ZbHanh/yDZOiqaCGJb7vA9f
        KPMIp9X2eIqDdmClcAfMffXQYw==
X-Google-Smtp-Source: ABdhPJwWbFrKUS/lRJJq/8VFObiKd0n2aVmGnF5RHGd9FSxMEaM8KRD5ae783HnEDAP9fF1ApDdMLQ==
X-Received: by 2002:a17:907:6d03:: with SMTP id sa3mr22717797ejc.200.1642542449232;
        Tue, 18 Jan 2022 13:47:29 -0800 (PST)
Received: from ?IPV6:2a02:578:8593:1200:27ca:2fb0:c5af:41e? ([2a02:578:8593:1200:27ca:2fb0:c5af:41e])
        by smtp.gmail.com with ESMTPSA id l25sm346996edc.20.2022.01.18.13.47.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Jan 2022 13:47:28 -0800 (PST)
Message-ID: <4d60a170-53d7-3f9f-fa48-34d6c4020346@tessares.net>
Date:   Tue, 18 Jan 2022 22:47:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 08/10] selftests: mptcp: Add the uapi headers include
 variable
Content-Language: en-GB
To:     Muhammad Usama Anjum <usama.anjum@collabora.com>,
        Shuah Khan <shuah@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        =?UTF-8?Q?Andr=c3=a9_Almeida?= <andrealmeid@collabora.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Mat Martineau <mathew.j.martineau@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        chiminghao <chi.minghao@zte.com.cn>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:KERNEL VIRTUAL MACHINE (KVM)" <kvm@vger.kernel.org>,
        "open list:LANDLOCK SECURITY MODULE" 
        <linux-security-module@vger.kernel.org>,
        "open list:NETWORKING [GENERAL]" <netdev@vger.kernel.org>,
        "open list:NETWORKING [MPTCP]" <mptcp@lists.linux.dev>,
        "open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>
Cc:     kernel@collabora.com
References: <20220118112909.1885705-1-usama.anjum@collabora.com>
 <20220118112909.1885705-9-usama.anjum@collabora.com>
From:   Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <20220118112909.1885705-9-usama.anjum@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Muhammad,

On 18/01/2022 12:29, Muhammad Usama Anjum wrote:
> Out of tree build of this test fails if relative path of the output
> directory is specified. Remove the un-needed include paths and use
> KHDR_INCLUDES to correctly reach the headers.

Thank you for looking at that!

> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
> ---
>  tools/testing/selftests/net/mptcp/Makefile | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/tools/testing/selftests/net/mptcp/Makefile b/tools/testing/selftests/net/mptcp/Makefile
> index 0356c4501c99..fed6866d3b73 100644
> --- a/tools/testing/selftests/net/mptcp/Makefile
> +++ b/tools/testing/selftests/net/mptcp/Makefile
> @@ -1,9 +1,8 @@
>  # SPDX-License-Identifier: GPL-2.0
>  
> -top_srcdir = ../../../../..

Removing this line breaks our CI validating MPTCP selftests. That's
because this "top_srcdir" variable is needed in the "lib.mk" file which
is included at the end of this Makefile.

But that's maybe a misuse from our side. Indeed to avoid compiling
binaries and more from the VM, our CI does that as a preparation job
before starting the VM and run MPTCP selftests:

  $ make O=(...) INSTALL_HDR_PATH=(...)/kselftest/usr headers_install
  $ make O=(...) -C tools/testing/selftests/net/mptcp

From the VM, we re-use the same source directory and we can start
individual tests without having to compile anything else:

  $ cd tools/testing/selftests/net/mptcp
  $ ./mptcp_connect.sh

We want to do that because some scripts are launched multiple times with
different parameters.

With your modifications, we can drop the headers_install instruction but
we need to pass new parameters to the last 'make' command:

  $ make O=(...) top_srcdir=../../../../.. \
                 KHDR_INCLUDES=-I(...)/usr/include \
         -C tools/testing/selftests/net/mptcp

Or is there a better way to do that?
Can we leave the definition of "top_srcdir" like it was or did we miss
something else?

>  KSFT_KHDR_INSTALL := 1
>  
> -CFLAGS =  -Wall -Wl,--no-as-needed -O2 -g  -I$(top_srcdir)/usr/include
> +CFLAGS =  -Wall -Wl,--no-as-needed -O2 -g $(KHDR_INCLUDES)
>  
>  TEST_PROGS := mptcp_connect.sh pm_netlink.sh mptcp_join.sh diag.sh \
>  	      simult_flows.sh mptcp_sockopt.sh

Note: I see there is a very long recipients list. If my issue is not
directly due to your modifications, we can probably continue the
discussion with a restricted audience.

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
