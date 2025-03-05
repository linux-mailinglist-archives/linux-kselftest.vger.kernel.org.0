Return-Path: <linux-kselftest+bounces-28255-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 862C3A4F22C
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Mar 2025 01:10:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D064A3A86E4
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Mar 2025 00:10:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4FABA32;
	Wed,  5 Mar 2025 00:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="neq77h+W"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 753176125;
	Wed,  5 Mar 2025 00:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741133417; cv=none; b=A/SZk/EDsKb487OaqVVNIQ700ZEGJ/sOvoB2enXyUUnqgf/FfjjwH66G50Sd62iqp3TeZA51v3FdQcKkpXEpXyhn6wgXW6ApZNPMHJ8BqxkZoZolJWoXOrq0PVIx1t1JWljVP7WOmuJ7iS1nkBGbCFFkLZOmUSHUdpXfKPvOW7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741133417; c=relaxed/simple;
	bh=bFnvscZbxhwjHZv1qs57YBCimMPUADwC2kTl8RsMdBI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R6EHDsmyn6G6ViMcaKrLCOJDtNKZf2IsgXIRtkbljqncxCpop6Q2CaYhz3F2PjR+QFFkOr7MliFnGi//+5s79W1XrKNxxtLIbreNY5qf5obFT1Nu5EMLDFN8wuDHPtuTBxGBZ3PgZ+AKBvOqnAIK1X2pWDP4WzhImjH6AL0YKFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=neq77h+W; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-223480ea43aso154846285ad.1;
        Tue, 04 Mar 2025 16:10:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741133414; x=1741738214; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=F7km59fao8y0WLhuX8SpE0wse6JiUzqNy5UOLlxx4/I=;
        b=neq77h+W6+yWJNFDe13Y7W1dX61gLSlsgx3vclpGF2ubX65MMV13onpmYXANKK6Fos
         avh3pi+tjVjyWLaGUz8RAHrsFUe0QtEZuX1MnQ5lbyQEkygLv9YIuxJ4sHALxJU/rxHU
         Tde+s+iRo3JWmEigh0iSsHZln8FkGa4iAhAg1pZkEDrFAKPVGCxxTnKJJX9pP31HZvTP
         YqYsRNzx5/++XGpBR5tHxrHhpC0Kkx2w+Zxo8OLoXVIaIUM9V6xxWX6H1FP/YCoCkt9N
         2C+MUdjthYgcF5PPozFXpXhO9qtqy3Yl5qYPz+P9w3oZKHp2zjUCvJw8GU34kCGyP6h9
         I0Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741133414; x=1741738214;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F7km59fao8y0WLhuX8SpE0wse6JiUzqNy5UOLlxx4/I=;
        b=wUTVYnjRhxH4tbqpQ780G7EuhvuQCrCAhtzGVhw/tphDZWgzYJMZ4VaYskfGAhD22s
         NJfEikqdfzgM15gUaAELHYTp8Nituwkel9Isx2BbGXJxSgSNyFCcx6jHH9j00N0DNzW8
         YsmUS+PT7RM5+TeeXapBG31HG/cA3dDjDI11LZx/BaHARwXZDksPXNSm/cRIKPw6NSjz
         +w56PC1dy+8nIdTMar6wPp7Xss5Jv59fMn3QivoYuEdnY53ikPuZ8UDPQGWY8xSL0DhL
         dqiJZzD/6bzuJPzfW36IeKeZR48U5O1d1kzpPzBzz21M8beQAx+crh5HyrqYXe5GSJUm
         /AMg==
X-Forwarded-Encrypted: i=1; AJvYcCV3ryZO8VmRptO7Jb7eCUigKoVXIllPFmDeMQauoaoiZxuRmAgKc6sFba+m/E4Tj0EA+/77FxF0SWutt2T2EwWm@vger.kernel.org, AJvYcCWgW63iqbkFgIF10kCkc4+M96rBni+XSqlmzVdw4zYKomFdVN1heEyjzooTjdGZzp9KPTg=@vger.kernel.org, AJvYcCXj7ebFse2tjGWuMxw5yPpvunWWGN81/hKiRRBpaqq4uHSi0/AeklICR6pRLqKXezKOJnjvLC0o@vger.kernel.org
X-Gm-Message-State: AOJu0YxBC0oeKwvqaqna+QWBchSd7Ra/r2ls7Jg6GIsaFGZ9PdTu2epV
	TAfSuzwd2CLc2AHh1N4g8BnW4/5glSOh8oaeZPDrOfOqpQECsA4=
X-Gm-Gg: ASbGnctXN3PmbH5u74ZO8ZsSpJjhuB6WW5zNLKaJ3BI3MkvXZe9nKyThS7qRbNJd1jl
	EDxMzMTRzulbmsQNjfzmAwkdIw836Wbc1f9NIjuY23y+NLEf5qiRGE410iQt06mNIGbEoY5yOc1
	uE5Lhm6c/+cCEdzAqa7XcPv/3jVmHMeY/ANQRodE10DuI9BEloUzxT+oXdzujVI+lBxTSRG8Qnl
	hKvxpC6LvCoTnJIFXPWXUIRaPqkc5cZrvE9NtXaomDmUxh57eqDO3OnusztcaH6l1yThjGvjcuK
	zpMPuRF18ZVvcwkhrGPanpHj3hgxOuod0UWEofOgvAhJ
X-Google-Smtp-Source: AGHT+IFWXh8pYE44o38u8+RjmjG93VO4wvY2NWvz2A123i/kXMGdBsntTk0KIIu+oAaxdbuP+nzQvA==
X-Received: by 2002:a05:6a21:3984:b0:1ee:d8c8:4b7f with SMTP id adf61e73a8af0-1f3494ce2e1mr1792845637.25.1741133414609;
        Tue, 04 Mar 2025 16:10:14 -0800 (PST)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-734a0040208sm11551609b3a.154.2025.03.04.16.10.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 16:10:14 -0800 (PST)
Date: Tue, 4 Mar 2025 16:10:13 -0800
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
	shuah@kernel.org, linux-kselftest@vger.kernel.org,
	bpf@vger.kernel.org
Subject: Re: [PATCH net-next 1/2] selftests: net: fix error message in
 bpf_offload
Message-ID: <Z8eWZSuDU4Q4q5UM@mini-arch>
References: <20250304233204.1139251-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250304233204.1139251-1-kuba@kernel.org>

On 03/04, Jakub Kicinski wrote:
> We hit a following exception on timeout, nmaps is never set:
> 
>     Test bpftool bound info reporting (own ns)...
>     Traceback (most recent call last):
>       File "/home/virtme/testing-1/tools/testing/selftests/net/./bpf_offload.py", line 1128, in <module>
>         check_dev_info(False, "")
>       File "/home/virtme/testing-1/tools/testing/selftests/net/./bpf_offload.py", line 583, in check_dev_info
>         maps = bpftool_map_list_wait(expected=2, ns=ns)
>       File "/home/virtme/testing-1/tools/testing/selftests/net/./bpf_offload.py", line 215, in bpftool_map_list_wait
>         raise Exception("Time out waiting for map counts to stabilize want %d, have %d" % (expected, nmaps))
>     NameError: name 'nmaps' is not defined
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Acked-by: Stanislav Fomichev <sdf@fomichev.me>

I've seen this a couple of times myself but was too lazy to send out
a fix :-[

