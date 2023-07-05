Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9149748504
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Jul 2023 15:32:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230466AbjGENcx (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 5 Jul 2023 09:32:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232291AbjGENcp (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 5 Jul 2023 09:32:45 -0400
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8516C1730;
        Wed,  5 Jul 2023 06:32:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
        bh=QR9LXQoWWr0wScmNywxUjk1GAhGRJT34AFfeE2vbkWE=; b=jgm9sd/Az/t4y8042+LZJpopdO
        h5l+c6shK5xSM/V0wJ+8w3TPYrQCQLh6t+ovos9jztjIn+uqW5webB5vyVXyqDPvR3iGvFFt7EgAI
        2Tv2t5XF4L5YTMIcZCbL4oNQMZ10gDDbgC42f+Y8GsVbW0y6MFAyz+TBCpBG/3sNLVZUP6UsGs83V
        7Wk2hNdAf658oX35i7N/56LP2rgrwxTOCc6X3InihLvr9HCNJJlqkCrs3cE+rkZDG0LyazgNXKcRj
        XTVUPBOxDLupVFKz5PIZTtxOGv/0qVOGBoc2AiCtTTdLWCrQ2HSa+uioY+TJnwSa0KqspF/qV6eiE
        CsGAtW8w==;
Received: from sslproxy03.your-server.de ([88.198.220.132])
        by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <daniel@iogearbox.net>)
        id 1qH2c6-00035C-7F; Wed, 05 Jul 2023 15:32:10 +0200
Received: from [178.197.249.31] (helo=linux.home)
        by sslproxy03.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1qH2c5-0008mc-KX; Wed, 05 Jul 2023 15:32:09 +0200
Subject: Re: [PATCH v1] selftests:bpf:Fix repeated initialization
To:     Wang Ming <machel@vivo.com>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>,
        bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     opensource.kernel@vivo.com
References: <20230705123432.1655-1-machel@vivo.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <cfc5f09e-7af1-abb9-aee9-737e3fe09c77@iogearbox.net>
Date:   Wed, 5 Jul 2023 15:32:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20230705123432.1655-1-machel@vivo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.8/26960/Wed Jul  5 09:29:05 2023)
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 7/5/23 2:33 PM, Wang Ming wrote:
> In use_missing_map function, value is
> initialized twice.There is no
> connection between the two assignment.
> This patch could fix this bug.

Please never submit patches where you are just speculating and did not even
bother to run BPF selftests !

Otherwise you would have seen that your change is breaking it :

Error: #126 log_fixup
Error: #126/5 log_fixup/missing_map
   Error: #126/5 log_fixup/missing_map
   missing_map:PASS:skel_open 0 nsec
   libbpf: prog 'use_missing_map': BPF program load failed: Invalid argument
   libbpf: prog 'use_missing_map': failed to load: -22
   libbpf: failed to load object 'test_log_fixup'
   libbpf: failed to load BPF skeleton 'test_log_fixup': -22
   missing_map:PASS:load_fail 0 nsec
   missing_map:PASS:existing_map_autocreate 0 nsec
   missing_map:PASS:missing_map_autocreate 0 nsec
   missing_map:FAIL:log_buf unexpected log_buf: '8: <invalid BPF map reference>
   BPF map 'missing_map' is referenced but wasn't created
   ' is not a substring of 'reg type unsupported for arg#0 function use_missing_map#20
   0: R1=ctx(off=0,imm=0) R10=fp0
   ; int use_missing_map(const void *ctx)
   0: (b4) w1 = 0                        ; R1_w=0
   ; int zero = 0;
   1: (63) *(u32 *)(r10 -4) = r1         ; R1_w=0 R10=fp0 fp-8=0000????
   2: (bf) r2 = r10                      ; R2_w=fp0 R10=fp0
   ;
   3: (07) r2 += -4                      ; R2_w=fp-4
   ; return bpf_map_lookup_elem(&missing_map, &zero) != NULL;
   4: <invalid BPF map reference>
   BPF map 'missing_map' is referenced but wasn't created
   processed 5 insns (limit 1000000) max_states_per_insn 0 total_states 0 peak_states 0 mark_read 0

> Signed-off-by: Wang Ming <machel@vivo.com>
> ---
>   tools/testing/selftests/bpf/progs/test_log_fixup.c | 8 ++------
>   1 file changed, 2 insertions(+), 6 deletions(-)
> 
> diff --git a/tools/testing/selftests/bpf/progs/test_log_fixup.c b/tools/testing/selftests/bpf/progs/test_log_fixup.c
> index 1bd48feaaa42..1c49b2f9be6c 100644
> --- a/tools/testing/selftests/bpf/progs/test_log_fixup.c
> +++ b/tools/testing/selftests/bpf/progs/test_log_fixup.c
> @@ -52,13 +52,9 @@ struct {
>   SEC("?raw_tp/sys_enter")
>   int use_missing_map(const void *ctx)
>   {
> -	int zero = 0, *value;
> +	int zero = 0;
>   
> -	value = bpf_map_lookup_elem(&existing_map, &zero);
> -
> -	value = bpf_map_lookup_elem(&missing_map, &zero);
> -
> -	return value != NULL;
> +	return bpf_map_lookup_elem(&missing_map, &zero) != NULL;
>   }
>   
>   extern int bpf_nonexistent_kfunc(void) __ksym __weak;
> 

