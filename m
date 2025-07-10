Return-Path: <linux-kselftest+bounces-36956-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11121B00092
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Jul 2025 13:29:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF356179A5F
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Jul 2025 11:29:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C93C42E7183;
	Thu, 10 Jul 2025 11:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P08AaATd"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C8042E54DC;
	Thu, 10 Jul 2025 11:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752146982; cv=none; b=QYNk7mKq21zZ8kz+FOaLMZY2Sm5VayX3GOPsF2/8/Se84+auBsxmdkErs13VA/R6CPUfYy1XesySQs+7rB4rm2FwLRXc4DhDAl+imHKPTsIcPITi0HpD4PwuUX5IDnwKujLGw7dUINJ6DD7MrGAhCyR8bKvz0RTCEP9hyXjcALo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752146982; c=relaxed/simple;
	bh=1wRUfKLHMLJ/xThNbPZABu1cA92Qh9NzVsJ/HIX/17w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nUljW3tpowNiQnLeMnIlsphj2q9dT15z6BgSTmkuVGmOp5PuUXV0Zljgr4TXN+gjJe+umYiBBwmnojrvsmIkkgUz1W9pAMCxSJzsBD+vmBCjHD5pLNc9UME+AM9QqmAu03guGez4ViKaxgBIQyk33IIimBYT7+vYXVPZVCze62I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P08AaATd; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-74b56b1d301so547608b3a.1;
        Thu, 10 Jul 2025 04:29:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752146980; x=1752751780; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1wRUfKLHMLJ/xThNbPZABu1cA92Qh9NzVsJ/HIX/17w=;
        b=P08AaATdMjsAqrLAyX8VRw5Pamj3/z9qdsKa/kkgXscM5ryYBtxgspYpAW9CYGWo21
         VfqPdBbSXM94OpO/qaKAAFUa7U8UFxRWjPwx5M8Zr/zMOJGMjFOx8JYN/WMqdqbVMueR
         ONf+ZnYyCunsqJ3yru2lJbmr23lUBNq3uvdCALjAlRWvrBZBeXvnOxLNP3Uz3cjMgVWq
         C/RKvcNVxn+TMK9wSFCxqKi7D9bkmqMsA+TpiJ0UdLPb7OCrQZ6Go6Xz1yYaMedFDeqt
         aT9FxFUqUKXDpSV406twHGG+NuraaW9rZZ6lj9410yuJ//xlBY/leG6yy1sljGAJOKXi
         86pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752146980; x=1752751780;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1wRUfKLHMLJ/xThNbPZABu1cA92Qh9NzVsJ/HIX/17w=;
        b=OSrTP9+JeAisMV1wVUuXOI2elxdSYEOz1/5A7+LwMH7Q5q/oSvlD6kjKjd44IdjAHs
         3XHHJnmnQ94CsKWonAwHdzz803cdBVg81TWMUQNZajtzBqt/T+54JR42T+ahpXDghtA9
         kP8Rit6VcLvh/h+oZPbJ3HsDopMtjjvYneRzvdPqTeh+ujCOXwuRl1HeLS4zzFQ6t/0t
         X7XunePki30SXP9yN79yqgrFi1GbhxrvvvIjd/m+Yp57OV1WL9uksNo+RXftCh1FlHC/
         8RzWo3rdOeh43MlcavbiJA+BZnwfMdDH4rTcfa+9RCvVwJJQRN5hGX6hCmwPI30fTUY0
         zE4w==
X-Forwarded-Encrypted: i=1; AJvYcCUXKaaP3R7S4aEfR6fCrnzkO/m+5Q6kDFFSq5Dfc1pmlPf/JXJZLkqryVbBzExFF2PiLP/NqeCgY2PkcsQ=@vger.kernel.org, AJvYcCVlbxDcgm1dilfDvVOLvJSy83Nr1ipltUIcx5dyGPrCjAK1DW7NRp/A2gYmlZkx9QU8aMdt4I7smbHy7EzBKpqd@vger.kernel.org
X-Gm-Message-State: AOJu0YzOulsvO6V5IKch00gznJDwDcjclxWRwjl4V6NJivxVCSfyu/oY
	OqOcmcYfUZCvV4qNdxZlm70nmfbBVcUnxoygt7V3XKfqQoSEcfqh4Rpz
