Return-Path: <linux-kselftest+bounces-43757-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6204EBFC062
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 Oct 2025 15:09:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6EC1C188AB38
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 Oct 2025 13:05:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F003355805;
	Wed, 22 Oct 2025 12:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BGF9O2Ow"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B4C234B185
	for <linux-kselftest@vger.kernel.org>; Wed, 22 Oct 2025 12:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761137766; cv=none; b=okt2WZP6noRDD0qsuNRjbhh9QN9UDaRAqMPhwnlmFNSahb2LAVjnk9XUTKIfgI1f7HJC/fyWh6ZiRasOkH6cPwwtRcGjWpt9K1dojo9q6nLR6kuITW7B9WB4Xcm9B3OB1eBw7fXOyIkPh4V18K07u6gKYx+6XTbTGFvrVJJaitE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761137766; c=relaxed/simple;
	bh=55Djqf35I/K3RxxLzdcQP6qMdW/uYAdfSQFf+LthStU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kwMkuwmgCkZpYkltDJl7fA3e+FYexBWQ7gIF076ePYGJSJI7TldRlWYCNDGg1Oc0AMSxLE9nljGRK/5QqPc//cbVRGsiegCr51G/oVR9fRBSRTLcw4XL+azBKViMLpK31G0OYp7SqZdUvWZQltkXyBGPIivQpwEPJut2DqtrcfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BGF9O2Ow; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-290ac2ef203so68045525ad.1
        for <linux-kselftest@vger.kernel.org>; Wed, 22 Oct 2025 05:56:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761137765; x=1761742565; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=55Djqf35I/K3RxxLzdcQP6qMdW/uYAdfSQFf+LthStU=;
        b=BGF9O2OwETToO33KLhtkS4GfP1axe7S3jilxDDoEbVe5mh1qiMKOedeftrQgdl/qKK
         4KULqF7CSImOTz8PjMH7joKKyO1lkQnZM6dzAnIBX/H54V0c5FfYCq7F8pO53cvVSzWZ
         k+ZH+MUzc/w5zftoKuM4FCm1w3Wgu3/eslyrv8ihLV/Gvm6iQ0NMI9dDf+iNcQnUlYhf
         WiREEhy2cB+Hnt/dqS9qmrna+q9to2jjn8X7kNjUeBcsAu2vBaIAXozsoIHVnCClhL2R
         oAV+NuNIsQ1pP6kgei0r30PnzVyYElvCD51w6vOLHCKRH90eWUKV9lE8FzXe8p6GaH81
         nHkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761137765; x=1761742565;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=55Djqf35I/K3RxxLzdcQP6qMdW/uYAdfSQFf+LthStU=;
        b=DaImSaDgfjIGbC8aMg/cd8bXtcBBy3iTmO+bxii7mIblufg9Fl6gv0kl6XJKFdJpmE
         MDCi3kEa6fRtxqQuEcsB7V5efw/ZUZNV1WzwCYzps+Y8itlqgxi8B/1KQEzPMJvJeYn3
         H0h0bhM4uy3mKBkQW4oWk7BBnX43liJm4uv69S/nBEMah/Kv7+UKvKuSBSRDMNHHL5MZ
         XYbF9NspPktRhqQJh63hFkgVq3fiXPYdCB7JGxDS3rKoDH8LJqOz7mgw1JWXzeqqNLDA
         iFMfpdR6jgd+qMLSp3pTJ0Q1ylgPH5oGkXl0xtB0FKZnoT71IdVUGQeDXUzkDmTlUol0
         3O5g==
X-Forwarded-Encrypted: i=1; AJvYcCVZZ9arn+XKgXBXurt5IW75IZa0L2x1ad+3rPtCxjaKqVtfedJr8l7AIeqmTQITgFqjqP3borSH/Oh4Wqy05sg=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywx78kRQp1EcEk5ODIqhrBZ/piJTDqK6D7kpS7fNqsmefxNZeqD
	cCjGtPw2EkWoj+NmBjsL7LkfpAP9Zq+TX7zxQ/lSSZCGkMsWmnX3a5k8
X-Gm-Gg: ASbGncvWp3sEHnyYuduNLhPobCQR1mH03NRqBYDHftQjFqqX+uMwV3aTFhyXryDXFOR
	iglK7pvBkQkZFb238hWmcS51eHtyMqArIH89l4pV70z3Ism3ZzphJEAycOIHnpRNKgaA/kaydNS
	AjxyLy7kJnOfILOMn7K4k9aU+KP+5XJS/tRXJvPJOGFITNlwHs+S+x2kUkZzI5Y7AExmTLrBDl/
	BeBTRlqrBSpxmijSUIe5H7kF82uj/9Hvq2+ZkAGqwmHwCnVJSfG+NbmteFTJgtcs0+XTO0AFBfs
	PYvseAbuQzOzhnqV8E+ub4R7Bhxfr4I4UiGG7vbQkYbKqq5KeAcGDYxRXZkYemODBYUn6EmsPlb
	wPYmkbiCTAMEIWa+qvgNSjUcztmD1/MCYl1JUTpGUfcDqVGos256c0ekrvbOeINRwSqNFs+sOLe
	oS7/6Vg4irsIgW7Q==
X-Google-Smtp-Source: AGHT+IFAbriApVOx8o8gcjpfk2lo+t2/yibaJf5nwAMFzyuHbx4XWsOEML5CUbO64FfcWtaVnEq9gQ==
X-Received: by 2002:a17:902:f78f:b0:290:af0e:1183 with SMTP id d9443c01a7336-290cb65c5e7mr213748355ad.51.1761137764590;
        Wed, 22 Oct 2025 05:56:04 -0700 (PDT)
Received: from [172.20.10.5] ([117.20.154.125])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29247218eafsm137558455ad.101.2025.10.22.05.55.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Oct 2025 05:56:03 -0700 (PDT)
Message-ID: <8764fe64-d896-460e-8e0c-cd81667c57b9@gmail.com>
Date: Wed, 22 Oct 2025 20:55:55 +0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v1 1/2] bpf: Add kfuncs for detecting execution
 context
To: Jiayuan Chen <jiayuan.chen@linux.dev>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman
 <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <20251022113412.352307-1-jiayuan.chen@linux.dev>
 <20251022113412.352307-2-jiayuan.chen@linux.dev>
Content-Language: en-US
From: Leon Hwang <hffilwlqm@gmail.com>
In-Reply-To: <20251022113412.352307-2-jiayuan.chen@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2025/10/22 19:33, Jiayuan Chen wrote:
> This path introduces several kfuncs to help BPF programs determine their
> current execution context. When hooking functions for statistics, we often
> need to use current->comm to get the process name.
>
> However, these hooked functions can be called from either process context
> or interrupt context. When called from interrupt context, the current we
> obtain may refer to the process that was interrupted, which may not be
> what we need.
>
> These new kfuncs expose APIs that allow users to determine the actual
> execution context.

Hi Jiayuan,

Rather than introducing multiple kfuncs to determine the current
execution context, this can already be achieved by using the
'bpf_this_cpu_ptr()' helper to read the underlying preemption count.

Please refer to my earlier patch,
"selftests/bpf: Introduce experimental bpf_in_interrupt()"[1], which
demonstrates this approach.

Links:
[1] https://lore.kernel.org/bpf/20250903140438.59517-1-leon.hwang@linux.dev/

Thanks,
Leon

[...]

