Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB6F5596071
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Aug 2022 18:40:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236561AbiHPQjo (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 16 Aug 2022 12:39:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235798AbiHPQjn (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 16 Aug 2022 12:39:43 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C18527D1DD;
        Tue, 16 Aug 2022 09:39:41 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id i14so19928517ejg.6;
        Tue, 16 Aug 2022 09:39:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=iaPjCYZgo5E7q90joQujnSp+771XiMnhGhIUF8A0osw=;
        b=FPh1mYpWX1kXNGRpv2OtRUKw0nrwqX4WOSfq2AvHSc4EDDOa9vuSlGBBhQw5VGxVZo
         me2KEsOIj/b2nCeEWXyrnZ9xo45gYizz+p0O55vh1TuXke4Chc0BwzB2hQvW9dqBCqwi
         +voyJye42aXpa9PSp4LARDR5OVlMAT1GywsdrnEuIhoApQ0+XBmPOQd2nWxKRhtE0sK/
         UURQd0bRVHSeV4sw7a9ETtKp6KJ9GvXZprN7U7F2f8Djivcrr8j+tAeW3Zw0UQM+8WtR
         GgYFiLmIM3OPA3IHoFfgfmt0z+EAVrPCM62ARF9TZCtysY29D3VVWwX9SNHkd44mDknB
         s59g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=iaPjCYZgo5E7q90joQujnSp+771XiMnhGhIUF8A0osw=;
        b=lp2eszvrQHFW34IdE3Gx4onJzrW2KdSWfU4MOIDb9Jr4AF0rBEvrFR6pCir0r4Q5Eb
         IGYqIqDvi902kd1yMvoGa3+KjXZkm7Lhqxplg++VIujUTeIH99JYzNXK+7WWuOA/b1rJ
         Oh4fO3SWCFsez9yACyZybTTDNAY3+YSpXlferuFJwnCy2jZ+96n2iT9O5ta6NmQ2e2hr
         7l80fa+ntS9EEBuuKftOfoQ3CTNaBP6CMJVty7t4irzk4M+Hzt4guh4oCfJ/uQHzJXAP
         n3V7B8jm57b9ClxTHurhIEjOaTK9d0k6FDsPKSJ04Sp6iblRS+Ry19qm2qPDHFRUne4S
         YhDQ==
X-Gm-Message-State: ACgBeo2CANEImU6BTEHmOCG8xmzKv/Z27rESnkVDU4biGP6OL7jsFb4k
        aqaHmKsY1o6NRSWYvYa/RbrJXXlbojXPx1Ota28=
X-Google-Smtp-Source: AA6agR6CVIWn3ph0TlBX1tyLLXQZhWJUJdPVsI1GiXe2PFPhFhhuvFgawG9EUtU9XUnOOWSp83GxQqb13jXb+Z/LAsw=
X-Received: by 2002:a17:907:2896:b0:730:983c:4621 with SMTP id
 em22-20020a170907289600b00730983c4621mr14063824ejc.502.1660667980256; Tue, 16
 Aug 2022 09:39:40 -0700 (PDT)
MIME-Version: 1.0
References: <20220812101902.2846182-1-roberto.sassu@huawei.com>
 <14032690-e7a9-9d14-1ec1-14dd3503037c@iogearbox.net> <b61eb3b95843409eb6ab03aea4a0ca30@huawei.com>
 <be1fdbba-73ba-3106-622e-57ef5f471a26@iogearbox.net> <f54e27659dce49ee93d5feafa46f5477@huawei.com>
In-Reply-To: <f54e27659dce49ee93d5feafa46f5477@huawei.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Tue, 16 Aug 2022 09:39:28 -0700
Message-ID: <CAADnVQJT_X-oX4czQ2dT1qFKwf4N5wRaSCTV-KzH5-p-1b4yfQ@mail.gmail.com>
Subject: Re: [PATCH v11 0/9] bpf: Add kfuncs for PKCS#7 signature verification
To:     Roberto Sassu <roberto.sassu@huawei.com>
Cc:     Daniel Borkmann <daniel@iogearbox.net>,
        "ast@kernel.org" <ast@kernel.org>,
        "andrii@kernel.org" <andrii@kernel.org>,
        "martin.lau@linux.dev" <martin.lau@linux.dev>,
        "song@kernel.org" <song@kernel.org>, "yhs@fb.com" <yhs@fb.com>,
        "john.fastabend@gmail.com" <john.fastabend@gmail.com>,
        "kpsingh@kernel.org" <kpsingh@kernel.org>,
        "sdf@google.com" <sdf@google.com>,
        "haoluo@google.com" <haoluo@google.com>,
        "jolsa@kernel.org" <jolsa@kernel.org>,
        "mykolal@fb.com" <mykolal@fb.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "dhowells@redhat.com" <dhowells@redhat.com>,
        "jarkko@kernel.org" <jarkko@kernel.org>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "paul@paul-moore.com" <paul@paul-moore.com>,
        "jmorris@namei.org" <jmorris@namei.org>,
        "serge@hallyn.com" <serge@hallyn.com>,
        "shuah@kernel.org" <shuah@kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "keyrings@vger.kernel.org" <keyrings@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
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

Roberto,

please use a different email provider,
since gmail classifies all of your emails as spam.
I've seen other huawei folks use huaweicloud.com.
