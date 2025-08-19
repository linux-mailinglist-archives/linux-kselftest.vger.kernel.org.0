Return-Path: <linux-kselftest+bounces-39331-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 11360B2CD0C
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Aug 2025 21:36:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 03FD64E4AA2
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Aug 2025 19:36:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD05B33769F;
	Tue, 19 Aug 2025 19:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="ZhvRG9Vl"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C3DD326D69
	for <linux-kselftest@vger.kernel.org>; Tue, 19 Aug 2025 19:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755632189; cv=none; b=dHXUYwB6wYRufaB4/TVtlbIDCgz0kKbsECG5ACajSMqvoGh4LeL5FEOancnMjTD4pSFm4z46G4Bx0uJMritCxdRevCjdKAfmUMX9+9K0hpLbJ0BNjkkxAS5FMvnz689Kc0RNdi2ogIF/u59Y4GRC3xjQl+PNlmEeikZrIHSnnWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755632189; c=relaxed/simple;
	bh=XMTr22jE8+TzIGCkrNbuJr5AyQILau+FIPmP9ww25t4=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:From:Subject:Cc:
	 References:In-Reply-To; b=dj1FXAd6+jF5qvyox8AnB5/ZUYGI7eO8MMv90UkKTCOC1XbUH0OnqFPj4nPXpJu4lrOOFv7VcCDz4Rh0kEmEFm/N1xTP/8OM8Y5UFcZ2okSEc9Y6bngDhOUSTwTVdirV/Yukn5i/eKrQDHZqhLAApAPOhOqFSmUbq35mgrcBtDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=ZhvRG9Vl; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3b9e414252dso2764417f8f.3
        for <linux-kselftest@vger.kernel.org>; Tue, 19 Aug 2025 12:36:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1755632186; x=1756236986; darn=vger.kernel.org;
        h=in-reply-to:references:cc:subject:from:to:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XMTr22jE8+TzIGCkrNbuJr5AyQILau+FIPmP9ww25t4=;
        b=ZhvRG9Vl0pj/TiRwXhF3iSzfCDebouJTmG+cX+DxjORb9DSqD93ZVxRmVEfXrdIvRh
         G/ZYUhmmqt2nGlmjy2UVRbHGEbFG3zI9ADXDQ5COe2vNNdYVtmnFGG8dd9OObciNMKpV
         RMtT7KIH+xz6M3n+5E+rSDLFnndWoVcP6S7OXvf2PQ4TETFdJZQN2qM/BCDNhzigx96V
         AYk8zncvpojcMpVdiGMOekx2ZHq8KpYoKrndMB7GGzure+6vpbBHIDIjL/7kCtwTOb+L
         IzdCy1zd3G491sqEEA8LZgOv4b0wD/eu2fXSB7PQG1ne4WzAEXGf0iXlwlrG0eeUfK6J
         fu2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755632186; x=1756236986;
        h=in-reply-to:references:cc:subject:from:to:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=XMTr22jE8+TzIGCkrNbuJr5AyQILau+FIPmP9ww25t4=;
        b=tIBAB+qs0L85xTaTCcqRGzSiRn4IhQOnfBqFaTrLu7GK/xbFo5XlS5yeKpV+TFDS5M
         grY5ht01uJTgjBRYwikBjq+lSLL/OQKMytyKqxnkceuAavPnR4kt0RdnAoOBmBymZC60
         eDSbx7QIgU+bfI/KyieRjkFZQx6pZErWadfNOZH92+/7r9hkl4gIWYWiwfEQuxQvhA2k
         5dWjOaeZRVu/svCOqYpW2izm+iU+vqcERh2SUj8x566nGO6oTS4PM6LhZzrRfc6lwJHB
         aPaMxD6HHKxB60ZVUhYRuqswVnvlU8NFHgxop7IAd1Zq3skylDdeavXiprGSELhetcGm
         luKA==
X-Forwarded-Encrypted: i=1; AJvYcCWfPVnUzlinc8IuUaivWNO1jPDZbH0dJgDDS4mLdH/ITgG/3HjrbkU4EcAzZVQUln7YRgwhxHyihe/5wBLszF4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxp1zzz6vEpbhUvE+O5EnKOZemFQUtxTgrUl0TjajAbJqXezHBx
	lAlG81h1X2yg5ovzX94ebBxJoSA0grYKm+eb6nYQbbt/EfsD5iPeNLyF1eO9NWRtNxQ=
X-Gm-Gg: ASbGncvBYXT0b8jnX2W3Rxjb6rzcIeQn1iIBkPlCf5f6m/ojzwzSJbvUaT5UMrl7ste
	GkSefpQiogBenbM/8walWGollUZvDD/uIueHYPPyobJ/75tQzVa9BKwWYZd9DhwewMdEfLrfwkG
	hCM5IttqRoZacxS2b3Lm8qjaPMv/AMgZWQ6JMB0uUEasQb//J/kQ8UtSLBOJ/tZI89lcoZDTmJX
	kyzh9U8MscXN4fWkc5PsyHOa8F+NCq/4qGM9tdd2qu4AhuQxbLWilZY3Oy0j2RshMI9qkG9sfSX
	msjG8SLkRHCldE+d2iMLdsO2obxbKG3iyTQ5b5DSrJETJm2Vs6j0zYMSrhABV8Vm4G63+xvFLKB
	VjkoMS/zfug==
X-Google-Smtp-Source: AGHT+IHBk2tSb5Lmwdms9G3Pkyvfo6Sp5PUfXRSGwyT9Jfwf9OGJ938dge2YMoXl7bFT6nj/p8+rtA==
X-Received: by 2002:a05:6000:26c1:b0:3b9:1109:7064 with SMTP id ffacd0b85a97d-3c32c52f457mr162200f8f.15.1755632185904;
        Tue, 19 Aug 2025 12:36:25 -0700 (PDT)
Received: from localhost ([177.94.120.255])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-53b2bddd926sm2708328e0c.14.2025.08.19.12.36.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Aug 2025 12:36:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 19 Aug 2025 16:36:20 -0300
Message-Id: <DC6NO1I1LFU4.1G1WPLKTRZGNV@suse.com>
To: "Josh Poimboeuf" <jpoimboe@kernel.org>, "Jiri Kosina"
 <jikos@kernel.org>, "Miroslav Benes" <mbenes@suse.cz>, "Petr Mladek"
 <pmladek@suse.com>, "Joe Lawrence" <joe.lawrence@redhat.com>, "Shuah Khan"
 <shuah@kernel.org>
From: =?utf-8?b?UmljYXJkbyBCLiBNYXJsacOocmU=?= <rbm@suse.com>
Subject: Re: [PATCH] selftests/livepatch: Ignore NO_SUPPORT line in dmesg
Cc: <live-patching@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, "Marcos Paulo de Souza"
 <mpdesouza@suse.com>
X-Mailer: aerc 0.20.1-125-gabe5bb884bbc-dirty
References: <20250819-selftests-lp_taint_flag-v1-1-a94a62a47683@suse.com>
In-Reply-To: <20250819-selftests-lp_taint_flag-v1-1-a94a62a47683@suse.com>

On Tue Aug 19, 2025 at 2:37 PM -03, Ricardo B. Marli=C3=A8re wrote:
> Some systems might disable unloading a livepatch and when running tests o=
n
> them they fail like the following:

oops, sorry..

Please ignore this patch, this should be handled downstream along with
https://github.com/openSUSE/kernel-source/blob/SL-16.0/patches.suse/livepat=
ch-mark-the-kernel-unsupported-when-disabling.patch
...

