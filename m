Return-Path: <linux-kselftest+bounces-35254-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3345CADE552
	for <lists+linux-kselftest@lfdr.de>; Wed, 18 Jun 2025 10:17:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 88F10189CC39
	for <lists+linux-kselftest@lfdr.de>; Wed, 18 Jun 2025 08:17:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4918198A2F;
	Wed, 18 Jun 2025 08:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YJV5bmib"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E276135963
	for <linux-kselftest@vger.kernel.org>; Wed, 18 Jun 2025 08:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750234618; cv=none; b=Yikpy0yBTuM+cTfj6t4Q5FudiolFeNTVes9TLZGStTue+qJFYfQVzpAY/LTA9Hl8dlS5eIb08E1YlROHWrIl55+16j9m9dGk6E+ll1FWdMEqckETaytRyudrUxoWFm1sivJ9hwLyONRjhk/L61oATzmiPaK8m18RJOwjLfJfbTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750234618; c=relaxed/simple;
	bh=aZ92ZJUmOfSxjsRRlPzLLG0jfFkv+ejFVU3IiW9X12w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CS/DeHnwTFiPGyIOKbOG2/Y8Wd4/aYbAuZWBRC9bRxOlUsPdUnFYP48p2onsFqDvjOV/hv6HC6ojq186fDmPhAlVOypmdbv/lkmI3n+OJiawMnbJR7ZfjmN2xRAtcXUmlOgOFfr8WInX8Cg5HamRN+mMfsjnFXtvafo/RcNpqas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YJV5bmib; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-ade4679fba7so1205894466b.2
        for <linux-kselftest@vger.kernel.org>; Wed, 18 Jun 2025 01:16:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750234615; x=1750839415; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-transfer-encoding
         :content-disposition:mime-version:references:reply-to:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=X0PvLDPGdJPK3jvIcIDdlHXE/E86yII7wEt38xaiYTI=;
        b=YJV5bmibxbo8dWCglap8RHCBKfQP904DpYz4QexqnPpqTl4RQPqQYSwAWxaLhJtnL7
         YkeH37F/++/awiminG/WZ+VH4CWC0lBNBjlqxyNkqDS1sIUaAfGQuLXuRyvcsfCfWaXM
         wZ9tHPd7T5FCJUYnPhe+LwS79uqTwFuXXoyGC+UB7ybUpH0Fee6F9raM7MeiWSte05/W
         83M5yaBJuboyfrGstvWGg3wHNjAJ42QVGXB8tJmb3+gtHQjeTWX1Lpp7N0q/4S7rIC+8
         +PcP1dkv6uk2BTfnddzQX9QSw6pPk5gGm5CCz+/Fh5IiQqMo7fGk0P4ih2+POolxLNZk
         g+7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750234615; x=1750839415;
        h=user-agent:in-reply-to:content-transfer-encoding
         :content-disposition:mime-version:references:reply-to:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X0PvLDPGdJPK3jvIcIDdlHXE/E86yII7wEt38xaiYTI=;
        b=Pp4sFYascnWdkVLjhjNBqP6Vy4qwCz5kSAEBBhsKp65B+E8u7NgmFh7zN/W0q1CbeU
         mbxz0XHvDmvsMIIcza+fzKny22iADjn66D6ujzrMLFltTRgDIgkoMCtlJ0HJ9Gv01SBo
         NHdgQwRj/jUEQs4Xw7oNiPLDrYnUaHfes8tLxZOOSZNZSz2fxMYEiI+e2VNMaIH4WmQM
         ar1w/Kzq1JdGNe2SSHBcWulc29O0tlaNSEzVB528VWUp0kfnN5DEBI8PLHQwF1EWa+z7
         JlC4rSMnkE4odkGnHk6AKAF3WW0bZ8Ut6f+uMV2i3m6Ni5dZI81H48f/qTh4rkBkqDmk
         GCHQ==
X-Forwarded-Encrypted: i=1; AJvYcCUotD4eEi4kqNuZ6LSN/ee2H1oW3+7ztGZaF5J05RWInjfOX0yU6q701pzxNofT4MhkVbOj3VlUYeIBaBdhSKM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxnI8pRTi0LGyuH9thTcvMkRiClE0yYW4lgPZMLYhNrB6fHnvy0
	DVxPT+mc2TTx/rT/UeenEhTRr48Tc2JuNajiJkg0KiXZncxvJ0Fi41zm
