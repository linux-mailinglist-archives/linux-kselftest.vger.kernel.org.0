Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23AAF4D88EE
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Mar 2022 17:18:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242940AbiCNQTf (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 14 Mar 2022 12:19:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242932AbiCNQTd (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 14 Mar 2022 12:19:33 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AC49FD3E
        for <linux-kselftest@vger.kernel.org>; Mon, 14 Mar 2022 09:18:22 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id qx21so35110737ejb.13
        for <linux-kselftest@vger.kernel.org>; Mon, 14 Mar 2022 09:18:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=geh31JjmgNWx5ruklOlb9OcIoz6waTuVoRaSRs47BzU=;
        b=Enq2pfXD4718fUK1qGIYNzfxh6gLp6gYvWlpoOX+opsFjk4MlAM5woUkcazkOTCoah
         CkuadOpxvrqyp9o+WuSg21I7x88nHviuCrwrDEbwCJ5jjC4/77X42nYCyZb2NjmeI4Wd
         Goaugm3+OtW7+zdBF9p8swNUc4SiOmEJWItPcH6RptjIIlvoO2yeAQUppyY7H1+StldH
         wlTHvsBwCk9Z7SUCGWry29PDB9LBhFoLYUKkCeC4/87SEwJzf1erdLyqJQIny7BsMekI
         ivaonQQOwnez1vOaIeaYHYbEeaMLVUwUc1bSEf8eaufczMIecqDPqzs4yZUWtenZlmgf
         ByQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=geh31JjmgNWx5ruklOlb9OcIoz6waTuVoRaSRs47BzU=;
        b=FXbvtlbvpGY+21Vsm+BCpVLITlTx2WQOCKhRgFRBlEwPl34LLAbs9bssDtBnPKojhr
         U7CkOk3pWWcNQZQzmXXu4b1fZHJAj0W5gUrt9Qvzwj/gfy0DUDcAktgNp+x6NVW+tOnE
         8dLlnMai9cUvqMWOL0MligzoLJSiqMnq7QbH2C+o0136MLJHfg8JPx6IO0z6gjeHuDO5
         M2sNGAmgL2E0t7XVkC4JaWcgbRGIcGOd3+lWaMWix7j2lx3DiC0CragZr9D7QYtpNTEK
         ZTCWJLI+DDbKHTLcoyE3F4OyC+UgZiRCxHQy4/eIdgYNBeaCwACL5YKnLpMc6gXIQWjr
         S07g==
X-Gm-Message-State: AOAM533RUbntG60z2AdCZ1EDhpF4opzwUabfmrQx3MLNfM35mcd/iBMj
        didBGYSbtush3JMWxwSslyEpd/wka/rO1Uq3t5Ap3zaRRBo=
X-Google-Smtp-Source: ABdhPJyJXWUIWeE0eLsn9QkFhL/gxlpQinKhevG1+ViqzjPGziTURcXeGN4fpJf9R/seHpCB5DB/xt8SuiOV4BG2dF4=
X-Received: by 2002:a17:906:2811:b0:6ce:eacf:5210 with SMTP id
 r17-20020a170906281100b006ceeacf5210mr19888730ejc.618.1647274700471; Mon, 14
 Mar 2022 09:18:20 -0700 (PDT)
MIME-Version: 1.0
References: <d0d460d7be0107a69e3c52477761a6fe694c1840.1646991629.git.guillaume.tucker@collabora.com>
In-Reply-To: <d0d460d7be0107a69e3c52477761a6fe694c1840.1646991629.git.guillaume.tucker@collabora.com>
From:   Guenter Roeck <groeck@google.com>
Date:   Mon, 14 Mar 2022 09:18:08 -0700
Message-ID: <CABXOdTcdgSSVTXDN0DjB+-2K+H76_YJeFrue_MFJmBkZQZu7JQ@mail.gmail.com>
Subject: Re: [PATCH v2] selftests, x86: fix how check_cc.sh is being invoked
To:     kernelci@groups.io,
        Guillaume Tucker <guillaume.tucker@collabora.com>
Cc:     Shuah Khan <shuah@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Borislav Petkov <bp@suse.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Collabora Kernel ML <kernel@collabora.com>,
        Linux MM <linux-mm@kvack.org>, linux-kselftest@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Mar 11, 2022 at 2:05 AM Guillaume Tucker
<guillaume.tucker@collabora.com> wrote:
>
> The $(CC) variable used in Makefiles could contain several arguments
> such as "ccache gcc".  These need to be passed as a single string to
> check_cc.sh, otherwise only the first argument will be used as the
> compiler command.  Without quotes, the $(CC) variable is passed as
> distinct arguments which causes the script to fail to build trivial
> programs.
>
> Fix this by adding quotes around $(CC) when calling check_cc.sh to
> pass the whole string as a single argument to the script even if it
> has several words such as "ccache gcc".
>
> Fixes: e9886ace222e ("selftests, x86: Rework x86 target architecture detection")
> Tested-by: "kernelci.org bot" <bot@kernelci.org>
> Signed-off-by: Guillaume Tucker <guillaume.tucker@collabora.com>

Reviewed-by: Guenter Roeck <groeck@google.com>

> ---
>
> Notes:
>     v2: rebase and drop changes in check_cc.sh
>
>  tools/testing/selftests/vm/Makefile  | 6 +++---
>  tools/testing/selftests/x86/Makefile | 6 +++---
>  2 files changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/tools/testing/selftests/vm/Makefile b/tools/testing/selftests/vm/Makefile
> index fbccdda93629..213f6a57d7f6 100644
> --- a/tools/testing/selftests/vm/Makefile
> +++ b/tools/testing/selftests/vm/Makefile
> @@ -54,9 +54,9 @@ TEST_GEN_FILES += split_huge_page_test
>  TEST_GEN_FILES += ksm_tests
>
>  ifeq ($(MACHINE),x86_64)
> -CAN_BUILD_I386 := $(shell ./../x86/check_cc.sh $(CC) ../x86/trivial_32bit_program.c -m32)
> -CAN_BUILD_X86_64 := $(shell ./../x86/check_cc.sh $(CC) ../x86/trivial_64bit_program.c)
> -CAN_BUILD_WITH_NOPIE := $(shell ./../x86/check_cc.sh $(CC) ../x86/trivial_program.c -no-pie)
> +CAN_BUILD_I386 := $(shell ./../x86/check_cc.sh "$(CC)" ../x86/trivial_32bit_program.c -m32)
> +CAN_BUILD_X86_64 := $(shell ./../x86/check_cc.sh "$(CC)" ../x86/trivial_64bit_program.c)
> +CAN_BUILD_WITH_NOPIE := $(shell ./../x86/check_cc.sh "$(CC)" ../x86/trivial_program.c -no-pie)
>
>  override TARGETS := protection_keys
>  BINARIES_32 := $(TARGETS:%=%_32)
> diff --git a/tools/testing/selftests/x86/Makefile b/tools/testing/selftests/x86/Makefile
> index 8a1f62ab3c8e..53df7d3893d3 100644
> --- a/tools/testing/selftests/x86/Makefile
> +++ b/tools/testing/selftests/x86/Makefile
> @@ -6,9 +6,9 @@ include ../lib.mk
>  .PHONY: all all_32 all_64 warn_32bit_failure clean
>
>  UNAME_M := $(shell uname -m)
> -CAN_BUILD_I386 := $(shell ./check_cc.sh $(CC) trivial_32bit_program.c -m32)
> -CAN_BUILD_X86_64 := $(shell ./check_cc.sh $(CC) trivial_64bit_program.c)
> -CAN_BUILD_WITH_NOPIE := $(shell ./check_cc.sh $(CC) trivial_program.c -no-pie)
> +CAN_BUILD_I386 := $(shell ./check_cc.sh "$(CC)" trivial_32bit_program.c -m32)
> +CAN_BUILD_X86_64 := $(shell ./check_cc.sh "$(CC)" trivial_64bit_program.c)
> +CAN_BUILD_WITH_NOPIE := $(shell ./check_cc.sh "$(CC)" trivial_program.c -no-pie)
>
>  TARGETS_C_BOTHBITS := single_step_syscall sysret_ss_attrs syscall_nt test_mremap_vdso \
>                         check_initial_reg_state sigreturn iopl ioperm \
> --
> 2.30.2
>
>
>
> ------------
> Groups.io Links: You receive all messages sent to this group.
> View/Reply Online (#1448): https://groups.io/g/kernelci/message/1448
> Mute This Topic: https://groups.io/mt/89707412/955378
> Group Owner: kernelci+owner@groups.io
> Unsubscribe: https://groups.io/g/kernelci/unsub [groeck@google.com]
> ------------
>
>
