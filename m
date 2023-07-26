Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B173676376C
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Jul 2023 15:22:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233943AbjGZNWb (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 26 Jul 2023 09:22:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233850AbjGZNW3 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 26 Jul 2023 09:22:29 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ACA62709
        for <linux-kselftest@vger.kernel.org>; Wed, 26 Jul 2023 06:22:25 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id 2adb3069b0e04-4fe05fbe250so2991083e87.0
        for <linux-kselftest@vger.kernel.org>; Wed, 26 Jul 2023 06:22:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690377744; x=1690982544;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RNBj29jr4jl10Xi2/aZroQsmuwBmNBwOZzK39VygtuU=;
        b=ZR7ItMsoA1A/Nf0sOAsNBK3BvkceyjN/sL6fBQtaSZAld48YYK29eLHJpLbOmYcO4N
         dYwufolsoOqxG66gXyatccol9XCFhslUJtN1fSKS7Ig5Kau5SMVFE7RX4yg5Rr4WodvW
         KGP5UDr+Anz0VQpD54p7Qveowg/GfBiANDGM4tvbiskCVcrN2Ayh2uU5VmTDPv4ac5wh
         wcczHEKlYM7+fs6dv2GFmLWJlAaieMsDTw3DWr/Yz6IprmyjYryQs6+CCKCZy1hgZmch
         9OcYz90i81pg25VCT++Zf0XNmTEBd2fezyDACkORNjUdmjCl6szBneV8zsIq5EvQsgSr
         1QLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690377744; x=1690982544;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RNBj29jr4jl10Xi2/aZroQsmuwBmNBwOZzK39VygtuU=;
        b=Bw9JUWnpR9dP4F25IHvDnHZ7LnV39Ere95QvMlLng8wOLwE5VFL8cZXQZ/MHWngoDV
         C7a3Y4ZQnBzft1GMaDs1LBl9Pi9ZZFDPJPJhwYijMn/FRioi1b3ZD4BJOlt2VrozMSYV
         WZ+bQ/ywi9fmxxPpsJSTWpVDQE4qccz1WZpklRilcV8kFDsJ11e2RW4kj/9ueMDLwnU3
         ehV/jpyyjb93KC4PT8f9Wobrk7O1C/Zim7oMwTmmzzA5lReMlQdL14zK4nfnA2omxu4V
         DvnE9oqyqQXGoBoLyBigRhV8LvXriMODIQDFwuFIwgd6oNjE+N/axseq3fpFA5+HzhOI
         Tbig==
X-Gm-Message-State: ABy/qLYlICt2++uLzr+OBf+qWUKE6dJ+4JkF7mcObxkkbqSo7ulVudcV
        Ol9oBz2rLHwFBqx/hDoS3FYVPQ==
X-Google-Smtp-Source: APBJJlFMUTV8xO+xbHIIv/bIIICqq09UIEpnnxDWYTvm3DUYUWAby+Rd3s59OPhDm1XNqeKodSv6yA==
X-Received: by 2002:a2e:9805:0:b0:2b6:fe55:7318 with SMTP id a5-20020a2e9805000000b002b6fe557318mr1472225ljj.12.1690377743727;
        Wed, 26 Jul 2023 06:22:23 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id y7-20020a1c4b07000000b003fc0505be19sm1939327wma.37.2023.07.26.06.22.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jul 2023 06:22:23 -0700 (PDT)
Date:   Wed, 26 Jul 2023 16:22:20 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     Yan Zhai <yan@cloudflare.com>
Cc:     Markus Elfring <Markus.Elfring@web.de>,
        Alexei Starovoitov <ast@kernel.org>,
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
Message-ID: <b0a4c52b-427d-462f-93a9-d94a294cedcf@kadam.mountain>
References: <cover.1690332693.git.yan@cloudflare.com>
 <9c4896b109a39c3fa088844addaa1737a84bbbb5.1690332693.git.yan@cloudflare.com>
 <3ec61192-c65c-62cc-d073-d6111b08e690@web.de>
 <CAO3-PbraNcfQnqHUG_992vssuA795RxtexYsMdEo=k9zp-XHog@mail.gmail.com>
 <ZMD1sFTW8SFiex+x@debian.debian>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZMD1sFTW8SFiex+x@debian.debian>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Was Markus unbanned from vger?  How are we recieving these emails?

regards,
dan carpenter

