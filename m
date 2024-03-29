Return-Path: <linux-kselftest+bounces-6896-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A60F28924A7
	for <lists+linux-kselftest@lfdr.de>; Fri, 29 Mar 2024 20:54:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 30288284F9D
	for <lists+linux-kselftest@lfdr.de>; Fri, 29 Mar 2024 19:54:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 916D713A879;
	Fri, 29 Mar 2024 19:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="GKkycvFk"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59E8F12FB12;
	Fri, 29 Mar 2024 19:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711742046; cv=none; b=ouE3rxCtJwhYADvaQnL9nlupheQcLw3+NdASrliPDQTsPbYAZh03TwttJnaEuGKCs+ylQgVLeNzleQbL6BOyvd6XwcVFBr4ilxwjUUjeb6KnmBoNFPSjdYOYOU9W8J3IaCxXdX83HKXQOvydbM39sgHd1VEX4Tk/3p3UC/NXvbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711742046; c=relaxed/simple;
	bh=7FIgZdhSuFmBFq7x61DjTJQ6bzsgrfBW8fIPAWIE+MU=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=n6PikM7JyVbcz/ILB1pCaYVakWY7coAO0Q1F8epSZlNYh3fiZU7PcQUw/opb/qrJKXSpns6vPxsdE3opxDLzMku8PdSH01/QlSC9v+Qz/ZUbkHQD8vkPOMWPjfC3id0ysxdyqZ1+UJRYSMynWFOebhGytOV1nHSM/Ipvl4V5CZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=GKkycvFk; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1711742042;
	bh=7FIgZdhSuFmBFq7x61DjTJQ6bzsgrfBW8fIPAWIE+MU=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=GKkycvFkCWp+5HTjbw8G0xXWaauEjnFnSHlwt8uaT6BT4Bg/7HmDKPatTDArsxdRm
	 G+Lcy90jN5PMAcqWlHcl/GVZpMc1HPY/ckbwi0RXmo5Qjp0g3WKVHfyOd5TX79bwWy
	 CfRH41Gu6cQjnLTEUjGg9EcODbPekwDb+vR3jzVzkx7zrV0z2AzNMnat27He8ow+dV
	 UGZ1nAyaT1MDSBBJuGm+sMND3htxnkklKcJUZbF0+3ECEj/PIbmBFV+XfUKNE2vMlP
	 PRmK74mnrrbVPG6NMDXqSyk5PY/vQDEyX9XWJ5pRTK1+y9pgiGeO/N5kkwJyYRUBFy
	 Ba0POAplPiXKA==
Received: from [100.113.15.66] (ec2-34-240-57-77.eu-west-1.compute.amazonaws.com [34.240.57.77])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: usama.anjum)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 94ED33781FCE;
	Fri, 29 Mar 2024 19:53:50 +0000 (UTC)
Message-ID: <c54bae70-3655-4188-aad7-358bb7897c3c@collabora.com>
Date: Sat, 30 Mar 2024 00:54:20 +0500
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>,
 linux-kselftest@vger.kernel.org, kernel-team@android.com,
 Lokesh Gidra <lokeshgidra@google.com>, bpf@vger.kernel.org,
 netdev@vger.kernel.org, linux-mm@kvack.org, llvm@lists.linux.dev
Subject: Re: [PATCH v3] selftests/mm: Fix ARM related issue with fork after
 pthread_create
To: Edward Liaw <edliaw@google.com>, linux-kernel@vger.kernel.org,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 John Fastabend <john.fastabend@gmail.com>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
 KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>,
 Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Andrew Morton <akpm@linux-foundation.org>, Shuah Khan <shuah@kernel.org>,
 Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling
 <morbo@google.com>, Justin Stitt <justinstitt@google.com>,
 Jann Horn <jannh@google.com>
References: <20240325194100.775052-1-edliaw@google.com>
Content-Language: en-US
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <20240325194100.775052-1-edliaw@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/26/24 12:40 AM, Edward Liaw wrote:
> Following issue was observed while running the uffd-unit-tests selftest
> on ARM devices. On x86_64 no issues were detected:
> 
> pthread_create followed by fork caused deadlock in certain cases
> wherein fork required some work to be completed by the created thread.
> Used synchronization to ensure that created thread's start function has
> started before invoking fork.
> 
> Signed-off-by: Lokesh Gidra <lokeshgidra@google.com>
> [edliaw: Refactored to use atomic_bool]
> Signed-off-by: Edward Liaw <edliaw@google.com>
Reviewed-by: Muhammad Usama Anjum <usama.anjum@collabora.com>

