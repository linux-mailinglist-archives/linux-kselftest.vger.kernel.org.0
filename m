Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6C0A5B3C9D
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 Sep 2022 18:05:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229955AbiIIQFm (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 9 Sep 2022 12:05:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229845AbiIIQFl (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 9 Sep 2022 12:05:41 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 381C51269F8;
        Fri,  9 Sep 2022 09:05:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 963C2B82584;
        Fri,  9 Sep 2022 16:05:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43BF3C43142;
        Fri,  9 Sep 2022 16:05:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662739537;
        bh=vZdt9ixCZtMLcAI25GuWDIZT5TxgjuuYoXVx/JYGVGY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=odSrelK3eNCHpDgWE8Y3tTlD/NuoAGPqafEe+Bker9e8oMm6a2LIAJhSr0+1xukvV
         6yCeit3xFM4/NpIN/vJUAcWjZpLz8FesYCby1lFimWunO+zR7IqAwGzbsaLpIRfjNn
         Itk5K24hwseJ7RShTWP7wZscLn2qJoArckxSYgKp52s+jjKbH+NAt6rkjHMsHMM0CM
         hpwe810k33BLU0KXZIzdeg3Ckd5LrILTIx/nEdnykWbB7zvZy0LGvPCaRI5CyJ0GII
         6UWD4kfMJjFAT9xgwQos7feHJ57Ohq0WqOS0+R0RCRG4pNTMV4y6XqrEErhQEKzI9o
         ZyHYVyBpwL9zg==
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-1278a61bd57so5038146fac.7;
        Fri, 09 Sep 2022 09:05:37 -0700 (PDT)
X-Gm-Message-State: ACgBeo3aaPbEG+pOGskB2VnRI/Nvu809DZOEIBEL79YPcLtHXglM5G3Y
        BitYUAxfNHkrEWSE3r/i0riFPu/akuSEoBDXtXM=
X-Google-Smtp-Source: AA6agR4l0hQbiJb5tqPV7ginxf4L2jgOl514Oejh5l5k9dTzEz2tfwqmk7IGsBHhGG67/L3lxzVanhheUehYuKXgwFE=
X-Received: by 2002:a05:6870:32d2:b0:127:f0b4:418f with SMTP id
 r18-20020a05687032d200b00127f0b4418fmr5643550oac.22.1662739536321; Fri, 09
 Sep 2022 09:05:36 -0700 (PDT)
MIME-Version: 1.0
References: <20220909120736.1027040-1-roberto.sassu@huaweicloud.com> <20220909120736.1027040-7-roberto.sassu@huaweicloud.com>
In-Reply-To: <20220909120736.1027040-7-roberto.sassu@huaweicloud.com>
From:   Song Liu <song@kernel.org>
Date:   Fri, 9 Sep 2022 17:05:25 +0100
X-Gmail-Original-Message-ID: <CAPhsuW4wYaBOwJW8EWv4COggZFpbic8yCbfCJ_u-4QPNUTGWCw@mail.gmail.com>
Message-ID: <CAPhsuW4wYaBOwJW8EWv4COggZFpbic8yCbfCJ_u-4QPNUTGWCw@mail.gmail.com>
Subject: Re: [PATCH v17 06/12] bpf: Add bpf_lookup_*_key() and bpf_key_put() kfuncs
To:     Roberto Sassu <roberto.sassu@huaweicloud.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Mykola Lysenko <mykolal@fb.com>,
        David Howells <dhowells@redhat.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>, paul@paul-moore.com,
        jmorris@namei.org, serge@hallyn.com, Shuah Khan <shuah@kernel.org>,
        bpf <bpf@vger.kernel.org>, keyrings@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        open list <linux-kernel@vger.kernel.org>,
        =?UTF-8?Q?Daniel_M=C3=BCller?= <deso@posteo.net>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Roberto Sassu <roberto.sassu@huawei.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Sep 9, 2022 at 1:09 PM Roberto Sassu
<roberto.sassu@huaweicloud.com> wrote:
>
> From: Roberto Sassu <roberto.sassu@huawei.com>
>
> Add the bpf_lookup_user_key(), bpf_lookup_system_key() and bpf_key_put()
> kfuncs, to respectively search a key with a given key handle serial number
> and flags, obtain a key from a pre-determined ID defined in
> include/linux/verification.h, and cleanup.
>
> Introduce system_keyring_id_check() to validate the keyring ID parameter of
> bpf_lookup_system_key().
>
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>

Acked-by: Song Liu <song@kernel.org>

[...]
