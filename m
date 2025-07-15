Return-Path: <linux-kselftest+bounces-37343-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A7B9FB056C3
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Jul 2025 11:39:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C8CD3740274
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Jul 2025 09:38:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31F782D6400;
	Tue, 15 Jul 2025 09:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BW+zEyHA"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE30B2AD00
	for <linux-kselftest@vger.kernel.org>; Tue, 15 Jul 2025 09:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752572283; cv=none; b=mHPuZACKimAgufIQehfNhI2DZ5LkcrpTMt3PaY83z952NR9LIsznu77XfAGkoBCPFUi/UuvA4hwtsI65FA6prEQyHTYpVnmX4cMtacwn9b4VutVaXBcVXqvMhkZqrKo/nTAd22K5G9txZVcYPBb5HyBHZZlElIyYBvHhd77OLQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752572283; c=relaxed/simple;
	bh=QNCBtPaTSE5T621Q1/slm5WE9aV/EJ6j6EVIvjDmpKE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=U1fs246znSEbLZNMOlYKfyiSDPGs5IryBPFocFOn+RGV3BvYp/m2Am8RNwH43Ii02A1PJFOtM+41DrM3KWFxXyXeoFzwrXemE/iuzyB9C0zbBHE7HqNwfdJi/Nu5XxSVMG4t8VR0rmR9J/YWIDpRrQDPk3CpAPwbO7qJZ1LkJoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BW+zEyHA; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752572278;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zQjsg9ZhDrbt59Nuu5HEpW/rnNZPZCAGMVCPsn70hCc=;
	b=BW+zEyHAp3/9b6WAX7prE4sqmO2SD541JSd0PqsuzU73yktESXs0desZc17MFia8tnZ08Z
	LiXniIxMQ26zm/O4SQXegZXlOcdAVJ+dKhIWfVs47lBVNNxo2UeYDrP6RMWOemIKuiZ+qN
	32LewqzfSEZwmh5RRBys56vri92ZlK4=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-180-Enq_cGI8MNOUL3_Lk7JsAw-1; Tue, 15 Jul 2025 05:37:57 -0400
X-MC-Unique: Enq_cGI8MNOUL3_Lk7JsAw-1
X-Mimecast-MFC-AGG-ID: Enq_cGI8MNOUL3_Lk7JsAw_1752572276
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3a58939191eso1962068f8f.0
        for <linux-kselftest@vger.kernel.org>; Tue, 15 Jul 2025 02:37:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752572276; x=1753177076;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zQjsg9ZhDrbt59Nuu5HEpW/rnNZPZCAGMVCPsn70hCc=;
        b=g+zDCMG88XaJhtQ2j2RLvwGO1XJyEhO/1kl6+7E2Vtm00B2/97Oejio/64GdD4MhgR
         9LFquG0SRi0vNR0ITYMyazAgZekZKnozCC/uzfYF24wJmVN5uDWlfhI2W6JibgOMaiyg
         HICHbLKMXevuTAMgfN5JEmnetujtBPFXqEsTmUSTtFEFCLiNYHTEBmkps1Q8S1c46cnZ
         N+N+iKKhrF09CXBZB2sZ8aRwe0P/WK4ocTK3rE9ecqQI80+pJEGIbbzI4kUGLBpPS3ty
         vhYjf7ZuWzV4xAOx8i7dne2kbJcHuKjNV+dj5BB1Ej5v3+u1gtdyRegbF1NW6PpnvySe
         Pk3A==
X-Forwarded-Encrypted: i=1; AJvYcCWHz1VCPONTbCKvH0nbnNLM8ye2upMOSs8cdADMdgeQvzIfQ1Ur6VwakXMgzRNdeK1a/rImvZcqv8XY1jd7j9E=@vger.kernel.org
X-Gm-Message-State: AOJu0YyrUAiUaVghPACGKPG4QgPbQLzZR1j+TtocAXrDP1loTnX2KsA6
	6MB6nqUBVCnWgNlgo6diJzqI/JN0KwpDKTltu6BOrynwuDLeJreD7vlG9mg06/RWMPgvWlUjZRs
	5aher8j7MwxmMh8Z6rG0N3f1s7iAr/R1VKGCQnkPEF2+phJRpNYFmBeRwfPNGeX291LDIYQ==
