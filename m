Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB4E3528CD6
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 May 2022 20:24:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232444AbiEPSYW (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 16 May 2022 14:24:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344743AbiEPSYW (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 16 May 2022 14:24:22 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 501D731935
        for <linux-kselftest@vger.kernel.org>; Mon, 16 May 2022 11:24:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652725460;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=id00oVYTmyhqPqdSLuA7jfzPXEfe8AjRZdJymH4RAy0=;
        b=bX8tF82w9dkyyRhvWaPIRS4ZOl/ie90iv+kb7w0md3oHqBbzrFBxileahPRdtAlnc8WbFh
        5lFVrpb+EVqslJhgnTFZHLHuSVsOHibdK+rWDP8B4HFm+x/cvhlL/6CgmgQ2paWTaIrXd0
        JTh7I8VYtoXjCrNUMsCDNhGqenNUTlk=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-425-1c6qYXoiM3aIcpzbJ6od5Q-1; Mon, 16 May 2022 14:24:14 -0400
X-MC-Unique: 1c6qYXoiM3aIcpzbJ6od5Q-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C9167382ECC8;
        Mon, 16 May 2022 18:24:13 +0000 (UTC)
Received: from asgard.redhat.com (unknown [10.36.110.3])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 61FD7153B8AC;
        Mon, 16 May 2022 18:24:10 +0000 (UTC)
Date:   Mon, 16 May 2022 20:24:07 +0200
From:   Eugene Syromiatnikov <esyr@redhat.com>
To:     Jiri Olsa <jolsa@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc:     Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>, netdev@vger.kernel.org,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: [PATCH bpf 0/4] Fix 32-bit arch and compat support for the
 kprobe_multi attach type
Message-ID: <20220516182407.GA15250@asgard.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.7
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

As suggested in [1], the kprobe_multi interface is to be fixed for 32-bit
architectures and compat, rather then disabled.  As it turned out,
there are a couple of additional problems that are to be addressed:
 - the absence of size overflow checks, leading to possible
   out-of-bounds writes (addressed by the first patch);
 - the assumption that long has the same size as u64, which would make
   cookies arrays size calculation incorrect on 32-bit architectures
   (addressed by the second patch);
 - the addrs array passing API, that is incompatible with compat and has
   to be changed (addressed in the fourth patch): those are kernel
   addresses and not user ones (as was incorrectly stated in [2]);
   this change is only semantical for 64-bit user/kernelspace,
   so it shouldn't impact ABI there, at least.

[1] https://lore.kernel.org/lkml/CAADnVQ+2gwhcMht4PuDnDOFKY68Wsq8QFz4Y69NBX_TLaSexQQ@mail.gmail.com/
[2] https://lore.kernel.org/lkml/20220510184155.GA8295@asgard.redhat.com/

Eugene Syromiatnikov (4):
  bpf_trace: check size for overflow in bpf_kprobe_multi_link_attach
  bpf_trace: support 32-bit kernels in bpf_kprobe_multi_link_attach
  bpf_trace: handle compat in kprobe_multi_resolve_syms
  bpf_trace: pass array of u64 values in kprobe_multi.addrs

 kernel/trace/bpf_trace.c                           | 63 ++++++++++++++++------
 tools/lib/bpf/bpf.h                                |  2 +-
 tools/lib/bpf/libbpf.c                             |  8 +--
 tools/lib/bpf/libbpf.h                             |  2 +-
 .../testing/selftests/bpf/prog_tests/bpf_cookie.c  |  2 +-
 .../selftests/bpf/prog_tests/kprobe_multi_test.c   |  2 +-
 6 files changed, 54 insertions(+), 25 deletions(-)

-- 
2.1.4

