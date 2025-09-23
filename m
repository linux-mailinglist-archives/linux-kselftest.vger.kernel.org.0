Return-Path: <linux-kselftest+bounces-42140-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1110B95008
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Sep 2025 10:32:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E05B2A69CC
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Sep 2025 08:32:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A20C3191BD;
	Tue, 23 Sep 2025 08:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GBUjPX4Q"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C9D02D6E76
	for <linux-kselftest@vger.kernel.org>; Tue, 23 Sep 2025 08:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758616350; cv=none; b=QeOPgp+lR+PIIXuT0sGerlQoLcSjv0PgwVP1nP6Y52jjCLyLu/ABmKKpFen6IhgBVpFC3j9283N2T0s7ARcQgMwJgBk28DlR3+go1e101TMJMlAmBn4AMWfg3LjjfnDG+X+61hq3y27+RNVXzCX0vZzznFcIwqFC5sCz2iS+rzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758616350; c=relaxed/simple;
	bh=NiZilVO952t8xhzkfD3k2tB4t5QzfJ5IvxtJx2lENi0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kgh2xQU3C77aSUW3fTrHAk8Qr4ldsID45ITcZbmwZ0SxYuVocV5syXDV8Zgo5zccIMan/IOLsAIEB5EcHpufQhqWtWQPFTnYzspaRKwiF9zjMhsaJ5fT+TvMJ2z/CDxwZWYcER9wNWlVc0wDFBf3WepwtQ66zbFc+7HaSpmuT4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GBUjPX4Q; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758616347;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AofCBIF9FsjYV+UgMxZqWzFMIGGZG+5eyuxtGxpb2KA=;
	b=GBUjPX4QfcKVkLivVduw5rOxE3cCbhPEVDuJuuiYKXJjWNl+0YABEs6kUhRVSPp8+H+c/Z
	i/v22SuTheLKU5cwRUMfcBe9ZdKIFqTDijLoEHimKRkMsBVlq1mKkUnjN+83rxSew35vx/
	8HN05gnhYKN4fPldrdSXwBMYFyPr068=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-629-TNRZN28GOXS3HAOrGKrLuw-1; Tue, 23 Sep 2025 04:32:25 -0400
X-MC-Unique: TNRZN28GOXS3HAOrGKrLuw-1
X-Mimecast-MFC-AGG-ID: TNRZN28GOXS3HAOrGKrLuw_1758616345
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3ecdd80ea44so1591755f8f.1
        for <linux-kselftest@vger.kernel.org>; Tue, 23 Sep 2025 01:32:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758616344; x=1759221144;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AofCBIF9FsjYV+UgMxZqWzFMIGGZG+5eyuxtGxpb2KA=;
        b=nantlUzdAosrUY/goZZPI759JmdL9Uj9Iwo322KdtQUGC7mB6dA8BIzd2yVBaFG69s
         6DdLG7zzEPIYh2gxogYMbbWxEC4FswkcuIbhtNdkjvNaR+bBuoRrvhMQ67DMrUBooHas
         M++JMqGsBP4kd1Rh7jDADCTxEb2IHxH7r4oPb/mOEhWYot0bb0W0NDXziDTlX/ikMxgW
         h9vqKR/ayfps7LNlZzAS3QffhFnyQ+kSImOgBDs0ux2CVJZ5rDOCSBizMyfIFZLUfSLE
         +hUjwCZvTkoFgxpdE7xOI3esPSw8quM+TXN8NbLb61061mcA1GcNIIJTr6H/i5lou6f0
         3/QA==
X-Forwarded-Encrypted: i=1; AJvYcCXMPG0jKl4OF4aOjXQNIL82dJS0CefEVtvtUy2gmKD0Rh+Skvcu4SkV9bAb48ri7Ria7GH8FSeFBQ+jk6IWo2E=@vger.kernel.org
X-Gm-Message-State: AOJu0YxaN2IE8x86X32HzuT8Y81R4Ba1MR6OPxjh9ZwlPNacBVUaDcF8
	YYQs2NMyFsRo7Ut2agVogNUB4rX94thKwBu3UtVtKRjroAqO+3WIcAtcHts9p3PNYFpFDCXat5f
	29HC1sK/x6ExSozNTgWVeaY9KH4XTGH9nLNVZll46RNtSdpBu0RuSsNoUeiPTqutkZrQ3oQ==
