Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E278A5F7720
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Oct 2022 12:59:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229714AbiJGK72 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 7 Oct 2022 06:59:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229711AbiJGK7Y (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 7 Oct 2022 06:59:24 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5C14F4716;
        Fri,  7 Oct 2022 03:59:21 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id e18so2655555wmq.3;
        Fri, 07 Oct 2022 03:59:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4xuYpdOCao3sDT55XW73n6bDSmtjOmU2U3ZcDnvfdKE=;
        b=BIvfQq4idd3t691vh764uDJKOGb49pL/7opERG7wAs1b2yCS8bC8clOM5yNVVAMA92
         sFG47oFvt6U6o1JTvGCovCBxey4SUPq4vKSDhIehfSSN9c3Pf1jTmlYXoZFg4PB9619P
         AuysXMHBKLFmjLthaRtzacjUkoFypr6PLVmXwMFNtapGdOAYeQj7CVnB/sgwPBy8AZ1X
         OyMmWPjzRN6t5dE6yScJD8nzj99aYXvRuhmNpAIEIXGHMHd8t6hxsXx1G2wkRIxhLLL5
         xBDMoJu+ZfQ4T162O9A70HAEB0Cm5uq7ABVrv1Aiw9RrRLuH84iwmzsVolm/sK46fAav
         4Hlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4xuYpdOCao3sDT55XW73n6bDSmtjOmU2U3ZcDnvfdKE=;
        b=1JTK5jBeVrdyEs736yo1PbSI40GApkZspqtt2csLOU4x+P2lbJUOhVCtw7iUR5WtGq
         WRBiE9iCSMi2J+3i3zB3npNIBsThFfrBKzcmtAxRQNMQd1FWQgUsq2yWh6F8bcgsN51I
         arOSWpJp94cFQJlt3Pm8xoIFE709UVkHL0C5tuq9sayovCM9jLTl2uyMC2B9wzX6MB74
         PgCrDxRpPMFfjm+XQwT0YnGvLMCb/+z54Gq/y+jbcithhbR7dolAOQm/wf/hi7Mit5Fb
         6FS3rkMmd0vXkrOs7txUFjuzQ8MXHo43lCmMACuW6ygqp9Phjja7NTCyeY+bCyfXhLHv
         eeUQ==
X-Gm-Message-State: ACrzQf1xFJdEZ0JYMYSbhTSi+9OuYjTH90rQWTqfuN2yK6GAe1Vn3Gzv
        jrkvjVEGCLDUH6WrvVJx6F8=
X-Google-Smtp-Source: AMsMyM6aannlvXhQfW2nf2R4CZXzYUqAGhcL33fsPjx5d4IL3jxsSgAUsY38N2ek1YjKVADlFetQmQ==
X-Received: by 2002:a05:600c:4e4d:b0:3b4:7659:38c with SMTP id e13-20020a05600c4e4d00b003b47659038cmr9886765wmq.176.1665140360286;
        Fri, 07 Oct 2022 03:59:20 -0700 (PDT)
Received: from krava ([193.85.244.190])
        by smtp.gmail.com with ESMTPSA id p16-20020a1c5450000000b003c00203fb81sm6542310wmi.7.2022.10.07.03.59.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Oct 2022 03:59:20 -0700 (PDT)
From:   Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date:   Fri, 7 Oct 2022 12:59:17 +0200
To:     Roberto Sassu <roberto.sassu@huaweicloud.com>
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, mykolal@fb.com, shuah@kernel.org,
        bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Roberto Sassu <roberto.sassu@huawei.com>
Subject: Re: [PATCH v2 0/6] Add _opts variant for bpf_*_get_fd_by_id()
Message-ID: <Y0AGhW4USeB4sHU3@krava>
References: <20221006110736.84253-1-roberto.sassu@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221006110736.84253-1-roberto.sassu@huaweicloud.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Oct 06, 2022 at 01:07:30PM +0200, Roberto Sassu wrote:
> From: Roberto Sassu <roberto.sassu@huawei.com>
> 
> Add the _opts variant for bpf_*_get_fd_by_id() functions, to be able to
> pass to the kernel more options, when requesting a fd of an eBPF object.
> 
> Pass the options through a newly introduced structure,
> bpf_get_fd_by_id_opts, which currently contains open_flags (the other two
> members are for compatibility and for padding).
> 
> open_flags allows the caller to request specific permissions to access a
> map (e.g. read-only). This is useful for example in the situation where a
> map is write-protected.
> 
> Besides patches 2-6, which introduce the new variants and the data
> structure, patch 1 fixes the LIBBPF_1.0.0 declaration in libbpf.map.
> 
> Changelog
> 
> v1:
>  - Don't CC stable kernel mailing list for patch 1 (suggested by Andrii)
>  - Rename bpf_get_fd_opts struct to bpf_get_fd_by_id_opts (suggested by
>    Andrii)
>  - Move declaration of _opts variants after non-opts variants (suggested by
>    Andrii)
>  - Correctly initialize bpf_map_info, fix style issues, use map from
>    skeleton, check valid fd in the test (suggested by Andrii)
>  - Rename libbpf_get_fd_opts test to libbpf_get_fd_by_id_opts
> 
> Roberto Sassu (6):
>   libbpf: Fix LIBBPF_1.0.0 declaration in libbpf.map
>   libbpf: Introduce bpf_get_fd_by_id_opts and
>     bpf_map_get_fd_by_id_opts()
>   libbpf: Introduce bpf_prog_get_fd_by_id_opts()
>   libbpf: Introduce bpf_btf_get_fd_by_id_opts()
>   libbpf: Introduce bpf_link_get_fd_by_id_opts()
>   selftests/bpf: Add tests for _opts variants of bpf_*_get_fd_by_id()

it's not marked, but I'm assuming this goes to bpf-next, right?

anyway, lgtm

Acked-by: Jiri Olsa <jolsa@kernel.org>

thanks,
jirka

> 
>  tools/lib/bpf/bpf.c                           | 48 +++++++++-
>  tools/lib/bpf/bpf.h                           | 16 ++++
>  tools/lib/bpf/libbpf.map                      |  6 +-
>  tools/testing/selftests/bpf/DENYLIST.s390x    |  1 +
>  .../bpf/prog_tests/libbpf_get_fd_by_id_opts.c | 87 +++++++++++++++++++
>  .../bpf/progs/test_libbpf_get_fd_by_id_opts.c | 36 ++++++++
>  6 files changed, 189 insertions(+), 5 deletions(-)
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/libbpf_get_fd_by_id_opts.c
>  create mode 100644 tools/testing/selftests/bpf/progs/test_libbpf_get_fd_by_id_opts.c
> 
> -- 
> 2.25.1
> 
