Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AE2471235C
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 May 2023 11:21:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242430AbjEZJVz (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 26 May 2023 05:21:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230240AbjEZJVx (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 26 May 2023 05:21:53 -0400
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4C921B1;
        Fri, 26 May 2023 02:21:23 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 5C22D5C00DF;
        Fri, 26 May 2023 05:21:23 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Fri, 26 May 2023 05:21:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1685092883; x=1685179283; bh=Th
        5sPJegF565hJ/l2p1q9i7N8Mb/IijkIAurtMCasPA=; b=WLdX1vOqYDygwHykwe
        Ee1k4Mi4aY19PjwhIUM5R+sTxV2UZj3xZgs9a4hOSbaJSvnpCtw4w/V/aezTeWjO
        NNFVuzIYS9wn+wOJFEMeDSsaqoj9FA87kv+D23Miq5GAYLk9cBGSIDe60vSsCD8P
        uORjVca+i9z/gRNEOvO2Or+FWZPhZb605zvlbbjrb9w0paiRWR9RWVgmW+jGsj3w
        vE9wg+So10AKZG90QZfnCEaJU/5M84Fm1b4zYa4TyIxn5bUGQRwJ8IUvNV3nndXk
        Nqpw3WJKRZ72cq73ImtrssqBJs/x9qxN4G2wnetYr11haEgd+1hMsmdIXRdaHfWd
        z7vA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1685092883; x=1685179283; bh=Th5sPJegF565h
        J/l2p1q9i7N8Mb/IijkIAurtMCasPA=; b=S9x+unDIjqon9YIvHBC9tHY3Z5AEs
        uA44buB/NMQ7bZtIt4vOmJmFBgdaM3TdBrFsPvBkQ6CAvKGu+KFztRYftm+4GEER
        5ucf0+RVdrURUED12Eje4k/JicX0YTw5mG/pnl0jH160P0hzesVn3BOmluNCv4mv
        LA6dgyCd75yrtStphXv9BIEs1TdaW4RnLgyLmx274PQDo9xd6fWRZbFUP32tV09r
        rD+3/wMWYcftCYEbzVuoA1MmLEYi2LDjUA5nU4axOZWTs135XYvOQDDmXKUUm8PL
        9vi6RWUiIq2WjHPtPM/CdXy7w+nNHEArgBybD2ux0chN6ACQAtXDKMJ/w==
X-ME-Sender: <xms:E3pwZHlrgvt6i8nVuSEzRpH1GXnaV2IriKIC6HGgL-cURZlz1EHWYQ>
    <xme:E3pwZK2UmIyMZlco9W5FTAmm255kwrjznREhfwfWgTqPF-kFBORyt5ycv2LK-Er3p
    HSA9ukaTPXAwKkQiF4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeejledgudegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:E3pwZNoTZ__zZ62x32Lph4j9VXE5oV36sUpxSinE4Svu3K_f44BB2w>
    <xmx:E3pwZPm7lPh0Ivia5ta9N2BFSjsPBjtHs0QZZa7uyS2YWMGh6R_8vg>
    <xmx:E3pwZF2DBeydvss40h4xAlLqmAhE2iYoXeGarXG-NVUe_S7tA_EekA>
    <xmx:E3pwZN-7Qf0jBP7w-WFED2NGze-WCn8NINPt0Co4gQkcNdm5levWqg>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 07AFFB60086; Fri, 26 May 2023 05:21:23 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-441-ga3ab13cd6d-fm-20230517.001-ga3ab13cd
Mime-Version: 1.0
Message-Id: <ee8b1f02-ded1-488b-a3a5-68774f0349b5@app.fastmail.com>
In-Reply-To: <b306ae7b53d67acad6d1e2f63d43505d79f81241.1684949267.git.falcon@tinylab.org>
References: <cover.1684949267.git.falcon@tinylab.org>
 <b306ae7b53d67acad6d1e2f63d43505d79f81241.1684949267.git.falcon@tinylab.org>
Date:   Fri, 26 May 2023 11:21:02 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Zhangjin Wu" <falcon@tinylab.org>, "Willy Tarreau" <w@1wt.eu>
Cc:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-riscv@lists.infradead.org,
        "Palmer Dabbelt" <palmer@dabbelt.com>,
        "Paul Walmsley" <paul.walmsley@sifive.com>, thomas@t-8ch.de
Subject: Re: [PATCH 04/13] selftests/nolibc: syscall_args: use __NR_statx for rv32
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

On Wed, May 24, 2023, at 19:48, Zhangjin Wu wrote:

> 
> +static int test_syscall_args(void)
> +{
> +#ifdef __NR_fstat
> +	return syscall(__NR_fstat, 0, NULL);
> +#elif defined(__NR_statx)
> +	return syscall(__NR_statx, 0, NULL, 0, 0, NULL);
> +#else
> +#error Neither __NR_fstat nor __NR_statx defined, cannot implement 
> syscall_args test
> +#endif
> +}

Does this need to work on old kernels? My impression was that
this is only intended to be used with the kernel that ships the
copy, so you can just rely on statx to be defined and drop
the old fallbacks (same as for pselect6_time64 as I commented).

      Arnd
