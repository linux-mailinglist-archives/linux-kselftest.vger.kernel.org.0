Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E6944A7BAC
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Feb 2022 00:26:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348080AbiBBX0B (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 2 Feb 2022 18:26:01 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:48813 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229764AbiBBX0A (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 2 Feb 2022 18:26:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643844360;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=V1irmvN4zP19hk1c37XkrsxWt5n5A/h9HErqCh9egyM=;
        b=aRFrQwzscodg8Mm9sOCbthJiJaV2ivSEqCEnAKK2fokZUO1XUSHL2W3a7V6lflnP9FsIjj
        SsI1VqSeWKwxGFb8EgmSWI+DP/dVSKwPShhjbA3iabflVtiK2dK/D1NuxFI9rIIHvihRwN
        6R93PNiBqfbjGwsQthX9N10RusreRsA=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-674-kH8Yg_pvOLqQVZXu1hY9bQ-1; Wed, 02 Feb 2022 18:25:59 -0500
X-MC-Unique: kH8Yg_pvOLqQVZXu1hY9bQ-1
Received: by mail-wm1-f71.google.com with SMTP id bg16-20020a05600c3c9000b0034bea12c043so4827231wmb.7
        for <linux-kselftest@vger.kernel.org>; Wed, 02 Feb 2022 15:25:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=V1irmvN4zP19hk1c37XkrsxWt5n5A/h9HErqCh9egyM=;
        b=hhKOYOoKKKDPVBfaIcNYUT+Yo5K8Wj0Hzp3AI+FT0XN/l2LR0KFTzgU7ckCWvEED7W
         5Mh2m5Q7cqBk0TYV4lDHlq4e05eNJLhrZzd4oeYM3Z83Bfc2VtekUH/71eGXXafFeC9E
         YKQE4fErbMksEsJemX6CYebtV5yFVXC3g5QIanzy6KNI/gK/IomTQHnwhdZ9dKvSg+V/
         0CTEoMs8pm3RYHXW0OpbINMCnz1Vv5Pi7pp/M0VTJz2wMyB4hCdDTxRX2m2l3TIdxcU4
         blOAQmEadKCQH9Te8Kq6auZT//AxuXis9ckTKK6CF9cbznuG0AlHL9C6i7SVbfK1pl2V
         iWDw==
X-Gm-Message-State: AOAM532ceitpV25hS5k/vCrMD3qpq4hQHzcDiDsOuJFs08UHA+4qv8/6
        aHeovjjQjXa4+i6cKfnwIV/2c5c2laOrW8bSAUNrdtmoNBiJ8JAk/AN6SsyxhvLnGr62H09CJnO
        fDo1q/LakXoCONEvOu2roWMHTIMdg
X-Received: by 2002:adf:d1c1:: with SMTP id b1mr3372359wrd.194.1643844358120;
        Wed, 02 Feb 2022 15:25:58 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwSO9KG6tY7otJ9gS+2Z7WctCTNZopwe1OQIFeR8JPQvW0ZC6+xdYbw6EQuMBsj+bGuZ0jFQw==
X-Received: by 2002:adf:d1c1:: with SMTP id b1mr3372344wrd.194.1643844357867;
        Wed, 02 Feb 2022 15:25:57 -0800 (PST)
Received: from pc-4.home (2a01cb058918ce00dd1a5a4f9908f2d5.ipv6.abo.wanadoo.fr. [2a01:cb05:8918:ce00:dd1a:5a4f:9908:f2d5])
        by smtp.gmail.com with ESMTPSA id s22sm5584046wmj.38.2022.02.02.15.25.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Feb 2022 15:25:57 -0800 (PST)
Date:   Thu, 3 Feb 2022 00:25:55 +0100
From:   Guillaume Nault <gnault@redhat.com>
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     David Miller <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
        Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
        Ido Schimmel <idosch@mellanox.com>,
        Jiri Pirko <jiri@mellanox.com>
Subject: Re: [PATCH net-next] selftests: fib offload: use sensible tos values
Message-ID: <20220202232555.GC15826@pc-4.home>
References: <5e43b343720360a1c0e4f5947d9e917b26f30fbf.1643826556.git.gnault@redhat.com>
 <54a7071e-71ad-0c7d-ccc4-0f85dbe1e077@linuxfoundation.org>
 <20220202201614.GB15826@pc-4.home>
 <c5be299d-35e9-9ae9-185f-2faa6eccb149@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c5be299d-35e9-9ae9-185f-2faa6eccb149@linuxfoundation.org>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Feb 02, 2022 at 02:10:15PM -0700, Shuah Khan wrote:
> On 2/2/22 1:16 PM, Guillaume Nault wrote:
> > On Wed, Feb 02, 2022 at 12:46:10PM -0700, Shuah Khan wrote:
> > > On 2/2/22 11:30 AM, Guillaume Nault wrote:
> > > > Although both iproute2 and the kernel accept 1 and 2 as tos values for
> > > > new routes, those are invalid. These values only set ECN bits, which
> > > > are ignored during IPv4 fib lookups. Therefore, no packet can actually
> > > > match such routes. This selftest therefore only succeeds because it
> > > > doesn't verify that the new routes do actually work in practice (it
> > > > just checks if the routes are offloaded or not).
> > > > 
> > > > It makes more sense to use tos values that don't conflict with ECN.
> > > > This way, the selftest won't be affected if we later decide to warn or
> > > > even reject invalid tos configurations for new routes.
> > > 
> > > Wouldn't it make sense to leave these invalid values in the test though.
> > > Removing these makes this test out of sync withe kernel.
> > 
> > Do you mean keeping the test as is and only modify it when (if) we
> > decide to reject such invalid values?
> 
> This is for sure. Remove the invalid values in sync with the kernel code.
> 
> > Or to write two versions of the
> > test, one with invalid values, the other with correct ones?
> > 
> 
> This one makes sense if it adds value in testing to make sure we continue
> to reject invalid values.
> 
> > I don't get what keeping a test with the invalid values could bring us.
> > It's confusing for the reader, and might break in the future. This
> > patch makes the test future proof, without altering its intent and code
> > coverage. It still works on current (and past) kernels, so I don't see
> > what this patch could make out of sync.
> > 
> 
> If kernel still accepts these values, then the test is valid as long as
> kernel still doesn't flag these values as invalid.
> 
> I might be missing something. Don't you want to test with invalid values
> so make sure they are indeed rejected?

Testing invalid values makes sense, but in another selftest IMHO. This
file is used to test hardware offload behaviour (although it lives
under selftests/net/, it's only called from other scripts living under
selftests/drivers/). Testing for accepted/rejected values should be
done in a network generic selftest, not in driver specific ones.

I'm currently working on a patch series that'd include such tests (as
part of a larger project aimed at fixing conflicting interpretations of
ECN bits). But for fib_offload_lib.sh, I'd really prefer if we could
keep it focused on testing driver features.

> 
> thanks,
> -- Shuah
> 

