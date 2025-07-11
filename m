Return-Path: <linux-kselftest+bounces-37080-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4FB9B01A66
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Jul 2025 13:16:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 89BA18E1776
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Jul 2025 11:15:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8750288C06;
	Fri, 11 Jul 2025 11:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UlPE5HCR"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6501628725E;
	Fri, 11 Jul 2025 11:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752232572; cv=none; b=k11bs2GFsR41+admRyFDpLuv8Sh7E2UpRzMZUI6Q6TNc/9Dy06O4Vg4nmYOwyrfLzIAf9DlpmTT6jrH10mG/PjGPc4qfDAQbxxcCD3HoHTgk/tQ/vTvSpPf2BHaO5v1WG0AP2Lm46L6tIlxBAkMuBODUVA5sdYv7BADshi6xGu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752232572; c=relaxed/simple;
	bh=tKZWQ2ZRPovut+Z2ikqFrEbpitEJd+NXnose16iDOdM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hovvbkItkZorSy9bBS49dvfMRrilEFxoG6yknE3Kt+cY+G+5VXekMSmTl8n5BqaWdEkyso6J9dXWKUQvT0+cFyTv3HKYkh5R5ofyDLu1zCOHdE5V8GyQFX1tj1+g4DbBDEbFNfadp+LcsFTAVDtQ9JPrxK1cqTDKmgTgD0pUTEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UlPE5HCR; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-b2c4331c50eso2092496a12.3;
        Fri, 11 Jul 2025 04:16:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752232571; x=1752837371; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BOujZ1TBTtbU8PPw3UDfxP7MnvO42++mvjjyH+W4bWI=;
        b=UlPE5HCRm9MGB/ftQtukxym3maZF5YL08MDVfZM2FlpEoeXUi8dPNf/U1OUD4db+kz
         mWHpNKJcB6aIgnBCCoyCpwwgTV0Z+U7VkGVp+GkjT6Im2L+808Zt/pi6kBd0kzrwrDfq
         tsGOYXteiN2HIJYX7rn5EcGUiMT4MHf9SsQNTrR49zzJmuYLUQ+fTtiXtQl9uaBs/xAr
         4C3k7QDEFRm+FW4gWiH0Apd7KXxJzoZKyFVG7z9PA09wXj8kW+ayh9F+5pTHjmrr7kel
         IYhZujTtvjRM0H5DctY7Gmc6/GK0eqmoj04JbRAtgF8+4jrfsLjZ1bkGdKNCWTk1RdJi
         /ZLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752232571; x=1752837371;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BOujZ1TBTtbU8PPw3UDfxP7MnvO42++mvjjyH+W4bWI=;
        b=ENbHaKWCwO259BAoIAGLLeybjJB0cnQgNQ61bKdFzYVCLKmqHrZiTrIlBdsXayZEf8
         3dLb/MjrIo9WBZjAJ7mf8KVvypE2Ruy85miZCTSHs7kdK2Yz2oyIJ4C8vVlyXEiR7itz
         FzOzo5wD0zY6/26Y9fp8jl0CfHeoQpJnRxtnOnfu6SW9JTGyK0QCZEaXdjni/02MXCD3
         ITbFcNRhbT9D8FMl45Yev5DeNCJ2Uo4VYzq4juTV13aoBsKDKMmM1V5ODUl83I8uvKn6
         MUKcDIt+FsQWVFbtvAvRz92CISAeIdVGRooxbwqwfHmmf3jWl26HQall1MydGadsnT2g
         0pvw==
X-Forwarded-Encrypted: i=1; AJvYcCUeNKB1znf2HuY+1rX545+TH6PZmGeZEF1RO1V3jsJS3J1n7tKGLu0b0G4CQvihIPedBr+3hPXdbA6/kbnrkB8K@vger.kernel.org, AJvYcCWMgZ7z+lPPWOM4HmUeoNJFJdvCVgxaUwTfm9zM8aKw5tnF4Gi81df7coy47RkH2I9OKB796j8SeDVs7d4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzzgwHUVaiapSp/a08Xt1PD+1p5n5MI97K44mrsn3NYW6i9CKnK
	z5dyfjxYUVID3FtlPohcOO1uYeaE1423sH7NGFftMRu1f4GgX3Wc4YmA
