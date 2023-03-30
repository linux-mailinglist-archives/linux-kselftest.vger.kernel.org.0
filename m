Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87ABD6CF802
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 Mar 2023 02:11:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230241AbjC3ALd (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 29 Mar 2023 20:11:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229694AbjC3ALb (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 29 Mar 2023 20:11:31 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 962AE4C15
        for <linux-kselftest@vger.kernel.org>; Wed, 29 Mar 2023 17:11:06 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id r11so70006997edd.5
        for <linux-kselftest@vger.kernel.org>; Wed, 29 Mar 2023 17:11:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680135059;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zS7IQPDMiW/+hW+Ioye+W55SPe8UpMOLvNbr97Z2oxM=;
        b=MtcLTgzXeaOaGjVyhZXXnEZhyKHbd/mszjzjeBuOS7ayzlKN4JbJRb6qAhRpwKCUC9
         WI98oqReLXyzvL8wl+U6rTPzz0Il0jUjFlHCEBSWvbX5zpWc4988i5PJtbzkGvV/gFCL
         CxA9EzhGU4PzCncX/CrN2IxyXYFghWaV7Kh9MVlW+Nu9SExQsscjwKIXIABkji1j7lMY
         jmKNzVu89DjiNc18Y6iLXcPz1SewEhn/SeDhLJpaMr4pnX78Gc/pij8HbFcFgH8wFnkv
         nt/8JHRKbYf8Ra0C3AdoBtMSKjCbRGxOo1/QzcoXKe1jzyZMcbd2TseVaIohEie11Xt0
         Tgrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680135059;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zS7IQPDMiW/+hW+Ioye+W55SPe8UpMOLvNbr97Z2oxM=;
        b=vBCh04PTOKM+M2oS1HOMZ1K3CNjfQppCtFajdbTRkbDWnRPh3Wxz64rqFhAZseUlgk
         0VcRvSz8892G6nIP7iuJa7R8vVl/5JGvY91uitgCnNXOZrsxPBvHFvFY4NdvpKfi/MAw
         5zdOKiv7Klg3uHbsR2+LXq/m/8wzRA7TEo4IpWWRZRmlh0YhI+NeJPSKr5XTgEoIky8h
         lKx4/CXicUEatmQae6c/Mw3P7X8qrF3aMfltqqyjGf4k1EgJlrRMtAb8cS0uXbUxewbx
         9e3/4d5HDsvPz+s9WN8BLil/mUxGpQHX110h4jebDJQQwgDmWmVG6VFjw+kt+pHE7uZd
         gNCg==
X-Gm-Message-State: AAQBX9eVPjxVJXuot/PWVPh+6CX804mGF5cHGpjEXcF8cIfmbgJlIEIl
        dgnm+GpBXrPhGGwdhnBaFHO3ausrq+hMmawQRdou7YGpgTiRMLnpdUGjPQ==
X-Google-Smtp-Source: AKy350aQi/2VkOWBIHQZFz8KEl/mv/orzkh9EkbmeOwUKSG+CmSGY34HyXENmyU1zGl0l4nRBuJygVcksv+wRoXFGZw=
X-Received: by 2002:a17:907:c281:b0:8b1:7682:3181 with SMTP id
 tk1-20020a170907c28100b008b176823181mr9849398ejc.9.1680135059084; Wed, 29 Mar
 2023 17:10:59 -0700 (PDT)
MIME-Version: 1.0
References: <20230329110723.3458843-1-sadiyakazi@google.com>
In-Reply-To: <20230329110723.3458843-1-sadiyakazi@google.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Wed, 29 Mar 2023 20:10:47 -0400
Message-ID: <CAFd5g45kEm2Kmwac3DTYVgWOcXLfp3b8_59euXOiJW8RVxRX0Q@mail.gmail.com>
Subject: Re: [PATCH v1] list: test: Test the klist structure
To:     Sadiya Kazi <sadiyakazi@google.com>
Cc:     davidgow@google.com, skhan@linuxfoundation.org, corbet@lwn.net,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
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

On Wed, Mar 29, 2023 at 7:07=E2=80=AFAM Sadiya Kazi <sadiyakazi@google.com>=
 wrote:
>
> Add KUnit tests to the klist linked-list structure.
> These perform testing for different variations of node add
> and node delete in the klist data structure (<linux/klist.h>).
>
> Limitation: Since we use a static global variable, and if
> multiple instances of this test are run concurrently, the test may fail.
>
> Signed-off-by: Sadiya Kazi <sadiyakazi@google.com>

Looks good!

Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
