Return-Path: <linux-kselftest+bounces-14346-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 470AB93EA47
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Jul 2024 02:30:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 864F6281670
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Jul 2024 00:30:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF91C1C27;
	Mon, 29 Jul 2024 00:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Moa8aFWW"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 866373236;
	Mon, 29 Jul 2024 00:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722213016; cv=none; b=aBVymoM+E7X0R+nOzNVU+Z2BlfKl/sVFBaOYy5zsIFhbgHZ/nSc8qykDi7D81zg8gQC4VJqYzRoYoyt4cHl97BxwOBUNwGzb7L0JDYoHJaRad6s7rt3OGoZrGs5UUDOmmx+tfPFPjh4U6YtgKA4VRhAmRi6dvD7cEnbK62b47io=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722213016; c=relaxed/simple;
	bh=XYMOpml3C5GDgzl3g6BpnDlx9xx8mV3x43adr2kwVIs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RATlI0LsIo7g9EPVnHCC6mf9WZ1HKL38fhiL9JuFwPFDgJCQM7e6msQedsA07NxghUiYD5kUzj49o/0Nx062LPhogjnyRwclAdj+RoHK2k/gRqJgpk0Wzl8Qx0D6okChMDZ2VnE52Yz40lisXp2W7fjXHII44l3TSYV7orvs3LM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Moa8aFWW; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1fc5296e214so18120255ad.0;
        Sun, 28 Jul 2024 17:30:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722213015; x=1722817815; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Opeic96XTBMCyByaALutlHM6zcHKHgHEzMs2e1m4Lfk=;
        b=Moa8aFWW7jQVRHqirLjRMZjttie6/2dTNLVjTL/P1kIpKe5yNfUJNkeeBzkhS2zxTE
         anU8jjPRKs+U/+cW4UtufsQuGhcTYvKHweZGsfecJhKqL+lyXiUxb7R8kOG56B7hpIp0
         ew8OFTEXXGSHtJaQAupmm2WekkqWABcWloBPSerMor5AlDBrLL92Zu6G5Yvcd0vgpaI5
         tDghpcJZWxzu4/q8LLl0PM86sORH+rns+wCKqm5A23UGEdj8tcnGRhG863ePEq4Y6C7L
         ecBQ5tbEm0XbQ4iFqMhHnRabHfd6T/IO8BUoWCSi88JzvWRUwUlV1mLXa8O11ZThVlcK
         04IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722213015; x=1722817815;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Opeic96XTBMCyByaALutlHM6zcHKHgHEzMs2e1m4Lfk=;
        b=SV4aJGtV/PrmIHnTwX/Ja99GT4Nz34x6ldC0vL3iEm/1mxzeHgT6aXI3UuujelOkgx
         0upW67thrDtmYOIeaOAFIJ36Mg6lyoVXS0ncs9buA7qr9uap2/oKs6b29/Fy3jk5GrPI
         GkFW7wmGbLORBBy3Kp7rvjXdJ+UlwWyCexWUxWEG+AfmIbMEPxV9/jbH/WgNkYB72CE6
         lvAx2sS04IKryIkEC4A/Dfc6XExTQUBktXV6Xja9WqSfwPP8Jotv22Z5kVd3gS7CRi+T
         4jvW3OdjUfa4tQ/YqtrQGpuYewamds3Cx0KxBp5PinpcHyTgIDOhZRXMB8n4IpuY9q4K
         HJUw==
X-Forwarded-Encrypted: i=1; AJvYcCVOXBDTDq8SqC+BfSV/rufcoDTULtkoyy4MsdHpfJK8+N2e9KJ6ACmam48mXWtWDdlO/J+flLRuDwZRbD2AK156rs2Sxmkijb5xwlifI4y6KTJ52bP9Y/Q5T86cvn80nYF0ud/Lyf6b1l0WMw9r
X-Gm-Message-State: AOJu0Yw5xuWV4j49PM3HFIK0olXhWSsvu2d1Fj/gigGbZSF1Rs7cw6QY
	AG2aTIcwCiVmbCDNZJNzJxsgEv0FzcZzTQy31wXEFr2CCS8TITiR
X-Google-Smtp-Source: AGHT+IFTxQ1xdZ0oHDAXAUAqiVZdWgvMYud0INEFpKgWhhBamj0oLm+zG+tRIwOkz238UYUndsFolw==
X-Received: by 2002:a17:903:2a85:b0:1fb:9b91:d7be with SMTP id d9443c01a7336-1ff047dd5d1mr80371945ad.9.1722213014585;
        Sun, 28 Jul 2024 17:30:14 -0700 (PDT)
Received: from arch.. ([2804:1b3:a700:11b8:26ee:9aff:fe39:f350])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fed7fcb33dsm70062395ad.281.2024.07.28.17.30.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Jul 2024 17:30:14 -0700 (PDT)
From: Artur Alves <arturacb@gmail.com>
To: quic_jjohnson@quicinc.com
Cc: akpm@linux-foundation.org,
	andrealmeid@riseup.net,
	arturacb@gmail.com,
	brendan.higgins@linux.dev,
	davidgow@google.com,
	diego.daniel.professional@gmail.com,
	kunit-dev@googlegroups.com,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	n@nfraprado.net,
	rmoar@google.com,
	vinicius@nukelet.com
Subject: Re: [PATCH 1/1] lib/llist_kunit.c: add KUnit tests for llist
Date: Sun, 28 Jul 2024 21:30:07 -0300
Message-ID: <20240729003007.147984-1-arturacb@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <d1a7c02f-2a13-4319-be33-fc7f613b7e8a@quicinc.com>
References: <d1a7c02f-2a13-4319-be33-fc7f613b7e8a@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Jeff,

I was unaware of this commit, I'm going to fix this issue to ensure no
warnings are introduced. 

Now I'm also aware of two patches that reorganize KUnit tests ([1], [2]).
I'll take these into account for the revised version.

Thanks for your reply.

Artur Alves

[1] https://lore.kernel.org/linux-kselftest/20240720181025.work.002-kees@kernel.org/
[2] https://lore.kernel.org/linux-kselftest/20240724201354.make.730-kees@kernel.org/

