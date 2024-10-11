Return-Path: <linux-kselftest+bounces-19547-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D65F99A66A
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Oct 2024 16:36:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B5B201F22FF7
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Oct 2024 14:36:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50D132BCFF;
	Fri, 11 Oct 2024 14:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UYE7U32x"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C60D1184;
	Fri, 11 Oct 2024 14:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728657357; cv=none; b=lDTZpWAEBCr1u87jgzWkYLvfslnHO0dhZeE+YsDgCjE0AgRYqGd4ktTnSo1SAgUkmxPPmR8MsGTGlwArjNF5jTUiD2m3A0sZ6Mv3rCR3suDo/7U7Tuk9suVqrVLKbZQ7ovai/Z1rVRDeHNVGzBZqENRTVJ8mNeDiMieXfEqzIfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728657357; c=relaxed/simple;
	bh=VJtVOr1F0kavsD9/a77o84vx4Pklcbr397Xt4zHniQ8=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=uCBwXpc3g4lnbGICLCLWvobfeaFuJeInmLAeXtO91eMIRInVVKk8a/JyMpmdYxKIlJNloZiIW+HOqEFIQ3jNGYzhydJp37GUsy/oHaiOi6Mltt9arfgQ15FI859hKS0Nf2/kjL8wCaxLF1RmQYqtoSWPn+wYUWnOAuWpSVSgksM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UYE7U32x; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-45f07eb6f03so20199921cf.0;
        Fri, 11 Oct 2024 07:35:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728657354; x=1729262154; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gWtwD5vM6ArA5v72hf/ot72bbW2hNBRkTyxGVubkvSs=;
        b=UYE7U32xCZYaaXx87DyIVqfG5zcZL2JmLNFMjU8fL0CGG4VClb4Ly6Z3JYzVlTNaFm
         2v/BBg2r2jZiDqA58c/r21yg45c6EDQEGWL46H/kkoDwC+xurwZPLxJ7Y2sEWnRbHe2t
         W0Govj1Q1NqW5GFa3K48V1V4xT8Oa3hFncyruoqHKOUe5LfdMxv4a3brlb8sfPSQ9xon
         BXeRQ2b5Z5bKbLaykwObvZSPfN/zrOmwdoSYK5i1ceURgKcM8KEQoDZym3TofiwgqWmU
         Qocv2uaO6Mra5WmWiiwROcDiLVa0IsChqvnqBQ4lM55z8jncLg1ZXR84q/ubucfl3jAh
         BH6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728657354; x=1729262154;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=gWtwD5vM6ArA5v72hf/ot72bbW2hNBRkTyxGVubkvSs=;
        b=uyf3Z9uy5FwRjOD1q9BHQ+9G6rvJ+92y/PC0CFZR+d3hc99xk6/REw/NTAOnDKA4q0
         q7GId4OFe9iiPrMpHCwcSCrZ+br3g+u1vQOxnF6CDKGTJRrvR9No7qrUmmgmJNBoJA6a
         thUZD+NpsctBa5/t3bNOiRXPxGJKIDWNwfolOYwotmQoSd2J461EDpEFKd/rnHf10ArR
         D00teFy2eXrY6ZnjYKEf8UTw1l+aXtIC1QHKHX+RiuVKY7F5ngw4q77fpUJQ+A0OTkxc
         tadV6xCQO6AWBCo+ODBxiywV3y6JNIe9Tfltg0aZ6tuekivWHWWEGHZ1PGSpeEudZV1y
         GGYg==
X-Forwarded-Encrypted: i=1; AJvYcCUR/mzbso3K0ErHJ+mxBZWc+YkdU10DtHm6JpyJmsN7AxIRn0jbIBa0R4B9IFR477YSPBDSuT/kTTPQsT0=@vger.kernel.org, AJvYcCVhQ3mVv1+Cxl0P27JAHTkKhARgfSkG8CqxCALLVuz9PS1Nuiuq4eNy1V6UQhONKilcIMpyKRGKAG94jBm60ZnG@vger.kernel.org, AJvYcCVxeR9/yRSMbJhp/DekrUpE9rscYWWNF5kKEK12Bnnp57e44wOBxF+q+XjvZMKJM1E28BebqdZF@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5p/KRbGLGKvf09YeMr1Cy0TZG83FbiKKw7KqKdv9Be68zLUK2
	uQJm7dYQp0+vy26T94h2qRj07dF08a2WkKsgPNDvUJM279SgrW8R
