Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 570ED78830B
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Aug 2023 11:09:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231379AbjHYJJN (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 25 Aug 2023 05:09:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244111AbjHYJIk (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 25 Aug 2023 05:08:40 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A3AF1FDF;
        Fri, 25 Aug 2023 02:08:27 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id 2adb3069b0e04-50043cf2e29so980461e87.2;
        Fri, 25 Aug 2023 02:08:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692954505; x=1693559305;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XGH+s8GQ40mAY7Hi7ApsqsxBdjwgwNJM3n/9eQfKme0=;
        b=hBNy8K0NdYE+g2rzEg13gMbP6TT+aNG2JduaqcPrtOdXXPc+jSJY9oDIlffzLUK0yJ
         lEmIcQv2ws72vXRM5LnszfoKMmnnKoxIhM7f92uW5ykpDzHWA+8h3JydgU/VAGVWOYL8
         Z8wp7/su8He2W1k+Seig/exREsn5NPCt1MKk57wK6puoslCuO7XJYz/seyYm7NPRU/aW
         QHwj1YqxUkp5Jg/z8E0jniCKTrszqisZnbn18w+hTNgZtPfN+M7dFbOJpSSHmV6s7Xdq
         Vx69d4Puk9drw9+rn2NffgaGzyT0cHRjX2JhF8HKSY+RZ727cIeNvQDm2PJsvuOMljgN
         7uyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692954505; x=1693559305;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XGH+s8GQ40mAY7Hi7ApsqsxBdjwgwNJM3n/9eQfKme0=;
        b=Tvu5XMdQ5gOSwet6bNcZuWEFEwlGuoZkPLLpkQJ6c/TKai7qe3I8ODnMg0bZgKRgFq
         LeZjjK7B4HCwar+nx23CZgUfrvMApy3HRLlO1dF3Rl6aGXapkzDDi0n+rbR2N4Rq1IKr
         9oCbC+2PrSk2IUgqJnG44K0WNlYbnbY5FvRFJB0HaoBKBrybLhEF9IhbJZqwfP+ADTI+
         Dk1ZwJhs8nnNvsiZYd4hZYSE9DIdVTKCM2lSrUQxzX5hxN5oyps5jszZ/Lwh69kwOi0A
         WO07CnXmHxMVcqCnju6DGI/iDrgfMbiAxHfZ2t0tWdlxzIQpq5QLoCMjWL/kiJW6gALQ
         sX4Q==
X-Gm-Message-State: AOJu0YxRhVCSd4OS6M/Q87W1DzT8X8X4Vd2VoNuom3etoQYN8i8ciD39
        Zp/R4xBmIW9K/w2htghxj5Y=
X-Google-Smtp-Source: AGHT+IGlMotjqDaVIjnPhJ0aBiH+sa14MKKRgk9Gr7+xNEBZbFXr0QcZClmRgTXLoibUTxZ/LbxPCw==
X-Received: by 2002:a05:6512:3b9e:b0:500:9a67:d40e with SMTP id g30-20020a0565123b9e00b005009a67d40emr6058180lfv.60.1692954505226;
        Fri, 25 Aug 2023 02:08:25 -0700 (PDT)
Received: from krava (ip-94-113-247-30.net.vodafone.cz. [94.113.247.30])
        by smtp.gmail.com with ESMTPSA id qo8-20020a170907212800b0099cd008c1a4sm739997ejb.136.2023.08.25.02.08.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Aug 2023 02:08:24 -0700 (PDT)
From:   Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date:   Fri, 25 Aug 2023 11:08:22 +0200
To:     Rong Tao <rtoax@foxmail.com>
Cc:     olsajiri@gmail.com, andrii@kernel.org, ast@kernel.org,
        bpf@vger.kernel.org, daniel@iogearbox.net, haoluo@google.com,
        john.fastabend@gmail.com, kpsingh@kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        martin.lau@linux.dev, mykolal@fb.com, rongtao@cestc.cn,
        sdf@google.com, shuah@kernel.org, song@kernel.org,
        yonghong.song@linux.dev
Subject: Re: [PATCH bpf-next v6] selftests/bpf: trace_helpers.c: optimize
 kallsyms cache
Message-ID: <ZOhvhnUTxtD6YYzl@krava>
References: <ZOMiqE0QY2Lrw2UC@krava>
 <tencent_492BE2E81E62BEC199106096C025954AFD06@qq.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_492BE2E81E62BEC199106096C025954AFD06@qq.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Aug 22, 2023 at 08:38:58AM +0800, Rong Tao wrote:
> > I think you need to fix this on samples/bpf side
> > 
> > I tried to play with the samples/bpf/ includes, but couldn't find a way to
> > make this work.. selftests base includes on tools/include, while samples
> > have $(objtree)/usr/include as first include and AFAICS the __must_check is
> > defined under __KERNEL__ ifdef
> > 
> > I guess the reason samples use $(objtree)/usr/include is to get some struct
> > definitions which are not in tools/include, but looks like some samples objects
> > already use vmlinux.h include, so that could be the way forward to fix that
> 
> I tried the method you suggested, and some unexpected problems occurred. Maybe,
> we can apply v5 [0] first, and then solve this problem?

how about change below, seem to work for me

jirka


---
diff --git a/samples/bpf/Makefile b/samples/bpf/Makefile
index 151ec320818b..3115f054dca7 100644
--- a/samples/bpf/Makefile
+++ b/samples/bpf/Makefile
@@ -316,6 +316,8 @@ XDP_SAMPLE_CFLAGS += -Wall -O2 \
 $(obj)/$(XDP_SAMPLE): TPROGS_CFLAGS = $(XDP_SAMPLE_CFLAGS)
 $(obj)/$(XDP_SAMPLE): $(src)/xdp_sample_user.h $(src)/xdp_sample_shared.h
 
+$(obj)/$(TRACE_HELPERS): TPROGS_CFLAGS := $(TPROGS_CFLAGS) -D__must_check=
+
 -include $(BPF_SAMPLES_PATH)/Makefile.target
 
 VMLINUX_BTF_PATHS ?= $(abspath $(if $(O),$(O)/vmlinux))				\
diff --git a/tools/testing/selftests/bpf/trace_helpers.c b/tools/testing/selftests/bpf/trace_helpers.c
index 316a7874a12b..551547ba6829 100644
--- a/tools/testing/selftests/bpf/trace_helpers.c
+++ b/tools/testing/selftests/bpf/trace_helpers.c
@@ -14,9 +14,6 @@
 #include <linux/limits.h>
 #include <libelf.h>
 #include <gelf.h>
-#ifndef __must_check
-#define __must_check
-#endif
 #include "bpf/libbpf_internal.h"
 
 #define TRACEFS_PIPE	"/sys/kernel/tracing/trace_pipe"
