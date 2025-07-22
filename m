Return-Path: <linux-kselftest+bounces-37800-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 95B15B0D444
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Jul 2025 10:18:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD5B73BBCED
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Jul 2025 08:17:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12C992236FC;
	Tue, 22 Jul 2025 08:17:56 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from proxmox-new.maurer-it.com (proxmox-new.maurer-it.com [94.136.29.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDDEF28937F;
	Tue, 22 Jul 2025 08:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=94.136.29.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753172276; cv=none; b=UL3vMkn874CAv2i+sD4oCCkCnYYvz98gBIl295GDSaS9SxPcT0PrYNIrVWIHrWgvikE8iZAj1jI+UQiG3yLcgDw9CBWIC4m4fol4R9jHUpEjSA6PKwWkoOkKPTSM9R3G9cJzvQ3K46kaQPM4Gc8GbN3Lzw84RnKo+LmHFo4NrPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753172276; c=relaxed/simple;
	bh=YDu4Ed5iTDNExQ/ODpQI7e2wAhHDp24J3HmABmlE35c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bZSdlp8mh6BQnbXTWjXdMWvPycI4NHD9q+FowCHWsuy2B70BmnhdYvKwKZPd3q7pfHFsrTNjjY4mgxm8GcuE1gj0gjQK92mX2fw1UZ6IJE428iMDcL64nbCm3DmIsHgpUrNMnGiIOR81CSfnmVjpG7kaoEiSdcW/xuRLlfKWgJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=proxmox.com; spf=pass smtp.mailfrom=proxmox.com; arc=none smtp.client-ip=94.136.29.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=proxmox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proxmox.com
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
	by proxmox-new.maurer-it.com (Proxmox) with ESMTP id 6991C42C79;
	Tue, 22 Jul 2025 10:17:44 +0200 (CEST)
Date: Tue, 22 Jul 2025 10:17:43 +0200
From: Gabriel Goller <g.goller@proxmox.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Nicolas Dichtel <nicolas.dichtel@6wind.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, David Ahern <dsahern@kernel.org>, Shuah Khan <shuah@kernel.org>, 
	netdev@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next v6] ipv6: add `force_forwarding` sysctl to
 enable per-interface forwarding
Message-ID: <hf2yl42fk2dy7nbrwkhcxkp6eaopv2mnjiuh66ehgk3eevyeq3@edkzqjrcprkp>
Mail-Followup-To: Paolo Abeni <pabeni@redhat.com>, 
	Nicolas Dichtel <nicolas.dichtel@6wind.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	David Ahern <dsahern@kernel.org>, Shuah Khan <shuah@kernel.org>, netdev@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <20250711124243.526735-1-g.goller@proxmox.com>
 <cb12d567-6654-48b0-8443-522aaddcc406@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <cb12d567-6654-48b0-8443-522aaddcc406@redhat.com>
User-Agent: NeoMutt/20241002-35-39f9a6
X-Bm-Milter-Handled: 55990f41-d878-4baa-be0a-ee34c49e34d2
X-Bm-Transport-Timestamp: 1753172255104

On 15.07.2025 15:34, Paolo Abeni wrote:
>On 7/11/25 2:42 PM, Gabriel Goller wrote:
>> It is currently impossible to enable ipv6 forwarding on a per-interface
>> basis like in ipv4. To enable forwarding on an ipv6 interface we need to
>> enable it on all interfaces and disable it on the other interfaces using
>> a netfilter rule. This is especially cumbersome if you have lots of
>> interface and only want to enable forwarding on a few. According to the
>> sysctl docs [0] the `net.ipv6.conf.all.forwarding` enables forwarding
>> for all interfaces, while the interface-specific
>> `net.ipv6.conf.<interface>.forwarding` configures the interface
>> Host/Router configuration.
>>
>> Introduce a new sysctl flag `force_forwarding`, which can be set on every
>> interface. The ip6_forwarding function will then check if the global
>> forwarding flag OR the force_forwarding flag is active and forward the
>> packet.
>>
>> To preserver backwards-compatibility reset the flag (on all interfaces)
>> to 0 if the net.ipv6.conf.all.forwarding flag is set to 0.
>>
>> Add a short selftest that checks if a packet gets forwarded with and
>> without `force_forwarding`.
>>
>> [0]: https://www.kernel.org/doc/Documentation/networking/ip-sysctl.txt
>>
>> Signed-off-by: Gabriel Goller <g.goller@proxmox.com>
>> Acked-by: Nicolas Dichtel <nicolas.dichtel@6wind.com>
>> ---
>> v6:
>>     * rebase
>>     * remove brackts around single line
>>     * add 'nodad' to addresses in selftest to avoid sporadic failures
>
>I'm sorry, but it still does not apply. Please rebase again and re-submit.
>
>Thanks,
>
>Paolo

Thanks for the review! Rebased again, should apply now.


