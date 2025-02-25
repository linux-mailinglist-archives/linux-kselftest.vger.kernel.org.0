Return-Path: <linux-kselftest+bounces-27520-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CF113A44A44
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Feb 2025 19:27:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F3E1421AC0
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Feb 2025 18:26:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 706561A238F;
	Tue, 25 Feb 2025 18:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XFH3hp7r"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1A151547F8;
	Tue, 25 Feb 2025 18:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740507877; cv=none; b=WQDAZyxhRnmgQLb30KgJsCR24HKV3k9zQ+HalvRC32xmMseeVoXyNfIYavlvuTEVFQuiOvgJqT2UliSw/rYkdU3Dqnoyo1eCVsx+rL/HuZRinOPu8nu6WT5eK7aHG7jyLaRaTDGj0rkyjBS+5WIKTg8/rFZzXfdbbry67w3QJZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740507877; c=relaxed/simple;
	bh=3XIq+v97MdxND3O722LZ/t+3NyB+KR8ITDStGEfj4lo=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=TbD2vyP6jH+IZ21qvUTehYyzAv7YUd6sB8VO75zBGP8FucODrlDloSd2PBmvLX9h2SXnBPMSFc20mJmAs0x0ouQ+EyYG+D0UWzEthyWmgv4kughmrzBGILlAGebOVaG+nScBlxvVfMarzPtkm7cSjBPuBylLGxrkwLSFQWPuE/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XFH3hp7r; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-47210ab1283so83351011cf.1;
        Tue, 25 Feb 2025 10:24:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740507875; x=1741112675; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gcKgXdB49GE6Hh9aVe3uCcLofk+Gl6MbQhN+OvHH2B8=;
        b=XFH3hp7rFtH4n3xrZGiiHgqipdpSM7my026I4/rm/2xSc8FEpMtWamIZ/sjdO+5Rru
         +nrVBu5V5E7MMKqsoYoyox5+OCEswu5fvtbii91pj22t09ccqybKTcPN/c6uHdAA1b7+
         woRFm4LUanBI7OMVCCuwFoYF9Cu1IiJQdPRTJuf+Yab0aTEC7MIe24vI1Ys1FVpb5zpo
         lkKHqOJRwMj3kkrRZda4mjhTptGBHWClkjHBaV3vcRYFcJr/D1r49Az9H3N6ByXl1nc5
         EvRdvUMCtEahHV/VwYdWY4m1+2QfpRbIxKABoxbFty9eiyu+xHnx2iE/UTAs8LEVWC6r
         46ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740507875; x=1741112675;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=gcKgXdB49GE6Hh9aVe3uCcLofk+Gl6MbQhN+OvHH2B8=;
        b=rQMxNmExB1NXrYV+TMFyrf34Q4mQ8FhhXW7fk8qn6gC52/2d5gh57SEQsw5hPLMte2
         R+AHsl4jaTKbVv+wnOAAV2cp8Lqet+SlYg7frCndeoLC1lSSBn/DYng2EKsS/bFgDHcl
         rUQ/w1DFYxQ3sN2YNVjoLqLSV+PLzprGkJB5cBVu1YuYjAnrVTmT9yA+iSE70OhdHNve
         CJMPCJsjdasoCLhbX94MsshE/992jweTRR4XtoOY9ZKocEMHZ7YTQIXZbxTCokCZsjHc
         X+EAzqiT3stQ2k6St39g3Wld89f1J6mU3zDHkBbF9ng2GRN12iK/OyXVA3MLYnuY2DE3
         M3zA==
X-Forwarded-Encrypted: i=1; AJvYcCV2myv4BD5g0HKDixOQNjqlJoWrMzbmMihnXzrrquFRUMYOnK435oFsTdbbfaA9iXz4tnWmQvlGV42XiVcB@vger.kernel.org, AJvYcCWvF22XKDvGSmKsXmulFbfivBTRDmvWStHp71MJuVJNZ1KBYdDJVXWUfk5JK7ZlIsUTfh8=@vger.kernel.org, AJvYcCX1TS3zHZ8Slhm3+cs1AgRPyvSjf5XQ8luWgNnL92z4ZnglgF3jUrTX4ukO1Mr4F153VU1/ETqBdR8iRsbjWaBK@vger.kernel.org, AJvYcCXJ/RXCGMu9w2fwRyy/KQswZ4O+zarzK/HYIgzLh96t5HaN1pwp0/LITPEt2pkij/EM3lVye7cy@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6MEaD7lPRQH2jeRqaiRUuOEw42/X7qiDkVai4yb+yrgbW5HnE
	MzKlbhOHEjcwwQbvZYPrFet/T+7oVyRs2dRa8h8mTan4Bht7n1tD
