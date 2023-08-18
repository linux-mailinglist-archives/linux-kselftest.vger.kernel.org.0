Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7146E7803AD
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Aug 2023 04:11:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357184AbjHRCKw (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 17 Aug 2023 22:10:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357187AbjHRCKm (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 17 Aug 2023 22:10:42 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73EAC30FE;
        Thu, 17 Aug 2023 19:10:41 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-689e6fce70dso387546b3a.1;
        Thu, 17 Aug 2023 19:10:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692324641; x=1692929441;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Wsj2zNj3xkOCvdWvIxiq3aCWKIVsXzUeqck+9IunsAc=;
        b=jHlL0o0V1LTQeWAo+KNlFfRAv/jd6lTaog8cCSKfDTDEwHOrkaTqcPmoUmqRJBJjls
         lZBL8YRCVda8i+gbzx816gCP7Sib/Ek+8MvlP5aDXSNmo9vncFdWDfQl8RiWsCMpl125
         JpK7jG+A93A8bO36o0hQybAkud2Xf8AdSRijcTWLpr6I6ms83Ja9ANwehcp3s1zdxZIQ
         uNSDYtGfmxVJ3LINfFmA/DkciALcdfU6W6yd6wjvvt9Vjm6JdRF1ZQCt7QNWpAK7d3xB
         vFbcQGr+qItjkOtnK23pyxVCOKVjsPSAjC9v+QV15VTKz+8FjJbN3+OZAxGXnG0U7kRm
         1f/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692324641; x=1692929441;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Wsj2zNj3xkOCvdWvIxiq3aCWKIVsXzUeqck+9IunsAc=;
        b=O8b2KmrfXN0rKVY2WVP+6Iys9kalHJ9tGAIvKi1EBlJc6ImvLOnY/TI1UVt+h/xGwL
         N8AnP4uglqARk7U62PB8CdcvKVlIeWR8U4rovQm4Hd5Tm0GMIUS5nzsTAF2etqpzE37M
         t3Zai0feOx780+EqD/fLHwL5/j1kuHipzGdk6Wp1Rz9vwCMpFRfJXSy+ri75qxhA5CiJ
         x2wWGtVs8QefRBaNatfpw9UdjlXlsH/AiyRaa3eQS/wFueMsvrHnQZTmGsKt2OAsJ0wr
         t1a/IU56dIINWnk7+85javWa2oBnZwbZGHe3L93cSZ5i/onjslxNu2bZ/ZiOYFJIzB+9
         2GCw==
X-Gm-Message-State: AOJu0Yzvca/Shk+hj2W3E1EMwAQdhwn/Kme90yJBGuetfl57AQ+uhleU
        SF4ha1TJAqoGXlAGBnicQMo=
X-Google-Smtp-Source: AGHT+IGuSeE4KmfNgan/3FH0662SMQS1YQkxWfN4l4PzfLryD1ZsnCd7EuNnUHT56oa64CZ8k00oaQ==
X-Received: by 2002:a05:6a00:134a:b0:687:e02b:e3c with SMTP id k10-20020a056a00134a00b00687e02b0e3cmr1630698pfu.17.1692324640752;
        Thu, 17 Aug 2023 19:10:40 -0700 (PDT)
Received: from [10.22.68.146] ([122.11.166.8])
        by smtp.gmail.com with ESMTPSA id n22-20020a62e516000000b006870ccfbb54sm400622pff.196.2023.08.17.19.10.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Aug 2023 19:10:40 -0700 (PDT)
Message-ID: <fea59b79-3f28-c580-185b-8c64dc21a399@gmail.com>
Date:   Fri, 18 Aug 2023 10:10:33 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Subject: Re: [RFC PATCH bpf-next 1/2] bpf, x64: Fix tailcall infinite loop bug
Content-Language: en-US
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
        yonghong.song@linux.dev, john.fastabend@gmail.com,
        kpsingh@kernel.org, sdf@google.com, haoluo@google.com,
        jolsa@kernel.org, x86@kernel.org, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        hpa@zytor.com, mykolal@fb.com, shuah@kernel.org,
        davem@davemloft.net, dsahern@kernel.org, tangyeechou@gmail.com,
        kernel-patches-bot@fb.com, maciej.fijalkowski@intel.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
References: <20230814134147.70289-1-hffilwlqm@gmail.com>
 <20230814134147.70289-2-hffilwlqm@gmail.com>
 <20230817223143.jyclrtf3a6kmtgh5@macbook-pro-8.dhcp.thefacebook.com>
From:   Leon Hwang <hffilwlqm@gmail.com>
In-Reply-To: <20230817223143.jyclrtf3a6kmtgh5@macbook-pro-8.dhcp.thefacebook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org



On 18/8/23 06:31, Alexei Starovoitov wrote:
> On Mon, Aug 14, 2023 at 09:41:46PM +0800, Leon Hwang wrote:
>> @@ -1147,6 +1152,7 @@ struct bpf_attach_target_info {
>>  	struct module *tgt_mod;
>>  	const char *tgt_name;
>>  	const struct btf_type *tgt_type;
>> +	bool tail_call_ctx;
> 
> Instead of extra flag here can you check tgt_prog->aux->tail_call_reachable in check_attach_btf_id()
> and set tr->flags there?

Should we check tgt_prog->aux->func[subprog]->is_func? Or, tgt_prog->aux->tail_call_reachable
is enough?

I think tgt_prog->aux->func[subprog]->is_func is required to check. It's because it's a bug
about subprog instead of tgt_prog.

In check_attach_btf_id():

bool tail_call_ctx;
// ...
ret = bpf_check_attach_target(&env->log, prog, tgt_prog, btf_id, &tgt_info, &tail_call_ctx);
// ...
tr->flags = (tail_call_ctx ? BPF_TRAMP_F_TAIL_CALL_CTX : 0);

How about changing like this? However, it's bad to change bpf_check_attach_target() declaration.

> Other than this the fix makes sense.
> Please trim your cc list when you respin.> Just maintainers, Maciej (author of fixes tag) and bpf@vger is enough.

I'll trim it.

Thanks,
Leon