X-Gm-Gg: ASbGncuQCzYDcgpwu7sh0xMLFHmhNk+NGOHBzmukGBvaTcLem8b7aJfS+gfaI+/+iYG
	39PrsCDn+cAMxZqWrXhye5a7pofbloEzybuQ1scAMZW6Hg5jD7xemmRvGvYQKQniC4x6kGL/b7O
	4H8Af26ULkxMAFRUp2GOMweNZYfkwEXcytC9PsCF3AL3SYc8Zu3QhFoeN/QfckLZWYef0zna+h4
	GsMpfskhQoSeez68vsWkJmjY3dvXEWFhmOkc5jBOKJNil7clunPld7QzHcqsKAvkitoC6W5JT/H
	MQIkP1k5PxPKwNtoHnahZrRhlqmH1YPRAaPHq1YwCuYAfqpSy5jbO563ornOX8KtbvB2mwDdx37
	y+m4fnEwfa0qj
X-Google-Smtp-Source: AGHT+IFxV6gpgXR4PTTjJdDViWyN/3ClUAf7M7XUCAc2HAa7pFkG9CEcToebbqq8Fzny54N1yfBPEQ==
X-Received: by 2002:a05:6a00:2e9e:b0:742:aecc:c472 with SMTP id d2e1a72fcca58-74eb8e854bamr3513500b3a.2.1752146980485;
        Thu, 10 Jul 2025 04:29:40 -0700 (PDT)
Received: from DESKTOP-GIED850.localdomain ([114.247.113.178])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74eb9f99d37sm1901629b3a.178.2025.07.10.04.29.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jul 2025 04:29:40 -0700 (PDT)
From: wang lian <lianux.mm@gmail.com>
To: lorenzo.stoakes@oracle.com
Cc: Liam.Howlett@oracle.com,
	akpm@linux-foundation.org,
	brauner@kernel.org,
	david@redhat.com,
	gkwang@linx-info.com,
	jannh@google.com,
	lianux.mm@gmail.com,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org,
	p1ucky0923@gmail.com,
	ryncsn@gmail.com,
	sj@kernel.org,
	vbabka@suse.cz,
	zijing.zhang@proton.me,
	ziy@nvidia.com
Subject: Re: [PATCH v3] selftests/mm: add process_madvise() tests
Date: Thu, 10 Jul 2025 19:29:25 +0800
Message-ID: <20250710112925.60437-1-lianux.mm@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <9aa51324-10b7-4bd0-9d83-5722d1ea0628@lucifer.local>
References: <9aa51324-10b7-4bd0-9d83-5722d1ea0628@lucifer.local>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Lorenzo,

On <Date of Lorenzo's email>, Lorenzo Stoakes wrote:
> Hi Wang,
>
> Please try to include the context of what you're replying to in your
> messages, reading the above I have to _just remember_ what Zi said, and I'm
> old so that's hard now ;)
>
> Please note that mm tests _must_ work without make headers_install being
> run.
>
> Your test must not rely upon those.

Thank you for the clear feedback and for pointing out these important rules.

You're absolutely right about including the context in my replies. My
apologies for the inconvenience this caused. SeongJae Park recently
recommended `hackmail` to me, and I am learning to use it to format
my emails correctly for the mailing list. I will be sure to get this
right going forward.


As this is one of my first contributions, your patience and clear
guidance, along with the help from everyone on the list, have been
incredibly encouraging. I have learned a great deal through this
process, and it has genuinely deepened my passion for this work.

Thanks again for all your help.

Best regards,
Wang Lian

