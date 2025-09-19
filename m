Return-Path: <linux-kselftest+bounces-41924-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 34B67B88A9E
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Sep 2025 11:54:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F255A16BEB5
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Sep 2025 09:54:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FB00286D4E;
	Fri, 19 Sep 2025 09:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="CyH62hPA"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E79EC26529A
	for <linux-kselftest@vger.kernel.org>; Fri, 19 Sep 2025 09:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758275658; cv=none; b=MzeEBQgnS+i2eRNB1sBAwX8eb1ptVDIhQVwJVgA+MQGIEJVV3KG0Vv8Zct6wHTDyBYsD3St+D50muIxM5tROG6eqffmruv+rky/DYo34JtXdRD99NS/pkY/ePOcbP2fI7kYrgh84gdBw53a467jv8D7kjnk+2OV/TQ7APbOWK2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758275658; c=relaxed/simple;
	bh=r8WWHzbKJIxTeouSgwB4Mr2pbj4QCBcVdISTTpSBgvQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=J652rJztbcT9wu5Tduu+WeHXuYK5GosX2bUbMmZIRkieCpglVN0ZmHW1mt1PILH+yEJVJliVuobRx8oZCJCyl62btqYuRASk+tzYo/nraG9nTUOHglxEW0Hmm6sk000Vrt1cxMwBdlbcnTeAmRGAtQj7912HJbDetwoCEnkIsME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=CyH62hPA; arc=none smtp.client-ip=209.85.219.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-ea5c3e8b88bso1335993276.0
        for <linux-kselftest@vger.kernel.org>; Fri, 19 Sep 2025 02:54:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1758275656; x=1758880456; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=POTRFWGD9N2Eju5JQSXhfOmcmRxIBLOL3ZetmyJPEbE=;
        b=CyH62hPA09osl6nefCXQ/8hXKAuLtUUzcsuNPYN6XoeW44BvChr6/rt+W2v69BbpN9
         vFC/oszlNTfD2ifi2dyPrZJwaVKMO46KSjxvzUutEqSG9Lj3PBr6g45qg3iZ20VeRIdC
         AntFg5KFQI3tFzjbRG3gJpo5THOKedIxGnssGOOdTfTp8PR5+uJAup0tOyHdzY3Ta7cF
         KLf2BPb10OR33/N2Y0FcTLL4dzVznVhZ4DHXATTJkQsMVi72bKn9C3hJKM1xZlRer/Gs
         yy9uNMfLylRc5Re53aQo2fVTpTgDIM0GdenRzs2WJ0mAf8IvchDKePGt/kkP36USo02D
         WijA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758275656; x=1758880456;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=POTRFWGD9N2Eju5JQSXhfOmcmRxIBLOL3ZetmyJPEbE=;
        b=SJPyC9oDJM7OhCKJ3/Jh8/5T0UBgGYeW3Hjp8JMON0YZGP61DpKCXoDGcMaUB+Heej
         +mnrUJfJuatT5q7APhvyUHlCEkhatSlFoLUjjIVx0qs4z+FKTtp4rZluOcX4/jeWEaYK
         wqAXM+D5pMHFm8YmgvDiLbLCDQbi9z9WZl0R/PkFdsbcLhJmx4/9SrVpW75e9e2ganJC
         C8ciV7U/nA4dtRfhuTfaAXg9dFsp+XAJPo7oosXjL+vzhYoiR4KKrAnKL2CuzEGM7Z6H
         lyjltQi4oWJRMoab0CYnoMKbXAc/s87MW4qWZ8KYOZyv0SEhA2tIA4OjzRP/DzI4spJA
         SYLg==
X-Forwarded-Encrypted: i=1; AJvYcCW38UOk4amyLMzsCUpPkA3vKLbklb7BcCDc6/z2yUsAYSAq8gzmraGEydGdzGuXc/h9dBxplcRJnXe0eAyBQ7I=@vger.kernel.org
X-Gm-Message-State: AOJu0YzevGD5J+yx4xPR49fSevI3NMlfcWxMlDAAjJzHQtrQ1wvPOoxy
	jE5snYKnsmhr5rpmKxevWn8cCDMVM6+09+GsVfW+gOC2t3yrhn9luiT4VhH7i3KftB8=
