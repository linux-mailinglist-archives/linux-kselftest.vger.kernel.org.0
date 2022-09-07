Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 925385B09A1
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Sep 2022 18:05:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230376AbiIGQFY (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 7 Sep 2022 12:05:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229604AbiIGQFE (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 7 Sep 2022 12:05:04 -0400
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5DDDBCCF6;
        Wed,  7 Sep 2022 09:03:28 -0700 (PDT)
Received: by mail-il1-x141.google.com with SMTP id l6so7793906ilk.13;
        Wed, 07 Sep 2022 09:03:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=lt1bpJM6pHMY/em4ZNsqZVuYS7ky1YDSS0Zv0T/sQCI=;
        b=jFrMQnAJyokhbea+zJXMZUcpgYdRpW6ftt5X8yDsUmyx2A4f77acUmlMItitO1FogO
         p0bEzPpuqSiuwlKsN8tybJJDylxM59F++Xmxy4P5f+e6/5m4LATaktIUyoghbJvS/faC
         CDzGmAW/QicbE8j6KYbsmSE/J19AMses1La/f2fg44SktusCjr2xneuPqsjpMAfBYCHn
         UPS3zWSx7vbgypW+5wJGwA5biGU+ZHb3LlbUMkkmWNyZuckczS+nu1IFmU/tfN0xIuBc
         7vbypb3c16FPIyTdjo2byYrd5Ce7ap9CY+J4YhWRm52GoiEDxedVnkj+Cfx53cDUSmrj
         CPoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=lt1bpJM6pHMY/em4ZNsqZVuYS7ky1YDSS0Zv0T/sQCI=;
        b=ze3Uc7zSJMaPjpVWvF1ztWN3mPjlJO61CQcR8BRJFtNNlhnAQtmIwo0phdrZCDxVtn
         LiS4aTiGt9tyM7YL8gVaKhD8QP8IdK1EYdh5WtkWaZh3v3EcS1tnMNCWCZmUN8gJXu5C
         Wn25edvZdPa6QkErAB3ctgO8KskxcYsWH8tamQl7BOUF32xXuYKzpiGCVbh9w8lz16fy
         B1aQfQITjb4S9VKOXhlvTmumfsLao4vk+rfFm+7jnT+qvE4wNb5z8jCU3LfMeBFoXIza
         jBxeJ2VH/00qa7nkCy2YbKwayzB+4F7vdzIQKj69R8d2o76BS5r2YjsQRwf7AdNfZXnZ
         b2Dg==
X-Gm-Message-State: ACgBeo1Z2lQomAOkdqp/Uqxp8PGSCWRDaMtjOLtJVj6OZ1xJk815Ycd0
        OLWteix1QeUpVx3OdqUJ73FGvlqouVHQNc42U0Q=
X-Google-Smtp-Source: AA6agR5D0yaJMaMJfVkyP7yo0j3n7J4Q2NxUTHD4GglycqC1kGl3Kap+m8RkpO7wuD2gzZZFsAnPWsgP2IfD+vK5xbs=
X-Received: by 2002:a05:6e02:1489:b0:2f1:a985:853 with SMTP id
 n9-20020a056e02148900b002f1a9850853mr2320169ilk.68.1662566607972; Wed, 07 Sep
 2022 09:03:27 -0700 (PDT)
MIME-Version: 1.0
References: <CAP01T74L7C+F7oiBx3fL9SahdvU-9rHpQ=GaLTj0XAfeOKaXrA@mail.gmail.com>
 <20220907145939.489784-1-roberto.sassu@huaweicloud.com>
In-Reply-To: <20220907145939.489784-1-roberto.sassu@huaweicloud.com>
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date:   Wed, 7 Sep 2022 18:02:51 +0200
Message-ID: <CAP01T77rgLz-ApBoXfegLCmensukK59-9=jh2CmuWsC0VVMzWw@mail.gmail.com>
Subject: Re: [PATCH v17 12/12] selftests/bpf: Add tests for dynamic pointers
 parameters in kfuncs
To:     Roberto Sassu <roberto.sassu@huaweicloud.com>
Cc:     andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org,
        daniel@iogearbox.net, deso@posteo.net, dhowells@redhat.com,
        haoluo@google.com, jarkko@kernel.org, jmorris@namei.org,
        john.fastabend@gmail.com, jolsa@kernel.org,
        keyrings@vger.kernel.org, kpsingh@kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-security-module@vger.kernel.org, martin.lau@linux.dev,
        mingo@redhat.com, mykolal@fb.com, paul@paul-moore.com,
        roberto.sassu@huawei.com, rostedt@goodmis.org, sdf@google.com,
        serge@hallyn.com, shuah@kernel.org, song@kernel.org, yhs@fb.com
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

On Wed, 7 Sept 2022 at 17:00, Roberto Sassu
<roberto.sassu@huaweicloud.com> wrote:
>
> From: Roberto Sassu <roberto.sassu@huawei.com>
>
> Add tests to ensure that only supported dynamic pointer types are accepted,
> that the passed argument is actually a dynamic pointer, that the passed
> argument is a pointer to the stack, and that bpf_verify_pkcs7_signature()
> correctly handles dynamic pointers with data set to NULL.
>
> The tests are currently in the deny list for s390x (JIT does not support
> calling kernel function).
>
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> ---

Just a minor nit: you could probably use invalid flags value other
than 1, since most likely the next valid flag value will be 1, which
will require changing this again. LGTM otherwise.

Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
