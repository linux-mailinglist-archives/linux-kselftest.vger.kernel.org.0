Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B421F4E5A78
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Mar 2022 22:10:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240886AbiCWVLk (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 23 Mar 2022 17:11:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240625AbiCWVLk (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 23 Mar 2022 17:11:40 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EACC466CBB
        for <linux-kselftest@vger.kernel.org>; Wed, 23 Mar 2022 14:10:09 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id r13so5370262ejd.5
        for <linux-kselftest@vger.kernel.org>; Wed, 23 Mar 2022 14:10:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZfhZGToUySyQoBAAzoaBItg7GXPjMEwgO7XHu6m15vo=;
        b=oTaYHuj6z4VlIdVrvz4in+OweaQ1aB5G22a02LB3zbxBxaial1xxJazofKO/pEcfz/
         +BXQTViVzjYvu51EW1xPKPz2YZnGmaD0Olarex25MrFsS+wxDzXnxsr6UmxDGbz5/41f
         M0OqCt0v7rWX3E+1irUJqceHYflxTGtVDzOehfjnQOHbNMML0j1bq1AzTTCmnabROg+k
         koycr/Xiq1lxmYxVmLh3jq0lv8dolD07i4X100kNrUHztguacN0E1uzJOfZNt/dIV4a5
         8PYxVdJx4ewa9P8Ga2ZTwDw+SB/V/5loxYn48Zr9v50nYGhDHQgI4zoO2bfF6B9BniB0
         RoQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZfhZGToUySyQoBAAzoaBItg7GXPjMEwgO7XHu6m15vo=;
        b=L3e32hUO8ookzlB+nQjPIfUkJ3RF4YnUkopkHniRJO50aEuVVu30COSiCtZ8+bCV+i
         RvygCBSITskr7WCs1MBfhWgfMQZKSOMAlrAih+/71Z69nF9uegpW4FuZjV/93L6U3iQQ
         FUnO+2xtB4PTrex8Qcex49ODIW4DuUT7YxVHyNierLflFL6HnyQRGpEOOw9ujgSzi7eA
         IghuGONuYhjnFkkCaARpQ/FnDtWIxGtcR0GlTtawDmM0yInvMdWMC/sPZRI0YrJHS3t6
         giSJI/tN4fpoo7MUQ6cI31xs8AF0gfTtyL5ljVYsxXGYeubM6K0H/b/+0vEXm1JEu+f4
         N0rw==
X-Gm-Message-State: AOAM5331qZ0nsAq0BStUb/8r3UKzhCJqJpGCCGdI5QXEADsvVOPfgPBv
        qyltsk6kN00XHhjtY+kW0MDBTLCe1eakEqbDUgN3SA==
X-Google-Smtp-Source: ABdhPJyE+u1EafGrU6LOqybdc98qkgtGQW9zc59eSn5dvWoEWW3X3gvp838MWC0NqNsJtL3kM5bm7ai6tTn2yPkVs7o=
X-Received: by 2002:a17:907:c018:b0:6df:e31b:d912 with SMTP id
 ss24-20020a170907c01800b006dfe31bd912mr2229796ejc.196.1648069808337; Wed, 23
 Mar 2022 14:10:08 -0700 (PDT)
MIME-Version: 1.0
References: <20220211164246.410079-1-ribalda@chromium.org> <20220211164246.410079-3-ribalda@chromium.org>
In-Reply-To: <20220211164246.410079-3-ribalda@chromium.org>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Wed, 23 Mar 2022 17:09:57 -0400
Message-ID: <CAFd5g444yDukdiegQW-H1kV1uaRYCzoX55WHoewHx6KTOa5DEw@mail.gmail.com>
Subject: Re: [PATCH v6 3/6] thunderbolt: test: use NULL macros
To:     Ricardo Ribalda <ribalda@chromium.org>
Cc:     kunit-dev@googlegroups.com, kasan-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Daniel Latypov <dlatypov@google.com>
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

On Fri, Feb 11, 2022 at 11:42 AM Ricardo Ribalda <ribalda@chromium.org> wrote:
>
> Replace the NULL checks with the more specific and idiomatic NULL macros.
>
> Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> Acked-by: Daniel Latypov <dlatypov@google.com>
> Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>

Acked-by: Brendan Higgins <brendanhiggins@google.com>
