Return-Path: <linux-kselftest+bounces-1832-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D1EB98113BF
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Dec 2023 14:54:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0FB1B1C2103F
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Dec 2023 13:54:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 567A72D7B5;
	Wed, 13 Dec 2023 13:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="A95HT764"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B21F71717
	for <linux-kselftest@vger.kernel.org>; Wed, 13 Dec 2023 05:52:56 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-40b5155e154so79402385e9.3
        for <linux-kselftest@vger.kernel.org>; Wed, 13 Dec 2023 05:52:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1702475536; x=1703080336; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PTROWi090VipJqK8OYHPEAxaQ5DHXWxJFjKYJmaz5R0=;
        b=A95HT764fiLL7ms92fZISKQ35BNeohhRyD+oaUKWGxBw1YEqGqwmU1Cc9qFBwgqdpu
         /mls630FnXkQLDq+D8z84e7jiizeAEGeCE0efZgncB8C1iY3VnjaM2KrYMM7cazWXnPZ
         vozpm0lqRTm5unbu7CyBTudS/d7rxmGZl4NErYy3zwp/QGMNOudxLi7e+okNuzX52SSe
         rFfdqGOzvI1kALr0KPWk4A+PJMOBSzCzSK1YWfPJEQ2sFqngOzC4YrILmRQBmxYGxHSr
         Ttj9NnKWU8MdAO3/JEFZiTqTvYBJTwgqcLv+Tfyeu+aqPOlkeR8tYmRn2aTvudWxpynO
         4E9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702475536; x=1703080336;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PTROWi090VipJqK8OYHPEAxaQ5DHXWxJFjKYJmaz5R0=;
        b=kirsUvWoKDV7+N9yyCiG9tksllTUIO1RlvvAFAiLeYMwUBE+9/eADsx5e/hnBhamcs
         b5uDkl77+Ao4YGpWVV8X2RpMciNOF6uAUQWIGYGZxBUJgNI3tmKf8uw9yvoSUMCXwxdi
         vuHXyO+My5ZypKpPaBySJdakjm6sS8VGANpVhS96nm7YO/BEwPdBmJQrJrJONi5mMsDG
         fXih5iBU6nXyZ5T6OxhSi+bOHPOMBHVMCaQLRy6DJG+39WrDzNYOSRM98/dJ72bBnwyU
         cl/dWIKdbnznXk60h0LIuI31NZgYymGRPe78DeDWK0hfNbi6lVloqEfzEPSCnsGAU/AN
         PtiQ==
X-Gm-Message-State: AOJu0Yymw0laZySndu3qVVs+SdGid5CnDoJjNarJ13KLzXr55j0ULAVj
	OhGI+CH1wGi5t985Y/Lt/A37kw==
X-Google-Smtp-Source: AGHT+IF5kmk8LVZ85W7N3gISbpDLPY8LvD+Hn6K1kJJ6Gm74g8cpX+vaNl8XPZV2r1+Itxbw0xZgcg==
X-Received: by 2002:a05:600c:220f:b0:40c:2100:60b1 with SMTP id z15-20020a05600c220f00b0040c210060b1mr3672409wml.178.1702475536469;
        Wed, 13 Dec 2023 05:52:16 -0800 (PST)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
        by smtp.gmail.com with ESMTPSA id s13-20020a05600c384d00b004030e8ff964sm22836432wmr.34.2023.12.13.05.52.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Dec 2023 05:52:16 -0800 (PST)
Date: Wed, 13 Dec 2023 14:52:15 +0100
From: Andrew Jones <ajones@ventanamicro.com>
To: Haibo Xu <haibo1.xu@intel.com>
Cc: xiaobo55x@gmail.com, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>, Marc Zyngier <maz@kernel.org>, 
	Oliver Upton <oliver.upton@linux.dev>, James Morse <james.morse@arm.com>, 
	Suzuki K Poulose <suzuki.poulose@arm.com>, Zenghui Yu <yuzenghui@huawei.com>, 
	Anup Patel <anup@brainfault.org>, Atish Patra <atishp@atishpatra.org>, Guo Ren <guoren@kernel.org>, 
	Conor Dooley <conor.dooley@microchip.com>, Mayuresh Chitale <mchitale@ventanamicro.com>, 
	Greentime Hu <greentime.hu@sifive.com>, wchen <waylingii@gmail.com>, Jisheng Zhang <jszhang@kernel.org>, 
	Samuel Holland <samuel@sholland.org>, Minda Chen <minda.chen@starfivetech.com>, 
	Sean Christopherson <seanjc@google.com>, Like Xu <likexu@tencent.com>, Peter Xu <peterx@redhat.com>, 
	Vipin Sharma <vipinsh@google.com>, Thomas Huth <thuth@redhat.com>, 
	Aaron Lewis <aaronlewis@google.com>, Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>, 
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, kvm@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
	kvm-riscv@lists.infradead.org
Subject: Re: [PATCH v4 03/11] KVM: selftests: Add CONFIG_64BIT definition for
 the build
Message-ID: <20231213-b7a894416841716b792da2d5@orel>
References: <cover.1702371136.git.haibo1.xu@intel.com>
 <227b86955b24583b5cacedc8480e8f5d7e4fabf8.1702371136.git.haibo1.xu@intel.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <227b86955b24583b5cacedc8480e8f5d7e4fabf8.1702371136.git.haibo1.xu@intel.com>

On Tue, Dec 12, 2023 at 05:31:12PM +0800, Haibo Xu wrote:
> Since only 64bit KVM selftests were supported on all architectures,
> add the CONFIG_64BIT definition in kvm/Makefile to ensure only 64bit
> definitions were available in the corresponding included files.
> 
> Suggested-by: Andrew Jones <ajones@ventanamicro.com>
> Signed-off-by: Haibo Xu <haibo1.xu@intel.com>
> ---
>  tools/testing/selftests/kvm/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/kvm/Makefile b/tools/testing/selftests/kvm/Makefile
> index 4838ea899bbb..bb03e278a163 100644
> --- a/tools/testing/selftests/kvm/Makefile
> +++ b/tools/testing/selftests/kvm/Makefile
> @@ -225,7 +225,7 @@ else
>  LINUX_TOOL_ARCH_INCLUDE = $(top_srcdir)/tools/arch/$(ARCH)/include
>  endif
>  CFLAGS += -Wall -Wstrict-prototypes -Wuninitialized -O2 -g -std=gnu99 \
> -	-Wno-gnu-variable-sized-type-not-at-end -MD\
> +	-Wno-gnu-variable-sized-type-not-at-end -MD -DCONFIG_64BIT \
>  	-fno-builtin-memcmp -fno-builtin-memcpy -fno-builtin-memset \
>  	-fno-builtin-strnlen \
>  	-fno-stack-protector -fno-PIE -I$(LINUX_TOOL_INCLUDE) \
> -- 
> 2.34.1
>

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>

