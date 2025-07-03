Return-Path: <linux-kselftest+bounces-36437-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 730BFAF7710
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Jul 2025 16:19:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C753C3B6173
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Jul 2025 14:17:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 733A22E62C4;
	Thu,  3 Jul 2025 14:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="OGq5NsqU";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="St5ttD5l"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A43091AF0B4
	for <linux-kselftest@vger.kernel.org>; Thu,  3 Jul 2025 14:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751552282; cv=none; b=r6pj+XaGQXVXKfgOsVQW78rg2ffvIpWRIjxYwHzjRV1r8eRSFVzd4IG3nAYShQCfCdbtB/OE4CgXjhMVhjhruWI5VekzklxMssjaSRKdWsQ9p/gm1JeBic1kGOemSm1rY8DimbuZoGW9Bc21NKeFwhTO7QmjET3PnBirGwppWOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751552282; c=relaxed/simple;
	bh=PzJce5OoLWe5IraYqyecvTvi9P6R84EsEG5rOMs/IYs=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=NQs7gDMRL0xTVmz0+QltvWEXALIcKtIdVN3/wV9fI5j+wuHtHMNsp9p9E0raUMeF4qRnGVz18hNvrzdlZRjvpezUg2sjQfFw+KyxhPpBjwV/Qh7jdjMMZqaNeblHgAXE5SUdIuSKRan+TnUW92D2maNJUDTV3fuuYUQ/XM+KypY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=OGq5NsqU; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=St5ttD5l; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 82284140025B;
	Thu,  3 Jul 2025 10:17:58 -0400 (EDT)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-05.internal (MEProxy); Thu, 03 Jul 2025 10:17:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1751552278;
	 x=1751638678; bh=ELCjAt/SQjWiLxFaoE+JA5BBE4/Ck0GCWWDaqcUeh0I=; b=
	OGq5NsqUjbvwQUp3jXfP/VhUv9L0Zv8mVx1gfFsb97HuCKdrzGEi7mOvANqRkSuh
	By1v5kBRSYwr0PcgyvckLfBc4VnEw703oCRlTiz7S1PRRxZtU7n8nkV2JyfE68bm
	gD/Jmbvu87r5afVjk79b4f11loDBAaSgGdhn5TE/BnNiC3xwfyMfXkibijQdQKfH
	evBv6kaRJM9XSuJCMz7zo7Ne1EHzuEP5xDFOySQMovFWorp+HRLXSnjuYRYCITr9
	796wyifi4KTy/Mqbq23gpKdvtjJGdKcC9GlzknejT13M40QjkNBY2xeSZmTkFNwF
	5CiA05Up1XH9nYqJXKGLDw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1751552278; x=
	1751638678; bh=ELCjAt/SQjWiLxFaoE+JA5BBE4/Ck0GCWWDaqcUeh0I=; b=S
	t5ttD5lG6oy9bmYeAuYxR6XzfgrgGFNiH8TXGuRwa74uqR45wk+nBWP1FWocfEVe
	smdNtWXfeaveUDf0fZkn3sFpQAYGsIZtb5jV584YjHKx6kOTvBZhkwepkAVMWBGY
	+Sa+UKZZTBDEuz0klklpwR9GptmVI6Y6YzcaSIGTxAmnVZdm92S3zCtuI8Q7V6xf
	9LWvYIuE3Yr+7KqzI+xdTra4ncDNC9go7PgTpgQJpjdStI79YcL5ebL87qZCrqKu
	NH0bK8+WYxWhcAfHGnpQ7cL4l6iG0XyAq7BUxzb/l2msB58eU9aEMmaT7cUbzeir
	dKLh46wFYwNBlKDrC6IPQ==
