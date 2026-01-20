Return-Path: <linux-kselftest+bounces-49470-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D2CA5D3C249
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 Jan 2026 09:40:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 5456F4A9393
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 Jan 2026 08:31:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2CE43A9DAD;
	Tue, 20 Jan 2026 08:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hEfHB/ug";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="tmZGoWGf"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43735361DA0
	for <linux-kselftest@vger.kernel.org>; Tue, 20 Jan 2026 08:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768897765; cv=none; b=rIOsY0OWX1nmA6qn/n13/nsbQwqWOEIHSvvFHN5ZG0GRyNkfWh1a5BtujTBla6/qgyEEabVFBuIYYj5DPqdn2fxYTmGAYyCRIkLDsANlNvavlSnNnC5DdXKE581YlldgPcLJKgrBM+EFqMIGEuDFGdQQYo821MiS1BZa2MDEXJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768897765; c=relaxed/simple;
	bh=0F5pRAQiD9A7ImGSSjD4nj69O4xpOqN06FuQAahRYFg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Y5BTHxGDOoAlIOKg92fVONt/36SKrNHRPtgY7UKcnzAWV3bpNydc15/TlItZ4ZQXGAicnK/+y1DOm2uaEwLQx+u5AMZ4cT5Sx7j9ovfozEyPX69iz5oOUKed6TRkwAvHSQKG/Ftk7A1FHX8KA4CqhIyfxRMdMqhfsiayDE+P8HI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hEfHB/ug; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=tmZGoWGf; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768897763;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Mo/4nv+/PrSgsyjtI40Did2BQlBAXqljc5CQXnAr0SI=;
	b=hEfHB/ugYPaSnmLkq+ZSIkpYp8i2L83tr93Ki62+T/XFM8V/XevJWrlE1x4goQ8SEPS097
	ZwlIVOQwq5VUkJ49S+Vgui53+Xa/JprspV8ixmB7wY/vyeR8ctanswJH319hTKPhJqjc4P
	OaH3CDptW2FYu5yqgnogkYTZ76vtVtY=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-424-Fc7o3qhWMsuvS0mtFhXN2g-1; Tue, 20 Jan 2026 03:29:21 -0500
X-MC-Unique: Fc7o3qhWMsuvS0mtFhXN2g-1
X-Mimecast-MFC-AGG-ID: Fc7o3qhWMsuvS0mtFhXN2g_1768897760
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-48025e12b5bso25560855e9.2
        for <linux-kselftest@vger.kernel.org>; Tue, 20 Jan 2026 00:29:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1768897760; x=1769502560; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Mo/4nv+/PrSgsyjtI40Did2BQlBAXqljc5CQXnAr0SI=;
        b=tmZGoWGfUQp5bKq99BNvoFAsxhGLDV5qlHpsCH28x0xyJs8svtvGbJ/DuYYn51a9LW
         2NILBa+FBeGNH1ttgmdB9hM8Vn1HWvub43umd0+BXwZrC3EOSDAGGZ6SatnsJmi8YRiN
         waljM6Pq7mUNbA9fP8CqqOwvIxfmOpZ/uiuQ55LXEAN8IaYwbiyqVNJha0+Ao64V6c62
         KC1632Ckws5EFjv9ga4KQeiXnwLoXO08wINIqR8CMdLwKSStFRmU0TTWJUJkQdsWfKU5
         MQkjd5ol2f63rUd3ZxPgZfxykabxA7l3l+gcSRRNKoXihuBiCYewTwjbikkHTlufiMcn
         /CQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768897760; x=1769502560;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Mo/4nv+/PrSgsyjtI40Did2BQlBAXqljc5CQXnAr0SI=;
        b=ZIMVwqMSegmdT5Bij5jZ6fZyyCRasbpSLvs3gmcCQoAx7NVNeX7p+mwzoqvSZ1APRL
         HReYrdqiyozx9MBypwYm8nTxuc2u1eYbge5F11Rq0t0jryT9BCQm1gADmhHZkYkW+2cN
         c9/9mUE/bfouqhdK01tEH9iCFscbaJNqbR+UCt9PMhu3gs6EyPceAemL9gAK+/FD5lev
         XFsTOmXh8Bg9wazOLgHzRdY21+DNo08ugwPFbl5ww0trZIhkebSBfvqq0xcHgj+SkufN
         XS87SUjywzg2ADYWv5Z/dz/HNil4qE34gEg55FFQ19vXYPehtYjM9tijcV7W6y+cddyH
         cMXA==
