Return-Path: <linux-kselftest+bounces-32362-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0167EAA95D5
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 May 2025 16:28:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8246E178805
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 May 2025 14:28:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0640925A349;
	Mon,  5 May 2025 14:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="FAEmofIC"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AB6B2522B1
	for <linux-kselftest@vger.kernel.org>; Mon,  5 May 2025 14:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746455282; cv=none; b=pnF4Wkvu1b0E8e66zd4jWxeY+/FMVzT6ezaRvj1Uml7iNlPFT6s/sq7+r4VUURru8Hv+iIsaVDTv0BGjpp+SrCJJ9+HuqC4L9bcOpGBPxksfjrV9hv1Fyq1EovtUhQV2GVkC626F2XhnYviRHH4MKf1vWxSw/dR6wjQauIvQTqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746455282; c=relaxed/simple;
	bh=8bG+q9cvIxNRKMt+IdST9BOBQGsJ4SSG4cIoMmhVp70=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UhMlJacUF852ywzAE032KTizsiSa0s+/xNWnSXUfKwm3NkH5+COgEE8hu7gksYKrSw09oU464dF4GyEeRKm4LCGiyAJ+iaWwbAbUqy3BhFG+gFdMtz0bOGnwpW9nJSdrHcaIIPI2sVjrgTlCNw8QVFwxyRT3KsNw49FTXHCVt1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=FAEmofIC; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5faaddb09feso3634743a12.2
        for <linux-kselftest@vger.kernel.org>; Mon, 05 May 2025 07:27:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1746455278; x=1747060078; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VBzMpH2jBdczGJAGi07riCizg5SErgbDrt1biXSYE6I=;
        b=FAEmofIC0oMM+HqGX1QdwjAskqxFoWHqsDymqlRLBS/KhXeZxE+mwWfJq29JUleahh
         vKT2odpe77T24da5PV0EMgZ19hC2eRe4ZrMkJVRQRz0eIKE20NtNaupb7t2dlnTladb6
         4mHbjKw5IN4P2WzraDyaCPW1q3P+ecfzDwBrl6jMs7w3fpy/jYI+5rBEE66Agxn9GF77
         g4Y8NWq5b6bnb9NlFU8Pc/my94E230XqMhM79g5fUvX3TSlwsiVK2ibWES8kafcBxZG4
         tnLTBER/EMzZktt84zMYVCpiHMTBHreMBiFItt1ZWyOn+8aGousocxWBWePautMA2OGz
         bc2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746455278; x=1747060078;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VBzMpH2jBdczGJAGi07riCizg5SErgbDrt1biXSYE6I=;
        b=f/MkdbQjVKv5v0nx4mK0UAbC1+qpj1S0fLX52Vq8emAoapc4rrPmL/NxV/cXR4SSJs
         keLGAIokN+qY0OUPvcwr6+JTWYjYGzU+7ejEd9lEEuM4TFLV8/9W3Xg61x6gUaIxjDRN
         XpSwSw4XWNotVbVMY1OQlQohLNcdJ5kBabIfaDouT9/gx3t89wfYLuksqt3FPFh0fD5w
         bxPAqEpP8wZ/ugMOPgQhFcryZ7S+QSduMGR+XdzFmFwenvc1B/szdrycAFUqe2jFqdz0
         hJfc1Ih93pFeX0OVaCA442hgx9EB2i0a7Xk5JFkt3e2OTpI9tX+PVcjyq5tDw0CUMwdp
         q9iQ==
X-Forwarded-Encrypted: i=1; AJvYcCXXkdCAdv/iQkmRKHMJ2yRhwgGZXA8G+ZKuEeVu/Ynof4e1Z/a+ehjwYTGIoSKM28dKq+VDN1Pe/81JupBDs3c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzr7WvU52T6axA5PY1rNbhLrNrA60GIFyMJuJBRMQ6q4gLnQ99D
	qOp7/1IVIDysuaqja2a6Yodge4yc+OQFf62G1vtP7I5rxsZPhM7fnaEntSpsrU0=
X-Gm-Gg: ASbGncvNxQRgf9CoWJjcqyXExEzMaUjXN5Zd1IEWqoOrluBqr701IZIlbRqV6UMf9qW
	swcJacyhtEisoOkRnQ4T41FTwSpq7RUHNODggXYZOdPAITqr5Yw1lLrPgI360S+HAHQLoPlj/UK
	QAiyTJ0UfMIElJN2YK5lGkBgl/2R/TuipgGU5Xdui8prHwGs1Lz72XPqN8+l0XLeeALPxi2AQ1v
	Zb/iZ8DZA/SKUxEImGHXCX48yJSVaWYZ41QU3t5x9jnUZpog5ZoU0HkxT0TBrPvPh610U2EQLFM
	0Ng/Jw96wPkBt+8Dfgo7dz42pGUgDJ0aCv6wNwR3bzdu+PJBZTW5WA==
