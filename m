Return-Path: <linux-kselftest+bounces-365-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A25227F25EF
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 Nov 2023 07:49:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D31E41C214F6
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 Nov 2023 06:49:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3076171AB;
	Tue, 21 Nov 2023 06:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="qgqcvbKw"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B2D8BB
	for <linux-kselftest@vger.kernel.org>; Mon, 20 Nov 2023 22:49:48 -0800 (PST)
Message-ID: <11bf3c0f-f78b-4dd3-97d3-c39b5b2ae7bd@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1700549386;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9BS9UBYsSndFAg/kFykIgLfKwkfc0tziM6o2ZmXP0yc=;
	b=qgqcvbKwWn9QXxkyQuD1VkO3P4AyGBcuxrKWDxsoKY9R187ET2HSTLU1/mpggl0ZFcCOSo
	J4HWCyhfEAj0QBgrQ9Otqfwl3Odl6dBAXBJfOD8Jn+f/+BDybL5NQDEZn7c5MB2AuPHU+4
	MZlYVZ0uuDvxw/O3hNk3Sj1YR8igVLc=
Date: Mon, 20 Nov 2023 22:49:39 -0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v3 0/4] selftests/bpf: Update multiple prog_tests
 to use ASSERT_ macros
Content-Language: en-GB
To: Yuran Pereira <yuran.pereira@hotmail.com>, bpf@vger.kernel.org
Cc: andrii@kernel.org, ast@kernel.org, haoluo@google.com,
 john.fastabend@gmail.com, jolsa@kernel.org, kpsingh@kernel.org,
 linux-kernel-mentees@lists.linuxfoundation.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 martin.lau@linux.dev, mykolal@fb.com, sdf@google.com, shuah@kernel.org,
 song@kernel.org
References: <GV1PR10MB6563BEFEA4269E1DDBC264B1E8BBA@GV1PR10MB6563.EURPRD10.PROD.OUTLOOK.COM>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <GV1PR10MB6563BEFEA4269E1DDBC264B1E8BBA@GV1PR10MB6563.EURPRD10.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 11/20/23 7:03 PM, Yuran Pereira wrote:
> Multiple files/programs in `tools/testing/selftests/bpf/prog_tests/` still
> heavily use the `CHECK` macro, even when better `ASSERT_` alternatives are
> available.
>
> As it was already pointed out by Yonghong Song [1] in the bpf selftests the use
> of the ASSERT_* series of macros is preferred over the CHECK macro.
>
> This patchset replaces the usage of `CHECK(` macros to the equivalent `ASSERT_`
> family of macros in the following prog_tests:
> - bind_perm.c
> - bpf_obj_id.c
> - bpf_tcp_ca.c
> - vmlinux.c
>
> [1] https://lore.kernel.org/lkml/0a142924-633c-44e6-9a92-2dc019656bf2@linux.dev
>
> Changes in v3:
> - Addressed the following points mentioned by Yonghong Song
> - Improved `bpf_map_lookup_elem` assertion in bpf_tcp_ca.
> - Replaced assertion introduced in v2 with one that checks `thread_ret`
>    instead of `pthread_join`. This ensures that `server`'s return value
>    (thread_ret) is the one being checked, as oposed to `pthread_join`'s
>    return value, since the latter one is less likely to fail.
>
> Changes in v2:
> - Fixed pthread_join assertion that broke the previous test
>
> Previous version:
> v2 - https://lore.kernel.org/lkml/GV1PR10MB6563AECF8E94798A1E5B36A4E8B6A@GV1PR10MB6563.EURPRD10.PROD.OUTLOOK.COM
> v1 - https://lore.kernel.org/lkml/GV1PR10MB6563FCFF1C5DEBE84FEA985FE8B0A@GV1PR10MB6563.EURPRD10.PROD.OUTLOOK.COM
>
> Yuran Pereira (4):
>    Replaces the usage of CHECK calls for ASSERTs in bpf_tcp_ca
>    Replaces the usage of CHECK calls for ASSERTs in bind_perm
>    Replaces the usage of CHECK calls for ASSERTs in bpf_obj_id
>    selftests/bpf: Replaces the usage of CHECK calls for ASSERTs in
>      vmlinux
>
>   .../selftests/bpf/prog_tests/bind_perm.c      |   6 +-
>   .../selftests/bpf/prog_tests/bpf_obj_id.c     | 204 +++++++-----------
>   .../selftests/bpf/prog_tests/bpf_tcp_ca.c     |  48 ++---
>   .../selftests/bpf/prog_tests/vmlinux.c        |  16 +-
>   4 files changed, 105 insertions(+), 169 deletions(-)
>
Ack for the whole series:
Acked-by: Yonghong Song <yonghong.song@linux.dev>

Yuran, next time when you submit patches, you can carry 'Acked-by' tag
from previous revision if there are no significant changes. This will
reduce some of reviewers and maintainers' work.


