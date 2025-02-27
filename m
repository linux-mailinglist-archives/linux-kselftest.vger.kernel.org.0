Return-Path: <linux-kselftest+bounces-27781-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 97E0FA48433
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Feb 2025 17:05:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9BF511888FE4
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Feb 2025 16:02:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C9F91D9694;
	Thu, 27 Feb 2025 15:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nXCZmz8w"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 794D919C57C;
	Thu, 27 Feb 2025 15:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740671900; cv=none; b=DWJVZPKAouxdsjgGN1QnYxeqGn2PVDnMRfo0LajKK/zoj1tP+N3/3dppao6SLeI/HZyWlZ5jaqqs/jBlogcQf/NwhhUIuoCx+vSiQ6zOV08ifY4L6SRL54VC5MkGWBd3V8tTwTuuJCx429n1+0w3nZCjG/0piCKcV/7oiMb/4Gg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740671900; c=relaxed/simple;
	bh=Z6YiEjRVHODaGAdVVq9S52FfmC0WacWfcyRNTiRjD1A=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=tskan+xa2Eg53Dsh8Hsvj/Q1++Zm/WJcPWYvqbkF2V4Iwg5swzdlY/BdJ+NqqmOXAwHNRyPj1p47fEllnlbW6mSSINAuPsTJis1PO+oEjdTBcpZmvkpnXuriEtcJtsbhVhLRHvwgIVHxUeiHTNO6I1ssZJqqCxY/rCaZe8CYFfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nXCZmz8w; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-6e41e18137bso8630986d6.1;
        Thu, 27 Feb 2025 07:58:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740671896; x=1741276696; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cLIVNI5v7jbwPgcz2HSm7WBrSE9jCi+ARbr++cHhcfk=;
        b=nXCZmz8wIUPNC/lGQs2QnUOapFyhKkGRMXqZVApMIoJpJbV/lLDwmO4Itf2iyIU+HJ
         VkmJIpO5QDbMebItxm4b9c/DdVMmO12H+n5mnbV/30QOZY3oVD5TBT3158FBFGpOY+tb
         buzvtpJJDIQGzv45V7pW7SWLk2z60SrrznNqs84qNdLgJQLT0LHT6EkiHo4rQVBJj5gB
         IJHq6biy2IeWe6DNmS4PRCkt41fBhN1rn0t4ceQlpOzUqZHCWvS1qTYxlKl/oM9XasMn
         zRuJqCJpQPO+eBVA9TT5nP1FPLR2x9xsEqft4fG2o+pJp5Zrnr5Jpt1Ovd9aAVUzRtGx
         eobA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740671896; x=1741276696;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=cLIVNI5v7jbwPgcz2HSm7WBrSE9jCi+ARbr++cHhcfk=;
        b=jbviurO32WmfwQmE0eM53Ej0egegkL3swajqyFQkg/CxBbK/mc0aAunL1xkUn12/+A
         H72HxkQAiNZg0losEH/kowc1TyYPwmmjAurU+Wvm38HAhB46VczNxVvS7UHhHygHszyK
         JzWOy7y2+p4h7oN0CaClWibtFLnteTYUc9Jek7eIVZgWI6LC2tkFfJJyKLyVNhj/euFS
         1nuc6qY+MBefRLCiMwPCMN5j5MyzZCplGOVdfa3UAT7cTUGM8IHIdfWu2bGGhVOfiY8J
         THg3aG30eINkQukQl8p6iua/dijvhsof/1iBGsYQ5DdRJ9tTNzUwY9Ma/DE7+3VcGvDP
         Pc5A==
X-Forwarded-Encrypted: i=1; AJvYcCV2T+Jtq+tiQ+zDF9FskflYLIQ82d6yFYPkCtdQSDrnMYzuzy8u2k65boLQwcmWR6eTc07YcjkgLZ1XFbjfDdT0@vger.kernel.org, AJvYcCVBDtIO01uAk8gys6xBxy3E4NSFkS3vUbqX1mkf2wtmWfRIyOKoFLuHz3MJpf4/mUg3j+U=@vger.kernel.org, AJvYcCVhtpYywqlVo+IebCHV0nF391nVlUD7Q1n9M+IF0LtXIEONaV68Qzskze9dKA2veaPgJ5bipd3j@vger.kernel.org, AJvYcCWvgNjc6R4EC7ZU3admqiNRwfvYS/cBhKJfbtWCDgFfCUlmQkAyiTnTLEutYOqtDXsFxXq4kWPlA6G/4Wv+@vger.kernel.org
X-Gm-Message-State: AOJu0YymPFYqfXi1ELqJEtoCy0ULsGa+BMrUYNGdcnt98ezsQjIiyjEo
	Z0Jy3E9+WYJ2IoP3VaN9OxdLNUh4yfPnZ0YDyW/tQGEiu/f6yoDE