X-ME-Sender: <xms:FZFmaIVBDFSS6YWEvqAIES-J0lUknGFuVds09p-xXbhMMO0h_g4VfQ>
    <xme:FZFmaMl_p9Avmch4AV-4yNVPmYh1PNqBc_dRs54rpa-ZwKG4GH9ecFco8vPTdJyM-
    bCvGsfyXwFWxavkcq0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddvtdeglecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefoggffhffvvefkjghfufgtgfesthejredtredttdenucfhrhhomhepfdetrhhnugcu
    uegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtthgvrh
    hnpefhtdfhvddtfeehudekteeggffghfejgeegteefgffgvedugeduveelvdekhfdvieen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhnug
    esrghrnhgusgdruggvpdhnsggprhgtphhtthhopeekpdhmohguvgepshhmthhpohhuthdp
    rhgtphhtthhopegrnhguvghrshdrrhhogigvlhhlsehlihhnrghrohdrohhrghdprhgtph
    htthhopegurghnrdgtrghrphgvnhhtvghrsehlihhnrghrohdrohhrghdprhgtphhtthho
    pehnrghrvghshhdrkhgrmhgsohhjuheslhhinhgrrhhordhorhhgpdhrtghpthhtoheplh
    htpheslhhishhtshdrlhhinhhugidrihhtpdhrtghpthhtoheplhhifigrnhhgsehrvggu
    hhgrthdrtghomhdprhgtphhtthhopegthhhruhgsihhssehsuhhsvgdrtgiipdhrtghpth
    htohepphhvohhrvghlsehsuhhsvgdrtgiipdhrtghpthhtoheplhhinhhugidqkhhsvghl
    fhhtvghsthesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:FZFmaMZWzGb93E1bKyalCazjYS2yec3eP_BRZurVKVcb62OySSfSaQ>
    <xmx:FZFmaHVCYlJXuQElBfP6NHHIfhaciteV393AR-Vh6cZDAQTf2aV6xw>
    <xmx:FZFmaCkuq1FHhz8xDE8owbJh4lTIExVs7DtWA1EuPZTg6NQI6ugK_w>
    <xmx:FZFmaMcZDi4kKmt5d37reVBXuw8zO7K6SjTiwRF5CE_GGKOi5WD3_A>
    <xmx:FpFmaNLnn1XFE78JkCVpoE-Gd3bQ5ywX2lbmN9m_phGFjuEjcGHK9zfw>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id CC865700065; Thu,  3 Jul 2025 10:17:57 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: Tb53dd688bc639d41
Date: Thu, 03 Jul 2025 16:17:37 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Naresh Kamboju" <naresh.kamboju@linaro.org>,
 "LTP List" <ltp@lists.linux.it>,
 "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>
Cc: "Anders Roxell" <anders.roxell@linaro.org>,
 "Dan Carpenter" <dan.carpenter@linaro.org>, chrubis <chrubis@suse.cz>,
 "Li Wang" <liwang@redhat.com>, "Petr Vorel" <pvorel@suse.cz>
Message-Id: <c9ba86f6-dea8-47bd-88e1-edf49e4bf9fd@app.fastmail.com>
In-Reply-To: 
 <CA+G9fYvD1A12WE36NjELe5cD-LbPsmwJnH5aUAcufBZ7ndt2Hw@mail.gmail.com>
References: 
 <CA+G9fYvD1A12WE36NjELe5cD-LbPsmwJnH5aUAcufBZ7ndt2Hw@mail.gmail.com>
Subject: Re: LTP syscalls mseal02 and shmctl03 fails on compat mode 64-bit kernel on
 32-bit rootfs
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Thu, Jul 3, 2025, at 15:47, Naresh Kamboju wrote:
> The LTP syscalls mseal02 and shmctl03 failed only with compat mode testing
> with 64-bit kernel with 32-bit rootfs combination.
>
> Would it be possible to detect compat mode test environment and handle the test
> expectation in LTP test development ?

I think we should either make the kernel behave the same way in
both environments, or accept either behavior as correct in LTP.
NVAL (22)
> mseal02.c:45: TPASS: mseal(0xf7a8e001, 4096, 0) : EINVAL (22)
> mseal02.c:45: TFAIL: mseal(0xf7a8e000, 4294963201, 0) expected EINVAL:
> ENOMEM (12)

This is "length=ULONG_MAX-page_size+2", which overflows on 32-bit
but not on 64-bit.

How about this?

--- a/mm/mseal.c
+++ b/mm/mseal.c
@@ -234,6 +234,9 @@ int do_mseal(unsigned long start, size_t len_in, unsigned long flags)
        if (end < start)
                return -EINVAL;
 
+       if (end > TASK_SIZE)
+               return -EINVAL;
+
        if (end == start)
                return 0;
 
Since TASK_SIZE is smaller for 32-bit tasks, it would detect
the overflow in the same way.

> tst_test.c:1774: TINFO: Overall timeout per run is 0h 21m 36s
> shmctl03.c:31: TPASS: shmmin = 1
> shmctl03.c:33: TFAIL: /proc/sys/kernel/shmmax != 2147483647 got 4294967295

I see this is being intentionally truncated to INT_MAX:

static int copy_compat_shminfo_to_user(void __user *buf, struct shminfo64 *in,
                                        int version)
{
        if (in->shmmax > INT_MAX)
                in->shmmax = INT_MAX;
        ...
}

> shmctl03.c:35: TFAIL: /proc/sys/kernel/shmall != 4278190079 got 4294967295

Here the value from /proc is defined in the kernel as
"#define SHMALL (ULONG_MAX - (1UL << 24))"

On a 64-bit machine this is 0xfffffffffeffffff.

However the 32-bit ltp tst_assert_ulong() truncates it
to 0xfeffffff, which happens to be the exact same value
that it would see on a 32-bit kernel.

The second one is 0xffffffff, and I don't know how that gets
computed, as it is derived from the same number in
info.shmall = in->shmall;

Are you running this inside of a container that its own ipc
namespace?

     Arnd

