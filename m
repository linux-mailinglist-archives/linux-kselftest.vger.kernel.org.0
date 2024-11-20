Return-Path: <linux-kselftest+bounces-22360-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D55129D3F7A
	for <lists+linux-kselftest@lfdr.de>; Wed, 20 Nov 2024 16:57:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B72C280CE1
	for <lists+linux-kselftest@lfdr.de>; Wed, 20 Nov 2024 15:57:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4B4915531A;
	Wed, 20 Nov 2024 15:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XCbdpbA0"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71544149DF4;
	Wed, 20 Nov 2024 15:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732118145; cv=none; b=FxEy7Yb7B3cZIw4ZpqbLctEFDCJcmA8aCzSMa4uZMU0QU8Xop1YWisr80eUi/xzlzZYrj6pG6A6g9QzV1Y4ey6M1/FcmTMPTP+ijO7b6RTd20vW4eqNNvviS5wWy/ZY6U6NDyezuM7ob26XSmIvrRWKl1wGAC6ASbnH15+xrmAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732118145; c=relaxed/simple;
	bh=fIdhUfiza/vDK9RkE6id2mDmAoBFg1X7DVWjFHqQny8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D1CeeP/YVmjuq4UQQ82o/jMvHQSwogcf8JeOCdeQENmEt60i/bX/ow9BYl1+uNTsoVYd2wK6NEvD/KICQK8UxT+w3REDgwV4RO2m6H4G+ou1Ev2GKrk0ZX8CP+imglNA68zmg2wIbJz0qSlDK6kQLQsgz2w3AH4FzV6RdZOF4Rs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XCbdpbA0; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-20c805a0753so23459065ad.0;
        Wed, 20 Nov 2024 07:55:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732118144; x=1732722944; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=AUQymMFxwrhSGX/+yxnXqAd+VjQFL+AsUSIHlUAW5jM=;
        b=XCbdpbA0dMohdvt1KO3W5zWPI47TBoqGdpJcd3oOxAmfepJKbMKV7RgtOVJzAvHF6S
         H6NQq2kEsFy1jt/5Y2Ue7i+qcvrXBtpOcFwEMC1V/5OrwfqjpOlfoyVBhyKVMVHw1GS3
         EMuesgHGtGJegot+ZmfrmWtQgthsqUVnlrBo2ySP10DSuausTL21LLqhr7kWiX2GmMHG
         kT7Nj71OjzBAL/QtZbZoWgMiPNlfq1wUeC9ZdL06Vixb0GOiDpUQucB4RduWkiRgo/Sv
         dpSmwgz2HrMGYnsd52OLJPNFGrkK+VB+5Vydz3gN0y6IYX+FvHaLL9/L7cST48D1RZaE
         OkXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732118144; x=1732722944;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AUQymMFxwrhSGX/+yxnXqAd+VjQFL+AsUSIHlUAW5jM=;
        b=HZHGLPa6Mygu0UI7xM+0PTFWSq1ATXoMInnufHt7AAxVypu27P7jL3rLpxG0B70T5E
         aKHhfHWCJwvcH1WhC/2w21FA2GMtFNeUDBy/lg5/0n4mqiNGi2HlK7sJFX/59nWId6ic
         xMiY3XAwRfA6sD1OVdoPiw7BLko9YrrScPJZ4KJ5bFCt2GjFHdaWQ5xqWJkb7I0lFub/
         aPLAX6Brs3mwEy4mMzwVE+VkGGOd/5hxvubApbH2PhblSacLYVX1CjZ329vLCOvmV3hM
         wJTju+sPen4ivIhepMW/QAubCUo4pRZADkDhV5R0MHz6GxtcSts8sgFRTH0e5vK2Tg8g
         dI/A==
X-Forwarded-Encrypted: i=1; AJvYcCWrHyizclW1UR9QtsPfTzTew9BXz0SAQwmakvraueYhQ4zQJ5m/OPRQ3t7X6QOzng9s3MXor7/Z@vger.kernel.org, AJvYcCXP7dmjqN6qG6BBLdbF82LGa6c91osUgJrgrag+HBtUPnHVxwwrAC84/Gs1jjJoo+r2h1aoxq/nHu3+NPyH@vger.kernel.org, AJvYcCXTdAVyfKm+SOZ+e6Eo5gjJ+584xmbJxdknHA1Y4B5b6F9B/BUIPoO3z+ookzjG93yG5c3cTdRAJBzJSguXjpyb@vger.kernel.org, AJvYcCXgKUOq9UDmKgVUBayJQbpF4iQXJ/GzeItFDrEGJep30n7yAhgMG5O7bKvkOfDnFBXCWpQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0VG3iXwURapCVttelx5fpvCsKab1XZeoqGgWZLkxXA++XX6If
	UfS5puf6EwZD79isfT4WQv1/os7x0nNwrlHR3eVfTrlYyH8VWH8=
X-Gm-Gg: ASbGnctXRx+VVjLIRhIV8t0Zqn6UJ++RZmPaCA9Y48vCBvUDeqLXSmHT5b0Ws2BwRib
	gJbKuwpcaolIkhWBMussQKsKahYmfzHJZEMmDzTeoJs+lQGB30ecs3tK00QxXVPG9/tKReNk8aa
	3Da1UQetmFX1mQymlI804WSs6eCy7/DXWGRc1q1ZaYwDWyZaZJ4zdnkqCRCLwOBEuM7c05v+aib
	/5IfAWJSs9tk08lY9gUzdKIqr2DsgfVGnFy6jFp8ojr48o0iA==
X-Google-Smtp-Source: AGHT+IGSsYXQdZoVajnSpa8lqE318JZ4JLIhBaSdvhkFxYX/LyPDqBuurRJGuQ2rlT9s1GL+apMkpA==
X-Received: by 2002:a17:903:1c3:b0:212:77d:3899 with SMTP id d9443c01a7336-2126a3f32fbmr45862975ad.31.1732118143834;
        Wed, 20 Nov 2024 07:55:43 -0800 (PST)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-211d0dc305dsm93619125ad.44.2024.11.20.07.55.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Nov 2024 07:55:43 -0800 (PST)
Date: Wed, 20 Nov 2024 07:55:42 -0800
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Alexis =?utf-8?Q?Lothor=C3=A9_=28eBPF_Foundation=29?= <alexis.lothore@bootlin.com>
Cc: Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Mykola Lysenko <mykolal@fb.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>, ebpf@linuxfoundation.org,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Bastien Curutchet <bastien.curutchet@bootlin.com>,
	bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH bpf-next v3 10/14] selftests/bpf: document pseudo-header
 checksum helpers
Message-ID: <Zz4Gfi8ll9lDH7aG@mini-arch>
References: <20241120-flow_dissector-v3-0-45b46494f937@bootlin.com>
 <20241120-flow_dissector-v3-10-45b46494f937@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241120-flow_dissector-v3-10-45b46494f937@bootlin.com>

On 11/20, Alexis Lothoré (eBPF Foundation) wrote:
> network_helpers.h provides helpers to compute checksum for pseudo
> headers but no helpers to compute the global checksums.
> 
> Before adding those, clarify csum_tcpudp_magic and csum_ipv6_magic
> purpose by adding some documentation.
> 
> Signed-off-by: Alexis Lothoré (eBPF Foundation) <alexis.lothore@bootlin.com>

Acked-by: Stanislav Fomichev <sdf@fomichev.me>

