Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56CF47D7B81
	for <lists+linux-kselftest@lfdr.de>; Thu, 26 Oct 2023 06:33:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229836AbjJZEdM (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 26 Oct 2023 00:33:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229638AbjJZEdL (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 26 Oct 2023 00:33:11 -0400
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com [IPv6:2607:f8b0:4864:20::1135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2338CD44;
        Wed, 25 Oct 2023 21:33:05 -0700 (PDT)
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-5ac376d311aso3570167b3.1;
        Wed, 25 Oct 2023 21:33:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698294784; x=1698899584; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gSErUA6bZ2PWSygt7Hg49URNcOPm6xwyaBE7DIJF2Qg=;
        b=PJans4U0WxbqkssC5OnTLbVavjpE6cu5gRmKxuufWd130pAa0AaCC/6yYwjAWswgWc
         EvE5aIgBIp+kVJoVjrgINkMro7IdWKolHHGKfWtqAlb0glcqRIBaMRzPCGNp81ryK3lB
         wxlANCBBgwrAZL2COlAF7wEmQCZ8EI8yyALtbSIpj5En2497Hu84s01rLAo6TE87c9ag
         zpvqEsaIlMjFQrowQ2ybzLbZspTMZh4u0Yv4gWBPREvZjajisTptbIIDmtPIM4NXcrk1
         5OG6cPyvvjme9zZNjD9EiwaJES8KFjqTCVud+n7lj/jPvvOyQMC8FnYwoPwzeVDT9T3E
         ziCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698294784; x=1698899584;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gSErUA6bZ2PWSygt7Hg49URNcOPm6xwyaBE7DIJF2Qg=;
        b=JWmfDlwP2CRRQ6Qn9CXM5W12Rx674I1IQ1nZOQRwRcLtNS0IhEnoUJiPy62ZtPd48c
         icZeZiC1QPZKvH1L0X74qttwUAd1dMBHy4vMeH6MWM9V2LCZp35fqKtwUO9dd5lGc/iZ
         +5K9s/88wIsiVVK6HEwBfVU66QF7kMAcyemOnBk7b4HPzTpSkXV+l4sFKYo4dDRuuxsO
         aw40TURLvZp7exjO5es3+tDTFYxFcQz3MgRMz3ZJIi9xic2sRoRZtIHfI5lDpP4Mwd+2
         0HEVq2VQpO/IdbYYDXXage44e3fctfTO7lFA8VoeeMaB3MFkV5W+0ZXPpbyp5blc2Zoo
         RBdA==
X-Gm-Message-State: AOJu0YxQsbtdDhixGcXUmtESypDLh0rEbdAyP2bO90b14qKF3owe5kq8
        LxvtJEGU3ajgSr5PZj/kzgM=
X-Google-Smtp-Source: AGHT+IHlqv+SCI5WQ2B19XGaNzb7GlnrD6BR3q4H7amVDEkIu3yFHMNwIr/nOjGL9cu4uG39hW0SmQ==
X-Received: by 2002:a05:690c:fd6:b0:5a8:1fea:37ee with SMTP id dg22-20020a05690c0fd600b005a81fea37eemr21724050ywb.22.1698294783866;
        Wed, 25 Oct 2023 21:33:03 -0700 (PDT)
Received: from ?IPV6:2600:1700:6cf8:1240:8355:61d5:b55:33e7? ([2600:1700:6cf8:1240:8355:61d5:b55:33e7])
        by smtp.gmail.com with ESMTPSA id j126-20020a0df984000000b0058038e6609csm5654316ywf.74.2023.10.25.21.33.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Oct 2023 21:33:03 -0700 (PDT)
Message-ID: <3739e65c-b86d-4c11-9cf5-7b76080400c2@gmail.com>
Date:   Wed, 25 Oct 2023 21:33:01 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v2 1/2] selftests/bpf: Convert CHECK macros to
 ASSERT_* macros in bpf_iter
Content-Language: en-US
To:     Yuran Pereira <yuran.pereira@hotmail.com>, bpf@vger.kernel.org,
        yonghong.song@linux.dev
Cc:     shuah@kernel.org, ast@kernel.org, daniel@iogearbox.net,
        song@kernel.org, john.fastabend@gmail.com, kpsingh@kernel.org,
        sdf@google.com, haoluo@google.com, jolsa@kernel.org,
        mykolal@fb.com, brauner@kernel.org, iii@linux.ibm.com,
        kuifeng@meta.com, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20231026020319.1203600-1-yuran.pereira@hotmail.com>
 <DB3PR10MB68352B683F26EE9C342B71A9E8DDA@DB3PR10MB6835.EURPRD10.PROD.OUTLOOK.COM>
From:   Kui-Feng Lee <sinquersw@gmail.com>
In-Reply-To: <DB3PR10MB68352B683F26EE9C342B71A9E8DDA@DB3PR10MB6835.EURPRD10.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org



On 10/25/23 19:03, Yuran Pereira wrote:
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
>   .../selftests/bpf/prog_tests/bpf_iter.c       | 82 +++++++++----------
>   1 file changed, 39 insertions(+), 43 deletions(-)
> 
> diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_iter.c b/tools/testing/selftests/bpf/prog_tests/bpf_iter.c
> index 1f02168103dd..7db6972ed952 100644
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
> @@ -714,16 +707,15 @@ static void test_overflow(bool test_e2big_overflow, bool ret1)
>   		while ((len = read(iter_fd, buf, expected_read_len)) > 0)
>   			total_read_len += len;
>   
> -		CHECK(len != -1 || errno != E2BIG, "read",
> -		      "expected ret -1, errno E2BIG, but get ret %d, error %s\n",
> -			  len, strerror(errno));
> +		if (!ASSERT_EQ(len, -1, "read"))
> +			goto free_buf;
> +		ASSERT_EQ(errno, E2BIG, "read");

I think you can just do

   ASSERT_EQ(len, -1, "read");
   ASSERT_EQ(errno, E2BG, "read");

without a check here.
WDYT?

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
> @@ -732,8 +724,7 @@ static void test_overflow(bool test_e2big_overflow, bool ret1)
>   				total_read_len += len;
>   		} while (len > 0 || len == -EAGAIN);
>   
> -		if (CHECK(len < 0, "read", "read failed: %s\n",
> -			  strerror(errno)))
> +		if (!ASSERT_GE(len, 0, "read"))
>   			goto free_buf;
>   	}
>   
> @@ -836,7 +827,7 @@ static void test_bpf_hash_map(void)
>   	/* do some tests */
>   	while ((len = read(iter_fd, buf, sizeof(buf))) > 0)
>   		;
> -	if (CHECK(len < 0, "read", "read failed: %s\n", strerror(errno)))
> +	if (!ASSERT_GE(len, 0, "read"))
>   		goto close_iter;
>   
>   	/* test results */
> @@ -917,7 +908,7 @@ static void test_bpf_percpu_hash_map(void)
>   	/* do some tests */
>   	while ((len = read(iter_fd, buf, sizeof(buf))) > 0)
>   		;
> -	if (CHECK(len < 0, "read", "read failed: %s\n", strerror(errno)))
> +	if (!ASSERT_GE(len, 0, "read"))
>   		goto close_iter;
>   
>   	/* test results */
> @@ -983,17 +974,15 @@ static void test_bpf_array_map(void)
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
> +	if (!ASSERT_EQ(res_first_key, 0, "bpf_seq_write"))
> +		goto close_iter;
> +	else if (!ASSERT_EQ(res_first_val, first_val, "bpf_seq_write"))
>   		goto close_iter;

