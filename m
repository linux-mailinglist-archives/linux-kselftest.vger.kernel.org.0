Return-Path: <linux-kselftest+bounces-15685-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 76CCA95741D
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Aug 2024 21:06:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 34A052841DF
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Aug 2024 19:06:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 601971D54F0;
	Mon, 19 Aug 2024 19:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lzC1qlUu"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4B3C26AD3
	for <linux-kselftest@vger.kernel.org>; Mon, 19 Aug 2024 19:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724094377; cv=none; b=AEJQtRE7yD6ru8Y4ng2otK293Ic0wUJYqB/CFi1q6IFdKtqSnyl+UVSIt4UzH306USzEik8eNiXoUvXLM3lVg1FtaT//9TmdAY5flGTlf/GB8l2l9J8T5FzS/kh/eWzsKYh3iK+BT2KfdzNgE8qBZXjO0fW+4yMOp7TmxuxmDog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724094377; c=relaxed/simple;
	bh=ZOmpoV2tEdUFrVa5RI+AkesGt6dYQh9a5AOy4xRvmLk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=C8SJ6dDMNKrGal3Z8pUBSoq7Z0OiNOW5aGuA+w9W1GwQoTXyh8gz54D4QPWHorFyjq8o0lUkegJkUA1W55TLFvir5vP7FR6KZF+EnDb43f9GDMwoIeDZkKmRtaNenlFaUbaQFt+CabjofIhAApUl0MHZyB/b8eJR0QLYjR/MIFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=lzC1qlUu; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5bf009cf4c0so1274778a12.1
        for <linux-kselftest@vger.kernel.org>; Mon, 19 Aug 2024 12:06:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724094374; x=1724699174; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xpAZramWONn8vOEqfHVOxy50BnBQq4M8nzGv89LSyDA=;
        b=lzC1qlUuIWJ6aSDarUyrmvpTuBe8Cd+N3aT8+jQWZfGo1DeXrskrMevudwNha0E6B4
         C9vCB/iXVgS/6UpHtVeQmEWXhEQuf7r4u2dibPHLG5xPSxhhggckmG1POlT0KbezmPsl
         8jTAUkP6IRhDtNsxIycgz2dyyDLOnnQtVVfI77cAfm6y0jfyxP4LxIcs3JmJPzD+ypDY
         1GXc8Q0ljiZ6cS8t7JYqMEW9fQKkrtBTgtZ4qACzGCAsWw/tERGC4vUafW7OZkDaTzvP
         haV5mLGcIieFQMeGDmtgo47+dONLTznoJbo6bCA9Vl9qHDKmnBMJMvPLCRDgNPzoC0N6
         lQdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724094374; x=1724699174;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xpAZramWONn8vOEqfHVOxy50BnBQq4M8nzGv89LSyDA=;
        b=qOaz6VVKzbHGMS7LOriq610dEwyUXs/2NamjqxawIymnzo7tUgWnRX0Vuf/+cas/nD
         HRkdd4uYhKM87DQGiwS01xfzi1qlgvSXv4XEDP/vyAOeKX0HgTkmSuo/STCG33C04pEV
         9BpOxSQsHkYBM13ghrQF1fpW0H0Gg2ZAo0ToxBLrx9xa7eW5Ft/b8iqcg8u5tDN4LVX0
         D7nbGdiHMqBf0npftLdxvHGjTH4Tf4R73ECr2ovqDQGG3ltg/9G/aD+ioogqlhzHeex2
         +00PJ5k+gZW2ll77ZHf2W9CuO40bZxi+4P7r2T7yocUNq5RXh0JDeD3GFhMSqWwvUQ21
         YkuQ==
X-Forwarded-Encrypted: i=1; AJvYcCUL2zaaN7lyFMGt+fM91wm5fKuc4+J+c61SM+RY9HfQiYqNxDAs784EbdEZFKRdVu4TTycgY5qqrNBvW3LTtgXmLB5QzwONdS858lUKMF4v
X-Gm-Message-State: AOJu0YxqRxwPLG4o5CBxVx06yM9eK777f2tad2lPXvWy7abgZ7QzYlKS
	ubUqXNCf+3XLTcLry3pOgInQh2k2A8uZATmM5Huga2FKsylgYIQt4paoNnoFDbA=
X-Google-Smtp-Source: AGHT+IHS7zo5e7902iNUDnPPR6SioO6pXYwQcqzC0BdGhlmJF+4NcA0LVgInhvXRdkMUPVgqBWaG+Q==
X-Received: by 2002:a05:6402:11d4:b0:5a1:c40a:3a81 with SMTP id 4fb4d7f45d1cf-5beca8d129cmr8278470a12.35.1724094373700;
        Mon, 19 Aug 2024 12:06:13 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5bebbde4964sm5870402a12.24.2024.08.19.12.06.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2024 12:06:12 -0700 (PDT)
Date: Mon, 19 Aug 2024 22:06:09 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Joe Stringer <joe@wand.net.nz>
Cc: bpf@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: [bug report] selftests/bpf: Add C tests for reference tracking
Message-ID: <418e180c-31b5-4777-b341-8503b1d5e0b9@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello Joe Stringer,

Commit de375f4e91e3 ("selftests/bpf: Add C tests for reference
tracking") from Oct 2, 2018 (linux-next), leads to the following
Smatch static checker warning:

	./tools/testing/selftests/bpf/progs/test_sk_lookup_kern.c:70 sk_lookup_success()
	warn: potential pointer math issue ('tuple' is a 288 bit pointer)

./tools/testing/selftests/bpf/progs/test_sk_lookup_kern.c
    55 SEC("?tc")
    56 int sk_lookup_success(struct __sk_buff *skb)
    57 {
    58         void *data_end = (void *)(long)skb->data_end;
    59         void *data = (void *)(long)skb->data;
    60         struct ethhdr *eth = (struct ethhdr *)(data);
    61         struct bpf_sock_tuple *tuple;
    62         struct bpf_sock *sk;
    63         size_t tuple_len;
    64         bool ipv4;
    65 
    66         if (eth + 1 > data_end)
    67                 return TC_ACT_SHOT;
    68 
    69         tuple = get_tuple(data, sizeof(*eth), data_end, eth->h_proto, &ipv4);
--> 70         if (!tuple || tuple + sizeof *tuple > data_end)
                             ^^^^^^^^^^^^^^^^^^^^^
This is pointer math.  It should be "tuple + 1" or (u8 *)tuple + sizeof(*tuple).

    71                 return TC_ACT_SHOT;
    72 
    73         tuple_len = ipv4 ? sizeof(tuple->ipv4) : sizeof(tuple->ipv6);
    74         sk = bpf_sk_lookup_tcp(skb, tuple, tuple_len, BPF_F_CURRENT_NETNS, 0);
    75         bpf_printk("sk=%d\n", sk ? 1 : 0);
    76         if (sk)
    77                 bpf_sk_release(sk);
    78         return sk ? TC_ACT_OK : TC_ACT_UNSPEC;
    79 }

regards,
dan carpenter

