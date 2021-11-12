Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BDFC44EB3A
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Nov 2021 17:17:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234342AbhKLQUQ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 12 Nov 2021 11:20:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235253AbhKLQUP (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 12 Nov 2021 11:20:15 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE68FC0613F5
        for <linux-kselftest@vger.kernel.org>; Fri, 12 Nov 2021 08:17:24 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id s13so16448282wrb.3
        for <linux-kselftest@vger.kernel.org>; Fri, 12 Nov 2021 08:17:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=IjY10L9Ob8FM1nTr8eL6YEuxMoDKftGPKbu87DB0I6E=;
        b=LY7rHaKO1XyaVEgqupWW9MVDr9cxkD2nvWYQ0Qq0XDj0F2vTRgJmwNyoyg0/JUHDb8
         rLQF9c7SG65ZvwP2bxe4zrVfXnTHMSTXBzUx8VCGNYeE39/RSS0mzTlLvJ29EX1nZn+J
         6xC3ATeccxzLbY1HurJLeLfOTEdIEEb3QhQSYr6SPrSVpNZIiH3dz4nEwO266FzWBpoD
         qVQBWpGcn+LR77bSMNNOaKuHd9Wjh7jV0A0saL9KLDa5AyJhJFkVa+4UsufkVu811Gul
         u6l0AdsonJJ3/6ghCbpz4m8KF/TrWMKnYfaB/j8TM3eVVwUtyL0Ysq3S3+TAP+kW2Z66
         ctdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=IjY10L9Ob8FM1nTr8eL6YEuxMoDKftGPKbu87DB0I6E=;
        b=qY0PS5tKrj/xmM5QKxMF4J9EvtkAUTgk348nxrAGW1/3vh8gqkkq8kqHJIdcsH53qI
         mV+gyC+VnoqryvGGHosg9cU7A6TWzQDmXDZ/3hiRf0Q8Ue4HstsYj7pTplKnSPQR6hKv
         2emRldE3MKLUuvdia+U/SB2c+af+QGI7uwvCihjvXPaODtFpO8eQYLxsYz5lkFq6klay
         4lbxvC6spIOnzPdJoEUcceE3o39T92XzTf1x5qraOSPFZIB4sG4mPI3M+ycUn1Bny0E3
         OljZWpWm5daEq1ERZtfW/3RBfVWAQoQztp084Mm2M0TNrIlWTJWCiCngbZzIdXxSu2Dh
         Y9yA==
X-Gm-Message-State: AOAM530DVXARWzf4Y55MHcEtablilA75OONYZLmnRQNvVX4jUalTdXkV
        jyoAfA44exCjxzJyl7mI/SUAQA4T1os4UA==
X-Google-Smtp-Source: ABdhPJzgw62hNc7tqgoMMizUhXXblEseuBOoSCaqCkMkuv93UdyM0yyjjrkW3p2LoJ1CzvZLh5Mgag==
X-Received: by 2002:a5d:4443:: with SMTP id x3mr20330241wrr.189.1636733843354;
        Fri, 12 Nov 2021 08:17:23 -0800 (PST)
Received: from [192.168.1.8] ([149.86.67.133])
        by smtp.gmail.com with ESMTPSA id 4sm8111048wrz.90.2021.11.12.08.17.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Nov 2021 08:17:23 -0800 (PST)
Message-ID: <d3a19501-01ee-a160-2275-c83fb0fb04b7@isovalent.com>
Date:   Fri, 12 Nov 2021 16:17:21 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH bpf] tools/runqslower: Fix cross-build
Content-Language: en-GB
To:     Jean-Philippe Brucker <jean-philippe@linaro.org>, ast@kernel.org,
        daniel@iogearbox.net, andrii@kernel.org
Cc:     kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, shuah@kernel.org,
        bpf@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <20211112155128.565680-1-jean-philippe@linaro.org>
From:   Quentin Monnet <quentin@isovalent.com>
In-Reply-To: <20211112155128.565680-1-jean-philippe@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

2021-11-12 15:51 UTC+0000 ~ Jean-Philippe Brucker <jean-philippe@linaro.org>
> Commit be79505caf3f ("tools/runqslower: Install libbpf headers when
> building") uses the target libbpf to build the host bpftool, which
> doesn't work when cross-building:
> 
>   make ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- -C tools/bpf/runqslower O=/tmp/runqslower
>   ...
>     LINK    /tmp/runqslower/bpftool/bpftool
>   /usr/bin/ld: /tmp/runqslower/libbpf/libbpf.a(libbpf-in.o): Relocations in generic ELF (EM: 183)
>   /usr/bin/ld: /tmp/runqslower/libbpf/libbpf.a: error adding symbols: file in wrong format
>   collect2: error: ld returned 1 exit status
> 
> When cross-building, the target architecture differs from the host. The
> bpftool used for building runqslower is executed on the host, and thus
> must use a different libbpf than that used for runqslower itself.
> Remove the LIBBPF_OUTPUT and LIBBPF_DESTDIR parameters, so the bpftool
> build makes its own library if necessary.
> 
> In the selftests, pass the host bpftool, already a prerequisite for the
> runqslower recipe, as BPFTOOL_OUTPUT. The runqslower Makefile will use
> the bpftool that's already built for selftests instead of making a new
> one.
> 
> Fixes: be79505caf3f ("tools/runqslower: Install libbpf headers when building")
> Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
Reviewed-by: Quentin Monnet <quentin@isovalent.com>

I realised too late I should have cc-ed you on those patches, apologies
for not doing so. Thank you for the fix!

Quentin
