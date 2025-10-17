Return-Path: <linux-kselftest+bounces-43447-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EC8DBEBFE5
	for <lists+linux-kselftest@lfdr.de>; Sat, 18 Oct 2025 01:26:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 9B8F2353A63
	for <lists+linux-kselftest@lfdr.de>; Fri, 17 Oct 2025 23:26:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A71E275105;
	Fri, 17 Oct 2025 23:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="v8XrcFLf"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 112051E32D3
	for <linux-kselftest@vger.kernel.org>; Fri, 17 Oct 2025 23:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760743613; cv=none; b=cWInPYMBqSF17/Wn6x8mc0NqHa2CyHJUCZ1rCLEaxowo6kwSf12WwcjpwGroIbu1Ysj9r+WupP58JuX/ViS0FO8CP5nR8g/Kv0C7/eSW8Pro8/fgUAqLGeFy9aCMcRYZKCjnGGgm2T7IRlUOOLmknAz9G8uxonjxKxIVfFXVOdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760743613; c=relaxed/simple;
	bh=9gqUxbSHcGE0nLXNi/sjXzi8nXQVY/mBieoF65QdSzg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TqFPHyjVGmALh4YVs+vKp45FbCLjfpCzmowOJx+y9ZdyV3xrTk0zoPVZRF5Khagz57qztskWJ+vgmZxzff9KOqyaZ88GrMmJASk/yAYWT70CkM6cv2HIZK9d6KHbefHGOdyIC4T1NhPwMshBohuF4KCuDDc2LgQCTIK5WA0xfF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=v8XrcFLf; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <a49ebaad-cc79-4ade-aa4a-ad37fcf81dee@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1760743605;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=H2aonym/zh/ZnIWdTwYFx2WcEyaxpP4oBGysUwcVhRw=;
	b=v8XrcFLfiMN3zwc6Y81v62BEUZVImYgn5nj77fGkfh7XVFL1IzClBcWXQpbE3quuOB6Rzj
	ZJBi8QplSEIiS6YLvFdXcfCTXEazaO0ZNFyaFWVaIyJ9fCSruA0npw3fCRG78XdAg3quD4
	hmgn48qMEqgCVGdxEIiomvfW1Fbyi2w=
Date: Fri, 17 Oct 2025 16:26:01 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next 2/5] selftests/bpf: add tc helpers
To: =?UTF-8?Q?Alexis_Lothor=C3=A9_=28eBPF_Foundation=29?=
 <alexis.lothore@bootlin.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>,
 ebpf@linuxfoundation.org, Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Bastien Curutchet <bastien.curutchet@bootlin.com>, bpf@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20251017-tc_tunnel-v1-0-2d86808d86b2@bootlin.com>
 <20251017-tc_tunnel-v1-2-2d86808d86b2@bootlin.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20251017-tc_tunnel-v1-2-2d86808d86b2@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 10/17/25 7:29 AM, Alexis Lothoré (eBPF Foundation) wrote:
> diff --git a/tools/testing/selftests/bpf/tc_helpers.c b/tools/testing/selftests/bpf/tc_helpers.c
> new file mode 100644
> index 0000000000000000000000000000000000000000..d668e10e3ebad8f8e04862f5c2b3ccd487fe8fa6
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/tc_helpers.c
> @@ -0,0 +1,87 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +#define _GNU_SOURCE
> +
> +#include <net/if.h>
> +#include "tc_helpers.h"
> +#include "test_progs.h"
> +
> +static int attach_tc_prog(int ifindex, int igr_fd, int egr_fd)

This one looks good but change it to "int tc_prog_attach(const char 
*dev, int ingress_fd, int egress_fd)". Remove static. Take "const char 
*dev" as the arg. Add it to network_helpers.[ch] instead of creating a 
new source file.

> +{
> +	DECLARE_LIBBPF_OPTS(bpf_tc_hook, hook, .ifindex = ifindex,
> +			    .attach_point = BPF_TC_INGRESS | BPF_TC_EGRESS);
> +	DECLARE_LIBBPF_OPTS(bpf_tc_opts, opts1, .handle = 1,
> +			    .priority = 1, .prog_fd = igr_fd);
> +	DECLARE_LIBBPF_OPTS(bpf_tc_opts, opts2, .handle = 1,
> +			    .priority = 1, .prog_fd = egr_fd);
> +	int ret;
> +
> +	ret = bpf_tc_hook_create(&hook);
> +	if (!ASSERT_OK(ret, "create tc hook"))
> +		return ret;
> +
> +	if (igr_fd >= 0) {
> +		hook.attach_point = BPF_TC_INGRESS;
> +		ret = bpf_tc_attach(&hook, &opts1);
> +		if (!ASSERT_OK(ret, "bpf_tc_attach")) {
> +			bpf_tc_hook_destroy(&hook);
> +			return ret;
> +		}
> +	}
> +
> +	if (egr_fd >= 0) {
> +		hook.attach_point = BPF_TC_EGRESS;
> +		ret = bpf_tc_attach(&hook, &opts2);
> +		if (!ASSERT_OK(ret, "bpf_tc_attach")) {
> +			bpf_tc_hook_destroy(&hook);
> +			return ret;
> +		}
> +	}
> +
> +	return 0;
> +}
> +
> +int generic_attach(const char *dev, int igr_fd, int egr_fd)
> +{
> +	int ifindex;
> +
> +	if (!ASSERT_OK_FD(igr_fd, "check ingress fd"))
> +		return -1;
> +	if (!ASSERT_OK_FD(egr_fd, "check egress fd"))
> +		return -1;
> +
> +	ifindex = if_nametoindex(dev);
> +	if (!ASSERT_NEQ(ifindex, 0, "get ifindex"))
> +		return -1;
> +
> +	return attach_tc_prog(ifindex, igr_fd, egr_fd);
> +}
> +
> +int generic_attach_igr(const char *dev, int igr_fd)
> +{
> +	int ifindex;
> +
> +	if (!ASSERT_OK_FD(igr_fd, "check ingress fd"))
> +		return -1;
> +
> +	ifindex = if_nametoindex(dev);
> +	if (!ASSERT_NEQ(ifindex, 0, "get ifindex"))
> +		return -1;
> +
> +	return attach_tc_prog(ifindex, igr_fd, -1);
> +}
> +
> +int generic_attach_egr(const char *dev, int egr_fd)
> +{
> +	int ifindex;
> +
> +	if (!ASSERT_OK_FD(egr_fd, "check egress fd"))
> +		return -1;
> +
> +	ifindex = if_nametoindex(dev);
> +	if (!ASSERT_NEQ(ifindex, 0, "get ifindex"))
> +		return -1;
> +
> +	return attach_tc_prog(ifindex, -1, egr_fd);
> +}

These three generic_attach_* is a bit overkill for network_helpers.c.

Change test_tunnel.c to directly use tc_prog_attach().

> +
> +
> diff --git a/tools/testing/selftests/bpf/tc_helpers.h b/tools/testing/selftests/bpf/tc_helpers.h
> new file mode 100644
> index 0000000000000000000000000000000000000000..d31abe33f9d80dadd8f829bcf9a68cfd744c3b99
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/tc_helpers.h

This new file is not needed also. Use the network_helpers.h.