> ---
> 
> v2: restored accidentally removed uffd_test_case_ops when merging
> v3: fixed commit subject to use selftests/mm prefix
> 
>  tools/testing/selftests/mm/uffd-common.c     |  3 +++
>  tools/testing/selftests/mm/uffd-common.h     |  2 ++
>  tools/testing/selftests/mm/uffd-unit-tests.c | 10 ++++++++++
>  3 files changed, 15 insertions(+)
> 
> diff --git a/tools/testing/selftests/mm/uffd-common.c b/tools/testing/selftests/mm/uffd-common.c
> index b0ac0ec2356d..7ad6ba660c7d 100644
> --- a/tools/testing/selftests/mm/uffd-common.c
> +++ b/tools/testing/selftests/mm/uffd-common.c
> @@ -18,6 +18,7 @@ bool test_uffdio_wp = true;
>  unsigned long long *count_verify;
>  uffd_test_ops_t *uffd_test_ops;
>  uffd_test_case_ops_t *uffd_test_case_ops;
> +atomic_bool ready_for_fork;
> 
>  static int uffd_mem_fd_create(off_t mem_size, bool hugetlb)
>  {
> @@ -518,6 +519,8 @@ void *uffd_poll_thread(void *arg)
>  	pollfd[1].fd = pipefd[cpu*2];
>  	pollfd[1].events = POLLIN;
> 
> +	ready_for_fork = true;
> +
>  	for (;;) {
>  		ret = poll(pollfd, 2, -1);
>  		if (ret <= 0) {
> diff --git a/tools/testing/selftests/mm/uffd-common.h b/tools/testing/selftests/mm/uffd-common.h
> index cb055282c89c..cc5629c3d2aa 100644
> --- a/tools/testing/selftests/mm/uffd-common.h
> +++ b/tools/testing/selftests/mm/uffd-common.h
> @@ -32,6 +32,7 @@
>  #include <inttypes.h>
>  #include <stdint.h>
>  #include <sys/random.h>
> +#include <stdatomic.h>
> 
>  #include "../kselftest.h"
>  #include "vm_util.h"
> @@ -103,6 +104,7 @@ extern bool map_shared;
>  extern bool test_uffdio_wp;
>  extern unsigned long long *count_verify;
>  extern volatile bool test_uffdio_copy_eexist;
> +extern atomic_bool ready_for_fork;
> 
>  extern uffd_test_ops_t anon_uffd_test_ops;
>  extern uffd_test_ops_t shmem_uffd_test_ops;
> diff --git a/tools/testing/selftests/mm/uffd-unit-tests.c b/tools/testing/selftests/mm/uffd-unit-tests.c
> index 2b9f8cc52639..4a48dc617c6b 100644
> --- a/tools/testing/selftests/mm/uffd-unit-tests.c
> +++ b/tools/testing/selftests/mm/uffd-unit-tests.c
> @@ -775,6 +775,8 @@ static void uffd_sigbus_test_common(bool wp)
>  	char c;
>  	struct uffd_args args = { 0 };
> 
> +	ready_for_fork = false;
> +
>  	fcntl(uffd, F_SETFL, uffd_flags | O_NONBLOCK);
> 
>  	if (uffd_register(uffd, area_dst, nr_pages * page_size,
> @@ -790,6 +792,9 @@ static void uffd_sigbus_test_common(bool wp)
>  	if (pthread_create(&uffd_mon, NULL, uffd_poll_thread, &args))
>  		err("uffd_poll_thread create");
> 
> +	while (!ready_for_fork)
> +		; /* Wait for the poll_thread to start executing before forking */
> +
>  	pid = fork();
>  	if (pid < 0)
>  		err("fork");
> @@ -829,6 +834,8 @@ static void uffd_events_test_common(bool wp)
>  	char c;
>  	struct uffd_args args = { 0 };
> 
> +	ready_for_fork = false;
> +
>  	fcntl(uffd, F_SETFL, uffd_flags | O_NONBLOCK);
>  	if (uffd_register(uffd, area_dst, nr_pages * page_size,
>  			  true, wp, false))
> @@ -838,6 +845,9 @@ static void uffd_events_test_common(bool wp)
>  	if (pthread_create(&uffd_mon, NULL, uffd_poll_thread, &args))
>  		err("uffd_poll_thread create");
> 
> +	while (!ready_for_fork)
> +		; /* Wait for the poll_thread to start executing before forking */
> +
>  	pid = fork();
>  	if (pid < 0)
>  		err("fork");
> --
> 2.44.0.396.g6e790dbe36-goog
> 
> 

-- 
BR,
Muhammad Usama Anjum

