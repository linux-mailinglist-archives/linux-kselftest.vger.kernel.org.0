Return-Path: <linux-kselftest+bounces-27789-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BBED5A484E4
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Feb 2025 17:27:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E170E189B66E
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Feb 2025 16:21:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B3001B21B4;
	Thu, 27 Feb 2025 16:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TzPa8+MX"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB5F21B042C;
	Thu, 27 Feb 2025 16:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740673231; cv=none; b=Bbsna7Q0FlKYmJLkH38/YVZzhkJXWXEAcYW/qVaxZySS/LG6ZXWhdcuzr3IsNlzCEkhpPfUtHnkkA3NPGYOgS2ULFGIeHn8IzWOdbF7Gra73Q4UTSrpQJMK+JMo/GAhp56zwXBmwr+X4rN2BZFuy/goEWFi9uBhTshUXkCvB37I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740673231; c=relaxed/simple;
	bh=rooEJYteRIHmTiGiFviyd+aMAzewENGwoNbS5c06yDU=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=A0kKdD5nJoDMEh8Xeenz9gnPqo6t2imSdQ5c1yBJzSGYdTS9220EpnRla6WLhumOyOjtWV94k4VQ9Z2kI6jsq3obOexZ5HYS1kGlpgyv5bfF6QsPm0EkhECQxVEO4FLo705IiNta1koXUNW/S1/xO9laR/HkvIsnPpOGh0LvT9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TzPa8+MX; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-7c0ade6036aso205966985a.0;
        Thu, 27 Feb 2025 08:20:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740673229; x=1741278029; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EZrrM0ptNXZ2w8KFlRqcTDnRKrUP4WAgT64SUQXk3lc=;
        b=TzPa8+MXmFBu5cZf3gRL3Q4LbTQx4Z4oe5yUPiH1gE+KsJysso3768DVoIqEb2DXGg
         jWMbzMUebQkGnrncnJbbNb1KjHT80GYLKhjx+VA6mMYmBiYZpjS0v9710rc9W+iQOAgw
         sqSGs/T3HkfmsbRxuLnsph1GbTOR18fWRIgmBA6DV7vg4hrdWkjRvrKZLye0pj1sD7Es
         CQn8Zta11wPkhOIvQLx5w6CtZkSWgw/x0Ltx84HK4c2bySDifsxR/fCQ97j/5aFmGW9P
         1REkGiHZYUE8IaFyPlEhuqhqFYXIOWGoOh5Wo6/THNOtq0YeDirXz5XFbISp1F+1Bzgt
         rikQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740673229; x=1741278029;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=EZrrM0ptNXZ2w8KFlRqcTDnRKrUP4WAgT64SUQXk3lc=;
        b=StLN4DUg1ImEEUciIoa68wgDd++iLfxv/iEX7gdPkpxSBVC8Ts36nWfX8tv5KU50ye
         Y+riPhJJYSktUaAECcMcbh95Vwpf05EcLemjpVvexBIkDVbgYeAF2N0lh/jh8FB5BE6N
         ev4VmnD1SdC784DNu8s3Dg5hRtrq9rrE/9lmS1iTk9VdN54Xb37wsfulrg5bzS3yZjYu
         Db9jEzeE9JF7cqMbIv66rNZjWknbdSFsqpJ8AYmciJTHDNmqKfe3ScrdbA7iOqFfCN73
         jqGbpC3D2NTXY5wKAD97JeDjvcbA3ao4VAZGjcBXmANGyd3sQQNLahISzFsR6wP/qvrg
         KJ2w==
X-Forwarded-Encrypted: i=1; AJvYcCUIui1jkH7p8fVmtSCBNIx5uCpwDbypRMhKCVaIAV1hkBrvdsO+lgsfzg32GvLQybgRcc275bMc@vger.kernel.org, AJvYcCUJjXwRQRLbJ6qmEDA6ZcFNoz769y3IKjah2+r1OATPoXLHcObI3Cp76ZpTw4lLDXU+dDQp3WY0BVcHEos=@vger.kernel.org, AJvYcCWHOSIwUQfENPeCN8YEDX1Y+GEU73FjmbBHdNus3egjpMH9d6uSqQmiLIgEmmyBnMXh5qZXn8rChavlBafqOWS9@vger.kernel.org
X-Gm-Message-State: AOJu0YwKmY+/Zi4bps0T6QySLPcOphLS43hSn9A1MwQ6UvnK1AG5OThc
	DkJndxNtClEfTmMmmWssImbbq4JZkuLm/BEwkSec60Jk9x4gvGWY
X-Gm-Gg: ASbGncu/T6Hx3W82O7P5kdVq3tD0nKrrP+cHe/Uly8EQYllTm6OeLJ9vEnXrdVKkea+
	15ALcvO7QKMhaLIt11s9OAZO3SEg/XcCfCAb5BKnPQpgo/BwbjbZgmZ8kshNFSd9NQ4Xdu4qhiU
	to7zU6YDGNSJH/87PdxfasXwkJvmbAgUY3t98IJ0VBwrw+a0uhJawy9cpX8dwIl/ljgwK6fKZ8q
	ro5kYc/WZnYfuscN4ZIF6ZfcUb+VlE9FXr2syE8DGot9772ZZJ0dOlZ2uM7kf/+fN2W3C+/xRZe
	8oGM9zCepvsHrvl57G0/wYO8vH2fL8hlGAm+H0ktS6O68loVNXfZwLmSo1KawNBOjPT4L6n/8sY
	2UhM=
X-Google-Smtp-Source: AGHT+IH56NbDkPEiTqE1fNGFonxYrJTWAvsmYVrJEdkF4m5HA5JbvrgU7zCjOs/KbisdUPWX0+cmew==
X-Received: by 2002:a05:620a:4146:b0:7be:513c:3371 with SMTP id af79cd13be357-7c39bc26d00mr8211185a.14.1740673228740;
        Thu, 27 Feb 2025 08:20:28 -0800 (PST)
Received: from localhost (234.207.85.34.bc.googleusercontent.com. [34.85.207.234])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c378d9f8f0sm121993585a.89.2025.02.27.08.20.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2025 08:20:28 -0800 (PST)
Date: Thu, 27 Feb 2025 11:20:27 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Kevin Krakauer <krakauer@google.com>, 
 netdev@vger.kernel.org, 
 linux-kselftest@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, 
 Shuah Khan <shuah@kernel.org>, 
 linux-kernel@vger.kernel.org, 
 Kevin Krakauer <krakauer@google.com>
Message-ID: <67c090cbd65f4_37f9292946@willemb.c.googlers.com.notmuch>
In-Reply-To: <20250226192725.621969-3-krakauer@google.com>
References: <20250226192725.621969-1-krakauer@google.com>
 <20250226192725.621969-3-krakauer@google.com>
Subject: Re: [PATCH v2 2/3] selftests/net: only print passing message in GRO
 tests when tests pass
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Kevin Krakauer wrote:
> gro.c:main no longer erroneously claims a test passes when running as a
> sender.
> 
> Tested: Ran `gro.sh -t large` to verify the sender no longer prints a
> status.
> 
> Signed-off-by: Kevin Krakauer <krakauer@google.com>

Reviewed-by: Willem de Bruijn <willemb@google.com>