X-Gm-Gg: ASbGnctnUub1b5WG4OQjE8J/rRfdVH9X6UbZk7GiXKMJr5qQQElXMq9XKi+yxZ3ucyA
	SZudNZ3ai1ipfa7O3JK2uifJjU2bY9Er7Fwq+h7Q32SwgZCfNE2+6cJaFpC3Uo8H2I5iyIFeGfi
	J3kKvdvHm+Y8qmcWj0nzd3mBo66xDU1C8McHY8o5wbcocG6SSidcLFz6XdtZqHJECmn9EkjbyWY
	8r8XqEdPeI+mQC2wG/yZ8yxFTV7t9VyUITKVSetKmSgM3iaSm5VQlYHb097jYnSNNCXIhu9T1Zq
	sN4nGgtI7wN8dv8FCs2tfxfJZ1cdYHjtjN1i08RE1HMW6udEauR4RP5WHL5FBU+rGsakd4I3Kxv
	vi5/2wS+tkvI=
X-Received: by 2002:a05:6000:440f:b0:3a4:ef30:a4c8 with SMTP id ffacd0b85a97d-3b5f187e383mr10123157f8f.10.1752572276251;
        Tue, 15 Jul 2025 02:37:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEY7rnEyaVNTCq9R6RoKiLyFF22JsBtzv/zE5FdLGKRbnJHy7hamvgRydWCDaxAzMf/pvDQpA==
X-Received: by 2002:a05:6000:440f:b0:3a4:ef30:a4c8 with SMTP id ffacd0b85a97d-3b5f187e383mr10123135f8f.10.1752572275741;
        Tue, 15 Jul 2025 02:37:55 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c? ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b5e8bd1a2bsm14923256f8f.14.2025.07.15.02.37.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Jul 2025 02:37:55 -0700 (PDT)
Message-ID: <6d4bbed3-472f-4002-abb9-47edf7743779@redhat.com>
Date: Tue, 15 Jul 2025 11:37:54 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 2/2] selftests: bonding: add test for passive LACP
 mode
To: Hangbin Liu <liuhangbin@gmail.com>, netdev@vger.kernel.org
Cc: Jay Vosburgh <jv@jvosburgh.net>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Nikolay Aleksandrov <razor@blackwall.org>,
 Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250709090344.88242-1-liuhangbin@gmail.com>
 <20250709090344.88242-3-liuhangbin@gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250709090344.88242-3-liuhangbin@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/9/25 11:03 AM, Hangbin Liu wrote:
> Add a selftest to verify bonding behavior when lacp_active is set to off.
> 
> Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
> ---
>  .../drivers/net/bonding/bond_passive_lacp.sh  | 21 +++++
>  .../drivers/net/bonding/bond_topo_lacp.sh     | 77 +++++++++++++++++++
>  2 files changed, 98 insertions(+)
>  create mode 100755 tools/testing/selftests/drivers/net/bonding/bond_passive_lacp.sh
>  create mode 100644 tools/testing/selftests/drivers/net/bonding/bond_topo_lacp.sh

New test should be listed in the relevant makefile
> diff --git a/tools/testing/selftests/drivers/net/bonding/bond_passive_lacp.sh b/tools/testing/selftests/drivers/net/bonding/bond_passive_lacp.sh
> new file mode 100755
> index 000000000000..4cf8a5999aaa
> --- /dev/null
> +++ b/tools/testing/selftests/drivers/net/bonding/bond_passive_lacp.sh
> @@ -0,0 +1,21 @@
> +#!/bin/sh
> +# SPDX-License-Identifier: GPL-2.0
> +#
> +# Testing if bond works with lacp_active = off
> +
> +lib_dir=$(dirname "$0")
> +source ${lib_dir}/bond_topo_lacp.sh

shellcheck is not super happy about 'source' usage:

In bond_passive_lacp.sh line 7:
source ${lib_dir}/bond_topo_lacp.sh
^-- SC3046 (warning): In POSIX sh, 'source' in place of '.' is undefined.
^-- SC3051 (warning): In POSIX sh, 'source' in place of '.' is undefined.

either switch to '. ' or use bash instead of 'sh'.

> +lacp_bond_reset "${c_ns}" "lacp_active off"
> +# make sure the switch state is not expired [A,T,G,S,Ex]
> +if slowwait 15 ip netns exec ${s_ns} grep -q 'port state: 143' /proc/net/bonding/bond0; then

Shellcheck wants double quote everywhere. Since in many cases (all the
blamed ones in this patch) we know the variable is really a single word,
I think you could simply disable the warning with:

#shellcheck disable=SC2086

(same in the other test file)

> +	RET=1
> +else
> +	RET=0
> +fi

/P


