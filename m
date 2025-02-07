Return-Path: <linux-kselftest+bounces-26012-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D44CA2CA08
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Feb 2025 18:21:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 351371882595
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Feb 2025 17:21:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4720C18FC72;
	Fri,  7 Feb 2025 17:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KIqcBo1A"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBBAC23C8DE;
	Fri,  7 Feb 2025 17:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738948866; cv=none; b=WoiPuhMI/7bQtFpyr95Ro1Du1s2mEw8I6PlynhsbEkkxMV5Tf44TeI/Kb/PH1Qi+IXRLVW8sDga9JX/l02IVkoOOLRkuQFx/fBH1VxjiwV/KTdslpF1pBcEhPdYDIJTwsDdW7xhbFqH4pGHnamXFO38CAL1MiYv+bmtyICfzwh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738948866; c=relaxed/simple;
	bh=JFEi2wLeGZOf8BHQEKqWbZM9NCkw6C1VmawHgv9xFhs=;
	h=Date:From:To:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=H+bEB7VOuaITccd7U/NU8xwT57/sOtVbZ5pPv6iRzRZE3kTRlKLS9quX+5rxWmyfVUPj/8yqNWazDq0ibpPw/awOooGcOkYsv7sEMqDezBwsjAnaUUWgb5WsU2waWLXQgZCRKvsAaRgMO+lY7H9dwkphj2rxH9987Kl4D7LMsP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KIqcBo1A; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-7b6ed0de64aso198749185a.0;
        Fri, 07 Feb 2025 09:21:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738948863; x=1739553663; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ScPbdVpBxzYO8pUJQAAuO4Xb4212ZYcCAfsm5wTEeKs=;
        b=KIqcBo1AT9fu92qctIGLSlRIImLC8b5o5ODaxl3D30K5VQgs1cH58sWQT0Majy+bZQ
         6OYB2/N6bjWD86G3q+8BxcsuhbZp8oFVCuIjwh6GXwRsw25N6vi5m29npLHozj3+eXGi
         GovMLdmos99/b2izHTA7GYHfLiGKVfj4xv6MIKUR1/oJiDzSiNaDqB/zCLnMJKEWhezd
         zRHik3aDHtxoXQDxiDvkIXHfsztysK++5u3n3G5XMw72riBb+E/KrEoM6cpduigUrlOe
         I2cOl4J95KiD4u3LuZtHFtZ2BJXSGWatVBThJPZDUht4upZNEQhojvTyI0WNAGCO5Vmq
         oQ6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738948863; x=1739553663;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ScPbdVpBxzYO8pUJQAAuO4Xb4212ZYcCAfsm5wTEeKs=;
        b=FeYsNvHEZ9c++ZlCyxu0E5FUEBnYkMNEIJs/uQ4v1TfYiafrhrKx9Eoe/u7QC0t1L0
         edpRrrXAlEZkMVazkXW2qBHqSqtLEmgWPqGP7ZWtxhE74kLjvXJZsQ8cGB9FcbG5Mvxb
         Vf2r5qZZJALWG0bNieVbwpFwNSTNjQ6NSc2b2gPml5PClWn6iXFTcGw0biWGltOcWc5C
         FFW0x8c+Lm8kpXjKC/Yg7g5omi8JWmRlp7ydg93p861pMQ8MlwGmkc000sGwHusEIFaL
         XLrVstfSuFXty3I1sESCsEwo+klIGi5ocvqArWa6QqQDQ1eAZbe05x0dm0Vb6V9euzpl
         sd8A==
X-Forwarded-Encrypted: i=1; AJvYcCVK/z6NFVJQ2hQlb+Ecpz74yHSZt3zHbvU7UX2crQ77DZf/EiITLFbistZkmqgSqEj7yrpHrMg+@vger.kernel.org, AJvYcCWcuCsUWNnP7CtUQuH3b8qUvyio+w216OuPt2TS5P4K3VchIq2mAhtlM0/fASrSRe7c56jXrKpsh7QQnLfE@vger.kernel.org, AJvYcCWsYA8psSvF9NGcLaC4JXDXHLAvEJfX3NiYtZBHDr+NAnz/wGUQAmp4Px5ubmE8rBujh0r8uG7ltmKn@vger.kernel.org, AJvYcCWyql/VHvjvRzYQZ7O6wLxDpkU3Ysy/H145WcYFA0P/GavhLvsPbTTe62g07cGRAYNR+7w=@vger.kernel.org, AJvYcCXIcuBTntJZTlwha1HunBLObztDAa8tUcrkyt/fqfG2ArvhOMsH2VhN8HCkZrYIdFUj6SwAUKXtXkasWOafwQQf@vger.kernel.org
X-Gm-Message-State: AOJu0YzvyIjs68z4V4YMtL47e6z6d9TxqzoWyGDQuI9A+ayqu3Fc/opH
	YkQ4MiOCqDnw2yJAScTEawtvnFnLZX2YBm2NTC7kkbSWoa0oEPPU
X-Gm-Gg: ASbGncuiw6B9x8zBGt1gw+128CLmcz7jtzAMr/74fr4eGS+HKaGqtpFH2sI2BFIIlRM
	eYc4XczaQAkvci1t213qqbX1aJJo/dl6BMy8qSYEKDjXhE+QsaBJsb8Sxe9DPlZpmpieeSXKQyq
	BfRDBVtbgLULiP/6e213bMNH8ewfofPBRgwlRQt7G2E/FZOqOWfPykz+XFCW+bASxvgh98Lzm0k
	H9XLQhprAf/cxSsgahz37fIpD+HMuE+wQ4YjBsgHyrAuAMCiHbPGkp+SlXXHTBIXMkOK0b6vsT5
	jA76tFq5lZNMHmxexc3fVgfxVTPs1HR4PChYrGEgtnBhGPsWZ+g0Dy2V80gqBuM=
X-Google-Smtp-Source: AGHT+IHgZz+O/0cXEsGoAckImVPwPZ7eUzYlDFm7WldQdP2qrllz9Oq9gpborPR1otvsihBd6dfnxQ==
X-Received: by 2002:a05:620a:3909:b0:7b6:67e1:b4ff with SMTP id af79cd13be357-7c047f25a93mr564417385a.28.1738948863537;
        Fri, 07 Feb 2025 09:21:03 -0800 (PST)
Received: from localhost (15.60.86.34.bc.googleusercontent.com. [34.86.60.15])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c041e12947sm213396785a.57.2025.02.07.09.21.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Feb 2025 09:21:03 -0800 (PST)
Date: Fri, 07 Feb 2025 12:21:02 -0500
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
Message-ID: <67a640fea839a_2b3e7e294e8@willemb.c.googlers.com.notmuch>
In-Reply-To: <20250207-tun-v6-6-fb49cf8b103e@daynix.com>
References: <20250207-tun-v6-0-fb49cf8b103e@daynix.com>
 <20250207-tun-v6-6-fb49cf8b103e@daynix.com>
Subject: Re: [PATCH net-next v6 6/7] tap: Keep hdr_len in tap_get_user()
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
> hdr_len is repeatedly used so keep it in a local variable.
> 
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>

Reviewed-by: Willem de Bruijn <willemb@google.com>

