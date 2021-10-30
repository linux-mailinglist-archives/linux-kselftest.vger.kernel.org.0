Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE4FF4406A4
	for <lists+linux-kselftest@lfdr.de>; Sat, 30 Oct 2021 03:15:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229656AbhJ3BRw (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 29 Oct 2021 21:17:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229801AbhJ3BRv (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 29 Oct 2021 21:17:51 -0400
Received: from mail-vk1-xa2f.google.com (mail-vk1-xa2f.google.com [IPv6:2607:f8b0:4864:20::a2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72A2AC061570
        for <linux-kselftest@vger.kernel.org>; Fri, 29 Oct 2021 18:15:22 -0700 (PDT)
Received: by mail-vk1-xa2f.google.com with SMTP id h133so5398161vke.10
        for <linux-kselftest@vger.kernel.org>; Fri, 29 Oct 2021 18:15:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QtE1gN6cjPAeZH9G/XY5cFoN/mhotk4pl2GQpQOelUQ=;
        b=EIcgFFNfnUbVABuDne8JNO/2vXMSp7LHTF+cuTTskgY1EZ4oCH5dS/nLvcVm9i5Pxq
         il0x2Qq8crgwF3YQgv+ZKBHiSkq2Fvz5e6VyIUkDXLO5axpsOZQdwFGc5Sga6phd34EK
         aL5NjNH6dhXqU9cuq2LmD9hnBJvCfPjUnRiMBJUq9079lg+N1jgFio01prLGqKu4Pghx
         5My1+482IlBIn+1en2FTZd2fGPnvnBNIn0sPIJASRkAnG40y/y8bQPoxVR3W8+VoWzeh
         wUnKpIbMSw5jFSCGGR8cohJ9iiJGRR3mR+om9AAqo/8tCujZqiBVh39ll4HjS1huGIIB
         1CzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QtE1gN6cjPAeZH9G/XY5cFoN/mhotk4pl2GQpQOelUQ=;
        b=q2eScFc1xpTmWV2gWRkXUUvwtHdrPJMPPVmu7+0EGYexgMHz5hq9f0UM/E3AbCX8KP
         fFWpeqhujcMxja/utu3hdlSeCE+EMo/APHtarBJ/0BJabdqaA26AqBMACK+XlxqJuVzf
         z7n6tmhBoHLfQhKC01Ww1OvtoHIczpp5QwbJQpQTJKGe4gooQgEQw2kis5pcBVX88IEh
         aCSDEUQctQLBpQOYShYr3i8GoeLc22Y+2lkWOG1W63WtiopxZfCSTYQXetVCAK73+ka3
         y5BJS+D4rwu0rzyzK18zhVNl/Ht9hpP3U8pXALr66Bh96BuLhG6OU6Qx+7TSUDBcf67D
         qCuw==
X-Gm-Message-State: AOAM532CM6H5xEp9SfDevA9WRl7rrsgEUmTMboM/pJpqG+vKkQeGbhiW
        oNaz19oWvb6CTQePYa601H9ct+M24oo=
X-Google-Smtp-Source: ABdhPJyOK65n7YzVOOT02pf/CDWuf5CXDbRT7VBWtZ7ghOqtjRkcJ09RmfiF6qfggyaKGiEbi+PfMw==
X-Received: by 2002:a1f:2502:: with SMTP id l2mr3796470vkl.4.1635556521001;
        Fri, 29 Oct 2021 18:15:21 -0700 (PDT)
Received: from mail-ua1-f43.google.com (mail-ua1-f43.google.com. [209.85.222.43])
        by smtp.gmail.com with ESMTPSA id l10sm828389uaa.19.2021.10.29.18.15.20
        for <linux-kselftest@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Oct 2021 18:15:20 -0700 (PDT)
Received: by mail-ua1-f43.google.com with SMTP id v20so21305322uaj.9
        for <linux-kselftest@vger.kernel.org>; Fri, 29 Oct 2021 18:15:20 -0700 (PDT)
X-Received: by 2002:ab0:15a1:: with SMTP id i30mr4692165uae.122.1635556520211;
 Fri, 29 Oct 2021 18:15:20 -0700 (PDT)
MIME-Version: 1.0
References: <20211029155135.468098-1-kuba@kernel.org> <20211029155135.468098-3-kuba@kernel.org>
 <9ec9011a-d240-e00a-38e2-51f8e2661a3d@gmail.com>
In-Reply-To: <9ec9011a-d240-e00a-38e2-51f8e2661a3d@gmail.com>
From:   Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date:   Fri, 29 Oct 2021 21:14:43 -0400
X-Gmail-Original-Message-ID: <CA+FuTSfW04yz42DtnJJZCBZmSjYygFP6_KmorKDYi73Y9Jh-=w@mail.gmail.com>
Message-ID: <CA+FuTSfW04yz42DtnJJZCBZmSjYygFP6_KmorKDYi73Y9Jh-=w@mail.gmail.com>
Subject: Re: [PATCH net 2/2] selftests: udp: test for passing SO_MARK as cmsg
To:     David Ahern <dsahern@gmail.com>
Cc:     Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net,
        netdev@vger.kernel.org, yoshfuji@linux-ipv6.org,
        dsahern@kernel.org, shuah@kernel.org,
        linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Oct 29, 2021 at 2:24 PM David Ahern <dsahern@gmail.com> wrote:
>
> On 10/29/21 9:51 AM, Jakub Kicinski wrote:
> > Before fix:
> > |  Case IPv6 rejection returned 0, expected 1
> > |FAIL - 1/4 cases failed
> >
> > With the fix:
> > | OK
> >
> > Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> > --
> > CC: shuah@kernel.org
> > CC: linux-kselftest@vger.kernel.org
> > ---
> >  tools/testing/selftests/net/.gitignore      |  1 +
> >  tools/testing/selftests/net/Makefile        |  2 +
> >  tools/testing/selftests/net/cmsg_so_mark.c  | 67 +++++++++++++++++++++
> >  tools/testing/selftests/net/cmsg_so_mark.sh | 61 +++++++++++++++++++
> >  4 files changed, 131 insertions(+)
> >  create mode 100644 tools/testing/selftests/net/cmsg_so_mark.c
> >  create mode 100755 tools/testing/selftests/net/cmsg_so_mark.sh
> >
> Reviewed-by: David Ahern <dsahern@kernel.org>

Reviewed-by: Willem de Bruijn <willemb@google.com>
