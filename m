Return-Path: <linux-kselftest+bounces-18226-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C3A397ED34
	for <lists+linux-kselftest@lfdr.de>; Mon, 23 Sep 2024 16:34:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3195E1C20491
	for <lists+linux-kselftest@lfdr.de>; Mon, 23 Sep 2024 14:34:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD4671991BA;
	Mon, 23 Sep 2024 14:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="QPerjNNA"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19A9177107
	for <linux-kselftest@vger.kernel.org>; Mon, 23 Sep 2024 14:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727102068; cv=none; b=ebcBe1LmG1aVO055B+2aAf6D7+92VBZiEM16YC26KAh1AX1Au+iSyXfzPT1hmNroP5zAlMGutLViU1Qzn4/2THSDxr3jxXpqai6H0ljO8+tKCh+M/MYSFndaNjuIyGktg0kDlkKo7iw9baYlc4ESx5OGykO4Q/oRn3x8JnLMtEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727102068; c=relaxed/simple;
	bh=/hlN1vc3iqsnhJ8BbsFU6jjZPvQSoABUoLWn0JPyOj4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=nn71Eq5nZuXQOT/JXQ0WYA0jMCcKoT0EObcvayHZYvLj0WYtXsBynR73OWj3FQXOXbTd/rEEl7D/n0Py4ikEmdJrPNqWIn2zhS8YQy7T82oXQ9aJVj8ix+FpMMJrP9GW+BfLAABNuerJjadCDrkai5BahvXwTNiHF+SR1+mGNMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=QPerjNNA; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a86e9db75b9so707173166b.1
        for <linux-kselftest@vger.kernel.org>; Mon, 23 Sep 2024 07:34:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1727102065; x=1727706865; darn=vger.kernel.org;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/hlN1vc3iqsnhJ8BbsFU6jjZPvQSoABUoLWn0JPyOj4=;
        b=QPerjNNAunT8g3oca6cMyqkWg91JFmbqR8GZv/t0dBb6Qgfl4wPfs+ItdFnLzPN5Aq
         nEzNhii9S20L/H/RYVbrOh0A3zABsPHNNdm4oycwVtLkhc6ziD0WzzyGusAc7nMapV++
         guf7HPqoCUi58x+wKb5YD6aTrOSTF/vo2S9CfKNnErUaFVSkNCiQpNVTKf2YC+Y61bob
         74RmMU5yhA14nkVH+Ktz7W+rMt3mKf5UD4x6EPc7a3LRueVIYLLNc1luXRJPzEUvs8pi
         2eXcDTt99KjbE+NGrlkyAETUGUz+k+/DK9OzsMPowX/MC12q+V9OtwnhQQfgVv4WSRmG
         7Sbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727102065; x=1727706865;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/hlN1vc3iqsnhJ8BbsFU6jjZPvQSoABUoLWn0JPyOj4=;
        b=LL7clw/AodrjrmrUMSDR7VW2klnswikqY7qTO9as4LaFBl9t7rssFU+gvqVAn7vK68
         N9LPwrs382Jds3HwsjHQilr2k2WIW04Rce33ciml2SMxoqLcaRK/EKuX0qcNmivIeSlg
         NY4u04LZ38ENdB5PH7w8nyDBw8HuWj8YCLDd1KxL0mh5O/B08XP9FOgb+qKNFZprICMv
         +mKbaWb2qNKi98dbpjrcKxh8gD8J9u4vHO8uGo2+gFgMXOmrb6hLX+2P5eWqED5kj8co
         Vis+okCSQ7nByfnfbQQTDzFEiOD1vcRnIpknUa5SRVdQBARRStJTP0y1spAJNKMtWo5n
         A5Mw==
X-Forwarded-Encrypted: i=1; AJvYcCWhoODmb5gs48XQRIOywyd9vc62gL66puHDZ7bPkRCQsMXCrtwFxjR3t0myt3lsNYzv3pzcoMIySB8ugKDVyA4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6eLsTuhXexC5AwGZo6ivO491a9Ne3463/kKtLz7KulJWCVELG
	COh2zHrAh5ZBxRyqi9Ki1RVp+k182Ff4PJDboj0EHqmIm1v9KH6DZ2UILm1Mi1A=
X-Google-Smtp-Source: AGHT+IGvZ8CQKXGAuBIihvOK7BE9/Z+R3v8H58CSqqO0KjaYyKlCLQW3ALuIjZIDoyqq5B9b4jxJgg==
X-Received: by 2002:a17:907:e64f:b0:a8d:555f:eeda with SMTP id a640c23a62f3a-a90d4fdf82cmr1225911666b.8.1727102065503;
        Mon, 23 Sep 2024 07:34:25 -0700 (PDT)
Received: from cloudflare.com ([2a09:bac5:5063:2432::39b:5a])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a90612b38d3sm1231298066b.120.2024.09.23.07.34.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Sep 2024 07:34:24 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
To: Tiago Lam <tiagolam@cloudflare.com>
Cc: "David S. Miller" <davem@davemloft.net>,  David Ahern
 <dsahern@kernel.org>,  Eric Dumazet <edumazet@google.com>,  Jakub Kicinski
 <kuba@kernel.org>,  Paolo Abeni <pabeni@redhat.com>,  Willem de Bruijn
 <willemdebruijn.kernel@gmail.com>,  Alexei Starovoitov <ast@kernel.org>,
  Daniel Borkmann <daniel@iogearbox.net>,  Andrii Nakryiko
 <andrii@kernel.org>,  Martin KaFai Lau <martin.lau@linux.dev>,  Eduard
 Zingerman <eddyz87@gmail.com>,  Song Liu <song@kernel.org>,  Yonghong Song
 <yonghong.song@linux.dev>,  John Fastabend <john.fastabend@gmail.com>,  KP
 Singh <kpsingh@kernel.org>,  Stanislav Fomichev <sdf@fomichev.me>,  Hao
 Luo <haoluo@google.com>,  Jiri Olsa <jolsa@kernel.org>,  Mykola Lysenko
 <mykolal@fb.com>,  Shuah Khan <shuah@kernel.org>,  netdev@vger.kernel.org,
  linux-kernel@vger.kernel.org,  bpf@vger.kernel.org,
  linux-kselftest@vger.kernel.org,  kernel-team@cloudflare.com
Subject: Re: [RFC PATCH v2 0/3] Allow sk_lookup UDP return traffic to egress
 when setting src port/address.
In-Reply-To: <20240920-reverse-sk-lookup-v2-0-916a48c47d56@cloudflare.com>
	(Tiago Lam's message of "Fri, 20 Sep 2024 18:02:11 +0100")
References: <20240920-reverse-sk-lookup-v2-0-916a48c47d56@cloudflare.com>
User-Agent: mu4e 1.12.4; emacs 29.1
Date: Mon, 23 Sep 2024 16:34:23 +0200
Message-ID: <87v7ym7828.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Just an FYI to the reviewers -

Tiago is out this week, so his reponses will be delayed.

