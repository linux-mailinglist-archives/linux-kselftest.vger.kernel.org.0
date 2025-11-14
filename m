Return-Path: <linux-kselftest+bounces-45639-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 928FFC5D00A
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Nov 2025 13:04:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 18C39420DF8
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Nov 2025 12:02:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A97543148B1;
	Fri, 14 Nov 2025 12:02:30 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18D9B30EF6E
	for <linux-kselftest@vger.kernel.org>; Fri, 14 Nov 2025 12:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763121750; cv=none; b=MMYhK0Oa7F1tH1U4b/O0j2a+bHbQ4yat7H/K0i/wSOmrYtvK5Si1dbEqe7hMLbML27pVuS1qxCAl8OCXi2oo6zXhHV58HeOOkQixdEhOR4jgVLrS7pLCmO00ddNa2dBBoLPFfTf2KNzXRYHHFyiLH+QNvtvlDClzMBLpdka5i6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763121750; c=relaxed/simple;
	bh=P2rDbxLN99bxs6YPpinBiTSsEfXXewl5hHR6vjb3rvc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bSUqRMCx5Hkw1W+GtJS5Tx9XgGiMK6p9V2W4wjYUZtvDm1ciPBwbaO+q4odpQMNaFKXmIJwmEZda6ObzheeBAKZ386ghADn5iCQBpN27DrfS6TR/mNHA3WHICyOXsAULClaQ+jlR3Qc0R3jXgr7UrsOa4ruHYat6+ngJJtzwMog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-7c2846c961fso1341128a34.2
        for <linux-kselftest@vger.kernel.org>; Fri, 14 Nov 2025 04:02:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763121748; x=1763726548;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qUMb8rT5vzNFBptKdq2Qr+S+DTsITygruouKMFYJoco=;
        b=wc51ZPi4ADDRnkMUOO4VUaXR2hBiZRtzSwuvU89jib7wKkA+iO25kfcJqYD8/hNFxo
         FeS/Ij8yxotgXvZrxuaNbr987x99eS6pcG2G226kyr7xoDc++RrLnyIm9QBvE3u6jovG
         C1lBBQuOpNEoSuPtWnxzbiPTebYrPBypYSB4aWsd8Ef5hnbf3IPITPt76z+HqAVTC+4m
         QSYpe9xzCgJjY/gOe5x05TxfTkj2HjUh2zO86pGSD0TwHyU+VQpWkUQOysdlxcFSmBPf
         TPR+Y6oQJfE2tQMkJbyRb/YKTiHoPd0grB5OiYQLlX2BuOfAn1U45I3mhMoyq+atzwFg
         lBgA==
X-Forwarded-Encrypted: i=1; AJvYcCUa04TNZWxDgE/cGTBbkYdDGbETjNCRfDr24lVAHvI4TqJFc7wmyEG9onbLwr2O2HCBQW8+aoBETJDZT00YAkA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOhXct/HjSyjaeisR3EOOqenekscg6PwrgJ0Ioh96zrhcMGkAo
	JRVDKfI+p0THWebsBNCUGZKqIZtlqq5PWBhlZH+hG3a4J/rB9xeTE4p/
X-Gm-Gg: ASbGncs8MHVAGoo2WTeSvVzQz3aed951nX4MsIhUkHxdWOZq+p7qbrIVF9CyhwylQJ4
	Bv7r5euQSxGhUC3FdlMQU7PmerSoZwmjHnEB9EpiezYU798Pg0FPsVYsZEQ5595y0oEvfmmzqu9
	vUxaXKY8M3mjE4B3RbjFbZwG954VnY/R2QOS9wdnWw43aPrIp0iDMGN5aZsNZcjpeJ1ZKPQOuaD
	JR0eSVAZ923oLbDkghgmTSJKwyL+488HUR+Z5Vr6DvjoClrrdbS8Pc5A8PNhH2hULT0IeRuoXp+
	ESftJtUQJUOB/hDZ82tn1A44OGqcs/yaKc9L+L1V+p40upBcTVEmN8/SbE//yHljMf5O8npCPRS
	AsKkOgKiHTjGwrL8IzYoipzpF0hedQd8RFL4KUSgNyjGG5OQvuxMXturPGXH9Do4tRFJeEPVp7j
	ci1Eg=
X-Google-Smtp-Source: AGHT+IFj5d1/PW8sqxWgMu4/IMgSKSuw1jOqaWOp4Y/7Javx+X8Crn+xn0RTmUXT0VZYyIRBs2mAcQ==
X-Received: by 2002:a05:6830:920:b0:7c2:779a:5c4f with SMTP id 46e09a7af769-7c7442aed40mr1473379a34.2.1763121748040;
        Fri, 14 Nov 2025 04:02:28 -0800 (PST)
Received: from gmail.com ([2a03:2880:10ff:43::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7c73a3bddd2sm2421111a34.25.2025.11.14.04.02.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Nov 2025 04:02:27 -0800 (PST)
Date: Fri, 14 Nov 2025 04:02:25 -0800
From: Breno Leitao <leitao@debian.org>
To: Gustavo Luiz Duarte <gustavold@gmail.com>
Cc: Andre Carvalho <asantostc@gmail.com>, Simon Horman <horms@kernel.org>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next v2 1/4] netconsole: Simplify
 send_fragmented_body()
Message-ID: <f3zsfjju6gsnpkq7ikxamlkncmirtvbt2fdieyqbpfbfyjjmkg@d3ezd47cqwip>
References: <20251113-netconsole_dynamic_extradata-v2-0-18cf7fed1026@meta.com>
 <20251113-netconsole_dynamic_extradata-v2-1-18cf7fed1026@meta.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251113-netconsole_dynamic_extradata-v2-1-18cf7fed1026@meta.com>

On Thu, Nov 13, 2025 at 08:42:18AM -0800, Gustavo Luiz Duarte wrote:
> Refactor send_fragmented_body() to use separate offset tracking for
> msgbody, and extradata instead of complex conditional logic.
> The previous implementation used boolean flags and calculated offsets
> which made the code harder to follow.
> 
> The new implementation maintains independent offset counters
> (msgbody_offset, extradata_offset) and processes each section
> sequentially, making the data flow more straightforward and the code
> easier to maintain.
> 
> This is a preparatory refactoring with no functional changes, which will
> allow easily splitting extradata_complete into separate userdata and
> sysdata buffers in the next patch.
> 
> Signed-off-by: Gustavo Luiz Duarte <gustavold@gmail.com>

Reviewed-by: Breno Leitao <leitao@debian.org>

Thanks for this refactor.
--breno

