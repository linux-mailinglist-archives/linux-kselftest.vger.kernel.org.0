Return-Path: <linux-kselftest+bounces-6140-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 596B78771E7
	for <lists+linux-kselftest@lfdr.de>; Sat,  9 Mar 2024 16:26:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 94C411F215F7
	for <lists+linux-kselftest@lfdr.de>; Sat,  9 Mar 2024 15:26:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C9F74437C;
	Sat,  9 Mar 2024 15:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Epnv8dLy"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2DC340870;
	Sat,  9 Mar 2024 15:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709998005; cv=none; b=DqFV28hmKVKe0GkUp7vGXZ3itMkLlrWMh5P7vC7YxFiYmSCMbkXCDE1AOtLCViEBtdXIWR6WNdfTLXGAZlzcEPY7M1MX2K+zwgjBSXciqcs5v0Nc49MkMdCVIwaiHRQIanQUxOMODkgQ7DcLRpv1FBISwHn6NYQKP1MI+LhPU7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709998005; c=relaxed/simple;
	bh=YjDS8iGJhtfuA0RgbPEdCTzn6QGfPrzGPSUWMFR51kA=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Content-Type; b=JpKRd/tD3stssDSRNcMYA3vzMcIeUFykzHZlpT6zJ1D1l9JRanKS5hRJWKJmKfO1bgF3Ilf3+xOpFfOjpjQaKnI5CrRgakEnIBeGt5SqNsxcgRQvHnxIelRWeByVonEVK/K2zIla6Pf5koeXpnzHbYCAhxbx+XqylixTdHB4tj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Epnv8dLy; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-41318e93a08so10568795e9.0;
        Sat, 09 Mar 2024 07:26:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709998002; x=1710602802; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=f/ddNOX2QllMjNIQC+nbdaiJ3K9z+QOijB5+nySnxPA=;
        b=Epnv8dLyz3vVPUnauLK179HEv0diKy9WBhKlRNf3NK+x2WMlhVwnfIWN/V5UJYC5hi
         fmxbRFQiO1SQEU7B0xnLz8d5LpNOFXFK63iGVkZ08+HzBWDrvNkz6/H3IzlraCQYG32j
         uAOvXufbGJueFVa3Fum87+cuPaTgHR3wKo5UoHdlw8l8DROjT2fHPO3eaxM5eUQ61yg3
         Y9EhxECguStdzm0HBP3Dnzi94taFiB2FnmrYMBtpY80Q12uEiZihIcjoilUrnCyEC2Np
         g4ucrrLDOrVYflTt7XjE7YT6y0s4L4rFSpBRVpWeBC7T05p4p3qbN4MiGokNx8541Hmk
         nlHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709998002; x=1710602802;
        h=content-transfer-encoding:to:subject:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=f/ddNOX2QllMjNIQC+nbdaiJ3K9z+QOijB5+nySnxPA=;
        b=BQslsxig3CaXxhUpCZDVu3SbNiR786h9UriIw5+kDMutkCTtTsv+sk4YftlG4r40Fo
         UkjeTbHP341E7pcvlNoNYY7e+6bZvcFUHEFTvSIDQIhoqbg8PIZIWZ/WoFfuzoLLbRj4
         Fbfy6yWuXngal24N7zEoei0BufZgKlsQQpVjl7ghDzWMR72VIVdLYPZqX9WvxkVgTr5P
         7ZrkIT1Wv4x44hOJmEfWCFpP1Rrd6Bd6dE5XRQWmYPM1T6Dhjx6xuu9SpVyWE6fXWkv/
         L08KGIXNGJiP+9IGfUQDK65bpGao+Op2eBgnZIfSl7F2q+zbPV8De64n1kF7ARfemvBE
         O/BQ==
X-Forwarded-Encrypted: i=1; AJvYcCUICnY8S9UAp06X0e6BY3eQ+WDh3Zm6+Ru77tOetK8lCFkINxIAveJrEXyQ6xWK2jTIsC4kgoZP0UfyogBScsfkfrXfADBwVK8VmCW3s9/KEf5B+j9tjEhVKijPsNIEXNg4hwNzr/nuRHUmCEVULo6XHq6woiDtYQVYbHn30gUBJVwmNDHi
X-Gm-Message-State: AOJu0YwNp+cIGZWdsj7TRU71+VVPTWXIxxBjQzdUxoG8WaWgi7AXMEGk
	x1xqRTp34oRCKk9ugzxOr7425LSoZ8LJ7OCk6lIcMqSLN2n0qZJv
