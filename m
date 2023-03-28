Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 001166CCA07
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Mar 2023 20:30:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229767AbjC1San (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 28 Mar 2023 14:30:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229693AbjC1Sam (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 28 Mar 2023 14:30:42 -0400
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45EEF19BC
        for <linux-kselftest@vger.kernel.org>; Tue, 28 Mar 2023 11:30:38 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id i6so16338306ybu.8
        for <linux-kselftest@vger.kernel.org>; Tue, 28 Mar 2023 11:30:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680028237;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yuuegu1cFbRg24plQOb38sIUWOVRgzcrx7ze3bOovCw=;
        b=EisE82n2osFxVjm+P56hUIztGP0SJpbOuCu+bnFrUJjzLGGVpT2AMhxGRhRvEmA+e2
         mwHDcinzo8KSut3L9WhHnDG/sBbyKItO3o5cOrsEclcaVTAdmsgDzbiHLetqMON/2c7R
         qpZOC3CsPKMtgEHwCwx1v1wiK2iAa31b/nQXGNFHbIbIzwDXJkIOYFqK/mwHKVOKMwGS
         eoPsvPi7xFBVvhTj0e8R8qCfZ78hkH22H8NGb+a9kyQqKqEAASHKv2y/b5mhdDZAjIMc
         uBbLtidGE9RRevnYtrdZjt5I7c3DLMwMWcWbUg99OolXIxTbL0WtfU/TrRwxVn+2cC6R
         hvFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680028237;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yuuegu1cFbRg24plQOb38sIUWOVRgzcrx7ze3bOovCw=;
        b=Mq5HtDwoVG6kvjzHwECFW2pFW62US1Qy/XxRif8AXpsHbMuPlJT+Xge65vyydTeSBo
         O6+3vzCuOtwFIANeJjkx1Vh5dFckt7kGo9zdJmzESgVMIaslVP3aZUwooACKgr/IHsrI
         MU/T7VJHHZX21ZfK5H4w/NZBxHXS8BcdQYYb7mbskbrzTZKtOClBdUtt154HtCTg2ZQQ
         9TmFxC0DKj6FRXjhIY8+s3d6+4v2KFRjqDDlHrQsnKQegTqfFOndognSDgrLOYnR1bhQ
         2yh7ZfwNMBwHH1M9nhQxS2ZMNeFeyIxKks6zzLwidI8gTbmG0JA5t0Zsn7nVGOLICC/R
         bQ6w==
X-Gm-Message-State: AAQBX9eGauIT02uiFsD+rvu+F9c4Bj9i+sONQxuBAqmufQXEB0J+KTxD
        01t06vE+gtt2YWMSqwWtE/oVqAS8gNu8wWsX49nBbxMJTJ3uWYWiJEQ=
X-Google-Smtp-Source: AKy350bdcqdugUTreAEdn+N2C6zWYXNTotXJWZHwzhwo68iZpT2NVGuPdqGaegdgwHn5bo8EA+DZTRUfdIbWCVZZmyQ=
X-Received: by 2002:a25:ef0e:0:b0:b6a:5594:5936 with SMTP id
 g14-20020a25ef0e000000b00b6a55945936mr10356788ybd.5.1680028237374; Tue, 28
 Mar 2023 11:30:37 -0700 (PDT)
MIME-Version: 1.0
References: <20230327115331.122562-1-hca@linux.ibm.com>
In-Reply-To: <20230327115331.122562-1-hca@linux.ibm.com>
From:   Rae Moar <rmoar@google.com>
Date:   Tue, 28 Mar 2023 14:30:22 -0400
Message-ID: <CA+GJov6YeJA5Hed=sLOdDY43WkwVrQ9i1dPsQ_inVdDhpBjUug@mail.gmail.com>
Subject: Re: [PATCH] kunit: increase KUNIT_LOG_SIZE to 2048 bytes
To:     Heiko Carstens <hca@linux.ibm.com>
Cc:     Brendan Higgins <brendan.higgins@linux.dev>,
        David Gow <davidgow@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Alexander Egorenkov <egorenar@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-15.7 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Mar 27, 2023 at 7:53=E2=80=AFAM Heiko Carstens <hca@linux.ibm.com> =
wrote:
>
> The s390 specific test_unwind kunit test has 39 parameterized tests. The
> results in debugfs are truncated since the full log doesn't fit into 1500
> bytes.
> Therefore increase KUNIT_LOG_SIZE to 2048 bytes in a similar way like it
> was done recently with commit "kunit: fix bug in debugfs logs of
> parameterized tests". With that the whole test result is present.
>
> Reported-by: Alexander Egorenkov <egorenar@linux.ibm.com>
> Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
> ---

This looks good to me. I don't see an issue increasing the log size.
Maybe eventually we could create a config option or test attribute for
a large log size but for now this seems good. Glad to see people are
starting to get use of the parameterized test logs after the debugfs
fixes.

Thanks!
-Rae

Reviewed-by: Rae Moar <rmoar@google.com>

>  include/kunit/test.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/include/kunit/test.h b/include/kunit/test.h
> index 9721584027d8..57b309c6ca27 100644
> --- a/include/kunit/test.h
> +++ b/include/kunit/test.h
> @@ -34,7 +34,7 @@ DECLARE_STATIC_KEY_FALSE(kunit_running);
>  struct kunit;
>
>  /* Size of log associated with test. */
> -#define KUNIT_LOG_SIZE 1500
> +#define KUNIT_LOG_SIZE 2048
>
>  /* Maximum size of parameter description string. */
>  #define KUNIT_PARAM_DESC_SIZE 128
> --
> 2.37.2
>
