Return-Path: <linux-kselftest+bounces-44979-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B22FC3BEAD
	for <lists+linux-kselftest@lfdr.de>; Thu, 06 Nov 2025 15:59:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 250B11B25C4F
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Nov 2025 14:54:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C578345CC5;
	Thu,  6 Nov 2025 14:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PEzINZh4";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="RYUakjPF"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF4A43254A6
	for <linux-kselftest@vger.kernel.org>; Thu,  6 Nov 2025 14:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762440798; cv=none; b=RAfhUUwBfBp3qbT9pnAnAkF7NEhCsYGUuiNx39pMFMLg6lcHwtHzuPPwHEbRBuLCjCu+nYQ/v1FldNTYG3e+6UgsZ9Vw6kHLOVpjDPn9U3DHujOxqUKvMjJmajOk2b784PmuUtDIWzBas79mSkrhtH2v0sTMDEEGNh/YM6QBDIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762440798; c=relaxed/simple;
	bh=0Bi4LHwQ3Oz1+CJ2dXX3nYlqYoDS15IyYtJpQGkCX9k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KRm9PzyOtnp6hNVJboc/SPeqN4tBp3utDJ64WVruFydwtxYkFlir5mzBZlyYXpnpYkfavWPT/MsflnoujweDjJZVihI4FlYnlbRSFa/m9F1D6CBeS5bra76GgfAEiWY/Gr1PDUWi2w2aJP55oQbmjXJulYUSVLF/uusLAVC7iv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PEzINZh4; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=RYUakjPF; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762440795;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zoyCQ2/Ndn55B6FLT+akNdN3gz83tHokFqTe1vC7y18=;
	b=PEzINZh4cDRhqRBdS0i6mmg0Cn/vA2ye6tMkPDFEoJOkcWzqAZzK1/vwwc23VGTE0CCZ+Q
	uFl10R1F5kf6A89St/hfUqoNPOz9zENvTZICdOtj6DEMgexAB2+QQcutYo43vtpHYAIEAR
	KMpjEpBzutqieFqVIPoFYuVxvdDKGh0=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-79-XYwsL4BGPeGqT0p4oXLeSw-1; Thu, 06 Nov 2025 09:53:13 -0500
X-MC-Unique: XYwsL4BGPeGqT0p4oXLeSw-1
X-Mimecast-MFC-AGG-ID: XYwsL4BGPeGqT0p4oXLeSw_1762440792
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-429cdb0706aso768703f8f.0
        for <linux-kselftest@vger.kernel.org>; Thu, 06 Nov 2025 06:53:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1762440792; x=1763045592; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zoyCQ2/Ndn55B6FLT+akNdN3gz83tHokFqTe1vC7y18=;
        b=RYUakjPFBI1nQ6ByJIzNvlePbCJqTmoLqWb7LSgbpmqjTaiLZjm2ODi+vkKuZFaxQF
         tcSj9lqHgLHryg3k3gngUnIA6/KoyUKAiHdh9sBIS1OaCHaljiidS4oGDa/3Sy8uPBFT
         xumpfatHv1vLrt0iERFlnOrt0a+GslFR5a+N6owhFDN0pytct6kpwceJci9ruD/bXetd
         CAmCKK+PvwDcTDPhE+h32qUYk9GHJU4eDVsWHjCzKsEC8dEphFc0INFpajZD4bWm78fW
         lmJSBhdOaDtMIycqhYAQE6akAgaoNQvI2OKrKBB95qllMWmK8tYyRMftjzTqBQLL9fTj
         uXWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762440792; x=1763045592;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zoyCQ2/Ndn55B6FLT+akNdN3gz83tHokFqTe1vC7y18=;
        b=SDG0dwO/jsaxuj+bo+AIIiUL5rkRAyumHRYmeTf34kQ5IBAtFD3LVGcYNrwKAEsiYM
         7Ns7wUdUmXs2MlrDTkdc/9t5o7qvkapHSkEISdPncEsjPnXl4Ds41QKA3Lkp1UnXtmi4
         iXZaktvWf/1iwTfv6toXPB4CVyLb/Xbp0oqm1kb7gkrBgMclsipqYbattLU6adZw7Ap6
         3kLU0FLwzd0fT01aHJ5Z9Y6x/MQ96zgZwHhNJN0IsXhGR7mLkvGoJzKPQS5BIDS5rQ+D
         V6QV6bS/QK09MEi22kVBbTVwOz2H+ndRbdfJcIFLfNK0Z5nizbvfdM7iVda3U1JLklTw
         iDpA==
