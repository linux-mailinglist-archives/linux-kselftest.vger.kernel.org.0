Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B23BA78010B
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Aug 2023 00:32:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346131AbjHQWbz (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 17 Aug 2023 18:31:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355817AbjHQWbu (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 17 Aug 2023 18:31:50 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4B823590;
        Thu, 17 Aug 2023 15:31:49 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1bdbf10333bso2656895ad.1;
        Thu, 17 Aug 2023 15:31:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692311509; x=1692916309;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FZEzx/BglPtyuNXga5z6ZOvALGdPR3nROuhrA48CEhQ=;
        b=VgdQi0wb+QcqqKFEK32EQETLpGKr94hILCEzMs+ya4wgLVbMBxZLweILHxpTWUNT29
         wnDZxPQJjysDQ8Pzpm9/L9thmavJvPhTroxZd4fuWSlP9NoAJDe/dSgAtu4jpw5piPiq
         /TqauBKuM0QcOnovn0zauAsvmZqfGQJvoARPSKSNZ0INCbpVBuhiWjzthW2DZ3uHuoAZ
         jrslOjG6Psob7Obghhzc47zrqRhaeLRRAm3EbeN226r0qerv9MT9YlaARsR+p0bRMhsR
         gzAb2gC7d5EcO0wBi/6aOqUTzWhgUfyYFVqI4yOKFGdrTwThrlRvBIHdY6V7U7udtNKo
         wPfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692311509; x=1692916309;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FZEzx/BglPtyuNXga5z6ZOvALGdPR3nROuhrA48CEhQ=;
        b=K63QjKxC2z4vurlAuFAMKaCkElm3kG0NGu0TGzcqF/MSw958hIppBXKTQy7BcG9Vj+
         RVIAj2IdQf4FrjYT38Z5W8YtjVtb4/b8eU+ItHZ+k6GQFmdhg4O/ZxkRJduvBT+pXIbG
         GntwG07ua4oyor8ZdaQ2B3pI8JV1F1Yv9yGrcOLcDlP6IlGRVHM8E+dRbPMjy5ftD9yB
         hase1gxQP6NklLlNQptcvsHKtAYKpnShT1Whv+E+7uTcyYXKXsmKAvq8f4llMuBrjEPc
         Ny2J3mPrONQ9RQfAnrFYjss62eCNGx90MJDCGLwfdQiYvrW8WeWLpEHBTifmwbcaQbv+
         5xvQ==
X-Gm-Message-State: AOJu0YwvnL4lRzC2x7VtGVBJgnQkR3YcOvBO96xYByeqVMQmbMfMKv2R
        H8oiJOvNiNPhVEaXRMzE7Ug=
X-Google-Smtp-Source: AGHT+IFpMhFHbdHJblnyyng0Ai8C8bEUNnlFfR7MeAyCIH06kdI3U/lM3NwBzp3uHHBzLf9bl0T1bQ==
X-Received: by 2002:a17:903:2310:b0:1bc:6c8:cde3 with SMTP id d16-20020a170903231000b001bc06c8cde3mr963298plh.57.1692311508914;
        Thu, 17 Aug 2023 15:31:48 -0700 (PDT)
Received: from macbook-pro-8.dhcp.thefacebook.com ([2620:10d:c090:500::4:8d88])
        by smtp.gmail.com with ESMTPSA id iy20-20020a170903131400b001bc18e579aesm274111plb.101.2023.08.17.15.31.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Aug 2023 15:31:48 -0700 (PDT)
Date:   Thu, 17 Aug 2023 15:31:43 -0700
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Leon Hwang <hffilwlqm@gmail.com>
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
Subject: Re: [RFC PATCH bpf-next 1/2] bpf, x64: Fix tailcall infinite loop bug
Message-ID: <20230817223143.jyclrtf3a6kmtgh5@macbook-pro-8.dhcp.thefacebook.com>
References: <20230814134147.70289-1-hffilwlqm@gmail.com>
 <20230814134147.70289-2-hffilwlqm@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230814134147.70289-2-hffilwlqm@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Aug 14, 2023 at 09:41:46PM +0800, Leon Hwang wrote:
> @@ -1147,6 +1152,7 @@ struct bpf_attach_target_info {
>  	struct module *tgt_mod;
>  	const char *tgt_name;
>  	const struct btf_type *tgt_type;
> +	bool tail_call_ctx;

Instead of extra flag here can you check tgt_prog->aux->tail_call_reachable in check_attach_btf_id()
and set tr->flags there?
Other than this the fix makes sense.
Please trim your cc list when you respin.
Just maintainers, Maciej (author of fixes tag) and bpf@vger is enough.
