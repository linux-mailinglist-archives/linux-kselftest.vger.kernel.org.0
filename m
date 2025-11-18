Return-Path: <linux-kselftest+bounces-45823-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DF1DC66F76
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Nov 2025 03:08:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id 0752229E1A
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Nov 2025 02:08:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8764A326D65;
	Tue, 18 Nov 2025 02:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zw7Cgvul"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFE6D3254A2
	for <linux-kselftest@vger.kernel.org>; Tue, 18 Nov 2025 02:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763431668; cv=none; b=CCWVu3Enhe5EDPz3CpX+191mWjlXy9XXsuEjPTXdBiezvPCP66kXPaiKgrb46l+6y4cNfi45UUL1YhpDVwH1qOP2of0rKW3S6fjOlDreZ1EBAERd0uHqjAtOwzfjljZT8qbzKwwuxe6GPV8V5c6Lxfhexc6XTw0QcM3nn5Dtwas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763431668; c=relaxed/simple;
	bh=zulHb8HLblzFI3a01kSRRJXRLphS/NHSMEh9xUMRuSQ=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=cTVwZ9hpGza5bRPkD70zpXJchfhefyOszMwyvP/wVUmlqnttA66Fwl436g+3j8yhIsQ21hc8IJGDVt9JWH7mWPQphSF+d4mSb04BI2SbS5Hj0WjxO5/WtV+Vg/xqtuqLPaXMRbsKXF2MUM4d8M2WB8BtvORYECK/pJMiuxykjXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zw7Cgvul; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-786572c14e3so50759237b3.2
        for <linux-kselftest@vger.kernel.org>; Mon, 17 Nov 2025 18:07:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763431665; x=1764036465; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sUE0IIC+wUoASvGIKd654X7nuyMKJdJFQ4SB1lxt2/E=;
        b=Zw7Cgvulv2NtCwkhjzjdu+t2FDLKlZVds6WRKGWBDFIbGahVvmAK7Cmk/kLAeDjnG/
         nzh/or0mh9mfxORpkVw7ArvjHnPkOEDovukg+ug8FPtmjcYUHIzgUru6x3tjTCZ82pSW
         iBBz6kaj85ez3xrjr5GUpvB4i0YFLikEIFcu7wT4FDmFn7K7KGVKcWdx/vpfGlyQNtDl
         BKrEN2PSLjuFTCAjgkF072DjEAcSlQgva8OiK0UMXJRoZCact3Xk5CZP5FtkO/6LfBY3
         gaKYjyZM3pDFTXPkDJsD+zABX5+aXZWa+kmZB6sZihU7K0N5k4dtRvaGnBqjZCv4xV0s
         RAEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763431665; x=1764036465;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sUE0IIC+wUoASvGIKd654X7nuyMKJdJFQ4SB1lxt2/E=;
        b=FGgQHRMlPas0QnY3KkSl1YCVe0voAwDKE2OjGTY7INaw9xG7KvnX+lpq+LAbtIpvgF
         Lq7ZrIRMkZcrsnsI9y8PN0QNJThcBNaGkzijE/YRw//t0xTDwtHerfbofDdyrZA2HxhI
         RZtGtL1ZmDSPD12jTrXjlai3kUOkGW7jjV1f1pi5PMCtFctasNkuAiTL+rAprNNhjeFs
         rRybCAzDTm3q6KdsWNVWYTIYjCAn8Z59N52YX2JKQ6mx3RE75ncs6cYmYjl3nB8W2ef0
         iNMJCpmQff4ZFwCn/xyTPaDB4YsmGxnymE9tY9yea/e819Ytcm2MSTEzlZQfvOO6XxMY
         US+w==
X-Forwarded-Encrypted: i=1; AJvYcCWiLfgfDljWCoxOXLobHnZWmlkKzh3xs7Wgi67WSe6cg6icprqhaG416jOVUDrSPpqnebSgqHD7LWSX36Pceq8=@vger.kernel.org
X-Gm-Message-State: AOJu0YweI+qvjmH4FKHiHAhg+B4A0Z/v5Ezzopl4EIzqSecMHJfsNGw2
	7zwjmRtRPO8wOMsCkcyxBImQoD1BeJmP+rR62PBdRNtZssWZn2kWU/Ho
X-Gm-Gg: ASbGncugEQuhAqBUziE10F0qb5R0XJz0aEUQblYB6h+XMa9H6vhmYjylCpEcAzIdquP
	OtmF4K5jR2WGthdG8yf0nudeHfp6reUiMeiMbjPCDr/YQVERP7yO9TMGcLUbYnUXecGUnJLokwZ
	ycZB3/vDU89yi4RH7iIrg9iLV/803tQxlPSH34dbEkCc/YySNnRf+Q9RNo8XK2BggRYOts0o60z
	tqwyQSgElxMWHiE981AfdGB7LFpqUpksSxC3JGKj3+gfPl4ye+pvlTgUc9ZLINUElE2tnVNvMnH
	15OP5kI2R+dozzuEb//Tt3M8cxRi9bq1fyhGhtidqMBxWJqQOosTSVMb8X/2T6Z8tWtuYhL954v
	K1vk0fVPG4Q9PcC9fV+sBU3jydWe/sJSQQyeTuYhuZDJvLeSTi+56zJmukuXLqJXYi8kKem3p4A
	0/GCtRzggwAzeTVW7FT3VN5kg1lIcMljICuK5puIGsDxRtgJbfgfMFPQfc
X-Google-Smtp-Source: AGHT+IGeaC4GKAyV7ipin/XG1dYVhnDBsRRn2eLksOzMNTKNMaqNZZNWaW168+t+ahhygJPWcmrPyw==
X-Received: by 2002:a05:690e:d8a:b0:63f:a856:5f56 with SMTP id 956f58d0204a3-641e74a41cfmr12289102d50.5.1763431665061;
        Mon, 17 Nov 2025 18:07:45 -0800 (PST)
Received: from gmail.com (116.235.236.35.bc.googleusercontent.com. [35.236.235.116])
        by smtp.gmail.com with UTF8SMTPSA id 956f58d0204a3-6410eabb558sm5294781d50.15.2025.11.17.18.07.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Nov 2025 18:07:44 -0800 (PST)
Date: Mon, 17 Nov 2025 21:07:44 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>, 
 davem@davemloft.net
Cc: netdev@vger.kernel.org, 
 edumazet@google.com, 
 pabeni@redhat.com, 
 andrew+netdev@lunn.ch, 
 horms@kernel.org, 
 willemdebruijn.kernel@gmail.com, 
 shuah@kernel.org, 
 sdf@fomichev.me, 
 krakauer@google.com, 
 linux-kselftest@vger.kernel.org, 
 Jakub Kicinski <kuba@kernel.org>
Message-ID: <willemdebruijn.kernel.fa82e73170d8@gmail.com>
In-Reply-To: <20251117205810.1617533-9-kuba@kernel.org>
References: <20251117205810.1617533-1-kuba@kernel.org>
 <20251117205810.1617533-9-kuba@kernel.org>
Subject: Re: [PATCH net-next 08/12] netdevsim: pass packets thru GRO on Rx
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Jakub Kicinski wrote:
> To replace veth in software GRO testing with netdevsim we need
> GRO support in netdevsim. Luckily we already have NAPI support
> so this change is trivial (comapred to veth).

compared
 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

