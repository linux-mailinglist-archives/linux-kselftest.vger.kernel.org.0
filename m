Return-Path: <linux-kselftest+bounces-24707-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AF274A14CB6
	for <lists+linux-kselftest@lfdr.de>; Fri, 17 Jan 2025 11:03:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D15B6162664
	for <lists+linux-kselftest@lfdr.de>; Fri, 17 Jan 2025 10:03:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3C7D1FA828;
	Fri, 17 Jan 2025 10:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I5Cu/xzq"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 195DF38DE3;
	Fri, 17 Jan 2025 10:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737108222; cv=none; b=Ya9b3269OUzMt0EXV+WAiNyUOgWWUcL7uLW2N9TsQNEHQKpl/V8SG7k4kcItNWsEEIrqsXjczpttutA5L/Rin3NWDWnGmjUCXqtfCP/UFz27GAPSYGcPgRdAgh570Nn+hpDVp95UYYitIll4mIcQqxctNJfXtpOPUh01c5FoUVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737108222; c=relaxed/simple;
	bh=stvLBj8vrIlRxoIQO91LmZtoYhREa7PDIqDHI76BvJ0=;
	h=Date:From:To:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=WWt0D2YLQ+ibag2nTVX81kChsdS3521xEIpLvcxbGxlROYavQGfBWAhkDdyAirioSq4iNDfWr+5wQ1VyFVWeaHC9lodV/4Fx9PnjnMTsJOPA2xm7GpuSK2vix3M8Zyaue/KWHJB/tyXP+d76cYr3mbYxF0y7Jgs1i8qYz7npvmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I5Cu/xzq; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-7be49f6b331so159565785a.1;
        Fri, 17 Jan 2025 02:03:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737108219; x=1737713019; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l9GtSAfegOKtXuU9h3FM+siOFpI1M1ddzEo5C7T72m4=;
        b=I5Cu/xzqCnpOfmfoEr9dW1VGSBIY78w8M9tpGjpmx9L9t5RSFpPLRYC5eRa20nkT38
         Kf6Lz5B3pSle8r6kyPkuJFrCiYYaFZcON/OAOB8J9CRV+7vpX2CWErh/G+LYDRm+fI7Y
         T/Dp5VOx/eMaAWEASSsJxqKYOiPnkysZ9KL+wU4YhOGFaNohagukcbFDu06UAZKamzBq
         to9Z67sdNhjf+ycfDFOMf5zBqlRhQSHQ1J20kaQVLWXOU3j07wdAsEjiZZlGHiJHKNf2
         4yTaxlGKxDQCDbisrTgKlAsiPobG931ofKaxi7Ser3Bm6cke0sb2G+U7EJiQcDTSZARi
         H67g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737108219; x=1737713019;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l9GtSAfegOKtXuU9h3FM+siOFpI1M1ddzEo5C7T72m4=;
        b=lhDUSv591WFA1NfW2iwpNbqBBqA+8Y9OOkSgQqpVk2xduev0j3OHZJWkxfKXIzLtGD
         tcNSwBCW6DC4SwKWqDjNu/FlcunB2C3GLSZg1XQJLoTyi2eky/eNtQfjz4oZdhh9gmBf
         dFDAZFVtDc4gOWJTlf6wl9RJx2Wh0MSMi8H96g6gNVhdF1so64HpaGnMzyhGEMhV8XjY
         LfgRChkOhOgTrRtPFSxfd8MSbWeWXWV06WCIdobZZLf/BvIkB7d6bbsyZbJLUeGYANVb
         Yw4TqJ69belBLWirPw+czeYTEOcF/aWdfSs49tboZox4FNJCf5lkQ6Bw6tEdVEQQ154b
         g8nA==
