Return-Path: <linux-kselftest+bounces-26430-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58B88A318EF
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Feb 2025 23:41:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 32D357A4490
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Feb 2025 22:40:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A0ED26A0CF;
	Tue, 11 Feb 2025 22:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EnLAzDRc"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44FBD26A0CD;
	Tue, 11 Feb 2025 22:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739313528; cv=none; b=a0F3J/lD1bnBUFX69opfMSr99PBDnHVAe07mTYh3o09HGRlWY/+TnNEYKuDXEwskBb2IwbE98hejfhMBv9hYUnVJuf8lnumKNiH5zGJOPfCfBeOjagEeKEJoTJrG6qalYfjBLGZIxZoSC+Vro9baQGpytbexSgDa9ijAaWSOChQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739313528; c=relaxed/simple;
	bh=rB7BxSHW6EtSoabTXOHtfnbpaHJ0cVwUdAN/POuDev0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XYRVZd8kp6XIYi++l56sC53zebUU5EkYcr1eV6o65THYGVrwlFp3ggEMJhytr8uSbu1lcpI50zQPtFC0LcNKXlKnj/i2DOAkGtiLLEyDl8YXKoqd98hfEU/RKQLMfioTPtEas9tL44SE22Mt5h1WMAvKnv/TNF+hv/fyMAf4pR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EnLAzDRc; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-46fa734a0b8so54883131cf.1;
        Tue, 11 Feb 2025 14:38:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739313526; x=1739918326; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YmBWEKaqUFBzqHGnnve5ouXXEJaAw0Livsmfx5tApoU=;
        b=EnLAzDRcdIxrLVXkxOphkNCvJNc3RSIqgPL6ec5UFUHTECZE2h+ctWDjSNxlMTka5F
         NwxhUImVY83+lm0VZgxyQ/rLty7OVUhpxBfvVL2bhGC3wenzRl6Nm0ts+3BZTNSSre2M
         y9du3GFZNd3oniIfRxaBZcyLkZfeWPO7+yXbZqG8mebmJbbi/hK1vEXVhArBllsNZUUT
         8Z0fhvMVKkul85L/2xFK4zZbIq7nRK8ZT9dtZCj47URAJNHQzTrw7mEHM53orvD5AG+l
         v2zYytdihxPUj0XJ6bXW+WOx849MpNaSIM46eebAD7kyfg74881FjSKvrGPzKXa44GLU
         PD8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739313526; x=1739918326;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YmBWEKaqUFBzqHGnnve5ouXXEJaAw0Livsmfx5tApoU=;
        b=Wnh0TTQZ6sm+Pd0flz8gjQKH090IVPimIjp9H1Zxl4Hs2RwAsFEjXX1fGKFffpW6BN
         YMjU15E+JH+cfrU2GG5AdBdBvfkbdEZ4n33BNWgYuVMGD/uYWPEFrZQJYNrKkMIWjt4D
         g7k3Z8YN+KOXMK7wWQQvMXLXKhUPBrmwx8CT95GcmwQNchhZPwYGiEZltwGgL5dGi8cG
         egKH+eq9qv9+j/f778835QCxE4856Lp9By8zU32bRagHTuUbGbapJjRqlLaeFu4GR7AV
         cG1KgtRpnOldRYowm8mxRFpPfKIA3FvOfmdh71XkdFRtLQUeiZCYLjONCV6ZXua9Q1Tf
         bD3Q==
X-Forwarded-Encrypted: i=1; AJvYcCWP9JzD88YRVI1IrXDYfYnP/sGmByoWBk7UJRBrxuxWThqw79rjeS/0PAfyTOMXyQUlJB6OLw6ZCGtxQ2fkzJ6t@vger.kernel.org, AJvYcCXRFk9yCg3S6og4oeUD6CFMRrINctT/4wiKszkfPMluXZ5q96j8QL9DGvmEuBbJRxPMvocGfkBItvrc7Qo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwAi/H8h9SWMiAev9T8dLu1J1wQ0NPqJCcmk3hC4TFToXHnNiMW
	eKgiCCzSzwohMVHnT0FpYwTTKl0YtQ6TIEkyRAmw0/jt1wBR2ZLk
