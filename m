Return-Path: <linux-kselftest+bounces-2180-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C14B8184BE
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Dec 2023 10:49:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 33E9B1F2687D
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Dec 2023 09:49:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC1E613AFC;
	Tue, 19 Dec 2023 09:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="giun6UcR"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EC9613FE5;
	Tue, 19 Dec 2023 09:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-6d411636a95so1830641b3a.0;
        Tue, 19 Dec 2023 01:49:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702979348; x=1703584148; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Qv6ayiB0gn1PnvSmyUoAGfG9689j0sDaLczeDjG83u4=;
        b=giun6UcRzaeIGOcORwj45pI1XXv/CH3R9wYZoVIOh33xSFY02o4qxUP84P5elzgiRF
         TQNJ2Dx6KONrkMy9bSNYna1vvqQzic+C3qg+ROFtCBhfVmGhbHw0B1VsczUYRvh4D6ic
         lUAvqXV637NSVFTGgNqr3q2YkTbSwuat4Q+uoXNa/BTxt973Tlb0y9Gf+lmWIEy03zKf
         AT+nxJZFWvvWviai9LYBxlWaXAqqXOhmXEMupIQyJvnrkuBdmUA9JFfAwZy6d6q5qc5r
         g+wk0EyZ9v/mA6MpPGdD3WWRXW3F8G4TBI8kAbYzfXk0a+EfEqtSR+CKXWzk0WpOuUXB
         tBMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702979348; x=1703584148;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Qv6ayiB0gn1PnvSmyUoAGfG9689j0sDaLczeDjG83u4=;
        b=BnvY75Bc0G9EMnbknZoi3Bo0eikfvyJCZuFx10EfPpP5PnWm+2iM4QvyK5AwtKYF/+
         cGzNY2W0CFRf3OdnxFuTHPnRn5OYFY0rzypY+tBMmGwGB7zsOA+2usjXHyox/hBN2YLL
         mU7q8teWs5XPDUKS/nH920zpzqprnQYiFvtCsV77v3TdaJuzbcvPvypRrJ6MILlKmkS2
         9VGsG3MMA582LFYM4g0SaBqne8t90lXQJ1rLOhmulFGetj3RV2sIHmRkQrQVfPn1N9T4
         a1WITlFtwu3K+7gYKFqg7Ttf5akzZiYsIeVzMlKr2Cl0XSFCH5Aem2sHttGjhAVo90Me
         zmPQ==
X-Gm-Message-State: AOJu0YzEEHdbodkCKG4/8LNzP0gcjUTcRB+FXil4RNSAW7JRjCMskfNY
	Bb7/spYjMJgufmytf7w2rmmPoF6hUQAwzIW0SsY=
X-Google-Smtp-Source: AGHT+IFLH/iPzSdZo0KcEzTihpRBQ1Ba1LPjV7Z/mQ0Pq19Kgta8Jz5kWk8lBE9p2E3UZSXcsLaHgQ==
X-Received: by 2002:a17:90a:df0c:b0:28b:bdb5:f5e5 with SMTP id gp12-20020a17090adf0c00b0028bbdb5f5e5mr601487pjb.44.1702979348311;
        Tue, 19 Dec 2023 01:49:08 -0800 (PST)
Received: from Laptop-X1.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id ds17-20020a17090b08d100b0028b21d24ba6sm1076276pjb.15.2023.12.19.01.49.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Dec 2023 01:49:07 -0800 (PST)
From: Hangbin Liu <liuhangbin@gmail.com>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	David Ahern <dsahern@kernel.org>,
	linux-kselftest@vger.kernel.org,
	Po-Hsu Lin <po-hsu.lin@canonical.com>,
	Florian Westphal <fw@strlen.de>,
	Martin KaFai Lau <kafai@fb.com>,
	Stefano Brivio <sbrivio@redhat.com>,
	Kees Cook <keescook@chromium.org>,
	Hangbin Liu <liuhangbin@gmail.com>
Subject: [PATCH net-next 0/8] Convert net selftests to run in unique namespace (last part)
Date: Tue, 19 Dec 2023 17:48:48 +0800
Message-ID: <20231219094856.1740079-1-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Here is the last part of converting net selftests to run in unique namespace.
This part converts all left tests. After the conversion, we can run the net
sleftests in parallel. e.g.

 # ./run_kselftest.sh -n -t net:reuseport_bpf
 TAP version 13
 1..1
 # selftests: net: reuseport_bpf
 ok 1 selftests: net: reuseport_bpf
  mod 10...
 # Socket 0: 0
 # Socket 1: 1
 ...
 # Socket 4: 19
 # Testing filter add without bind...
 # SUCCESS

 # ./run_kselftest.sh -p -n -t net:cmsg_so_mark.sh -t net:cmsg_time.sh -t net:cmsg_ipv6.sh
 TAP version 13
 1..3
 # selftests: net: cmsg_so_mark.sh
 ok 1 selftests: net: cmsg_so_mark.sh
 # selftests: net: cmsg_time.sh
 ok 2 selftests: net: cmsg_time.sh
 # selftests: net: cmsg_ipv6.sh
 ok 3 selftests: net: cmsg_ipv6.sh

 # ./run_kselftest.sh -p -n -c net
 TAP version 13
 1..95
 # selftests: net: reuseport_bpf_numa
 ok 3 selftests: net: reuseport_bpf_numa
 # selftests: net: reuseport_bpf_cpu
 ok 2 selftests: net: reuseport_bpf_cpu
 # selftests: net: sk_bind_sendto_listen
 ok 9 selftests: net: sk_bind_sendto_listen
 # selftests: net: reuseaddr_conflict
 ok 5 selftests: net: reuseaddr_conflict
 ...

Here is the part 1 link:
https://lore.kernel.org/netdev/20231202020110.362433-1-liuhangbin@gmail.com
part 2 link:
https://lore.kernel.org/netdev/20231206070801.1691247-1-liuhangbin@gmail.com
part 3 link:
https://lore.kernel.org/netdev/20231213060856.4030084-1-liuhangbin@gmail.com

Hangbin Liu (8):
  selftests/net: convert gre_gso.sh to run it in unique namespace
  selftests/net: convert netns-name.sh to run it in unique namespace
  selftests/net: convert rtnetlink.sh to run it in unique namespace
  selftests/net: convert stress_reuseport_listen.sh to run it in unique
    namespace
  selftests/net: convert xfrm_policy.sh to run it in unique namespace
  selftests/net: use unique netns name for setup_loopback.sh
    setup_veth.sh
  selftests/net: convert pmtu.sh to run it in unique namespace
  kselftest/runner.sh: add netns support

 tools/testing/selftests/kselftest/runner.sh   |  38 ++++-
 tools/testing/selftests/net/gre_gso.sh        |  18 +--
 tools/testing/selftests/net/gro.sh            |   4 +-
 tools/testing/selftests/net/netns-name.sh     |  44 +++---
 tools/testing/selftests/net/pmtu.sh           |  27 ++--
 tools/testing/selftests/net/rtnetlink.sh      |  34 +++--
 tools/testing/selftests/net/setup_loopback.sh |   8 +-
 tools/testing/selftests/net/setup_veth.sh     |   9 +-
 .../selftests/net/stress_reuseport_listen.sh  |   6 +-
 tools/testing/selftests/net/toeplitz.sh       |  14 +-
 tools/testing/selftests/net/xfrm_policy.sh    | 138 +++++++++---------
 tools/testing/selftests/run_kselftest.sh      |  10 +-
 12 files changed, 193 insertions(+), 157 deletions(-)

-- 
2.43.0