X-Google-Smtp-Source: AGHT+IHrDGMadli9epBpxggQmI/6QpQUD9CaKMpPchEVFeJw39z1KdjaJQhtalPO3f7WKAcp8EwqCw==
X-Received: by 2002:a05:600c:1c03:b0:413:1d7b:1cd8 with SMTP id j3-20020a05600c1c0300b004131d7b1cd8mr1685998wms.33.1709998001813;
        Sat, 09 Mar 2024 07:26:41 -0800 (PST)
Received: from debian ([146.70.204.204])
        by smtp.gmail.com with ESMTPSA id r4-20020a05600c35c400b004130c1dc29csm2840162wmq.22.2024.03.09.07.26.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 09 Mar 2024 07:26:41 -0800 (PST)
Message-ID: <f939c84a-2322-4393-a5b0-9b1e0be8ed8e@gmail.com>
Date: Sat, 9 Mar 2024 16:26:25 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Richard Gobert <richardbgobert@gmail.com>
Subject: [PATCH net-next v3 0/4] net: gro: encapsulation bug fix and flush
 checks improvements
To: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, willemdebruijn.kernel@gmail.com, dsahern@kernel.org,
 xeb@mail.ru, shuah@kernel.org, idosch@nvidia.com, razor@blackwall.org,
 amcohen@nvidia.com, petrm@nvidia.com, jbenc@redhat.com, bpoirier@nvidia.com,
 b.galvani@gmail.com, gavinl@nvidia.com, liujian56@huawei.com,
 horms@kernel.org, linyunsheng@huawei.com, richardbgobert@gmail.com,
 therbert@google.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

This series fixes a bug in the complete phase of UDP in GRO, in which
socket lookup fails due to using network_header when parsing encapsulated
packets. The fix is to pass p_off parameter in *_gro_complete.

Next, the fields network_offset and inner_network_offset are added to
napi_gro_cb, and are both set during the receive phase of GRO. This is then
leveraged in the next commit to remove flush_id state from napi_gro_cb, and
stateful code in {ipv6,inet}_gro_receive which may be unnecessarily
complicated due to encapsulation support in GRO.

In addition, udpgro_fwd selftest is adjusted to include the socket lookup
case for vxlan. This selftest will test its supposed functionality once
local bind support is merged (https://lore.kernel.org/netdev/df300a49-7811-4126-a56a-a77100c8841b@gmail.com/).

v2 -> v3:
 - Use napi_gro_cb instead of skb->{offset}
 - v2:
   https://lore.kernel.org/netdev/2ce1600b-e733-448b-91ac-9d0ae2b866a4@gmail.com/

v1 -> v2:
 - Pass p_off in *_gro_complete to fix UDP bug
 - Remove more conditionals and memory fetches from inet_gro_flush
 - v1:
   https://lore.kernel.org/netdev/e1d22505-c5f8-4c02-a997-64248480338b@gmail.com/

Richard Gobert (4):
  net: gro: add p_off param in *_gro_complete
  selftests/net: add local address bind in vxlan selftest
  net: gro: add {inner_}network_offset to napi_gro_cb
  net: gro: move L3 flush checks to tcp_gro_receive

 drivers/net/geneve.c                      |  7 +-
 drivers/net/vxlan/vxlan_core.c            | 11 ++--
 include/linux/etherdevice.h               |  2 +-
 include/linux/netdevice.h                 |  3 +-
 include/linux/udp.h                       |  2 +-
 include/net/gro.h                         | 36 +++++++----
 include/net/inet_common.h                 |  2 +-
 include/net/tcp.h                         |  6 +-
 include/net/udp.h                         |  8 +--
 include/net/udp_tunnel.h                  |  2 +-
 net/8021q/vlan_core.c                     |  6 +-
 net/core/gro.c                            |  6 +-
 net/ethernet/eth.c                        |  5 +-
 net/ipv4/af_inet.c                        | 49 ++------------
 net/ipv4/fou_core.c                       |  9 +--
 net/ipv4/gre_offload.c                    |  6 +-
 net/ipv4/tcp_offload.c                    | 79 ++++++++++++++++++-----
 net/ipv4/udp.c                            |  3 +-
 net/ipv4/udp_offload.c                    | 26 ++++----
 net/ipv6/ip6_offload.c                    | 41 +++++-------
 net/ipv6/tcpv6_offload.c                  |  7 +-
 net/ipv6/udp.c                            |  3 +-
 net/ipv6/udp_offload.c                    | 13 ++--
 tools/testing/selftests/net/udpgro_fwd.sh | 10 ++-
 24 files changed, 187 insertions(+), 155 deletions(-)

-- 
2.36.1


