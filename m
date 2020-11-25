Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5ECB62C45CF
	for <lists+linux-kselftest@lfdr.de>; Wed, 25 Nov 2020 17:49:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732395AbgKYQrN (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 25 Nov 2020 11:47:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:58640 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732323AbgKYQrM (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 25 Nov 2020 11:47:12 -0500
Received: from kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com (unknown [163.114.132.4])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 19BBC2168B;
        Wed, 25 Nov 2020 16:47:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606322832;
        bh=EjOSjsBeEUqJSy95gsQXTZF+m3ei8bvcvCCGSZM/QXU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=LSgiRZuRmjjvwgXBkKn/SRwakKUcZMQnJnVB72Ap6szYZO4P2D0LXo3q2KxCbmQ6m
         BZYsJoMFz9JDHZKXZIoUKKIhAGNqHU7PJ5UnHhxBkqyvL7jIMo07m1UJqHOHsSQbWc
         HAa5V19mVxktdO75qe8oUiqqfC/7XIm9oZSr0aMw=
Date:   Wed, 25 Nov 2020 08:47:10 -0800
From:   Jakub Kicinski <kuba@kernel.org>
To:     David Ahern <dsahern@gmail.com>
Cc:     Andrea Mayer <andrea.mayer@uniroma2.it>,
        "David S. Miller" <davem@davemloft.net>,
        David Ahern <dsahern@kernel.org>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        Shuah Khan <shuah@kernel.org>,
        Shrijeet Mukherjee <shrijeet@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Nathan Chancellor <natechancellor@gmail.com>,
        Stefano Salsano <stefano.salsano@uniroma2.it>,
        Paolo Lungaroni <paolo.lungaroni@cnit.it>,
        Ahmed Abdelsalam <ahabdels.dev@gmail.com>
Subject: Re: [net-next v3 0/8] seg6: add support for SRv6 End.DT4/DT6
 behavior
Message-ID: <20201125084710.01f0e6a6@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
In-Reply-To: <08201db4-d523-3b0e-fcb6-dfb666f2e013@gmail.com>
References: <20201123182857.4640-1-andrea.mayer@uniroma2.it>
        <20201124154904.0699f4c1@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
        <3dd23494-d6ae-1c09-acb3-c6c2b2ef93d8@gmail.com>
        <20201124175803.1e09e19e@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
        <08201db4-d523-3b0e-fcb6-dfb666f2e013@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, 24 Nov 2020 21:37:18 -0700 David Ahern wrote:
> On 11/24/20 6:58 PM, Jakub Kicinski wrote:
> > But it's generally not a huge issue for applying the patch. I just like
> > to see the build bot result, to make sure we're not adding W=1 C=1
> > warnings.  
> 
> ah, the build bot part is new. got it.

BTW I was wondering for the longest time how to structure things so
that build bot can also build iproute2 in case we want to run tests
attached to the series and the tests depend on iproute2 changes...

But let's cross that bridge when we get there.
