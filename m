Return-Path: <linux-kselftest+bounces-18024-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DAD31979C60
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Sep 2024 10:02:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 84DDD1F23E8E
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Sep 2024 08:02:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A3D713B5AF;
	Mon, 16 Sep 2024 08:02:01 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF9D6136357;
	Mon, 16 Sep 2024 08:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726473721; cv=none; b=CVzIdlVXw8d2ExT2gQkW0Rgn0QXbEbLetufACW8XgrAIKxR0IoEhweiaDy3RgSKcgkSxF9DhVP7uwk6LCLqAQKT2jKaZpV3FQSYWMrzPB5qBPG+DeOXl44dzRks3Daz8r4hisuV9QsRCGgBamUTvu/6vpkuCJZy/xDEX+pSaIlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726473721; c=relaxed/simple;
	bh=46/KW6t/Ri9qLs83dZwNcfB7QL78F1lTLAYCmSjs+g4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BZsoAN/4Q9akuHMERpLQghLMBprtHLqX4oL+xf0b4EimlIjhOrdyVbOH38VkD+Gr2nKhy+PikL5W34bsRjqePlHZrP/ItEbOKzDm1asCjLbBDOT00Crq+SaU1rsktdCvOVUdnk9g5YEYTSknAUi44siKMX/W5W6CA5a6tbLdvYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4X6cjH0kRmz6L6ww;
	Mon, 16 Sep 2024 15:58:11 +0800 (CST)
Received: from frapeml500005.china.huawei.com (unknown [7.182.85.13])
	by mail.maildlp.com (Postfix) with ESMTPS id 827341400CB;
	Mon, 16 Sep 2024 16:01:55 +0800 (CST)
Received: from china (10.221.233.88) by frapeml500005.china.huawei.com
 (7.182.85.13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Mon, 16 Sep
 2024 10:01:46 +0200
From: <gur.stavi@huawei.com>
To: <gur.stavi@huawei.com>
CC: <akihiko.odaki@daynix.com>, <andrew@daynix.com>, <corbet@lwn.net>,
	<davem@davemloft.net>, <edumazet@google.com>, <jasowang@redhat.com>,
	<kuba@kernel.org>, <kvm@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
	<mst@redhat.com>, <netdev@vger.kernel.org>, <pabeni@redhat.com>,
	<shuah@kernel.org>, <virtualization@lists.linux-foundation.org>,
	<willemdebruijn.kernel@gmail.com>, <xuanzhuo@linux.alibaba.com>,
	<yuri.benditovich@daynix.com>
Subject: [PATCH RFC v3 2/9] virtio_net: Add functions for hashing
Date: Mon, 16 Sep 2024 11:01:36 +0300
Message-ID: <20240916080137.508-1-gur.stavi@huawei.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240916071253.462-1-gur.stavi@huawei.com>
References: <20240916071253.462-1-gur.stavi@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 frapeml500005.china.huawei.com (7.182.85.13)

> +
> +static inline void virtio_net_toeplitz(struct virtio_net_toeplitz_state *state,
> +				       const __be32 *input, size_t len)
> 
> The function calculates a hash value but its name does not make it
> clear. Consider adding a 'calc'.
> 
> +{
> +	u32 key;
> +
> +	while (len) {
> +		state->key++;
> +		key = be32_to_cpu(*state->key);
> 
> You perform be32_to_cpu to support both CPU endianities.
> If you will follow with an unconditional swab32, you could run the
> following loop on a more natural 0 to 31 always referring to bit 0
> and avoiding !!(key & bit):
> 
> key = swab32(be32_to_cpu(*state->key));
> for (i = 0; i < 32; i++, key >>= 1) {
> 	if (be32_to_cpu(*input) & 1)
> 		state->hash ^= state->key_buffer;
> 	state->key_buffer = (state->key_buffer << 1) | (key & 1);
> }
> 

Fixing myself, in previous version 'input' was tested against same bit.
Advantage is less clear now, replacing !! with extra shift.
However, since little endian CPUs are more common, the combination of
swab32(be32_to_cpu(x) will actually become a nop.
Similar tactic may be applied to 'input' by assigning it to local
variable. This may produce more efficient version but not necessary
easier to understand.

key = bswap32(be32_to_cpu(*state->key));
for (u32 bit = BIT(31); bit; bit >>= 1, key >>= 1) {
	if (be32_to_cpu(*input) & bit)
		state->hash ^= state->key_buffer;
	state->key_buffer =
		(state->key_buffer << 1) | (key & 1);
}

> 
> +
> +		for (u32 bit = BIT(31); bit; bit >>= 1) {
> +			if (be32_to_cpu(*input) & bit)
> +				state->hash ^= state->key_buffer;
> +
> +			state->key_buffer =
> +				(state->key_buffer << 1) | !!(key & bit);
> +		}
> +
> +		input++;
> +		len--;
> +	}
> +}
> +

