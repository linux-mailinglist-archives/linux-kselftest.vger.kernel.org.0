Return-Path: <linux-kselftest+bounces-49014-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 55508D244C7
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Jan 2026 12:49:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 853E93096013
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Jan 2026 11:43:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13AA037E2E0;
	Thu, 15 Jan 2026 11:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qmon.net header.i=@qmon.net header.b="mHk8G2Ww"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from outbound.soverin.net (outbound.soverin.net [185.233.34.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBDC02EBBB8;
	Thu, 15 Jan 2026 11:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.233.34.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768477366; cv=none; b=AULPH2osw3m6n1xPBYgoKAlDa06gtEqbRPmAD9fuin8KDr+/YMRUj9WVFD9CGgGB6EMCfXcDwPboAVYst63FpvGewgHb5yRhhC1yvQxABLVvLXd4h2YEuqRDH+lWPAWstVejfaNgMiOZ6t0DPfgrbkFVgvbJ3wo+YPlLqAhacWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768477366; c=relaxed/simple;
	bh=RrWNNpmGtTT22Z14HxnH+Yh0kS6RBPYzO3RC13wye7o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SBmEHo6WpcmGeOZYm23QfWzOMiUUR19yBoZxuKDD+D7QhOyXncIVLi9NHYeDSzjXZ8j5gX8GoLYUNMk5PCmP0L6prXGicYs1CZuJGCox0HovLkVVRuXIJ5ddrHIq+kWFrvVzUzHgv6DPu4BHAjbQtnp4yHij4JcuUKcTUSovRIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=qmon.net; spf=pass smtp.mailfrom=qmon.net; dkim=pass (2048-bit key) header.d=qmon.net header.i=@qmon.net header.b=mHk8G2Ww; arc=none smtp.client-ip=185.233.34.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=qmon.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qmon.net
Received: from smtp.soverin.net (unknown [10.10.4.100])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by outbound.soverin.net (Postfix) with ESMTPS id 4dsLSw4bHhz7s;
	Thu, 15 Jan 2026 11:33:04 +0000 (UTC)
Received: from smtp.soverin.net (smtp.soverin.net [10.10.4.100]) by soverin.net (Postfix) with ESMTPSA id 4dsLSs5JFmzLh;
	Thu, 15 Jan 2026 11:33:01 +0000 (UTC)
Authentication-Results: smtp.soverin.net;
	dkim=pass (2048-bit key; unprotected) header.d=qmon.net header.i=@qmon.net header.a=rsa-sha256 header.s=soverin1 header.b=mHk8G2Ww;
	dkim-atps=neutral
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qmon.net; s=soverin1;
	t=1768476782;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PmY9Mru9bITFj+Kevk4NXj0Z9MCjIEdZQ7uzoSC83Yo=;
	b=mHk8G2WwB6os3ulzh8f7yjqYQqmEdi20aYg1fqoKioq2fdFtPh/6zkQDCsTY0dzZPkqKJp
	bfHBFPzU8hC4g2NswHyL3IRTJYgGKntQX4FynwYxHYzxeJhpcKFQXetc9ybGuvJ8/+QE6K
	/0vLtM7ylzPzSQpGJHiwtO8dPojHdnqJvkoOSAOHtu9xu5n3HmyxZU/WSPR+/XVeAuFCBn
	iZ17BQXFulRsFlKI+DkUC2R8NJrDRmovvogHvpYLPmhkDETXmDjHniQhFcLa7RDz3UAXkO
	Hw//5amJb8xbUF9ngP6vYFaG1cCADmIDdJ2gvg8lLTpDDdu7fuHRsgkG/5oA7g==
X-CMAE-Score: 0
X-CM-Analysis: v=2.4 cv=I7afRMgg c=1 sm=1 tr=0 ts=6968d06e a=vzOQIoBu8N4nb49veeH0EQ==:617 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=P-IC7800AAAA:8 a=VwQbUJbxAAAA:8 a=qmeGYJczOn36ELxD-Y4A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=d3PnA9EDa4IxuAV0gXij:22
X-CM-Envelope: MS4xfIeqP7VKKwbCbhMiBZ2QkpMttS1d87gyEgvlgKYTNr/iYaprpS8Hw7IIhzHDm1SQ/n/OUf6HIb11Kz18k69ptMfkx003lIzMK1pRA45YvINbkrXE6JhM UDeAXbH4vq2rF2PREH4R221+eIl3Raqcd2pLoN4wYy4dcQR5scWknUd4Pla+IjyCNNy4lT+w4/YZLdl9x+PpWCuVsYB3xV9GNphMvxE5GnEi8Me9nk5PWMbp CDhfvGjjnXD/HNr3mx544L99xR8mk2fCIvj8WC7WBoKQDR9srkzDBLMQFx/MtZzd6rbeh3mlLmP0ySSuCMoYFWAM0NqXb3GsxNVFWJ/nOuntBMkqaoBMem2Z t87HrHPwKJWHUZxLUPos3+7hxYJDw67wa0KAZ8L0OhhCmxwl4ldJ+/oUIe99riHBDqtpbz3X3VllhYMp3DN+NKQz5MffoZB53sh+l0vv35pnk/p+IcO57Yh3 F9J3WBC45D7FYT+lX57BW7oOHMgR/59EqeOaT9YzffcaykM6Ee+8dBBS25GWsAfGyzUwhC3irXSDZPKQdQgHtyFaOgb871KciBfotpYKFuRNk43nWsJmtrZF 5iQbCLhMqCAXBoS0o4yfBlyrI4gUm0Q6UR1OPSgXGkLebTrABvKmwhdWJvAX9v4UqPcXqGE1/pM8SJwBSDZMPpxbdzDutj8zqAfrA38e0V9y+vb1eBecC/TB XKF1/g0dC2EOKEuXLr1kMGeH92EK7UtA7yFqY35ZWxWw3QQlsJOPaBz7K0610nfWGVeyZqBp1lwh5YVATtaAYIlpiMG6xFTTUOuWByMQSBsJhKPf+FBDwoz3 O8oee2FSBVY7oCmORzUfjOBSmXiA4Y9lTYrzpNvymvdN61bHyAKNq6QiPbQIgm6nTQp3UId2g89SSgQqDHwSwcdgvYVed644xfgPM4AW
X-Soverin-Id: 019bc16e-2db0-7fac-a44d-3885abf186d6
Message-ID: <465892a7-a422-4380-b139-5fae25a5066a@qmon.net>
Date: Thu, 15 Jan 2026 11:33:01 +0000
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next 1/4] bpf/selftests: move assert macros into a
 dedicated header
To: =?UTF-8?Q?Alexis_Lothor=C3=A9_=28eBPF_Foundation=29?=
 <alexis.lothore@bootlin.com>, Andrii Nakryiko <andrii@kernel.org>,
 Eduard Zingerman <eddyz87@gmail.com>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc: ebpf@linuxfoundation.org,
 Bastien Curutchet <bastien.curutchet@bootlin.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
 linux-kselftest@vger.kernel.org
References: <20260114-bpftool-tests-v1-0-cfab1cc9beaf@bootlin.com>
 <20260114-bpftool-tests-v1-1-cfab1cc9beaf@bootlin.com>
From: Quentin Monnet <qmo@qmon.net>
Content-Language: en-GB
In-Reply-To: <20260114-bpftool-tests-v1-1-cfab1cc9beaf@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spampanel-Class: ham

2026-01-14 09:59 UTC+0100 ~ "Alexis Lothoré (eBPF Foundation)"
<alexis.lothore@bootlin.com>
> The test_progs runner defines a large set of convenient assert macros to
> perform all the tests. Writing a new runner involves rewriting some
> macros if we want some basic testing features like standardized failure
> log.
> 
> Export those assert macros from test_progs into a dedicated header so
> that we can use those in any test_runner. The sole requirement to be
> able to use those macros is to define a test__fail function in the
> runner that will be called whenever an assert fails.
> 
> Signed-off-by: Alexis Lothoré (eBPF Foundation) <alexis.lothore@bootlin.com>


Acked-by: Quentin Monnet <qmo@kernel.org>

