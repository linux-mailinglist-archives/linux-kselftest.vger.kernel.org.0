Return-Path: <linux-kselftest+bounces-41180-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70511B51DF7
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Sep 2025 18:40:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 615E27A3E0A
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Sep 2025 16:38:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33C8B274B5A;
	Wed, 10 Sep 2025 16:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="RHS/O7Wp"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-il1-f169.google.com (mail-il1-f169.google.com [209.85.166.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 817502727E6
	for <linux-kselftest@vger.kernel.org>; Wed, 10 Sep 2025 16:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757522391; cv=none; b=biqvD46OcOSm6xEnaFjS4iK6lpResxH2+R5U5lavZKYOe4iF3JL7XNNMtaJlvLdbG9xm+KLptsHzkgmiaBsCyLuc2QbQ09w7VySWEeU2Lj9uSIcNdncMOOh8FyT9avdhOjWk75TqeH898oOgztDa2CB+CFN9FkCekweT3fkKkyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757522391; c=relaxed/simple;
	bh=hbjFWc/M1u0JtUeGDfraCyEfZ1LuYrMt6ic+SN3g7Vs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uC0kTn7hAiOBCNFJxAz/DFed6tMby0/lriP/1ZW7j7aidBe5AhLJNtAOmHAH+pR5ntEwlnCPt/GIUKmXHXv2V6pntGc5HZiWzhh9XndUYhmxgVhqcJRpFn7tWw4VydrOo7DC3lMZBGEKnS+ZfRj5LE2L79jvekCWXVAdYDUczbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=RHS/O7Wp; arc=none smtp.client-ip=209.85.166.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-il1-f169.google.com with SMTP id e9e14a558f8ab-40ab48f3924so28764105ab.3
        for <linux-kselftest@vger.kernel.org>; Wed, 10 Sep 2025 09:39:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1757522387; x=1758127187; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/+f5haOvY7V5aJLRvqMe+OKgyMJap2D1kg9AHRnXBFo=;
        b=RHS/O7WpW2bKu3dkD3GuvUB5YTGA6gb7LyRfu04M+JBfGeQSuhkT/9v/nk/R+dCoyX
         mZsi1sKflT/XdZwHcNBieE1AylK3Qix8qUwrzhYZBj750TLxjVeOdcOWZXYvcj2GenBj
         MSoClkJ/PsF+80kRfPRItEj7Tm8QePGqSzJ+QsmXJFA9doy+ahyquicL0MG8caYp2OlB
         12byJ3aQN9mNWsdieeNi/AazOX86gv6oqRz8IP9rkgCUTTxmZp3BM2oUxPZN3vW0lahe
         xvDFzSbVRTFzXeitmxBk2z2OUGa+MHihFvw3YurqqUNqs94s3BNYsz99KAOAQOFDWNFA
         OV0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757522387; x=1758127187;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/+f5haOvY7V5aJLRvqMe+OKgyMJap2D1kg9AHRnXBFo=;
        b=wTdMvATiiuagX1WoS78OfkwmiBkkmLiPL8ggHlwWTDdfBkgy7nL0lr9902JHb08bis
         XrYoncNjGcxNNOTvlmomLONyuR5L/DoE94H+dukis5HaGvbYaqcsG94YVha/xSveJnAk
         +eIHWgVlC5l7txSBQzvgb1ZUooijo8CEn3Eha/tl6k+KNzLsfYRlf1stc66J+twdvlFc
         4YaCjYNUfSSt/j8Q531lxiQlpTv3FGgtpoeEq9fNn3iSt1bB0hem+goACkVbQxoqZjUA
         8AD/JQGU1SDnSfDNFG07N+S/z26tYhRLE7uSc8phTQpR/+yNYIaJWHB98COnTIcC8Q2Z
         wMig==
X-Forwarded-Encrypted: i=1; AJvYcCU/iR6RXIfzWSqPyaTBfBO3fSqtY/4G14ONFbl4IEcNwyp2BXDsnkmqkbpK3fATF+2zX4WqIMeT2/1Hg+aSGn4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRtJMaF16oNnhdrECW5hFSnk2AYB6+KTuMEX5ofgDxZ5v7xc06
	yMpq/Lw+gcWZM5Z2eANwVy5a8H2dHPiL9MI8FqCNBK39IbeKU9ibosR7kRmoLl+8cNQ=
X-Gm-Gg: ASbGncudbZYrlMXXPpYriTrEtfPf5BjjC7GwWsVajn4H6jZCrzbc2+F++v0ILPxXG9u
	PPxs4FSUHn+sQn7zEqBaaWSKhNmTnT4jkbyY77qPLHuN1+FixZzeOgBXbQDhUpO8Mx4Y53itUYi
	XuXRWOEGdEBbzj5E9r6A/I/wuorHcwFRAExCm+sj7pXc96rQZ/pMuPSXa+0oxEPRJRh7egxyVt7
	1/HJYIB2VNxYscNAsSIceL8QFg1utxlDy/4kshU4FwBxyKJfHMu6M4QINTg/gHmKwlsfdRL+u99
	JcbMbzXlQy8DQ3fg4XD3zCGveSUvjaETFS2YeYar9dWHwvUoi3taLonowfbk32fZm+bSWmBDvUf
	7AHZAgJrpHu/9yFmopak=
X-Google-Smtp-Source: AGHT+IEb5WYlYRXj9KAGrUB6b6ycfigzKegEaHb0jkZarvr/Z/Q5oCi/e4o3PHKyP6WP+mXNVGSbxw==
X-Received: by 2002:a05:6e02:1a69:b0:3fd:1d2e:2e5f with SMTP id e9e14a558f8ab-3fd86264465mr231635655ab.21.1757522387509;
        Wed, 10 Sep 2025 09:39:47 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-417c8f03f9csm8607825ab.43.2025.09.10.09.39.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Sep 2025 09:39:47 -0700 (PDT)
Message-ID: <a2d770aa-737b-43f5-8d1e-0c139c09dc0c@kernel.dk>
Date: Wed, 10 Sep 2025 10:39:45 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/32] block: use extensible_ioctl_valid()
To: Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 Amir Goldstein <amir73il@gmail.com>, linux-fsdevel@vger.kernel.org
Cc: Josef Bacik <josef@toxicpanda.com>, Jeff Layton <jlayton@kernel.org>,
 Mike Yuan <me@yhndnzj.com>, =?UTF-8?Q?Zbigniew_J=C4=99drzejewski-Szmek?=
 <zbyszek@in.waw.pl>, Lennart Poettering <mzxreary@0pointer.de>,
 Daan De Meyer <daan.j.demeyer@gmail.com>, Aleksa Sarai <cyphar@cyphar.com>,
 Alexander Viro <viro@zeniv.linux.org.uk>, Tejun Heo <tj@kernel.org>,
 Johannes Weiner <hannes@cmpxchg.org>, =?UTF-8?Q?Michal_Koutn=C3=BD?=
 <mkoutny@suse.com>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Chuck Lever <chuck.lever@oracle.com>,
 linux-nfs@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 cgroups@vger.kernel.org, netdev@vger.kernel.org
References: <20250910-work-namespace-v1-0-4dd56e7359d8@kernel.org>
 <20250910-work-namespace-v1-3-4dd56e7359d8@kernel.org>
From: Jens Axboe <axboe@kernel.dk>
Content-Language: en-US
In-Reply-To: <20250910-work-namespace-v1-3-4dd56e7359d8@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Reviewed-by: Jens Axboe <axboe@kernel.dk>

-- 
Jens Axboe

