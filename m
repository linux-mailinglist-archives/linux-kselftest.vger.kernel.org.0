Return-Path: <linux-kselftest+bounces-35626-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 121B6AE46F6
	for <lists+linux-kselftest@lfdr.de>; Mon, 23 Jun 2025 16:37:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9AA56189B22D
	for <lists+linux-kselftest@lfdr.de>; Mon, 23 Jun 2025 14:37:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39F7B2609F6;
	Mon, 23 Jun 2025 14:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KtxwNz9O"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCCEB2609F5;
	Mon, 23 Jun 2025 14:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750689429; cv=none; b=pQQs2fDGbiwevb59xfFgq/LEQUAgLZdHI7Ucr4g4tAF7+D9yjaPDrFzK87RIOhcR+vTtwHZaGqJtb8r8gMKpetxg/9YfHpwDRQIBzqPh0XY9Zjm4v/9o00CT8O3FHeE73vPxkpxcRISXAxKHfuSbsRbzZ/+ep0oBXfxj0SWMG3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750689429; c=relaxed/simple;
	bh=p+1bES6nhRGhhOuo5sW+tTVPZcikBMLlGMM4HW5rSZg=;
	h=From:Content-Type:Mime-Version:Subject:Message-Id:Date:Cc:To; b=kRLd6yWh4HDDFgVvpoATSnFnvbRUE2y/TLCKnPAT9lRUuhK3763GZ1IFohZzUKqEgvC0oUAGAIvVfCMQXW/vO0hMrYTiA2GXGkKcEz6NhZdVzeaZBAQsNzb7UnuCRd0IQxI5FO8gnI2qKu2/PAPRwX/LmgSnvS0budrzg3nA7po=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KtxwNz9O; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-b0db0b6a677so3854462a12.2;
        Mon, 23 Jun 2025 07:37:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750689427; x=1751294227; darn=vger.kernel.org;
        h=to:cc:date:message-id:subject:mime-version
         :content-transfer-encoding:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=p+1bES6nhRGhhOuo5sW+tTVPZcikBMLlGMM4HW5rSZg=;
        b=KtxwNz9OxYJwfhNVlZS8E+Yx+XG31lyW2hI24Hz6mOjOnomYrHWxjQSLx/x8nt/TPO
         uUiH24f1SoQABFUQ3QzYkrsmjiJWs3K5RPnxFl19FNSmRP9pF3cm3YdyaVzdYYx+Q5Be
         CyYLgd8ySuY6u5XGMF6/9MecLTjLBH2dRbxEUCML2mx3WO7Kup5bkFQMzIOu0N3UuivX
         1bC0L4OylYorXuxazDYGLsD8qp7de2FhNhYXa9ftoAIUBWqhDNFle+J/YUSMKIFyv0h+
         dbWznZ/TVwl1GCydEtPYbmVsdri8FvsZAn0ydz/2VieWMkcpdVqtpjj0mceA+OAKyLAd
         MmhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750689427; x=1751294227;
        h=to:cc:date:message-id:subject:mime-version
         :content-transfer-encoding:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p+1bES6nhRGhhOuo5sW+tTVPZcikBMLlGMM4HW5rSZg=;
        b=gBaFABI9VQZgIOZimNZQd0QpQLHAhdhuUzW/8ca/m1pppkLeE74HLaLAduSHeATTq7
         r1kHyc8MkT70Pn92uL87XhiY2uToYpLD3FqOR/NfDsFd97NvHF2JQUKvFw/iCpKHkVf5
         54rIKADJwr6GRAb/SwsDAsyqwQ00mwgy0dZh4ATETWbdWj3gLsKd+HN6xPkRxvbVPCrP
         S1YclWICNuozaRbGxWlgrjPV+nCsSV3pKqS/pgEvabVMjBWUcD9tpZz7do00CQknzwS6
         EMBrIDcSgREGTnF53KpH8hAAr9QFOsHktFRWFg9HsjQ1JsJpI6JqxvZJz+G2EPaAz5LQ
         MjxQ==
X-Forwarded-Encrypted: i=1; AJvYcCUtE8Fq9HZ06BWDsxJUkvAqK6eKzGaV6j899GjwV33mNjUX8gCA6qDKAtcfWtyd1QnyDjRPP55Fw2/psofKiyCq@vger.kernel.org, AJvYcCVEhGTYrLnsEAXMsNk7TtH2xwF5SxZoLL9qcFRJ7haGVXUE9XdBkN+FyxBxqGGRH53ML2PF/YbIJk+KDic=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywho/qqmNUv5k/ZGh3c7ogdgNjDNbE9+YV08J6P5HdR9KJUTWs8
	a2xFneR6QwnMhf3KIZLqo7KITHyZF8gJq7k/KariYqqo9p4uzt0ynLB/Wo7nVA==
X-Gm-Gg: ASbGncv+fACjjubxqxHv1Cm8pzSUz605Zl8lg3x6sV/gRl+UphIqnjkmoeAbPbXC7E0
	CAMElIyx1w3tPMoEGU28oaPyxWrsiyj+i+lb2Jv40rKhf70TDjCB5q2P2DGJJuy6FnKfZEA6gii
	oz2lZAnTMRcTaqkg420cKgvhrFVDzaBEf9lrRxS5KtoeHMX6JIW+Q1CBnJmjNx8bSz1Oij7oCiT
	LQBx/SOjLNctkShLXeLkJCkaach40Td7F0djmVFBSZ2/OnG2FV2Gian1IpuEBJNmtih+a3FIdPq
	Yf69wzUD2Ri6YFOeoqvPrrLhxqI84UfHfR0HFOF2LgPEbTCX/1I=
X-Google-Smtp-Source: AGHT+IEFIwaSsjd67G3I/WciFQe4N9hlk4t21lDGsXMt8J9b5wUDC7qKQCwFG8vFYkuM6aLBnGiltA==
X-Received: by 2002:a17:90b:278e:b0:314:2939:efdc with SMTP id 98e67ed59e1d1-3159d63629fmr21191481a91.13.1750689427065;
        Mon, 23 Jun 2025 07:37:07 -0700 (PDT)
Received: from smtpclient.apple ([2402:1f00:8001:567::103])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3159e07d222sm8109508a91.45.2025.06.23.07.37.01
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Jun 2025 07:37:06 -0700 (PDT)
From: wang lian <lianux.mm@gmail.com>
Content-Type: text/plain;
	charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.600.51.1.1\))
Subject: Re: [PATCH] selftests/mm: add test for (BATCH_PROCESS)MADV_DONTNEED
Message-Id: <6CC829BF-E6B3-4115-9256-11248BB39F51@gmail.com>
Date: Mon, 23 Jun 2025 22:36:48 +0800
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
 shuah@kernel.org,
 sj@kernel.org,
 vbabka@suse.cz,
 zijing.zhang@proton.me
To: lorenzo.stoakes@oracle.com
X-Mailer: Apple Mail (2.3826.600.51.1.1)

I deeply appreciate for your criticism. This is my first patch and I =
will improve it based on what we have discussed so far.=

