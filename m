Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B9CD73FD98
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Jun 2023 16:18:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230037AbjF0OSw (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 27 Jun 2023 10:18:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229664AbjF0OSv (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 27 Jun 2023 10:18:51 -0400
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72ACDE74;
        Tue, 27 Jun 2023 07:18:50 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id 288B43200902;
        Tue, 27 Jun 2023 10:18:49 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Tue, 27 Jun 2023 10:18:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1687875528; x=1687961928; bh=S1
        D40gp6+PWYTPqDFOllnu+PG6ZODSbCZgaOeRMNOMk=; b=IJDkcnexA858NahWOP
        6/wPMSfBEN5RjQQ5OFDYoJr86LbD+0VuT0sl1bR6Ef/WDcDaxhZWf7q7imOi6IBE
        /F81rplB7nPe6ofa0J/tBasIY1ouJGY64UtHSuCXeMDNZEo4F/PRT7nZ9X2L8okj
        6kgd5amVG1klPjvrry3y+BDAEZcthPiTozlYSicTZTGmeL48+4aBmvqOU3bZpZOH
        J4dCfZP8oXV3yf3qfOo/FAHM9doc262+mYW1G0yQKcAhQ+bOm/rfbvJAWKWB6Hf8
        s0xc79RL4GIzoX68szuOxGCOp22OjE8BmMncnNsSa2ZjDSd2msqIY/1J5K1J2GDB
        vMBQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1687875528; x=1687961928; bh=S1D40gp6+PWYT
        PqDFOllnu+PG6ZODSbCZgaOeRMNOMk=; b=ikT1F2QhAPXkDzCXxFJkpvp/KlqdQ
        igdx7jFSTngtUkC8kdzNoVMjlYwL5HL7NauVzzO5IT6VXmkGmrzStgo/o7ecX1nM
        +ZZRH7SKa9nKbYSjPTHBkHpotDELw46jiyvEHwTaL+LVR9nhgL7KwzVu1V3Vy1TK
        8Dij1AMdzACQw9wVEv8gcaDKngcX4qs6sVGQ+fktjEpHBS5ZvCFVwo08ug3/cF/E
        1Z9yBX8uQQRBtRvRhtZmf5EQy7g829gEeR260p39IZplFeX78Y+4OxxT/AeGUNpy
        PS4EL7dHpNkZWi5Fg+cXiPe13IY6fzgJYqUp1evNU5koI5RLSPvEx24OQ==
X-ME-Sender: <xms:yO-aZAJiD2IA4CxUilKnax6Q2sIlB1MjX7gTN_ts5Xis-ehRvLhXxQ>
    <xme:yO-aZAKjaPCSYa6dBth_D4P6ATBeQ5KuAM_BHiwQLi66JgvdW4BeGTTGBmhiZLLyG
    ioYGNiBDA-5mYmH7Q>
X-ME-Received: <xmr:yO-aZAuMOVg8ngM6tGXw9sm5xGYEzjgJktCXryJ02wSkQ8PVjmJ1bZTxTG7mQYKfNT3iHKl_ZdnCzC2uxCZOBUo05RGEuuW0t88M>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrtddtgdefvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenfg
    hrlhcuvffnffculdejtddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtsfdttddt
    vdenucfhrhhomhepffgrnhhivghlucgiuhcuoegugihusegugihuuhhurdighiiiqeenuc
    ggtffrrghtthgvrhhnpedvfeekteduudefieegtdehfeffkeeuudekheduffduffffgfeg
    iedttefgvdfhvdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfh
    hrohhmpegugihusegugihuuhhurdighiii
X-ME-Proxy: <xmx:yO-aZNbuWS0RNXvdoKdT6A5-U6gKwq2Lc9TuVPaD1Eis-g-4A8NPTQ>
    <xmx:yO-aZHa5ahl8DmHTB0n2EjsvTohQK3L9EY7n0YT2UC2rQPHKVu4ulQ>
    <xmx:yO-aZJCXv4JsOOP1HjTFJV6Bjqzhx5bnp92JekGarxi-g0IthyyIzQ>
    <xmx:yO-aZL7xKGsruRStLr46VGr29MvH-GXmZPpGqWfj2qEzlusRwhsCLA>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 27 Jun 2023 10:18:47 -0400 (EDT)
Date:   Tue, 27 Jun 2023 08:18:46 -0600
From:   Daniel Xu <dxu@dxuuu.xyz>
To:     Florian Westphal <fw@strlen.de>
Cc:     bpf@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        coreteam@netfilter.org, netfilter-devel@vger.kernel.org,
        daniel@iogearbox.net, dsahern@kernel.org
Subject: Re: [PATCH bpf-next 0/7] Support defragmenting IPv(4|6) packets in
 BPF
Message-ID: <uuxfzet3r6eovdtetr26cebbjoohizepbefggab6c5edjqjkjy@ntjyfw3v4jmd>
References: <cover.1687819413.git.dxu@dxuuu.xyz>
 <20230627104820.GF3207@breakpoint.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230627104820.GF3207@breakpoint.cc>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Florian,

On Tue, Jun 27, 2023 at 12:48:20PM +0200, Florian Westphal wrote:
> Daniel Xu <dxu@dxuuu.xyz> wrote:
> > Patches 1 & 2 are stolenfrom Florian. Hopefully he doesn't mind. There
> > were some outstanding comments on the v2 [2] but it doesn't look like a
> > v3 was ever submitted.  I've addressed the comments and put them in this
> > patchset cuz I needed them.
> 
> I did not submit a v3 because i had to wait for the bpf -> bpf-next
> merge to get "bpf: netfilter: Add BPF_NETFILTER bpf_attach_type".
> 
> Now that has been done so I will do v3 shortly.

Ack. Will wait for your patches to go in before sending my v2.

Thanks,
Daniel
