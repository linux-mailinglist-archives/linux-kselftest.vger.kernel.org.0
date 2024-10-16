Return-Path: <linux-kselftest+bounces-19826-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AD2109A043A
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Oct 2024 10:28:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 143E0B228CD
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Oct 2024 08:28:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ACA11D90A2;
	Wed, 16 Oct 2024 08:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="Z1RhusA6"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F255B1D8DFE
	for <linux-kselftest@vger.kernel.org>; Wed, 16 Oct 2024 08:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729067322; cv=none; b=cEBSGeVi0vtkQhkpSR/he+wLBAxFO5C6mX8838NPkX3XnHm2lcVzSrfXo99yGaZkJslw4ATvNICosPnSmgq8NMm4syK01oT3n1yj4qVUlwSJ1rROulWf+14FIYSCmVRFN7NxbsQioWCCrVS32TTrvuJky/0BDQTjhjvoldD2gR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729067322; c=relaxed/simple;
	bh=iIIpJpeakjeQ6MiJ397fq0GNk4HO6z5XH6bDjYColuo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lM2iZ8K+zTAwdeDhFQPfgvrUu68wz9QZzb68rcjmLsI9Z+wLhERWXLSgth/NrDVzBHzkjBUUgwCjN36ph7urZSwItFQjev8iLrCNAM7myCVzcnYTSPVOBZeV3fWpivW5PCtk6Nd2YVhhKleXQjIzLlB9+ZBnOqbm0q8vzrF9QzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=Z1RhusA6; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2e2b549799eso4539687a91.3
        for <linux-kselftest@vger.kernel.org>; Wed, 16 Oct 2024 01:28:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1729067319; x=1729672119; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oK3r7JDohs2krUXNPNKZVE3HoJ9iGwZ4bW7axF6Bd2E=;
        b=Z1RhusA6yMd4Cf/CNCgHL8c1rwUhirYGP8mylTXd6V4w4JVbKLdbD4sIm1ZzYijL/L
         9AZ39ZpST2dzhPwczO/bvIJYMnmp0sdg1gLUWcspKXFRDiy3g/dPjageFg9332ndOJXT
         q4UT9Ln7Km2ggwvSbNwZ6DgN/W/Sb15RjT0JwpTA8q35sbUFxv9EetgT0noAjrPz72qx
         zL9xziL1rAlwWk7VJjn+KcqU9FyMnxW3dp9QELs8JwczYtGiC+J6e17Gvblufw9Pojm6
         vI4ZqbGRSjSmOUp1rkmbHHgKpnOkhHscjjldo55SEZ5HOFzZ9welxBbI+ThJzJriyVvg
         3H8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729067319; x=1729672119;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=oK3r7JDohs2krUXNPNKZVE3HoJ9iGwZ4bW7axF6Bd2E=;
        b=il+P+q3LjJUtnz1rQbr2QXfeyHrKE7MBBcr4tr6FGs8e24jd9DVmaO+8H5RqPnlV+y
         0sZtNa1WRc7/xWm6XzHb/8BA4NkuKlYIVMpDVnHYB44cXvoyOvnhPUau6NlPnBfMn7k2
         552LSLMIu8hQhKDUm48ZA9bXLeZwhtTMnooWp7i7h/PrPLRO0NYWBR9OL7/fMQLrYa8d
         P4G0iuANQEzbd6bL6fKTLJi2hNXD1i3gQdvRaL46HYgRzi7KZGsXbNNVUcrHilZq+T9L
         2KBUagIhEvm3f2WVC8AUU+AwXMJEOdiDqo9MllBJv4hFHRIENbzu3uJEZnBC4k/qLzJN
         +p6Q==
X-Forwarded-Encrypted: i=1; AJvYcCUZQl4CXdXkLQ3zP8rHy+W/qFXaV0b8hBzEI8GEX0oVncEFBKMTsxodETKy10MFEejoGaXNDHeEy0j7+iXXxas=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCVrgWQ647zFQUf8JA2MMeRfneOqQayaOia57hsO/o4ogcJYVb
	+v+oj6JSPtzXR4w8hv6pKTgoGDfUruuu/ChWTztHE1IENjCTG+oUP1JWpOmpHq8=
X-Google-Smtp-Source: AGHT+IGEYNpbSXS9A+lWMLTCRUXwyBdU2dEOqJc7naNeVS68q5VEhcTwcma4YJ+YWUY64K/Zzj3UfQ==
X-Received: by 2002:a17:90a:b398:b0:2e2:eac6:6c05 with SMTP id 98e67ed59e1d1-2e3151b4176mr18983487a91.4.1729067318995;
        Wed, 16 Oct 2024 01:28:38 -0700 (PDT)
Received: from [10.68.122.241] ([203.208.167.149])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e392ed3b28sm3516764a91.19.2024.10.16.01.28.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Oct 2024 01:28:38 -0700 (PDT)
Message-ID: <5969d1ca-688b-4a27-9e39-dc9f89381d40@bytedance.com>
Date: Wed, 16 Oct 2024 16:28:27 +0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [External] Re: [PATCH bpf-next v2 2/2] bpf, selftests: Add test
 case for cgroup skb to get net_cls classid helpers
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: daniel@iogearbox.net, john.fastabend@gmail.com, ast@kernel.org,
 andrii@kernel.org, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, kpsingh@kernel.org, sdf@fomichev.me,
 haoluo@google.com, jolsa@kernel.org, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, mykolal@fb.com,
 shuah@kernel.org, geliang@kernel.org, laoar.shao@gmail.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
 linux-kselftest@vger.kernel.org, yangzhenze@bytedance.com,
 wangdongdong.6@bytedance.com
