Return-Path: <linux-kselftest+bounces-15319-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C769C951CD9
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 Aug 2024 16:18:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F0581F2130E
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 Aug 2024 14:18:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22A141B29DB;
	Wed, 14 Aug 2024 14:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CM9+IrFh"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC4861B1417;
	Wed, 14 Aug 2024 14:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723645079; cv=none; b=f4tiKM+SLgTAIKfqn1UCI2m6/sCjp8Qw+ryWymlsYdqV4SGjM/B6jqE2cZkq9S5jKclGHrPQh01h4GKvn1lC8gItgk1DnmLIT7LZTCL8v/AJ9MQxNv4BVd37fSSREskgZPG3ZvH+a2TWU4L9PzdcShcqR2+kpKxr3eGeVZTOSMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723645079; c=relaxed/simple;
	bh=yA6y+xo/SimRk3qR9RYdbznCNXerpsXkLWyum8LUXl8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pqPcI05tu3rtXFv36odpv2Ep5p0AuONKnrUV/yJuR4Z81h/sQM/VDPzufisw1ncBWCqNOS5SAlr2LctTAKV0OpQaqjPZAaNeaIrkxDm4zX+vIngOvPWcMf6dYIWHKwMBIp0cdo+vyo1dKvBqVTiXVOxmlIEzahcW8S09FzI+dUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CM9+IrFh; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-710ce81bf7dso4424448b3a.0;
        Wed, 14 Aug 2024 07:17:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723645077; x=1724249877; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=r+/C9SJOxI4cFoo7KriHAW5uob8rhPiZWTGMW094FmY=;
        b=CM9+IrFh64tLYOO7rpfTgRghEB2l2g8mTVfuy0fkHzWJ+/3RAJxqDViv34ywcYuTyk
         6fWb0TxPUIgBJ9uzgQ+qI+wmUaAjxRISYFc/kVVh8y2EF9tA3U9ncZz7fADlAqrdm9fY
         647OLNbf5MvPcSvNW8M3DW8MSWNQoIM2JiaC3w0kRcUkyV1ga50A2dZ8DKytzPBZAW0H
         GoRUukDCRDTckj7rZye1v9S1czJ3Cx8tn9HM0fG9sI05mACzRFIkP2Msy+10OpMAZAwj
         dbakJDwEJtESdyzoFoBwIS9o4DCjvcnrhLR2OMoDpyJF8t9nDhaDprTxvRSNZct8L1oS
         UgqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723645077; x=1724249877;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r+/C9SJOxI4cFoo7KriHAW5uob8rhPiZWTGMW094FmY=;
        b=vuBD2qFPDcaQdWqJCrsdY3CF2fUvAlcWmOrxL6FG6YjOn6d4vzdOXUInxGzBja5du3
         9k2PLShK1qjrn9w0cR3XwEupujFU9YE9lRuGEvUYfD6MLrtwHjaIIcBKSMPPHq3DJ5az
         dcOEiRTAbCfgzXBweVSrH3Tldf5wZnajZXaJDNGY36DueQnni2aVhLFnTl4jhdMiWEm9
         K6LfHcmBUfWquqTPwIzAVDta5EgIbRXHyoaCIty45yGltO4PpQR2xqg50KKSPlLL4T0f
         r0p0n/SWnWSkburPxXwMdpL2RxENhoGNjngSN1wnGP52QW8AkEaQhAx+0K9xuJjq4chQ
         okpQ==
X-Forwarded-Encrypted: i=1; AJvYcCX1baTa9QejV/g7CeynGYIUI/L7mpAWKNnbbXD+kht801hBHBT5DPCEMAa5/1CBlPQk7wyKv0FUboQYKR30C2QilKvuumAsAT/aitxo0z551t6jji69KYhHrcxWufJidP/+AMPd
X-Gm-Message-State: AOJu0Ywirxi3IybfdoHpYmtTCgOx36f4hSJJuXUsqh1NfKPIaUD8OH8B
	VTA7dXWmNC2Yy1l25ixrS+nDUf9MRvesEiOSNQFehzPFsOVjd8Po1evSoBJWERM=
X-Google-Smtp-Source: AGHT+IGlVkZdNTgQypPMX1HODNGrZ1Eb3vrJl56uGoum5Wnn71WiaHwk363hewkwGLKuKUm8qV7KxA==
X-Received: by 2002:a05:6a20:438e:b0:1c6:fb0b:51d8 with SMTP id adf61e73a8af0-1c8eae2f5f0mr4081223637.9.1723645076733;
        Wed, 14 Aug 2024 07:17:56 -0700 (PDT)
Received: from Laptop-X1 ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-710e5a8a2f5sm7351015b3a.166.2024.08.14.07.17.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Aug 2024 07:17:56 -0700 (PDT)
Date: Wed, 14 Aug 2024 22:17:50 +0800
From: Hangbin Liu <liuhangbin@gmail.com>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Toke =?iso-8859-1?Q?H=F8iland-J=F8rgensen?= <toke@redhat.com>,
	Ignat Korchagin <ignat@cloudflare.com>,
	linux-kselftest@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH net 1/2] selftests: udpgro: report error when receive
 failed
Message-ID: <Zry8jqeQWgBPYK7m@Laptop-X1>
References: <20240814075758.163065-1-liuhangbin@gmail.com>
 <20240814075758.163065-2-liuhangbin@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240814075758.163065-2-liuhangbin@gmail.com>

On Wed, Aug 14, 2024 at 03:57:57PM +0800, Hangbin Liu wrote:
> ---
>  tools/testing/selftests/net/udpgro.sh | 41 ++++++++++++++++-----------
>  1 file changed, 24 insertions(+), 17 deletions(-)
> 
> diff --git a/tools/testing/selftests/net/udpgro.sh b/tools/testing/selftests/net/udpgro.sh
> index 11a1ebda564f..7e0164247b83 100755
> --- a/tools/testing/selftests/net/udpgro.sh
> +++ b/tools/testing/selftests/net/udpgro.sh
> @@ -49,14 +49,15 @@ run_one() {
>  
>  	cfg_veth
>  
> -	ip netns exec "${PEER_NS}" ./udpgso_bench_rx -C 1000 -R 10 ${rx_args} && \
> -		echo "ok" || \
> -		echo "failed" &
> +	ip netns exec "${PEER_NS}" ./udpgso_bench_rx -C 1000 -R 10 ${rx_args} &
> +	local PID1=$!
>  
>  	wait_local_port_listen ${PEER_NS} 8000 udp
>  	./udpgso_bench_tx ${tx_args}
> -	ret=$?
> -	wait $(jobs -p)
> +	check_err $?
> +	wait ${PID1}
> +	check_err $?
> +	[ "$ret" -eq 0 ] && echo "ok" || echo "failed"
>  	return $ret
>  }

Self NACK. The ret need to define first in each function, or the check_err
will failed... I forgot to the update the patch before post..

Thanks
Hangbin

