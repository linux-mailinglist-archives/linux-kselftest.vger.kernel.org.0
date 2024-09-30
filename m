Return-Path: <linux-kselftest+bounces-18666-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D7C398AADF
	for <lists+linux-kselftest@lfdr.de>; Mon, 30 Sep 2024 19:16:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4DB9E289B1D
	for <lists+linux-kselftest@lfdr.de>; Mon, 30 Sep 2024 17:16:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 286431940B2;
	Mon, 30 Sep 2024 17:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XgEGCQ3Q"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC4A3273FD;
	Mon, 30 Sep 2024 17:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727716568; cv=none; b=IjzMVmOTuyXT94p8FKtO2eYGlzyHBH2kvr1ifdszSuozRdra9O09izRTZvhtgPXkQUsRuwPATPqBmNPxQqRCMDyNiPmQIHgR62mTBy1hysF2jfFz7MJ9C3J741b+lV+iUIMe7Fw/k/4zS2p8EmbEySbK9tMfvbJC9+2QmAqUTbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727716568; c=relaxed/simple;
	bh=TjwEM1zuI7BG22m/2dhtlDUvWLCXOJ/fTWYcnz31FnM=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=XkJk4TP+R/uE2bfQF4nuMHaKKUWQlZVnHQUHX2xAO60ozlRThmboMN2iRkZ6ENqSu8KbNDaH+SatEINcQoTdPpdn8MgbWl0/odYHk6yY2mvqlOT9EGb/YMTbNUudANMUWknRCUTz00TpfzB8h5CyLMfePuzbEEGSM9SQwAnX4Y0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XgEGCQ3Q; arc=none smtp.client-ip=209.85.160.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-277fa3de06fso1762535fac.0;
        Mon, 30 Sep 2024 10:16:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727716566; x=1728321366; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VpXwoIxbjUogeJRClZVzOGln9U9ds33wWUdNvQDsqko=;
        b=XgEGCQ3QQIep6OvyF2PEUNk4ZqiIl6syLVmZtrXMtwFbQPXknWXykNOF/aL2mycgYj
         ZuYPQGhuEiuNRhX1vbo4SL5vNIWzg02WOrSULWdQo6t3RuR0Gdxady0uHW2tz4fsYLes
         vgZdmmo/JCTE/zxuJlK6oSyX2n16hUmdUCQGb531evdBj6qhQoqwkOtbo3XJUcOynYsA
         KbaIdSSAhU3e4Zhbwh4fpTvs8dhTicljO6LgH4emB9PfHpzfFmU5+BqF7EnbyGuwzB5F
         nndOLAH7g/xqzwBSVfjkaZgdO4Ri+Uz/z3oi1bLg93GOnbmHdwzZeF5+mDRoKDEPzagJ
         /lzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727716566; x=1728321366;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=VpXwoIxbjUogeJRClZVzOGln9U9ds33wWUdNvQDsqko=;
        b=gFfcCMoim/4sxrbPco+BoIUR0ANajrQm8bnWsObI11xBlwp8JzO5KQqjBdWCrLfr84
         IRah16Q5ffNIu1Qg7ccqV2hgRuV92n9vi7unBatz/Eg8RQSFPZ/xLhQApDlKVhccCvbk
         P+XYq0lf6gLTV9mrxQXuxHdKBTgghCJLNfcpfPrgD+wY81CS03Zhc9SWBr/gj7/1LpTj
         dcikjIUq/0SVLg+K7q4dFAxZyblOtzB/ZM9xr765oS5/kgRF32zI/3ydYBwBb1Nd4UWC
         su213aPOME/wOXjh+eXhrBRE56TbQMdfIwzhR/cFSCFm9NAIKrqMW1rs+JdlkISZ5FWC
         IC7Q==
X-Forwarded-Encrypted: i=1; AJvYcCUDt/JT80X99VCCfQP6rnqEl1HAUhOjEJyRtyap9m43PZa7zFcgNR/XIowxLsP3MwSBl+iz13TKvnhHG1w=@vger.kernel.org, AJvYcCWTVkMdYCZ5jEgOt7V26OioPRgJ/3STXY3D6c/sgFRRS/Lwts/R0bU7ZdAGnLdenaPawWsyE+5fyx1q5uVCYYZN@vger.kernel.org, AJvYcCXERFTx+1NGk2m1B+Om4/UbygUYiNKX6TmFzModTUcPqrOdVMkWoN6hQzl8yqyG8z2Gi2L+NQSN@vger.kernel.org
X-Gm-Message-State: AOJu0YyOlHEGHSONQMcPCEHzOy4FXiHYOEulxril4U23FVohmL0RD3hU
	sNFv3ElHqCo5waEulm2Q4B4weI6Z2e2LpWTC6VTeCEHkHsPP0wvU
X-Google-Smtp-Source: AGHT+IFditoSuyfroEdAIwRzRKlnVguY9UGX/ffbBoHQcF7P0K+SUmhbtMF0mznARjuTvpJ5h/6kXw==
X-Received: by 2002:a05:6870:1d08:b0:277:ca2f:905 with SMTP id 586e51a60fabf-28710bb61f6mr6895849fac.29.1727716565711;
        Mon, 30 Sep 2024 10:16:05 -0700 (PDT)
Received: from localhost (23.67.48.34.bc.googleusercontent.com. [34.48.67.23])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7ae3783ff45sm427231585a.115.2024.09.30.10.16.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2024 10:16:05 -0700 (PDT)
Date: Mon, 30 Sep 2024 13:16:04 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Sean Anderson <sean.anderson@linux.dev>, 
 "David S . Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 netdev@vger.kernel.org
Cc: Willem de Bruijn <willemb@google.com>, 
 Shuah Khan <shuah@kernel.org>, 
 linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Sean Anderson <sean.anderson@linux.dev>
Message-ID: <66fadcd4b8f08_18740029417@willemb.c.googlers.com.notmuch>
In-Reply-To: <20240930162935.980712-1-sean.anderson@linux.dev>
References: <20240930162935.980712-1-sean.anderson@linux.dev>
Subject: Re: [PATCH net-next] selftests: net: csum: Clean up
 recv_verify_packet_ipv6
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Sean Anderson wrote:
> Rename ip_len to payload_len since the length in this case refers only
> to the payload, and not the entire IP packet like for IPv4. While we're
> at it, just use the variable directly when calling
> recv_verify_packet_udp/tcp.
> 
> Signed-off-by: Sean Anderson <sean.anderson@linux.dev>

Not sure such refactoring patches are worth the effort.