X-Google-Smtp-Source: AGHT+IF2HO2JtdSB7zpnnHGgjBBXHOu10wQAgXvvi0ZfmBa+7n308Fu6b2arna1J8z+ro5XKfZOQ3Q==
X-Received: by 2002:a05:622a:1448:b0:45f:c8c3:e039 with SMTP id d75a77b69052e-4604bc93b1cmr40292311cf.51.1728657354609;
        Fri, 11 Oct 2024 07:35:54 -0700 (PDT)
Received: from localhost (86.235.150.34.bc.googleusercontent.com. [34.150.235.86])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b11497a931sm136474685a.110.2024.10.11.07.35.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2024 07:35:53 -0700 (PDT)
Date: Fri, 11 Oct 2024 10:35:53 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Gur Stavi <gur.stavi@huawei.com>, 
 'Willem de Bruijn' <willemdebruijn.kernel@gmail.com>
Cc: davem@davemloft.net, 
 edumazet@google.com, 
 kuba@kernel.org, 
 linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, 
 netdev@vger.kernel.org, 
 pabeni@redhat.com, 
 shuah@kernel.org
Message-ID: <670937c990fca_234aca29481@willemb.c.googlers.com.notmuch>
In-Reply-To: <000301db1bbc$453feae0$cfbfc0a0$@huawei.com>
References: <67054127bb083_18b21e2943f@willemb.c.googlers.com.notmuch>
 <20241009065837.354332-1-gur.stavi@huawei.com>
 <67068a44bff02_1cca3129431@willemb.c.googlers.com.notmuch>
 <002201db1a75$9a83b420$cf8b1c60$@huawei.com>
 <67072012c983a_1e805629421@willemb.c.googlers.com.notmuch>
 <002701db1ae3$368d9b70$a3a8d250$@huawei.com>
 <6707e3028d844_20573a294f0@willemb.c.googlers.com.notmuch>
 <000101db1b2f$7410c2f0$5c3248d0$@huawei.com>
 <67085135e4fe2_21530629429@willemb.c.googlers.com.notmuch>
 <000301db1bbc$453feae0$cfbfc0a0$@huawei.com>
Subject: RE: [PATCH net-next v02 1/2] af_packet: allow fanout_add when socket
 is not RUNNING
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Gur Stavi wrote:
> > 
> > If we don't care about opening up fanout groups to ETH_P_NONE, then
> > patch v2 seems sufficient. If explicitly blocking this, the ENXIO
> > return can be added, but ideally without touching the other lines.
> 
> I don't think that allowing ETH_P_NONE is relevant.
> In my opinion the 2 options that should be considered to fail
> fanout_add are:
> 1. Testing proto == 0
> 2. Testing proto == 0 || ifindex == -1
> 
> The only corner case that is caught by [2] and missed by [1] is
> the "unlisted" case during do_bind. It is such a rare case that
> probably no one will ever encounter bind "unlisted" followed by
> FANOUT_ADD. And this is not a dangerous corner case that leads to
> system crash.
> 
> However, being a purist, I see the major goal of code review to promote
> correctness by identifying corner cases while improving style is a
> secondary priority. Since we did identify this corner case in our
> discussion I think we should still use [2].
> I don't consider the code complex. In fact, to me, the ifindex clause
> is a more understandable direct reason for failure than the proto which
> is indirect. Having the ifindex clause helps figuring out the proto
> clause.

It's interesting that the unlisted fix does not return ENODEV, but
returns success and leaves the socket in an unbound state, equivalent
to binding to ETH_P_NONE and ifindex 0. This seems surprising behavior
to the caller.

On rereading that, I still do not see a purpose of special ifindex -1.




