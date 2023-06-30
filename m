Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FF88743EAA
	for <lists+linux-kselftest@lfdr.de>; Fri, 30 Jun 2023 17:23:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232583AbjF3PXx (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 30 Jun 2023 11:23:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232543AbjF3PXv (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 30 Jun 2023 11:23:51 -0400
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 837173C26;
        Fri, 30 Jun 2023 08:23:46 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 89AFF5C0676;
        Fri, 30 Jun 2023 11:23:45 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Fri, 30 Jun 2023 11:23:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1688138625; x=1688225025; bh=IL
        g/wPOhXEcgQ5Av4DXDVBtyA0OobUQWTU0tPHfsP7s=; b=KpqedbCuGpeTfWO8aR
        H9i7PlsCFvlHcBZsJOGhJOKX5VRjNurfW2SCuGQvalOFaq/i2J/yQfjPjiT5hORZ
        AlNKYrhrkkCIICEZMrLP1VcsnMI8semBtNYfLrRv21RAxdB9LKKsneg3RZbOKMch
        1k1p/yjAjZgp9sf5JuqoFky0iPJIq+Hf4k/Y04YYvMQrj9PGh7W9q4UhRNQb3afu
        1sTsNNdW2uFEvYCOcVz2zpBIzmT34j6P6WOllzAUs9g5X/ebzH1cyFuOrfin3EUL
        9ow7AfQwiyYsncCyjCVBq4vvQBqfsrewwVph7q8WZ/iMNocFxpr7NbyvDgVKelCd
        kVyg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1688138625; x=1688225025; bh=ILg/wPOhXEcgQ
        5Av4DXDVBtyA0OobUQWTU0tPHfsP7s=; b=PR8/rBOJ661jJEQkqegRQk26V7Q8P
        P7loAA/laIYtFFcpwxW73pyDvi4wQGzAZno/sfpt46KbJXp6+NwqYqqqmpStdfd+
        WgEDhj7DLIn10DpIV6Wkizkt+8crbXjeKv36AN8Swu4Q5NRWVxF77DvjyFGszVGq
        ag2bxWggdKj/bFsGge/yqGN3GiPV3ZaSE9fTN8uYfnzexvQZXSc/uZX2sqlZE+3I
        06oY++rdWmT/4gzAKaZfdUt0TDa1I0lt+uqd1XsqtshHd5FsLGgLb8tz52OkdJ0D
        rLHuwnyJ6V62q0kb1WRl5q26b70Elusw0Fv2S/pumL50I4UWfsFpZR+dg==
X-ME-Sender: <xms:gfOeZA2WFjX1hT6kw_7BSjNgobGk1iQRpo5eyv1Xf2r1MJf0LUeo5w>
    <xme:gfOeZLGtX8fNZWE5MObxvF0HzlqeCTqliqrprVeRpeJGJOdYRN94czCEILI539blt
    G_PjJvx7ACRbm5oWXg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrtdeigdekiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdetrhhn
    ugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtth
    gvrhhnpeffheeugeetiefhgeethfejgfdtuefggeejleehjeeutefhfeeggefhkedtkeet
    ffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrh
    hnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:gfOeZI5SVm4qGM-HSuJiFMUPZXrmLu4UlYM2SVeGXDQFDyNtRnnICA>
    <xmx:gfOeZJ0muAwX_k5KTlLZx7dexdIYwA1adxvIK9KqrDaQN5uSvaghaQ>
    <xmx:gfOeZDFDGdgB_0jh1g_jm1HzvztBND-q96RJeNiGIn9c6DqNgbtqHQ>
    <xmx:gfOeZLCajJOSrGYznpxXSuetO8srW4lAsDKvH693EKXR5HoD_r1NqA>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id E8010B60092; Fri, 30 Jun 2023 11:23:44 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-499-gf27bbf33e2-fm-20230619.001-gf27bbf33
Mime-Version: 1.0
Message-Id: <dc7b8b17-4338-424f-a1f1-c12fb7ea08bd@app.fastmail.com>
In-Reply-To: <c61f64c4d1f69c19b41efae8fef5a94547089ca7.1688134399.git.falcon@tinylab.org>
References: <cover.1688134399.git.falcon@tinylab.org>
 <c61f64c4d1f69c19b41efae8fef5a94547089ca7.1688134399.git.falcon@tinylab.org>
Date:   Fri, 30 Jun 2023 17:23:24 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Zhangjin Wu" <falcon@tinylab.org>,
        =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas@t-8ch.de>,
        "Willy Tarreau" <w@1wt.eu>
Cc:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Subject: Re: [PATCH v3 03/14] selftests/nolibc: add _LARGEFILE64_SOURCE for musl
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Jun 30, 2023, at 16:44, Zhangjin Wu wrote:
> _GNU_SOURCE Implies _LARGEFILE64_SOURCE in glibc, but in musl, the
> default configuration doesn't enable _LARGEFILE64_SOURCE.
>
> From include/dirent.h of musl, getdents64 is provided as getdents when
> _LARGEFILE64_SOURCE is defined.
>
>     #if defined(_LARGEFILE64_SOURCE)
>     ...
>     #define getdents64 getdents
>     #endif
>
> Let's define _LARGEFILE64_SOURCE to fix up this compile error:

I think a better solution would be to use the normal getdents() instead
of glibc getdents64(), but then define _FILE_OFFSET_BITS=64 to tell
glibc to use the modern version of all filesystem syscalls.

     Arnd
