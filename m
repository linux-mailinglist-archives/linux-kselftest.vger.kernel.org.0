Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CABB77B800C
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Oct 2023 15:00:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233110AbjJDNAO (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 4 Oct 2023 09:00:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232939AbjJDNAN (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 4 Oct 2023 09:00:13 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2400EA1;
        Wed,  4 Oct 2023 06:00:10 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-9b974955474so12661466b.1;
        Wed, 04 Oct 2023 06:00:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696424408; x=1697029208; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=9LA3z81dm8x/8yLvFD8FRfA0jwHx+VnSKrEfLe84ZDY=;
        b=eP73tx2G+BpzSdyKlvYxvg3APQWb6H8s1JT3FCiMI7BCF3wMINdbB9lFYVlhPcra00
         iOjl2vWm5GAstFYnQTGBvSMDtPoeBYc2BNj79+KP9TrLU8K1IpUf7i6NEhYei5fim1Ia
         y6D6aME3ScHMEJ8makvD5wIV8Ug2k9snoILdggtwhpVtXlh1v2vZGXT9DXN1BuLYhlEq
         mvI8rc153zzfYgfwUGyd8Bd2TBeNGwbvHAVKG+JkWvSSd7yGKGcbUVv7ll9gMYIL7jxB
         jbB/tOG0iteJowgZrJrXULI4/0HihVjYcrPVt2ZO/h7gYcWN6pqrY3hEDwChMfZw/ok6
         UQvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696424408; x=1697029208;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9LA3z81dm8x/8yLvFD8FRfA0jwHx+VnSKrEfLe84ZDY=;
        b=rq0oqqbfNKYM5PpZBQ4kzvypyzAvsEeJGldOxZ4gsTZQDxoaSU6P29aYBjJx5DvMcF
         DYPi6gu5RO0wrc+HnnJV6SRjk7PEI5IhyU19K14XwmRq0/24RoZaP5YClte414NKU6D3
         JkM6KHsBZh1KSLg95qLHvbLsMNlGSNOixP86UrdKKeuEcq5Xeh7Rd4L/dQW5M249cakQ
         N/8Mhl0cHr7+7Wf8ztxjQDOy0vxkcUIp+XDvya119PO4FfWJJ6LDe2naxIjHZUYBdkmb
         SG9qnnTxIgSHR+BottoCzIDQo0OVPPPjaAc2m+8lf9gQqK0je/Oz3D1TiVpXEEKXsRh9
         SU4Q==
X-Gm-Message-State: AOJu0Yxe6zl3LdxXDQdhLUedI3ZRSIf3J9Egakar2heH/OWIkJwom1U2
        jJtdEKhZLUhGZFGaEBE9NhM=
X-Google-Smtp-Source: AGHT+IH8tyx7NrLsAWfLrTeFsQplGLPzPMsVk0D0fv5EBxxMQvFsWQwUjjUbM7H5o4zX0h2jhoXOiw==
X-Received: by 2002:a17:907:7850:b0:9a2:474:4aa0 with SMTP id lb16-20020a170907785000b009a204744aa0mr2184081ejc.48.1696424408174;
        Wed, 04 Oct 2023 06:00:08 -0700 (PDT)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id vi13-20020a170907d40d00b009b8a4f9f20esm1067025ejc.102.2023.10.04.06.00.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Oct 2023 06:00:07 -0700 (PDT)
From:   Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date:   Wed, 4 Oct 2023 15:00:05 +0200
To:     =?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@kernel.org>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Mykola Lysenko <mykolal@fb.com>, bpf@vger.kernel.org,
        netdev@vger.kernel.org,
        =?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@rivosinc.com>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: Re: [PATCH bpf-next 3/3] selftests/bpf: Add uprobe_multi to gen_tar
 target
Message-ID: <ZR1h1ZWrsH9dtCLN@krava>
References: <20231004122721.54525-1-bjorn@kernel.org>
 <20231004122721.54525-4-bjorn@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231004122721.54525-4-bjorn@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Oct 04, 2023 at 02:27:21PM +0200, Björn Töpel wrote:
> From: Björn Töpel <bjorn@rivosinc.com>
> 
> The uprobe_multi program was not picked up for the gen_tar target. Fix
> by adding it to TEST_GEN_FILES.
> 
> Signed-off-by: Björn Töpel <bjorn@rivosinc.com>

Acked-by: Jiri Olsa <jolsa@kernel.org>

thanks,
jirka


> ---
>  tools/testing/selftests/bpf/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
> index 098e32c684d5..07ac73cc339d 100644
> --- a/tools/testing/selftests/bpf/Makefile
> +++ b/tools/testing/selftests/bpf/Makefile
> @@ -104,7 +104,7 @@ TEST_GEN_PROGS_EXTENDED = test_sock_addr test_skb_cgroup_id_user \
>  	xskxceiver xdp_redirect_multi xdp_synproxy veristat xdp_hw_metadata \
>  	xdp_features
>  
> -TEST_GEN_FILES += liburandom_read.so urandom_read sign-file
> +TEST_GEN_FILES += liburandom_read.so urandom_read sign-file uprobe_multi
>  
>  # Emit succinct information message describing current building step
>  # $1 - generic step name (e.g., CC, LINK, etc);
> -- 
> 2.39.2
> 
> 
