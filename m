Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8CAC3B951A
	for <lists+linux-kselftest@lfdr.de>; Thu,  1 Jul 2021 18:59:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232523AbhGARCI (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 1 Jul 2021 13:02:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:49122 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229967AbhGARCH (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 1 Jul 2021 13:02:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1625158776;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JHh8ICKOowqqu/ghi9bTRyehDsl7GNMy0SOY9PPvc9Q=;
        b=hJgpjQ58cTpygw4YrSkl7QIRF4XrVpS+N3ap1QsRH7xfjl+FAz5qb8NYM7RLDe8hSPNy0M
        jLj0NzADYH6dYIDeK3X20e0/TsWong3s/hNwDQVswGKeI5qCsLIN/gPhm3/Ci/nWMQ+XR9
        omvLTgNDQGW3RegV2WK2WPP6ZY2SbB0=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-340-H-BXwiuzNuGZp2uwTVExRg-1; Thu, 01 Jul 2021 12:59:35 -0400
X-MC-Unique: H-BXwiuzNuGZp2uwTVExRg-1
Received: by mail-wr1-f70.google.com with SMTP id k1-20020adfe8c10000b0290124c5f1d4dbso2851617wrn.0
        for <linux-kselftest@vger.kernel.org>; Thu, 01 Jul 2021 09:59:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=JHh8ICKOowqqu/ghi9bTRyehDsl7GNMy0SOY9PPvc9Q=;
        b=q0gPIIFCKEbTjNqDFM6XT+/Cs/vATWq1vFpYz3VnPOMncNd8kVxK/uN3w5YBU3phGD
         tnjUyeXNgR1wcq8SCHAYDoKr/jPqt8wADnMnlnsdIQnh32RQQEaMDajpAmGy+chGu+9h
         OHc2drIQljvygybHV7R9paX+w/8KDuwn7HpDgk5S/JYFp4suXmdcDh9Dwj5+5/FJjy3M
         JdZM9RF1Qzb7Ysjzq0zcmGLtkVJ62npG5U1V1arD6yra3UWY7y4A0r7BqMTIbchD46nA
         v9YgV5JelrfEltoOxB4CWY0fEgLmPAWezBBPv7j2AQubNcvsLYZFvZQS0G/mXlcNQ+/v
         WSxw==
X-Gm-Message-State: AOAM533Ml4BgVJF2Jb/uWb0a3WSVyjt54HotzMlPxTI5ThK4S38Zi7fr
        JF2b2KvXM5YXZWoB8q24sFxOJi9561uci9oLJjjX1WmmLvCFZKoBPJVRtlW3wd0ZHoxhFiVLAX5
        AUyco8iMW7M+/7kJ4EO9rSjmdql25
X-Received: by 2002:a1c:4b08:: with SMTP id y8mr708125wma.80.1625158774498;
        Thu, 01 Jul 2021 09:59:34 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzUJwaFSBPDak7ty0IV5j7y2eQyFVUQYPsp6gCVoc+oDBE3CM0+VQeowj59kEauWhKjd5LaHQ==
X-Received: by 2002:a1c:4b08:: with SMTP id y8mr708103wma.80.1625158774317;
        Thu, 01 Jul 2021 09:59:34 -0700 (PDT)
Received: from pc-32.home (2a01cb058918ce00dd1a5a4f9908f2d5.ipv6.abo.wanadoo.fr. [2a01:cb05:8918:ce00:dd1a:5a4f:9908:f2d5])
        by smtp.gmail.com with ESMTPSA id v25sm543261wrd.65.2021.07.01.09.59.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jul 2021 09:59:33 -0700 (PDT)
Date:   Thu, 1 Jul 2021 18:59:31 +0200
From:   Guillaume Nault <gnault@redhat.com>
To:     David Ahern <dsahern@gmail.com>
Cc:     Ido Schimmel <idosch@idosch.org>,
        David Miller <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
        Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next 1/4] selftests: forwarding: Test redirecting gre
 or ipip packets to Ethernet
Message-ID: <20210701165931.GB3933@pc-32.home>
References: <cover.1625056665.git.gnault@redhat.com>
 <0a4e63cd3cde3c71cfc422a7f0f5e9bc76c0c1f5.1625056665.git.gnault@redhat.com>
 <YN1Wxm0mOFFhbuTl@shredder>
 <20210701145943.GA3933@pc-32.home>
 <1932a3af-2fdd-229a-e5f5-6b1ef95361e1@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1932a3af-2fdd-229a-e5f5-6b1ef95361e1@gmail.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Jul 01, 2021 at 09:38:44AM -0600, David Ahern wrote:
> On 7/1/21 8:59 AM, Guillaume Nault wrote:
> > I first tried to write this selftest using VRFs, but there were some
> > problems that made me switch to namespaces (I don't remember precisely
> > which ones, probably virtual tunnel devices in collect_md mode).
> 
> if you hit a problem with the test not working, send me the test script
> and I will take a look.

Okay, thanks.