X-Gm-Gg: ASbGncugWTlb0cT3jX6lsgOb25tnD3xQFF/GdizDlY+1K31jEPdKkAwWgQ3lE/p4Cy0
	6GV35F8Bgd9SLB9XFz4b1sGwhdXAumseXGPy19+/451YU93mKGilc88pPtIFGRxSy8pC65SqqjS
	33LmcoC36zUtfeAtZNxm6OmCfj3ojbKsSHfKpEDOtc4BwEXzitWwTIm/7jIcfKMHegkqpFlBaCZ
	jYheN8PDrqB9lEAFqzIw/FwFcotF8gHWd8fsk42+tIFKWA0Sq1uRjmL9eIQmJdU/uIrPQHzjnff
	6vq4uNa2578r6boNhKJcB+DdH6O/ZVSrZpJwWgKe9YoYz8CJcqfDGq5e5MMN8/AeTWzL+5mrywq
	RLHiJQL41ha14ERzpSIbmQJApIIE7i/jYYyqYhDpz5BwQ
X-Google-Smtp-Source: AGHT+IEIQG7QEB6ft6cUjxp2hKorQ78Cb8O+7jrU7uXwwdEDusnirPFcWyMCbcvxbZFzM8Ph5R1kJQ==
X-Received: by 2002:a17:90a:f945:b0:313:d79d:87eb with SMTP id 98e67ed59e1d1-31c4cdb9f31mr4056051a91.35.1752232570365;
        Fri, 11 Jul 2025 04:16:10 -0700 (PDT)
Received: from DESKTOP-GIED850.localdomain ([114.247.113.178])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31c3e972298sm5133942a91.11.2025.07.11.04.16.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Jul 2025 04:16:09 -0700 (PDT)
From: wang lian <lianux.mm@gmail.com>
To: lorenzo.stoakes@oracle.com
Cc: Liam.Howlett@oracle.com,
	akpm@linux-foundation.org,
	brauner@kernel.org,
	broonie@kernel.org,
	david@redhat.com,
	gkwang@linx-info.com,
	jannh@google.com,
	lianux.mm@gmail.com,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org,
	p1ucky0923@gmail.com,
	ryncsn@gmail.com,
	shuah@kernel.org,
	sj@kernel.org,
	vbabka@suse.cz,
	zijing.zhang@proton.me,
	ziy@nvidia.com
Subject: Re: [PATCH v4] selftests/mm: add process_madvise() tests
Date: Fri, 11 Jul 2025 19:16:00 +0800
Message-ID: <20250711111600.3989-1-lianux.mm@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <81f9a104-6d7d-4552-851e-8690d4a1b723@lucifer.local>
References: <81f9a104-6d7d-4552-851e-8690d4a1b723@lucifer.local>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Lorenzo Stoakes,

>> + *
>> + * This test deterministically validates process_madvise() with MADV_COLLAPSE
>> + * on a remote process, other advices are difficult to verify reliably.
>> + *
>> + * The test verifies that a memory region in a child process, initially
>> + * backed by small pages, can be collapsed into a Transparent Huge Page by a
>> + * request from the parent. The result is verified by parsing the child's
>> + * /proc/<pid>/smaps file.
>> + */

> This is clever and you've put a lot of effort in, but this just seems
> absolutely prone to flaking and you're essentially testing something that's
> highly automated.

> I think you're also going way outside of the realms of testing
> process_madvise() and are getting into testing essentially MADV_COLLAPSE
> here.

> We have to try to keep the test specific to what it is you're testing -
> which is process_madvise() itself.

> So for me, and I realise you've put a ton of work into this and I'm really
> sorry to say it, I think you should drop this specific test.

> For me simply testing the remote MADV_DONTNEED is enough.

My motivation for this complex test came from the need to verify that
the process_madvise operation was actually successful. Without checking
the outcome, the test would only validate that the syscall returns the
correct number of bytes, not that the advice truly took effect on the
target process's memory.

For remote calls, process_madvise is intentionally limited to
non-destructive advice: MADV_COLD, MADV_PAGEOUT, MADV_WILLNEED,
and MADV_COLLAPSE. However, verifying the effects of COLD, PAGEOUT,
and WILLNEED is very difficult to do reliably in a selftest. This left
MADV_COLLAPSE as what seemed to be the only verifiable option.

But, as you correctly pointed out, MADV_COLLAPSE is too dependent on
the system's THP state and prone to races with khugepaged. This is the
very issue I tried to work around in v4 after the v3 test failures. 
So I think this test is necessary. 
As for your other opinions, I completely agree.



Best regards,
Wang Lian

