Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE95C40D98A
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Sep 2021 14:13:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239341AbhIPMOV (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 16 Sep 2021 08:14:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239396AbhIPMOU (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 16 Sep 2021 08:14:20 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 779FEC061766
        for <linux-kselftest@vger.kernel.org>; Thu, 16 Sep 2021 05:13:00 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id g16so9134835wrb.3
        for <linux-kselftest@vger.kernel.org>; Thu, 16 Sep 2021 05:13:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent-com.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=nAa7hcN3ascpVQvM2OTeR2k2GxYPakXsr5xj8Xor+Lw=;
        b=WmD/Z3+ncYgIZPTkselMJKRJwFC5I8QlynB+q8Lx4A4w+1BwjPde8V+HFZ6T61d3Z0
         WKVnlly6gf/xyNqeuOpkTGnrKuo3Nxcf/0+NI5UBolir1q1MWuUtuIz/RXfmU9IeW4lo
         Wn1ilNGM56xVE7XDbRQu4sBu+57OlID40Z97fV41DuOiSZVTetL3kTj2ZwthotdFdH/Q
         SXUKvUGfvyzlorYs+n55BkMW476UbDatDv318GaIiqZLzQesajEooYAG0rOQ92vePetd
         EhyWlX87ZPx152HdnX8/byXkwQz6eKseOdCyzYZYo0y2pwUyJfEPx4ro/AcoWJzqDAQt
         ERWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=nAa7hcN3ascpVQvM2OTeR2k2GxYPakXsr5xj8Xor+Lw=;
        b=S0ybfTFuAPoby6KRrjIFH3kXPo+imtjky/FozxuzOCkatWNrzv3wgPSWmRVX9flZK9
         JqCs3qvnRKtFDFvuVm1ratOfw0116nZUzD6vSRlH/RkDN5bRWj2ksXyhGgxF/Y9Tvyr4
         HdrjcCQPK07pJSein3/MfDrfjBkiFNqD2MRAoVyJcTNNXN/sXT3w8JBc3eBPE4Utqr5D
         gZn3p6ygdvac8U2O43Spt52hhyM6zE2pA9prcRyyrmkCIJe9zM3AqxbRA75pCPz3NgP4
         jd86VCYpwAp/NgiL1TFVWFicHMUYlZHFlblsIzz8RystKm2dWhMZhI6SShl1ZB6mRA31
         LrtQ==
X-Gm-Message-State: AOAM533Y1FruMSoVzFYjpHEBg6fRglhebwPgQ8/PIrso9ehAF3vTY08C
        itPY8vk4FzmApdwbopmEi5eg5Q==
X-Google-Smtp-Source: ABdhPJzjhJgO8cFIT2GipL1pyLBESTYNhG5MXheT1l5nRxXPi6XFjSoeUvTa4kKMZP8Y/iAwUO0X0A==
X-Received: by 2002:a5d:64ea:: with SMTP id g10mr2658238wri.274.1631794379049;
        Thu, 16 Sep 2021 05:12:59 -0700 (PDT)
Received: from [192.168.1.8] ([149.86.87.95])
        by smtp.gmail.com with ESMTPSA id m29sm3450939wrb.89.2021.09.16.05.12.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Sep 2021 05:12:58 -0700 (PDT)
Subject: Re: [PATCH 08/24] tools: bpftool: update bpftool-prog.rst reference
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "David S. Miller" <davem@davemloft.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        David Beckett <david.beckett@netronome.com>,
        Jakub Kicinski <kuba@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>, Martin KaFai Lau <kafai@fb.com>,
        Shuah Khan <shuah@kernel.org>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, netdev@vger.kernel.org
References: <cover.1631783482.git.mchehab+huawei@kernel.org>
 <dc4bae7a14518fbfff20a0f539df06a5c19b09de.1631783482.git.mchehab+huawei@kernel.org>
 <eb80e8f5-b9d7-5031-8ebb-4595bb295dbf@isovalent.com>
 <20210916124930.7ae3b722@coco.lan>
 <33d66a49-2fc0-57a1-c1e5-34e932bcc237@isovalent.com>
 <20210916133036.37c50383@coco.lan>
From:   Quentin Monnet <quentin@isovalent.com>
Message-ID: <8d5eaebb-29ac-5ee6-20ec-09d30d33dd73@isovalent.com>
Date:   Thu, 16 Sep 2021 13:12:57 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20210916133036.37c50383@coco.lan>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

2021-09-16 13:30 UTC+0200 ~ Mauro Carvalho Chehab
<mchehab+huawei@kernel.org>

> [PATCH] scripts: documentation-file-ref-check: fix bpf selftests path
> 
> tools/testing/selftests/bpf/test_bpftool_synctypes.py use
> relative patches on the top of BPFTOOL_DIR:
> 
> 	BPFTOOL_DIR = os.path.join(LINUX_ROOT, 'tools/bpf/bpftool')
> 
> Change the script to automatically convert:
> 
> 	testing/selftests/bpf -> bpf/bpftool
> 
> In order to properly check the files used by such script.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> 
> diff --git a/scripts/documentation-file-ref-check b/scripts/documentation-file-ref-check
> index 7187ea5e5149..2d91cfe11cd2 100755
> --- a/scripts/documentation-file-ref-check
> +++ b/scripts/documentation-file-ref-check
> @@ -144,6 +144,7 @@ while (<IN>) {
>  		if ($f =~ m/tools/) {
>  			my $path = $f;
>  			$path =~ s,(.*)/.*,$1,;
> +			$path =~ s,testing/selftests/bpf,bpf/bpftool,;
>  			next if (grep -e, glob("$path/$ref $path/../$ref $path/$fulref"));
>  		}
>  
> 
> 
> 

I tested the patch and it works well on my side.

However, this looks a bit fragile to me. There is no particular reason
to have testing/selftests/bpf point to bpf/bpftool other than to
accommodate the current case, we could imagine other selftest files
pointing to other parts of the documentation in the future. I would
instead make an exception for test_bpftool_synctypes.py specifically
(other selftest files don't usually parse documentation anyway).
Alternatively, I would look at excluding lines where the path is used in
code (tricky to detect), maybe at least when used with os.path.join():

    next if ($ln =~ m,os\.path\.join\([^\,]*\,\s*['"]$fulref,);

But I'm not familiar with documentation-file-ref-check in the first
place, so these are just my two cents.

Thanks,
Quentin