X-Gm-Gg: ASbGnct2cVp83kpM/V6CiMnQ4e9IZv8G7aOB6gvDAhUFZZUCitYxhtNFzbt/4CvN6Cu
	H+NDUARjHqjGgeMiZxnldhaQ2mA1R+cN9xDHcf03Zwlkh9GZts0pPC5oomnJ7k/0cEc4FUlWSmP
	xaOQo7vpvIRkLqqZ0jdDjQz/OHXt9eFGivWB4GtJWKCItzn1lpaFX382Wzb6yM1J0VhBYNKR2Y8
	w5lbJL+eBLwIfyQAnkSz22NuzFODM8hiz7IMEb2ZHDEoRcYqFvkX65Y9dOhMQI/Ty50GDX4opiz
	Aa5zoNUZYsgIy3fwHn61FmZzzXSdvKqaE0cah7jmHC8e5ZzhSmtfh7A8kj+V7RC7IJKxStjDNxO
	1vb6AZQKyvGbr
X-Received: by 2002:a05:6000:2484:b0:3fd:7388:28a with SMTP id ffacd0b85a97d-405cb3e57efmr1100221f8f.8.1758616344553;
        Tue, 23 Sep 2025 01:32:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHNRhUtcGLLr4h24SLafmawf/1r1TuWen0JWEexdyB4FM711uxWMVzCfOmriGj/xPN14FiEAg==
X-Received: by 2002:a05:6000:2484:b0:3fd:7388:28a with SMTP id ffacd0b85a97d-405cb3e57efmr1100193f8f.8.1758616344066;
        Tue, 23 Sep 2025 01:32:24 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c? ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-464f0aac271sm231480095e9.3.2025.09.23.01.32.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Sep 2025 01:32:23 -0700 (PDT)
Message-ID: <ae9f772b-d1fb-4688-a809-b4507060d205@redhat.com>
Date: Tue, 23 Sep 2025 10:32:22 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv2 net 2/2] selftests: bonding: add ipsec offload test
To: Hangbin Liu <liuhangbin@gmail.com>, netdev@vger.kernel.org
Cc: Jay Vosburgh <jv@jvosburgh.net>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>,
 Shuah Khan <shuah@kernel.org>, Petr Machata <petrm@nvidia.com>,
 linux-kselftest@vger.kernel.org
References: <20250918020202.440904-1-liuhangbin@gmail.com>
 <20250918020202.440904-2-liuhangbin@gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250918020202.440904-2-liuhangbin@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/18/25 4:02 AM, Hangbin Liu wrote:
> diff --git a/tools/testing/selftests/drivers/net/bonding/bond_ipsec_offload.sh b/tools/testing/selftests/drivers/net/bonding/bond_ipsec_offload.sh
> new file mode 100755
> index 000000000000..4b19949a4c33
> --- /dev/null
> +++ b/tools/testing/selftests/drivers/net/bonding/bond_ipsec_offload.sh
> @@ -0,0 +1,154 @@
> +#!/bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +
> +# IPsec over bonding offload test:
> +#
> +#  +----------------+
> +#  |     bond0      |
> +#  |       |        |
> +#  |  eth0    eth1  |
> +#  +---+-------+----+
> +#
> +# We use netdevsim instead of physical interfaces
> +#-------------------------------------------------------------------
> +# Example commands
> +#   ip x s add proto esp src 192.0.2.1 dst 192.0.2.2 \
> +#            spi 0x07 mode transport reqid 0x07 replay-window 32 \
> +#            aead 'rfc4106(gcm(aes))' 1234567890123456dcba 128 \
> +#            sel src 192.0.2.1/24 dst 192.0.2.2/24
> +#            offload dev bond0 dir out
> +#   ip x p add dir out src 192.0.2.1/24 dst 192.0.2.2/24 \
> +#            tmpl proto esp src 192.0.2.1 dst 192.0.2.2 \
> +#            spi 0x07 mode transport reqid 0x07
> +#
> +#-------------------------------------------------------------------
> +
> +lib_dir=$(dirname "$0")
> +source "$lib_dir"/../../../net/lib.sh
> +algo="aead rfc4106(gcm(aes)) 0x3132333435363738393031323334353664636261 128"
> +srcip=192.0.2.1
> +dstip=192.0.2.2
> +ipsec0=/sys/kernel/debug/netdevsim/netdevsim0/ports/0/ipsec
> +ipsec1=/sys/kernel/debug/netdevsim/netdevsim0/ports/1/ipsec
> +active_slave=""
> +
> +active_slave_changed()
> +{
> +        local old_active_slave=$1
> +        local new_active_slave=$(ip -n ${ns} -d -j link show bond0 | \
> +				 jq -r ".[].linkinfo.info_data.active_slave")

shell check is not super happy about the lack of double quotes  around
the variables (above and many places below) and about declaring the
variable and assigning it to a subshell in the same statement.

I think it's better to address such warnings for consistency.

Thanks,

Paolo


