Return-Path: <linux-kselftest+bounces-30725-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C603A88440
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Apr 2025 16:16:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4597817F07F
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Apr 2025 14:10:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15D782749F1;
	Mon, 14 Apr 2025 13:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="XteWAv+h"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFBEE25C71D
	for <linux-kselftest@vger.kernel.org>; Mon, 14 Apr 2025 13:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744637996; cv=none; b=rzjL3A9GwrT82S/pffolmljV8kwlJqPtpqF/fkAsQdxEvdGrVptKbW0CECyNjQSNQDmfs/N0TxqTUT1cY/YmsjhnwSRjGuFLAsT6lQetB+1s4j6GedHcSFVNTLa6dUGQYJNz4bbdi+fLJY76/aKZsd6QiVxaPaKAlSr/OKLOVq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744637996; c=relaxed/simple;
	bh=NtCW/E8exydYTxFSwUlIDYXeH3TA9ME05Yx8nihFiFg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZrLd98h6jxeFSvja7nx5z+nAQAnUXx2Iz6Pig68H8ETHQ14cT1q9swdqKQQ9wSoLkJDMgIU5H0sTK6XXCT+MpBCGI3QEKHzGiOnE8Y2t6q10qioFQVDM9j/Q/tos+K1GxCcgUuWy0hBwYfstRIikGe9erPE4OC415F+f6cNMvHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=XteWAv+h; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5e673822f76so7709206a12.2
        for <linux-kselftest@vger.kernel.org>; Mon, 14 Apr 2025 06:39:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1744637992; x=1745242792; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ZquJTzO2TMrzx3oM3vRZxn3X9pd2r24oUtQt3eHPnLc=;
        b=XteWAv+h8B74asVCm/j/e0NLRp4TEeKg6pdI/nhhYbAsUNJVE3IKA3re7QUrGNfoC+
         vTfI3OuJKiGhJAiEK/eMQOuQtBkRgxHt/86RkPF6rsaIIUM1JS9hswRObGwZSGF28fLv
         6kKYMPKNZNeBUdW63FI6Iln97wCpqnBahwtJYXskzglvw4RR4qw9BTzYLmSFSyzH04GJ
         nG0mRiJpC8Jfjs8tVIHSkqpg/aC6hJH2O40fgk4DyOFwA9MRHE8r4SoRTpWvEKmjhZge
         C6ZGNXzx5J8XcBhQiD99pFCYJC7895BUXj2W2k6ss5P88v0xC8aQXDKJffcka/FhaBJv
         aW3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744637992; x=1745242792;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZquJTzO2TMrzx3oM3vRZxn3X9pd2r24oUtQt3eHPnLc=;
        b=P65Zt5mcQmp93txxqflnfPnAcAYPYdMk7uvA2H1ISpikWFidvI7gEju1DtEazRqLCK
         NSxPyr0jNJRNIExgyZlFbK+tsH2V91mG3jag8YEO9wrD29QCV5YPcApFrQkTqJUcQzt9
         SMyCjr2zzflwvvTLj8GyBq7u9F7f0q9BP47/Dr6l5HqH5ClUzCIadTSdjOO3g39Z57rR
         UaAl1rvEsv8drXIDYnySDK3yp6U4GxbhHmL08VtA/peh6y9qoLGOO/azWVIGbtCMDP3A
         puQ/U+Dl5o0ItbvNzAtsw95psAXZpZ4mguqtBEqLJUCp/dGfCNpk4fA27PEi6bXQbK2+
         sgSA==
X-Forwarded-Encrypted: i=1; AJvYcCU0NKH/x2Gbo3a3/tKLxF1MIqm3qQronj4rxOhwlpzSZNLifUroVcIJpsCTWcjCYo9qAZXKRjEGziQ0nmm3t58=@vger.kernel.org
X-Gm-Message-State: AOJu0YxdHHYTB0DjJaaBQJDPF1KFJjI+x1S4tQbUtCaMtFPQVp3+dLUS
	eCKfOQK4xrzQLMJBw+0d6iQEKRS32c9X7E8OdwmDxX/gtseTIgHG5NDkku3cQNh02PyJQrqKgxA
	atjznN/lo11AF/tIY5aNPQ3Nui0IVLyLupUF4DwJSdxA++KUuV7syhb8/NAg=
