Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6406346D5B2
	for <lists+linux-kselftest@lfdr.de>; Wed,  8 Dec 2021 15:31:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235127AbhLHOfY (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 8 Dec 2021 09:35:24 -0500
Received: from wout3-smtp.messagingengine.com ([64.147.123.19]:42571 "EHLO
        wout3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235128AbhLHOfX (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 8 Dec 2021 09:35:23 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id 0ECB33200F88;
        Wed,  8 Dec 2021 09:31:50 -0500 (EST)
Received: from imap41 ([10.202.2.91])
  by compute3.internal (MEProxy); Wed, 08 Dec 2021 09:31:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
         h=mime-version:message-id:in-reply-to:references:date:from:to
        :subject:content-type; s=fm3; bh=lzlBfJiFFNAQazeIS9L2mhLJdV9WgFB
        ASUdK1hLfY4E=; b=ECmc72pYxDrcE0TefEHw8s30000JukcITpZdhFdGogCHEqq
        w+Z2vYA1Yyv+Yjk3duccpfQQki2FN1+MuTs1gnV6MBFTgtFo8Iw472U2CcY8fEJb
        wY30wIQ6dPW9V67gF5SVVkodxJ2CR/WFdCXAq6BoWyHKeQ7wYsXIcSs1bv2WyL5b
        0hTchI1BlYwH7rDKrUYEMANu74/Wzo3QZTMeyv/APq0i/cqd7APr0z6/eCZ9Dd4h
        tDBkiFPAERzVkEQYCydoatc1OEeAnBs8VuLDo+xAN4sAz7wgntCryFxb3mawd2d+
        +uruWfUgJRJ3Ysz1Tbzt846n7BYrd9YSiDNLZ6g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=lzlBfJ
        iFFNAQazeIS9L2mhLJdV9WgFBASUdK1hLfY4E=; b=ACAy89unfsgG6DqVHL2ViZ
        64eZflvH/5YCAm/jYso9dxToMzLMbsvKrqw+ckIuDnyp+GJcu4pviCMJdko55EuL
        ixIEtRz+fCLgSS6Cw34BWFYkrVJY4e4fS5OGFjZtmhl5bwkmb+g4W6xlygobfJx2
        aH1gCU/+tIEjQRLlQ5g83MZrFmum5s8YVFtexA6em7AHUBvVncDJrKpPK7ApdhkS
        poIKz4sD1/CJvPsKSOTVI8/oeIiE79jgpCHgxLlpo6Rm3E5v4GzjqlgcZXaltVi5
        Ul5TFuAepCiY9ha/xr9OL4hya1B3uYvaRswRBavY1VyHVNyGhUIQlLXdzxtXysaw
        ==
X-ME-Sender: <xms:1cGwYQveMe7mkeZ88Uj6abvv6428oTOo8W_2S8ZkQN6Ld7FWHKkMeA>
    <xme:1cGwYdeI07yoGk-oaN38ugeW0V8ymts5eCG2pSLbufj-me01u_7s6GQ-ttZuAf9eo
    cwu07IXStRRhJVmGMo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvuddrjeekgdeigecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvufgtsehttdertderredtnecuhfhrohhmpedfvfgrkhgr
    shhhihcuufgrkhgrmhhothhofdcuoehoqdhtrghkrghshhhisehsrghkrghmohgttghhih
    drjhhpqeenucggtffrrghtthgvrhhnpeehvdekvdfgiedtteejvedutddutdfgtefgvdei
    vdetffffffeffeeihfdvveehleenucffohhmrghinhepghhithhhuhgsrdgtohhmnecuve
    hluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepohdqthgrkhgr
    shhhihesshgrkhgrmhhotggthhhirdhjph
X-ME-Proxy: <xmx:1cGwYbzFlgIQb4JogckypUoJApRRa0dOX975kAONGjYvNnAd6qlWPg>
    <xmx:1cGwYTOFDCZchpgnvqvW0QmMfstBDwZ1OV6gzzdAHRjdSv9zh__g4Q>
    <xmx:1cGwYQ9NSLRxQt_FsqyVpPLcaKJyGUvO--JLkF_yqJB6Mc3vshVeSA>
    <xmx:1sGwYfZsGPHI8otYWfgnXTSU5vtId3eTb1QxGjTEn8zDaIJkB2DXVQ>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 538B03C031B; Wed,  8 Dec 2021 09:31:49 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.5.0-alpha0-4492-g121c2470aa-fm-20211206.001-g121c2470
Mime-Version: 1.0
Message-Id: <eef54329-7ce0-45f9-95ce-3db985cabd70@www.fastmail.com>
In-Reply-To: <85e0af0d-6f7e-47b0-b09c-c6006ee50662@www.fastmail.com>
References: <20211206160305.194011-1-broonie@kernel.org>
 <Ya7TAHdMe9i41bsC@workstation> <Ya9uvPx37AcOdwLK@sirena.org.uk>
 <85e0af0d-6f7e-47b0-b09c-c6006ee50662@www.fastmail.com>
Date:   Wed, 08 Dec 2021 23:31:31 +0900
From:   "Takashi Sakamoto" <o-takashi@sakamocchi.jp>
To:     "Mark Brown" <broonie@kernel.org>, "Takashi Iwai" <tiwai@suse.de>,
        "Shuah Khan" <shuah@kernel.org>,
        "Jaroslav Kysela" <perex@perex.cz>, alsa-devel@alsa-project.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v2] kselftest: alsa: Add simplistic test for ALSA mixer controls
 kselftest
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Dec 8, 2021, at 23:26, Takashi Sakamoto wrote:
> For your information, `check_event()` in `test/user-ctl-element-set.c`, my
> rough implementation of test for event triggered by tlv operation, might
> be helpful to you or start point t to discuss about event check.

Oops. It's in source code of alsa-lib.

 * https://github.com/alsa-project/alsa-lib/blob/master/test/user-ctl-element-set.c#L389


Regards

Takashi Sakamoto
