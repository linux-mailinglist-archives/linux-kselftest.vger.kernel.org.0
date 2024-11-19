Return-Path: <linux-kselftest+bounces-22243-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 237CF9D21DB
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Nov 2024 09:51:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A6734B20F82
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Nov 2024 08:51:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A45A19ABC2;
	Tue, 19 Nov 2024 08:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="AISlr6bO"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89061146D53;
	Tue, 19 Nov 2024 08:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732006289; cv=none; b=VL6qk4oIw1+st6XmD87A0yFQFu65VOYl9UhK3DvR6ZKTuVMy19s1OsfoOEJmLiHW2gfdju3MNrUh9hWibkB3C0PtnsYYEDT9zLCswP4RyU+2AnydE2pbHe4dBbnWjCY8uQG62i52hYjFxKchVvcaVWPghu88fPZ5Y0m+PLItw90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732006289; c=relaxed/simple;
	bh=l0JlU4N1Mp/ygwpUsFE+wAmibFF+9Rk/z0z+Gm9myP4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=duXl7E2zgkCZr4sp3UQvD2ZM0u0/A4nGeNiAH0oWmJ6EvaDJ2w/NQiaTaao2JJ2GSksevtoudPDjfIZY1FZVi0xgwjExIi2Vy8Qx8A9WWCmnxu7r4zp1Ke5Ci0Drouau3LrCjlCnRP3ZcMXErEH7x4UzJcnf7fbdruwPkHuq3EU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=AISlr6bO; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id B828C2000F;
	Tue, 19 Nov 2024 08:51:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1732006284;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IcqVflbFpKhSDailGV7ecVaIw/F8cjue8PM1p8I8xY4=;
	b=AISlr6bOZ8FTntG92ihdfR9TQpkWXCazabdxizWZk4/tBFC0RGrNrHOle1+FjLPwAltAf6
	wNJ9GP7xjnx8HlT5zcByGu3AgqAYW+U12eZlZrDMRRR/o6aRGu2o+6AT6anUoWlOErN7Is
	2terff+zTLsszjNkInitggare/WqUrfWNposN4LI/7HyxNtlLCNYqd8OOAMEMwWDS+s7k0
	ELCmdmbtr9z0Sm6PeuLMhKQvEdd8ri9a5Qf1On9bEWMHgWpSMh19IfJrXz9FY9gRPw1ds7
	XFlKMSylXtwKHJcADXbgtCzlweFnVd4arcHFBVeleWrbfMkgh/zKjZze4sV8kA==
Message-ID: <024d3079-a553-4525-90af-2aa82ad3ac85@bootlin.com>
Date: Tue, 19 Nov 2024 09:51:22 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v2 10/13] selftests/bpf: rename pseudo headers
 checksum computation
To: Stanislav Fomichev <stfomichev@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman
 <eddyz87@gmail.com>, Mykola Lysenko <mykolal@fb.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>,
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Jesper Dangaard Brouer <hawk@kernel.org>, ebpf@linuxfoundation.org,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Bastien Curutchet <bastien.curutchet@bootlin.com>, bpf@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org
References: <20241114-flow_dissector-v2-0-ee4a3be3de65@bootlin.com>
 <20241114-flow_dissector-v2-10-ee4a3be3de65@bootlin.com>
 <ZzdpxDYzwDDu5W6x@mini-arch>
Content-Language: en-US
From: =?UTF-8?Q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
In-Reply-To: <ZzdpxDYzwDDu5W6x@mini-arch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-Sasl: alexis.lothore@bootlin.com

On 11/15/24 16:33, Stanislav Fomichev wrote:
> On 11/14, Alexis Lothoré (eBPF Foundation) wrote:
>> network_helpers.h provides helpers to compute checksum for pseudo
>> headers but no helpers to compute the global checksums.
>>
>> Before adding those, rename the pseudo header checksum helper to clarify
>> their role.
> 
> Same here: let's keep the old names? They are matching the ones we
> have on the kernel side so it's easy to find them. I do agree that
> the naming is unfortunate :-( If you prefer, maybe clarify with
> a doc?

Yeah, I did not really get the meaning of "magic" here, but ok, let's keep the
original name to keep it synced with the kernel functions. I'll replace the
rename with some doc.


-- 
Alexis Lothoré, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

