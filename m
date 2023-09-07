Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DC147978DC
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Sep 2023 18:56:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229893AbjIGQ42 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 7 Sep 2023 12:56:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244813AbjIGQ40 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 7 Sep 2023 12:56:26 -0400
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85CE31BE9;
        Thu,  7 Sep 2023 09:56:01 -0700 (PDT)
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-400a087b0bfso12673555e9.2;
        Thu, 07 Sep 2023 09:56:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694105397; x=1694710197; darn=vger.kernel.org;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zJt/9WZjIvczsRkxafc4lYbTBilfxwLL5Q8Z2MfbMxA=;
        b=sIyv8y6BstNYPgCkKYouA0nClPdzHpzFsSwR2R5WKhLc7KetEy1CbeXi8RYz4kf8pL
         vuOh2q4nRy7hxzvfMHsKvS4lZxJWNuTyh5QerRPyTNwd95Qp7bZhICi1WRWr8Sr7VwNP
         mNtjG2DqqyB+xJ5y+ZGpbN91MS1FBx7xi9L918mEWLQx3/oENeRreY7mrVhG4hwfTAkN
         ZB3FHb0vrFQbacWDfoiujcR9SMxEmiohYeOcYDgivfKWvX5rpoi1bH78toHcSrBBbsIF
         Yf+hIZcY8hRJoffHeajx1ZknY9S7reCwyPxtRxsqJt2Juu/Xilj+n7Kv/YQ66saDfxgz
         1ddQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694105397; x=1694710197;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zJt/9WZjIvczsRkxafc4lYbTBilfxwLL5Q8Z2MfbMxA=;
        b=jseJvb6XStpg9JhKXaXoKLAnkgXbpqpX9nK9c2zPOTfRegO3gAKcsSx60J0Y8VgTbi
         pZrftQUMG2I9H5h75zY+BneSb6kMkIqHanThLVSPDTIko6SESPzt9cNbLRRfbZZOMd6V
         lqQSIP71ByUpY1EUlMYSW4Mgso435wbHVh0r9sGtpc+NmdaEJHBbOqTMq8qWyv7w9H3C
         OSEh1MGb2qx3lxufkbMRtg7/s2pU6MkFCXOc9jxWX6Erc0l2rqlrFu8ULI/XnSqDTA0l
         eVb2zkeLc+xplZdutfjRWqBqADMNWEixZwnAqL+9eyxeRjrG7aijlRtms2XQ+lRXJHFB
         srhQ==
X-Gm-Message-State: AOJu0YxWYWHl0zRU95bvKNYfGCgH3I6YEjuAOyFsaw9b1KMSiO2Kt2Ka
        rfbRTwWJnnUwfr843JyhaZCDTcw8viJ9cVhtrOs=
X-Google-Smtp-Source: AGHT+IHQms088fQHxPwTfEA6+q2JptXmrfKtUg9+VGkg/zVvy2mqqimWslcAItCwwk8cjnVfE5Wtew==
X-Received: by 2002:a05:6000:10d0:b0:319:7788:5027 with SMTP id b16-20020a05600010d000b0031977885027mr4324606wrx.59.1694077727914;
        Thu, 07 Sep 2023 02:08:47 -0700 (PDT)
Received: from dev-dsk-pjy-1a-76bc80b3.eu-west-1.amazon.com (54-240-197-231.amazon.com. [54.240.197.231])
        by smtp.gmail.com with ESMTPSA id m12-20020adff38c000000b0031ad5fb5a0fsm22777884wro.58.2023.09.07.02.08.46
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Sep 2023 02:08:47 -0700 (PDT)
From:   Puranjay Mohan <puranjay12@gmail.com>
To:     "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>,
        Yonghong Song <yonghong.song@linux.dev>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Shubham Bansal <illusionist.neo@gmail.com>,
        Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>,
        bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next v2 4/8] arm32, bpf: add support for
 unconditional bswap instruction
References: <20230906183320.1959008-1-puranjay12@gmail.com>
        <20230906183320.1959008-5-puranjay12@gmail.com>
        <ZPmOUYBdRxR1/8vw@shell.armlinux.org.uk>
Date:   Thu, 07 Sep 2023 09:08:46 +0000
In-Reply-To: <ZPmOUYBdRxR1/8vw@shell.armlinux.org.uk> (Russell King's message
        of "Thu, 7 Sep 2023 09:48:17 +0100")
Message-ID: <mb61pzg1y1hb5.fsf@amazon.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Sep 07 2023, Russell King (Oracle) wrote:

> On Wed, Sep 06, 2023 at 06:33:16PM +0000, Puranjay Mohan wrote:
>> @@ -1633,8 +1633,10 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx)
>>  	/* dst = htobe(dst) */
>>  	case BPF_ALU | BPF_END | BPF_FROM_LE:
>>  	case BPF_ALU | BPF_END | BPF_FROM_BE:
>> +	/* dst = bswap(dst) */
>> +	case BPF_ALU64 | BPF_END | BPF_TO_LE:
>>  		rd = arm_bpf_get_reg64(dst, tmp, ctx);
>> -		if (BPF_SRC(code) == BPF_FROM_LE)
>> +		if (BPF_SRC(code) == BPF_FROM_LE && BPF_CLASS(code) != BPF_ALU64)
>
> With the addition of the BPF_ALU64 case, I'm wondering why this if() is
> affected. If you were adding:
>
> 	case BPF_ALU64 | BPF_END | BPF_FROM_LE:
>
> then maybe there would be a reason, but the BPF_ALU64 | BPF_END |
> BPF_TO_LE case will never match even the original if() statement.

The reason is that these mean the same thing.
from: include/uapi/linux/bpf.h

#define BPF_TO_LE	0x00	/* convert to little-endian */
#define BPF_TO_BE	0x08	/* convert to big-endian */
#define BPF_FROM_LE	BPF_TO_LE
#define BPF_FROM_BE	BPF_TO_BE

So, to not cause confusion and follow the earlier cases I can add:

case BPF_ALU64 | BPF_END | BPF_FROM_LE:

in the next version.


Thanks,
Puranjay