References: <20240918074516.5697-1-zhoufeng.zf@bytedance.com>
 <20240918074516.5697-3-zhoufeng.zf@bytedance.com>
 <075e314c-3aa5-4f7b-81f7-3bc0e055334a@linux.dev>
From: Feng Zhou <zhoufeng.zf@bytedance.com>
In-Reply-To: <075e314c-3aa5-4f7b-81f7-3bc0e055334a@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

在 2024/10/1 09:58, Martin KaFai Lau 写道:
> On 9/18/24 12:45 AM, Feng zhou wrote:
>> From: Feng Zhou <zhoufeng.zf@bytedance.com>
>>
>> This patch adds a test for cgroup skb to get classid.
>>
>> Signed-off-by: Feng Zhou <zhoufeng.zf@bytedance.com>
>> ---
>>   .../bpf/prog_tests/cg_skb_get_classid.c       | 87 +++++++++++++++++++
>>   .../selftests/bpf/progs/cg_skb_get_classid.c  | 19 ++++
>>   2 files changed, 106 insertions(+)
>>   create mode 100644 
>> tools/testing/selftests/bpf/prog_tests/cg_skb_get_classid.c
>>   create mode 100644 
>> tools/testing/selftests/bpf/progs/cg_skb_get_classid.c
>>
>> diff --git 
>> a/tools/testing/selftests/bpf/prog_tests/cg_skb_get_classid.c 
>> b/tools/testing/selftests/bpf/prog_tests/cg_skb_get_classid.c
>> new file mode 100644
>> index 000000000000..13a5943c387d
>> --- /dev/null
>> +++ b/tools/testing/selftests/bpf/prog_tests/cg_skb_get_classid.c
>> @@ -0,0 +1,87 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +
>> +/*
>> + * Copyright 2024 Bytedance.
>> + */
>> +
>> +#include <test_progs.h>
>> +
>> +#include "cg_skb_get_classid.skel.h"
>> +
>> +#include "cgroup_helpers.h"
>> +#include "network_helpers.h"
>> +
>> +static int run_test(int cgroup_fd, int server_fd)
>> +{
>> +    struct cg_skb_get_classid *skel;
>> +    int fd, err = 0;
>> +
>> +    skel = cg_skb_get_classid__open_and_load();
>> +    if (!ASSERT_OK_PTR(skel, "skel_open"))
>> +        return -1;
>> +
>> +    skel->links.cg_skb_classid =
>> +        bpf_program__attach_cgroup(skel->progs.cg_skb_classid,
>> +                       cgroup_fd);
>> +    if (!ASSERT_OK_PTR(skel->links.cg_skb_classid, "prog_attach")) {
>> +        err = -1;
>> +        goto out;
>> +    }
>> +
>> +    if (!ASSERT_OK(join_classid(), "join_classid")) {
>> +        err = -1;
>> +        goto out;
>> +    }
>> +
>> +    errno = 0;
>> +    fd = connect_to_fd_opts(server_fd, NULL);
>> +    if (fd >= 0) {
>> +        if (skel->bss->classid != getpid()) {
>> +            log_err("Get unexpected classid");
>> +            err = -1;
>> +        }
>> +
>> +        close(fd);
>> +    } else {
>> +        log_err("Unexpected errno from connect to server");
>> +        err = -1;
>> +    }
>> +out:
>> +    cg_skb_get_classid__destroy(skel);
>> +    return err;
>> +}
>> +
>> +void test_cg_skb_get_classid(void)
>> +{
>> +    struct network_helper_opts opts = {};
>> +    int server_fd, client_fd, cgroup_fd;
>> +    static const int port = 60120;
> 
> Running a test with a specific port without netns could fail when 
> test_progs is run in parallel (-j). e.g. cgroup_v1v2 is using the same 
> port.
> 
>> +
>> +    /* Step 1: Check base connectivity works without any BPF. */
>> +    server_fd = start_server(AF_INET, SOCK_STREAM, NULL, port, 0);
>> +    if (!ASSERT_GE(server_fd, 0, "server_fd"))
>> +        return;
>> +    client_fd = connect_to_fd_opts(server_fd, &opts);
>> +    if (!ASSERT_GE(client_fd, 0, "client_fd")) {
>> +        close(server_fd);
>> +        return;
>> +    }
>> +    close(client_fd);
>> +    close(server_fd);
> 
> imo, this connection pre-test is unnecessary. I would remove it.
> 
>> +
>> +    /* Step 2: Check BPF prog attached to cgroups. */
>> +    cgroup_fd = test__join_cgroup("/cg_skb_get_classid");
>> +    if (!ASSERT_GE(cgroup_fd, 0, "cgroup_fd"))
>> +        return;
>> +    server_fd = start_server(AF_INET, SOCK_STREAM, NULL, port, 0);
>> +    if (!ASSERT_GE(server_fd, 0, "server_fd")) {
>> +        close(cgroup_fd);
>> +        return;
>> +    }
>> +    setup_classid_environment();
>> +    set_classid();
>> +    ASSERT_OK(run_test(cgroup_fd, server_fd), "cg_skb_get_classid");
> 
> Please run this test under a netns and without specifying a particular 
> port. connect_to_fd_opts will figure out the port used in server_fd.
> 
> Patch 1 lgtm.
> 
> Please add a few words to the cover letter also.
> 
> pw-bot: cr

Sorry for taking so long to reply.

Will do, thanks.



