Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EC8A717900
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 May 2023 09:52:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234769AbjEaHwv (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 31 May 2023 03:52:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234878AbjEaHwA (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 31 May 2023 03:52:00 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D695D10CB
        for <linux-kselftest@vger.kernel.org>; Wed, 31 May 2023 00:51:06 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id ffacd0b85a97d-30af86a96b4so1142503f8f.3
        for <linux-kselftest@vger.kernel.org>; Wed, 31 May 2023 00:51:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685519464; x=1688111464;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=aCiP4MMSibYW0/yekwWeN83nPjDqo+zmYCQqXPfMlsQ=;
        b=KxIFXc3XbPO+1gYgOOk/90oGm/JEIHXeR2xRaiberGS4qS5Ft1bgxYhViYOJ9s9u2G
         TPbiQ9+NRrBGoJ6eQeUm4EJcwNjBx+248VxuHpZeViPIYwvhD+oVqEljD8IvuMpoWTh1
         bo1HPvf++ADfbDTg3tQ2VgwHdN0GVyM1jqcz7d06N+Cf5sP/YW2UbgBV7IlZl+sxfVdh
         zq0gOxE9E3ARbDhXsx8kRBM4xjBy52oEiEd/QvnVMv65IRb1YXSEjb7jgyHs/veUura8
         NPFse5oBNr2AEkJseF5DIVcB2YmrqcqS5+QUv4zgUHvB6FHmOyc+K0yWvVPW8UAMKrMp
         wplQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685519464; x=1688111464;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aCiP4MMSibYW0/yekwWeN83nPjDqo+zmYCQqXPfMlsQ=;
        b=MTfKtka/MDeG0vCrRjFa/Ii3CyKBwCaTRTamnWCOsjhsIy1L38gcV7bpLIXoVgb3Nl
         gpbgIOrA5soW3oYpMv1PnO++TazIp/jGWUgxEg6TkBT8hj+46aCPzr5H5zMOXqvHBQtd
         UYJAQCOCc2UkkdmVxAHeL/w+fFHIvkfxDHnrjrH69wAeTPlB86vb3Rpcu7FBPbD7YyzS
         FcMlvuD9emPktpzPG2k2M9SEXcjdIX2WxGgO2hG3L7P/2emnChoLa8KkwNjSMEG8QTkw
         sXOG4O5tMavnwGMKayHuqeMxCVsLdDXuU/YN1wcCzOp+MCuPzzU95nPTsJfSah8fJjZ/
         Vh+g==
X-Gm-Message-State: AC+VfDw/tFkAxfUhnfrGJNIzmCvU9XmL+rUUq+EWU2Pxj0RVq+KYxqpx
        1zS+spt4qfs3IK/KVO79xoyl0wJqdPa8Voa9e0A=
X-Google-Smtp-Source: ACHHUZ74iLhzQbLTZgd+gSEU1rRIICluXbvzT8dhVDP0yuOM+iJ9KQ/9veKaCtGt6UjCh5xcmstC9w==
X-Received: by 2002:a5d:6084:0:b0:307:8c47:a266 with SMTP id w4-20020a5d6084000000b003078c47a266mr3278298wrt.61.1685519464415;
        Wed, 31 May 2023 00:51:04 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id g3-20020a5d46c3000000b002f28de9f73bsm5786231wrs.55.2023.05.31.00.51.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 May 2023 00:51:02 -0700 (PDT)
Date:   Wed, 31 May 2023 10:50:59 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     David Gow <davidgow@google.com>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Brendan Higgins <brendan.higgins@linux.dev>,
        Rae Moar <rmoar@google.com>,
        Daniel Latypov <dlatypov@google.com>,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kunit: Move kunit_abort() call out of
 kunit_do_failed_assertion()
Message-ID: <7faac99b-8bb9-4015-9b64-789587542d20@kili.mountain>
References: <20230531052158.1788232-1-davidgow@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230531052158.1788232-1-davidgow@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, May 31, 2023 at 01:21:57PM +0800, David Gow wrote:
> KUnit aborts the current thread when an assertion fails. Currently, this
> is done conditionally as part of the kunit_do_failed_assertion()
> function, but this hides the kunit_abort() call from the compiler
> (particularly if it's in another module). This, in turn, can lead to
> both suboptimal code generation (the compiler can't know if
> kunit_do_failed_assertion() will return), and to static analysis tools
> like smatch giving false positives.
> 
> Moving the kunit_abort() call into the macro should give the compiler
> and tools a better chance at understanding what's going on. Doing so
> requires exporting kunit_abort(), though it's recommended to continue to
> use assertions in lieu of aborting directly.
> 
> In addition, kunit_abort() and kunit_do_failed_assertion() are renamed
> to make it clear they they're intended for internal KUnit use, to:
> __kunit_do_failed_assertion() and __kunit_abort()
> 
> Suggested-by: Dan Carpenter <dan.carpenter@linaro.org>
> Signed-off-by: David Gow <davidgow@google.com>

Fantastic!  Thanks so much!

regards,
dan carpenter

