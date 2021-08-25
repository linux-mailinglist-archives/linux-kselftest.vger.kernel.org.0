Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5D853F721C
	for <lists+linux-kselftest@lfdr.de>; Wed, 25 Aug 2021 11:44:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239618AbhHYJou (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 25 Aug 2021 05:44:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239465AbhHYJot (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 25 Aug 2021 05:44:49 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE65CC06179A
        for <linux-kselftest@vger.kernel.org>; Wed, 25 Aug 2021 02:44:03 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id g13so51586548lfj.12
        for <linux-kselftest@vger.kernel.org>; Wed, 25 Aug 2021 02:44:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=references:user-agent:from:to:cc:subject:in-reply-to:date
         :message-id:mime-version;
        bh=mVBCLMrmtNi0cBtd2h0yR4rj69aPWXuUyL2zj6muVGc=;
        b=nvhJO0jOM9EWIg+YirpaPwyNot5o45tv1yCyrmltHv0cBZhd17TNcCrZ4atxwswTl4
         5uhYYq3S9cLZPs9WAV3wSBKLyJwPW/XfLAlH1kvqTSTPi58I/oU36SmUuST6bOGHp4Qb
         yh3p+qfKpVDwWAggGmGVFa8olBj3vQF2keIu4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:date:message-id:mime-version;
        bh=mVBCLMrmtNi0cBtd2h0yR4rj69aPWXuUyL2zj6muVGc=;
        b=IgrzjXmPZHbfnK1CdyfntZypAyDrx0j46/O2Ac3AAjibW9PMINdnNib3FgN+S1hJ2/
         l3XIYYXNbqW4uOuSatHzDk1ENvaJWJSau6vmh+sfh2TneIz1RZ63GoUB7TslZBDbfmWS
         8Byo/1CWQJz2wDPLCb4YVSxBLjFc7osUp6PtTm374CHTOhvjG9stcrD8R4WCgdeGrVy3
         3Xnc3T7lTgRiKs1dO6YgLnM/GBN2ubc2xufODnEuhByu3rmm9oNgdW/+xT9nYPSkBtSx
         /gsKURO+fDsYIj0egkKjjnefF0aadRoVVUy+YKKqxNATVvDmmyUWdleZm6wJh+WkdLhB
         YUnA==
X-Gm-Message-State: AOAM532kgh+p50PmHJEItXbtmco6LQuYNC1R3NykBwLj0KNyUWvGyej0
        G8JNB28chGMGHT6fgy/FU9HOIw==
X-Google-Smtp-Source: ABdhPJzCdAERMdrEjkk3bVyLtyl+jMyTKe5MEdSUZQWrko89ztd+kwzLWjgykYkketLnht4xsCSQ0Q==
X-Received: by 2002:ac2:4d52:: with SMTP id 18mr32810334lfp.550.1629884642112;
        Wed, 25 Aug 2021 02:44:02 -0700 (PDT)
Received: from cloudflare.com ([2a01:110f:480d:6f00:ff34:bf12:ef2:5071])
        by smtp.gmail.com with ESMTPSA id g25sm691895lfv.62.2021.08.25.02.44.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Aug 2021 02:44:01 -0700 (PDT)
References: <20210823030143.29937-1-po-hsu.lin@canonical.com>
User-agent: mu4e 1.1.0; emacs 27.2
From:   Jakub Sitnicki <jakub@cloudflare.com>
To:     Po-Hsu Lin <po-hsu.lin@canonical.com>
Cc:     linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
        hawk@kernel.org, kuba@kernel.org, davem@davemloft.net,
        kpsingh@kernel.org, john.fastabend@gmail.com, yhs@fb.com,
        songliubraving@fb.com, kafai@fb.com, andrii@kernel.org,
        daniel@iogearbox.net, ast@kernel.org, skhan@linuxfoundation.org
Subject: Re: [PATCH] selftests/bpf: Use kselftest skip code for skipped tests
In-reply-to: <20210823030143.29937-1-po-hsu.lin@canonical.com>
Date:   Wed, 25 Aug 2021 11:44:00 +0200
Message-ID: <87h7fdg8pr.fsf@cloudflare.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Aug 23, 2021 at 05:01 AM CEST, Po-Hsu Lin wrote:
> There are several test cases in the bpf directory are still using
> exit 0 when they need to be skipped. Use kselftest framework skip
> code instead so it can help us to distinguish the return status.
>
> Criterion to filter out what should be fixed in bpf directory:
>   grep -r "exit 0" -B1 | grep -i skip
>
> This change might cause some false-positives if people are running
> these test scripts directly and only checking their return codes,
> which will change from 0 to 4. However I think the impact should be
> small as most of our scripts here are already using this skip code.
> And there will be no such issue if running them with the kselftest
> framework.
>
> Signed-off-by: Po-Hsu Lin <po-hsu.lin@canonical.com>
> ---
>  tools/testing/selftests/bpf/test_bpftool_build.sh | 5 ++++-
>  tools/testing/selftests/bpf/test_xdp_meta.sh      | 5 ++++-
>  tools/testing/selftests/bpf/test_xdp_vlan.sh      | 7 +++++--
>  3 files changed, 13 insertions(+), 4 deletions(-)
>
> diff --git a/tools/testing/selftests/bpf/test_bpftool_build.sh b/tools/testing/selftests/bpf/test_bpftool_build.sh
> index ac349a5..b6fab1e 100755
> --- a/tools/testing/selftests/bpf/test_bpftool_build.sh
> +++ b/tools/testing/selftests/bpf/test_bpftool_build.sh
> @@ -1,6 +1,9 @@
>  #!/bin/bash
>  # SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>  
> +# Kselftest framework requirement - SKIP code is 4.
> +ksft_skip=4
> +
>  case $1 in
>  	-h|--help)
>  		echo -e "$0 [-j <n>]"
> @@ -22,7 +25,7 @@ KDIR_ROOT_DIR=$(realpath $PWD/$SCRIPT_REL_DIR/../../../../)
>  cd $KDIR_ROOT_DIR
>  if [ ! -e tools/bpf/bpftool/Makefile ]; then
>  	echo -e "skip:    bpftool files not found!\n"
> -	exit 0
> +	exit $ksft_skip
>  fi
>  
>  ERROR=0

This bit has been fixed a couple days ago by a similar change:

https://lore.kernel.org/bpf/20210820025549.28325-1-lizhijian@cn.fujitsu.com

> diff --git a/tools/testing/selftests/bpf/test_xdp_meta.sh b/tools/testing/selftests/bpf/test_xdp_meta.sh
> index 637fcf4..fd3f218 100755
> --- a/tools/testing/selftests/bpf/test_xdp_meta.sh
> +++ b/tools/testing/selftests/bpf/test_xdp_meta.sh
> @@ -1,5 +1,8 @@
>  #!/bin/sh
>  
> +# Kselftest framework requirement - SKIP code is 4.
> +ksft_skip=4
> +
>  cleanup()
>  {
>  	if [ "$?" = "0" ]; then

Would consider making it read-only:

  readonly KSFT_SKIP=4

[...]
