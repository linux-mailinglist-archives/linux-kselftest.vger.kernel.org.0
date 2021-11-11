Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30B2A44D92F
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Nov 2021 16:31:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233872AbhKKPeJ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 11 Nov 2021 10:34:09 -0500
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:36036
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233075AbhKKPeJ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 11 Nov 2021 10:34:09 -0500
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com [209.85.208.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id EBA0C3F1B9
        for <linux-kselftest@vger.kernel.org>; Thu, 11 Nov 2021 15:31:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1636644678;
        bh=M0C7+Kz82L1iJI4IsUCerrEkcKIRCNBXuupYaoELGn8=;
        h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
         Content-Type:In-Reply-To;
        b=Z0tRQF3//dA43VNIN1zdtZKhc0nO+D4MQMIGSI3J+2trrtgQFvWUig6MCKzVwH3ZV
         6wBwXN95NMjRPpw8sLF+Vzu2kW0tpNK+u7Xfa4EFzhTcR/SzlVAVO87jZUFP3SC/FS
         bBAGIqxtIu6z2vZaU5WXtGbvUuBcNuylq2aw478Z+H6moq8ULQC4EWomODAjJhb/H7
         eeZf1SPwh32xtW/f/gg3TKqBQ0idnURyofxuITiU6Cgil7R5Hpy2/iyvjYzFV37plQ
         pmCWqj8xaKD/Dn9RIuoszT69PtT41RLdmTMlkFUpww8QmT32xdOREDSVc8D0bpRkyB
         3btKJYTO4rPIQ==
Received: by mail-ed1-f70.google.com with SMTP id r25-20020a05640216d900b003dca3501ab4so5684395edx.15
        for <linux-kselftest@vger.kernel.org>; Thu, 11 Nov 2021 07:31:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=M0C7+Kz82L1iJI4IsUCerrEkcKIRCNBXuupYaoELGn8=;
        b=VqqNi2CQO7KP44cMfdvx3yEand1VcR30Q59Y9D8PeSXPMHByJBAL7X5rjSrrvx4qpS
         +s+Q9raHKlBd+71xX3KuElOR6WrMTS4/Pzw873ii0cTgIiWZdDARLPJZWcr0YrVoI0Aw
         NJjEZxGF8IdLu+FhBEf3hrMNuha7ipNNR5Gp9yh5vLyxqf0TUInIo/rGdj/alN/Oan/Z
         rahPDg8G3QuUH4ZP1WM69odWOpb6OKYUMLCNPgzpXyC0k4ShFCQqxszc7CFkXuzMkEYL
         UPLvwqIpr9WIAbweT2o7KVeaBKf39rpuybmVzy0bs+RCE5anXX7oa/GrYDc9vqfB/C5R
         lfPw==
X-Gm-Message-State: AOAM532os9QNYZT2REStvTKdouYvXNr+ENrSPVhbq260+Rua2LG7kI2R
        VS1GvXZkvrlN646CrQgylgrgySBdv+WeBTAMcBC4Cdn3siTbX8BDnOzTkmVtqyJFZO6EZxNqPc4
        iFFEaGlRwLpxlMXBdErhTVxMP7J76JV82fYs/be3Mt/Vnqw==
X-Received: by 2002:a50:8741:: with SMTP id 1mr5562820edv.119.1636644678606;
        Thu, 11 Nov 2021 07:31:18 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxNXq3MmMTketRsMLJKPUzEi/cY9pv/3KWPhTEuC6OXxeVdf1W1fHDuZk7Csd5eUT40sk6ApA==
X-Received: by 2002:a50:8741:: with SMTP id 1mr5562788edv.119.1636644678393;
        Thu, 11 Nov 2021 07:31:18 -0800 (PST)
Received: from localhost ([2001:67c:1560:8007::aac:c1b6])
        by smtp.gmail.com with ESMTPSA id y4sm1745261edq.13.2021.11.11.07.31.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Nov 2021 07:31:18 -0800 (PST)
Date:   Thu, 11 Nov 2021 16:31:17 +0100
From:   Andrea Righi <andrea.righi@canonical.com>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     Shuah Khan <shuah@kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        linux-kselftest@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftests: net: properly support IPv6 in GSO GRE test
Message-ID: <YY03RcYshbQFJBRb@arighi-desktop>
References: <20211104104613.17204-1-andrea.righi@canonical.com>
 <20211111072048.00852448@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211111072048.00852448@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Nov 11, 2021 at 07:20:48AM -0800, Jakub Kicinski wrote:
> On Thu,  4 Nov 2021 11:46:13 +0100 Andrea Righi wrote:
> > Explicitly pass -6 to netcat when the test is using IPv6 to prevent
> > failures.
> > 
> > Also make sure to pass "-N" to netcat to close the socket after EOF on
> > the client side, otherwise we would always hit the timeout and the test
> > would fail.
> > 
> > Without this fix applied:
> > 
> >  TEST: GREv6/v4 - copy file w/ TSO                                   [FAIL]
> >  TEST: GREv6/v4 - copy file w/ GSO                                   [FAIL]
> >  TEST: GREv6/v6 - copy file w/ TSO                                   [FAIL]
> >  TEST: GREv6/v6 - copy file w/ GSO                                   [FAIL]
> > 
> > With this fix applied:
> > 
> >  TEST: GREv6/v4 - copy file w/ TSO                                   [ OK ]
> >  TEST: GREv6/v4 - copy file w/ GSO                                   [ OK ]
> >  TEST: GREv6/v6 - copy file w/ TSO                                   [ OK ]
> >  TEST: GREv6/v6 - copy file w/ GSO                                   [ OK ]
> > 
> > Fixes: 025efa0a82df ("selftests: add simple GSO GRE test")
> > Signed-off-by: Andrea Righi <andrea.righi@canonical.com>
> 
> This breaks the test for me on Fedora now :(

Oops, sorry about that.

> 
> nc: invalid option -- 'N'
> Ncat: Try `--help' or man(1) ncat for more information, usage options and help. QUITTING.
>     TEST: GREv6/v4 - copy file w/ TSO                                   [FAIL]
> nc: invalid option -- 'N'
> Ncat: Try `--help' or man(1) ncat for more information, usage options and help. QUITTING.
>     TEST: GREv6/v4 - copy file w/ GSO                                   [FAIL]
> nc: invalid option -- 'N'
> Ncat: Try `--help' or man(1) ncat for more information, usage options and help. QUITTING.
>     TEST: GREv6/v6 - copy file w/ TSO                                   [FAIL]
> nc: invalid option -- 'N'
> Ncat: Try `--help' or man(1) ncat for more information, usage options and help. QUITTING.
>     TEST: GREv6/v6 - copy file w/ GSO                                   [FAIL]
> 
> Tests passed:   0
> Tests failed:   4
> 
> 
> Can you please test this on your distro?

Tested, it works fine in Ubuntu as well:

$ sudo ./tools/testing/selftests/net/gre_gso.sh
    TEST: GREv6/v4 - copy file w/ TSO                                   [ OK ]
    TEST: GREv6/v4 - copy file w/ GSO                                   [ OK ]
    TEST: GREv6/v6 - copy file w/ TSO                                   [ OK ]
    TEST: GREv6/v6 - copy file w/ GSO                                   [ OK ]

Tests passed:   4
Tests failed:   0

Tested-by: Andrea Righi <andrea.righi@canonical.com>
