Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 707A75909B1
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Aug 2022 02:54:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234273AbiHLAyr (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 11 Aug 2022 20:54:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235966AbiHLAyr (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 11 Aug 2022 20:54:47 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55376A1D7F
        for <linux-kselftest@vger.kernel.org>; Thu, 11 Aug 2022 17:54:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0975DB82334
        for <linux-kselftest@vger.kernel.org>; Fri, 12 Aug 2022 00:54:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0052C43140
        for <linux-kselftest@vger.kernel.org>; Fri, 12 Aug 2022 00:54:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660265683;
        bh=ko4LsCzf56xt2ligcUqqBjSthEnXoJd5Td0ClHErlH0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=oAR26MJNnSfoUozY1EEMzpLLBEWphku2dRq7PjCLW9SAroz2JocVpwvH4UaEQB7ZW
         aPDnQXr3xrRNgBfgoLDLNVxYWa7qwi7bPrg6AW5NqSjAJHX+XnNy+isMsISdhiD0D1
         9asy995BAXALl75xSbQYhy9+rn2EbE9AELblFCnNqNr+0CNLWM20qI/gJytvrO3VEn
         7jUKidSnOBnRzEUhsaCLLRmz2eTjtLEfNiGT5XMpo07gZneCsfh2pF851lF9IlUrVk
         G+nIP7midkkMqsitmSHixZIayL+q9Pt8dssxsZziD/pxNaoTnnJPj9ZOrqWA0W+QHp
         IGG2X/HBR30dw==
Received: by mail-yb1-f176.google.com with SMTP id e127so30789214yba.12
        for <linux-kselftest@vger.kernel.org>; Thu, 11 Aug 2022 17:54:43 -0700 (PDT)
X-Gm-Message-State: ACgBeo0ZI+4q9ZXjs8TcrKU198iU5z9P5soR2hU60OtOITeL+EG3sNmY
        t7ffuWiiiayz5eFHsLIqZUD0da/rcW6a1tbbztWVZw==
X-Google-Smtp-Source: AA6agR7MkYt6y5J9PCZiVOwauRd/hdvFE5aDqGKBjAEfRLqRib+sSpPOU1Cb2FNHuGCtCTe6wX55IJCt1sl1YbwMk1w=
X-Received: by 2002:a25:bfca:0:b0:676:a583:e215 with SMTP id
 q10-20020a25bfca000000b00676a583e215mr1824268ybm.131.1660265671902; Thu, 11
 Aug 2022 17:54:31 -0700 (PDT)
MIME-Version: 1.0
References: <20220810165932.2143413-1-roberto.sassu@huawei.com> <20220810165932.2143413-7-roberto.sassu@huawei.com>
In-Reply-To: <20220810165932.2143413-7-roberto.sassu@huawei.com>
From:   KP Singh <kpsingh@kernel.org>
Date:   Fri, 12 Aug 2022 02:54:21 +0200
X-Gmail-Original-Message-ID: <CACYkzJ5ZCtgdCz=kBdUAkhD6UyzspqMsNyC32_VR0aLt=a3Okg@mail.gmail.com>
Message-ID: <CACYkzJ5ZCtgdCz=kBdUAkhD6UyzspqMsNyC32_VR0aLt=a3Okg@mail.gmail.com>
Subject: Re: [PATCH v10 6/9] bpf: Add bpf_verify_pkcs7_signature() kfunc
To:     Roberto Sassu <roberto.sassu@huawei.com>
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, sdf@google.com, haoluo@google.com,
        jolsa@kernel.org, corbet@lwn.net, dhowells@redhat.com,
        jarkko@kernel.org, rostedt@goodmis.org, mingo@redhat.com,
        paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com,
        shuah@kernel.org, bpf@vger.kernel.org, linux-doc@vger.kernel.org,
        keyrings@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Aug 10, 2022 at 7:01 PM Roberto Sassu <roberto.sassu@huawei.com> wrote:
>
> Add the bpf_verify_pkcs7_signature() kfunc, to give eBPF security modules
> the ability to check the validity of a signature against supplied data, by
> using user-provided or system-provided keys as trust anchor.
>
> The new kfunc makes it possible to enforce mandatory policies, as eBPF
> programs might be allowed to make security decisions only based on data
> sources the system administrator approves.
>
> The caller should provide the data to be verified and the signature as eBPF
> dynamic pointers (to minimize the number of parameters) and a bpf_key
> structure containing a reference to the keyring with keys trusted for
> signature verification, obtained from bpf_lookup_user_key() or
> bpf_lookup_system_key().
>
> For bpf_key structures obtained from the former lookup function,
> bpf_verify_pkcs7_signature() completes the permission check deferred by
> that function by calling key_validate(). key_task_permission() is already
> called by the PKCS#7 code.
>
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>

Acked-by: KP Singh <kpsingh@kernel.org>
