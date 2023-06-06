Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF72772391C
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 Jun 2023 09:35:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231911AbjFFHfy (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 6 Jun 2023 03:35:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235090AbjFFHfx (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 6 Jun 2023 03:35:53 -0400
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3DB711D;
        Tue,  6 Jun 2023 00:35:51 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 129EA5C00CC;
        Tue,  6 Jun 2023 03:35:49 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Tue, 06 Jun 2023 03:35:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1686036949; x=1686123349; bh=JP
        6R94uQbzQBfUBBvYz80fUZWf0TL/O0HNFiOYoH0g8=; b=VzA/5wvw+R/Q0vEigx
        C6bAunIc1d6yzEraxrGySxrM2Id2FfJbsuAgHJIWW7cxm+dvWvB+5urBCTuP/aCt
        oBtRxJh+nBd0aERvmDnApWrYKp9f+vx1onw2ekLHupDXSbY1FoeS1M0XW1vntoYb
        QILd8QYJa+0e2BlpOuwrHwouhgh8HewOcxOwEZjxWf43hJtvhpcbUDhizkUiqr4W
        6XPiIvx3fOWe63trfROGA4YOvcPc4PFY6vjuSb6FTWqBJaD4F5DlISMf4dvrOHKp
        CN3YJvGMiM1ktsW/dO7PZ+kK5QPvg8i7+CdDMH53oVygrDLDsIx+HdbQ9crCMRnD
        RdxQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1686036949; x=1686123349; bh=JP6R94uQbzQBf
        UBBvYz80fUZWf0TL/O0HNFiOYoH0g8=; b=NJZ/bUauyn6r9C2HniX6H8c+cfhTz
        zWalf2888DaLopnoz27/2Bhayjh1J7fAqLRxel8pdEoGtvN74uqeJskTSRP+PjKx
        1ACNlag3qsQY4TwYXeJOX+b6caxIE6GXgCvw4UocZ0dAj8RKictsabo9jR4oKDSb
        1kPRfEvSld4q463ZukNMi2EZc6nMf5UK3T0Fo1KnhqbzjaBEyZKdIbUbcpwUoKGw
        O2+xz/3sKW1RDpfi5te+Ln8XeCEquZEZYHke4XoS6cJg+aDrbTXLBxYVcKZsKBGE
        d4uBpzsPSLmAiOa9419nOpkYnrH3vHZog8Nh8bztyXiKFPz58qOvk7IWQ==
X-ME-Sender: <xms:1OF-ZKt9FM-Vh1KjIFQye05jUJr2DB9M0kJ3xkz2GOCM6xJIrEKTNA>
    <xme:1OF-ZPc_OwDlWmBUK1wtW1BsCPhNvqwQxqXM5bja4oepM_sVkE4bblHJ4TNFnAUFe
    l8u3RWEGfH9F8vJeIQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrgedttddguddvtdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdet
    rhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrg
    htthgvrhhnpeevhfffledtgeehfeffhfdtgedvheejtdfgkeeuvefgudffteettdekkeeu
    feehudenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomheprghrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:1OF-ZFx-xnV4OSZPeRQwP67_ZNCCCObOLZBge6a0A-hiiSGnA4RcPA>
    <xmx:1OF-ZFPhvQTI52yGaUY8KdiJAuK1kW_ejI79kv0KPVwIzhhHHWtTaA>
    <xmx:1OF-ZK9GEYwyjb3dy3bwc6Lir3zhwym7NWTiTM4_J37LyQs2LkUklw>
    <xmx:1eF-ZBZ6vCszYkLrJswcZcm_k0XMuUbT_z6z-oydrUerYNiK6XLS_w>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 5175CB60086; Tue,  6 Jun 2023 03:35:48 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-447-ge2460e13b3-fm-20230525.001-ge2460e13
Mime-Version: 1.0
Message-Id: <4fcdd08c-e6fb-40b7-9f2b-77f96e798b37@app.fastmail.com>
In-Reply-To: <f2776eb566b8cf2409d2c21f83ebf85ab92d2f09.1685780412.git.falcon@tinylab.org>
References: <cover.1685780412.git.falcon@tinylab.org>
 <f2776eb566b8cf2409d2c21f83ebf85ab92d2f09.1685780412.git.falcon@tinylab.org>
Date:   Tue, 06 Jun 2023 09:35:27 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Zhangjin Wu" <falcon@tinylab.org>, "Willy Tarreau" <w@1wt.eu>
Cc:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-riscv@lists.infradead.org,
        =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas@t-8ch.de>
Subject: Re: [PATCH v3 1/3] tools/nolibc: fix up #error compile failures with -ENOSYS
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sat, Jun 3, 2023, at 11:01, Zhangjin Wu wrote:
>
> Suggested-by: Arnd Bergmann <arnd@arndb.de>
> Link: 
> https://lore.kernel.org/linux-riscv/5e7d2adf-e96f-41ca-a4c6-5c87a25d4c9c@app.fastmail.com/
> Signed-off-by: Zhangjin Wu <falcon@tinylab.org>
> ---
>  tools/include/nolibc/sys.h | 26 +++++++++++++-------------
>  1 file changed, 13 insertions(+), 13 deletions(-)
>
> diff --git a/tools/include/nolibc/sys.h b/tools/include/nolibc/sys.h
> index 856249a11890..78c86f124335 100644
> --- a/tools/include/nolibc/sys.h
> +++ b/tools/include/nolibc/sys.h
> @@ -124,7 +124,7 @@ int sys_chmod(const char *path, mode_t mode)
>  #elif defined(__NR_chmod)
>  	return my_syscall2(__NR_chmod, path, mode);
>  #else
> -#error Neither __NR_fchmodat nor __NR_chmod defined, cannot implement 
> sys_chmod()
> +	return -ENOSYS;
>  #endif
>  }

I think the most logical would be to have each syscall (chmod,
fchmodat, ...) have its own function that returns -ENOSYS if
that is not defined, and have the logic that decides which one
to use as a separate function.

This patch is a step in that direction though, so I think that's
totally fine.

     Arnd
