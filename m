Return-Path: <linux-kselftest+bounces-5749-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B5DF86E7FF
	for <lists+linux-kselftest@lfdr.de>; Fri,  1 Mar 2024 19:10:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1DBD6284A02
	for <lists+linux-kselftest@lfdr.de>; Fri,  1 Mar 2024 18:10:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A82F22092;
	Fri,  1 Mar 2024 18:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3u1OFBlZ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 230B120DC5
	for <linux-kselftest@vger.kernel.org>; Fri,  1 Mar 2024 18:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709316647; cv=none; b=V7NcL96qcnsjpwfBwdYebL1OvBjAnsJU3qQ77Qgvwl6ilVjik3XpeOR8tBH2fFaAZ7hjpdu1yWs1FM/xgysHThHI5JcFb4iBIOfTMLv4dAnJb8l+EODPhjh6pko6eviL11X8+vCiA4LaTDPpGwE4gEgiVHo62od/iITHoJtfIJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709316647; c=relaxed/simple;
	bh=/6jcISU9a2lnag5/ubrKOxe+3HSP1o+nV0AIAXp30PU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Z7VMKxKP8/JmSDHKNXMJgLzM7+pdmcQhRxeWPhjfuzK25LFd2yMOY2rZJhCQ+hYypfe65a6TX0l4f8ZECZnDEYryxCE/BDEVlZtkOUP7pQKHkmjbn4mMrueHRoHXt8RI9YKgoBRg0bMLo0ttbDCVfpIVRvFl0OqJYJ+WoCxj8+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--sdf.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3u1OFBlZ; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--sdf.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-29ad35a8650so2910162a91.0
        for <linux-kselftest@vger.kernel.org>; Fri, 01 Mar 2024 10:10:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709316645; x=1709921445; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=pgwkJ5zBKIvalm1RJIrALe5y36weQ/YKYrh2qwof5jE=;
        b=3u1OFBlZYlDwYDMaBGNvYsP/Pe7bCrKTk9rO35Zkj2EH0Y2HN8qyn4tCt9hhbrBOQW
         060bAX/T3CzjtXIl6zmDevL1mQnfzPDQM7tnR+iyQAJxOeULy57SMTHdGuioYEJLVxQG
         XsgjG1HjuPzImNJfCRK2jeta+85kTzFWGxwHuYz7AkwOthWV5VX+PDiRrXK0Lh6K14jw
         no/WqSgV2aCib4O/QQ1S8zc5y4ZyyrUXiCX1miul9XZ9AEy9JksbG77PLebrNJDrzoQ8
         ylseZTbjcDFxg7TcpMYPEU7QO+SvPoZNeSLhng04gwoWGqOLEzGgjihRjwo1E7qtkeOD
         746w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709316645; x=1709921445;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pgwkJ5zBKIvalm1RJIrALe5y36weQ/YKYrh2qwof5jE=;
        b=RgOsgAwGSe8o6ClfGKr31cdxffNT7YkhtoHu8h72hRul9ju2yThuT43UhusTrrQ3qc
         kAXatuNxiqfp5m4jd1oSz71I4TznVsjlcRxHklav3BRs1AoirFjz3Q1h5TsDlkebjvCE
         f1hlHUD6UCWKto+78RUEaSFPx64u2002xKxnq+82V8pAOKEQsb6HhlqemkhpU4/CXHUK
         kztJ7bH9baS36splirG6E7u+O70ucAcFNmQwDMNq9H0Eyb8H6PSsNH+RqO/tU/n6RMKq
         q10V47f3uThfRlDklw7nJWffqUiPQjd8qgAxvAFlw6HWg7oCnlNxIZfvm+3JC9cy91uG
         leFQ==
X-Forwarded-Encrypted: i=1; AJvYcCVxOOfpp5nZ+1I8wmbi+h5koo/x+erMoH7DqCU6LJr9Wi+toNl4rLP8WcCGT30RIkvS3atkhXsf9Pd7VZxKeGbikhPyk0uLVnyFFw2FNr4W
X-Gm-Message-State: AOJu0Ywdg0szL2Lid2ycfCKoAp+AeM5Z5d7iJPI0HPEDjgrfmftpw8X8
	dCB3Hp8AgLJ8J5fGJyACB/AD+B2T/KI5+e8+dMLJtL/kqvu6Et3Nb7ENZ+Vfz3MchQ==
X-Google-Smtp-Source: AGHT+IEGDx0IBS91RwXiEWVsOKX4bVPCV9F+AXiFnctjT3PsNi+Tc0z/aXyoMVHCH/0MRr3/ArbUUwo=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a17:90b:3741:b0:29a:a70d:e5ce with SMTP id
 ne1-20020a17090b374100b0029aa70de5cemr24534pjb.3.1709316645070; Fri, 01 Mar
 2024 10:10:45 -0800 (PST)
Date: Fri, 1 Mar 2024 10:10:43 -0800
In-Reply-To: <20240301162348.898619-2-yoong.siang.song@intel.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240301162348.898619-1-yoong.siang.song@intel.com> <20240301162348.898619-2-yoong.siang.song@intel.com>
Message-ID: <ZeIaI4TNqXSxU4LX@google.com>
Subject: Re: [PATCH iwl-next,v2 1/2] selftests/bpf: xdp_hw_metadata reduce
 sleep interval
From: Stanislav Fomichev <sdf@google.com>
To: Song Yoong Siang <yoong.siang.song@intel.com>
Cc: Jesse Brandeburg <jesse.brandeburg@intel.com>, Tony Nguyen <anthony.l.nguyen@intel.com>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Richard Cochran <richardcochran@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, Vinicius Costa Gomes <vinicius.gomes@intel.com>, 
	Florian Bezdeka <florian.bezdeka@siemens.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Mykola Lysenko <mykolal@fb.com>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>, 
	intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, xdp-hints@xdp-project.net
Content-Type: text/plain; charset="utf-8"

On 03/02, Song Yoong Siang wrote:
> In current ping-pong design, xdp_hw_metadata will wait until the packet
> transmition completely done, then only start to receive the next packet.
> 
> The current sleep interval is 10ms, which is unnecessary large. Typically,
> a NIC does not need such a long time to transmit a packet. Furthermore,
> during this 10ms sleep time, the app is unable to receive incoming packets.
> 
> Therefore, this commit reduce sleep interval to 10us, so that
> xdp_hw_metadata able to support periodic packets with shorter interval.
> 10us * 500 = 5ms should be enough for packet transmission and status
> retrival.
> 
> Signed-off-by: Song Yoong Siang <yoong.siang.song@intel.com>

Acked-by: Stanislav Fomichev <sdf@google.com>

