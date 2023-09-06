Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CA4079383E
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Sep 2023 11:30:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236808AbjIFJa3 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 6 Sep 2023 05:30:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235329AbjIFJa3 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 6 Sep 2023 05:30:29 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20BCD1732;
        Wed,  6 Sep 2023 02:29:49 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id 38308e7fff4ca-2bcc846fed0so53878551fa.2;
        Wed, 06 Sep 2023 02:29:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693992561; x=1694597361; darn=vger.kernel.org;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/RsfULzpF1odV8BlqVly8vHWfWckX8ePw3jzEkac84c=;
        b=HGWY78217NAWwRbV1imkKz1avzHjGN484j1O8KSz480YaEy3VmUIdmykLePYnY5jAY
         nLEe/bgkwHdvsl1Mj65PWAN9WQqQX5ycfwMEUjj73gSxU66wsKAf10nKfBpoao7jUsB5
         tWNqlOfTayh7tI8Du7B5P3Eyc+hsqyFuTrrj6pMe/pLT/mkWw89/GhEGH6vXAgx6Pdya
         t4jpnJGc6boLX+Fa2GZbM/Nd6uc0mVoj38vdjJsKfzR8NmC22ZSDZIDCEpfbOVwctS5z
         lDie3P+vMyfy0CGoLguXZU1szYFA76mNfQd+xOHp8AsulieOkm6mg3ivBC61EcTkZBqV
         jyrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693992561; x=1694597361;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/RsfULzpF1odV8BlqVly8vHWfWckX8ePw3jzEkac84c=;
        b=eOg5HM4Rs+1Ap0OX0Bzp42TCKhFfhVVOSfWtpEomvuggqRPanZQmIuo6PZep/xo1jL
         slgB4aPRfwKRRbChIywGWNBWppPqTtQRt39ajJNTau/v5I7NAP1UcL+JELeQB5JdP7qv
         38BY1Fwdp5sh9FEuhB8uI3bHOWG4K9mEVqzjCYKPMdzaWQeUvVtdLe2xYMMShis27gac
         skDa3RDHub0ayo2ZYOLbIsdBqVqkSGfZzin8gX9wVruXtvRNzusFBDdzrS7Nzy3aLPKg
         47QMWGkFEOWC7yuV4NBy+I6p+4/tjllmZzZRDCcKJEiPHGhihJI8G8L5OGxJodIdXE6V
         sAhg==
X-Gm-Message-State: AOJu0YwR+kY9XgT8VQZ49dAESnUBXd4gV6JXjvpw+CILMqHfwH/cu6uP
        z2CAfhmPB/QZ/ka5odML6Azlke7l1UpkCm0Yvu0=
X-Google-Smtp-Source: AGHT+IGKaMJSDf8csr0Zu2G/4dDSjwT1H9c5ww+CXkDQ7LrEQU9iFyU8J49LizPWQ/hizsoPTC0mPg==
X-Received: by 2002:a2e:9cd5:0:b0:2bc:c21d:311f with SMTP id g21-20020a2e9cd5000000b002bcc21d311fmr1561491ljj.52.1693992560399;
        Wed, 06 Sep 2023 02:29:20 -0700 (PDT)
Received: from dev-dsk-pjy-1a-76bc80b3.eu-west-1.amazon.com (54-240-197-231.amazon.com. [54.240.197.231])
        by smtp.gmail.com with ESMTPSA id t12-20020a7bc3cc000000b003fef19bb55csm19209577wmj.34.2023.09.06.02.29.19
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Sep 2023 02:29:20 -0700 (PDT)
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
Subject: Re: [PATCH bpf-next 6/8] arm32, bpf: add support for 64 bit
 division instruction
References: <20230905210621.1711859-1-puranjay12@gmail.com>
        <20230905210621.1711859-7-puranjay12@gmail.com>
        <ZPein8oS5egqGwzp@shell.armlinux.org.uk>
Date:   Wed, 06 Sep 2023 09:29:19 +0000
In-Reply-To: <ZPein8oS5egqGwzp@shell.armlinux.org.uk> (Russell King's message
        of "Tue, 5 Sep 2023 22:50:23 +0100")
Message-ID: <mb61po7if3b0w.fsf@amazon.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Sep 05 2023, Russell King (Oracle) wrote:

> On Tue, Sep 05, 2023 at 09:06:19PM +0000, Puranjay Mohan wrote:
>> +cont:
>> +
>> +	/* Call appropriate function */
>> +	if (sign)
>> +		emit_mov_i(ARM_IP, op == BPF_DIV ? (u32)jit_sdiv64 : (u32)jit_smod64, ctx);
>> +	else
>> +		emit_mov_i(ARM_IP, op == BPF_DIV ? (u32)jit_udiv64 : (u32)jit_mod64, ctx);
>
> Same comment as the previous patch here.

Will fix both in next version.

>
>> +
>> +	emit_blx_r(ARM_IP, ctx);
>> +
>> +	/* Save return value */
>> +	if (rd[1] != ARM_R0) {
>> +		emit(ARM_MOV_R(rd[0], ARM_R1), ctx);
>> +		emit(ARM_MOV_R(rd[1], ARM_R0), ctx);
>> +	}
>> +
>> +	/* Recover {R1, R0} from stack if it is not Rd */
>> +	if (rd[1] != ARM_R0)
>> +		emit(ARM_POP(BIT(ARM_R0) | BIT(ARM_R1)), ctx);
>> +	else
>> +		emit(ARM_ADD_I(ARM_SP, ARM_SP, 8), ctx);
>> +
>> +	/* Recover {R3, R2} from stack if it is not Rd */
>> +	if (rd[1] != ARM_R2)
>> +		emit(ARM_POP(BIT(ARM_R2) | BIT(ARM_R3)), ctx);
>> +	else
>> +		emit(ARM_ADD_I(ARM_SP, ARM_SP, 8), ctx);
>
> 	if (rd[1] != ARM_R0) {
> 		emit(ARM_POP(BIT(ARM_R0) | BIT(ARM_R1)), ctx);
> 		emit(ARM_ADD_I(ARM_SP, ARM_SP, 8), ctx);
> 	} else if (rd[1] != ARM_R2) {
> 		emit(ARM_ADD_I(ARM_SP, ARM_SP, 8), ctx);
> 		emit(ARM_POP(BIT(ARM_R2) | BIT(ARM_R3)), ctx);
> 	} else {
> 		emit(ARM_ADD_I(ARM_SP, ARM_SP, 16), ctx);
> 	}
>
> Hmm?

Actually, there can also be a situation where rd[1] != ARM_R0 && rd[1] != ARM_R2,
so should I do it like:

 	if (rd[1] != ARM_R0 && rd[1] != ARM_R2) {
 		emit(ARM_POP(BIT(ARM_R0) | BIT(ARM_R1)), ctx);
 		emit(ARM_POP(BIT(ARM_R2) | BIT(ARM_R3)), ctx);      
 	} else if (rd[1] != ARM_R0) {
 		emit(ARM_POP(BIT(ARM_R0) | BIT(ARM_R1)), ctx);
 		emit(ARM_ADD_I(ARM_SP, ARM_SP, 8), ctx);
 	} else if (rd[1] != ARM_R2) {
 		emit(ARM_ADD_I(ARM_SP, ARM_SP, 8), ctx);
 		emit(ARM_POP(BIT(ARM_R2) | BIT(ARM_R3)), ctx);
 	} else {
 		emit(ARM_ADD_I(ARM_SP, ARM_SP, 16), ctx);
 	}

Thanks,
Puranjay
