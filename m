Return-Path: <linux-kselftest+bounces-5004-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A74085B393
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 Feb 2024 08:04:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D2521C218FE
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 Feb 2024 07:04:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CA8C5A4E0;
	Tue, 20 Feb 2024 07:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="GtDfhOPD";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gSwCnKk+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B2275A4CE;
	Tue, 20 Feb 2024 07:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708412544; cv=none; b=TZqkiG1kgVoU9V4/ifolN5qrUe1up4cra6p4QPCCi9Q1taHr0caNZ6zKhRtLBoGEVq1w6TZxzjjwLxKfAkeWOZ2QG0ekYgjd2JC4kghOs30pKCtV5iDaCjY2zT6paD69+SuK5JcYutNEf4OoxFZX82NiIqy0fpkFf2bNWRJcZCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708412544; c=relaxed/simple;
	bh=CGtGsFU2wXDy0isZRRb/KkEss2u7yvyia8mRoaJgn9M=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=mLSQ5lEfWMyBZeD2jenHfDM7vdo1whKmNsywm5KQnPH2JaBt0mIBIwN2ru+GnPnEOia7f158cGsnq3dnhNk8s5dka0mZClgLf2dYZbF45kz3yvdcUQFV3zePqQQwvNN46kSbh4R9quI5SrbNgPiX/Ku1yv/q1csP802A8LRpQd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=GtDfhOPD; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gSwCnKk+; arc=none smtp.client-ip=64.147.123.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.west.internal (Postfix) with ESMTP id 63B3F3200035;
	Tue, 20 Feb 2024 02:02:20 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Tue, 20 Feb 2024 02:02:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1708412539; x=1708498939; bh=mbO/zaQXvf
	9m5LFtRthBDAWNdbFRPWSTknyOW7f6+rE=; b=GtDfhOPD6uD6H0sAelQ0ZtNx0/
	NRlgJrzEmUmJCCkqZ194HFHqwEd/CELc5UGj+Tg5+5PO7VK5ixGcdABOPCHDJYAN
	77f/cqTaGV3W0t/8BioPGkOP1E5Qkvn8uzW1csJAePyaq9FEzT5Dc/4AbFwik39m
	7lgmvfhnDvYNEGR3zV7XvK6/4+iS5SJsRRtTJbytokoI7synhmim6yy1EykFOg+a
	nkI03WRzGJDc3nDhkQ333t+aLEMTM6//bhgESNsmZYFfr9O+Yh5OY6tsxqBwcxXP
	G+PpDTZAFDiBYVrDW5hnd84dLiVe/TTWyeilwsnbZTlAP8mQVZ0p2r4E73eg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1708412539; x=1708498939; bh=mbO/zaQXvf9m5LFtRthBDAWNdbFR
	PWSTknyOW7f6+rE=; b=gSwCnKk+gBcaLaHDSiSJIw6GSXpisMD4GR/Yu6hpEl6k
	HkMdYKrkkxtyBLK0rDY6JBtDp8oPLg89fLVG4lZA+6nEUUXScqU+CF7cSIGMDdEj
	wRQtyHA0ndB5uCukNgV0463rARFFwlwQtZ7gMTfbnZ8iAL7nx/FJqY0XPic9SwR2
	60KsF//vVH3oRGkzhZM0Js+/NL80t96taprp/uuLdhpRN35uWOyNVA5RckWw7fUy
	g5pdAY3dNjWCRq+c/O3L/VXxObGeZg2tMMyo+EMhD//+fSq2vBpN7clH/cVXxB1s
	yC65LBtOhMOSG0tlm5IobUETiqFtDQlHmP5QwFuSFw==
X-ME-Sender: <xms:e07UZYBm2hAHCJXsZzNHYoM9w_MqFrjQeYAAE3f-399uYwTeXJn9ng>
    <xme:e07UZajACisGNQ92u2SHlsHMFHYqwH6lj3Of1f8R6re0jpa1E0CGmRUGL2WbGnw9h
    8uE-n4tkmH0M2XRi3U>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdelgddutddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:e07UZblP6z4GUSL-aC_vKHC6wX4ABG6e8bUzBxO0EWnRsN_yJ-pxaw>
    <xmx:e07UZeyTQGWHfj_t69Iu2lnA-jvGG0F9hIIzb8OjCnG21dlM9fWMlA>
    <xmx:e07UZdTHOGMBgWVpilHMFgaMrsqKonYDKq_j9UPavaZ2vPfXvdU3Ug>
    <xmx:e07UZTCp_m36J6zr-xHOlLigMehtSQIiqAs_dknUnbrxVoSIyV-t1w>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id A0B7EB6008D; Tue, 20 Feb 2024 02:02:19 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-153-g7e3bb84806-fm-20240215.007-g7e3bb848
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <830b0788-35e6-4cbd-b195-254d434ba0cd@app.fastmail.com>
In-Reply-To: <20240219223833.95710-18-zfigura@codeweavers.com>
References: <20240219223833.95710-1-zfigura@codeweavers.com>
 <20240219223833.95710-18-zfigura@codeweavers.com>
Date: Tue, 20 Feb 2024 08:01:59 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Elizabeth Figura" <zfigura@codeweavers.com>,
 "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
 "Jonathan Corbet" <corbet@lwn.net>, shuah <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
 wine-devel@winehq.org,
 =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>,
 "Wolfram Sang" <wsa@kernel.org>, "Arkadiusz Hiler" <ahiler@codeweavers.com>,
 "Peter Zijlstra" <peterz@infradead.org>, "Andy Lutomirski" <luto@kernel.org>,
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
 "Randy Dunlap" <rdunlap@infradead.org>
Subject: Re: [PATCH v2 17/31] ntsync: Allow waits to use the REALTIME clock.
Content-Type: text/plain

On Mon, Feb 19, 2024, at 23:38, Elizabeth Figura wrote:
> NtWaitForMultipleObjects() can receive a timeout in two forms, relative or
> absolute. Relative timeouts are unaffected by changes to the system time and do
> not count down while the system suspends; for absolute timeouts the opposite is
> true.
>
> In order to make the interface and implementation simpler, the ntsync driver
> only deals in absolute timeouts. However, we need to be able to emulate both
> behaviours apropos suspension and time adjustment, which is achieved by allowing
> either the MONOTONIC or REALTIME clock to be used.
>
> Signed-off-by: Elizabeth Figura <zfigura@codeweavers.com>

I understand that there is no practical problem in building
up the API one patch at a time in the initial merge, but
it still feels wrong to have an incompatible ABI change in
the middle of the series:

> @@ -35,6 +37,8 @@ struct ntsync_wait_args {
>  	__u32 owner;
>  	__u32 index;
>  	__u32 alert;
> +	__u32 flags;
> +	__u32 pad;
>  };

If this was patch to get merged at any later point, you'd have
to support both the shorter and the longer structure layout
with their distinct ioctl command codes.

If you do a v3 series, maybe just merge this patch into the
one that introduces the struct ntsync_wait_args. Overall,
you could probably have fewer but larger patches anyway
without harming the review process, but other than this
one that is not a problem.

       Arnd

