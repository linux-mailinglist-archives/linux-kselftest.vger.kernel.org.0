Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F9C347B04F
	for <lists+linux-kselftest@lfdr.de>; Mon, 20 Dec 2021 16:31:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238378AbhLTPbG (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 20 Dec 2021 10:31:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234881AbhLTPar (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 20 Dec 2021 10:30:47 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE040C0698C6
        for <linux-kselftest@vger.kernel.org>; Mon, 20 Dec 2021 07:27:05 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id j6so19070001edw.12
        for <linux-kselftest@vger.kernel.org>; Mon, 20 Dec 2021 07:27:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=elastic.co; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=AXpj1vp629gSs0ATSB+0fWXF2SHKFQXC0D6SE9fulsc=;
        b=HV5k2bEXzHRsIEW2knQNwXLdcLEhJ7QCZyTOHKHwiHLU7Vr1frm0j/3ct7MEi+TbAL
         auzpm+V+ijQ9uQ+CB1nDGDbzcGhhw62IBfOKo+yPFvQbucPjdnD01hYN1nKlHJxp+PI/
         hdDyhdzeOvVKxDZ8NAddL4hv3hlTzbzTn9ckM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=AXpj1vp629gSs0ATSB+0fWXF2SHKFQXC0D6SE9fulsc=;
        b=k2KIczASvIpFJrSfUyz/SprrlQammOZqTu9dhxp0xCgb+MEJ3+6lJFBEpJZzk1RIR/
         xN3bXKM3wnluzWQ87LqSqa100kP1paEG+8e5zkDk2t+ND5C4M3lZn+NhLoEcetfzAfNy
         BrYJ91vQG2AHm+YtDFvWjSH2UbYg35rBlT1J4rWm4Ad7ZP0EpJA8pDTExb6i8+F/5qT4
         CIu3+XLSU3J2LPunz/yU6kaE2R+JwTC5KgGRs/mK7pakCH2VZpblKe1NwFxmSOOrI6vp
         FsbrfBBYL6mZ9F+nMGJJ2VjvgeLbA3HWtPttLn9DcXKTvb+KMNvf7p5Y/Ggk//NlL2H6
         Rpvg==
X-Gm-Message-State: AOAM530iCC28tjPxSx4zhV6ueCjGhH51IH8zR/FWBJB9KDItqjCtzBJz
        vOm/J7ur6InyoBURtJYpo8tNQQ==
X-Google-Smtp-Source: ABdhPJwJGOV7KbK/D+HPi6v2dyWHGDUeD4dpoDpmquJ7tdFLpPw4IowXj6TxuLKTZEH04k2nSfcoEw==
X-Received: by 2002:a17:907:1c9c:: with SMTP id nb28mr13152129ejc.184.1640014024301;
        Mon, 20 Dec 2021 07:27:04 -0800 (PST)
Received: from localhost (host-82-50-106-104.retail.telecomitalia.it. [82.50.106.104])
        by smtp.gmail.com with ESMTPSA id f5sm5597778edu.38.2021.12.20.07.27.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Dec 2021 07:27:03 -0800 (PST)
Date:   Mon, 20 Dec 2021 16:27:01 +0100
From:   Lorenzo Fontana <lorenzo.fontana@elastic.co>
To:     Pu Lehui <pulehui@huawei.com>
Cc:     shuah@kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org,
        linux-kselftest@vger.kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next] selftests/bpf: Correct the INDEX address in
 vmtest.sh
Message-ID: <YcCgxQiEGLOd130m@workstation>
Mail-Followup-To: Lorenzo Fontana <lorenzo.fontana@elastic.co>,
        Pu Lehui <pulehui@huawei.com>, shuah@kernel.org, ast@kernel.org,
        daniel@iogearbox.net, andrii@kernel.org, kafai@fb.com,
        songliubraving@fb.com, yhs@fb.com, john.fastabend@gmail.com,
        kpsingh@kernel.org, linux-kselftest@vger.kernel.org,
        netdev@vger.kernel.org, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20211220050803.2670677-1-pulehui@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211220050803.2670677-1-pulehui@huawei.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Dec 20, 2021 at 05:08:03AM +0000, Pu Lehui wrote:
> Migration of vmtest to libbpf/ci will change the address
> of INDEX in vmtest.sh, which will cause vmtest.sh to not
> work due to the failure of rootfs fetching.
> 
> Signed-off-by: Pu Lehui <pulehui@huawei.com>
> ---
>  tools/testing/selftests/bpf/vmtest.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/bpf/vmtest.sh b/tools/testing/selftests/bpf/vmtest.sh
> index 5e43c79ddc6e..b3afd43549fa 100755
> --- a/tools/testing/selftests/bpf/vmtest.sh
> +++ b/tools/testing/selftests/bpf/vmtest.sh
> @@ -32,7 +32,7 @@ ROOTFS_IMAGE="root.img"
>  OUTPUT_DIR="$HOME/.bpf_selftests"
>  KCONFIG_URL="https://raw.githubusercontent.com/libbpf/libbpf/master/travis-ci/vmtest/configs/config-latest.${ARCH}"
>  KCONFIG_API_URL="https://api.github.com/repos/libbpf/libbpf/contents/travis-ci/vmtest/configs/config-latest.${ARCH}"
> -INDEX_URL="https://raw.githubusercontent.com/libbpf/libbpf/master/travis-ci/vmtest/configs/INDEX"
> +INDEX_URL="https://raw.githubusercontent.com/libbpf/ci/master/INDEX"
>  NUM_COMPILE_JOBS="$(nproc)"
>  LOG_FILE_BASE="$(date +"bpf_selftests.%Y-%m-%d_%H-%M-%S")"
>  LOG_FILE="${LOG_FILE_BASE}.log"
> -- 
> 2.25.1
> 

I was testing some failures with another patch and was about to do the
same.

Tested this in my environment.

Tested-by: Lorenzo Fontana <lorenzo.fontana@elastic.co>

Thanks!

-Lore
