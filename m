Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 575AF1AAEB
	for <lists+linux-kselftest@lfdr.de>; Sun, 12 May 2019 08:29:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726092AbfELG3K (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 12 May 2019 02:29:10 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:41127 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726002AbfELG3K (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 12 May 2019 02:29:10 -0400
Received: by mail-pg1-f196.google.com with SMTP id z3so5076568pgp.8
        for <linux-kselftest@vger.kernel.org>; Sat, 11 May 2019 23:29:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fomichev-me.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=pSWMt1O9RyRNp2R37obyg4EhfrggGYCpcdG8qEUd4/w=;
        b=CKf756SiRXeuNuJY5MCR440JDY0r/+ZbV+fmGloYC2vXpaJyT/W27LoJbDNwfzR4GQ
         0QjWahoJm+onBpzCptev7pIaQJ9YlLdaUR7mP1k/ZJCO9GL97fAU0dGj9MIuL8NPTjW0
         wVvy/KSOxZaznitl9ALWJGLTLFYMZN/OrKOjD90iROk6Y/NIP4X3TH0gxmuvg/EXXof7
         Cw2EjPaLTDIlTkAGW/+EjA4OukxKfRsSeHhQuh8mZFBDxgZiQYPTJxoQaLvtwyUnTkut
         BQSUmV1yieB7+26nVd4cj1T0gN70hi0WZaQaaBbl4/qCCwhrweUgpBeuDsHy/Vht8PMq
         S7WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=pSWMt1O9RyRNp2R37obyg4EhfrggGYCpcdG8qEUd4/w=;
        b=tiyVc+bUEN/izAZWd2CCBv0nuZZaiuw451ShXzUHxFdKROWmCsOTTxNK+PldpWMh5F
         0tMIDyJVKCa+cv94KS8f5+J8yZJtNMErQDsbGfli7xpGCKrNhhBsOgcKXaFKFDibYTeH
         zcGk5B3rjSO8WjAvMlQAnwQCbMdOdppn23+c+KO6uVR4ESdD4+xShCe3FOs9983YfkXw
         QLpUjvPFKb3J5gyCnWbi8fR9Smv1s/csT92MlQ0J8GeDaRQxLqhjBmHzg41mLKBmmZiY
         2RWRW+Oj6B5hOESBATef9sziX/tX+7AsWSqAePLEcsnAf+2jBxQNOp6Zj/OTC+ZBNAt4
         7+pw==
X-Gm-Message-State: APjAAAWpHKDchS32XPvNri//zJwBWitxzCFTSRh38DyQTpdfCLquWDiz
        jPNGmvSeNIyTnQ1CTUrjo6xJAQ==
X-Google-Smtp-Source: APXvYqxprQsC0AXWjoX8Vnk2CDqxAQBeXRlCaMTi7hz2pRnNfQMIUWZqND2vSYrCfrN6LqxCvng/yw==
X-Received: by 2002:a62:4d03:: with SMTP id a3mr26678309pfb.2.1557642549622;
        Sat, 11 May 2019 23:29:09 -0700 (PDT)
Received: from localhost ([2601:646:8f00:18d9:d0fa:7a4b:764f:de48])
        by smtp.gmail.com with ESMTPSA id v1sm16037213pgb.85.2019.05.11.23.29.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 11 May 2019 23:29:08 -0700 (PDT)
Date:   Sat, 11 May 2019 23:29:07 -0700
From:   Stanislav Fomichev <sdf@fomichev.me>
To:     Kelsey Skunberg <skunberg.kelsey@gmail.com>
Cc:     shuah@kernel.org, ast@kernel.org, daniel@iogearbox.net,
        kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        linux-kselftest@vger.kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        skhan@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [PATCH] selftests: bpf: Add files generated when compiled to
 .gitignore
Message-ID: <20190512062907.GL1247@mini-arch>
References: <20190512035009.25451-1-skunberg.kelsey@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190512035009.25451-1-skunberg.kelsey@gmail.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 05/11, Kelsey Skunberg wrote:
> The following files are generated when /selftests/bpf/ is compiled and
> should be added to .gitignore:
> 
> 	- libbpf.pc
> 	- libbpf.so.0
> 	- libbpf.so.0.0.3
> 
> Signed-off-by: Kelsey Skunberg <skunberg.kelsey@gmail.com>
> ---
>  tools/testing/selftests/bpf/.gitignore | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/tools/testing/selftests/bpf/.gitignore b/tools/testing/selftests/bpf/.gitignore
> index 41e8a689aa77..ceb11f98fe4f 100644
> --- a/tools/testing/selftests/bpf/.gitignore
> +++ b/tools/testing/selftests/bpf/.gitignore
> @@ -32,3 +32,6 @@ test_tcpnotify_user
>  test_libbpf
>  test_tcp_check_syncookie_user
>  alu32
> +libbpf.pc

[..]
> +libbpf.so.0
> +libbpf.so.0.0.3
How about libbpf.so.* so we don't have to update it on every release?

> --
> 2.20.1
> 
