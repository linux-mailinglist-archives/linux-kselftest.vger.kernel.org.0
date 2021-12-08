Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06E2146D59F
	for <lists+linux-kselftest@lfdr.de>; Wed,  8 Dec 2021 15:27:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235101AbhLHOax (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 8 Dec 2021 09:30:53 -0500
Received: from wout2-smtp.messagingengine.com ([64.147.123.25]:48463 "EHLO
        wout2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235099AbhLHOax (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 8 Dec 2021 09:30:53 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id D29D03201D40;
        Wed,  8 Dec 2021 09:27:20 -0500 (EST)
Received: from imap41 ([10.202.2.91])
  by compute3.internal (MEProxy); Wed, 08 Dec 2021 09:27:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
         h=mime-version:message-id:in-reply-to:references:date:from:to
        :subject:content-type; s=fm3; bh=6ORq/SgBvFOuBcZ0HewAIDGw0gFBrj4
        g3+zfdCb8Sac=; b=YTVu1fTgsRJ/Dv2EyO96L0qUzP2tRqaxQad7BsXeGw7yQTx
        BPI7rqXsFX6emq3SaavbslkAy/YFHzDRPXQ3otgkZ6TCKv5px573mLuqySvELr0H
        j7ADOwMq5i2BCJi3xqBgv4raBZDBneGx+lvF1luAsWb+ZLpZx18t415xCPfI4UZk
        qmpx5rGZRw3yQ9JnDwIlqqmpMbkOCdgtGE69z8zv0gMWPL5KE6KxtvS6z+pmEGK0
        J1zp+kCZp3pLhhuIu/CvGeGoqn0RQFx/5GiNXOtqqgdion+xNIQXPszhDyTG55MJ
        2+O5Xc4KXruxBBe5YRrFscrQEIb3AGTNcJQNKsA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=6ORq/S
        gBvFOuBcZ0HewAIDGw0gFBrj4g3+zfdCb8Sac=; b=L+83eAt01a0hjes9LgK3v7
        y3Lj528fms5d5Cvwvl1U6pT6Cuzxtw91aUxvhEYvqU+WjODx418HXVw++ePALxGk
        siR1rmXtgivRFoWkPCY7VAL8eagWfxTEGtGM91920CRw0JAp3Ess11uR3NFj1t/+
        j6+PeipnLQuiQbXsGUMjfjfCEMj6QjU4gGxTzAkNb8JdCm+EsI69wqGS6pEjdfnk
        8krl/ysQktnWO6IYcktAAGWezIUDoZsttWPYC+IRtX7++tWJxDiR9vq3A+nBrsKZ
        L6x4S6dcaSNP4DNd+TS7b+WZK4pQ1OYGidEw7aytDeQh07oR8E52f6NjRTnCYi3g
        ==
X-ME-Sender: <xms:x8CwYTCyxJANISDz4PNMBBdLPEmYsUH0SUGN2qPF1bD07AUpVJ8eqA>
    <xme:x8CwYZgaDYibOY8Azao8t3DA1PRx0qd4C5AM9DLsuoF0Hhq1f9MfWvzOAul2i-mUX
    TOQfuP0urdx8ncFwlA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvuddrjeekgdeifecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvufgtsehttdertderredtnecuhfhrohhmpedfvfgrkhgr
    shhhihcuufgrkhgrmhhothhofdcuoehoqdhtrghkrghshhhisehsrghkrghmohgttghhih
    drjhhpqeenucggtffrrghtthgvrhhnpeekkefgtdeigffgheefleduveefvdevgeehffet
    jefghfejheffudduieevvedvieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehoqdhtrghkrghshhhisehsrghkrghmohgttghhihdrjhhp
X-ME-Proxy: <xmx:yMCwYek6-f5MGzgVldUwNEW29vhVBPajAN-MryEe9tTkqopbRF-5wQ>
    <xmx:yMCwYVzXuhxbpXr_xdT9eoaKufMe5muUA4US5PdHfTlZ-du1XGqXgg>
    <xmx:yMCwYYQeHqZx03PfGtaNfHa1a0HC8EoFz0oQgpqveA-QOjozSV6kWg>
    <xmx:yMCwYeciwrdFoLVmChwHbik8GMmVLKwOPWryS7tVvkWEtZgZ-t0Rcg>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id E70EC3C031B; Wed,  8 Dec 2021 09:27:19 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.5.0-alpha0-4492-g121c2470aa-fm-20211206.001-g121c2470
Mime-Version: 1.0
Message-Id: <85e0af0d-6f7e-47b0-b09c-c6006ee50662@www.fastmail.com>
In-Reply-To: <Ya9uvPx37AcOdwLK@sirena.org.uk>
References: <20211206160305.194011-1-broonie@kernel.org>
 <Ya7TAHdMe9i41bsC@workstation> <Ya9uvPx37AcOdwLK@sirena.org.uk>
Date:   Wed, 08 Dec 2021 23:26:59 +0900
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

On Tue, Dec 7, 2021, at 23:25, Mark Brown wrote:
> On Tue, Dec 07, 2021 at 12:20:32PM +0900, Takashi Sakamoto wrote:
>> On Mon, Dec 06, 2021 at 04:03:05PM +0000, Mark Brown wrote:
>
>> I think it safer to take care of volatile attribute when comparing read
>> value to written value. I'm glad if you review below patch.
>
> Yes, that's a good spot, it was an oversight to not take care of
> volatile controls - I'll roll that in if I send a new version or
> I guess Takashi could apply on top of my v2?  If people are mostly happy
> and at Jaroslav is also preparing patches on top of this it might make
> sense to get it into git sooner.
>
> Reviewed-by: Mark Brown <broonie@kernel.org>

Feel free to append it for your new version with or without my sign-off.
If keeping it, I could review your respun one by receiving according to To
or Cc.

>> As another topic, the runtime of alsa-lib application largely differs
>> between process user due to the result of parsing text files for
>> configuration space. I can easily imagine that developers unfamiliar to
>> alsa-lib carelessly adds invalid or inadequate configurations to files
>> under target path of alsa-lib configuration space, and they are puzzled
>> since they are unaware of the fact that the kselftest is affected by
>> userspace stuffs for the runtime.
>
>> If we respect the basic theory of test (idempotence), we can use ioctl(2)
>> with requests for ALSA control interface since it's not so complicated
>> (at least it is easier than ALSA PCM interface). The purpose of
>> kselftest is to test kernel stuffs, not to test userspace stuffs
>> including alsa-lib implementation and variety of plugins.
>
> Right, I was originally thinking of implementing this in terms of
> tinyalsa which is much more direct (though I was amused to see that's
> gained userspace plugins at some point!) partly for this reason but the
> lack of widespread packaging for it was a bit of a blocker and it didn't
> feel like a great idea to essentially do yet another userspace ALSA
> library even if as you say it can be pretty trivial.  Jaroslav's
> suggestion of using a custom configuration to override the default seems
> like it addresses everything though.
>
> I do think there's an advantage for test comprehensibility in having the
> test written in terms of similar APIs to a normal userspace application
> - it makes it easier to relate what the test is doing to normal usage
> which is helpful when trying to understand what the test is trying to
> tell you.

In my opinion, test is merely test. It's not a sample program.

What important is what is tested. and how to assist developers if failed.
If more suitable for the direction, we should do it, even if using raw ioctl
in the case.

For your information, `check_event()` in `test/user-ctl-element-set.c`, my
rough implementation of test for event triggered by tlv operation, might
be helpful to you or start point t to discuss about event check.


Regards

Takashi Sakamoto
