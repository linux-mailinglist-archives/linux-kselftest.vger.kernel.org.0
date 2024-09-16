Return-Path: <linux-kselftest+bounces-18036-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 573E7979D22
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Sep 2024 10:46:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 89B291C2208D
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Sep 2024 08:46:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C66861411E0;
	Mon, 16 Sep 2024 08:46:42 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A88BEF9DA;
	Mon, 16 Sep 2024 08:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726476402; cv=none; b=n9/j+XwlRNVU5e0D4KwHvLi9VX14vW93CkakfQVoLnCbadWMGTyPmfHLbgqannC7IYJ15pllVq/LEP2z97PrBF2gxs9mEd+vQMmx0zOy+aL0w+jdUQ9c+8kzBe8di5RnmjiirJ5/5We1in8JRsjq0TrQTScn91oy2lV6DQPnR+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726476402; c=relaxed/simple;
	bh=XM85QJ+Tc2CQ3IWFm1G1jTKIuhtI8vmRVh0zF/XCmnk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HTgQv70zSrGKOR9mFtl1kiu0d7zZ0mSrgkQ1j+ugyEj3te7p3pOtg98uI/an0eCSDwWltoZV/iVEUKd9moqZTfCyXUb4pJXP4FTiN69JAFX1dSwo85RposMNxQjupBSYsYvr+LH2P74O0w8QlMUBhY/OVn91o0mXct43+boULz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4X6dhr4KZ7z6L7DQ;
	Mon, 16 Sep 2024 16:42:52 +0800 (CST)
Received: from frapeml500005.china.huawei.com (unknown [7.182.85.13])
	by mail.maildlp.com (Postfix) with ESMTPS id 148FE140158;
	Mon, 16 Sep 2024 16:46:37 +0800 (CST)
Received: from china (10.221.233.88) by frapeml500005.china.huawei.com
 (7.182.85.13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Mon, 16 Sep
 2024 10:46:28 +0200
From: <gur.stavi@huawei.com>
To: <akihiko.odaki@daynix.com>
CC: <andrew@daynix.com>, <corbet@lwn.net>, <davem@davemloft.net>,
	<edumazet@google.com>, <jasowang@redhat.com>, <kuba@kernel.org>,
	<kvm@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
	<mst@redhat.com>, <netdev@vger.kernel.org>, <pabeni@redhat.com>,
	<shuah@kernel.org>, <virtualization@lists.linux-foundation.org>,
	<willemdebruijn.kernel@gmail.com>, <xuanzhuo@linux.alibaba.com>,
	<yuri.benditovich@daynix.com>
Subject: [PATCH RFC v3 2/9] virtio_net: Add functions for hashing
Date: Mon, 16 Sep 2024 11:46:18 +0300
Message-ID: <20240916084619.581-1-gur.stavi@huawei.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240915-rss-v3-2-c630015db082@daynix.com>
References: <20240915-rss-v3-2-c630015db082@daynix.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 frapeml500005.china.huawei.com (7.182.85.13)

> +
> +static inline bool virtio_net_hash_rss(const struct sk_buff *skb,
> +				       u32 types, const __be32 *key,
> +				       struct virtio_net_hash *hash)

Based on the guidelines, this function seems imperative rather than
predicate and should return an error-code integer.

https://www.kernel.org/doc/html/latest/process/coding-style.html#function-return-values-and-names

> +{
> +	u16 report;
> +	struct virtio_net_toeplitz_state toeplitz_state = {
> +		.key_buffer = be32_to_cpu(*key),
> +		.key = key
> +	};
> +	struct flow_keys flow;
> +
> +	if (!skb_flow_dissect_flow_keys(skb, &flow, 0))
> +		return false;
> +
> +	report = virtio_net_hash_report(types, flow.basic);
> +
> +	switch (report) {
> +	case VIRTIO_NET_HASH_REPORT_IPv4:
> +		virtio_net_toeplitz(&toeplitz_state,
> +				    (__be32 *)&flow.addrs.v4addrs,
> +				    sizeof(flow.addrs.v4addrs) / 4);
> +		break;
> +
> +	case VIRTIO_NET_HASH_REPORT_TCPv4:
> +		virtio_net_toeplitz(&toeplitz_state,
> +				    (__be32 *)&flow.addrs.v4addrs,
> +				    sizeof(flow.addrs.v4addrs) / 4);
> +		virtio_net_toeplitz(&toeplitz_state, &flow.ports.ports,
> +				    1);
> +		break;
> +
> +	case VIRTIO_NET_HASH_REPORT_UDPv4:
> +		virtio_net_toeplitz(&toeplitz_state,
> +				    (__be32 *)&flow.addrs.v4addrs,
> +				    sizeof(flow.addrs.v4addrs) / 4);
> +		virtio_net_toeplitz(&toeplitz_state, &flow.ports.ports,
> +				    1);
> +		break;
> +
> +	case VIRTIO_NET_HASH_REPORT_IPv6:
> +		virtio_net_toeplitz(&toeplitz_state,
> +				    (__be32 *)&flow.addrs.v6addrs,
> +				    sizeof(flow.addrs.v6addrs) / 4);
> +		break;
> +
> +	case VIRTIO_NET_HASH_REPORT_TCPv6:
> +		virtio_net_toeplitz(&toeplitz_state,
> +				    (__be32 *)&flow.addrs.v6addrs,
> +				    sizeof(flow.addrs.v6addrs) / 4);
> +		virtio_net_toeplitz(&toeplitz_state, &flow.ports.ports,
> +				    1);
> +		break;
> +
> +	case VIRTIO_NET_HASH_REPORT_UDPv6:
> +		virtio_net_toeplitz(&toeplitz_state,
> +				    (__be32 *)&flow.addrs.v6addrs,
> +				    sizeof(flow.addrs.v6addrs) / 4);
> +		virtio_net_toeplitz(&toeplitz_state, &flow.ports.ports,
> +				    1);
> +		break;
> +
> +	default:
> +		return false;
> +	}
> +
> +	hash->value = toeplitz_state.hash;
> +	hash->report = report;
> +
> +	return true;
> +}
> +

