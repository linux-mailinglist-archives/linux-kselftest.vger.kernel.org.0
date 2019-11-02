Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 12A8AECFAB
	for <lists+linux-kselftest@lfdr.de>; Sat,  2 Nov 2019 17:09:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726454AbfKBQJY (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 2 Nov 2019 12:09:24 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:33817 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726450AbfKBQJY (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 2 Nov 2019 12:09:24 -0400
Received: by mail-qk1-f194.google.com with SMTP id 205so12249791qkk.1
        for <linux-kselftest@vger.kernel.org>; Sat, 02 Nov 2019 09:09:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=c0cuVGBxflnSQObQkQQzATSPlFqd42XqW398RDi97KM=;
        b=lg8n5uU+jUkgGxBjJckhIjEIDGOGiGG4uoQ+2XB6K9Y51kxHkGIteS3t6zSH7j4BDY
         kIsXxPYSNxFEZdHNP2ARtt5NiTJlb51Ofc/dpJ+TpTOlA7XzlF8povfT8bBcc1EBFJX/
         nLKnEW2IDZLiArATz9QNIChEZeiE3A7oIVmSggFBQioc9xhOIcP+P+Ein5g4PirLlMDQ
         8750GJpbvWFX/knOlQTylxpWERHVHYn3V9doGmNCg7XPmuSkWPpBSLQYF41TqUbJJp6A
         4fc76p5kdFjGW0waA/Ya2OfwSsfR+wnWc63zW0UqZwP+LGYj4+Dr3JB5jDDcYN/E19Uq
         xMpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=c0cuVGBxflnSQObQkQQzATSPlFqd42XqW398RDi97KM=;
        b=N4Lx3z9Hkql8iKCjmyOe+Ln7+rOb0U8D7vHPcYtMnySoDY5nL4rxPdxShBoUuFc3a8
         /ut0s0IzwvmalYPe59wS4RWaASw5ndxL/miobgAqa8JxTbhOi6CSWsCBV45JQ/UEezP2
         a1bNPEGzDVon7F75Bkb6NQbr1t4p/pZyBZh434EhDy+q1Qk0JjHLu07W/brTBNCdPjOP
         Y7TgH4MWfe9LG6xYR2iAoFgZK/1vvFTxtR4r+WwPWVEi08F+MXFHtUYFr5/f/NWK3kF3
         LzuloDMAIpAXF3IAzUWpDh70K2mIeZG6VkTCTPW9BM6i6Thv8d6CQvi4VhByticiA223
         CxRw==
X-Gm-Message-State: APjAAAU9+bP26ynM1UKuogdPoCsUHHEDWqICGRkDPMnidEGZVFH90FwU
        LOnj8WMWKF/Zk0gBEzpV45ZipBCtnqTirei7atQsPQ==
X-Google-Smtp-Source: APXvYqxW3TLE6Mypdskzd8rpXIqk/4gf+r1q20YO37mFCiA4rJIwpOhyscQhTKkejd5xB+0DUpP5HRziZAg34YznUsc=
X-Received: by 2002:a05:620a:231:: with SMTP id u17mr8682910qkm.271.1572710963381;
 Sat, 02 Nov 2019 09:09:23 -0700 (PDT)
MIME-Version: 1.0
References: <20191101233408.BC15495C0902@us180.sjc.aristanetworks.com>
 <0a03def6-3ea0-090f-048f-877700836df2@gmail.com> <CA+HUmGgDrY9A7kz7268ycAOhExA3Y1h-QhBS6xwbWYxpUODDWw@mail.gmail.com>
 <690336d7-0478-e555-a49b-143091e6e818@gmail.com>
In-Reply-To: <690336d7-0478-e555-a49b-143091e6e818@gmail.com>
From:   Francesco Ruggeri <fruggeri@arista.com>
Date:   Sat, 2 Nov 2019 09:09:12 -0700
Message-ID: <CA+HUmGgKakVpS8UsKWUwm9QdCf+T2Pi1wNS-Kr7NE+TQ8ABGaQ@mail.gmail.com>
Subject: Re: [PATCH net-next 2/2] selftest: net: add icmp reply address test
To:     David Ahern <dsahern@gmail.com>
Cc:     David Miller <davem@davemloft.net>, shuah@kernel.org,
        netdev <netdev@vger.kernel.org>, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sat, Nov 2, 2019 at 8:11 AM David Ahern <dsahern@gmail.com> wrote:
> On 11/2/19 9:08 AM, Francesco Ruggeri wrote:
> > I am only using macvlans for N1 in the ipv6 test, where there are 3 nodes.
> > How do I use veths for that?
>
> checkout the connect_ns function. It uses veth to connect ns1 to ns2.

I apologize in advance  for being slow ...
I have 3 namespaces that have to share the same LAN, I am not trying
1-1 connections among those namespaces.

Thanks,
Francesco
