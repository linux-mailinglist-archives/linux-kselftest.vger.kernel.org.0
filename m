Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 176F17D7B89
	for <lists+linux-kselftest@lfdr.de>; Thu, 26 Oct 2023 06:37:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229638AbjJZEhv (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 26 Oct 2023 00:37:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbjJZEhu (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 26 Oct 2023 00:37:50 -0400
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BFD1186;
        Wed, 25 Oct 2023 21:37:48 -0700 (PDT)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-5a7c08b7744so3541747b3.3;
        Wed, 25 Oct 2023 21:37:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698295067; x=1698899867; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VQfPVTlNxNs5d5jXM9r1QgUiEU5LPOzadsgQUw42pws=;
        b=SrmRGDX76S4eqY/cRYUq+j0/xYZNR5I4a2AO2d8Nt82dr03fAaYE0BtVYIWvNlHZ5o
         xpBKmAH3HR21DPQwEAy0WcwO95GSoQYBGqlwUiyiJqL2+3qpewWfuBDqrjeC6xf9o5Jo
         cL+HIRcF1hqvNwQhG11AMZP0oKrOZs3iIzSaCb/KXYVcvmVa8q+qSm008JLBcI7OZEX4
         1+BAt5uDD25sUsWeSbcI8fwiOnDok6oNPM+OD5i5kfmFi/5nnEugTq4w4w+9AjPw1/pM
         tMpQhMvn0UPLVyNyUygAE/7ST3szUVVVgzkYRU+Fz9DDU3lri7w9wzSdehXqddQ7oWPV
         YhvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698295067; x=1698899867;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VQfPVTlNxNs5d5jXM9r1QgUiEU5LPOzadsgQUw42pws=;
        b=Ds1B2GpeO5vF9S/JaNDg0CEhKOhHFxUEcbpLINd8+HKeQMRGN4Y3IUpV8lE96Z7nsm
         aJXZlTRs77c86e8ih5NqhyhnxWCyz26e9+18/vb3L1XXGMjscOm+cQrvs/0LDWImbcNi
         55N6BzZvoWqhC8MaI9F4OXguWcSMxTsRfyq5rChOqPoERMS5+fLsSxDguUun/6yowBOB
         uD1zMily4Rsc+ySMpzsifiGmwFknTQY5WtJi3z/I8Fbq7p8dN4sMvMy5EL2Bzel2H7Oe
         d4VBvnSBhlboeWXm8sgPxacrWsnbyAaQdSb9WYlx21hZxc5rY6+PuuhVsAfXTSAJL2Jr
         JLZw==
X-Gm-Message-State: AOJu0Ywfuv/n1/Gvy0D4j14jCTPvbcGf4wfhYQgXl2yNgvR0CXvAa8ic
        Z1PUHFdKoeo6UYcW1Vkvrx0=
X-Google-Smtp-Source: AGHT+IHt52HN0V+3DlJVOcSRacrk5PEgPDnXA6DtClm+Xq2Pw2+zSIqHBsRMDI/5qnu5klMYdQnj0A==
X-Received: by 2002:a0d:d810:0:b0:5a7:cfdc:d7b1 with SMTP id a16-20020a0dd810000000b005a7cfdcd7b1mr19298114ywe.4.1698295067160;
        Wed, 25 Oct 2023 21:37:47 -0700 (PDT)
Received: from ?IPV6:2600:1700:6cf8:1240:8355:61d5:b55:33e7? ([2600:1700:6cf8:1240:8355:61d5:b55:33e7])
        by smtp.gmail.com with ESMTPSA id s13-20020a81bf4d000000b005a7fbac4ff0sm5638687ywk.110.2023.10.25.21.37.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Oct 2023 21:37:46 -0700 (PDT)
Message-ID: <563d1ae7-8d1f-48d5-b742-989ce482c4f1@gmail.com>
Date:   Wed, 25 Oct 2023 21:37:44 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v2 0/2] selftests/bpf: Replaces CHECK macros and
 adds malloc failure checks to bpf_iter
Content-Language: en-US
To:     Yuran Pereira <yuran.pereira@hotmail.com>, bpf@vger.kernel.org,
        yonghong.song@linux.dev
Cc:     shuah@kernel.org, ast@kernel.org, daniel@iogearbox.net,
        song@kernel.org, john.fastabend@gmail.com, kpsingh@kernel.org,
        sdf@google.com, haoluo@google.com, jolsa@kernel.org,
        mykolal@fb.com, brauner@kernel.org, iii@linux.ibm.com,
        kuifeng@meta.com, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <DB3PR10MB6835598B901975BEAEBA8601E8DDA@DB3PR10MB6835.EURPRD10.PROD.OUTLOOK.COM>
From:   Kui-Feng Lee <sinquersw@gmail.com>
In-Reply-To: <DB3PR10MB6835598B901975BEAEBA8601E8DDA@DB3PR10MB6835.EURPRD10.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org



On 10/25/23 19:03, Yuran Pereira wrote:
> This patch series contains the following updates:
> - Replaces the usage of all the CHECK macros in bpf_iter
>    to the appropriate ASSERT_* macro calls
> - Adds appropriate malloc failure checks to bpf_iter
> 
> Changes in v2:
> - Removed unused "duration" variable which caused compilation error
>    as reported by Yonghong Song [1]
> - Improved malloc failure handling as suggested by Kui-Feng Lee [2]
> - Ensured propper patch formatting (i.e. sending it as a set instead
>    of two distinct patches)
> 
> [1] https://lore.kernel.org/lkml/3531360b-c933-4c5f-a84c-17edf0592519@linux.dev/
> [2] https://lore.kernel.org/lkml/7d703c4c-1a24-4806-a483-c02efb666059@gmail.com
> 
> 
> Previous version:
> v1 - https://lore.kernel.org/lkml/DB3PR10MB683589A5F705C6CA5BE0D325E8DFA@DB3PR10MB6835.EURPRD10.PROD.OUTLOOK.COM
>     - https://lore.kernel.org/lkml/DB3PR10MB68356D7CDF6005480BE5876CE8DEA@DB3PR10MB6835.EURPRD10.PROD.OUTLOOK.COM
> 
> Yuran Pereira (2):
>    selftests/bpf: Convert CHECK macros to ASSERT_* macros in bpf_iter
>    selftests/bpf: Add malloc failure checks in bpf_iter
> 
>   .../selftests/bpf/prog_tests/bpf_iter.c       | 88 +++++++++----------
>   1 file changed, 44 insertions(+), 44 deletions(-)
> 


For the cover letter, you can just put it at the same directory of
patch 1 and 2 and sent them with "git send-email" at once. All of them
will be in the same thread.

"git format-patch --cover-letter ..." will generate a template
of the cover letter along with patches. FYI

