Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CD5C793BA6
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Sep 2023 13:47:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231566AbjIFLrV (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 6 Sep 2023 07:47:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240041AbjIFLrU (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 6 Sep 2023 07:47:20 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E93ECF;
        Wed,  6 Sep 2023 04:47:16 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-402d0eda361so27190275e9.0;
        Wed, 06 Sep 2023 04:47:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694000835; x=1694605635; darn=vger.kernel.org;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=F2eaACEiwNOBR0CmXxKwHpPHw6vWE8V2R0NQnhuogoY=;
        b=W4D/cC4VJ14Y1xB89+3FtPGZzzJIAWnp6l3thrFTiJKihIL03TKUCCxLpY5yZc+YJV
         FpqKAqAhU5cbLip6m/PqEH00wgBiDVmLM5WubUSIFLNoI5nbl8gz8ONSGr5MMXEdO5jT
         OncXQV4C+Fk4EBFmN8GRS6RcgWdt8soY/72QwsAkiH8t1ivvEIUd0/cHFkcykdPSz7g1
         udMyBiB/4w6dQXFYwLQEjwzoBkBk8xQfWoDjxY2ESMk2aMZmqOyeJx2hTvVYHqZNPGXr
         7dOL0Uu2PhmbT1cQgnjDr3UlSyRaTCVYZp3KUepI7e6Fs71BKCCGxNRda8Q/WcaCtmcz
         9SYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694000835; x=1694605635;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F2eaACEiwNOBR0CmXxKwHpPHw6vWE8V2R0NQnhuogoY=;
        b=DujKGuEhG11YABMgM14thEPWqEVrYe6GM84yuKDv0GXwd5HfK1qYq3ROPpqZ64Tvl/
         TjaA9ahrI19TMUSyWp8JPa4rmLD9ww5XxrMJ0vHB60YQ9STawu6X/V44uzE/xIBG14ZW
         QY7O8D8Nj22eENkv2mFSiHmTfh7WrI9LUbYA23OSIuaotEuBBLBAFyF3jBut8DMb0D6Q
         cC9quG7awUhVH7WA7QXT/A1NfS4mqrKQJBXc1s4hExDLNDdNBJ1XyJf0MtfF+UMqgXP9
         8oUXnzVvGfa0A/6adpI7TLMcUBk2tLOvYbQ/yhMzRvfj9YZtflnHjWVPeRlhXZOqwE1D
         kdvg==
X-Gm-Message-State: AOJu0YwcQLcXS2KGzIQ10u5+Kiz+GdPg8JWk2QyIi02iuTWx1dG/0Ypj
        y+y2hIUL1kn9GOlh/74fk9OBp6FUwkP6MgUoMjY=
X-Google-Smtp-Source: AGHT+IF7nE1PrmxOMYf+opmJ2sQuwLT6cnLGUFRdZDtVVjfaLeR9Nl2nQuhAwy3jvGoBLrr5FVI5Uw==
X-Received: by 2002:a7b:cb8c:0:b0:3fe:22a9:907 with SMTP id m12-20020a7bcb8c000000b003fe22a90907mr1959689wmi.20.1694000834248;
        Wed, 06 Sep 2023 04:47:14 -0700 (PDT)
Received: from dev-dsk-pjy-1a-76bc80b3.eu-west-1.amazon.com (54-240-197-231.amazon.com. [54.240.197.231])
        by smtp.gmail.com with ESMTPSA id bt9-20020a056000080900b0031c5ce91ad6sm16328019wrb.97.2023.09.06.04.47.13
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Sep 2023 04:47:13 -0700 (PDT)
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
Subject: Re: [PATCH bpf-next 2/8] arm32, bpf: add support for sign-extension
 load instruction
References: <20230905210621.1711859-1-puranjay12@gmail.com>
        <20230905210621.1711859-3-puranjay12@gmail.com>
        <ZPeceR+qKgsedJ1H@shell.armlinux.org.uk>
Date:   Wed, 06 Sep 2023 11:47:13 +0000
In-Reply-To: <ZPeceR+qKgsedJ1H@shell.armlinux.org.uk> (Russell King's message
        of "Tue, 5 Sep 2023 22:24:09 +0100")
Message-ID: <mb61pfs3r34n2.fsf@amazon.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Sep 05 2023, Russell King (Oracle) wrote:

[...]
>> +/* dst = *(signed size*)(src + off) */
>> +static inline void emit_ldsx_r(const s8 dst[], const s8 src,
>> +			       s16 off, struct jit_ctx *ctx, const u8 sz){
>> +	const s8 *tmp = bpf2a32[TMP_REG_1];
>> +	const s8 *rd = is_stacked(dst_lo) ? tmp : dst;
>> +	s8 rm = src;
>> +
>> +	if (!is_ldst_imm8(off, sz)) {
>> +		emit_a32_mov_i(tmp[0], off, ctx);
>> +		emit(ARM_ADD_R(tmp[0], tmp[0], src), ctx);
>
> Hmm. This looks inefficient when "off" is able to fit in an immediate.
> Please try:
>
> 	int add_off;
>
> 	if (!is_ldst_imm8(off, sz)) {
> 		add_off = imm8m(off);
> 		if (add_off > 0) {
> 			emit(ARM_ADD_I(tmp[0], src, add_off), ctx);
> 			rm = tmp[0];
> 		} else {
> 			emit_a32_mov_i(tmp[0], off, ctx);
> 			emit(ARM_ADD_R(tmp[0], tmp[0], src), ctx);
> 			rm = tmp[0];
> 		}
> 		off = 0;
>> +	} else if (rd[1] == rm) {
>> +		emit(ARM_MOV_R(tmp[0], rm), ctx);
>> +		rm = tmp[0];
>
> Why do you need this? rd and rm can be the same for LDRS[BH].

I agree that this is not required, will remove in the next version.
Will also use the suggested optimization for immediate.

>> +	}
>> +	switch (sz) {
>> +	case BPF_B:
>> +		/* Load a Byte with sign extension*/
>> +		emit(ARM_LDRSB_I(rd[1], rm, off), ctx);
>> +		/* Carry the sign extension to upper 32 bits */
>> +		emit(ARM_ASR_I(rd[0], rd[1], 31), ctx);
>> +		break;
>> +	case BPF_H:
>> +		/* Load a HalfWord with sign extension*/
>> +		emit(ARM_LDRSH_I(rd[1], rm, off), ctx);
>> +		/* Carry the sign extension to upper 32 bits */
>> +		emit(ARM_ASR_I(rd[0], rd[1], 31), ctx);
>> +		break;
>> +	case BPF_W:
>> +		/* Load a Word*/
>> +		emit(ARM_LDR_I(rd[1], rm, off), ctx);
>> +		/* Carry the sign extension to upper 32 bits */
>> +		emit(ARM_ASR_I(rd[0], rd[1], 31), ctx);
>
> The last instruction extending to the upper 32 bits is the same in each
> of these cases, so is there any reason not to do it outside the switch
> statement?

Will move it outside in the next version.


Thanks,
Puranjay

