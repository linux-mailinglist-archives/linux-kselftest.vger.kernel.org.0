Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69CBF58F3DE
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Aug 2022 23:34:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231820AbiHJVd5 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 10 Aug 2022 17:33:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbiHJVd4 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 10 Aug 2022 17:33:56 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55C984B4A5;
        Wed, 10 Aug 2022 14:33:56 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id q9-20020a17090a2dc900b001f58bcaca95so3456550pjm.3;
        Wed, 10 Aug 2022 14:33:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=S2SNY55FOS+4M1mNfoZqilCfP2TWhwI3D0z0ZaiahwA=;
        b=HERmc5TzADuBX1uNIWqHPP+KIg08pmSu7CoH6wlu25tcFGvFKH+r0nDKuug4hj6Szv
         QRwIgpWOy4aRnWWJs3mHUYWwjD7qbSASZ/BN6GKRarYwtMOScuRGLNCHN/yX1DoUxX0x
         mZdtExZSimMYj86a7MfQZwaKVTIlMyPe5HHynSDoXM9SDi4qxMYBdwVMF+D/bjq5oiZA
         rVTufHnZ6wOcm+bQ6/4SN9VtMLb4XjuyPemRi/42jnP0sGdvsYLwR0PAYSg8P8U0a4hp
         An4xi4VAKas0dXAPa/15LoKCABIoUrR2IVf49mozCfKxAtKDSPn1vHp+Jk6wLdA4g7Ld
         iNJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=S2SNY55FOS+4M1mNfoZqilCfP2TWhwI3D0z0ZaiahwA=;
        b=DWT268tJQpXGo0n4SMf8YR2ud1xo3NL4k0bGsvR0FG/Fa5KEMNhBalvoLILXdDEHY7
         74Vg1aMEn7/QMvtN063iCnHc04f5ptAGO3aSu+tXUw6EyP3ExdR2C7SR+rSz/YjT0fFA
         oPxm9O0C9sVHdEtTjxFNqscrgPTZc09bHpJd716LuaN4Vp1ymD839K2WrKQYJaFNHQtt
         ESMBTXxbcA/B4yZe9i3dENnO9tqbhDjCQGj3XuI1FI93u1gEbsEgKZJza5MdwbhfPSCU
         XIoac5A3NUyTTEqJFXIuh6B9Y8iBzZFWj5AH1tXZVlqKYN5sthzSLUR/s71LakV4owaN
         HHvA==
X-Gm-Message-State: ACgBeo2G2EIarPS2ap4NXVTmnuFslLoKMlvpn8oT9KfIouQFJgukbcG5
        m1fF7xeIcTw6y5WnTLkhtk0=
X-Google-Smtp-Source: AA6agR4vGuIYLa/x3kbGUsZP3kOhUbWEfHeH4LcRFsunnkDnxEh9oqqwSziLnMtDJ67zN0PNnE71gw==
X-Received: by 2002:a17:902:f144:b0:170:89eb:a16e with SMTP id d4-20020a170902f14400b0017089eba16emr22253171plb.7.1660167235706;
        Wed, 10 Aug 2022 14:33:55 -0700 (PDT)
Received: from MacBook-Pro-3.local.dhcp.thefacebook.com ([2620:10d:c090:500::1:762f])
        by smtp.gmail.com with ESMTPSA id q16-20020aa79830000000b0052c4b3e6f6asm2536687pfl.97.2022.08.10.14.33.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Aug 2022 14:33:55 -0700 (PDT)
Date:   Wed, 10 Aug 2022 14:33:51 -0700
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Roberto Sassu <roberto.sassu@huawei.com>
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, corbet@lwn.net,
        dhowells@redhat.com, jarkko@kernel.org, rostedt@goodmis.org,
        mingo@redhat.com, paul@paul-moore.com, jmorris@namei.org,
        serge@hallyn.com, shuah@kernel.org, bpf@vger.kernel.org,
        linux-doc@vger.kernel.org, keyrings@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v10 5/9] bpf: Add bpf_lookup_*_key() and bpf_key_put()
 kfuncs
Message-ID: <20220810213351.wm5utltm67q4i6lu@MacBook-Pro-3.local.dhcp.thefacebook.com>
References: <20220810165932.2143413-1-roberto.sassu@huawei.com>
 <20220810165932.2143413-6-roberto.sassu@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220810165932.2143413-6-roberto.sassu@huawei.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Aug 10, 2022 at 06:59:28PM +0200, Roberto Sassu wrote:
> +
> +static int __init bpf_key_sig_kfuncs_init(void)
> +{
> +	int ret;
> +
> +	ret = register_btf_kfunc_id_set(BPF_PROG_TYPE_TRACING,
> +					&bpf_key_sig_kfunc_set);
> +	if (!ret)
> +		return 0;
> +
> +	return register_btf_kfunc_id_set(BPF_PROG_TYPE_LSM,
> +					 &bpf_key_sig_kfunc_set);

Isn't this a watery water ?
Don't you have a patch 1 ?
What am I missing ?
