Return-Path: <linux-kselftest+bounces-22142-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AC5B9CFF9D
	for <lists+linux-kselftest@lfdr.de>; Sat, 16 Nov 2024 16:40:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 187B51F22253
	for <lists+linux-kselftest@lfdr.de>; Sat, 16 Nov 2024 15:40:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00D2080C02;
	Sat, 16 Nov 2024 15:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SSsZoKY0"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98EC7144D1A
	for <linux-kselftest@vger.kernel.org>; Sat, 16 Nov 2024 15:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731771637; cv=none; b=f09lo3nyQfOQnXErWN4sFVbDJkr1ZsdtmdYSV7q2FUUyLhVh5SomWbeeawsPX4z86kXeUkSsZyE6luc+6lTDKuNgmjCT4il3wqZmbos+kj7DUG19Lk6lVr9Ri5V1ha5oMhieO0OVJ8Ryd+EPEmFR5Pn0BMH/lbFGBXfZhGd9jws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731771637; c=relaxed/simple;
	bh=Wd+7kLQISUZlzyPvYmSUTVOb8NV4Vyd3OpsFXw6X7a0=;
	h=From:Message-ID:To:Subject:Date:MIME-Version:Content-Type; b=SLtAD9VH/7DtogADUgZ3vVtUvhOpjBIrp5upGrgme18I/mYQnnJNM5xzpVakmXM10XQJIfGxGFTAdDTHt2S03/DRc804cUs+bKy6VKbZiaC/wDMzEaukKgudpXQmdzFbY2rJapbFwfitw7lYaS+HDtL0FwOEpkpmNRU/5u11CWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SSsZoKY0; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-20c7ee8fe6bso28939095ad.2
        for <linux-kselftest@vger.kernel.org>; Sat, 16 Nov 2024 07:40:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731771636; x=1732376436; darn=vger.kernel.org;
        h=mime-version:date:subject:to:reply-to:message-id:from:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XHEOkgJ64rwJ+cv0sVIqPUmbc8l+iTifR7HzGzNced0=;
        b=SSsZoKY08uRq/wLG8l2+t3lDp4HDkIb1C5GO3jzG4C/ZhPGxAnMFDEqsysblF63wgR
         CSGxs3fNheTjtZrqWpy41Dj2wTPiclWy6K9rASyPRQ3BJRSgzyYbkqZP/0DxYSSVqTFd
         4NYITMJcsmB4eZIf75hat7HyxdZuo6wqGtlzrsac4vpoj3RkSpn8PNNDsQyT75ldgeqa
         oYQpLubeads9GTJgP6coYBc28XWzZ5f14+Op4uwvXMKtAPK2Ytxa5EWixDWslkwBIdVD
         YDJQeQkkuVZRjpmJQiAtIc7NbkRxcTO4qrZUdJmIJbe6OM9v+gHWtxnHTcrLD/2pE+60
         Wb0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731771636; x=1732376436;
        h=mime-version:date:subject:to:reply-to:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XHEOkgJ64rwJ+cv0sVIqPUmbc8l+iTifR7HzGzNced0=;
        b=cSOlZRb3Ukz9wWnwyRQgGxxJ0GS3iWFSQoE34yC8n5Na267jJInGwc7Fzf0SOhVjSG
         U5ALIM+3u9rXBz7vfw0NjDKCvZYzGBA0ZUoqDAuzLTOgAUjvkSjgKo2ARRUs338U1+Op
         RniDKvMGw7T0700wb7AwHrjlkBSBBrO7LUqwiA1yjjKOB/AW5T5KMSNSIAwCGbZoo+yL
         FEddSFPxWI/tziJSWOyhqFdheFxN7iLjn+XWY6EP6JZveN70txFp/PIvCnLsvAEM3vtP
         h1d98oaM1dyfflf6rHE0YFxNyKinVcqwwILdsnsIaMoxvSyx4eaTwOU0e9Nv84eo8D4D
         RCTQ==
X-Gm-Message-State: AOJu0YxyCGGpQaBWcKmVwrUOJko+DAu2QVdY85Z6LO9pIYdObIWgeV2h
	w1U3nZQ8BJ6rf233bAna8PrT4vWz3S8VwZxytA6OiY2AwUZ3YQqCVzSOZg==
X-Google-Smtp-Source: AGHT+IFMHkt7dg+HDmSVGlcJNSS3pNyogVigWInnmPjWaolcpTbctPZIQYYghiK1qaXO5M1Fz2z1NQ==
X-Received: by 2002:a17:902:f54d:b0:20c:d5c5:4039 with SMTP id d9443c01a7336-211d0d62196mr76304975ad.10.1731771635641;
        Sat, 16 Nov 2024 07:40:35 -0800 (PST)
Received: from [103.67.163.162] ([103.67.163.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-211d0f56de1sm28930535ad.262.2024.11.16.07.40.34
        for <linux-kselftest@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 16 Nov 2024 07:40:35 -0800 (PST)
From: "Van. HR" <skirotuh@gmail.com>
X-Google-Original-From: "Van. HR" <infodesk@information.com>
Message-ID: <a56e712e53bbde3a6279c41d19f98dc9ba177904b36fc316b73c32be6a0f89f4@mx.google.com>
Reply-To: dirofdptvancollin@gmail.com
To: linux-kselftest@vger.kernel.org
Subject: Nov:16:24
Date: Sat, 16 Nov 2024 10:40:32 -0500
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii

Hello,
I am a private investment consultant representing the interest of a multinational  conglomerate that wishes to place funds into a trust management portfolio.

Please indicate your interest for additional information.

Regards,

Van Collin.