X-Gm-Gg: ASbGncs02iBJTDFyozR4kkG4FnTgV6iOY/RK0kzosfSbZxjzamH8tcbNgguoDmiIgP8
	Ni+rvrPNfxthHFyNri3+t0A26ZmhthNEWj1ABRYSvuxr4IttWaxLKLaKeX2i3l1R0J72uGi52DW
	aMhaY+7CleM2obkJNDSr1hlIQghR69ruZOTWarfF0QI5y8aFv4SZHCP1jfEIyUFKVSflV/hnD0e
	JMY6LzD90D1e3NkJqZMn+hRinykQj2UrwrX/4WNPwtJLgAXr66zNST09ojgs7K+LtRAC72TImKS
	X717jcVny929yvtwC1qLyJOdB+/rw9nljajmieIW56VQEQOPelkXrehQsc3kXI0IpCDWM+xfxOx
	jE1E=
X-Google-Smtp-Source: AGHT+IF3piGfoREI1ClipfUhAb9zibppog3A3EluGLFdr9tFdlwjUC4NyFScj1tA+K5uVqcdMTZW0A==
X-Received: by 2002:a05:6214:1d28:b0:6e6:6ca6:b702 with SMTP id 6a1803df08f44-6e8a0c0426bmr38416d6.0.1740671896026;
        Thu, 27 Feb 2025 07:58:16 -0800 (PST)
Received: from localhost (234.207.85.34.bc.googleusercontent.com. [34.85.207.234])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e8976534c0sm11179116d6.40.2025.02.27.07.58.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2025 07:58:15 -0800 (PST)
Date: Thu, 27 Feb 2025 10:58:14 -0500
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
 ast@kernel.org, 
 daniel@iogearbox.net, 
 andrii@kernel.org, 
 martin.lau@linux.dev, 
 eddyz87@gmail.com, 
 song@kernel.org, 
 yonghong.song@linux.dev, 
 john.fastabend@gmail.com, 
 kpsingh@kernel.org, 
 sdf@fomichev.me, 
 haoluo@google.com, 
 jolsa@kernel.org, 
 mykolal@fb.com, 
 shuah@kernel.org, 
 hawk@kernel.org, 
 marcus.wichelmann@hetzner-cloud.de
Message-ID: <67c08b96d1f88_37f929294af@willemb.c.googlers.com.notmuch>
In-Reply-To: <20250227142330.1605996-5-marcus.wichelmann@hetzner-cloud.de>
References: <20250227142330.1605996-1-marcus.wichelmann@hetzner-cloud.de>
 <20250227142330.1605996-5-marcus.wichelmann@hetzner-cloud.de>
Subject: Re: [PATCH bpf-next v4 4/6] selftests/bpf: refactor
 xdp_context_functional test and bpf program
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
> The existing XDP metadata test works by creating a veth pair and
> attaching XDP & TC programs that drop the packet when the condition of
> the test isn't fulfilled. The test then pings through the veth pair and
> succeeds when the ping comes through.
> 
> While this test works great for a veth pair, it is hard to replicate for
> tap devices to test the XDP metadata support of them. A similar test for
> the tun driver would either involve logic to reply to the ping request,
> or would have to capture the packet to check if it was dropped or not.
> 
> To make the testing of other drivers easier while still maximizing code
> reuse, this commit refactors the existing xdp_context_functional test to
> use a test_result map. Instead of conditionally passing or dropping the
> packet, the TC program is changed to copy the received metadata into the
> value of that single-entry array map. Tests can then verify that the map
> value matches the expectation.
> 
> This testing logic is easy to adapt to other network drivers as the only
> remaining requirement is that there is some way to send a custom
> Ethernet packet through it that triggers the XDP & TC programs.
> 
> The Ethernet header of that custom packet is all-zero, because it is not
> required to be valid for the test to work. The zero ethertype also helps
> to filter out packets that are not related to the test and would
> otherwise interfere with it.
> 
> The payload of the Ethernet packet is used as the test data that is
> expected to be passed as metadata from the XDP to the TC program and
> written to the map. It has a fixed size of 32 bytes which is a
> reasonable size that should be supported by both drivers. Additional
> packet headers are not necessary for the test and were therefore skipped
> to keep the testing code short.
> 
> This new testing methodology no longer requires the veth interfaces to
> have IP addresses assigned, therefore these were removed.
> 
> Signed-off-by: Marcus Wichelmann <marcus.wichelmann@hetzner-cloud.de>

Reviewed-by: Willem de Bruijn <willemb@google.com>

