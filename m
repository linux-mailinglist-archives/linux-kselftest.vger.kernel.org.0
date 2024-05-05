Return-Path: <linux-kselftest+bounces-9496-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AE41F8BC4A4
	for <lists+linux-kselftest@lfdr.de>; Mon,  6 May 2024 00:51:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 619771F2152B
	for <lists+linux-kselftest@lfdr.de>; Sun,  5 May 2024 22:51:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 562AB13FD95;
	Sun,  5 May 2024 22:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KedS7YTF"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 175D7136E20;
	Sun,  5 May 2024 22:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714949474; cv=none; b=EqWQxmEBIb+m4TblwWw/3xoM1CDZknf5qGGGw7B7nyBgf1/sXwtHBPX/wq9rQls03O+/1wcFKQQ4b1JAlfreVUSKlw+JmkJ/fEmFZ++xhcCZ+JqWDJq/QoQBqu/FxOYAMaHoQniXHSQPAkAv9M+Tn9KYyo8NskhP7bQTSIIzeEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714949474; c=relaxed/simple;
	bh=PpREyaeRW9fmGEqzkui6H4Fz+fZHr5048DsvwArMj34=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FV5XC2nALJ0cAxryKaAGSKahN9KEYXZSTEQiw+JDQrcUwxOZU5Zvgpnx6d1Zd3wq/n3L3qLNzHFNiw2Okls/0v84xj/okSmnSK+7U/J8aHfhgv/Wc2Jt8LanRWCvyGxTPVjiU58z/sNIsEpCFQEI6A5lYkmISe3wzMe1VD+iLBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KedS7YTF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C62A2C113CC;
	Sun,  5 May 2024 22:51:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714949473;
	bh=PpREyaeRW9fmGEqzkui6H4Fz+fZHr5048DsvwArMj34=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=KedS7YTFPShms2EW5vmctbeblHwEm1MRr50DJxSpBbw7O09IJeOBzr9lnJ8SxFh6r
	 B5CNYYMnX1pXknonOt9+TLwLc/R7z1auYvCwf8/defzhp2/XSKMQFrHCjzjstic0Vw
	 ZAWnnzTGW6be8MSe98YnsUG3/AEaxZDgzihz5+yVS7l1CBP5jIpsHYjYDGNcXALan+
	 NAQ1bfwOYHD2vFUPtZ3SwYe00jj0dNBjxawq1RrOtiNFvPIhNMxSfvbnavPt+VNUFd
	 Ev8A04hMMTgpFS57QddgG39j+ofgsXTLzU8aKzdmUVUIl5cMUyh3HEO9samEhRDfvQ
	 CdMVOG6MNry1w==
Message-ID: <e5c1d2c6-932c-4d25-8a71-bd8b13402ffd@kernel.org>
Date: Sun, 5 May 2024 23:51:07 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH] bpftool, selftests/hid/bpf: fix 29 clang warnings
To: John Hubbard <jhubbard@nvidia.com>, Shuah Khan <shuah@kernel.org>
Cc: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>,
 Justin Stitt <justinstitt@google.com>,
 Peter Hutterer <peter.hutterer@who-t.net>,
 Jason Gerecke <jason.gerecke@wacom.com>,
 Joshua Dickens <joshua@joshua-dickens.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, bpf@vger.kernel.org,
 linux-input@vger.kernel.org, Valentin Obst <kernel@valentinobst.de>,
 linux-kselftest@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
 llvm@lists.linux.dev
References: <20240505215636.63592-1-jhubbard@nvidia.com>
 <4f947691-bf25-460b-bc08-da29de3fdaa6@kernel.org>
 <c0a8ffa7-0609-4904-961c-3f4357c53237@nvidia.com>
From: Quentin Monnet <qmo@kernel.org>
Content-Language: en-GB
In-Reply-To: <c0a8ffa7-0609-4904-961c-3f4357c53237@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 05/05/2024 23:48, John Hubbard wrote:
> On 5/5/24 3:36 PM, Quentin Monnet wrote:
>> On 05/05/2024 22:56, John Hubbard wrote:
> ...
>> Thanks! If possible, I'd rather keep the warning enabled, and fix the
>> command line instead. Looking at the error and the Makefile, we may not
>> need the -lLLVM<version> in the CFLAGS at all, but only in $(LIBS). On
>> my setup, I can build successfully, without the warnings, with the
>> following patch:
>>
>> ------
>> diff --git a/tools/bpf/bpftool/Makefile b/tools/bpf/bpftool/Makefile
>> index b67454b45a49..dfa4f1bebbb3 100644
>> --- a/tools/bpf/bpftool/Makefile
>> +++ b/tools/bpf/bpftool/Makefile
>> @@ -147,7 +147,7 @@ ifeq ($(feature-llvm),1)
>>     # If LLVM is available, use it for JIT disassembly
>>     CFLAGS  += -DHAVE_LLVM_SUPPORT
>>     LLVM_CONFIG_LIB_COMPONENTS := mcdisassembler all-targets
>> -  CFLAGS  += $(shell $(LLVM_CONFIG) --cflags --libs
>> $(LLVM_CONFIG_LIB_COMPONENTS))
>> +  CFLAGS  += $(shell $(LLVM_CONFIG) --cflags)
>>     LIBS    += $(shell $(LLVM_CONFIG) --libs
>> $(LLVM_CONFIG_LIB_COMPONENTS))
>>     ifeq ($(shell $(LLVM_CONFIG) --shared-mode),static)
>>       LIBS += $(shell $(LLVM_CONFIG) --system-libs
>> $(LLVM_CONFIG_LIB_COMPONENTS))
>> ------
>>
>> Could you please check whether that works on your side, too?
>>
> 
> Yes, that works, and of course that's much better. Please let me
> know if you prefer me to post a v2 with that, or if you plan
> on sending it yourself?
Please go ahead!
Quentin

