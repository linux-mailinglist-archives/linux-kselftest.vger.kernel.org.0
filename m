Return-Path: <linux-kselftest+bounces-19677-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 47FA799D9A1
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Oct 2024 00:07:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F2FD0283250
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Oct 2024 22:07:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C77121D173E;
	Mon, 14 Oct 2024 22:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SqWS0yis"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 482B813BC02;
	Mon, 14 Oct 2024 22:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728943638; cv=none; b=mPJNlY4SnVKuzxWcUz4rlmfmAOTFMEiNUdjYE0YCuX1QFsnxykIwcmC3BmosipDCsaT/L3jDSzhPBLSnS1Wl25gHhE0N0mVlIBzagTK/IWESThnOwi93w4oFpquMKR3DHLdsih+2rMjlZPJ+SeCEVzh87MYIClryHK4130kTaIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728943638; c=relaxed/simple;
	bh=BXoqDheXy+2BwaKLV2FiDxisztcZ2Mr3gf7y1y0b2KY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SLi48oCQSrVv6knRh2wPZOZpU34wA8BQ4g0S1uBjZQtNsEZSnLYdZsJQPyOUrgYZTHsR3VZ+qUn8pGwipn323eK+TZUTsmUAkb4oU0zY3w67KznF50SYAr2iCKiRrKl9qHRGJxI5s7OpFlrizQwtpoD1lxr4cVPmtIl1xYeeC10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SqWS0yis; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-2e2c6bc4840so3348757a91.2;
        Mon, 14 Oct 2024 15:07:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728943636; x=1729548436; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=i8w6ffEpFO7SbSBhrFi9OhNa1QYyGwUObySt3ab3Ei0=;
        b=SqWS0yis6JOBAhGq0V09lH4aqQ95YS0FHD49MBz8KPP/H7x8Zxtx9IkhzfoCS5LLRz
         x5tiW1K2DEqzMsKbMqLUkX/ZIGQ0+TS5JGsvD6CpFHfsN76FrqU5xNtFhdxkbzuhiVQT
         BjWeQH5IcAzx5mwG5M71nHbZJK2Cl55zeKvtTX+o2v7Zx5FIlgjfWbyKVUw81xgMi3DO
         t2cMj5huQzwdg3o18D4oPuaUPC1dN9XNkcF3PP++WYAtzl3ZSA+vIvW322VgQSKlqyWu
         xKtr3caSJsLrGxYV02oO60lVbUczUR6FAq/4InapBB8vR2j0B6pFpW5jRj911ybpVZOB
         SqQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728943636; x=1729548436;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=i8w6ffEpFO7SbSBhrFi9OhNa1QYyGwUObySt3ab3Ei0=;
        b=ra7IvIheto1XwAK6Ql1hK0cT4RdpIrXX8n4Pf79kYGSPtrztRcSdHywlIplJjGDJcW
         ByopkY/GIgg2aIzGb916+N9XF4W8wLJx78I5B+G2H2n0VpRGZGaTNeuGPqDNMvaiU0Ll
         8tUmQkt/Tz/1VVx3kzqKOdGEQ8+HGl/mktknr61KwAeEFBlanHUQys1BVVMazwDz2qnd
         Jlr8gBC0W6iT7CrA+7AoBREJ2dBfkGfGPfV0iprlxJpeYqAujmmyLxIEesmd/RgzYC+K
         bLe3AMW1d2i36Cv5ziZVk+P9vlsUhg//wAIiSsKDFnJ+oaa/sX58Ehkyst6QbhPwxcD1
         g94Q==
X-Forwarded-Encrypted: i=1; AJvYcCVnucGWM+BVtgWcdHyZtoRlm/zAvaYA5Hs/MUTx6Agc54R55L+gcRHH+2KdH3Z4AfiucBRYQl3Tv3ZfMJg=@vger.kernel.org, AJvYcCWxEMqZQkv5ptmm3DONIavVSyJYO6t6ZOPBK64nrLe/cWoL8w5Il5W1C6u8E8MYfK4+OazvKQJsBecZY6//RLTU@vger.kernel.org, AJvYcCXN5CQJ0yDhxAJXrOWeTYloSlhsVCBENQrGjfNg4d4w6jbrQGf41fSJPS0SaMZGhMi+Je6LQdyJ@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5+qA6/aAgr4pX/jnvNKhtKC4DbA1zeYxbC7uV1C6fKToRf+AS
	Uy5+NYS/Dq/U+4dyLfkOH6BlxvOik3gT/C1dkX7jXVu4RjMisqPcOEvzn3U0QBV/03PQDJuYMkf
	I/PFU5GB+QIGZ3Cel2dd7juqBD8Q=