X-Forwarded-Encrypted: i=1; AJvYcCV5a5RBF7u248Lv7YvVfl2DP0n6TiUedBF0nhpAqHD/2I4bFKoT7oYg2w5aD2TSIs3ldsN9OD3LHtSp@vger.kernel.org, AJvYcCVLEu0KEbkqRx5pJwrDEQsyXb+WKMULK0xVMqCtJuwTGVjuwPUR2hkVth4/XvZut374rwc=@vger.kernel.org, AJvYcCWsImxD35JkC2HZT7HrfbFvOPbD9b8WyfiNFjZDfRLrvLHQmG6qOZz+wd73mn2uu3XvaOGXqOlY@vger.kernel.org, AJvYcCX6l+HRVjC7NHOUcOYztDHbCpMzEc+SdUrGrDdLDKOoezYzWiruk/o/xRGN7jMKY7jFaKO+LUSdbtKpPV9c@vger.kernel.org, AJvYcCXy0Xd1NA+kRghTVOGfC9euYbMXMdu+Wz+dgqqo5A8dFTRddQpaZr8tgCm0w1FbH6ZzcCzoPFyS+5ghYv/wojQe@vger.kernel.org
X-Gm-Message-State: AOJu0YzXjn/LCVxDPtCRNiGn9tDn9dNvJ2FZRTzUqM4zAufqNel6wKSi
	tgGGWsnKrhbCtsQX3AULVTmyr1t5cTjCQPyCNbVdlMvO3SCEuX+A
X-Gm-Gg: ASbGncuZiP6L5SYIToTTyegTf++LvV88n8TjkM1mud9QXDDlNCqu7L420e5Tm0NzbbR
	pouwy8KgM9pWy6Xx6IJiv55obuT4INQM8cLwDreDikmc25ZWRbwYtzWFrLlNnex8oq7dyTTGBmk
	NbeSU6bVW7enro7hDEn/vGkQJ6J4Q61S1YD1+M9VQKxCxGe53qKJFSecMklWOkz2FXcOtOh/9cN
	Iu83kwKLr0Kq+OSQCawhr51sazg0bG8CpBo6fGksgqzan/Gp6B/GHietO4EnmXwb97RcicEHUSR
	8KXx+Xyh7tZ17M4W8z5Z4am1HyCq
X-Google-Smtp-Source: AGHT+IHAw9VdvUbvSwjtsR3613T025f+o8n8ZrH+eW7tHQF97iIfZacZIlS99j4vfw/rHbRvSMKG4w==
X-Received: by 2002:ad4:5aa4:0:b0:6d8:8f14:2f5c with SMTP id 6a1803df08f44-6e1b2180802mr40099486d6.23.1737108218910;
        Fri, 17 Jan 2025 02:03:38 -0800 (PST)
Received: from localhost (15.60.86.34.bc.googleusercontent.com. [34.86.60.15])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e1afcd37f6sm9789456d6.91.2025.01.17.02.03.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jan 2025 02:03:38 -0800 (PST)
Date: Fri, 17 Jan 2025 05:03:37 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Akihiko Odaki <akihiko.odaki@daynix.com>, 
 Jonathan Corbet <corbet@lwn.net>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Jason Wang <jasowang@redhat.com>, 
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, 
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
 Shuah Khan <shuah@kernel.org>, 
 linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 netdev@vger.kernel.org, 
 kvm@vger.kernel.org, 
 virtualization@lists.linux-foundation.org, 
 linux-kselftest@vger.kernel.org, 
 Yuri Benditovich <yuri.benditovich@daynix.com>, 
 Andrew Melnychenko <andrew@daynix.com>, 
 Stephen Hemminger <stephen@networkplumber.org>, 
 gur.stavi@huawei.com, 
 devel@daynix.com, 
 Akihiko Odaki <akihiko.odaki@daynix.com>
Message-ID: <678a2af9e73fc_3e985b294ee@willemb.c.googlers.com.notmuch>
In-Reply-To: <20250116-tun-v3-2-c6b2871e97f7@daynix.com>
References: <20250116-tun-v3-0-c6b2871e97f7@daynix.com>
 <20250116-tun-v3-2-c6b2871e97f7@daynix.com>
Subject: Re: [PATCH net v3 2/9] tun: Avoid double-tracking iov_iter length
 changes
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Akihiko Odaki wrote:
> tun_get_user() used to track the length of iov_iter with another
> variable. We can use iov_iter_count() to determine the current length
> to avoid such chores.
> 
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>

Reviewed-by: Willem de Bruijn <willemb@google.com>

