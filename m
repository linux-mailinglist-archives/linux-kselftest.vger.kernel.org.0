Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54ADE769B23
	for <lists+linux-kselftest@lfdr.de>; Mon, 31 Jul 2023 17:48:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230176AbjGaPss (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 31 Jul 2023 11:48:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232557AbjGaPsk (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 31 Jul 2023 11:48:40 -0400
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19F6B188;
        Mon, 31 Jul 2023 08:48:33 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 2804F5C01AF;
        Mon, 31 Jul 2023 11:48:32 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Mon, 31 Jul 2023 11:48:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1690818512; x=1690904912; bh=27RrpVb0fJrKV
        16IE46CaVHMUvzfYPXPG/0myoO6SvA=; b=0ScKz1Um7XPgRQfzP3imVy6eQKowp
        CAS7y6PTQeU5jRZV3jC2/+2nRIzYiM/IhsG0Iu2duwmuqjwW1SUOnIaspOxtK8zb
        22D3y7i1l2+Nnnx9mjGi/IoWO07+++Ne9MmOtWjPDZfBBirk9rxPhyXYVXSzdi7Y
        hUXp0miove+RoScyeXR/pvr3hrtG4lo3rq6RG/uPYKSHKylil/J/vMgtYeJ3n9kW
        qPz2nPEOkJKBp47/o5aiiv4sqDzNW2OzkA75k42bgFF07SWySzaRZNzjW7sMGYUm
        U92BigqhOHpblkjV+WTHjSJKu4oECc48nlZwa6Cy0Ym6nd1U1g8tFdXFQ==
X-ME-Sender: <xms:z9fHZBXMuQHqUL5mtsFYDtzJ7cByzvUnrNOZLHzJm4tJlsoXaxVsKA>
    <xme:z9fHZBnfyEqdQ2pTsT86ZLZjunMLIOdSNlkuibGGLOERMtGlhjQDAy6-hBYM_TlQG
    Lse_UpDUQ4aoZ0>
X-ME-Received: <xmr:z9fHZNbLY6BdiHHCD7j6zMzw-Yb3zcqEKntThq8ivMVgioO3A7-b6z66l_sP>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrjeeggdeilecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefkughoucfu
    tghhihhmmhgvlhcuoehiughoshgthhesihguohhstghhrdhorhhgqeenucggtffrrghtth
    gvrhhnpefhffejgefhjeehjeevheevhfetveevfefgueduueeivdeijeeihfegheeljefg
    ueenucffohhmrghinhepghhithhhuhgsrdgtohhmnecuvehluhhsthgvrhfuihiivgeptd
    enucfrrghrrghmpehmrghilhhfrhhomhepihguohhstghhsehiughoshgthhdrohhrgh
X-ME-Proxy: <xmx:z9fHZEV6y7XijHDOtZXmiXL4Jf3H-caRWrAgDrACnaZORlnPDV7r9g>
    <xmx:z9fHZLnRXAESmhq3FwoDgIW0HX_Yno0P7y9oXOieIER9x5BqBneVsw>
    <xmx:z9fHZBceZD6WKs6cgHiKdLm7qkQp91rkaUc4A3IoUybnTJG11bOemA>
    <xmx:0NfHZEi29yN6UeRHXSHbMf1zIX8vsIQC9DzGdVU7v6t65zW7JYkbjA>
Feedback-ID: i494840e7:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 31 Jul 2023 11:48:30 -0400 (EDT)
Date:   Mon, 31 Jul 2023 18:48:01 +0300
From:   Ido Schimmel <idosch@idosch.org>
To:     Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>
Cc:     petrm@nvidia.com, razor@blackwall.org,
        Ido Schimmel <idosch@nvidia.com>, netdev@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>
Subject: Re: [PATCH v1 01/11] selftests: forwarding:
 custom_multipath_hash.sh: add cleanup for SIGTERM sent by timeout
Message-ID: <ZMfXsVAfpizMKH/U@shredder>
References: <ZL6OljQubhVtQjcD@shredder>
 <cab8ea8a-98f4-ef9b-4215-e2a93cccaab1@alu.unizg.hr>
 <ZMEQGIOQXv6so30x@shredder>
 <a9b6d9f5-14ae-a931-ab7b-d31b5e40f5df@alu.unizg.hr>
 <ZMYXABUN9OzfN5D3@shredder>
 <da3f4f4e-47a7-25be-fa61-aebeba1d8d0c@alu.unizg.hr>
 <ZMdouQRypZCGZhV0@shredder>
 <2f203995-5ae0-13bc-d1a6-997c2b36a2b8@alu.unizg.hr>
 <ZMei0VMIH/l1GzVM@shredder>
 <cadad022-b241-398d-c79d-187596356a72@alu.unizg.hr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cadad022-b241-398d-c79d-187596356a72@alu.unizg.hr>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Jul 31, 2023 at 05:13:37PM +0200, Mirsad Todorovac wrote:
> You can add:
> 
> Tested-by: Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>

Added your tags to all 17 patches. Available here:
https://github.com/idosch/linux/tree/submit/selftests_fix_v2

Will submit later this week (most likely on Wednesday) after I verify
they don't cause other regressions.

Thanks for testing and reporting.