X-Google-Smtp-Source: AGHT+IHkyDEUmmGGnyUt7sO+5LG4pdrQyOuHncFHLBQRb0Zc7Ja7f7NQho3LtKeKQZKMj2cJZacYqB1cIXzt/cm2gMw=
X-Received: by 2002:a17:90a:a00f:b0:2e2:92fe:35d5 with SMTP id
 98e67ed59e1d1-2e315356673mr12536398a91.31.1728943636516; Mon, 14 Oct 2024
 15:07:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241014213313.15100-1-leocstone@gmail.com>
In-Reply-To: <20241014213313.15100-1-leocstone@gmail.com>
From: Dmitry Safonov <0x7f454c46@gmail.com>
Date: Mon, 14 Oct 2024 23:07:04 +0100
Message-ID: <CAJwJo6anjg4rBDLhgHL+vVtQ0FTWvK089p3D_xNNmcDTrXRL+w@mail.gmail.com>
Subject: Re: [RFC PATCH] selftest/tcp-ao: Add filter tests
To: Leo Stone <leocstone@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, shuah@kernel.org, rdunlap@infradead.org, 
	mnassiri@ciena.com, jiapeng.chong@linux.alibaba.com, colin.i.king@gmail.com, 
	netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org, anupnewsmail@gmail.com, 
	linux-kernel-mentees@lists.linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"

Hi Leo,

On Mon, 14 Oct 2024 at 22:37, Leo Stone <leocstone@gmail.com> wrote:
>
> Add tests that check if getsockopt(TCP_AO_GET_KEYS) returns the right
> keys when using different filters.
>
> Sample output:
>
> > # ok 114 filter keys: by sndid, rcvid, address
> > # ok 115 filter keys: by sndid, rcvid
> > # ok 116 filter keys: by is_current
> > # ok 117 filter keys: by is_rnext
>
> Signed-off-by: Leo Stone <leocstone@gmail.com>
> ---
> This patch is meant to address the TODO in setsockopt-closed.c:
> > /*
> >  * TODO: check getsockopt(TCP_AO_GET_KEYS) with different filters
> >  * returning proper nr & keys;
> >  */
>
> Is this a reasonable way to do these tests? If so, what cases should I
> add?

Your change does look reasonable to me.
I think you could add one more test here for passing
(FILTER_TEST_NKEYS/2) to getsockopt() as tcp_ao_getsockopt::nkeys with
get_all = 1, and check that the value in tcp_ao_getsockopt::nkeys
after getsockopt() reflects the number of matched keys
(FILTER_TEST_NKEYS).

See also minor nits inline.

[..]
> +static void filter_keys_checked(int sk, struct tcp_ao_getsockopt *filter,
> +                               struct tcp_ao_getsockopt *expected,
> +                               unsigned int nexpected, const char *tst)
> +{
> +       struct tcp_ao_getsockopt all_keys[FILTER_TEST_NKEYS] = {};
> +       struct tcp_ao_getsockopt filtered_keys[FILTER_TEST_NKEYS] = {};
> +       socklen_t len = sizeof(struct tcp_ao_getsockopt);
> +
> +       fetch_all_keys(sk, all_keys);
> +       memcpy(&filtered_keys[0], filter, sizeof(struct tcp_ao_getsockopt));
> +       filtered_keys[0].nkeys = FILTER_TEST_NKEYS;
> +       if (getsockopt(sk, IPPROTO_TCP, TCP_AO_GET_KEYS, filtered_keys, &len))
> +               test_error("getsockopt");

I think the following two checks would be better s/test_error/test_fail/.
The difference between _error() and _fail() is that for the later
exit() is not called, which allows the person running the test to
gather all "not okay" cases.
So, in tcp_ao selftests I used _error() only for failures where
nothing meaningful could be done afterwards, i.e. memory allocation or
socket() creation.

> +       if (filtered_keys[0].nkeys != nexpected)
> +               test_error("wrong nr of keys, expected %u got %u", nexpected,
> +                          filtered_keys[0].nkeys);
> +       if (compare_mkts(expected, nexpected, filtered_keys, filtered_keys[0].nkeys))
> +               test_error("got wrong keys back");

^ in those two it seems to be better to do
: test_fail("...")
: goto out_close;

which would allow to go through other "filter" and "duplicate"
selftests even if one of the "filter" tests has failed.

[..]
>  static void *client_fn(void *arg)
>  {
>         if (inet_pton(TEST_FAMILY, __TEST_CLIENT_IP(2), &tcp_md5_client) != 1)
>                 test_error("Can't convert ip address");
>         extend_tests();
>         einval_tests();
> +       filter_tests();
>         duplicate_tests();
>         /*
>          * TODO: check getsockopt(TCP_AO_GET_KEYS) with different filters

^ please, remove the related TODO comment, I think you just fixed it :-)

Thank you for the patch,
             Dmitry

