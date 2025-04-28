Return-Path: <linux-kselftest+bounces-31785-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C72A1A9F4CF
	for <lists+linux-kselftest@lfdr.de>; Mon, 28 Apr 2025 17:44:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF5063A8C26
	for <lists+linux-kselftest@lfdr.de>; Mon, 28 Apr 2025 15:44:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB09426FA6A;
	Mon, 28 Apr 2025 15:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GxHyUZLd"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEFC114A62B;
	Mon, 28 Apr 2025 15:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745855064; cv=none; b=otCrRfntqDHnpsoTPmBGvluTbQaqWXspOhmyahlgyYvBnbioTuAi6Q7euHZ0m0uyRL/w/u+gr9lLmAOfwkim2wSefFs6daK0ES5bBkffvZrTVMeBlUeFeDIX2bCvVpb1SKPm/c8dLiR1tH43DVLS3sikuGSaepkbd9X9/vviSYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745855064; c=relaxed/simple;
	bh=iLG3fqqfp4/aP0KBXyfC3Ee/J6tueQqSLAA581tEjYM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=XigpwktKDP6x2s5u6m5qal2994iOGfavhKJwomv+BwW7225UbyzOr3jAO6fOlymhhIsyVObs8aCa8aqZK3ZUt2GWUEr33Wu26IGcmDmxhIBceoZfd9FInw+4skPaWAfkcAWqtLUZR/CHwpYt95rDlnpFRBIUlKwXrPG5OTldLKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GxHyUZLd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4999C4CEEC;
	Mon, 28 Apr 2025 15:44:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745855064;
	bh=iLG3fqqfp4/aP0KBXyfC3Ee/J6tueQqSLAA581tEjYM=;
	h=From:Subject:Date:To:Cc:From;
	b=GxHyUZLd1KRiBFyAtE17e6oqct6GQnIsCixsSaSqnyYdf4CMLxToETf9S7WSVVLDz
	 82RuqYMo17sJKVtoDXlO7o+XYAUUvFR20dhP7y7Uua82d/d3LgGkGlH0gNCMhrAy+a
	 LrR+Iu5xx2uUb1hETYk+KkjYwxgEWUbxaSQYh0UJtUR7KxL/SWJYQRZN85fesy99dJ
	 +p6qKTzPCZC+lkKCdt7xr7TKSSChr7GhUImXnpZg7jxveuyZ31Dyi+P5XEB45GpfKk
	 /TBdiTHyh0hwq6c5yOxWFs/rv3Gw/1aNSeCDNMXjvCNq0194OwnWQiuHmoAbEhNqkp
	 dZEuWEZQIYsEw==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Subject: [PATCH bpf-next v3 0/2] bpf: Allow XDP_REDIRECT for XDP dev-bound
 programs
Date: Mon, 28 Apr 2025 17:44:01 +0200
Message-Id: <20250428-xdp-prog-bound-fix-v3-0-c9e9ba3300c7@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAEGiD2gC/33NTQrCMBCG4atI1o7kp9HqynuIi7SZtEFJykRDp
 fTupl0piMv3g3lmYgnJY2KnzcQIs08+hhJqu2Ftb0KH4G1pJrnUvJISRjvAQLGDJj6DBedHODr
 FnUKhKmNYORwIy7yil2vp3qdHpNf6I4tl/ctlAQJ4o2vhjKj3Ds83pID3XaSOLV6Wn4b6achia
 HGopNHWNe23Mc/zG05VXiH5AAAA
X-Change-ID: 20250422-xdp-prog-bound-fix-9f30f3e134aa
To: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Andrii Nakryiko <andrii@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
 Jiri Olsa <jolsa@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Jakub Kicinski <kuba@kernel.org>, Jesper Dangaard Brouer <hawk@kernel.org>, 
 Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Lorenzo Bianconi <lorenzo@kernel.org>
X-Mailer: b4 0.14.2

In the current implementation if the program is dev-bound to a specific
device, it will not be possible to perform XDP_REDIRECT into a DEVMAP or
CPUMAP even if the program is running in the driver NAPI context.
Fix the issue introducing __bpf_prog_map_compatible utility routine in
order to avoid bpf_prog_is_dev_bound() during the XDP program load.
Continue forbidding to attach a dev-bound program to XDP maps.

---
Changes in v3:
- move seltest changes in a dedicated patch
- Link to v2: https://lore.kernel.org/r/20250423-xdp-prog-bound-fix-v2-1-51742a5dfbce@kernel.org

Changes in v2:
- Introduce __bpf_prog_map_compatible() utility routine in order to skip
  bpf_prog_is_dev_bound check in bpf_check_tail_call()
- Extend xdp_metadata selftest
- Link to v1: https://lore.kernel.org/r/20250422-xdp-prog-bound-fix-v1-1-0b581fa186fe@kernel.org

---
Lorenzo Bianconi (2):
      bpf: Allow XDP dev-bound programs to perform XDP_REDIRECT into maps
      selftests/bpf: xdp_metadata: check XDP_REDIRCT support for dev-bound progs

 kernel/bpf/core.c                                  | 27 +++++++++++++---------
 .../selftests/bpf/prog_tests/xdp_metadata.c        | 22 +++++++++++++++++-
 tools/testing/selftests/bpf/progs/xdp_metadata.c   | 13 +++++++++++
 3 files changed, 50 insertions(+), 12 deletions(-)
---
base-commit: 91dbac4076537b464639953c055c460d2bdfc7ea
change-id: 20250422-xdp-prog-bound-fix-9f30f3e134aa

Best regards,
-- 
Lorenzo Bianconi <lorenzo@kernel.org>


