Return-Path: <linux-kselftest+bounces-27365-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 600AAA4291E
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Feb 2025 18:16:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 713D418848B7
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Feb 2025 17:12:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7AE32627F7;
	Mon, 24 Feb 2025 17:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LAxOmcAC"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59AF7260A5E;
	Mon, 24 Feb 2025 17:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740417154; cv=none; b=lHJXOo+y6IqHhnF6gIOEjady0B0G/hHJLsGLUGCm7FNxyXwWlvrkNe7wwPYaLcl3XNwOmdgW4JaNd4tCTNKKe7wMx73ycyvo6wdKrfaCvzWTRKh+dGUZvGKkrACoggqmlNQynCUtzQxDrOccy2q2D7ziXnartOuGpF3PW+4wiF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740417154; c=relaxed/simple;
	bh=INCTVpEiHnc/oIKx9E4dIa9hFE2BQCY6HgP+mcwRRT0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W0j9NcViaISwKirVf5i9+jT0QV58paFjJTzK1sQNV1iKD1lUaPTEItJlVY848DwHgQxS2tPkn8lrPP3ax7PjSOLlFU7WWLu/e38517Hm3gQaUahbpgJO5MOF1cRisFZc6yhNXXtpWkWvz72adQNNw7HLWuUrwSUPL6oYUx8hJV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LAxOmcAC; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-220c8cf98bbso11563205ad.1;
        Mon, 24 Feb 2025 09:12:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740417152; x=1741021952; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TlqcvofmGggiBiv0CE7G1YH/4SRW4duxvdw0TO81nSE=;
        b=LAxOmcACcMgm6BQWO9ZvIyHVb5WSurpcb554CHYiV0Bluz0tqxeIifj3C7gG4f9Vpw
         VN0vYlN5mSVcZxrCdI16vklZHc7/6xDoCvL+I+EgWKfW8SYyewkFDpJwFxcx+2S2b4x3
         P8oQqJZbHCoHeXGmQxv8aiGEZtazJXn0ZPWm1Q/bizyasPHtE28Nkw1h77rsJgJboKQ4
         36wa2+9GzXimb69s0H/Z61nO/7TrNdl48hxKvoqInBDYDhU1f07YgF88deDOTLbM7sqf
         fVb513sQ5uKfD519tXDM6MI5z4Em8ofa1zNs/GI22jJqu+uffYg2bIMNrKjsfBn/LiC4
         GRMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740417152; x=1741021952;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TlqcvofmGggiBiv0CE7G1YH/4SRW4duxvdw0TO81nSE=;
        b=Q06WDhIogxl+pYFdIDvEjEB5tUJFMzEVlTrQTvhkBIvB6m+FSAKPJlsDyT5wYndbvP
         gMRVHeuDMueChyeBgZ/rt3SX+K7dAc2QqnC7eFEPKf+PndmKfM5w+aPUEVJdftkXhW6A
         b/GZlTzBxBlvQVdfxzDtuT1sNoyJkkHu8aNBUnHj52O0Dl4/jZZgKFuS67py/T0k5Jjl
         lSxnjwW32cg+dABaRbpDm5186/M6CdCak+7xQ3Ufcw/ofZFSXxgv8SxxXn+XbGb+lBQ/
         F8DDi7dS3Z9/kCgQWDxn80YyXN1wYwi+cB7EqKgrzBsw1ldi8e1lQICk96RM9d/kS23R
         5udA==
X-Forwarded-Encrypted: i=1; AJvYcCU+ZzC0o63Dp6WFsY+oVfSo4kov7LAe5kZbEurbW9VgNX2PiyJTYV7WnNYewkWFuZDHj5I=@vger.kernel.org, AJvYcCWGWtWI9+VXWUBqyf/CioCO+uwT8L/pGpUHG49C6UVgwMaKWLKf88ZVRZuneHSm/SUSvf+qOoj2qLN/xkX/xWZy@vger.kernel.org, AJvYcCWYlO3vaB8037KFUTeo0PZ3bbmO9sieFLkyuHlpZpqnr6Jfzyga2MT07ID1AvppO4eoRwAFIfoeX04efCDJ@vger.kernel.org
X-Gm-Message-State: AOJu0YyrQ11CnJiGJb0diZ8tYN+Y2ExMdBmpFLzFuTzs3Qpt2KIIAWzu
	M4Ur4tFnyxv/nBGPc1GGETd7YrBny/Y2nyebFVWxXgWkf97yqgE=
X-Gm-Gg: ASbGncv2cKhhbpCqrltexjUOW/j+mdGXYsNZzDzuT8h+Iljf9TFayR8cLMIIXzpCUaN
	/2ghu4Xncq6ytIkLaz9okn95FNeAjOdnKqwlu88+gJ9YkdhvLfU7tDTQJRpFz8fvwhqiDoT1CHv
	PXezLDTKz4g7E5hKKc0CD3CVtG153w5jDA7Abe7+3G6k/YZcVqUhGF8ypjbf58eS1pzcmb5n69v
	sZLMC2PJBpJlvh49rqMVum/OKsnxZlVnPSB+nsuuCBXpycLrVKBqXunPwA7/P9QJwCdDLAtg8c1
	CtddmFeujaTR1l+W5X6WT9wz6A==