X-Gm-Gg: ASbGncttNuRceT3UP4IXu69Z5D/sTHERA4aXCkneMLRZeOTAH6CMAbcalsIUIQB5mzK
	Dk5LHhItEykRUpAFWwmRVe7QUjn/YoqkLqUjW1E1jdmsGaQ0MgZr7xw4XYG0CtvALqFSZduNqFR
	0tbA60G7TwCb/TzBc+Gy+Vv1+HgetZ484GUihNA82JaexPdHRIA7lnEQJDIIIk7qNnvtFjR905v
	J3s7LJv2UYWqikYV6TEAYB2LYFejPr7fZjZYt9tVPZ7eNrIRosqp3f4XkKk3hXU76MVw8xB5e8O
	Hekht1R/Z4WtksTr29jGIuXUdxZ9003feL0u8IlVxZu4qi5udlmoYkLy0iTBZn/tSpaTHWB46go
	Rbog=
X-Google-Smtp-Source: AGHT+IFOopZa/1wU5Ofb0aMRHUO40bsVkgmw83ugxbCbpEvLcFfyvu3Aj5dity4kFsEHcpf7OP9MTQ==
X-Received: by 2002:a05:622a:1481:b0:472:1601:c551 with SMTP id d75a77b69052e-4737725d705mr57841861cf.42.1740507874775;
        Tue, 25 Feb 2025 10:24:34 -0800 (PST)
Received: from localhost (234.207.85.34.bc.googleusercontent.com. [34.85.207.234])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4737806a53csm12814031cf.57.2025.02.25.10.24.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 10:24:34 -0800 (PST)
Date: Tue, 25 Feb 2025 13:24:33 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Marcus Wichelmann <marcus.wichelmann@hetzner-cloud.de>, 
 netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 bpf@vger.kernel.org, 
 linux-kselftest@vger.kernel.org
Cc: willemdebruijn.kernel@gmail.com, 
 jasowang@redhat.com, 
 andrew+netdev@lunn.ch, 
 davem@davemloft.net, 
 edumazet@google.com, 
 kuba@kernel.org, 
 pabeni@redhat.com, 
 andrii@kernel.org, 
 eddyz87@gmail.com, 
 mykolal@fb.com, 
 ast@kernel.org, 
 daniel@iogearbox.net, 
 martin.lau@linux.dev, 
 song@kernel.org, 
 yonghong.song@linux.dev, 
 john.fastabend@gmail.com, 
 kpsingh@kernel.org, 
 sdf@fomichev.me, 
 haoluo@google.com, 
 jolsa@kernel.org, 
 shuah@kernel.org, 
 hawk@kernel.org, 
 marcus.wichelmann@hetzner-cloud.de
Message-ID: <67be0ae1dd4f5_25ccfc294fe@willemb.c.googlers.com.notmuch>
In-Reply-To: <20250224152909.3911544-4-marcus.wichelmann@hetzner-cloud.de>
References: <20250224152909.3911544-1-marcus.wichelmann@hetzner-cloud.de>
 <20250224152909.3911544-4-marcus.wichelmann@hetzner-cloud.de>
Subject: Re: [PATCH bpf-next v3 3/6] selftests/bpf: move open_tuntap to
 network helpers
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Marcus Wichelmann wrote:
> To test the XDP metadata functionality of the tun driver, it's necessary
> to create a new tap device first. A helper function for this already
> exists in lwt_helpers.h. Move it to the common network helpers header,
> so it can be reused in other tests.
> 
> Signed-off-by: Marcus Wichelmann <marcus.wichelmann@hetzner-cloud.de>

Reviewed-by: Willem de Bruijn <willemb@google.com>

