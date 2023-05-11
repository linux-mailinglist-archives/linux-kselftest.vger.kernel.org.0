Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFD066FF5EA
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 May 2023 17:27:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238381AbjEKP14 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 11 May 2023 11:27:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237754AbjEKP1z (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 11 May 2023 11:27:55 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30C4EDC;
        Thu, 11 May 2023 08:27:54 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id A97B85C025A;
        Thu, 11 May 2023 11:27:50 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Thu, 11 May 2023 11:27:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1683818870; x=1683905270; bh=tq0xRJgFEn7zo
        AuFPcq4UZUgJGgAiIZCfjImzNGnHt0=; b=BEs2HaKKzR+i6UMjnhkClU7U5zR7M
        z95NspE0Sp1Ij/1OAWncYDL89LYlR16qkHaEd5iZr1+wFxb0PeJzcggfanQzokC2
        e2M7wcSCUQvYsC4Pb0K1EswAB0LxoUO+QztxF+tM13D19JvvpHv1S1lLZttLMTSR
        XTcw+8rWWQE4PBqSyDDfL7/OOzTbRJeeHZNN5qGcX+xWh/wGaPCg2CEL0Hyn1ycP
        0J/3/tiNpsEy3BOQNWaPyT6i1k3oYFceJ8YoMjrbXxn1mQJuRvI3gsD0i2euIbkm
        6onoMqKSHlEZhTKVxankiyIdmdcZSpCy81z9AxWkufLba3GwbY/VOcwrA==
X-ME-Sender: <xms:dgldZGI0w7UwgoRM-O3MuLEbV3EC362WDR7dViBQrUanCFBLP9jSFQ>
    <xme:dgldZOJ1e1NuiG3COHjKD7nHU3gv7SBi4pQ8tg0pVQehoIllfXTRU51LnGO1C2Ef3
    s70w9JgNhcmjWU>
X-ME-Received: <xmr:dgldZGuVMhc5ABffNGkCqaOj9T4WC5qo3fLCUOB_8XmEfNEne9XW_GIpo9XBQsb1v1psV8YgpQSRFH0WTvbGhaN1NB4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeegkedgkeelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    gfrhhlucfvnfffucdluddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddt
    tddvnecuhfhrohhmpefkughoucfutghhihhmmhgvlhcuoehiughoshgthhesihguohhstg
    hhrdhorhhgqeenucggtffrrghtthgvrhhnpeehhfdtjedviefffeduuddvffegteeiieeg
    uefgudffvdfftdefheeijedthfejkeenucffohhmrghinhepkhgvrhhnvghlrdhorhhgne
    cuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepihguohhs
    tghhsehiughoshgthhdrohhrgh
X-ME-Proxy: <xmx:dgldZLYsTyB-AAf4S5xo2JUPW2_j3rQ15gzZuJ_Y5yb7AwefZeS21w>
    <xmx:dgldZNZR7Stdum_cyWjXeQn-NOXUgsQIdA8AyRZPzT6W4asB_ASTYw>
    <xmx:dgldZHC4wHHmLqfcWrosaiUOOctZoukoO5Xm_pe00O4YCqmzKTynLQ>
    <xmx:dgldZBRzZevdjvVrMBGnN3VejRC2Z35gRWGCM95eSFeicbRRfr4smw>
Feedback-ID: i494840e7:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 11 May 2023 11:27:49 -0400 (EDT)
Date:   Thu, 11 May 2023 18:27:45 +0300
From:   Ido Schimmel <idosch@idosch.org>
To:     Vladimir Nikishkin <vladimir@nikishkin.pw>
Cc:     netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com,
        eng.alaamohamedsoliman.am@gmail.com, gnault@redhat.com,
        razor@blackwall.org, idosch@nvidia.com, liuhangbin@gmail.com,
        eyal.birger@gmail.com, jtoppins@redhat.com, shuah@kernel.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next v8 1/2] vxlan: Add nolocalbypass option to vxlan.
Message-ID: <ZF0JcT5SSF9KLdQ5@shredder>
References: <20230511032210.9146-1-vladimir@nikishkin.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230511032210.9146-1-vladimir@nikishkin.pw>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, May 11, 2023 at 11:22:09AM +0800, Vladimir Nikishkin wrote:
> If a packet needs to be encapsulated towards a local destination IP,
> the packet will be injected into the Rx path as if it was received by
> the target VXLAN device without undergoing encapsulation. If such a
> device does not exist, the packet will be dropped.
> 
> There are scenarios where we do not want to drop such packets and
> instead want to let them be encapsulated and locally received by a user
> space program that post-processes these VXLAN packets.
> 
> To that end, add a new VXLAN device attribute that controls whether such
> packets are dropped or not. When set ("localbypass") packets are
> dropped and when unset ("nolocalbypass") the packets are encapsulated
> and locally delivered to the listening user space application. Default
> to "localbypass" to maintain existing behavior.
> 
> Signed-off-by: Vladimir Nikishkin <vladimir@nikishkin.pw>

The code looks fine to me, so:

Reviewed-by: Ido Schimmel <idosch@nvidia.com>

But the commit message needs to be aligned to the code changes made in
this version (which need to be noted the under the '---' [1]). I
suggest:

"
If a packet needs to be encapsulated towards a local destination IP, the
packet will undergo a "local bypass" and be injected into the Rx path as
if it was received by the target VXLAN device without undergoing
encapsulation. If such a device does not exist, the packet will be
dropped.

There are scenarios where we do not want to perform such a bypass, but
instead want the packet to be encapsulated and locally received by a
user space program for post-processing.

To that end, add a new VXLAN device attribute that controls whether a
"local bypass" is performed or not. Default to performing a bypass to
maintain existing behavior.
"

[1] https://www.kernel.org/doc/html/latest/process/submitting-patches.html#the-canonical-patch-format
