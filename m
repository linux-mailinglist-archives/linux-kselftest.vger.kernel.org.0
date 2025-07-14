Return-Path: <linux-kselftest+bounces-37227-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DA26B03B6D
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Jul 2025 11:54:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E76A3162ABC
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Jul 2025 09:54:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAF8D242D83;
	Mon, 14 Jul 2025 09:54:01 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 259BA24291C;
	Mon, 14 Jul 2025 09:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752486841; cv=none; b=XgHej6c8puMo5TOzrBqKlOBMkmtdX2eSJYBBVQx/gmgY9jbF68OZfM+hMoekZXsg9zAo7CeKLA8dFrvzPloySK8jmjViYj7K/6dERzpPdICZnKWWNwWsRNATf3m2P/wvDHO7WbepGrRDmNpomQ4Q+Dy5nEqDkmkip7l3zR5SwEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752486841; c=relaxed/simple;
	bh=LVEVJJXdU2navZDiFimiwkAdBu778EfdOSQ47RGXLTw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EYjPvBqF2T/Q5/sLkUMN50nX0Eg95vs3H1u17KWJXAqIWwPXpAtLPAqvhscvTnJg7XySJddFMsy0CqT9kak1hQrofDHvFu8CRbA3eZQE2JA5VZg6EeTKWYywro0wTB1rbv4Uid4yp4eY/3qKEz4GAugx5IxO32+Abfh88TBDoBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-60707b740a6so6289426a12.0;
        Mon, 14 Jul 2025 02:53:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752486838; x=1753091638;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5+nwQ+gUq+eVRVteBjqQ9zFxb4lMzQgpjj70tq9U1Z0=;
        b=OCP8klGSwKsLhyQMjXVMyFRlnTtLj4KX6rEmPuiNS2Od9lpYSUoAfGoMq5HUARVI7L
         oMgW5YfxsjI4bUbvkZ8JSBn+/KmHaVupUUY2+Brx+WYSyouR/ie7E6eqpj8ibP+GiTtY
         83r5xqMf/WsuwDZ/HENjFaQ6f7sFaEMddRYRfVwIzrDFnrGdZlO9Vv7PcA68TavTOfmo
         xmjS0xpskGS4iskLjPNW/XRdK9qJIcQS3C4JjaiGPCBo579COlTvJRDHj8C49F/qguhL
         TCQbhLJftqNaQLejMPwACOrFpk7T79Q7i6XEQcruauSPd/KWjLhumEtDLVxvBJqC7hJf
         U6vg==
X-Forwarded-Encrypted: i=1; AJvYcCUE7+ORtlsq8V4Adtjy6jVx0P1lNStueDhczP3rwzrv/PwOui5B8ZiwCaAyu9vRPtZqfPg=@vger.kernel.org, AJvYcCVaY6lQT0WwqKR+lthPdjnJ9GIbMFOgzNIGCJrTo8D3+OoExuGzIAftz8Mtz5cRCcB6zMMoPXd4wVeaZxK3@vger.kernel.org, AJvYcCWGPnvP9zYiKBtI8+6OAD6hGblwSw5iWRupL3GjgqI67N9I+zeZZHsPOF7iTIyheH9PgpR0jV7m@vger.kernel.org, AJvYcCXksiaIpSUc26KAIoT9jhjzGwuHsnuo1jFMFFu3TTTpaeJ04/6fU5+d2hzGIBS8f3cb4V82DUU3jwF5kzahOc3n@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1vELCKF3YmL282hAtXOXqBbqfBgdfZaMxbfe2lhGoslwEPveq
	lrnEEGRmlOH3JNCo9ZQmgIRPgfTGyTCw+u6iGiJkoUxF8Y1NjFwvMA21
X-Gm-Gg: ASbGncvEWv5Qs84++fp/5miEZRYcZ8LCk3E0jF/nUq9j/+oTi3NADU9VpT6t4DJJfMm
	UiKIq5Xk0626FvD01SdSLlblwONVvJvU/ys4eqC4muDVEFDaEfZPQLTuJeixjuMJ5v/tsl5m+TX
	Tbhz2whiEWujj2rOHdP3gC+quyQo68C9RTzF3Cy7Bq43oSRHndawG3JlqevkeqTUVDYaa1nmYC1
	oTfTz9SEi9kbSuFKW4GzGaZ80Wp1g9H9S131Un4zak8SBcpKe405c7GRB/M/VAet/0Tie7ZC4tr
	F4EPUVbQtIuaz+04Y0N7b97Kd7XgFBko95nMTKqEyKaPQu91R+6RYhwkFEn2LUm1Xcu1KidYM58
	paJbsuBuV8awI6D2qOfEOxzc=
X-Google-Smtp-Source: AGHT+IFLL9yNozFf9SkrqVC1Oj+fY6Ntdk+aVRqprSaJ8XTyV9GQg8vXooOlt13SfS2/j/4m+75OiQ==
X-Received: by 2002:a17:907:84a:b0:ae3:a240:7ad2 with SMTP id a640c23a62f3a-ae6fc6aa6dcmr1339638066b.2.1752486838034;
        Mon, 14 Jul 2025 02:53:58 -0700 (PDT)
Received: from gmail.com ([2a03:2880:30ff:7::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae6e8294b5fsm780577966b.125.2025.07.14.02.53.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jul 2025 02:53:57 -0700 (PDT)
Date: Mon, 14 Jul 2025 02:52:13 -0700
From: Breno Leitao <leitao@debian.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>, Simon Horman <horms@kernel.org>, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>, bpf@vger.kernel.org, kernel-team@meta.com, 
	Willem de Bruijn <willemb@google.com>
Subject: Re: [PATCH net-next v6 3/3] selftests: net: add netpoll basic
 functionality test
Message-ID: <v3tiskdekzcj4ra4pgd3wegz2wkafp5sfzber3e2i7unj72bsp@sywehjrf45xb>
References: <20250711-netpoll_test-v6-0-130465f286a8@debian.org>
 <20250711-netpoll_test-v6-3-130465f286a8@debian.org>
 <20250711101415.6ae42daf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250711101415.6ae42daf@kernel.org>

Hello Jakub,

On Fri, Jul 11, 2025 at 10:14:15AM -0700, Jakub Kicinski wrote:
> On Fri, 11 Jul 2025 09:05:11 -0700 Breno Leitao wrote:
> > +        rxq = ethtool_result["rx"]
> > +        txq = ethtool_result["tx"]
> 
> Most HW NICs will actually use the "combined" channels (which have both
> rx and tx ring on one NAPI).

Right. I am getting combined as well. With the JSON output in ethtool,
I get;


        ethtool_result = ethtool(f"-l {interface_name}", json=True)[0]
        rxq = ethtool_result.get("rx", -1)
        txq = ethtool_result.get("tx", -1)
        combined = ethtool_result.get("combined", -1)

> > +    logging.debug("calling: ethtool %s", cmdline)
> 
> ksft_pr() ? 

ksft_pr() would make it very verbose. logging.debug() is always
disabled, so, the selftest executes cleanly.

> We had a plan to add a verbose() helper which would still be
> TAP-compatible, but never finished the patches.

I can try to help. How do you want to set verbose during the test
execution? Any shell environment variable?

> Either way, would you mind respinning the series (without the 24h wait)?
> It conflicts with another series which adds a bpftool() helper.
> I applied that patch so you should see a trivial conflict when rebasing.

Thanks. I am sending a new version assuming ethtool -l has the json
option. That would make the code simpler, given we don't need that hacky
to_int().

Thanks for the review,
--breno