X-Gm-Gg: ASbGncueOr6bWsKz9g1KWn2QUK0ocxH6MjDY9sFsyFYPefcfKdGKSenfIeaEdNuVqJG
	seLj1LZFB15VclELbSixqLcg74lS/Q/5yV1eOIsd0BFgQCZLBJRU/C2hWOtZjAjCelokRMxl8K8
	/6LF2Lqd6khAu73sspckclNvlCGMG1uSA5YGipXrIRLwJ4NxfjlBWMhQTpBIfY3jMSZZEMgfny9
	YLwXkLe37SxoaCgVSHfmD/pgGKcxT+Dg8WEMWhd2Fd2dBhppUPwNuARYaNyJFVXkhkuUvlMT9Y+
	oJ0zJcKAOxJokIxDimBg621T7lrd34oW4blLx69falJ+lD7NnE2dTcfCX7dP2BW7zT8kUyc2/Vt
	ra6V9XRAF+6OyEA==
X-Google-Smtp-Source: AGHT+IFh6gBvRGK6CP91Xd7WmHsxfSp7jA0HwoLiouLAGHBFeou/eRHvssueILk3xyR+Puuh0g2paA==
X-Received: by 2002:a05:6902:150f:b0:ea4:139d:33f6 with SMTP id 3f1490d57ef6-ea8a0c2f5e3mr2212165276.29.1758275655893;
        Fri, 19 Sep 2025 02:54:15 -0700 (PDT)
Received: from cloudflare.com ([2a09:bac6:d677:2432::39b:31])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-ea5ce8544b5sm1580858276.17.2025.09.19.02.54.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Sep 2025 02:54:14 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
To: Michal Luczaj <mhal@rbox.co>
Cc: Alexei Starovoitov <ast@kernel.org>,  Daniel Borkmann
 <daniel@iogearbox.net>,  Andrii Nakryiko <andrii@kernel.org>,  Martin
 KaFai Lau <martin.lau@linux.dev>,  Eduard Zingerman <eddyz87@gmail.com>,
  Song Liu <song@kernel.org>,  Yonghong Song <yonghong.song@linux.dev>,
  John Fastabend <john.fastabend@gmail.com>,  KP Singh
 <kpsingh@kernel.org>,  Stanislav Fomichev <sdf@fomichev.me>,  Hao Luo
 <haoluo@google.com>,  Jiri Olsa <jolsa@kernel.org>,  Mykola Lysenko
 <mykolal@fb.com>,  Shuah Khan <shuah@kernel.org>,  bpf@vger.kernel.org,
  linux-kselftest@vger.kernel.org,  linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next 3/5] selftests/bpf: sockmap_redir: Rename
 functions
In-Reply-To: <20250905-redir-test-pass-drop-v1-3-9d9e43ff40df@rbox.co> (Michal
	Luczaj's message of "Fri, 05 Sep 2025 13:11:43 +0200")
References: <20250905-redir-test-pass-drop-v1-0-9d9e43ff40df@rbox.co>
	<20250905-redir-test-pass-drop-v1-3-9d9e43ff40df@rbox.co>
Date: Fri, 19 Sep 2025 11:54:13 +0200
Message-ID: <87frciu5ru.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Fri, Sep 05, 2025 at 01:11 PM +02, Michal Luczaj wrote:
> Preparatory patch before adding SK_PASS/SK_DROP support:
>
> test_redir() => test_sockets()
> test_socket() => test_redir()
> test_send_redir_recv() => test_send_recv()
>
> After the change (and the following patch) the call stack will be:
>
> serial_test_sockmap_redir
>   test_map
>     test_sockets
>       test_redir
>         test_send_recv
>       (test_verdict)
>         (test_send_recv)
>
> Signed-off-by: Michal Luczaj <mhal@rbox.co>
> ---

Reviewed-by: Jakub Sitnicki <jakub@cloudflare.com>

