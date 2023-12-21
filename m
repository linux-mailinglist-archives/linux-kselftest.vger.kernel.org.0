Return-Path: <linux-kselftest+bounces-2311-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BB6981BE69
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Dec 2023 19:45:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E5121C23F31
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Dec 2023 18:45:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E13564A98;
	Thu, 21 Dec 2023 18:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dTlMHxwG"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B69655B1ED;
	Thu, 21 Dec 2023 18:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-40b5155e154so13615005e9.3;
        Thu, 21 Dec 2023 10:44:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703184294; x=1703789094; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ntx7s0uRV0mp2r8zWsvNB9qnCJ5QsvZ3Jpv2yv8Rzbw=;
        b=dTlMHxwGSNjMVPZVkfkVEwtfKPW7p+xNSz20Awi4FOBl0qbeda0CK2J/tmlRA6mmAp
         VFKnCBlBV15fXYmU32ralnO1+VbElH8yotEc+aB1UJxEmMpdJq/oQLbpxIP1+c22z35F
         7VBmtUXy46nFEfq/MbbenS8aZDMxrrfyrXCOU7VDA3rF+6c01cC2PwztJH/I5lT3mQMx
         /qF1gMn0dMJ8u2KDkw08sPAgUBTDov8khKacz4wKTd+PqRV8zY0/hkdZ4hdimYU8anv1
         Yo8l4B2s/bTzBxcqE56AeaxvZfRoOBjemUq2si5DTwhW0XsHwM127D2cYNWek2WQn5Nk
         odHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703184294; x=1703789094;
        h=content-transfer-encoding:to:subject:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ntx7s0uRV0mp2r8zWsvNB9qnCJ5QsvZ3Jpv2yv8Rzbw=;
        b=KTU9WGxMccnMLElAjOYtp2s8zvboh59Ks+Ch8BLAax4CpJZUtDlpyUQW0KxetUSnUd
         vZSAjiKXQaelVCfS3j28YRNJTtIFkkXExXaC7H+FSADMJe0NCYI+0wgsll7STEk0psEJ
         vvMh4GFszihhgoQ5rssu7nsXCet/llb3CnJIwqIgRuT0TkCkjaEJVZU5Rt7GV/RB5tNR
         Z6lL7iqel5WVEVVY3/8h7ZIWH9eJEQrAdpZOeBvIHJ2DtQPZ4hOsDF9Ilz87eeP7/R95
         xvLk5z+4bwXLbTCMx1gQZ/t8QM7i963arxbxKAh1gIEtGZuIqk/7XhROb8+3r+95OUgX
         X54A==
X-Gm-Message-State: AOJu0YyHCuHJO22p3Y/lzcsHHQV91Gxqre4w5NoAo/4sZH+QjAZQ0fex
	ROcS46s8+mQhNkZG6MEaZH4=
X-Google-Smtp-Source: AGHT+IEHfvTA00m83GwRhaHI0yXC1lou9gcvK7/JhPDyAgarVWZ1ehCvpTJA55yuV8gPBaeKKVCYeQ==
X-Received: by 2002:a05:600c:1f07:b0:40c:314a:42e with SMTP id bd7-20020a05600c1f0700b0040c314a042emr81041wmb.246.1703184293889;
        Thu, 21 Dec 2023 10:44:53 -0800 (PST)
Received: from debian ([146.70.204.204])
        by smtp.gmail.com with ESMTPSA id l4-20020a05600c1d0400b0040d3276ba19sm4212714wms.25.2023.12.21.10.44.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Dec 2023 10:44:53 -0800 (PST)
Message-ID: <f4eff69d-3917-4c42-8c6b-d09597ac4437@gmail.com>
Date: Thu, 21 Dec 2023 19:44:13 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Richard Gobert <richardbgobert@gmail.com>
Subject: [PATCH net-next 0/3] net: gro: reduce extension header parsing
 overhead
To: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, shuah@kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

This series attempts to reduce parsing overhead of IPv6 extension headers
in GRO and GSO, by removing extension header specific code and enabling
the frag0 fast path.
 
The following changes were made:
- Specific unnecessary HBH conditionals were removed by adding HBH offload
  to inet6_offloads
- Added a utility function to support frag0 fast path in ipv6_gro_receive
- Added self-test for IPv6 packets with extension headers in GRO

Richard

Richard Gobert (3):
  net: gso: add HBH extension header offload support
  net: gro: parse ipv6 ext headers without frag0 invalidation
  selftests/net: fix GRO coalesce test and add ext header coalesce test

 net/ipv6/exthdrs_offload.c        | 11 +++++
 net/ipv6/ip6_offload.c            | 76 ++++++++++++++++++++----------
 tools/testing/selftests/net/gro.c | 78 ++++++++++++++++++++++++++++---
 3 files changed, 134 insertions(+), 31 deletions(-)

-- 
2.36.1



