Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 078AA7BF8B6
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Oct 2023 12:32:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231218AbjJJKcJ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 10 Oct 2023 06:32:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231192AbjJJKcF (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 10 Oct 2023 06:32:05 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D98D9D
        for <linux-kselftest@vger.kernel.org>; Tue, 10 Oct 2023 03:31:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1696933881;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1C2ePqqy9Lk6VTckZlTq+a1e83GQqbEDpw2ShG10pB0=;
        b=YWsxFP++ADzIA4nfrTR3ZiAfLML+sTjQCqSgC+RXdj0xk9yZDY2aQT81ZcsyjJQwp8f7oT
        53VTvrHtzOpFEk6w/y9qQxMpHkvj2OjbN356qiwfj1/NZHdhsr99Z7X2J85EB935vc5g7/
        krY4FTij6kw2Ac3Uvftd5AzHU1SEBGE=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-56--WHS4hAcOyKPLyi38B4rBg-1; Tue, 10 Oct 2023 06:31:10 -0400
X-MC-Unique: -WHS4hAcOyKPLyi38B4rBg-1
Received: by mail-lf1-f69.google.com with SMTP id 2adb3069b0e04-50301e9e1f0so1398309e87.0
        for <linux-kselftest@vger.kernel.org>; Tue, 10 Oct 2023 03:31:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696933868; x=1697538668;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1C2ePqqy9Lk6VTckZlTq+a1e83GQqbEDpw2ShG10pB0=;
        b=bBAWonlG+BpJiPqs7rOZ0N9v0SBJOBavmA68Co6o5R3p5KLUdKSg4v0N4Dfs9P7cfF
         J0S8Z5IJD/lo9HXSudJGyasWiN9ZV5uE64ymb5zadGUZrmUmL0yf0UX6eptxzHRzpz7T
         64/E3QBmxJuXYXXEWrCAdKBwJZ14Cq6OFWy5JsCHL11Jls8cYf6kSW3nOm830NmfSrsJ
         WFoPhSqRPWofvZx7CwRkIIgVg73QXggFpooxciCs55POOdVErCcMKbMb5RKErk2ZddHo
         Wrong5WVZB4QF0toIKGi88bhG2FdmLMvtoxrpDNYjkDiCHPja9rEPMAZ3ndOjk22wLBx
         swSQ==
X-Gm-Message-State: AOJu0YynqvURrW+N3h1FAMmV6sVZnNWgYXtmX4GCoav/uNjRKHNzxpME
        BVZ2vUlbF48J3jdk0gY75hiWawKU6Lk9j+bC8XKxS20FMJi3Aw9j+qqoKnfFh2t3OmHwv3E897k
        +ocWirSKxDzs5SkiZ2eXDnF+sMuh7
X-Received: by 2002:ac2:44af:0:b0:500:8b8d:d567 with SMTP id c15-20020ac244af000000b005008b8dd567mr13954369lfm.1.1696933868586;
        Tue, 10 Oct 2023 03:31:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH4zbsYE0b6xpuabrHTXmkVT5Ih05AnKqJobbYn9oPPUXFCdOy98fOtleNCBIYF/2hGX1lXUg==
X-Received: by 2002:ac2:44af:0:b0:500:8b8d:d567 with SMTP id c15-20020ac244af000000b005008b8dd567mr13954336lfm.1.1696933868226;
        Tue, 10 Oct 2023 03:31:08 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-228-243.dyn.eolo.it. [146.241.228.243])
        by smtp.gmail.com with ESMTPSA id o9-20020a05651238a900b004fe7011072fsm1760741lft.58.2023.10.10.03.31.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Oct 2023 03:31:07 -0700 (PDT)
Message-ID: <417e00407c64ccc39fce35bdb41b6765363d9fb1.camel@redhat.com>
Subject: Re: [PATCH net 4/4] selftests: openvswitch: Fix the ct_tuple for v4
From:   Paolo Abeni <pabeni@redhat.com>
To:     Aaron Conole <aconole@redhat.com>, netdev@vger.kernel.org
Cc:     dev@openvswitch.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, Pravin B Shelar <pshelar@ovn.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Adrian Moreno <amorenoz@redhat.com>,
        Eelco Chaudron <echaudro@redhat.com>
Date:   Tue, 10 Oct 2023 12:31:05 +0200
In-Reply-To: <20231006151258.983906-5-aconole@redhat.com>
References: <20231006151258.983906-1-aconole@redhat.com>
         <20231006151258.983906-5-aconole@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, 2023-10-06 at 11:12 -0400, Aaron Conole wrote:
> Caught during code review.

Since there are a few other small things, please additionally expand
this changelog briefly describing the addressed problem and it's
consequences.

Thanks,

Paolo