X-Gm-Gg: ASbGncsjIZQZmDRAjKzZ/wEbOGq2cAm8BEMJWVKHs6EhGkl5gwvFCvrvK0d+bI1qHQ5
	CKC6x/tyPulpeioYxk9e2HdHpGGUp8Up0GS5IU6HDe5bJNM6T/px/C5PDv9b/Gzk7NsTQRZICMZ
	7gkQwQLuKVnt3bKgiAwgEBa4+4Y3qQuOzgVAvUMVBF32z3ldqO2sz/B37Jz4Cq3P8lfKzKLVFlD
	TQ0gXTJyodFtGSlwaS57WyQ6yf24hl7OetONdmu6xem/e5XcpTa2tre98el/iB+MVrMEz91/W6T
	Y69fl4eAgNrmYUrerADlXjFce62lLT9ue+d3hh82KJopibUwW/Z6+p+5eGTComO5rYXzfaOEq3y
	lUmdCJw==
X-Google-Smtp-Source: AGHT+IEO9AyXzekNhsd8EdtjWApnNbjJdg5zmAFdkNj4BVJjZli/lTN21xPpUXmaP+8WJPWp5aYc3Q==
X-Received: by 2002:a05:622a:5c7:b0:467:8217:aae3 with SMTP id d75a77b69052e-471b070d34emr8123011cf.47.1739313526095;
        Tue, 11 Feb 2025 14:38:46 -0800 (PST)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e44e550783sm51208976d6.86.2025.02.11.14.38.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Feb 2025 14:38:45 -0800 (PST)
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfauth.phl.internal (Postfix) with ESMTP id 24AC1120006A;
	Tue, 11 Feb 2025 17:38:45 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Tue, 11 Feb 2025 17:38:45 -0500
X-ME-Sender: <xms:ddGrZ-7nz1pK_q1szOpi7W3KVQfGB-XsCxtvYKKHSFCUYYnRHFOyAQ>
    <xme:ddGrZ36wQ_AtIwyIEnrzPz9MTqCxGb1HYPIQBXW-9CQ0-HeLOyWL3Jr0oYh4_Wk8-
    KKepFtQkcS5Nh2ELg>
X-ME-Received: <xmr:ddGrZ9ex6wzy9h4GEuXb4Ji6kfd6in0yO8ApFAYVyRCsSp9VB3QMJ5oYwzg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdegvddvfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpeeuohhquhhnucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilh
    drtghomheqnecuggftrfgrthhtvghrnhephedugfduffffteeutddvheeuveelvdfhleel
    ieevtdeguefhgeeuveeiudffiedvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepsghoqhhunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghl
    ihhthidqieelvdeghedtieegqddujeejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepgh
    hmrghilhdrtghomhesfhhigihmvgdrnhgrmhgvpdhnsggprhgtphhtthhopeduiedpmhho
    uggvpehsmhhtphhouhhtpdhrtghpthhtohepthgrmhhirhgusehgmhgrihhlrdgtohhmpd
    hrtghpthhtohepuggrvhhiughgohifsehgohhoghhlvgdrtghomhdprhgtphhtthhopehp
    vghtvghriiesihhnfhhrrgguvggrugdrohhrghdprhgtphhtthhopehmihhnghhosehrvg
    guhhgrthdrtghomhdprhgtphhtthhopeifihhllheskhgvrhhnvghlrdhorhhgpdhrtghp
    thhtoheplhhonhhgmhgrnhesrhgvughhrghtrdgtohhmpdhrtghpthhtoheprghkphhmse
    hlihhnuhigqdhfohhunhgurghtihhonhdrohhrghdprhgtphhtthhopehshhhurghhsehk
    vghrnhgvlhdrohhrghdprhgtphhtthhopehnrghthhgrnheskhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:ddGrZ7JOOesaVFaui5eNoxq2f3auchwWtsWyE8m66QHx71LpWfYXuQ>
    <xmx:ddGrZyIydsiH7cRzEnKiS0iDVYY7mNhrlOBMcYSFPj6QZ8Nb625riA>
    <xmx:ddGrZ8yAnL9Y1Zxsi6NCcrSk0iHRiQjGbpNH7bQ-TWVsFvnmqdzh7w>
    <xmx:ddGrZ2KwB0gJlijq0EF6JOpuOYid2afthp6lzK_V_SKL7O9MEprt6w>
    <xmx:ddGrZ5byxjJ6W8bf1lypP9hPFBx7z2Cn6VnXABb2jNt_YIezVqI3F1g5>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 11 Feb 2025 17:38:44 -0500 (EST)
