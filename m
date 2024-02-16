Return-Path: <linux-kselftest+bounces-4868-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FF9385827B
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Feb 2024 17:31:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3AF80281D13
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Feb 2024 16:31:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A63AD130ADB;
	Fri, 16 Feb 2024 16:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f48dtKdO"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC9151EA7A;
	Fri, 16 Feb 2024 16:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708101079; cv=none; b=tQ17h1dvegVbctUzf0Q8DzJcKrr8+g+85Psp32NUKxUbVvqnvq9gNhCwhDI/G93mZnGdKS9YeMKyndzEAL6NboFTckr7691JjWGMTVCIQTTITMOattH1AidivsebhVGUo9cyogC48QNUz3Ch3keKv4up2/+WwwtbneHR26gFs1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708101079; c=relaxed/simple;
	bh=mvhUG7Rm1RzkETXGdubqawFc+pot5tVe+dKejiOX1AQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Dvq1zsmJCG7GeKSPAVRhnPY6+Gd0V+PN94BUFtqshDiflPolNLgcIvGpuaQGnOKair472pZ+bXiNCGauUXTvuMwUe9uE9Hen+3+LGNr41uKFIHwZeC8ybOQiwexXIDRlFrQK2Ui1DJ8hbFlgoL43vU0M8QkvEaRfH0vR/2pCPA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f48dtKdO; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2d21a68dd3bso9146431fa.1;
        Fri, 16 Feb 2024 08:31:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708101076; x=1708705876; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KKqRhlwnpPAoRAORBxhCFRSOC3qB0pNS/W30w/sCAcg=;
        b=f48dtKdORptG0klWY3yvxHEdwmbe55DgI308r/1mWunyRY6wALuUZcbzCpZ7+eO9Dv
         LhaytTnSjFGu4VVpHYmHlY7es2Dhz3kA5wMxoUtG9MxXNYFyfQPRTeETs5dMs29oZOqz
         iXnn0dAGAfrmklPENam1VxtSPyiNQFhbJPPr/yXRE3VRwvjJ3oAVx1MKeFoKrPxfsH5k
         BfMyEvtjUmu7x42D05DIDhBj4WC0G+9zt8wynh6mR6kbPggXmSOts7TG3xD09++yMmXN
         a/UMr8UePR75bGa/9cCkNe1bRFneh93rLszZjNEs40bXWsChgnoXYRD7kwDqs7zvLBy3
         Oqfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708101076; x=1708705876;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KKqRhlwnpPAoRAORBxhCFRSOC3qB0pNS/W30w/sCAcg=;
        b=mEGBX2Q/9eS4f8BaUWTMbURfEy+qKbsfN4UAjBXIqNvTXz5vYCyUZsZiODFP0oB14P
         xX9xYxM0c5gW4NgnJ5PzGzpt657zGS4DWgIpXIeR0lyca40Fm38Nv/N2Vm1XdAJRlgYc
         fTbwxT4gPmCZbJhqypmyUkK67bVQTzefIkN0zlLuONWBsy0klAv8LWnU/FiORPyGWoDU
         S50Ob8X98KnL7sa2nLtmCCSJDbjiU/uUw3w2Nulnki39rndr4/Ro1XTvWDuhKt609WsM
         XM59wu8WT0gJb6/4LzrGr7pNVL5QyOahwlj7cvtaxkxOwSUk4tl39HfzHe7AWilsPmsw
         LkXw==
X-Forwarded-Encrypted: i=1; AJvYcCXqd5lH8t+wRIybSUBjSB73kju4ggE+BI8hl+oO9wAmbg2IHwWMEJKRUA1dkgp5zC5DqfZZQiV3URwY4qyKnxmjRjNyW+O2Qbq9d4s8RKnZGjx0IPA8LEDDBtaw5BTCWTfTDGy+qQijsfCUZl9VFSGh3JoonYzvwkJOENLwveCuImC16gyL9fhzMDI/g7bljit4+RNY0ldc7gFmzm3g9rVtBLE+
X-Gm-Message-State: AOJu0YxD3efHIpBT3XQnXZWu91mM3R8Q6nlAGbpHLUy48hwJuilVf7FS
	IBI6fX53thKaZUmnBz5ikhqdEpfO8NU7b5bNsN8/MVD+uEmdqZA=
X-Google-Smtp-Source: AGHT+IF6Kx06xVo5O1YNA5lW9q32aL7kZEmHkTDV9jC0bLqcybt/Vrx991QKEa3fLPejtmQqakNnkA==
X-Received: by 2002:a2e:8813:0:b0:2d0:e45c:5650 with SMTP id x19-20020a2e8813000000b002d0e45c5650mr4166062ljh.11.1708101075709;
        Fri, 16 Feb 2024 08:31:15 -0800 (PST)
Received: from p183 ([46.53.252.171])
        by smtp.gmail.com with ESMTPSA id m41-20020a05600c3b2900b0041076fc2a61sm2893051wms.5.2024.02.16.08.31.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Feb 2024 08:31:14 -0800 (PST)
Date: Fri, 16 Feb 2024 19:31:12 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Elizabeth Figura <zfigura@codeweavers.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>,
	linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
	=?utf-8?B?QW5kcsOp?= Almeida <andrealmeid@igalia.com>,
	Wolfram Sang <wsa@kernel.org>,
	Arkadiusz Hiler <ahiler@codeweavers.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Andy Lutomirski <luto@kernel.org>,
	Elizabeth Figura <zfigura@codeweavers.com>,
	linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 00/31] NT synchronization primitive driver
Message-ID: <5ae668e3-e275-40b0-af3c-6a459e3a0b87@p183>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

> drivers/misc/ntsync.c                         | 1146 ++++++++++++++

Assuming this doesn't go into futex(2) or some other existing code...

Can you start putting all of this into top-level "windows" directory?
I suspect there will be more Windows stuff in the future.

So those who don't care about Windows can turn off just one config option
(CONFIG_WINDOWS) and be done with it.

Name it "Linux Subsystem for Windows" for 146% better memes.

