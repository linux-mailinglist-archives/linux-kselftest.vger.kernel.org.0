Return-Path: <linux-kselftest+bounces-2561-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E6C2821C6E
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Jan 2024 14:16:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E0FC9B222CA
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Jan 2024 13:16:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DCF7F9EF;
	Tue,  2 Jan 2024 13:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nFbw9+uz"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 001D6F9E0;
	Tue,  2 Jan 2024 13:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3367a304091so9172292f8f.3;
        Tue, 02 Jan 2024 05:15:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704201357; x=1704806157; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=dqqX1JqpimAC6WihwYqyfae5QhT3NRDdGoohV28wxAI=;
        b=nFbw9+uzOZxxYuLF5AEsqx83bjvpEB5bTrs65RjTSV8+E5MJ3+ioF5MTOFFRWRyk+J
         qqHstuteQupFf/RJCbscuwPzp9DglpqGFlDsWmJtPdkz/sR6fjTh0K2GMHgGBUNCNmZm
         0vf/sPwmp1FBiL3W+g9Uz2aqTTK+HrE0/OyhuF9D5KoHNuy+Ko53fy+g9LfwDiQ1zZYN
         cT1PXrZIXTKzvoWZ5KKjB6XVZBs6sJ6xJvKQDXW/xEipt06KyjUAJq/QLi5IkgxE0776
         jZEmYNKymZh2pG3UL1db2Rjb2tiNZk48+HcKzyzP0rw92pRoy0DlCol/1UDn8BIuNZjx
         1/Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704201357; x=1704806157;
        h=content-transfer-encoding:to:subject:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dqqX1JqpimAC6WihwYqyfae5QhT3NRDdGoohV28wxAI=;
        b=UXBj8u64+x2vOsZYK+Xa/JBBCb0fLamYLdpsCMaeM96Jgr35ZPW4qd4VMzVFkvQU1M
         a/n9ovIpcoJBQ/4Bv6DBCVe2hIPcPGHLWfTnMMEA5lW+a+LY2DrrH8W2Diug0o27zYxW
         ELBgHQ5ofP3mvmERv9XGKbte1O2vP1JrLDUXJ4Z2dFn7jwvCI0LJ9Dfagyd1bPGnvrv/
         5uLbD1DDh7ZGq0FHSM9t+1djjM6kYy1t4nTzD5Za0QBwJz/c8yfRqctQmv2gl3rRNNnx
         KWpkBElNrRH0HMez5V9KjIx85Vg7B8Fh09NBXTyczmujLoRmeCmLLy3It4AXMLi+6mDu
         kvBg==
X-Gm-Message-State: AOJu0YzedBeFFYgVrW35tSP6ANdp2hdd68gbbQ5WFU/Jq7LPxqDqnUB6
	wuBc0IR7Ziea6FdyFIZnWhs=
X-Google-Smtp-Source: AGHT+IGcS7PgOg4I+exgCKVC94VRbmPUFjcbsafH6LxZaK3p42Hs+yK476OdyEYRPY987/x9j+YIAA==
X-Received: by 2002:adf:e648:0:b0:337:4a10:ea9 with SMTP id b8-20020adfe648000000b003374a100ea9mr141492wrn.207.1704201356973;
        Tue, 02 Jan 2024 05:15:56 -0800 (PST)
Received: from debian ([146.70.204.204])
        by smtp.gmail.com with ESMTPSA id dr15-20020a5d5f8f000000b003373ece28efsm5985602wrb.29.2024.01.02.05.15.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Jan 2024 05:15:56 -0800 (PST)
Message-ID: <127b8199-1cd4-42d7-9b2b-875abaad93fe@gmail.com>
Date: Tue, 2 Jan 2024 14:15:43 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Richard Gobert <richardbgobert@gmail.com>
Subject: [PATCH net-next v2 0/3] net: gro: reduce extension header parsing
 overhead
To: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, shuah@kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

This series attempts to reduce the parsing overhead of IPv6 extension
headers in GRO and GSO, by removing extension header specific code and
enabling the frag0 fast path.
 
The following changes were made:
 - Removed some unnecessary HBH conditionals by adding HBH offload
   to inet6_offloads
 - Added a utility function to support frag0 fast path in ipv6_gro_receive
 - Added selftests for IPv6 packets with extension headers in GRO

Richard

v1 -> v2:
 - Added a minimum IPv6 extension header length constant to make code self
   documenting.
 - Added new selftest which checks that packets with different extension
   header payloads do not coalesce.
 - Added more info in the second commit message regarding the code changes.
 - v1:
   https://lore.kernel.org/netdev/f4eff69d-3917-4c42-8c6b-d09597ac4437@gmail.com/

Richard Gobert (3):
  net: gso: add HBH extension header offload support
  net: gro: parse ipv6 ext headers without frag0 invalidation
  selftests/net: fix GRO coalesce test and add ext header coalesce tests

 include/net/ipv6.h                |  1 +
 net/ipv6/exthdrs_offload.c        | 11 ++++
 net/ipv6/ip6_offload.c            | 76 +++++++++++++++++--------
 tools/testing/selftests/net/gro.c | 94 +++++++++++++++++++++++++++++--
 4 files changed, 152 insertions(+), 30 deletions(-)

-- 
2.36.1


