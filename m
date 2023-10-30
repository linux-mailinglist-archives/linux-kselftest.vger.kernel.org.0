Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16A397DC0B1
	for <lists+linux-kselftest@lfdr.de>; Mon, 30 Oct 2023 20:39:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229788AbjJ3TjW (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 30 Oct 2023 15:39:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjJ3TjW (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 30 Oct 2023 15:39:22 -0400
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A502C2;
        Mon, 30 Oct 2023 12:39:18 -0700 (PDT)
Received: by mail-yb1-xb32.google.com with SMTP id 3f1490d57ef6-d81d09d883dso4177807276.0;
        Mon, 30 Oct 2023 12:39:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698694757; x=1699299557; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jX7iUzZFcTBfQ+kYYju+3Vitfff4IDCKl0n/5TrIXLk=;
        b=h+nlIO+TV+s28msuxmIaVOZMPLUodZMmKAf6L+aQxdxclukzu0WRDA6D5EI4BhTFGo
         ILYBQzm5GRGo7/u0y0gsZUKSOqMj1jvm1/5UyZvEFaDGTEgBErbCMiiV9OQhDcX6GEFu
         mGebER9+3ulPSSFgqk915q4hxipfwh/qFHVDlJkq0Emvgzk+/SfF3+T61+E8gscLT77N
         MvCfT2mVG6Z6NMAGIaJZew2QSuKSIqs8oSDDtqZidglXx/cBkY/4COZ7dJAxrrnPMWPC
         0vRFjhkpj3aeLqAORmrVv0qBKc1ORUdNHUOFVaJIdgF92vJF0AOZ1PlnrkqUhPRg4FIP
         30ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698694757; x=1699299557;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jX7iUzZFcTBfQ+kYYju+3Vitfff4IDCKl0n/5TrIXLk=;
        b=J0mBC4K/CVzFv2nSmb6roa0aDLDtI3ZwNq8wMWwxY7XY/wyIypVf/P+UG+hd8mAx/T
         Qb9lI/I52KqWftWRRHFnN5utbBuHaoRN5FYZmZdhmBN+nJ32H6tVDl569VKmqEqIeReB
         kzPTFUnlncXeQ/FCfTk9BCE5bzuMfz7tC6yRwdjkgu7dqWY5YUtOp/mz+kO2Iyqn4Zxj
         M+JN48waoX2iRyl5+yR3bKBRa8DF36hY66kBit2PrbsdZOQu45OXf7KHudSstNKmOhLR
         XS0lTz8pYksUfnEZ7QTWM8f+RaoYaoLhDieQXQ8AOVBL5Le0jDJsGkiMMrGH7tbv/VN+
         g2DQ==
X-Gm-Message-State: AOJu0YxLdgDt1hAG5s7iGX4UVuh3Rx/VnbG4PfFxCsgeBPYrKRnLpUtr
        IG1gPLIJh7dPfw9lCzHC3XM=
X-Google-Smtp-Source: AGHT+IH4ij93XR8icYrangBvkwE5L8lhwK9+GXb1aipCMJo1v5brEu3650ZmOxGtu1dhENKQ8vuOXw==
X-Received: by 2002:a05:6902:54f:b0:da0:6a55:b4d5 with SMTP id z15-20020a056902054f00b00da06a55b4d5mr8492448ybs.46.1698694757335;
        Mon, 30 Oct 2023 12:39:17 -0700 (PDT)
Received: from ?IPV6:2600:1700:6cf8:1240:5b04:e8d1:ce5:8164? ([2600:1700:6cf8:1240:5b04:e8d1:ce5:8164])
        by smtp.gmail.com with ESMTPSA id k11-20020a056902024b00b00d7b9fab78bfsm62003ybs.7.2023.10.30.12.39.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Oct 2023 12:39:16 -0700 (PDT)
Message-ID: <c3790110-43d8-4ec3-919c-8493eb9a6e38@gmail.com>
Date:   Mon, 30 Oct 2023 12:39:15 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v3 1/2] selftests/bpf: Convert CHECK macros to
 ASSERT_* macros in bpf_iter
Content-Language: en-US
To:     Yuran Pereira <yuran.pereira@hotmail.com>, bpf@vger.kernel.org,
        yonghong.song@linux.dev
Cc:     ast@kernel.org, brauner@kernel.org, daniel@iogearbox.net,
        haoluo@google.com, iii@linux.ibm.com, john.fastabend@gmail.com,
        jolsa@kernel.org, kpsingh@kernel.org, kuifeng@meta.com,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        mykolal@fb.com, sdf@google.com, shuah@kernel.org, song@kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org
References: <cover.1698461732.git.yuran.pereira@hotmail.com>
 <DB3PR10MB6835E9C8DFCA226DD6FEF914E8A3A@DB3PR10MB6835.EURPRD10.PROD.OUTLOOK.COM>
From:   Kui-Feng Lee <sinquersw@gmail.com>
In-Reply-To: <DB3PR10MB6835E9C8DFCA226DD6FEF914E8A3A@DB3PR10MB6835.EURPRD10.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Acked-by: Kui-Feng Lee <thinker.li@gmail.com>

On 10/27/23 22:24, Yuran Pereira wrote:
> As it was pointed out by Yonghong Song [1], in the bpf selftests the use
> of the ASSERT_* series of macros is preferred over the CHECK macro.
> This patch replaces all CHECK calls in bpf_iter with the appropriate
> ASSERT_* macros.
> 
> [1] https://lore.kernel.org/lkml/0a142924-633c-44e6-9a92-2dc019656bf2@linux.dev
> 
> Suggested-by: Yonghong Song <yonghong.song@linux.dev>
> Signed-off-by: Yuran Pereira <yuran.pereira@hotmail.com>
> ---
>   .../selftests/bpf/prog_tests/bpf_iter.c       | 79 ++++++++-----------
>   1 file changed, 35 insertions(+), 44 deletions(-)
> 
> diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_iter.c b/tools/testing/selftests/bpf/prog_tests/bpf_iter.c
> index 1f02168103dd..123a3502b8f0 100644
> --- a/tools/testing/selftests/bpf/prog_tests/bpf_iter.c
> +++ b/tools/testing/selftests/bpf/prog_tests/bpf_iter.c
> @@ -34,8 +34,6 @@
>   #include "bpf_iter_ksym.skel.h"
>   #include "bpf_iter_sockmap.skel.h"
>   
> -static int duration;
> -
>   static void test_btf_id_or_null(void)
>   {
>   	struct bpf_iter_test_kern3 *skel;
> @@ -64,7 +62,7 @@ static void do_dummy_read_opts(struct bpf_program *prog, struct bpf_iter_attach_
>   	/* not check contents, but ensure read() ends without error */
>   	while ((len = read(iter_fd, buf, sizeof(buf))) > 0)
>   		;
> -	CHECK(len < 0, "read", "read failed: %s\n", strerror(errno));
> +	ASSERT_GE(len, 0, "read");
>   
>   	close(iter_fd);
>   
> @@ -413,7 +411,7 @@ static int do_btf_read(struct bpf_iter_task_btf *skel)
>   		goto free_link;
>   	}
>   
> -	if (CHECK(err < 0, "read", "read failed: %s\n", strerror(errno)))
> +	if (!ASSERT_GE(err, 0, "read"))
>   		goto free_link;
>   
>   	ASSERT_HAS_SUBSTR(taskbuf, "(struct task_struct)",
> @@ -526,11 +524,11 @@ static int do_read_with_fd(int iter_fd, const char *expected,
>   	start = 0;
>   	while ((len = read(iter_fd, buf + start, read_buf_len)) > 0) {
>   		start += len;
> -		if (CHECK(start >= 16, "read", "read len %d\n", len))
> +		if (!ASSERT_LT(start, 16, "read"))
>   			return -1;
>   		read_buf_len = read_one_char ? 1 : 16 - start;
>   	}
> -	if (CHECK(len < 0, "read", "read failed: %s\n", strerror(errno)))
> +	if (!ASSERT_GE(len, 0, "read"))
>   		return -1;
>   
>   	if (!ASSERT_STREQ(buf, expected, "read"))
> @@ -571,8 +569,7 @@ static int do_read(const char *path, const char *expected)
>   	int err, iter_fd;
>   
>   	iter_fd = open(path, O_RDONLY);
> -	if (CHECK(iter_fd < 0, "open", "open %s failed: %s\n",
> -		  path, strerror(errno)))
> +	if (!ASSERT_GE(iter_fd, 0, "open"))
>   		return -1;
>   
>   	err = do_read_with_fd(iter_fd, expected, false);
> @@ -600,7 +597,7 @@ static void test_file_iter(void)
>   	unlink(path);
>   
>   	err = bpf_link__pin(link, path);
> -	if (CHECK(err, "pin_iter", "pin_iter to %s failed: %d\n", path, err))
> +	if (!ASSERT_OK(err, "pin_iter"))
>   		goto free_link;
>   
>   	err = do_read(path, "abcd");
> @@ -651,12 +648,10 @@ static void test_overflow(bool test_e2big_overflow, bool ret1)
>   	 * overflow and needs restart.
>   	 */
>   	map1_fd = bpf_map_create(BPF_MAP_TYPE_ARRAY, NULL, 4, 8, 1, NULL);
> -	if (CHECK(map1_fd < 0, "bpf_map_create",
> -		  "map_creation failed: %s\n", strerror(errno)))
> +	if (!ASSERT_GE(map1_fd, 0, "bpf_map_create"))
>   		goto out;
>   	map2_fd = bpf_map_create(BPF_MAP_TYPE_ARRAY, NULL, 4, 8, 1, NULL);
> -	if (CHECK(map2_fd < 0, "bpf_map_create",
> -		  "map_creation failed: %s\n", strerror(errno)))
> +	if (!ASSERT_GE(map2_fd, 0, "bpf_map_create"))
>   		goto free_map1;
>   
>   	/* bpf_seq_printf kernel buffer is 8 pages, so one map
> @@ -685,14 +680,12 @@ static void test_overflow(bool test_e2big_overflow, bool ret1)
>   	/* setup filtering map_id in bpf program */
>   	map_info_len = sizeof(map_info);
>   	err = bpf_map_get_info_by_fd(map1_fd, &map_info, &map_info_len);
> -	if (CHECK(err, "get_map_info", "get map info failed: %s\n",
> -		  strerror(errno)))
> +	if (!ASSERT_OK(err, "get_map_info"))
>   		goto free_map2;
>   	skel->bss->map1_id = map_info.id;
>   
>   	err = bpf_map_get_info_by_fd(map2_fd, &map_info, &map_info_len);
> -	if (CHECK(err, "get_map_info", "get map info failed: %s\n",
> -		  strerror(errno)))
> +	if (!ASSERT_OK(err, "get_map_info"))
>   		goto free_map2;
>   	skel->bss->map2_id = map_info.id;
>   
> @@ -714,16 +707,14 @@ static void test_overflow(bool test_e2big_overflow, bool ret1)
>   		while ((len = read(iter_fd, buf, expected_read_len)) > 0)
>   			total_read_len += len;
>   
> -		CHECK(len != -1 || errno != E2BIG, "read",
> -		      "expected ret -1, errno E2BIG, but get ret %d, error %s\n",
> -			  len, strerror(errno));
> +		ASSERT_EQ(len, -1, "read");
> +		ASSERT_EQ(errno, E2BIG, "read");
>   		goto free_buf;
>   	} else if (!ret1) {
>   		while ((len = read(iter_fd, buf, expected_read_len)) > 0)
>   			total_read_len += len;
>   
> -		if (CHECK(len < 0, "read", "read failed: %s\n",
> -			  strerror(errno)))
> +		if (!ASSERT_GE(len, 0, "read"))
>   			goto free_buf;
>   	} else {
>   		do {
> @@ -732,8 +723,7 @@ static void test_overflow(bool test_e2big_overflow, bool ret1)
>   				total_read_len += len;
>   		} while (len > 0 || len == -EAGAIN);
>   
> -		if (CHECK(len < 0, "read", "read failed: %s\n",
> -			  strerror(errno)))
> +		if (!ASSERT_GE(len, 0, "read"))
>   			goto free_buf;
>   	}
>   
> @@ -836,7 +826,7 @@ static void test_bpf_hash_map(void)
>   	/* do some tests */
>   	while ((len = read(iter_fd, buf, sizeof(buf))) > 0)
>   		;
> -	if (CHECK(len < 0, "read", "read failed: %s\n", strerror(errno)))
> +	if (!ASSERT_GE(len, 0, "read"))
>   		goto close_iter;
>   
>   	/* test results */
> @@ -917,7 +907,7 @@ static void test_bpf_percpu_hash_map(void)
>   	/* do some tests */
>   	while ((len = read(iter_fd, buf, sizeof(buf))) > 0)
>   		;
> -	if (CHECK(len < 0, "read", "read failed: %s\n", strerror(errno)))
> +	if (!ASSERT_GE(len, 0, "read"))
>   		goto close_iter;
>   
>   	/* test results */
> @@ -983,17 +973,14 @@ static void test_bpf_array_map(void)
>   	start = 0;
>   	while ((len = read(iter_fd, buf + start, sizeof(buf) - start)) > 0)
>   		start += len;
> -	if (CHECK(len < 0, "read", "read failed: %s\n", strerror(errno)))
> +	if (!ASSERT_GE(len, 0, "read"))
>   		goto close_iter;
>   
>   	/* test results */
>   	res_first_key = *(__u32 *)buf;
>   	res_first_val = *(__u64 *)(buf + sizeof(__u32));
> -	if (CHECK(res_first_key != 0 || res_first_val != first_val,
> -		  "bpf_seq_write",
> -		  "seq_write failure: first key %u vs expected 0, "
> -		  " first value %llu vs expected %llu\n",
> -		  res_first_key, res_first_val, first_val))
> +	if (!ASSERT_EQ(res_first_key, 0, "bpf_seq_write") ||
> +			!ASSERT_EQ(res_first_val, first_val, "bpf_seq_write"))
>   		goto close_iter;
>   
>   	if (!ASSERT_EQ(skel->bss->key_sum, expected_key, "key_sum"))
> @@ -1092,7 +1079,7 @@ static void test_bpf_percpu_array_map(void)
>   	/* do some tests */
>   	while ((len = read(iter_fd, buf, sizeof(buf))) > 0)
>   		;
> -	if (CHECK(len < 0, "read", "read failed: %s\n", strerror(errno)))
> +	if (!ASSERT_GE(len, 0, "read"))
>   		goto close_iter;
>   
>   	/* test results */
> @@ -1131,6 +1118,7 @@ static void test_bpf_sk_storage_delete(void)
>   	sock_fd = socket(AF_INET6, SOCK_STREAM, 0);
>   	if (!ASSERT_GE(sock_fd, 0, "socket"))
>   		goto out;
> +
>   	err = bpf_map_update_elem(map_fd, &sock_fd, &val, BPF_NOEXIST);
>   	if (!ASSERT_OK(err, "map_update"))
>   		goto out;
> @@ -1151,14 +1139,19 @@ static void test_bpf_sk_storage_delete(void)
>   	/* do some tests */
>   	while ((len = read(iter_fd, buf, sizeof(buf))) > 0)
>   		;
> -	if (CHECK(len < 0, "read", "read failed: %s\n", strerror(errno)))
> +	if (!ASSERT_GE(len, 0, "read"))
>   		goto close_iter;
>   
>   	/* test results */
>   	err = bpf_map_lookup_elem(map_fd, &sock_fd, &val);
> -	if (CHECK(!err || errno != ENOENT, "bpf_map_lookup_elem",
> -		  "map value wasn't deleted (err=%d, errno=%d)\n", err, errno))
> -		goto close_iter;
> +
> +	 /* Note: The following assertions serve to ensure
> +	  * the value was deleted. It does so by asserting
> +	  * that bpf_map_lookup_elem has failed. This might
> +	  * seem counterintuitive at first.
> +	  */
> +	ASSERT_ERR(err, "bpf_map_lookup_elem");
> +	ASSERT_EQ(errno, ENOENT, "bpf_map_lookup_elem");
>   
>   close_iter:
>   	close(iter_fd);
> @@ -1203,17 +1196,15 @@ static void test_bpf_sk_storage_get(void)
>   	do_dummy_read(skel->progs.fill_socket_owner);
>   
>   	err = bpf_map_lookup_elem(map_fd, &sock_fd, &val);
> -	if (CHECK(err || val != getpid(), "bpf_map_lookup_elem",
> -	    "map value wasn't set correctly (expected %d, got %d, err=%d)\n",
> -	    getpid(), val, err))
> +	if (!ASSERT_OK(err, "bpf_map_lookup_elem") ||
> +			!ASSERT_EQ(val, getpid(), "bpf_map_lookup_elem"))
>   		goto close_socket;
>   
>   	do_dummy_read(skel->progs.negate_socket_local_storage);
>   
>   	err = bpf_map_lookup_elem(map_fd, &sock_fd, &val);
> -	CHECK(err || val != -getpid(), "bpf_map_lookup_elem",
> -	      "map value wasn't set correctly (expected %d, got %d, err=%d)\n",
> -	      -getpid(), val, err);
> +	ASSERT_OK(err, "bpf_map_lookup_elem");
> +	ASSERT_EQ(val, -getpid(), "bpf_map_lookup_elem");
>   
>   close_socket:
>   	close(sock_fd);
> @@ -1290,7 +1281,7 @@ static void test_bpf_sk_storage_map(void)
>   	/* do some tests */
>   	while ((len = read(iter_fd, buf, sizeof(buf))) > 0)
>   		;
> -	if (CHECK(len < 0, "read", "read failed: %s\n", strerror(errno)))
> +	if (!ASSERT_GE(len, 0, "read"))
>   		goto close_iter;
>   
>   	/* test results */
