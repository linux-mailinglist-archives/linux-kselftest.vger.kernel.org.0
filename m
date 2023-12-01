Return-Path: <linux-kselftest+bounces-951-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19353800701
	for <lists+linux-kselftest@lfdr.de>; Fri,  1 Dec 2023 10:30:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C85CB28173A
	for <lists+linux-kselftest@lfdr.de>; Fri,  1 Dec 2023 09:30:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A2591D523;
	Fri,  1 Dec 2023 09:30:03 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 996944C0E;
	Fri,  1 Dec 2023 01:29:34 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 924E11042;
	Fri,  1 Dec 2023 01:30:14 -0800 (PST)
Received: from [10.57.73.130] (unknown [10.57.73.130])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BC3E83F5A1;
	Fri,  1 Dec 2023 01:29:24 -0800 (PST)
Message-ID: <b3c882d2-0135-430c-8179-784f78be0902@arm.com>
Date: Fri, 1 Dec 2023 09:29:23 +0000
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 5/5] selftests/mm: add UFFDIO_MOVE ioctl test
Content-Language: en-GB
To: Suren Baghdasaryan <surenb@google.com>, akpm@linux-foundation.org
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, shuah@kernel.org,
 aarcange@redhat.com, lokeshgidra@google.com, peterx@redhat.com,
 david@redhat.com, hughd@google.com, mhocko@suse.com,
 axelrasmussen@google.com, rppt@kernel.org, willy@infradead.org,
 Liam.Howlett@oracle.com, jannh@google.com, zhangpeng362@huawei.com,
 bgeffon@google.com, kaleshsingh@google.com, ngeoffray@google.com,
 jdduke@google.com, linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 kernel-team@android.com
References: <20231121171643.3719880-1-surenb@google.com>
 <20231121171643.3719880-6-surenb@google.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <20231121171643.3719880-6-surenb@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 21/11/2023 17:16, Suren Baghdasaryan wrote:
> Add tests for new UFFDIO_MOVE ioctl which uses uffd to move source
> into destination buffer while checking the contents of both after
> the move. After the operation the content of the destination buffer
> should match the original source buffer's content while the source
> buffer should be zeroed. Separate tests are designed for PMD aligned and
> unaligned cases because they utilize different code paths in the kernel.
> 
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> ---
>  tools/testing/selftests/mm/uffd-common.c     |  24 +++
>  tools/testing/selftests/mm/uffd-common.h     |   1 +
>  tools/testing/selftests/mm/uffd-unit-tests.c | 189 +++++++++++++++++++
>  3 files changed, 214 insertions(+)
> 
> diff --git a/tools/testing/selftests/mm/uffd-common.c b/tools/testing/selftests/mm/uffd-common.c
> index fb3bbc77fd00..b0ac0ec2356d 100644
> --- a/tools/testing/selftests/mm/uffd-common.c
> +++ b/tools/testing/selftests/mm/uffd-common.c
> @@ -631,6 +631,30 @@ int copy_page(int ufd, unsigned long offset, bool wp)
>  	return __copy_page(ufd, offset, false, wp);
>  }
>  
> +int move_page(int ufd, unsigned long offset, unsigned long len)
> +{
> +	struct uffdio_move uffdio_move;
> +
> +	if (offset + len > nr_pages * page_size)
> +		err("unexpected offset %lu and length %lu\n", offset, len);
> +	uffdio_move.dst = (unsigned long) area_dst + offset;
> +	uffdio_move.src = (unsigned long) area_src + offset;
> +	uffdio_move.len = len;
> +	uffdio_move.mode = UFFDIO_MOVE_MODE_ALLOW_SRC_HOLES;
> +	uffdio_move.move = 0;
> +	if (ioctl(ufd, UFFDIO_MOVE, &uffdio_move)) {
> +		/* real retval in uffdio_move.move */
> +		if (uffdio_move.move != -EEXIST)
> +			err("UFFDIO_MOVE error: %"PRId64,
> +			    (int64_t)uffdio_move.move);

Hi Suren,

FYI this error is triggering in mm-unstable (715b67adf4c8):

Testing move-pmd on anon... ERROR: UFFDIO_MOVE error: -16 (errno=16,
@uffd-common.c:648)

I'm running in a VM on Apple M2 (arm64). I haven't debugged any further, but
happy to go deeper if you can direct.

Thanks,
Ryan


> +		wake_range(ufd, uffdio_move.dst, len);
> +	} else if (uffdio_move.move != len) {
> +		err("UFFDIO_MOVE error: %"PRId64, (int64_t)uffdio_move.move);
> +	} else
> +		return 1;
> +	return 0;
> +}