X-Forwarded-Encrypted: i=1; AJvYcCW+pLI+X7bQWp+2KpWkYU6yDy3DUtMRH8YW1QGPwtaURktWFnsGtOSaD/oz0TuU655hylI2hRII3Emm46+iSp0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzdlFCjheuuMLMEbUR25bDH9j3vbqmJG8iRfbhkWeCgmNGFGlqA
	/07PSvPyMn0fLM4Q1i007rKCSTyJfcbViG2lhblwd3wRVBUsYTEG2oSMFO0nFCq/orDEwZyk3Od
	b8Y/2UQf+tcUY6MUkoqZRbA77xuPHzfNz8abhB/X+F9+1YdnrDnJwg1i2EDmX64272csCJA==
X-Gm-Gg: ASbGncsGeQsLcPR7sNmQkw/G3IHTFsP7hEtNBmkh9w1XTMWfArPJ53WB8Ks7SuYFoQK
	BJKGE29ZUxxZS4qddCzLtvm059p3xzNBiR6lPMWsSvVvdXotLXgoUjhJ/jNw/ro7PK+pjQ6bQ62
	xfg8TFCGw+guvKU0XTE9i6Km6R62L/P6FuUQ+DWQ7LqZ1HrQJns1eI9wyY9ISw42m3RY+90kQl9
	hNrdtsXe9pIKVcwxQ0h5UDqJjNpwDBCElHd+A3FbynLXPBDGIzQksqM04SYmyAz6h4/S7EjOqNB
	PBbOfOJd1goUSERLt2D/jF1Xk+APEX+G2fJeDt5eKDZF7U9vDynE7B6Z78YXPh1MPUBzQM5aeZX
	Svw==
X-Received: by 2002:a5d:5f56:0:b0:429:bac1:c7f5 with SMTP id ffacd0b85a97d-429e330aae1mr6387401f8f.44.1762440792102;
        Thu, 06 Nov 2025 06:53:12 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGK5t7Fq6Zv4jWk7ndZnINKEE6SRIPfe793yxVRVTG7XMWpFYrBjzrI+ymWB1vQzl2d9MBt0g==
X-Received: by 2002:a5d:5f56:0:b0:429:bac1:c7f5 with SMTP id ffacd0b85a97d-429e330aae1mr6387380f8f.44.1762440791658;
        Thu, 06 Nov 2025 06:53:11 -0800 (PST)
Received: from [192.168.88.32] ([212.105.155.83])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429eb41102bsm5566783f8f.17.2025.11.06.06.53.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Nov 2025 06:53:11 -0800 (PST)
Message-ID: <8d9c37d0-b238-4778-b18c-473bddd6481c@redhat.com>
Date: Thu, 6 Nov 2025 15:53:09 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests: net: local_termination: Wait for interfaces to
 come up
To: Vladimir Oltean <vladimir.oltean@nxp.com>,
 "A. Sverdlin" <alexander.sverdlin@siemens.com>
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>,
 Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org
References: <20251104061723.483301-1-alexander.sverdlin@siemens.com>
 <20251105213137.2knkuovcc3jpnhqv@skbuf>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20251105213137.2knkuovcc3jpnhqv@skbuf>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/5/25 10:31 PM, Vladimir Oltean wrote:
> Functionally I have nothing against this change.
> 
> Reviewed-by: Vladimir Oltean <vladimir.oltean@nxp.com>
> 
> Two ideas to minimize the delta in a more obviously correct way.
> They can perhaps be implemented together, independently of one another,
> or not at all:
> 
> - setup_wait() could be used directly, as it waits for $NUM_NETIFS, aka
>   $h1 and $h2.
> - There is no case where run_test() does not need a prior setup_wait()
>   call, so it can just as well be placed as the first thing of that
>   function.

I think both suggestions make a lot of sense, @Alexander: please send
and updated version including them. You can retain Vladimir's RB tag.

Thanks,

Paolo