X-Google-Smtp-Source: AGHT+IEn9JgospvuGafyt2PK7wawjv6RYzjXoajKoNOMWXmzMfR7NyYhQJKwd1T2G5qAEYY1RFGtgA==
X-Received: by 2002:a17:902:e88d:b0:21d:dfae:300b with SMTP id d9443c01a7336-221a0ec46ffmr231562035ad.10.1740417152537;
        Mon, 24 Feb 2025 09:12:32 -0800 (PST)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-220d53490c2sm184364335ad.47.2025.02.24.09.12.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2025 09:12:32 -0800 (PST)
Date: Mon, 24 Feb 2025 09:12:31 -0800
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Marcus Wichelmann <marcus.wichelmann@hetzner-cloud.de>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
	willemdebruijn.kernel@gmail.com, jasowang@redhat.com,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, andrii@kernel.org,
	eddyz87@gmail.com, mykolal@fb.com, ast@kernel.org,
	daniel@iogearbox.net, martin.lau@linux.dev, song@kernel.org,
	yonghong.song@linux.dev, john.fastabend@gmail.com,
	kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com,
	jolsa@kernel.org, shuah@kernel.org, hawk@kernel.org
Subject: Re: [PATCH bpf-next v3 4/6] selftests/bpf: refactor
 xdp_context_functional test and bpf program
Message-ID: <Z7yof3pafRsMwBrf@mini-arch>
References: <20250224152909.3911544-1-marcus.wichelmann@hetzner-cloud.de>
 <20250224152909.3911544-5-marcus.wichelmann@hetzner-cloud.de>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250224152909.3911544-5-marcus.wichelmann@hetzner-cloud.de>

On 02/24, Marcus Wichelmann wrote:
> The existing XDP metadata test works by creating a veth pair and
> attaching XDP & TC programs that drop the packet when the condition of
> the test isn't fulfilled. The test then pings through the veth pair and
> succeeds when the ping comes through.
> 
> While this test works great for a veth pair, it is hard to replicate for
> tap devices to test the XDP metadata support of them. A similar test for
> the tun driver would either involve logic to reply to the ping request,
> or would have to capture the packet to check if it was dropped or not.
> 
> To make the testing of other drivers easier while still maximizing code
> reuse, this commit refactors the existing xdp_context_functional test to
> use a test_result map. Instead of conditionally passing or dropping the
> packet, the TC program is changed to copy the received metadata into the
> value of that single-entry array map. Tests can then verify that the map
> value matches the expectation.
> 
> This testing logic is easy to adapt to other network drivers as the only
> remaining requirement is that there is some way to send a custom
> Ethernet packet through it that triggers the XDP & TC programs.
> 
> The payload of the Ethernet packet is used as the test data that is
> expected to be passed as metadata from the XDP to the TC program and
> written to the map. It has a fixed size of 32 bytes which is a
> reasonalbe size that should be supported by both drivers. Additional
> packet headers are not necessary for the test and were therefore skipped
> to keep the testing code short.
> 
> Signed-off-by: Marcus Wichelmann <marcus.wichelmann@hetzner-cloud.de>
> ---
>  .../bpf/prog_tests/xdp_context_test_run.c     | 99 +++++++++++++++----
>  .../selftests/bpf/progs/test_xdp_meta.c       | 56 ++++++-----
>  2 files changed, 112 insertions(+), 43 deletions(-)
> 
> diff --git a/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c b/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c
> index 937da9b7532a..4043f220d7c0 100644
> --- a/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c
> +++ b/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c
> @@ -4,13 +4,19 @@
>  #include "test_xdp_context_test_run.skel.h"
>  #include "test_xdp_meta.skel.h"
>  
> -#define TX_ADDR "10.0.0.1"
> -#define RX_ADDR "10.0.0.2"
>  #define RX_NAME "veth0"
>  #define TX_NAME "veth1"
>  #define TX_NETNS "xdp_context_tx"
>  #define RX_NETNS "xdp_context_rx"
>  
> +#define TEST_PAYLOAD_LEN 32
> +static const __u8 test_payload[TEST_PAYLOAD_LEN] = {
> +	0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07, 0x08,
> +	0x11, 0x12, 0x13, 0x14, 0x15, 0x16, 0x17, 0x18,
> +	0x21, 0x22, 0x23, 0x24, 0x25, 0x26, 0x27, 0x28,
> +	0x31, 0x32, 0x33, 0x34, 0x35, 0x36, 0x37, 0x38,
> +};
> +
>  void test_xdp_context_error(int prog_fd, struct bpf_test_run_opts opts,
>  			    __u32 data_meta, __u32 data, __u32 data_end,
>  			    __u32 ingress_ifindex, __u32 rx_queue_index,
> @@ -112,15 +118,66 @@ void test_xdp_context_test_run(void)
>  	test_xdp_context_test_run__destroy(skel);
>  }
>  
> -void test_xdp_context_functional(void)

[..]

> +int send_test_packet(int ifindex)

nit: static? same for assert_test_result below

