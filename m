Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5573C7633B7
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Jul 2023 12:30:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233117AbjGZKaP (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 26 Jul 2023 06:30:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231817AbjGZKaO (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 26 Jul 2023 06:30:14 -0400
Received: from mail-vk1-xa2d.google.com (mail-vk1-xa2d.google.com [IPv6:2607:f8b0:4864:20::a2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6389F211C
        for <linux-kselftest@vger.kernel.org>; Wed, 26 Jul 2023 03:30:12 -0700 (PDT)
Received: by mail-vk1-xa2d.google.com with SMTP id 71dfb90a1353d-4864b490e2dso320476e0c.1
        for <linux-kselftest@vger.kernel.org>; Wed, 26 Jul 2023 03:30:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google; t=1690367411; x=1690972211;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=CTp3lWOa4enqnnJtPatmpsbCOMEyt2QR5UoDl0egg08=;
        b=U53wjrNbnX2OBR176Yur6xYn3E/JYdgMSR+16BeKehlz0f5fhbA4/Eg+atl6iREs1s
         3hd1bGwS0oYOzjB09zMamrTE4lmrgLW5QinZEx0HkqXXHB6+U0DeoMK4QtsOMtoslD42
         1m2x7JeviSkT+6a0DDmtk3352V5vC2zODwSo0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690367411; x=1690972211;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CTp3lWOa4enqnnJtPatmpsbCOMEyt2QR5UoDl0egg08=;
        b=G2teHr1TYOXh/XqMwqi0pnSCw6VMNXMYT8kGJLN7EDDujan/yyOYSUrBNEBaX3JeJQ
         E2AahvyRaSnztgOH+vltYo64v4IeZbAJ9oiLj9WHxjW5ACTNRt+VgP59Q5QU9TT9CY5F
         Pwyi4hSGAbWfXzAdukeVeh2fWAwIy1YILETWX5PvSGNg/feeV1YrvSv0rzvZof00CSy9
         g5diLzc5ukIXLIt6jKXjflMrWktm60Va9HkHQn7SpFIEAjglxEADY2Y7TGoV2CDhEDN9
         j5NjqOrKj51Ddi0iHErxov168EX0BcKUhQBvTTn8Xs4taMLPqA3Wuo9tCIomTeELOv+a
         1A6w==
X-Gm-Message-State: ABy/qLZOwOZEQoym/I1BUO0dr+Iip150qm9irc9gQEiRdpI82NW/t3QR
        eb1+jGScfQnGcgEX2lmbMx+SnA==
X-Google-Smtp-Source: APBJJlHQAi72WGV2GbGe8wvaVLOW245nW2auiZg9IEQZ6jnW7cUxgb+TrfgWpmozA/5rJdkpi3JzsQ==
X-Received: by 2002:a1f:4ac4:0:b0:46e:7558:a45c with SMTP id x187-20020a1f4ac4000000b0046e7558a45cmr836922vka.8.1690367411455;
        Wed, 26 Jul 2023 03:30:11 -0700 (PDT)
Received: from debian.debian ([140.141.197.139])
        by smtp.gmail.com with ESMTPSA id h9-20020a0cab09000000b0063019b482f8sm1479020qvb.85.2023.07.26.03.30.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jul 2023 03:30:10 -0700 (PDT)
Date:   Wed, 26 Jul 2023 03:30:08 -0700
From:   Yan Zhai <yan@cloudflare.com>
To:     Markus Elfring <Markus.Elfring@web.de>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Hao Luo <haoluo@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Jakub Sitnicki <jakub@cloudflare.com>,
        Jiri Olsa <jolsa@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Jordan Griege <jgriege@cloudflare.com>,
        KP Singh <kpsingh@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Mykola Lysenko <mykolal@fb.com>,
        Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>,
        Song Liu <song@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Yonghong Song <yhs@fb.com>, bpf@vger.kernel.org,
        kernel-janitors@vger.kernel.org, kernel-team@cloudflare.com,
        linux-kselftest@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH v4 bpf 2/2] bpf: selftests: add lwt redirect regression
 test cases
Message-ID: <ZMD1sFTW8SFiex+x@debian.debian>
References: <cover.1690332693.git.yan@cloudflare.com>
 <9c4896b109a39c3fa088844addaa1737a84bbbb5.1690332693.git.yan@cloudflare.com>
 <3ec61192-c65c-62cc-d073-d6111b08e690@web.de>
 <CAO3-PbraNcfQnqHUG_992vssuA795RxtexYsMdEo=k9zp-XHog@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAO3-PbraNcfQnqHUG_992vssuA795RxtexYsMdEo=k9zp-XHog@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Apologize for sending previous mail from a wrong app (not text mode).
Resending to keep the mailing list thread consistent.

On Wed, Jul 26, 2023 at 3:10 AM Markus Elfring <Markus.Elfring@web.de>
wrote:
>
> > Tests BPF redirect at the lwt xmit hook to ensure error handling are
> > safe, i.e. won't panic the kernel.
>
> Are imperative change descriptions still preferred?


Hi Markus,

   I think you linked this to me yesterday that it should be described
imperatively:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst?h=v6.5-rc3#n155


>
> See also:
>
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst?h=v6.5-rc3#n94
>

I don’t follow the purpose of this reference. This points to user impact
but this is a selftest, so I don’t see any user impact here. Or is there
anything I missed?


>
> Can remaining wording weaknesses be adjusted accordingly?


I am not following this question . Can you be more specific or provide an
example?

Yan


>
> Regards,
> Markus
>