X-Google-Smtp-Source: AGHT+IExfE0hcX78gw0nn1iPLAnLmMN0HdxWQnnSN8VNB89rL2yQ8NHWy4t+WCuJ1B8DNVSnVHuwAg==
X-Received: by 2002:a17:906:c115:b0:ad0:c6ae:c0c9 with SMTP id a640c23a62f3a-ad1a4ab7f0dmr731420066b.40.1746455277537;
        Mon, 05 May 2025 07:27:57 -0700 (PDT)
Received: from [10.100.51.48] ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ad1891a1f2dsm498974566b.40.2025.05.05.07.27.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 May 2025 07:27:57 -0700 (PDT)
Message-ID: <68e762ec-d320-4077-b321-63eefefe6d7d@suse.com>
Date: Mon, 5 May 2025 16:27:54 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 22/25] module: Remove outdated comment about text_size
To: Valentin Schneider <vschneid@redhat.com>
Cc: linux-kernel@vger.kernel.org, virtualization@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, loongarch@lists.linux.dev,
 linux-riscv@lists.infradead.org, linux-perf-users@vger.kernel.org,
 kvm@vger.kernel.org, linux-arch@vger.kernel.org,
 linux-modules@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 rcu@vger.kernel.org, linux-hardening@vger.kernel.org,
 linux-kselftest@vger.kernel.org, bpf@vger.kernel.org,
 Juri Lelli <juri.lelli@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 Yair Podemsky <ypodemsk@redhat.com>, Josh Poimboeuf <jpoimboe@kernel.org>,
 Daniel Wagner <dwagner@suse.de>, Petr Tesarik <ptesarik@suse.com>,
 Nicolas Saenz Julienne <nsaenz@amazon.com>,
 Frederic Weisbecker <frederic@kernel.org>,
 "Paul E. McKenney" <paulmck@kernel.org>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 Sean Christopherson <seanjc@google.com>, Juergen Gross <jgross@suse.com>,
 Ajay Kaher <ajay.kaher@broadcom.com>,
 Alexey Makhalov <alexey.amakhalov@broadcom.com>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, Russell King
 <linux@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will@kernel.org>, Huacai Chen <chenhuacai@kernel.org>,
 WANG Xuerui <kernel@xen0n.name>, Paul Walmsley <paul.walmsley@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Alexandre Ghiti <alex@ghiti.fr>, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
 Peter Zijlstra <peterz@infradead.org>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>,
 "Liang, Kan" <kan.liang@linux.intel.com>,
 Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Arnd Bergmann <arnd@arndb.de>,
 Jason Baron <jbaron@akamai.com>, Steven Rostedt <rostedt@goodmis.org>,
 Ard Biesheuvel <ardb@kernel.org>, Luis Chamberlain <mcgrof@kernel.org>,
 Petr Pavlu <petr.pavlu@suse.com>, Sami Tolvanen <samitolvanen@google.com>,
 Daniel Gomez <da.gomez@samsung.com>, Naveen N Rao <naveen@kernel.org>,
 Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
 "David S. Miller" <davem@davemloft.net>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
 Joel Fernandes <joel@joelfernandes.org>,
 Josh Triplett <josh@joshtriplett.org>, Boqun Feng <boqun.feng@gmail.com>,
 Uladzislau Rezki <urezki@gmail.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Lai Jiangshan <jiangshanlai@gmail.com>, Zqiang <qiang.zhang1211@gmail.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>, Ben Segall
 <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
 Kees Cook <kees@kernel.org>, Shuah Khan <shuah@kernel.org>,
 Masahiro Yamada <masahiroy@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 Miguel Ojeda <ojeda@kernel.org>, "Mike Rapoport (Microsoft)"
 <rppt@kernel.org>, Rong Xu <xur@google.com>,
 Rafael Aquini <aquini@redhat.com>, Song Liu <song@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, Dan Carpenter
 <dan.carpenter@linaro.org>, Brian Gerst <brgerst@gmail.com>,
 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
 Benjamin Berg <benjamin.berg@intel.com>,
 Vishal Annapurve <vannapurve@google.com>,
 Randy Dunlap <rdunlap@infradead.org>, John Stultz <jstultz@google.com>,
 Tiezhu Yang <yangtiezhu@loongson.cn>
References: <20250429113242.998312-1-vschneid@redhat.com>
 <20250429113242.998312-23-vschneid@redhat.com>
Content-Language: en-US
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <20250429113242.998312-23-vschneid@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/29/25 13:32, Valentin Schneider wrote:
> The text_size bit referred to by the comment has been removed as of commit
> 
>   ac3b43283923 ("module: replace module_layout with module_memory")
> 
> and is thus no longer relevant. Remove it and comment about the contents of
> the masks array instead.
> 
> Signed-off-by: Valentin Schneider <vschneid@redhat.com>

This comment cleanup is independent of the rest of the series. I've
picked it separately on modules-next.

-- 
Thanks,
Petr

