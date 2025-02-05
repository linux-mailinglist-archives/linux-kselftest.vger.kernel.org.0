Return-Path: <linux-kselftest+bounces-25784-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9345DA2823B
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Feb 2025 03:57:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C655165E72
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Feb 2025 02:57:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24543212B04;
	Wed,  5 Feb 2025 02:57:30 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8679A25A65E;
	Wed,  5 Feb 2025 02:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738724250; cv=none; b=ZpPoLzaGTKsq+bKMA2N3sUDpSmhZ5moq/1ra7QVyqM5vhQdvftgUE82YGYb6qN+CiB8t9w6h+Syso65hdLbaXfAL1kJqUnGgaPrNKBszJvsT0IuSUFp1UhV96sBwt5T9NyPgFMgvA+06f5Dj/Rtz/wO3FAq9rfAodnkzJ62pLkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738724250; c=relaxed/simple;
	bh=AfulHl21s7hVAp0pzpF1SNz5m0L8t342/MNzQ8Yz8JE=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=De/jZ/cyqFKX6/+NAb0ksjUETBrr5wXfR46laW+SD9vkllCoDLbfbVx9tMn+xa5wAWfv6XCWFhlgBPVToSX8pDkUeGbS8tOCQNuO4ZgM1YdVGVPscbbIhH6JUPTQ+i4T6IFaj7APNHNBaG35rhF8cHlZRti+oz6WUh9KXjRTSLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=none smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4YnlJL6ldTz4f3jsx;
	Wed,  5 Feb 2025 10:57:06 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id C27D21A10B0;
	Wed,  5 Feb 2025 10:57:22 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
	by APP3 (Coremail) with SMTP id _Ch0CgBH58GO06Jnx9KcCw--.20669S2;
	Wed, 05 Feb 2025 10:57:22 +0800 (CST)
Subject: Re: [PATCH bpf-next v1 2/2] bpf: sockopt_sk: fix 'undeclared'
 definition error
To: Jason Xing <kerneljasonxing@gmail.com>, bpf@vger.kernel.org,
 linux-kselftest@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 eddyz87@gmail.com, mykolal@fb.com, martin.lau@linux.dev, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, shuah@kernel.org
References: <20250204023946.16031-1-kerneljasonxing@gmail.com>
 <20250204023946.16031-3-kerneljasonxing@gmail.com>
From: Hou Tao <houtao@huaweicloud.com>
Message-ID: <99ccf971-cae5-9c45-5dff-2c8563a7879f@huaweicloud.com>
Date: Wed, 5 Feb 2025 10:57:18 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20250204023946.16031-3-kerneljasonxing@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID:_Ch0CgBH58GO06Jnx9KcCw--.20669S2
X-Coremail-Antispam: 1UD129KBjvJXoWxJr45Wr48Zw4rXF47Kr45Jrb_yoW8GF1rpa
	4kAa4jk3yxCFWYq3ZrGF4avF10gF4UA34Ykw4ktr1Dur1xGF97JrWIkrZ8WFn3WrZIvrsY
	v34xKFn8uw4DZFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9Ib4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7Mxk0xIA0c2IE
	e2xFo4CEbIxvr21lc7CjxVAaw2AFwI0_GFv_Wryl42xK82IYc2Ij64vIr41l4I8I3I0E4I
	kC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWU
	WwC2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr
	0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWU
	JVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJb
	IYCTnIWIevJa73UjIFyTuYvjxUIa0PDUUUU
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/

Hi,

On 2/4/2025 10:39 AM, Jason Xing wrote:
> Error messages:
> selftests/bpf/prog_tests/sockopt_sk.c: In function ‘getsetsockopt’:
> selftests/bpf/prog_tests/sockopt_sk.c:22:31: error: field ‘zc’ has incomplete type
>    struct tcp_zerocopy_receive zc;
>                                ^~
> selftests/bpf/prog_tests/sockopt_sk.c:169:32: error: ‘TCP_ZEROCOPY_RECEIVE’ undeclared (first use in this function)
>   err = getsockopt(fd, SOL_TCP, TCP_ZEROCOPY_RECEIVE, &buf, &optlen);
>                                 ^~~~~~~~~~~~~~~~~~~~
>
> Fix it by introducing the right header.
>
> Signed-off-by: Jason Xing <kerneljasonxing@gmail.com>
> ---
>  tools/testing/selftests/bpf/prog_tests/sockopt_sk.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/sockopt_sk.c b/tools/testing/selftests/bpf/prog_tests/sockopt_sk.c
> index ba6b3ec1156a..e0a9785ffcdc 100644
> --- a/tools/testing/selftests/bpf/prog_tests/sockopt_sk.c
> +++ b/tools/testing/selftests/bpf/prog_tests/sockopt_sk.c
> @@ -2,7 +2,7 @@
>  #include <test_progs.h>
>  #include "cgroup_helpers.h"
>  
> -#include <netinet/tcp.h>
> +#include <uapi/linux/tcp.h>

Should it be <linux/tcp.h> instead ? Directly including uapi header file
in application seems weird.
>  #include <linux/netlink.h>
>  #include "sockopt_sk.skel.h"
>  


