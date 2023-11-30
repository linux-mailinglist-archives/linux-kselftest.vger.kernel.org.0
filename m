Return-Path: <linux-kselftest+bounces-923-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E69477FFF8F
	for <lists+linux-kselftest@lfdr.de>; Fri,  1 Dec 2023 00:38:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7563BB20EF0
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 Nov 2023 23:38:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83CFB5954A;
	Thu, 30 Nov 2023 23:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="DqR0Teck"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ED5510F3
	for <linux-kselftest@vger.kernel.org>; Thu, 30 Nov 2023 15:38:44 -0800 (PST)
Received: by mail-io1-xd2a.google.com with SMTP id ca18e2360f4ac-7b359dad0e7so18700939f.0
        for <linux-kselftest@vger.kernel.org>; Thu, 30 Nov 2023 15:38:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1701387524; x=1701992324; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=B8VSO3h3YSEqNeVJ9Fi67nw8jeBYbkM3BVJqSu9EWHk=;
        b=DqR0TeckTPH0f/xMcGeWS4IKoZaabx6L4jisrC9MW3J44g1ChAieZOWI8HNHUO2sNU
         ka+h21TdBDLx5ILIEyuke1ohSusAkQYjJ/pegmu3lJlY4l1+n9XCIVE5cEZnrnTvllo6
         qYWtTuYq/3Ie3VHgbpskXgXxWrKWHfyi5gm/w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701387524; x=1701992324;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=B8VSO3h3YSEqNeVJ9Fi67nw8jeBYbkM3BVJqSu9EWHk=;
        b=ikJhPNa0tjWWk5Gn8k1s//tJTc6kLrHK1oGJwvq1X93uv3zpb8fMCldKDT9RKn8uEc
         iG8jCmKqkCHGa/Ri1p/eFF8n128JzvkjFl4Vf1JRCVeTXxaF1Vurgp2fmbBa4umUrUM5
         t//WcUoDXwaKNhJyL4Peesl02n/TUXY/op1lwA6QhMpaZqCGIveFtFD+edB8MAN/O+wB
         B6qcNrj7IXZm8O94BZu5KEFOvrY92aGyT8mE1DlvLtxdo1SvwxB9Ao207Z/bTxD0H7dB
         +bWHLcmTcKTB6x7ncnCtFHkLh8R0F6Yb+aFEeqMJTGsbJv9RLl8NEGFc4p362hjh8Nea
         siTw==
X-Gm-Message-State: AOJu0Yz5DbB8OEbMlGHYjcbFM/b8aFLsmC0hm3TElmBmI4BAzIA2Int5
	aPuFO3gy2LOdmQJsB5nQ+SO4+/ujrm3kJF7A8ac=
X-Google-Smtp-Source: AGHT+IEYVFgFuCQ9/iSPvBP7ggc5G0uFd8cYcDJdySji0vrzDvhBu7qkO3oqJyFU8Fbgj1HNp1WU4w==
X-Received: by 2002:a6b:6915:0:b0:7b0:aea8:2643 with SMTP id e21-20020a6b6915000000b007b0aea82643mr3960976ioc.1.1701387523699;
        Thu, 30 Nov 2023 15:38:43 -0800 (PST)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id ft18-20020a056638661200b004667eb7fd91sm565078jab.101.2023.11.30.15.38.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Nov 2023 15:38:43 -0800 (PST)
Message-ID: <7900802c-3860-4a52-aede-edc544461a57@linuxfoundation.org>
Date: Thu, 30 Nov 2023 16:38:42 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] selftests: capabilities: namespace create varies for
 root and normal user
