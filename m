Return-Path: <linux-kselftest+bounces-20918-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1DDC9B458F
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Oct 2024 10:20:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 66B88B21CDF
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Oct 2024 09:20:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14D041E1C34;
	Tue, 29 Oct 2024 09:20:31 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E81BC1E0E12;
	Tue, 29 Oct 2024 09:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730193631; cv=none; b=RedJfG0l7tF6yavgXeo1be0Hg8JRJo04GQukT27nTn00wSD3khokwfbNbk+UagiVlQ6giDR9HpnulgkSxeIJF7g8562WrrJ/oPy0LiXXMGClvj0k+tYHtLYtB1UBTOUdVsK8voTi4iLxfnJyimvvnlpyPBH6L2FYL7WEOQzUjWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730193631; c=relaxed/simple;
	bh=Af2mIKhIRGotDgzpL7eCFa9njSonwVtG3f8IUMpVdj8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cy04MGMKfjp6IsTj7N+HL6GBz7vatdcgYgGjVObrK7ZX2qeeDKgV2en11Xk5KKWtIsKabEsXXO7sqv3sGqtU4uLjwvnQpNDzO+K+5v6tIbR40tvFzsTlaMn7grXhNNVV4VKAPxVKDaSo9wtz23OhyIBs4Mw5VsLJA0Z2F8woAVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a9a4031f69fso700024566b.0;
        Tue, 29 Oct 2024 02:20:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730193627; x=1730798427;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3xN4lpIsKPo3Kxdwucu2GDItju6TFFKBOYt/Wm/ZX2o=;
        b=VV4aFlJS5hGH9AjWXwOTWFPwavFM7FktdFPp0XUs06h0AVS1yL78yMHbUv88YKsuX6
         1XeJiZSK+AMVfPNMjhvHws4qT8E6oCrxlcu15oiEVCU27lFkq9xZp7mDv1AFH7fpA//M
         jJLOuwA8t+XSdpnTIghajOfymH6bUPfKvNVDfN2hpmU4cl9GsZOOHYmwiF8VteCJZ5i4
         Jm5qx5MwS/65DrmBtuJHuGDI9yTInGBLkDggJ+VJXqehzIKss/aYuzvebczF52KInR+s
         zmKEqcFUvgqQi6cIsvgpksI2QrOmDvQ6qwlFw9s8fvujFvBXo/mgW7J5+bkB3FB1TiZ1
         uzeA==
X-Forwarded-Encrypted: i=1; AJvYcCUjppIN+72yvo6HxfHUfhKvVd5g/KvF5/fpcZyM+SzsoOu3014COYKzD6Zb/Ph8UEUQ/j/FKYvv@vger.kernel.org, AJvYcCUuimU9tzuhAt8zZKvkgUhuThbYT5jilhYOT3HsXC0Sbcuk8uWD6XH+mvex+HGAG1OBapZUkO0NegsQEGjWQgUX@vger.kernel.org, AJvYcCXEOY0ILret+njK2NuivwE9Rb0wv4p4F3153llT3Pudkr2ByLovXOGYx4XBfGEeSx+31Fy0uzt7XrMGq/s=@vger.kernel.org
X-Gm-Message-State: AOJu0YyhGXeAs4/ivsrtF9wQiL+Tu3MKD19Xk5aUgV7p52djcJFkmiDb
	zLJuUcZfhbRSPSXhD+xTnsgaEru2kQC4KzXNBmzbye05ZH0RA5rL
X-Google-Smtp-Source: AGHT+IHNus2VsBptL6kuQAA1I6xC1NQoVbZXmlvaVhgUzZphD2XK7I9H2ul2K5D+khMmq1pcl75Lsw==
X-Received: by 2002:a17:906:6a0e:b0:a9a:7f37:2b62 with SMTP id a640c23a62f3a-a9de6167b7emr1237070666b.49.1730193626857;
        Tue, 29 Oct 2024 02:20:26 -0700 (PDT)
Received: from gmail.com (fwdproxy-lla-009.fbsv.net. [2a03:2880:30ff:9::face:b00c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9b3a083dcdsm447968666b.200.2024.10.29.02.20.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2024 02:20:26 -0700 (PDT)
Date: Tue, 29 Oct 2024 02:20:23 -0700
From: Breno Leitao <leitao@debian.org>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: kuba@kernel.org, horms@kernel.org, davem@davemloft.net,
	edumazet@google.com, pabeni@redhat.com,
	Andrew Lunn <andrew+netdev@lunn.ch>, Shuah Khan <shuah@kernel.org>,
	thepacketgeek@gmail.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, davej@codemonkey.org.uk,
	vlad.wing@gmail.com, max@kutsevol.com, kernel-team@meta.com,
	aehkn@xenhub.one, Petr Machata <petrm@nvidia.com>,
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH net-next 1/2] net: netconsole: selftests: Change the IP
 subnet
Message-ID: <20241029-lyrical-witty-pillbug-adb892@leitao>
References: <20241028154805.1394611-1-leitao@debian.org>
 <ce2892c4-f759-40ca-a188-11a83b0164b3@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ce2892c4-f759-40ca-a188-11a83b0164b3@kernel.org>

Hello Matthieu,

On Mon, Oct 28, 2024 at 06:57:29PM +0100, Matthieu Baerts wrote:
> Hi Breno,
> 
> On 28/10/2024 16:48, Breno Leitao wrote:
> > Use a less populated IP range to run the tests, as suggested by Petr in
> > Link: https://lore.kernel.org/netdev/87ikvukv3s.fsf@nvidia.com/.
> 
> It looks like this is the same version as the one you sent on Friday,
> without the modification suggested by Petr:
> 
>   https://lore.kernel.org/20241025161415.238215-1-leitao@debian.org
> 
> I supposed these new patches have been sent by accident, right?

Right. I've resent the v1 instead of the v2. :-|

I've just sent v2 now.

https://lore.kernel.org/all/20241029090030.1793551-1-leitao@debian.org/

Thanks for the heads-up,
--breno

