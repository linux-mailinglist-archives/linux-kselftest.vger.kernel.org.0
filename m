Return-Path: <linux-kselftest+bounces-11636-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62EE1902E58
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Jun 2024 04:27:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BC69FB21360
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Jun 2024 02:27:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 383F515AAD5;
	Tue, 11 Jun 2024 02:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SkowLrCu"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 110D4BA4B;
	Tue, 11 Jun 2024 02:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718072870; cv=none; b=XEsetVp4v6Qtk2ybbhVZ33HxEKnFWKh3h5htBWEqmsAg5jS2F0032KTVf/HHSo87ae27KYBMUj3/6z/Y1TJRU2fAxBhKFbTImFVStOJ39weXqL75Jw9wnNS9uDsiOTYsetXVVu2CnVzv83GlCmACG4SSmg7FsVEKrPp+mHlLog4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718072870; c=relaxed/simple;
	bh=2N7cLTt3HayJgqi/3bNdeO+1xYh+bh+nh3jwFc5kyz8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HL9FeUMTd913YHCceD62H0sncMU0+1bufNcy0LZ5ZO3qagiVy0aSHmCH9+iFBXPv9d3pOfJ3Fr2ZsDfVNJSGxDvCv25ZpYw2tCsQsI+57wEO2j352M033kI/HLWH/kGVXzBDfpUU/QZKvhePfYSxOS/9HZMG7mdjH/LdUq72PEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SkowLrCu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 481BEC2BBFC;
	Tue, 11 Jun 2024 02:27:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718072869;
	bh=2N7cLTt3HayJgqi/3bNdeO+1xYh+bh+nh3jwFc5kyz8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SkowLrCucwT6AHkKRzdjB+yWZb9BYH5xQ0wT/G52yMQs3THSE4bKuNrAIONz70vo4
	 fQ1CNGxeqeiyKRIgp7xkPEDWLsvo0Y6GVZi8jz0eU5wb8ZGyWjlafnSf4A1e70w3Vc
	 SXWIQPT3sPT/TbBLe9vCERqL6yKrbBt9GT54ZbQJyXFxV+xY6T1lCoNpbAsoY46nqq
	 4usAIX/LEAch1mK/6fHDRka+gZCSoPej29y3Zv/X2p0TRAv6PSxXik5nNDP8lOhhyF
	 RG2GTPPYR90s2XjM4AStpBBDIsR+VFyLqtfawm2w1+MwZQ+Ct9qFQu3+IQ1lDxswGv
	 Br/oUv0RfttXg==
From: Geliang Tang <geliang@kernel.org>
To: Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Mykola Lysenko <mykolal@fb.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Shuah Khan <shuah@kernel.org>
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH bpf-next v2 1/2] selftests/bpf: Enable INET_XFRM_TUNNEL in config
Date: Tue, 11 Jun 2024 10:27:27 +0800
Message-ID: <e11e980f06bd94eb86b52891bb70ddb3ab2aa8bc.1718072698.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1718072698.git.tanggeliang@kylinos.cn>
References: <cover.1718072698.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

The kconfigs CONFIG_INET_XFRM_TUNNEL and CONFIG_INET6_XFRM_TUNNEL are
needed by test_tunnel tests. This patch enables them together with the
dependent kconfigs CONFIG_INET_IPCOMP and CONFIG_INET6_IPCOMP.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/bpf/config | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/testing/selftests/bpf/config b/tools/testing/selftests/bpf/config
index 2fb16da78dce..de358b51a05a 100644
--- a/tools/testing/selftests/bpf/config
+++ b/tools/testing/selftests/bpf/config
@@ -96,3 +96,7 @@ CONFIG_XDP_SOCKETS=y
 CONFIG_XFRM_INTERFACE=y
 CONFIG_TCP_CONG_DCTCP=y
 CONFIG_TCP_CONG_BBR=y
+CONFIG_INET_IPCOMP=y
+CONFIG_INET_XFRM_TUNNEL=y
+CONFIG_INET6_IPCOMP=y
+CONFIG_INET6_XFRM_TUNNEL=y
-- 
2.43.0