Content-Language: en-US
To: Swarup Laxman Kotiaklapudi <swarupkotikalapudi@gmail.com>,
 shuah@kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 linux-kernel-mentees@lists.linuxfoundation.org, luto@kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <ZU+xkpH09xjzO5IS@swarup-virtual-machine>
 <20231111173806.16775-1-swarupkotikalapudi@gmail.com>
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20231111173806.16775-1-swarupkotikalapudi@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/11/23 10:38, Swarup Laxman Kotiaklapudi wrote:
> This patchset fixes TODO:
> "If we're already root, we could skip creating the userns."
> 
> Change namespace creation for root and non-root
> user differently in create_and_enter_ns() function
> in this file:
> tools/testing/selftests/capabilities/test_execve.c
> 
> Test result with root user:
> $sudo make  TARGETS="capabilities" kselftest
>   ...
>   TAP version 13
>   1..1
>   timeout set to 45
>   selftests: capabilities: test_execve
>   TAP version 13
>   1..12
>   [RUN]       +++ Tests with uid == 0 +++
>   [NOTE]      Using global UIDs for tests
>   [RUN]       Root => ep
>   ...
>   ok 12 Passed
>   Totals: pass:12 fail:0 xfail:0 xpass:0 skip:0 error:0
>   ==================================================
>   TAP version 13
>   1..9
>   [RUN]       +++ Tests with uid != 0 +++
>   [NOTE]      Using global UIDs for tests
>   [RUN]       Non-root => no caps
>   ...
>   ok 9 Passed
>   Totals: pass:9 fail:0 xfail:0 xpass:0 skip:0 error:0
> 
> Test result without root or normal user:
> $make  TARGETS="capabilities" kselftest
>   ...
>   timeout set to 45
>   selftests: capabilities: test_execve
>   TAP version 13
>   1..12
>   [RUN]       +++ Tests with uid == 0 +++
>   [NOTE]      Using a user namespace for tests
>   [RUN]       Root => ep
>   validate_cap:: Capabilities after execve were correct
>   ok 1 Passed
>   Check cap_ambient manipulation rules
>   ok 2 PR_CAP_AMBIENT_RAISE failed on non-inheritable cap
>   ok 3 PR_CAP_AMBIENT_RAISE failed on non-permitted cap
>   ok 4 PR_CAP_AMBIENT_RAISE worked
>   ok 5 Basic manipulation appears to work
>   [RUN]       Root +i => eip
>   validate_cap:: Capabilities after execve were correct
>   ok 6 Passed
>   [RUN]       UID 0 +ia => eipa
>   validate_cap:: Capabilities after execve were correct
>   ok 7 Passed
>   ok 8 # SKIP SUID/SGID tests (needs privilege)
>   Planned tests != run tests (12 != 8)
>   Totals: pass:7 fail:0 xfail:0 xpass:0 skip:1 error:0
>   ==================================================
>   TAP version 13
>   1..9
>   [RUN]       +++ Tests with uid != 0 +++
>   [NOTE]      Using a user namespace for tests
>   [RUN]       Non-root => no caps
>   validate_cap:: Capabilities after execve were correct
>   ok 1 Passed
>   Check cap_ambient manipulation rules
>   ok 2 PR_CAP_AMBIENT_RAISE failed on non-inheritable cap
>   ok 3 PR_CAP_AMBIENT_RAISE failed on non-permitted cap
>   ok 4 PR_CAP_AMBIENT_RAISE worked
>   ok 5 Basic manipulation appears to work
>   [RUN]       Non-root +i => i
>   validate_cap:: Capabilities after execve were correct
>   ok 6 Passed
>   [RUN]       UID 1 +ia => eipa
>   validate_cap:: Capabilities after execve were correct
>   ok 7 Passed
>   ok 8 # SKIP SUID/SGID tests (needs privilege)
>   Planned tests != run tests (9 != 8)
>   Totals: pass:7 fail:0 xfail:0 xpass:0 skip:1 error:0
> 
> Signed-off-by: Swarup Laxman Kotiaklapudi <swarupkotikalapudi@gmail.com>
> ---
> 
> Changes in V2:
>   - Change the commit message explaining
>     why this patchset is needed.
> 

Applied to linux-kselftest next for Linux 6.8-rc1

thanks,
-- Shuah