X-Gm-Gg: ASbGncuMeEjAF5Eu3KntViMgUQkCTf+5Mk4uiLG9ZhB6JMuWRJ3KtJT4Hrmz6wyGPVB
	/brrsu9iMZXg0veE6cqO4lc0VL1xWStkO4p1XYcsBM2V975CCMjwybQwvCdxfAIh5ZS/exdw99Y
	2sQmT7tivTNwLzwSONe7YYDBbJzvpBUc0KUhqWq/FDje0TGzACETJRabAkvGzD4Zy5vxjaDfo4V
	4DJbayVJwVSVs4JeunmH3iSsimzPLTfZj67J9FbjiRWuAbycL1bc9scgj5Hrka8OEORCHhqMJ1T
	3WEXtrW6cFavXKS4kOBMnSB5sR13x4HG9l5HjtjH8+k52NV41HtDRSdrklKJ6kxQE0Nk4qR987S
	UZJXU5wee42ksUA==
X-Google-Smtp-Source: AGHT+IFPxNqtw28ADerWg6CufaL1pKk/7NGw4kAzwMNIMYRZtCBUOHqCketsjh37yheEVO4bOxUj2g==
X-Received: by 2002:a05:6402:3487:b0:5ec:f769:db07 with SMTP id 4fb4d7f45d1cf-5f36fefc74amr8488977a12.29.1744637992033;
        Mon, 14 Apr 2025 06:39:52 -0700 (PDT)
Received: from ?IPV6:2001:67c:2fbc:1:7de8:ff34:becd:c8f0? ([2001:67c:2fbc:1:7de8:ff34:becd:c8f0])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5f36ef5c445sm4905583a12.31.2025.04.14.06.39.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Apr 2025 06:39:51 -0700 (PDT)
Message-ID: <963c2166-aed8-4928-bdeb-6acbec2b0ea7@openvpn.net>
Date: Mon, 14 Apr 2025 15:39:50 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v25 01/23] net: introduce OpenVPN Data Channel
 Offload (ovpn)
To: Jakub Kicinski <kuba@kernel.org>, Sabrina Dubroca <sd@queasysnail.net>
Cc: netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Donald Hunter <donald.hunter@gmail.com>,
 Shuah Khan <shuah@kernel.org>, ryazanov.s.a@gmail.com,
 Andrew Lunn <andrew+netdev@lunn.ch>, Simon Horman <horms@kernel.org>,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 Xiao Liang <shaw.leon@gmail.com>, steffen.klassert@secunet.com,
 antony.antony@secunet.com
References: <20250407-b4-ovpn-v25-0-a04eae86e016@openvpn.net>
 <20250407-b4-ovpn-v25-1-a04eae86e016@openvpn.net>
 <20250410195440.3ba7ba0f@kernel.org>
 <f11e8a14-deb0-456f-bb4a-b5e4e16a79d7@openvpn.net> <Z_keORW4OWc8i5Vz@krikkit>
 <20250411141847.6dba6987@kernel.org>
Content-Language: en-US
From: Antonio Quartulli <antonio@openvpn.net>
Autocrypt: addr=antonio@openvpn.net; keydata=
 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
Organization: OpenVPN Inc.
In-Reply-To: <20250411141847.6dba6987@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/04/2025 23:18, Jakub Kicinski wrote:
> On Fri, 11 Apr 2025 15:50:49 +0200 Sabrina Dubroca wrote:
>>> My understanding is that this is the standard approach to:
>>> 1) hook in the middle of registration/deregistration;
>>> 2) handle events generated by other components/routines.
>>>
>>> I see in /drivers/net/ almost every driver registers a notifier for their
>>> own device.
>>
>> I think most of them register a notifier for their lower device
>> (bridge port, real device under a vlan, or similar).
>>
>> I've mentioned at some point that it would be more usual to replace
>> this notifier with a custom dellink, and that ovpn->registered could
>> likely be replaced with checking for NETREG_REGISTERED. I just thought
>> it could be cleaned up a bit later, but it seems Jakub wants it done
>> before taking the patches :)
> 
> Ideally, yes. One fewer place for us to check when trying to figure
> out if we will break anything with the locking changes :(
> Notifiers are very powerful but that comes at high maintenance cost.

ACK, working on it!

Thanks,

-- 
Antonio Quartulli
OpenVPN Inc.


