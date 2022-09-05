Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0512C5AD99B
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 Sep 2022 21:27:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231475AbiIET1b (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 5 Sep 2022 15:27:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232304AbiIET1O (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 5 Sep 2022 15:27:14 -0400
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3812622512;
        Mon,  5 Sep 2022 12:27:02 -0700 (PDT)
Received: by mail-il1-x143.google.com with SMTP id s3so3049241ilv.4;
        Mon, 05 Sep 2022 12:27:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=okbKeeBWBjVpIAJiPzx493ODGSDGbaRaZtMV6fwikf4=;
        b=DZVQ7G1dtNGpG2nPDFL5GYqXFWFqPGklfB9ivgGQ2aCtoZSVxhOJyyuxYcx/PLshpS
         eSj9Sv5axF7UzOIXn9yXOaw+jPNw992t4wHUi2xwtOYQ6ox9jnaWWL9usAll9xELHad1
         ibWS4xJpQp9tAZ8kebQ7eS9h7d6ap6iFpnqnq39WDERLgwlpZ8FpEQ388Iz3s+jowlTz
         9qOONIiPtusL21h0GTRdwelC5MkTob0xEq8QeK73WPkLq+LQ2+vg9p0eeGGJttA5J8i5
         i27lgI87U0M0oz4nAyDEW+uUPERt27Js/x+KR0XoGCcOdzx/k5hu9mQLAQCdxJuytVe1
         glFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=okbKeeBWBjVpIAJiPzx493ODGSDGbaRaZtMV6fwikf4=;
        b=dRF98ZEm7djJegh6Uh5Wp9dCzJKbHY2OaVOoF9W6uGtJaaGpQ4bgzRfl+TCV/0IhBR
         +iqj38DxLw4oXcHTQ7POHEikmOjCWlSMxFlF9T0Oto+jmucsU5jQJ9QbtSgfAXACgYZc
         JHOdyUiuH1M+DzRSNNX7pIAGO0/DAdeA7B9pI4iof4pKTjNsjwmnQtTwk3/3tHc9ju9U
         ToMUAx0c8ioijhFwBIP+aegQuYSF32Jk4pNNNFyiChqxcLov2q8YWZ+gWfzB+WgteWwX
         IYNMIxKYbrdEpS4iUPNy8kDx1CcRKq/g+Rh9hl5QPpw02/iLXmrkmbFE8tZ9EZc58+HJ
         KQvQ==
X-Gm-Message-State: ACgBeo0D2axlqFNtdqpgJ8sTI8ynX4mYkVOX7Tpmc9T1GBdH07jVYtEZ
        NzwVdmbnRWA7FBKIQPel35osCJfVRG7cKwhglCIXh+uO794=
X-Google-Smtp-Source: AA6agR4UHGlM1wnVx+7B4pMceGklI3ut/1Hp4jDMKF72vpHZsmVqw49fXPSrCWb1lWNFsrLNyVlaIRExi0CYCpBsOyo=
X-Received: by 2002:a05:6e02:170f:b0:2f1:6cdf:6f32 with SMTP id
 u15-20020a056e02170f00b002f16cdf6f32mr3321677ill.216.1662406021617; Mon, 05
 Sep 2022 12:27:01 -0700 (PDT)
MIME-Version: 1.0
References: <20220905143318.1592015-1-roberto.sassu@huaweicloud.com>
In-Reply-To: <20220905143318.1592015-1-roberto.sassu@huaweicloud.com>
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date:   Mon, 5 Sep 2022 21:26:25 +0200
Message-ID: <CAP01T77aq-UP02JYp1Vu-LE--K1ieCyfKfyZPw-a7DDKQ7_F+g@mail.gmail.com>
Subject: Re: [PATCH v16 00/12] bpf: Add kfuncs for PKCS#7 signature verification
To:     Roberto Sassu <roberto.sassu@huaweicloud.com>
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, mykolal@fb.com,
        dhowells@redhat.com, jarkko@kernel.org, rostedt@goodmis.org,
        mingo@redhat.com, paul@paul-moore.com, jmorris@namei.org,
        serge@hallyn.com, shuah@kernel.org, bpf@vger.kernel.org,
        keyrings@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        deso@posteo.net, Roberto Sassu <roberto.sassu@huawei.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, 5 Sept 2022 at 16:34, Roberto Sassu
<roberto.sassu@huaweicloud.com> wrote:
>
> From: Roberto Sassu <roberto.sassu@huawei.com>
>
> One of the desirable features in security is the ability to restrict import
> of data to a given system based on data authenticity. If data import can be
> restricted, it would be possible to enforce a system-wide policy based on
> the signing keys the system owner trusts.
>
> This feature is widely used in the kernel. For example, if the restriction
> is enabled, kernel modules can be plugged in only if they are signed with a
> key whose public part is in the primary or secondary keyring.
>
> For eBPF, it can be useful as well. For example, it might be useful to
> authenticate data an eBPF program makes security decisions on.
>
> [...]

CI is crashing with NULL deref for test_progs-no_alu32 with llvm-16,
but I don't think the problem is in this series. This is most likely
unrelated to BPF, as the crash happens inside
kernel/time/tick-sched.c:tick_nohz_restart_sched_tick.

This was the same case in
https://lore.kernel.org/bpf/CAP01T74steDfP6O8QOshoto3e3RnHhKtAeTbnrPBZS3YJXjvbA@mail.gmail.com.

So, https://github.com/kernel-patches/bpf/runs/8194263557?check_suite_focus=true
and https://github.com/kernel-patches/bpf/runs/7982907380?check_suite_focus=true

look similar to me, and may not be related to BPF. They only trigger
during runs compiled using LLVM 16, so maybe some compiler
transformation is surfacing the problem?