X-Forwarded-Encrypted: i=1; AJvYcCVF+CPnGTy/yH/mEtsTHHbGqGJlB4O7dBhvx+i1vwhZUS8znm65S6YnaMaB/4eV8U2UUgJ3D7g+SnmhMuVaI8o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzr7YkRFgHkHhZr8yRQbRQrUAASMdnHjdqfNhHtnAToNkKQzFZZ
	e6LLJaDNfzc06Vlxky7ZgfLN0oWlpP3DG8WgdmWDMUo8pe9/QQVytbgLoLKcYgfym4uLBzomQwE
	IIogyalWrl2K9HyW+PMLEXnImPlcVPmwdi1OB3cwInKij1nfDjS0DFdVTHB4g3w3kqTwg/g==
X-Gm-Gg: AY/fxX4Wkg9r43S1mqYibM7JiAbkIsloJDB6YltF92w8zRJo6LkIXRtiUHmKzVoWUA2
	AG2PG/HiyRLTT5XEBLPewP88X8VyklYbYZdaNgTnh25E3rWyJUyjA/uGsxym6g8V1c22Y11PFYA
	X7GXt3FNrZz1K/3gjdYJ1wkXidtArQYTY2EL5JhY5jpPfzrvh8eEfvNIDReLRrKdEwVCtjDWd/w
	vFP08iZerG32+0JZZnmxd4WdaV37r9Xf2u+M5//C3QCHPg+9JluFlx41ADMOwXyvr2US5oNWBuK
	oiAWdqLfZggydg7N4gccwh5+2bEqH/pLi4AQ5WZ7hjxmBOPoPwtKQWSSi/BJs++R7MYWlaVTlCZ
	E4R5LYpvuIHaR
X-Received: by 2002:a05:600d:644f:10b0:480:3b4e:41ba with SMTP id 5b1f17b1804b1-4803e7e8548mr9365815e9.18.1768897759983;
        Tue, 20 Jan 2026 00:29:19 -0800 (PST)
X-Received: by 2002:a05:600d:644f:10b0:480:3b4e:41ba with SMTP id 5b1f17b1804b1-4803e7e8548mr9365495e9.18.1768897759618;
        Tue, 20 Jan 2026 00:29:19 -0800 (PST)
Received: from [192.168.88.32] ([150.228.93.113])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47f4b2672d6sm296787775e9.14.2026.01.20.00.29.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Jan 2026 00:29:19 -0800 (PST)
Message-ID: <71e30492-7644-4d4f-aaab-9a505f8faae3@redhat.com>
Date: Tue, 20 Jan 2026 09:29:14 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv2 net-next 2/3] bonding: restructure ad_churn_machine
To: Jakub Kicinski <kuba@kernel.org>, Hangbin Liu <liuhangbin@gmail.com>
Cc: netdev@vger.kernel.org, Jay Vosburgh <jv@jvosburgh.net>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Simon Horman <horms@kernel.org>, Mahesh Bandewar <maheshb@google.com>,
 Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
 Liang Li <liali@redhat.com>
References: <20260114064921.57686-1-liuhangbin@gmail.com>
 <20260114064921.57686-3-liuhangbin@gmail.com>
 <20260119122203.5113b16f@kernel.org>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260119122203.5113b16f@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 1/19/26 9:22 PM, Jakub Kicinski wrote:
> On Wed, 14 Jan 2026 06:49:20 +0000 Hangbin Liu wrote:
>> The current ad_churn_machine implementation only transitions the
>> actor/partner churn state to churned or none after the churn timer expires.
>> However, IEEE 802.1AX-2014 specifies that a port should enter the none
>> state immediately once the actor’s port state enters synchronization.
> 
> Paolo, how do you feel about his patch with 2+ weeks until final?
> The first patch is definitely suitable for net. If this one is not
> it should not have a Fixes tag. I'd lean towards getting them all
> into -rc7 if we can.

My personal preference would be for 2/3 landing into net-next: the code
looks correct to me, but refactor has IMHO still to much potential for
regressions do land directly into net and the blamed commit is quite old.

I suggested targeting net-next while retaining the Fixes tag as we
already had complex fixes landing into net-next in the past.

/P


