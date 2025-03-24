Return-Path: <linux-kselftest+bounces-29630-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 220C6A6D84D
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Mar 2025 11:31:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C91207A5D0F
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Mar 2025 10:30:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E18A25DAE9;
	Mon, 24 Mar 2025 10:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o3Oh38jK"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31F8814386D;
	Mon, 24 Mar 2025 10:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742812301; cv=none; b=V29mWiU0I3wfODOdrM7n5aTJxcWaVE+d7oLqfyjr2PIcBcNpvlVjcNTRah8MPOgoNq2hZtYapTfmFR0iiWbnFZy7/2MmZhclI7xaSneUW5EBq3+Xw3l2xnC/E3OkJoka9JhzsDxOk1Z4BObpMgNrqNxsAq3srFPnVSfSj6apAgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742812301; c=relaxed/simple;
	bh=7GAZFJZl+eKu5P9ihY2WmQuvZGa6gA3gVGjHE+fPDMo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Yuwy2ty9+Q0069q16rkraxy6G3wWTDigQzkwqWNWBYeeDt7AG2O/nwYyHtTxE0W90lBkqJC253qou5Ac44wdPYZ6fG7qHvf6ljQTmTPpH2c9ufWHmbBOqUE47uR9cV6qlE7FvpRXbqVzkAHVHGtGVXA08XFP5hTDWJ5129p3SZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o3Oh38jK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72F69C4CEDD;
	Mon, 24 Mar 2025 10:31:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742812300;
	bh=7GAZFJZl+eKu5P9ihY2WmQuvZGa6gA3gVGjHE+fPDMo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=o3Oh38jKmLbmx2Hy9PuIK6O8ifW4Y0N/uz0RAy/iM6IehElvV79s5T/S0HnlpjEbj
	 CmquiYEvuA9O2qYRu6Jy3udMGB+/ImugKje5kRLPpU0rGJgmmjwa92rnD5SIW2gtjh
	 I/RCkgdLwrK0tz1nXth2eJCD9l0DW53CiFJqn2aStOg9EERHD7wXDs9LEm5Ex4BfjK
	 7z1UkMS6uNVFLXJPXYTp5FlDOo2f/q+SPd5xsISTmMbHr+F9LwH6HclxFneC3VUO4W
	 muKE/QeNmJJhfayAnei1uqT+8MbSJMn9ChCu6fHf62r9NERRKh1i1EGMqY4hVuIdBK
	 2nFLB2fDdo/Xw==
Date: Mon, 24 Mar 2025 03:31:29 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Willem de Bruijn
 <willemdebruijn.kernel@gmail.com>, Jason Wang <jasowang@redhat.com>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Xuan Zhuo
 <xuanzhuo@linux.alibaba.com>, Shuah Khan <shuah@kernel.org>,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, kvm@vger.kernel.org,
 virtualization@lists.linux-foundation.org, linux-kselftest@vger.kernel.org,
 Yuri Benditovich <yuri.benditovich@daynix.com>, Andrew Melnychenko
 <andrew@daynix.com>, Stephen Hemminger <stephen@networkplumber.org>,
 gur.stavi@huawei.com, Lei Yang <leiyang@redhat.com>, Simon Horman
 <horms@kernel.org>
Subject: Re: [PATCH net-next v11 09/10] selftest: tap: Add tests for
 virtio-net ioctls
Message-ID: <20250324033129.0016abc9@kernel.org>
In-Reply-To: <20250317-rss-v11-9-4cacca92f31f@daynix.com>
References: <20250317-rss-v11-0-4cacca92f31f@daynix.com>
	<20250317-rss-v11-9-4cacca92f31f@daynix.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 17 Mar 2025 19:57:59 +0900 Akihiko Odaki wrote:
> +TEST_F(tap, test_vnetbe)
> +{
> +	int be = 1;
> +	int ret;
> +
> +	ASSERT_FALSE(dev_delete(param_dev_tap_name));
> +	self->deleted = true;
> +
> +	ret = ioctl(self->fd, TUNSETVNETBE, &be);
> +	if (ret == -1 && errno == EINVAL)
> +		SKIP(return, "TUNSETVNETBE not supported");
> +
> +	ASSERT_FALSE(ret);
> +	be = 0;
> +	ASSERT_FALSE(ioctl(self->fd, TUNGETVNETBE, &be));
> +	EXPECT_EQ(1, be);

The config options needed by selftests should be listed in the relevant
config file, I think you need this snippet:

diff --git a/tools/testing/selftests/net/config b/tools/testing/selftests/net/config
index 130d532b7e67..9b6aa8c4e6d8 100644
--- a/tools/testing/selftests/net/config
+++ b/tools/testing/selftests/net/config
@@ -101,6 +101,7 @@ CONFIG_IPV6_IOAM6_LWTUNNEL=y
 CONFIG_CRYPTO_SM4_GENERIC=y
 CONFIG_AMT=m
 CONFIG_TUN=y
+CONFIG_TUN_VNET_CROSS_LE=y
 CONFIG_VXLAN=m
 CONFIG_IP_SCTP=m
 CONFIG_NETFILTER_XT_MATCH_POLICY=m
-- 
pw-bot: cr

