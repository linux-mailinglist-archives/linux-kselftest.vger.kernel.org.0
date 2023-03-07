Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E0E46AF36D
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 Mar 2023 20:04:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233653AbjCGTEl (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 7 Mar 2023 14:04:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231618AbjCGTES (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 7 Mar 2023 14:04:18 -0500
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9402B76F45;
        Tue,  7 Mar 2023 10:50:00 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 66BEB5C0297;
        Tue,  7 Mar 2023 13:49:37 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Tue, 07 Mar 2023 13:49:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=devkernel.io; h=
        cc:cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1678214977; x=1678301377; bh=P2
        eYCUn4XQ1ZPSM5uBDSRPlUAfsQ7yKQeLEQr2QQkBg=; b=lOa2rchhGbSWNj3QQn
        LVtyqUiyyaux6Ad9uRo/4mfKTBv/zrUwv9AumTiI6vm9vTS/VsYycMcENUP6ircn
        egJTH1cW/4LhQ5dnFkkyboJXsGSwmmKmBfZsRKOshjve7tn4WxcPcPW77ua6/4dM
        qF03TGGTmsBE/F7gomsrIL89QjY5dc39JefVqzo8wR1HHFRBu5pWcTTzPUWFD38M
        vFgXYeXlTlgpQQszT+BKbejS8kYxQ+ZY8FtRqnNCu1WFFfAmkjro7zNKAnRsfoKO
        V9vQaYhwVd/zC/WuxOuwSVnewZEk7rG7jf13MZRgynKMhMllsGyvtlk1YFaPgDhn
        dPgg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1678214977; x=1678301377; bh=P2eYCUn4XQ1ZP
        SM5uBDSRPlUAfsQ7yKQeLEQr2QQkBg=; b=FtDUgsoElbzHcFVdw09IZE+u6i5wh
        0IrcwaWYpK2UO3FDSEnZ80mFcau1q5vNGH3L/RkFNFOI02HMY5fcqmEr4Kdua/ZB
        KB1VeW+NpFOSjsmNLoMt3/hDKp4T7j/BfeiQkqRhuIOSyta8rUhA3d1DIk55Uiqn
        yflNGAuKhPkJgjJF+PufG6fxahOHyxnc8OyDuy8UeGYNg529Pq//2GxgNyc9cFqJ
        8RQlYCRYSdBruftTcTUK4MnV3ss1eRa9cQhV0Sfe+iFPByyviPkxWGUXcgEkC+cz
        t7cwAaoPIBC8I4qB1y8WWTiFrSorlxq3AYES89TYkKE3qM0C18B6rbB2g==
X-ME-Sender: <xms:QYcHZGriXsPLzW62pimimwW4cvuw6fe--_4TWQxppDALbPOeC_-ZcA>
    <xme:QYcHZEq_f1z_HMoTFGc6Kmr7_Azpd7E_tB1sBIQiSTGiPxoGFUPJUgP24C-qmm9bq
    UQ27UjYg688F3SPX1A>
X-ME-Received: <xmr:QYcHZLNG2aNknJ0_i3-Mpu_NEPUtM7-szMv5tUYGYnsc2UdiwMo9j_kMHEr3AFBNImZ8L2d0mB1MgFFzdtveXH1eb1IptXvFVNxmr2E>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvddutddgudduudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhepfhgfhffvvefuffgjkfggtgesth
    dtofdttdertdenucfhrhhomhepufhtvghfrghnucftohgvshgthhcuoehshhhrseguvghv
    khgvrhhnvghlrdhioheqnecuggftrfgrthhtvghrnhepgeeiudelhefhkeffiefhteeuve
    dugfejgfeutdevfeeufeeggeegueehieekudeinecuffhomhgrihhnpehkvghrnhgvlhdr
    ohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hshhhrseguvghvkhgvrhhnvghlrdhioh
X-ME-Proxy: <xmx:QYcHZF5Y76SuwluK-VaqVnkYHz1D9VikefIEk52SJNBKTeAME40a_A>
    <xmx:QYcHZF7YOHpJD-rXOVxHneXC_rzxmDWHTPHEagVtHoZufJo5S5cbpA>
    <xmx:QYcHZFgwJ5iUdgdgfEZeah03xd24gewezztmiKZcu_l1m7nTHgnbCQ>
    <xmx:QYcHZAaw39t6qsYxraG8aShDaE7naVnEEnQeorv0HSwXYXT8FSU--g>
Feedback-ID: i84614614:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 7 Mar 2023 13:49:36 -0500 (EST)
References: <20230224044000.3084046-1-shr@devkernel.io>
 <20230225210854.25e93b1d94666aa13c269104@linux-foundation.org>
User-agent: mu4e 1.6.11; emacs 28.2.50
From:   Stefan Roesch <shr@devkernel.io>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     kernel-team@fb.com, linux-mm@kvack.org, riel@surriel.com,
        mhocko@suse.com, david@redhat.com, linux-kselftest@vger.kernel.org,
        linux-doc@vger.kernel.org, hannes@cmpxchg.org
Subject: Re: [PATCH v3 0/3] mm: process/cgroup ksm support
Date:   Tue, 07 Mar 2023 10:48:12 -0800
In-reply-to: <20230225210854.25e93b1d94666aa13c269104@linux-foundation.org>
Message-ID: <qvqwsfeggzwl.fsf@dev0134.prn3.facebook.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


Andrew Morton <akpm@linux-foundation.org> writes:

> On Thu, 23 Feb 2023 20:39:57 -0800 Stefan Roesch <shr@devkernel.io> wrote:
>
>> So far KSM can only be enabled by calling madvise for memory regions. To
>> be able to use KSM for more workloads, KSM needs to have the ability to be
>> enabled / disabled at the process / cgroup level.
>
> I'll toss this in for integration and testing, but I'd like to see
> reviewer input before proceeding further.
>
> Please plan on adding suitable user-facing documentation?  Presumably a
> patch for the prctl manpage?

The doc patch has been posted:
https://lore.kernel.org/linux-man/20230227220206.436662-1-shr@devkernel.io/
