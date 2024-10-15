Return-Path: <linux-kselftest+bounces-19709-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CA0D99E0EF
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Oct 2024 10:23:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 60C72B258E2
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Oct 2024 08:23:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B7DD1D5AB4;
	Tue, 15 Oct 2024 08:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fsj+jLUi"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 863D71CACEE
	for <linux-kselftest@vger.kernel.org>; Tue, 15 Oct 2024 08:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728980577; cv=none; b=IGqqIeGB3RmeBMv5c0vhN3msqINKXg7GkI/DdaIoeNvAZ3iaMLlwl1P0SiLDyzL2l/9QFU9KFvgzXHBT19fP9SWFUDkY/psLKXHudugiwrDKEYMjojoYYeSQHVmHs4SodivUek8FGOXIl2Hd3WkIc1913zxpB5rOsSItRe8lVCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728980577; c=relaxed/simple;
	bh=cUwe0v7vBLeUuYtqFoHOZI44JFRnj3mCsTB1ARnQFBk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BVapp6pAUUAcaCZ/2DMdPVILNPNBsFydQQ6ukXRcS97Z96/aLw6VWbx+DT31GfDgLyreGwNq8At8ZfgSJpBPnaFWj1A+HPjoux3vaB5otf7vt1KhlynazpQOo8QrUSypngi1y9/Iqa+ehDDMG+mUBHqVNNYKc7/6oSFqqTc5nxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fsj+jLUi; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728980574;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HZT5NqeAX+0TO6OTyvaLn7KXovdqFQioxNek5XGLyj4=;
	b=fsj+jLUibGeRHi+7onQBnGM4NRiHJmIUmJTPRfs3ruBttivXIu9Ix8CY+db0mcO6sAjOsb
	VggQrRRPK1I1OGc1I7+O8GYLy2FhaVY0LHsNRz5BMaCQaZ/XqZWj8KtrT1gG+mX405jXAl
	eCabnuy6H16HScCo71YoLYAPsKLdlKA=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-147-3QNaZYR8M8ythGzJ3gjATg-1; Tue, 15 Oct 2024 04:22:53 -0400
X-MC-Unique: 3QNaZYR8M8ythGzJ3gjATg-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4311c47684aso24284935e9.0
        for <linux-kselftest@vger.kernel.org>; Tue, 15 Oct 2024 01:22:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728980572; x=1729585372;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HZT5NqeAX+0TO6OTyvaLn7KXovdqFQioxNek5XGLyj4=;
        b=qxXNBHSO93zelUUykKTx6r5NhexlV7CWXSErHawrp0j5zDBHVMpQCIIhT7LqBoWJyl
         vDecKsdWkuNy6aONoegmMT4v5IeQ6n4OjdYA5lvGP2cG947Ir4qPYIavsyvpRjMH0T2I
         IdAuHO5ac68FmUB5vFHrSER/FcPR5ekK9ebuVOH3LyF5fjeOxbtEkTYUzPcGDTXXoe3l
         XQ0jG8fg5VxE/uBZwyqsdjR3rzy/SRvgxMXSoWgCkO219e4Zvf+G9DK+FZ0507HQyz85
         wmurnrhMfN/qnftOifg8SlPxkYTJm1xXMg8TJTa+Jow0+vZ8t/MDNNzmOkdufnswq4s9
         xDpA==
X-Gm-Message-State: AOJu0YzZVPUIaIbaemSCZO05FCEgFIoUZuX8uoYzJ1LLrRW570Va8kek
	QM4sYhyFDp2bG/NUJEWz4I1RReNAPGN9KP+4COwaggSWjejt+4Svjeip5qJaohwMMoWZyh/mjY5
	fXqWHUfAygF5wKVZb3dj63sXF1ktF16QHOzBaXZaGBClWVAzlMzGLzdIphMP0vIAy1g==
X-Received: by 2002:a05:600c:190f:b0:430:53f8:38bc with SMTP id 5b1f17b1804b1-431255dcb76mr84598515e9.12.1728980571896;
        Tue, 15 Oct 2024 01:22:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGb9R0EruHHyWpo5DjDeKbICO+26yqisy6fvsgv2XfNXRWKW5oDvwU8eVyVBYf6OquOO+b6nA==
X-Received: by 2002:a05:600c:190f:b0:430:53f8:38bc with SMTP id 5b1f17b1804b1-431255dcb76mr84598275e9.12.1728980571475;
        Tue, 15 Oct 2024 01:22:51 -0700 (PDT)
Received: from [192.168.88.248] (146-241-22-245.dyn.eolo.it. [146.241.22.245])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4313f56a583sm10390135e9.19.2024.10.15.01.22.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Oct 2024 01:22:51 -0700 (PDT)
Message-ID: <0b947dd2-5891-457c-8511-52781764857d@redhat.com>
Date: Tue, 15 Oct 2024 10:22:49 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 01/10] selftests: net: lib: Introduce deferred
 commands
To: Petr Machata <petrm@nvidia.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 netdev@vger.kernel.org
Cc: linux-kselftest@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
 Benjamin Poirier <bpoirier@nvidia.com>, Hangbin Liu <liuhangbin@gmail.com>,
 Vladimir Oltean <vladimir.oltean@nxp.com>, Ido Schimmel <idosch@nvidia.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>, mlxsw@nvidia.com
References: <cover.1728473602.git.petrm@nvidia.com>
 <5c0506e2d1bcdd513b9917716702c9bc5f656198.1728473602.git.petrm@nvidia.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <5c0506e2d1bcdd513b9917716702c9bc5f656198.1728473602.git.petrm@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

On 10/9/24 14:06, Petr Machata wrote:
> diff --git a/tools/testing/selftests/net/lib/sh/defer.sh b/tools/testing/selftests/net/lib/sh/defer.sh
> new file mode 100644
> index 000000000000..8d205c3f0445
> --- /dev/null
> +++ b/tools/testing/selftests/net/lib/sh/defer.sh
> @@ -0,0 +1,115 @@
> +#!/bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +
> +# map[(scope_id,track,cleanup_id) -> cleanup_command]
> +# track={d=default | p=priority}
> +declare -A __DEFER__JOBS
> +
> +# map[(scope_id,track) -> # cleanup_commands]
> +declare -A __DEFER__NJOBS
> +
> +# scope_id of the topmost scope.
> +__DEFER__SCOPE_ID=0
> +
> +__defer__ndefer_key()
> +{
> +	local track=$1; shift

Minor nit: IMHO the trailing shift is here a bit confusing: it let me 
think about other arguments, which are not really expected.

[...]
> +__defer__schedule()
> +{
> +	local track=$1; shift
> +	local ndefers=$(__defer__ndefers $track)
> +	local ndefers_key=$(__defer__ndefer_key $track)
> +	local defer_key=$(__defer__defer_key $track $ndefers)
> +	local defer="$@"
> +
> +	__DEFER__JOBS[$defer_key]="$defer"
> +	__DEFER__NJOBS[$ndefers_key]=$((${__DEFER__NJOBS[$ndefers_key]} + 1))

'${__DEFER__NJOBS[$ndefers_key]}' is actually '$ndefers', right? If so 
it would be better to reuse the avail variable.

Thanks,

Paolo


