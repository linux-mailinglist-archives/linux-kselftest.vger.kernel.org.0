Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 179724B1256
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Feb 2022 17:09:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244015AbiBJQJL (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 10 Feb 2022 11:09:11 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:60888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244016AbiBJQJL (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 10 Feb 2022 11:09:11 -0500
Received: from mail-vs1-xe2c.google.com (mail-vs1-xe2c.google.com [IPv6:2607:f8b0:4864:20::e2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 351D9CC6
        for <linux-kselftest@vger.kernel.org>; Thu, 10 Feb 2022 08:09:12 -0800 (PST)
Received: by mail-vs1-xe2c.google.com with SMTP id t184so6926588vst.13
        for <linux-kselftest@vger.kernel.org>; Thu, 10 Feb 2022 08:09:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TRwPb5Y+oBkP41XEt/JXjya2Xo5aicaCGmanVBPeNig=;
        b=R5iXAIJyn5nNTBjra5nrJeFym34vS+blo4YIs4MhOiIkIBJUmO81I8FmYY5J3KdEk3
         Ww1crq7HzjrrjAmQ5QZwPZWCRMeHX4fOIecZgF0PmxkHfi5AHsq8KlRk8N9IGnP54gN5
         ++QGFkPEC1UCzJC99/P++84QyO/wxA6eaze1+OPL/zsoeRzNNPFK0uCZXBPtFVxg1WlX
         vpeLsQa0tqTloY6Q/jfdecxSSEY7ANdvIxylQUnmAzz6xuffquxll7kkWEaYecDbM7sY
         triYS7uch0DbgivVcmsjIwNFf/LliQITrZ801j0Bm90crKwt7BwhWdTMRjhp2mZcXsL1
         O5jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TRwPb5Y+oBkP41XEt/JXjya2Xo5aicaCGmanVBPeNig=;
        b=zTa95qR7EHxeePqwlry+0iVDSxZAnj1k+2OE3SrtoOrAZQ5W2tWoVv8ly69KyqbI7z
         STYbgHQZZeeK8i6pRLeTMFFrpJ9R5pyN2jznb5cNYMkow3DfiyaKezn8/+O0y66pUvup
         CmsvS7YsNqxlnhXG4s2Eg6VqYmfAWv2GS/FQFGVDylhs5TfD18wI3TrE3Ypc0k/gOM75
         J6MTP7mLYUUAC0ch2rbzeYbvOvJPPSccDbqvaaakRBuZb5MxoRZ85bJVRITUxGztZMq+
         Is5cGtgccPv+mVIJAq3mJ+8LLJ1mfu0w5D8iSCWyEDhvgrzttT1KaNYBPPu0q/7QG1qC
         W9dA==
X-Gm-Message-State: AOAM5304dJfuHQxBDXZDgArCoOlkAoVba84IXa9Y112my7AVOMrgJffa
        UX3cHokSWte4KpLi0yxBJhwHrxhYrS8=
X-Google-Smtp-Source: ABdhPJzsH3icICGSciPSQSVJKK92jv8ClWImxf2OVLy0hhVzzGUn7Exk0bvCancCG60t6HeG3Jg1sw==
X-Received: by 2002:a67:7206:: with SMTP id n6mr2483822vsc.21.1644509351381;
        Thu, 10 Feb 2022 08:09:11 -0800 (PST)
Received: from mail-vk1-f179.google.com (mail-vk1-f179.google.com. [209.85.221.179])
        by smtp.gmail.com with ESMTPSA id t207sm693536vkb.45.2022.02.10.08.09.10
        for <linux-kselftest@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Feb 2022 08:09:10 -0800 (PST)
Received: by mail-vk1-f179.google.com with SMTP id 5so3343152vkq.9
        for <linux-kselftest@vger.kernel.org>; Thu, 10 Feb 2022 08:09:10 -0800 (PST)
X-Received: by 2002:a05:6122:507:: with SMTP id x7mr2742625vko.14.1644509350149;
 Thu, 10 Feb 2022 08:09:10 -0800 (PST)
MIME-Version: 1.0
References: <20220210003649.3120861-1-kuba@kernel.org>
In-Reply-To: <20220210003649.3120861-1-kuba@kernel.org>
From:   Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date:   Thu, 10 Feb 2022 11:08:33 -0500
X-Gmail-Original-Message-ID: <CA+FuTScN_Mu5qV1H3Wpo4o=5hTiakP0eD7NRuZse-4TsxubQyA@mail.gmail.com>
Message-ID: <CA+FuTScN_Mu5qV1H3Wpo4o=5hTiakP0eD7NRuZse-4TsxubQyA@mail.gmail.com>
Subject: Re: [PATCH net-next 00/11] net: ping6: support basic socket cmsgs
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     davem@davemloft.net, netdev@vger.kernel.org, lorenzo@google.com,
        maze@google.com, dsahern@kernel.org, yoshfuji@linux-ipv6.org,
        shuah@kernel.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Feb 9, 2022 at 7:36 PM Jakub Kicinski <kuba@kernel.org> wrote:
>
> Add support for common SOL_SOCKET cmsgs in ICMPv6 sockets.
> Extend the cmsg tests to cover more cmsgs and socket types.
>
> SOL_IPV6 cmsgs to follow.
>
> Jakub Kicinski (11):
>   net: ping6: remove a pr_debug() statement
>   net: ping6: support packet timestamping
>   net: ping6: support setting socket options via cmsg
>   selftests: net: rename cmsg_so_mark
>   selftests: net: make cmsg_so_mark ready for more options
>   selftests: net: cmsg_sender: support icmp and raw sockets
>   selftests: net: cmsg_so_mark: test ICMP and RAW sockets
>   selftests: net: cmsg_so_mark: test with SO_MARK set by setsockopt
>   selftests: net: cmsg_sender: support setting SO_TXTIME
>   selftests: net: cmsg_sender: support Tx timestamping
>   selftests: net: test standard socket cmsgs across UDP and ICMP sockets
>
>  net/ipv6/ping.c                             |  14 +-
>  tools/testing/selftests/net/.gitignore      |   2 +-
>  tools/testing/selftests/net/Makefile        |   3 +-
>  tools/testing/selftests/net/cmsg_sender.c   | 380 ++++++++++++++++++++
>  tools/testing/selftests/net/cmsg_so_mark.c  |  67 ----
>  tools/testing/selftests/net/cmsg_so_mark.sh |  32 +-
>  tools/testing/selftests/net/cmsg_time.sh    |  83 +++++
>  7 files changed, 499 insertions(+), 82 deletions(-)
>  create mode 100644 tools/testing/selftests/net/cmsg_sender.c
>  delete mode 100644 tools/testing/selftests/net/cmsg_so_mark.c
>  create mode 100755 tools/testing/selftests/net/cmsg_time.sh
>

Already merged, but since I was on the cc line: overall looks great to
me too. Thanks Jakub.
