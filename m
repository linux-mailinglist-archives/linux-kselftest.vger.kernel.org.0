Return-Path: <linux-kselftest+bounces-5027-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56C0185BD07
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 Feb 2024 14:20:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 86E3A1C21D32
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 Feb 2024 13:20:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC5A86A034;
	Tue, 20 Feb 2024 13:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a9yd/bEW"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CC5069E0E;
	Tue, 20 Feb 2024 13:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708435218; cv=none; b=CJM58faPrVqamDLLfXrmtakZBzSszjH2lmTA0J6rw9yjrZeptd41jxTcXhaBI+5dhQQ8sFkzhE78oTC/H4iK03Vj4dCrHLDmCy5jMUFjtLoX79BHZOKhiML9kxOmYVeSPe/qbddKXcwy5uss16Nb1GdmqjySA6TEt1EoG4myWXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708435218; c=relaxed/simple;
	bh=Fv9dyTtBP1/Lsb3Vbk1dXhdsNHDyoT8aBphxxfwrw5g=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:Subject:MIME-Version:
	 Content-Type; b=VQOOylyAqqPk4715NmhpWS3fCX0lNDKFECuG6J61dSLC4OQj3/134801N39Kxj5glI4Z4HXpKUHQDDrSLwPvbEDyKOwBRf8G1v0OB0zetxqqORiIIGFfQ6zJeOqyoxlgp6ybnpAw1hbs4qU/xeI3J13UVA2yNbE34V5DBDwgDC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a9yd/bEW; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-6da4a923b1bso4547509b3a.2;
        Tue, 20 Feb 2024 05:20:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708435216; x=1709040016; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:in-reply-to
         :message-id:cc:to:from:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Fv9dyTtBP1/Lsb3Vbk1dXhdsNHDyoT8aBphxxfwrw5g=;
        b=a9yd/bEWSl0IuucSu6giuHN/9vZGAxVOUV2GcETb4H48YrJ8VmufF+kxq6JO8VR8ZA
         SnYdJpT+CKTjoaOm1DAyBY6rO+vQicV/33XbZo07qOjZhegZ7IOqcGSDh2tZANOU3s2p
         TeNfeR/PtaP6edtN1sCtxxt8bC4WBSjHJ3CGYGvWXkPh6LfAQrQEuobDorvKJZCdpjOj
         jS9AQ5RjIn8tXZP5jrQQZ9lM4jS9/tMG/SB3/t66JV9sjLtbsk61TFvRcB2vnbIGvY9x
         8jYR05FWwpKTc0qkb3NuMNTclGDjnsoWgssjeKnp4w+2dw6X0ir4Y2T+0/gALXlTMNSy
         Ne6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708435216; x=1709040016;
        h=content-transfer-encoding:mime-version:subject:in-reply-to
         :message-id:cc:to:from:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Fv9dyTtBP1/Lsb3Vbk1dXhdsNHDyoT8aBphxxfwrw5g=;
        b=bnJhuNLUTaOk454y9dl/dFt2Vm6ap4+PMTE/icYYAhdt10VQ2IYUDd8upwvMN1CTNQ
         uq0+PsapWtUuyKyUST/8kFEDuWDVvjaD9IuQwUO/iX4ZrtwLCvuODNSLNGhuKop5QoHI
         46dqH7ErKPq4BUXyg+rehaOsqOVowBmcXmFKjpW7fzwaLADoUXRc+kqcvUNXu52pinyH
         gQdKNmKnYziGLGRNcfjCh5PCYIBjHgXpv0MonY39RMnKVC70Kg2eJg2dtKJaY86omLpB
         GUb9fIvktUMOJGGMUARKVL8TW6meTKp6a4xGllpZPwR6scc8Ts/WrViWcYCea0FbtAuA
         3E3Q==
X-Forwarded-Encrypted: i=1; AJvYcCWDCUtCuCwBnt9dBEHvvr5Nspbo1ry7vo09qE8DyictzDDemdI4y3DO/nYuWLKCDuOZsYBSVEDVr3PaGxc6pXeU18b6CIO9wfMau2s6abdgyh4OLcxqMVkden3LUiWrTfY6L7ignsY+c3V9bd+KBMLdxJB3hmPESZlyIw366APQzZtTOs/VJ6b4WFS34w==
X-Gm-Message-State: AOJu0YznzKyordTamNNfxBdb8MGNHug7pJgzjeGzBPR+S5AXgYQ5q+aQ
	4LUNdiFlzkW4UGBxFQncs+9QqsOHohFe+SQeWWe/uUrlVlZ4UvoU
X-Google-Smtp-Source: AGHT+IEttk5iim0fojrJRidnAlSwPBQzCi5OkRgaS40jpL4zi8P4DwPAw/dTd8vJAIb7P1GvllVmgQ==
X-Received: by 2002:a05:6a00:1b42:b0:6e4:5a01:1b4 with SMTP id o2-20020a056a001b4200b006e45a0101b4mr5402527pfv.8.1708435216508;
        Tue, 20 Feb 2024 05:20:16 -0800 (PST)
Received: from [127.0.0.1] ([106.221.238.187])
        by smtp.gmail.com with ESMTPSA id n12-20020a63ee4c000000b005dc4b562f6csm6515293pgk.3.2024.02.20.05.20.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Feb 2024 05:20:15 -0800 (PST)
Date: Tue, 20 Feb 2024 18:50:09 +0530 (GMT+05:30)
From: Shresth Prasad <shresthprasad7@gmail.com>
To: mpdesouza@suse.com
Cc: jikos@kernel.org, joe.lawrence@redhat.com, jpoimboe@kernel.org,
	linux-kernel-mentees@lists.linuxfoundation.org,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	live-patching@vger.kernel.org, mbenes@suse.cz, pmladek@suse.com,
	shresthprasad7@gmail.com, shuah@kernel.org,
	skhan@linuxfoundation.org, zhangwarden@gmail.com
Message-ID: <6fcd7da4-f7c1-4f2c-9214-70ec77443572@gmail.com>
In-Reply-To: <20240220120024.28694-1-mpdesouza@suse.com>
Subject: Re: [PATCH]     Fix implicit cast warning in test_klp_state.c
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Correlation-ID: <6fcd7da4-f7c1-4f2c-9214-70ec77443572@gmail.com>

>What compiler version and architecture? Are you >compiling using flags like W=1?
>I would advise you to always add more information >about how the problem
>manifests, and what you are executing. This can >help to nail down the issue quicker.

I'll keep that in mind. I'm on an x86_64 system with gcc version 13.2.1 20230801.

I'm using the command `make -j15 -C tools/testing/selftests` with no additional flags.

Regards,
Shresth

