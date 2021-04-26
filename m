Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 565AF36BA14
	for <lists+linux-kselftest@lfdr.de>; Mon, 26 Apr 2021 21:30:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239021AbhDZTbG (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 26 Apr 2021 15:31:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240430AbhDZTbC (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 26 Apr 2021 15:31:02 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1691AC061574
        for <linux-kselftest@vger.kernel.org>; Mon, 26 Apr 2021 12:30:20 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id d14so3282401edc.12
        for <linux-kselftest@vger.kernel.org>; Mon, 26 Apr 2021 12:30:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20150623.gappssmtp.com; s=20150623;
        h=to:cc:references:from:subject:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Dr87k9ZfKSIjKnHclx7DePEImf+rQ7+qp484Yc2GQDI=;
        b=PPOrCQABnsVUARLGHk3k4EHRz5rL54WAC/3DmqIc9Chmcl13vZveHm9YTgPByu9ISi
         BCM/sigWLiv6oopbIxbMFfnPjXDDtLMM7ucX+DRa10VkRS6dPJUiaf2WgASxfslYX16E
         +bppZXEMf+sV9kNORgUP1nYT3q7/2Za5BgRMgLnxUbuBHvygarfczX+R3rRy0AfqqvgH
         Xitwa51T16WbhvkAvSG4cEktOXnr6XxCEyVTfulx1je4TvHzlBJ10ZT2yTfsjgzv6ePw
         Y9LgkJ4yyVK6FRcD7HdvGU04WKY4YtpvKyRVuqndTXJYPUNTtQ3PWYHDR1yWXuDSDmmy
         jROw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:subject:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Dr87k9ZfKSIjKnHclx7DePEImf+rQ7+qp484Yc2GQDI=;
        b=Gewr35KmhYyouiHLCXI7cWPX1ZmpuaVf4MslANvJlTv5EAMZiYwU2DASggMAlbcmm0
         c0RYR+s1AVBiRORzxsNGECrp6pLhsSodI0kgbscwRbxdZDWpQCKImYYk1PoqMbiMMo/1
         k0D1a5OG1wo+DXlYEHpgFPvKWEe1kPL8+thLKSfG9Utdw4Ix/lUGoZ+q+pt2lt2T0NAX
         i50EWwbe6X1r8w9nWX+nN8HzLj0P74N1nKb84y8LhqhS1vo23ma7yQeJMNC6CqNeeo6b
         XZoW+CTzD4RgUkzXEsjjFrpp/iCZABmvSetFNqz5OMDfbxZUXvy2m2v81+HwrHegZoOZ
         y0Lw==
X-Gm-Message-State: AOAM531JfDPQBofn9ftrYH3ri6leTyvu5tcGiFy9LYhhHqI0RkenD9eT
        Gd9npd8R1Q3u+8OMOsHazuTRkQ==
X-Google-Smtp-Source: ABdhPJwEsGiSPn86sUce28FQhOIkZd9EDC808DnlsPjgtQS2kJzYU55xlwjSXiAaAe8rkGOR/w0UhA==
X-Received: by 2002:a05:6402:3514:: with SMTP id b20mr267417edd.348.1619465418825;
        Mon, 26 Apr 2021 12:30:18 -0700 (PDT)
Received: from tsr-lap-08.nix.tessares.net ([46.166.143.116])
        by smtp.gmail.com with ESMTPSA id r10sm12090371ejd.112.2021.04.26.12.30.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Apr 2021 12:30:18 -0700 (PDT)
To:     Masahiro Yamada <masahiroy@kernel.org>,
        linux-kbuild@vger.kernel.org
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Mat Martineau <mathew.j.martineau@linux.intel.com>,
        Matthias Maennich <maennich@google.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Mackerras <paulus@samba.org>,
        Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        mptcp@lists.01.org, netdev@vger.kernel.org
References: <20210424114841.394239-1-masahiroy@kernel.org>
From:   Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: Re: [PATCH] kbuild: replace LANG=C with LC_ALL=C
Message-ID: <2f8ccc46-16a1-e0fe-7cb0-0912295153ee@tessares.net>
Date:   Mon, 26 Apr 2021 21:30:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210424114841.394239-1-masahiroy@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi,

Thank you for the patch!

On 24/04/2021 13:48, Masahiro Yamada wrote:
> LANG gives a weak default to each LC_* in case it is not explicitly
> defined. LC_ALL, if set, overrides all other LC_* variables.
> 
>   LANG  <  LC_CTYPE, LC_COLLATE, LC_MONETARY, LC_NUMERIC, ...  <  LC_ALL
> 
> This is why documentation such as [1] suggests to set LC_ALL in build
> scripts to get the deterministic result.
> 
> LANG=C is not strong enough to override LC_* that may be set by end
> users.
> 
> [1]: https://reproducible-builds.org/docs/locales/
> 
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---
> 
>  arch/powerpc/boot/wrapper                          | 2 +-
>  scripts/nsdeps                                     | 2 +-
>  scripts/recordmcount.pl                            | 2 +-
>  scripts/setlocalversion                            | 2 +-
>  scripts/tags.sh                                    | 2 +-
>  tools/testing/selftests/net/mptcp/mptcp_connect.sh | 2 +-

Acked-by: Matthieu Baerts <matthieu.baerts@tessares.net> (mptcp)

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
