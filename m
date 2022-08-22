Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E84759BBFA
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Aug 2022 10:50:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233238AbiHVItt (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 22 Aug 2022 04:49:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232048AbiHVItl (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 22 Aug 2022 04:49:41 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30A712E6A6;
        Mon, 22 Aug 2022 01:49:37 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id x19so9309988plc.5;
        Mon, 22 Aug 2022 01:49:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=iCDhhI8vpKAF6ccQbhIqtzhgqF2l3okiXUrZiiXnnm0=;
        b=W9Bhg7iSBNOgvnU4J2cCOmqNHfLa6kD+gS/Usqk3AknhHc4v+WiAGy+JIEpPk93F0v
         ZshHrlelmZNNgf8KNqLcb2tdv1RVNyQ8n2r9V1LafUXbS29Nfdmtx3Bk4T2UYNjQbWdQ
         IROe8E7Zl0eewBHK1sXgs9MmGbJECKFYcUSw81vfilrCvGg+ZbUA4gOLuTUO6Q7BEYJe
         MN+Wo90tD7jV4sH/X4vyuwR3x5Dph7r+EdaKdioVD6yx07RcnroQp+rGacCErIWwFtuE
         QhTbdQdv1J//jmz2eZQHWOI5vKSy3TwcG8mOESrZt1vrbVa3t25yUqVLuSQfBzvMQnt4
         I0Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=iCDhhI8vpKAF6ccQbhIqtzhgqF2l3okiXUrZiiXnnm0=;
        b=VcMRJ34isvyMSdDDD+OPbnMLfThLay1pBwGTa4GBu5tmRA82NvFljBJ6wGWtZmk0Gv
         ttjLVwjGt/z9Wd8vCgSvltjhb02ItUACWx5dbUg26w//0c35j2aQuUOWJ1gHiTKpwxp0
         8xehUYDBnF1cCLL/M4u6T/1NIghMYeTgDcTXV8DOmbIA5F1TzoIyrYCry/sjvjPuc6HG
         kSvVcajYXYKrN+4xOGBLDnfOe2wCtNMtH0vLPXzYz7eELVLTPNEjO/EXzTrHOEngVDFH
         cw66SJFNfmv4mxbHN9qb15lXmpyvDZ/73uQCUgvVYa08ImSIYmwROs/qVbVoqa2a9RId
         892g==
X-Gm-Message-State: ACgBeo1tHY5uzHESZIGo3aDsoiqi3fwNjyTNlaY5Ygv9FOH3bZoWMqKg
        iqxe2heRrwE4a9biylT94YE=
X-Google-Smtp-Source: AA6agR6cvVQaqLj53v88y85bXAGnA2dBM9QOcc34rNSyJrlGP9xIQiKAtSUBCGRWwgaBCUY9lmf8Ow==
X-Received: by 2002:a17:903:2602:b0:172:ba94:1590 with SMTP id jd2-20020a170903260200b00172ba941590mr17217787plb.146.1661158177309;
        Mon, 22 Aug 2022 01:49:37 -0700 (PDT)
Received: from fedora ([103.230.148.185])
        by smtp.gmail.com with ESMTPSA id c2-20020a634e02000000b00401a9bc0f33sm6874136pgb.85.2022.08.22.01.49.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Aug 2022 01:49:36 -0700 (PDT)
Date:   Mon, 22 Aug 2022 14:19:28 +0530
From:   Gautam Menghani <gautammenghani201@gmail.com>
To:     keescook@chromium.org, shuah@kernel.org, brauner@kernel.org,
        paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, guoren@kernel.org
Cc:     luto@amacapital.net, wad@chromium.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, bpf@vger.kernel.org,
        linux-csky@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [PATCH] selftests/seccomp: Check CAP_SYS_ADMIN capability in the
 test mode_filter_without_nnp
Message-ID: <YwNDGAVrik3DvWZf@fedora>
References: <20220731092529.28760-1-gautammenghani201@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220731092529.28760-1-gautammenghani201@gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sun, Jul 31, 2022 at 02:55:29PM +0530, Gautam Menghani wrote:
> In the "mode_filter_without_nnp" test in seccomp_bpf, there is currently
> a TODO which asks to check the capability CAP_SYS_ADMIN instead of euid.
> This patch adds support to check if the calling process has the flag 
> CAP_SYS_ADMIN, and also if this flag has CAP_EFFECTIVE set.
> 
> Signed-off-by: Gautam Menghani <gautammenghani201@gmail.com>
> ---
>  tools/testing/selftests/seccomp/seccomp_bpf.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/testing/selftests/seccomp/seccomp_bpf.c b/tools/testing/selftests/seccomp/seccomp_bpf.c
> index 136df5b76319..16b0edc520ef 100644
> --- a/tools/testing/selftests/seccomp/seccomp_bpf.c
> +++ b/tools/testing/selftests/seccomp/seccomp_bpf.c
> @@ -392,6 +392,8 @@ TEST(mode_filter_without_nnp)
>  		.filter = filter,
>  	};
>  	long ret;
> +	cap_t cap = cap_get_proc();
> +	cap_flag_value_t is_cap_sys_admin = 0;
>  
>  	ret = prctl(PR_GET_NO_NEW_PRIVS, 0, NULL, 0, 0);
>  	ASSERT_LE(0, ret) {
> @@ -400,8 +402,8 @@ TEST(mode_filter_without_nnp)
>  	errno = 0;
>  	ret = prctl(PR_SET_SECCOMP, SECCOMP_MODE_FILTER, &prog, 0, 0);
>  	/* Succeeds with CAP_SYS_ADMIN, fails without */
> -	/* TODO(wad) check caps not euid */
> -	if (geteuid()) {
> +	cap_get_flag(cap, CAP_SYS_ADMIN, CAP_EFFECTIVE, &is_cap_sys_admin);
> +	if (!is_cap_sys_admin) {
>  		EXPECT_EQ(-1, ret);
>  		EXPECT_EQ(EACCES, errno);
>  	} else {
> -- 
> 2.34.1
> 

Hi,

Please review the above patch and let me know if any changes are required.

Thanks,
Gautam
