Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03ADC7943C0
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Sep 2023 21:20:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241186AbjIFTUE (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 6 Sep 2023 15:20:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229974AbjIFTT5 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 6 Sep 2023 15:19:57 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE5B719AB;
        Wed,  6 Sep 2023 12:19:53 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-401f68602a8so2181105e9.3;
        Wed, 06 Sep 2023 12:19:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694027992; x=1694632792; darn=vger.kernel.org;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NJQb5Q/N8QCDXHak4HbkHfzYNqWs5Nggb+jewixNoe0=;
        b=PQ1jMrco8TtG9bqtZcrHFCa++LrVe37I/Um/GkREuoQddfXdfgj6lKS9H2FvSXSbjM
         l92xPK/D/eOS8orzvRsr79RQ5pw3t14FYSGSq6yIdOrjmOnKlJD5z0ceOcHzDWN4gEa3
         vhv2C/L2U+RsaAWKUXCyogR7UWGGa/NXn1G3LLK1ud7Vhov10HZk3UUyQYzFCTNVYIDI
         sxOTHp3z0+ss7xmtEfvd3c9RNEnMlWcaciufQui6BiBUchZGyB3HL6e9diP1m7EuWD+i
         3kXW84eGRgYHoeVbKxxK+moOU4SIqla4TZ30JomH1jhOLfJ7qoL9Iz7TsT4pprAtJI4k
         gKow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694027992; x=1694632792;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NJQb5Q/N8QCDXHak4HbkHfzYNqWs5Nggb+jewixNoe0=;
        b=h5/7D35U/wJURCq3wBR9s0JGBCnm+ynE4SXM/lg6W1lOQPfDMnutRbTsIQW7JzNrA9
         g+5DJ6W0/lVwPnOBIxukjIpN0kn0G1dnBjyAETpojdnrm3rn/FvUT88jEcI3+QNMtleW
         GwbwKoRsJ4bUQ2DZX/PP3yjZWS0nTxyZWNNPmZzppusI28Z39bFxusGDhy30wk2d2lee
         Subzks3h0JohiNuB+V4VY4OBQUig/noseCQAKC1oUKOPma3Cbb1ImCEUQZ76M9bJxtGy
         6DNEyfqarq4AmenSkljVwRt8lvHCPthJNgcU7CVTY8EVEBI1XS+5zwlHQKeog/+lwzIU
         RLOg==
X-Gm-Message-State: AOJu0Yzt/D/uhyK0Df2C5tyNMEV3zuzKEGFvuqJ2tS+y6/NXHQp7dX3E
        goOfemGiLb9VyEcw41tRrfIAuCLoJ3DLEzaMwX4=
X-Google-Smtp-Source: AGHT+IFKv9dh+dX10+Kfl6M2hk6O+saoK3aeQkDet8liAArxOF/5rxY/sw8kdEw/4opz1PHWRIPg/w==
X-Received: by 2002:a1c:6a18:0:b0:3fe:d1b9:7ea9 with SMTP id f24-20020a1c6a18000000b003fed1b97ea9mr2945310wmc.36.1694027991739;
        Wed, 06 Sep 2023 12:19:51 -0700 (PDT)
Received: from dev-dsk-pjy-1a-76bc80b3.eu-west-1.amazon.com (54-240-197-231.amazon.com. [54.240.197.231])
        by smtp.gmail.com with ESMTPSA id v8-20020a05600c214800b00401c9228bf7sm366544wml.18.2023.09.06.12.19.50
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Sep 2023 12:19:51 -0700 (PDT)
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
        <ZPein8oS5egqGwzp@shell.armlinux.org.uk> <mb61po7if3b0w.fsf@amazon.com>
        <ZPjLSHG7JToLWvmT@shell.armlinux.org.uk>
Date:   Wed, 06 Sep 2023 19:19:50 +0000
In-Reply-To: <ZPjLSHG7JToLWvmT@shell.armlinux.org.uk> (Russell King's message
        of "Wed, 6 Sep 2023 19:56:08 +0100")
Message-ID: <mb61p8r9j2jop.fsf@amazon.com>
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

On Wed, Sep 06 2023, Russell King (Oracle) wrote:

> On Wed, Sep 06, 2023 at 09:29:19AM +0000, Puranjay Mohan wrote:
>> On Tue, Sep 05 2023, Russell King (Oracle) wrote:
>> 
>> > On Tue, Sep 05, 2023 at 09:06:19PM +0000, Puranjay Mohan wrote:
>> Actually, there can also be a situation where rd[1] != ARM_R0 && rd[1] != ARM_R2,
>> so should I do it like:
>> 
>>  	if (rd[1] != ARM_R0 && rd[1] != ARM_R2) {
>>  		emit(ARM_POP(BIT(ARM_R0) | BIT(ARM_R1)), ctx);
>>  		emit(ARM_POP(BIT(ARM_R2) | BIT(ARM_R3)), ctx);      
>>  	} else if (rd[1] != ARM_R0) {
>>  		emit(ARM_POP(BIT(ARM_R0) | BIT(ARM_R1)), ctx);
>>  		emit(ARM_ADD_I(ARM_SP, ARM_SP, 8), ctx);
>>  	} else if (rd[1] != ARM_R2) {
>>  		emit(ARM_ADD_I(ARM_SP, ARM_SP, 8), ctx);
>>  		emit(ARM_POP(BIT(ARM_R2) | BIT(ARM_R3)), ctx);
>>  	} else {
>>  		emit(ARM_ADD_I(ARM_SP, ARM_SP, 16), ctx);
>>  	}
>
> Are you sure all four states are possible?

ohh!

I just realized that the last else will never run.
rd[1] can never be equal to both ARM_R0 and ARM_R2.
Will fix it in V3 as I already sent out the V2.

I need to learn to leave patches on the list for few days before re-spinning.

Thanks,
Puranjay
