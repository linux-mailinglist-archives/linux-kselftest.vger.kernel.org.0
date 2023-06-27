Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF94D73FF04
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Jun 2023 16:54:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232160AbjF0OyE (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 27 Jun 2023 10:54:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231854AbjF0Oxs (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 27 Jun 2023 10:53:48 -0400
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 267A4FA;
        Tue, 27 Jun 2023 07:51:51 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id 076803200902;
        Tue, 27 Jun 2023 10:51:49 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Tue, 27 Jun 2023 10:51:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
        :cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm1; t=
        1687877509; x=1687963909; bh=J3c7xEg1YYI1wbRJy4qEuZ+boAxMySi5/Do
        IOAO5gmQ=; b=hz+vJUg6/cZg8YDhve5zDRJlNDDz7L3F3NrNUBFBV7BRIVCY/cO
        yudg+iwgFub4Y2o/zqIA/jswngiWu1DT8Jtxii5L/zV/tI7xKQMHIDfjpziFGnf6
        GP9WqzvTGneYGh0KxDj5Mgj0oVPZgiEUIhiZ0iwlOXwgt9X1SSdmBUm3rQvNli8Q
        W8Mgh17/B455eXKqfEsS4kjEw1tVnvqlUnBxElvl6AW61PvnKkA2+28lc0RiJbLo
        CcFMZ0Ec+tvHXrIrB8Hz7uZ/IVQsDk38cuBOokKNrPWdsbAGQvYpSVk88JcQcoiV
        jDvm4fvt/sJq9F9J0lvtjbvb2gMlopxHI6Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
        1687877509; x=1687963909; bh=J3c7xEg1YYI1wbRJy4qEuZ+boAxMySi5/Do
        IOAO5gmQ=; b=A29GD4T+i5IqDhXAoTc3X1F9q08SZiK4F/dqN2gK6eClwF+xUsc
        Rb0kKaF8UXdrQWfWsfMX81NxWhJ4C37Yzn0VGKYaUF6ug2i8EYo7Musc3OhnuKSX
        lsMwf5JynptvrqXgKjpDtbKF0V3Bb3iwxDy+q9Eu+/1nHbsSoEeL5h7SeS/19n3g
        OHxElU34m3xpbnt5F0o1UE6pUc9uucx3wzW5PgnjUtetc2HZRcmxZLBJFlHFcGMN
        xrIOcU2UGUdIoRihQVhfe/MwciVfteHECfgqJzrjGzz3qYXsnI9l8dn+yRLLktf7
        6IMfDTEJRTQam69e+SHFs9Rz2N718k/vZVQ==
X-ME-Sender: <xms:hfeaZOUsX6-KqQxbmdgBnMZ6wNH0rhCxn1TOVs_SDDeMdBKYWuM00A>
    <xme:hfeaZKn37W5L4sGVVjJChvYyulvnep473lsDql4-0UvzhhD6PHZhmWb3yXSqIQJlx
    4ZxETT6TQTyUySDAA>
X-ME-Received: <xmr:hfeaZCahAN26rfSxkkVFGPyXi3CD6Qb9wQDzyqvVXo7SvVpGNOML-JGHFq0lorqspFmU4Rvw4wQG7TvMV8IH_p-T5G0svIZBpKax>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrtddtgdeflecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenfg
    hrlhcuvffnffculdejtddmnecujfgurhepfffhvfevuffkfhggtggugfgjsehtkefstddt
    tddunecuhfhrohhmpeffrghnihgvlhcuighuuceougiguhesugiguhhuuhdrgiihiieqne
    cuggftrfgrthhtvghrnhepudefiedtieehffeuffelffegheegjeekteekgfdtkeefjeeh
    ffejtdfgkeeiteelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilh
    hfrhhomhepugiguhesugiguhhuuhdrgiihii
X-ME-Proxy: <xmx:hfeaZFUt-HHxVlILylDOTB_guDV_gvTgjgjh468_aQIlDVu3G1dY9g>
    <xmx:hfeaZIlvBTx6nBB6Nj_IvLEBd3yma-IqEq_zlI5mgoKcGK6pxQm7IQ>
    <xmx:hfeaZKcvuJFGIxzHbokFp40x4LcuS9dbxC7U8xOHom64hGUfV0fckg>
    <xmx:hfeaZC4fUpuPIKeRG5l1RH2I8d9cULCwJgiGhNg6D1ehy4U2aU3GkQ>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 27 Jun 2023 10:51:48 -0400 (EDT)
Date:   Tue, 27 Jun 2023 08:51:47 -0600
From:   Daniel Xu <dxu@dxuuu.xyz>
To:     Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
Cc:     bpf@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        coreteam@netfilter.org, netfilter-devel@vger.kernel.org,
        fw@strlen.de, daniel@iogearbox.net, dsahern@kernel.org
Subject: Re: [PATCH bpf-next 0/7] Support defragmenting IPv(4|6) packets in
 BPF
Message-ID: <hwsdt5pjygunx7lxrvnwjerugchzpu5mpb442hlwf2h5szqq2h@cuqbteb6bqyh>
References: <cover.1687819413.git.dxu@dxuuu.xyz>
 <874jmthtiu.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <874jmthtiu.fsf@toke.dk>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Toke,

Thanks for taking a look at the patchset.

On Tue, Jun 27, 2023 at 04:25:13PM +0200, Toke Høiland-Jørgensen wrote:
> > The basic idea is we bump a refcnt on the netfilter defrag module and
> > then run the bpf prog after the defrag module runs. This allows bpf
> > progs to transparently see full, reassembled packets. The nice thing
> > about this is that progs don't have to carry around logic to detect
> > fragments.
> 
> One high-level comment after glancing through the series: Instead of
> allocating a flag specifically for the defrag module, why not support
> loading (and holding) arbitrary netfilter modules in the UAPI? If we
> need to allocate a new flag every time someone wants to use a netfilter
> module along with BPF we'll run out of flags pretty quickly :)

I don't have enough context on netfilter in general to say if it'd be
generically useful -- perhaps Florian can comment on that.

However, I'm not sure such a mechanism removes the need for a flag. The
netfilter defrag modules still need to be called into to bump the refcnt.

The module could export some kfuncs to inc/dec the refcnt, but it'd be
rather odd for prog code to think about the lifetime of the attachment
(as inc/dec for _each_ prog execution seems wasteful and slow).  AFAIK
all the other resource acquire/release APIs are for a single prog
execution.

So a flag for link attach feels the most natural to me. We could always
add a flag2 field or something right?

[...]

Thanks,
Daniel
