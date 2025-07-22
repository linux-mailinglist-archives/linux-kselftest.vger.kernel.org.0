Return-Path: <linux-kselftest+bounces-37801-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C99BB0D44B
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Jul 2025 10:18:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E3C0B3A1D53
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Jul 2025 08:18:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80F7C2D3ED0;
	Tue, 22 Jul 2025 08:18:25 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from proxmox-new.maurer-it.com (proxmox-new.maurer-it.com [94.136.29.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 546A72D372F;
	Tue, 22 Jul 2025 08:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=94.136.29.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753172305; cv=none; b=WJkRwvF2q5CKXlCy/y+eol14Pm+T5AxmcoMmOLYf3dgi17UNoIe0jSAZdNo+x1yaylSF5q6gGvJZwTYE9tAUdErND+po4t9i7u+JDzFojN5y7nJy8fJ8EESBXIhSJLHyLvM56D15OI9i5R+j7SDiDYwk+m0bqS+oLV6fnyOvkqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753172305; c=relaxed/simple;
	bh=Y9fbfBmMFOxyDXvi2W/7wKvwEvSCnh/FLCPdTfB8nIE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XJVl41PHrsgtUWAA9QaQWApRnTjglw1B3Cp8YFtgabkcDzGml2l3jCrWUCDDphzvPNRYtuUsfFFdL5QT7QkOcr76/drcsw3M1JYmhu5kVhrpMfRDtdeFL01eDcHlp37Erxhr2nD0E4Q3NZqvAPblcpp6y+3sOlyh5Oluk7CrDlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=proxmox.com; spf=pass smtp.mailfrom=proxmox.com; arc=none smtp.client-ip=94.136.29.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=proxmox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proxmox.com
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
	by proxmox-new.maurer-it.com (Proxmox) with ESMTP id 4A0FF430CD;
	Tue, 22 Jul 2025 10:18:21 +0200 (CEST)
Date: Tue, 22 Jul 2025 10:18:20 +0200
From: Gabriel Goller <g.goller@proxmox.com>
To: Markus Elfring <Markus.Elfring@web.de>
Cc: netdev@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	David Ahern <dsahern@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, Nicolas Dichtel <nicolas.dichtel@6wind.com>, 
	Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>, Simon Horman <horms@kernel.org>
Subject: Re: [PATCH net-next v6] ipv6: add `force_forwarding` sysctl to
 enable per-interface forwarding
Message-ID: <x7g3fqj2bn3u345kb5ifh7rcfqprkt2squvfk3qd3ex5fviqbe@kigwj6kiykit>
Mail-Followup-To: Markus Elfring <Markus.Elfring@web.de>, 
	netdev@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, David Ahern <dsahern@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	Nicolas Dichtel <nicolas.dichtel@6wind.com>, Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>, 
	Simon Horman <horms@kernel.org>
References: <20250711124243.526735-1-g.goller@proxmox.com>
 <01498bc3-4885-4b6e-a437-af3dca58f187@web.de>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <01498bc3-4885-4b6e-a437-af3dca58f187@web.de>
User-Agent: NeoMutt/20241002-35-39f9a6
X-Bm-Milter-Handled: 55990f41-d878-4baa-be0a-ee34c49e34d2
X-Bm-Transport-Timestamp: 1753172292245

On 15.07.2025 21:00, Markus Elfring wrote:
>…
>> a netfilter rule. This is especially cumbersome if you have lots of
>> interface and only want to enable forwarding on a few. According to the
>
>  interfaces?
>
>
>…
>> To preserver backwards-compatibility reset the flag (on all interfaces)
>…
>
>  preserve?
>
>
>…
>> ---
>> v6:
>>     * rebase
>>     * remove brackts around single line
>…
>
>               brackets?

Fixed the typos.

>Regards,
>Markus

Thanks for the review!
Submitted a new patch!