X-Gm-Gg: ASbGncvPJenlrjSlHnpZ6v+JvK/WajNL0s6evotBta/SWM6/HKIcLDdQidcBhjTMxBv
	gvjrXb3uJj6JH2z8xbMM6t21Mx89VOqz4D2/OCF3awrqimtwmR0YmUVE/eFkBc4SPBN5efAWlFs
	UJ0TwpeXqqTNjXcVt7Kcts9Se34slFa4AcL67VlHO6fVqvgPc8t81zuI73lB40a8/ftRGZodu4y
	re+A6brjuuszZHD0cF4n5a5mOqquN9LfYBcJ34w54piz8hxQP0GioMceqbT9/m/yNFPjfAH7uOX
	b4N9uHxGcZptlLg0rSrtfMGMyYF25/XXAKj3JqDt0/Pu9vumpB82e4Dr00EI6A==
X-Google-Smtp-Source: AGHT+IEUOHKbd4t5kkBgUO1f7y28+BYtU1+Mgg1gVkRRpVIVeeRhDodh28xngZg7wZNSsJL7sAjJ5A==
X-Received: by 2002:a17:907:6e94:b0:ad2:46b2:78b2 with SMTP id a640c23a62f3a-adfad3aa4e8mr1645714866b.18.1750234614751;
        Wed, 18 Jun 2025 01:16:54 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae012888714sm161209066b.19.2025.06.18.01.16.54
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 18 Jun 2025 01:16:54 -0700 (PDT)
Date: Wed, 18 Jun 2025 08:16:53 +0000
From: Wei Yang <richard.weiyang@gmail.com>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas.weissschuh@linutronix.de>
Cc: Wei Yang <richard.weiyang@gmail.com>, shuah@kernel.org, kees@kernel.org,
	luto@amacapital.net, wad@chromium.org,
	linux-kselftest@vger.kernel.org, usama.anjum@collabora.com,
	skhan@linuxfoundation.org
Subject: Re: [PATCH 3/3] selftests: harness: Add kselftest harness selftest
 with variant
Message-ID: <20250618081653.y5xbkoeaab324nof@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20250616122338.32678-1-richard.weiyang@gmail.com>
 <20250616122338.32678-4-richard.weiyang@gmail.com>
 <20250617093230-7c07d08b-5956-4a78-863c-f35cc300815c@linutronix.de>
 <20250617235748.pbw2mrpneol6gajb@master>
 <20250618074357-cb331853-aa30-43b1-8a2a-e193fd98eb90@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250618074357-cb331853-aa30-43b1-8a2a-e193fd98eb90@linutronix.de>
User-Agent: NeoMutt/20170113 (1.7.2)

On Wed, Jun 18, 2025 at 07:47:19AM +0200, Thomas Weißschuh wrote:
>On Tue, Jun 17, 2025 at 11:57:48PM +0000, Wei Yang wrote:
>> On Tue, Jun 17, 2025 at 09:35:12AM +0200, Thomas Weißschuh wrote:
>
><snip>
>
>> >> +FIXTURE_SETUP(fixture_variant) {
>> >> +	TH_LOG("setup %d", variant->value);
>> >> +	self->testpid = getpid();
>> >> +}
>> >> +
>> >> +FIXTURE_TEARDOWN(fixture_variant) {
>> >> +	TH_LOG("teardown same-process=%d", self->testpid == getpid());
>> >> +}
>> >> +
>> >> +TEST_F(fixture_variant, pass) {
>> >> +	TH_LOG("before");
>> >> +	ASSERT_EQ(0, 0);
>> >
>> >Please log the variant value from the test itself and the teardown function.
>> >Also I don't think we need the pid logging and before/after/ASSERT in this test
>> >also, it is already validated in the other ones.
>> >
>> 
>> Sure, per my understanding, is this what you prefer?
>> 
>> 
>> FIXTURE_SETUP(fixture_variant) {
>> 	TH_LOG("setup %d", variant->value);
>> }
>> 
>> FIXTURE_TEARDOWN(fixture_variant) {
>> 	TH_LOG("teardown %d", variant->value);
>> }
>> 
>> TEST_F(fixture_variant, pass) {
>> 	TH_LOG("before %d", variant->value);
>> 	ASSERT_EQ(0, 0);
>> 	TH_LOG("after %d", variant->value);
>
>I would drop the three lines above and just do:
>
>TH_LOG("test function %d", variant->value);
>

Got it, thanks.

>Also please note that my earlier comment about the patch prefix
>"selftests: harness:" should only apply to the patches really related to the
>harness.
>Not patch 2, which should use "selftests: kselftest:".
>

Hmm.. for patch 2, Muhammad mentioned it not comply with TAP guideline.

So I plan to drop it in next version.

>> }
>> 
>> 
>> -- 
>> Wei Yang
>> Help you, Help me

-- 
Wei Yang
Help you, Help me