Similiar here!

  if (!ASSERT_EQ(...) ||
      !ASSERT_EQ(...))
       goto close_iter;


>   
>   	if (!ASSERT_EQ(skel->bss->key_sum, expected_key, "key_sum"))
> @@ -1092,7 +1081,7 @@ static void test_bpf_percpu_array_map(void)
>   	/* do some tests */
>   	while ((len = read(iter_fd, buf, sizeof(buf))) > 0)
>   		;
> -	if (CHECK(len < 0, "read", "read failed: %s\n", strerror(errno)))
> +	if (!ASSERT_GE(len, 0, "read"))
>   		goto close_iter;
>   
>   	/* test results */
> @@ -1131,6 +1120,7 @@ static void test_bpf_sk_storage_delete(void)
>   	sock_fd = socket(AF_INET6, SOCK_STREAM, 0);
>   	if (!ASSERT_GE(sock_fd, 0, "socket"))
>   		goto out;
> +
>   	err = bpf_map_update_elem(map_fd, &sock_fd, &val, BPF_NOEXIST);
>   	if (!ASSERT_OK(err, "map_update"))
>   		goto out;
> @@ -1151,14 +1141,20 @@ static void test_bpf_sk_storage_delete(void)
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
> +
> +	 /* Note: The following assertions serve to ensure
> +	  * the value was deleted. It does so by asserting
> +	  * that bpf_map_lookup_elem has failed. This might
> +	  * seem counterintuitivei at first.
> +	  */
> +	if (!ASSERT_ERR(err, "bpf_map_lookup_elem"))
>   		goto close_iter;
> +	ASSERT_EQ(errno, ENOENT, "bpf_map_lookup_elem");

Same! Two consecutive ASSERT_*()s should be good.

>   
>   close_iter:
>   	close(iter_fd);
> @@ -1203,17 +1199,17 @@ static void test_bpf_sk_storage_get(void)
>   	do_dummy_read(skel->progs.fill_socket_owner);
>   
>   	err = bpf_map_lookup_elem(map_fd, &sock_fd, &val);
> -	if (CHECK(err || val != getpid(), "bpf_map_lookup_elem",
> -	    "map value wasn't set correctly (expected %d, got %d, err=%d)\n",
> -	    getpid(), val, err))
> +	if (!ASSERT_OK(err, "bpf_map_lookup_elem"))
> +		goto close_socket;
> +	else if (!ASSERT_EQ(val, getpid(), "bpf_map_lookup_elem"))
>   		goto close_socket;
>   

Same, !ASSERT_OK(..) || !ASSERT_EQ(...)

>   	do_dummy_read(skel->progs.negate_socket_local_storage);
>   
>   	err = bpf_map_lookup_elem(map_fd, &sock_fd, &val);
> -	CHECK(err || val != -getpid(), "bpf_map_lookup_elem",
> -	      "map value wasn't set correctly (expected %d, got %d, err=%d)\n",
> -	      -getpid(), val, err);
> +	if (!ASSERT_OK(err, "bpf_map_lookup_elem"))
> +		goto close_socket;
> +	ASSERT_EQ(val, -getpid(), "bpf_map_lookup_elem");

Two consecutive ASSERT_*()s should be good.

>   
>   close_socket:
>   	close(sock_fd);
> @@ -1290,7 +1286,7 @@ static void test_bpf_sk_storage_map(void)
>   	/* do some tests */
>   	while ((len = read(iter_fd, buf, sizeof(buf))) > 0)
>   		;
> -	if (CHECK(len < 0, "read", "read failed: %s\n", strerror(errno)))
> +	if (!ASSERT_GE(len, 0, "read"))
>   		goto close_iter;
>   
>   	/* test results */
