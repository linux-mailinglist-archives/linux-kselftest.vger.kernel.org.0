Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE0C074427E
	for <lists+linux-kselftest@lfdr.de>; Fri, 30 Jun 2023 20:45:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233286AbjF3Spr (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 30 Jun 2023 14:45:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232840AbjF3Spq (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 30 Jun 2023 14:45:46 -0400
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E90BF4217;
        Fri, 30 Jun 2023 11:45:42 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id 3197132009B8;
        Fri, 30 Jun 2023 14:45:38 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Fri, 30 Jun 2023 14:45:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1688150737; x=1688237137; bh=OD
        7NEWZMjnc3AbjUhqszEH5f8FSq8A02z7HM+Zk5VTQ=; b=nZqga/m9GefFoRkgjW
        wCScpF4TnDnGPeuUasUAy0Tsutz2ksKQc0YunXEFrcBfPE1RDulZktzaFWLnV5ig
        WABir1b5wSPpM3Off4SL8xcJ8Qc8KLoXqvytAqKlsJvQggbeKYGTCpEFooDczmnH
        R1BFVwrtV2ThDKmsLeOPs8NFJXW8SkfHKVNeAd4Ovh64XOSWtlcaUKdRGJmjPx9N
        muDzkqaqkIFOdRv4FUdtFmChaiEpsQrpAq3BocX5+EMSbIRVFG7HsJUjZJtldQiA
        4JdCzPce1O/RWqkQaFBKHbA9J/kRxGs7S0uyppxsgXuvj2BvbnrBlfWMe+Ni22Ni
        Lovg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1688150737; x=1688237137; bh=OD7NEWZMjnc3A
        bjUhqszEH5f8FSq8A02z7HM+Zk5VTQ=; b=FYCMuqxz/bkccAwK5NS/IJZ1ViBqp
        BEaW+z7djcsHzcEIuvYEn5rCD36aqPfmJeU7NX201iQfj1Wz6BO97KGNF3Wk8vyy
        MNKx3nKrWZUUJE+j6XXEWq4HAPn/OD/3Db18XYUGyXIf8mvPbBbgJwwp0NbeLRaF
        ymaUIygjD3H9h0nCb0B9VZTKb3LQgu7e1uWVvNg5R26SUHSYoEpPxs4PAq279qm6
        OKXxb6P3gCMkcxludO0XpzlgpZWEKtdNK5FdyeqW8rX4CmCYP+DfL8zA99m7vExq
        o/WTGB8T8RudCVRyoXrNHxvaJVrQOrt2U5Jyai6Y2iQINlKshvI8BvT6g==
X-ME-Sender: <xms:0CKfZIxwRzPTUcYaML1VsJb665JNARXTd1nAPENK_uUR1XEzwdmXoQ>
    <xme:0CKfZMTPjnVb4EYOyIf6JF7pg5h8qF7Qr9-Cq09JZdeLC4jIZ5f96HsN1tHUlkm6Z
    VQIWOB8NbKCsc-z4Go>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrtdeigdduvdeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:0CKfZKXmiNSLkZ4ueENKRKQAG6kHMQ6fsydFp3bp5kKmowxaKQnDCQ>
    <xmx:0CKfZGjegXjsThipzMoMMNtNS_BFskCX9a0AnzfQGhI-l64YJhOvvA>
    <xmx:0CKfZKDmQHGB-_ejbm0Qp3U929NvGSeSl2qv4azreS3wpRdKVXu4Pg>
    <xmx:0SKfZFOQadL6j0CCbRB-TlMDEffqCZJIA16KF2kiQviHEQQIduXprA>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 7BD88B60092; Fri, 30 Jun 2023 14:45:36 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-499-gf27bbf33e2-fm-20230619.001-gf27bbf33
Mime-Version: 1.0
Message-Id: <d096e463-b135-49b1-884b-a3038723ccdd@app.fastmail.com>
In-Reply-To: <20230630180126.283419-1-falcon@tinylab.org>
References: <dc7b8b17-4338-424f-a1f1-c12fb7ea08bd@app.fastmail.com>
 <20230630180126.283419-1-falcon@tinylab.org>
Date:   Fri, 30 Jun 2023 20:45:15 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Zhangjin Wu" <falcon@tinylab.org>
Cc:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>,
        =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas@t-8ch.de>,
        "Willy Tarreau" <w@1wt.eu>
Subject: Re: [PATCH v3 03/14] selftests/nolibc: add _LARGEFILE64_SOURCE for musl
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

On Fri, Jun 30, 2023, at 20:01, Zhangjin Wu wrote:
> Hi, Arnd
>
>> On Fri, Jun 30, 2023, at 16:44, Zhangjin Wu wrote:
>> > _GNU_SOURCE Implies _LARGEFILE64_SOURCE in glibc, but in musl, the
>> > default configuration doesn't enable _LARGEFILE64_SOURCE.
>> >
>> > From include/dirent.h of musl, getdents64 is provided as getdents when
>> > _LARGEFILE64_SOURCE is defined.
>> >
>> >     #if defined(_LARGEFILE64_SOURCE)
>> >     ...
>> >     #define getdents64 getdents
>> >     #endif
>> >
>> > Let's define _LARGEFILE64_SOURCE to fix up this compile error:
>> 
>> I think a better solution would be to use the normal getdents() instead
>> of glibc getdents64(), but then define _FILE_OFFSET_BITS=64 to tell
>> glibc to use the modern version of all filesystem syscalls.
>> 
>
> Just checked the getdents manpage[1] and the nolibc code, both of glibc and
> nolibc don't provide the getdents() library routine but both of them provide
> the getdents64(), only musl provide getdents() by default.
>
> And as the manpage shows, it is not easy to call getdents() with glibc, we
> need manually call syscall() and define the 'dirent' struct ourselves:
>
>     glibc does not provide a wrapper for getdents(); call getdents()
>     using syscall(2).  In that case you will need to define the
>     linux_dirent or linux_dirent64 structure yourself.
>
> And for nolibc, a getdents64() with linux_dirent64 struct (with int64_t offset)
> is provided, there is either no getdents() currently.
>
> This patch aims to let nolibc-test at least compile for musl and therefore we
> can easily check the new tests for musl, glibc and nolibc together.

Ok, I see. Your current approach should be fine then.

> For the 64bit offset related stuff, we'd better delay it in another patchset
> (part of full rv32 support), which will convert the off_t to 64bit by default.

Right, makes sense.


    ARnd
