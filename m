Return-Path: <linux-kselftest+bounces-26718-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D0DBA36F0E
	for <lists+linux-kselftest@lfdr.de>; Sat, 15 Feb 2025 16:21:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6E9D37A334F
	for <lists+linux-kselftest@lfdr.de>; Sat, 15 Feb 2025 15:21:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 356481DDC2C;
	Sat, 15 Feb 2025 15:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ECzYN6xI"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 803A11B532F;
	Sat, 15 Feb 2025 15:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739632913; cv=none; b=oeakw6D7rTNXz0/uadIYlxD3Tmm8PKRi3kWStoVtzjDCA7CSfJ/TiHIpEznxEX3HPvoCnh5aZpLxmGZXkO6fot7UvSEWfWo1Rxec0t8dBYm4pmIUSpfVYNqAlmSiN/fwwMUG7bsxsM6+VfeI8k6VnvRGabpuWaVbLfY74r0YfMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739632913; c=relaxed/simple;
	bh=qhDazyfT4fXyQ55ZFc7/xhm33sFszSOfjFQXOuGirLY=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=VSfSuIadiLkyBPNPi1T2DiiSAI5atf3IGP35y2PzErHgkAjnVIyu/xLEwP3CnS/jHY7A7lBGiMz8ZDKllueXU/w7vp5HIqJlRljzcAwsgaUoIi2RJQhLOGlaFhr8xR3yWc/5tKKGGaGojKoBMeqZmyROnpK+G6EIAHw4OsmjmZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ECzYN6xI; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-7c077c9cbb9so249482585a.1;
        Sat, 15 Feb 2025 07:21:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739632910; x=1740237710; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lMmFW9JrhGDdKsX2kiJjysOLPKZHgx5YbIzP9n3YrVc=;
        b=ECzYN6xIX7c09baMp1hCDYfACmNyT+riShIJBNgCTIrTdYdXgPIdppEt7YYKvSVkOl
         qjcBUi4Yb9fFOzBk39R7QzUHxsZTGfZibcKN5KqpZytAuFS0t9grsdy2xS9lzWRG3TwW
         Z0Njlxhs5U10WSJ2kQa1fNT+/Tmop8lyp5XpNAfg9FLmDHhehQdmF4N0GNRT//MwNbhZ
         +CxC4AxksU3Idcror5ZsgSMAyc3O2m7fMJH4rRrDrdRmyrC/lKHShNlzTQsIXLTIJDJ3
         wRpP5NvJRyMSBcN8PJKNXg9UGijAqNnzm8GIe43rBYYtrAsxKuHsopDgD0oUgueu3P4X
         sCwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739632910; x=1740237710;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=lMmFW9JrhGDdKsX2kiJjysOLPKZHgx5YbIzP9n3YrVc=;
        b=EisqNisXeTQtJJ1jsp+EqyAEA7kcyfi44yoZlvKo4zzm45Lq6AIBDvRgtdLFjCbseF
         32EaoAkqA3zPEfATUFGzuM3joBm2V5BbmHhLn6rkiOAa9wt7Pe4HkhzgVyTxvmvK0zpp
         b/HxjudtKFcc8U1tSWLXXjw8q7TmyUI7oz5OdI8wTpM1+MH1mlDnMTkFJs1uQZuHz3ft
         ACTXOQ9bEjDO5pFH4ed6tVDIr0zZqGjg9HBo7K4dHdLWAX+qzb2I9c5mBtPp7lEk/XDT
         qEVKRNyd2uVOw5nY/d7dsa+jclQYjuSZ9GxxqHLxu6tDnf0vsB2aNfyx8ksIiGPTPECb
         wxNw==
X-Forwarded-Encrypted: i=1; AJvYcCWiO5nbAKOATO9dvyOphuLQDoeG9KoAQDNBOvucPoQm02NcQqGjIMdqlJnlZhpf49yOmiK+bkm0e5MAiI7GETw=@vger.kernel.org, AJvYcCWpG0ObZuv3nC/N59yVziLOkST4Az7Jz9L/A0Vwh4KDj29IOBumRB5AouijAUy/LiLntLDnPkz0@vger.kernel.org
X-Gm-Message-State: AOJu0YyZo+dPqDkedda4qmbQrcYetcszM6vAmiGYz2nsPLRJUvoBi5Xl
	g792VdyegFj77Krt0ZWpJ8JbI5rJYFAGDkXSeOoSuLkAjRg/zJ3/
