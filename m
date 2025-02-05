Return-Path: <linux-kselftest+bounces-25782-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D314CA2821F
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Feb 2025 03:44:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D510A7A2E62
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Feb 2025 02:43:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E71521323C;
	Wed,  5 Feb 2025 02:42:50 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C20F200A3;
	Wed,  5 Feb 2025 02:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738723370; cv=none; b=fe6RFtY1z2PBU95ToUQ0WKxn8Lkvp8VAOnIpBLyOpijqIuvvS1/JXajvtN9u3rpHB3LcWNyK15VDHSjwlaEh7gmGzJvE7+TVOLKDYE/WsAcHjfB1LLHtcBG49PU2ir0xcE+92LnT0u0+vOUi1WLrJZtm+oeDuUW1nyIUwMRcsIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738723370; c=relaxed/simple;
	bh=HCm+P1j6fb2x+58L1VY6iZ16Bgr0r6sjqAeUyrkl6NQ=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=mYzmCKOTefinEXuE3VjfIsN6ZRfhqpqcjrh96zonbUJzeCNuI6SlWTLKeg5TTjHx/Rwh8wOByqBbasTnJZtCxdER2dBjAnZygNSJCyRQ7Pz1SIp9bRkQ4teFg6NgF6FSehsncM+cwXTKbDIELJ/hi15Hcbpnv+kbLZRFj19huwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4YnkzJ24Dyz4f3jY3;
	Wed,  5 Feb 2025 10:42:20 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id 61F811A0FED;
	Wed,  5 Feb 2025 10:42:41 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
	by APP3 (Coremail) with SMTP id _Ch0CgDHGMMa0KJn3+GbCw--.28738S2;
	Wed, 05 Feb 2025 10:42:38 +0800 (CST)
Subject: Re: [PATCH bpf-next v1] selftests/bpf: correct the check of join
 cgroup
To: Jason Xing <kerneljasonxing@gmail.com>, ast@kernel.org,
 daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com, mykolal@fb.com,
 martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev,
 john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me,
 haoluo@google.com, jolsa@kernel.org, shuah@kernel.org
Cc: bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
 Martin KaFai Lau <martin.lau@kernel.org>
References: <20250204051154.57655-1-kerneljasonxing@gmail.com>
From: Hou Tao <houtao@huaweicloud.com>
Message-ID: <96d70d0b-048a-e715-0348-c1ba4b3e0e59@huaweicloud.com>
Date: Wed, 5 Feb 2025 10:42:34 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20250204051154.57655-1-kerneljasonxing@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-CM-TRANSID:_Ch0CgDHGMMa0KJn3+GbCw--.28738S2
X-Coremail-Antispam: 1UD129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UjIYCTnIWjp_UUUYQ7kC6x804xWl14x267AKxVW5JVWrJwAF
	c2x0x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII
	0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xv
	wVC0I7IYx2IY6xkF7I0E14v26F4j6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7
	xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40E
	FcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr
	0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY
	04v7Mxk0xIA0c2IEe2xFo4CEbIxvr21l42xK82IYc2Ij64vIr41l4c8EcI0Ec7CjxVAaw2
	AFwI0_GFv_Wryl4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC2
	0s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMI
	IF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF
	0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87
	Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUFDGOUUUUU
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/



On 2/4/2025 1:11 PM, Jason Xing wrote:
> Use ASSERT_OK_FD to check the return value of join cgroup,
> or else this test will pass even if the fd < 0. ASSERT_OK_FD
> can print the error message to the console.
>
> Link: https://lore.kernel.org/all/6d62bd77-6733-40c7-b240-a1aeff55566c@linux.dev/
> Suggested-by: Martin KaFai Lau <martin.lau@kernel.org>
> Signed-off-by: Jason Xing <kerneljasonxing@gmail.com>

Acked-by: Hou Tao <houtao1@huawei.com>


