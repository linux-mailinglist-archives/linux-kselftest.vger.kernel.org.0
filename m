Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 074CA6F7ABC
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 May 2023 03:43:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229524AbjEEBnb (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 4 May 2023 21:43:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbjEEBnb (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 4 May 2023 21:43:31 -0400
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF4F2900D;
        Thu,  4 May 2023 18:43:29 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id EC9723200A42;
        Thu,  4 May 2023 21:43:24 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Thu, 04 May 2023 21:43:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nikishkin.pw; h=
        cc:cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1683251004; x=1683337404; bh=/Y
        VNUnh3p+PgM89Dwya/IElj4KFR7bzSFhdZiIuzB3A=; b=lUA416YK92vpONrf7V
        L59IrPtcPDMWU2r5QlAvZhpzZQY6PtwISHSk5C6ij3aOi1axkDFcJQyY4siEkOQ4
        4xemOdWOETe+aD9lH+nkSObyi/lYF9kGM89PMTkVNVBKbYUWi1EQu1HdpqC+lUZJ
        0j4xzdNJpdG3eINBma0Gdyc3h6rvRsNGvSyxdVlv7tZLi6JLT6gXJyjxHYjUVUDA
        9p/qior6CC4El/CrWNkplJeiEbL0P31ufTlAgVstbs64tBOoxsS/7zIrMfq5nFRD
        whOV3JROzTBy6PxYjs1P0xUhxfKXLBscKqLTTOLQXYcP2zO1fKFc68A+AyGTYI+3
        g2MQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1683251004; x=1683337404; bh=/YVNUnh3p+PgM
        89Dwya/IElj4KFR7bzSFhdZiIuzB3A=; b=J5gYOlXklohJoONvqh+Bp629jYVTZ
        16BiIbENgjo+yJ1IOn9QVdDOBZsmAOKXKH9pBDZAX2W26EdWdhCfE2vRjp1tXbr0
        b0sHXodki1Q0TQKQkipvAhO7D+O+A1rcpascjBGjND8Ncky9z8y78hqkEbEM9Eps
        FwhOn7xW+Z18LG+RL7rUp8M7OQnkzwPu128W95uL86N8sNraEaEcNHrDv8eooW1e
        yKx4f47wTYWzVvkk2ttEE4rOWkrrsBQobG/f5tc3AXcBRKcyQg93g8IUnELOReHZ
        pJVF6ZN6BlZ41bQgomsrgRKlzmgaYj1hFDuMisOWqWMJtYQOgqK0xjAEw==
X-ME-Sender: <xms:PF9UZAz2K2ohEukSG4g9FmOTgp_k2imgFzrmXLC3ZHAej-q7w17iog>
    <xme:PF9UZESnzDbkF8q77OG7hr97U3BhW3ECEJK-o2q_V7u1XYs4x0gqxxr0Qlkvx-3Ad
    iURkprEBXS71KG9hLY>
X-ME-Received: <xmr:PF9UZCWoelUWyp9snhZPt3KR59zRU8Xq4uoGci8D7jHriiqbYFdyfgQ7uUqghkrWrApw1cOv>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeefuddghedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    gfrhhlucfvnfffucdluddtmdenucfjughrpehffgfhvfevufffjgfkgggtsehttdertddt
    redtnecuhfhrohhmpegglhgrughimhhirhcupfhikhhishhhkhhinhcuoehvlhgrughimh
    hirhesnhhikhhishhhkhhinhdrphifqeenucggtffrrghtthgvrhhnpeeigfdvgeeiieel
    udehueeuueejieeiheegudevhffggeeguddvveduueehueefgeenucevlhhushhtvghruf
    hiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehvlhgrughimhhirhesnhhikhhi
    shhhkhhinhdrphif
X-ME-Proxy: <xmx:PF9UZOhBSvWS68k2dlmZwhtavjTdGNCvRV20Cz12dUIo6fqgYnUKZQ>
    <xmx:PF9UZCBE-FVZGA5ANx12BkRE-X9m6jIh33IfOvPSnV2o0ZXAIF1kcg>
    <xmx:PF9UZPJdULZALU2N25kT_dbCXgwcgVXYcAld4J4QGKQ_qpuRtTXveg>
    <xmx:PF9UZOyhGxYMOzwOKEAklhGPr0rMbpmYGUbgSPGDpcSTMcmWybHOlA>
Feedback-ID: id3b446c5:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 4 May 2023 21:43:20 -0400 (EDT)
References: <20230501162530.26414-1-vladimir@nikishkin.pw>
 <20230501162530.26414-2-vladimir@nikishkin.pw> <ZFPWNXtV7sTmH/aQ@shredder>
User-agent: mu4e 1.8.14; emacs 30.0.50
From:   Vladimir Nikishkin <vladimir@nikishkin.pw>
To:     Ido Schimmel <idosch@idosch.org>
Cc:     netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com,
        eng.alaamohamedsoliman.am@gmail.com, gnault@redhat.com,
        razor@blackwall.org, idosch@nvidia.com, liuhangbin@gmail.com,
        eyal.birger@gmail.com, jtoppins@redhat.com, shuah@kernel.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next v7 2/2] Add tests for vxlan nolocalbypass option.
Date:   Fri, 05 May 2023 09:33:03 +0800
In-reply-to: <ZFPWNXtV7sTmH/aQ@shredder>
Message-ID: <87sfcb8sej.fsf@laptop.lockywolf.net>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


Ido Schimmel <idosch@idosch.org> writes:

> On Tue, May 02, 2023 at 12:25:30AM +0800, Vladimir Nikishkin wrote:
>> Add test to make sure that the localbypass option is on by default.
>> 
>> Add test to change vxlan localbypass to nolocalbypass and check
>> that packets are delivered to userspace.
>
> What do you think about this version [1]?

I think that your idea of making "nolocalbypass" applicable universally
is more clear and more straightforward than doing an exception to a
special case, as the original patch does. I had actually considered such
a change myself, and only decided against it because I wanted a patch
that changes the existing behaviour in a minimal way.

If you are happy with a more radical behaviour for "nolocalbypass", I am
all for it.

I can even imagine a line in the documentation, something along the
lines of "The use of the nolocalbypass flag makes debugging easier,
because the packets are seen on widely available userspace network
debugging tools, such as tcpdump. You might want to debug and tweak your
system using this flag, and when you are convinced that the system is
working as expected, turn it off for a performance gain."

I will re-submit this series of patches on after the 8th of May 2023.

-- 
Your sincerely,
Vladimir Nikishkin (MiEr, lockywolf)
(Laptop)
--
Fastmail.