X-Gm-Gg: ASbGncs+VTKRen+EF6ve5jegxBL12ESGkliIPLTXTdHTQ3i+DgnnsNU+YXe6tn3z51Q
	LhHQf9vXzJ0feHJExQhdYQDAWyAmKTQTyl8fWj8KqddrezNBD9PFHY/ukiAOvJXog4iezqlKLe9
	DopcifoSbYVTRTDU3oy9bZZMW8ra7apN5bbpkqZgsl5FbNpbMK6tpCjVOs8YD9c6e6FmTrZ6TZw
	XVBsiOi9zf7gvMjWVZHY0zQmM1i4MwFw5K73gbRhNiSxFJMgd2nhVQG2oTRsKsdheyS3hFn+BWE
	JQJWuyMtObw1a4VQDjhBNOwG4UxKNI22XFPJgVJH4MjJV5/0X5hUbFNgfcSaZYQ=
X-Google-Smtp-Source: AGHT+IG5scF0mmUQW2RyZ3GmEoLcesENu3i2UpsNOTAMjxcvKEICQAtJy5/BHE9hAqFDiYO78xC4dQ==
X-Received: by 2002:a05:620a:2496:b0:7b6:d5b2:e58 with SMTP id af79cd13be357-7c08b1568d2mr455733885a.18.1739632909676;
        Sat, 15 Feb 2025 07:21:49 -0800 (PST)
Received: from localhost (15.60.86.34.bc.googleusercontent.com. [34.86.60.15])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c07c6173f7sm324813585a.57.2025.02.15.07.21.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Feb 2025 07:21:49 -0800 (PST)
Date: Sat, 15 Feb 2025 10:21:48 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Anna Emese Nyiri <annaemesenyiri@gmail.com>, 
 netdev@vger.kernel.org
Cc: fejes@inf.elte.hu, 
 edumazet@google.com, 
 kuba@kernel.org, 
 pabeni@redhat.com, 
 willemb@google.com, 
 idosch@idosch.org, 
 horms@kernel.org, 
 davem@davemloft.net, 
 shuah@kernel.org, 
 linux-kselftest@vger.kernel.org, 
 Anna Emese Nyiri <annaemesenyiri@gmail.com>
Message-ID: <67b0b10cd4381_36e34429435@willemb.c.googlers.com.notmuch>
In-Reply-To: <20250214205828.48503-1-annaemesenyiri@gmail.com>
References: <20250214205828.48503-1-annaemesenyiri@gmail.com>
Subject: Re: [PATCH net-next v3] selftests: net: add support for testing
 SO_RCVMARK and SO_RCVPRIORITY
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Anna Emese Nyiri wrote:
> Introduce tests to verify the correct functionality of the SO_RCVMARK and 
> SO_RCVPRIORITY socket options.
> 
> Key changes include:
> 
> - so_rcv_listener.c: Implements a receiver application to test the correct 
> behavior of the SO_RCVMARK and SO_RCVPRIORITY options.
> - test_so_rcv.sh: Provides a shell script to automate testing for these options.
> - Makefile: Integrates test_so_rcv.sh into the kernel selftests.
> 
> v3:
> 
> - Add the C part to TEST_GEN_FILES.
> - Ensure the test fails if no cmsg of type opt.name is received
> in so_rcv_listener.c
> - Rebased on net-next.
> 
> v2:
> 
> https://lore.kernel.org/netdev/20250210192216.37756-1-annaemesenyiri@gmail.com/
> - Add the C part to TEST_GEN_PROGS and .gitignore.
> - Modify buffer space and add IPv6 testing option
> in so_rcv_listener.c.
> - Add IPv6 testing, remove unnecessary comment,
> add kselftest exit codes, run both binaries in a namespace,
> and add sleep in test_so_rcv.sh.
> The sleep was added to ensure that the listener process has
> enough time to start before the sender attempts to connect.
> - Rebased on net-next.
> 
> v1:
> 
> https://lore.kernel.org/netdev/20250129143601.16035-2-annaemesenyiri@gmail.com/
> 
> Suggested-by: Jakub Kicinski <kuba@kernel.org>
> Suggested-by: Ferenc Fejes <fejes@inf.elte.hu>
> Signed-off-by: Anna Emese Nyiri <annaemesenyiri@gmail.com>

Reviewed-by: Willem de Bruijn <willemb@google.com>

