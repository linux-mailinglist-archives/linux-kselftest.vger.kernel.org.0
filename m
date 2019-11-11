Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 37830F7449
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Nov 2019 13:45:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726888AbfKKMpH (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 11 Nov 2019 07:45:07 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:34003 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726954AbfKKMpG (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 11 Nov 2019 07:45:06 -0500
Received: by mail-wr1-f66.google.com with SMTP id e6so14549191wrw.1
        for <linux-kselftest@vger.kernel.org>; Mon, 11 Nov 2019 04:45:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=lfLrZn6o0WR8hdcCQJP/FUN2uHD26lyPzVdfs4Co05w=;
        b=fb+nN6Uuz6cxCb/MUEEu46gj/oPoclIDJyF4HjZ7dCt8iI4yMuPaFZnf1gCbwfMBoL
         Zjjsyp2mAxTv7eJqD4bSiZabLLZaEkM6nmjhnTBpLTKH7lTXZcK1CvUUEl2Hy0PaIQti
         J8+Mizhrq8gor7l1xqJlXjSHivxQwfLb/RvYWEIpUFuEey/p6GbcsV32JXh9Ojcc/w5X
         34cXpkod+6aJ3fm8gNtUWfyj26UEIt0r9jYvSYl3zUsKR1099FfIveueo6vzHIozHrBQ
         Qyly14FRfsQB/BscV2MatF/f6b70UBamTI+CG5fkrD/mx2atbnvHuN1CCtxww6TXGgJu
         MN7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=lfLrZn6o0WR8hdcCQJP/FUN2uHD26lyPzVdfs4Co05w=;
        b=pYyc0Jk+tXIdMQS3miiyx4A5SEzq/Zpd2EZXiQmJbrgN1xHBO1s1XcNYM5o3SURlRv
         1jwKPG0MrI1sCBfWGxaRcPk8DbbC3hU0ABa7nkI4aSFwdfs1NRJBp8Fa0YK7je8tzwuf
         Rm4onY3JMGrTm53XzCiVnT10bYUuU3OFAEpbe3izHYrxuJZzBP1vuIhwRUxlLFsQ3Hz8
         fnV1MmKfeSd81TEmmTF7GD9on7ESXz43lYKKpzWmPxihjY1ZnDb2t8zVG9+xlealO3Xh
         xt2/BZf4yKJc3/DXnXBIv5UNdA7wGPJa/BCt/XovHTBYJeUUqbNkWvDdX0e+NF8fvIRI
         JA7w==
X-Gm-Message-State: APjAAAVC/aA1wvgLWWrCMHIa+2kdfuC0LZYdm8+AmALzeDIlrp9pMxPg
        SQhvvpXoQBbVxZ3kQLSnfsE4yg==
X-Google-Smtp-Source: APXvYqynnsowDNPN19ONnGx2L9ZiGciqUv0b2LcAiPsqYBZGCQh+PtiTwcoRjNIcezfJbH/cKMl5ig==
X-Received: by 2002:adf:e505:: with SMTP id j5mr19727543wrm.46.1573476303323;
        Mon, 11 Nov 2019 04:45:03 -0800 (PST)
Received: from netronome.com ([2001:982:756:703:d63d:7eff:fe99:ac9d])
        by smtp.gmail.com with ESMTPSA id j2sm71885wrt.61.2019.11.11.04.45.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 11 Nov 2019 04:45:02 -0800 (PST)
Date:   Mon, 11 Nov 2019 13:45:02 +0100
From:   Simon Horman <simon.horman@netronome.com>
To:     Anders Roxell <anders.roxell@linaro.org>
Cc:     ast@kernel.org, daniel@iogearbox.net, davem@davemloft.net,
        netdev@vger.kernel.org, bpf@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        shuah@kernel.org, songliubraving@fb.com
Subject: Re: [PATCH bpf-next 2/2] selftests: bpf: test_tc_edt: add missing
 object file to TEST_FILES
Message-ID: <20191111124501.alvvekp5owj4daoh@netronome.com>
References: <20191110092616.24842-1-anders.roxell@linaro.org>
 <20191110092616.24842-2-anders.roxell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191110092616.24842-2-anders.roxell@linaro.org>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sun, Nov 10, 2019 at 10:26:16AM +0100, Anders Roxell wrote:
> When installing kselftests to its own directory and running the
> test_tc_edt.sh it will complain that test_tc_edt.o can't be find.
> 
> $ ./test_tc_edt.sh
> Error opening object test_tc_edt.o: No such file or directory
> Object hashing failed!
> Cannot initialize ELF context!
> Unable to load program
> 
> Rework to add test_tc_edt.o to TEST_FILES so the object file gets
> installed when installing kselftest.
> 
> Fixes: 74b5a5968fe8 ("selftests/bpf: Replace test_progs and test_maps w/ general rule")
> Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
> Acked-by: Song Liu <songliubraving@fb.com>

It seems to me that the two patches that comprise this series
should be combined as they seem to be fixing two halves of the same
problem.

> ---
>  tools/testing/selftests/bpf/Makefile | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
> index cc09b5df9403..b03dc2298fea 100644
> --- a/tools/testing/selftests/bpf/Makefile
> +++ b/tools/testing/selftests/bpf/Makefile
> @@ -38,7 +38,8 @@ TEST_GEN_PROGS += test_progs-bpf_gcc
>  endif
>  
>  TEST_GEN_FILES =
> -TEST_FILES = test_lwt_ip_encap.o
> +TEST_FILES = test_lwt_ip_encap.o \
> +	test_tc_edt.o
>  
>  # Order correspond to 'make run_tests' order
>  TEST_PROGS := test_kmod.sh \
> -- 
> 2.20.1
> 