Date: Tue, 11 Feb 2025 14:37:21 -0800
From: Boqun Feng <boqun.feng@gmail.com>
To: Tamir Duberstein <tamird@gmail.com>
Cc: David Gow <davidgow@google.com>, Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
	Waiman Long <longman@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Shuah Khan <shuah@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH] ww_mutex: convert self-test to KUnit
Message-ID: <Z6vRIZk7DsSNooFZ@boqun-archlinux>
References: <20250210-ww_mutex-kunit-convert-v1-1-972f0201f71e@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250210-ww_mutex-kunit-convert-v1-1-972f0201f71e@gmail.com>

Hi Tamir,

On Mon, Feb 10, 2025 at 10:59:12AM -0500, Tamir Duberstein wrote:
> Convert this unit test to a KUnit test.
> 

I would like to know the pros and cons between kunit tests and
kselftests, maybe someone Cced can answer that? It'll be good to put
these in the commit log as well.

Regards,
Boqun

> Signed-off-by: Tamir Duberstein <tamird@gmail.com>
> ---
> I tested this using:
> $ tools/testing/kunit/kunit.py run --arch arm64 --make_options LLVM=1 ww_mutex
> 
> On success:
> ; [12:48:16] ================== ww_mutex (5 subtests) ===================
> ; [12:48:16] ======================= test_mutex  ========================
> ; [12:48:16] [PASSED] flags=0
> ; [12:48:16] [PASSED] flags=1
> ; [12:48:16] [PASSED] flags=2
> ; [12:48:16] [PASSED] flags=3
> ; [12:48:16] [PASSED] flags=4
> ; [12:48:17] [PASSED] flags=5
> ; [12:48:17] [PASSED] flags=6
> ; [12:48:17] [PASSED] flags=7
> ; [12:48:17] =================== [PASSED] test_mutex ====================
> ; [12:48:17] ========================= test_aa  =========================
> ; [12:48:17] [PASSED] lock
> ; [12:48:17] [PASSED] trylock
> ; [12:48:17] ===================== [PASSED] test_aa =====================
> ; [12:48:17] ======================== test_abba  ========================
> ; [12:48:17] [PASSED] trylock=0,resolve=0
> ; [12:48:17] [PASSED] trylock=1,resolve=1
> ; [12:48:17] [PASSED] trylock=0,resolve=0
> ; [12:48:17] [PASSED] trylock=1,resolve=1
> ; [12:48:17] ==================== [PASSED] test_abba ====================
> ; [12:48:17] ======================= test_cycle  ========================
> ; [12:48:17] [PASSED] nthreads=2
> ; [12:48:17] =================== [PASSED] test_cycle ====================
> ; [12:48:21] ========================= stress  ==========================
> ; [12:48:21] [PASSED] nlocks=16,nthreads_per_cpu=2,flags=1
> ; [12:48:23] [PASSED] nlocks=16,nthreads_per_cpu=2,flags=2
> ; [12:48:23] [PASSED] nlocks=2046,nthreads_per_cpu=3,flags=7
> ; [12:48:23] ===================== [PASSED] stress ======================
> ; [12:48:23] ==================== [PASSED] ww_mutex =====================
> ; [12:48:23] ============================================================
> ; [12:48:23] Testing complete. Ran 18 tests: passed: 18
> 
> On failure:
> ---
[...]

