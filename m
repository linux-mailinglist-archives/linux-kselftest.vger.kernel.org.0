Return-Path: <linux-kselftest+bounces-6-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE9617E7F37
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 Nov 2023 18:50:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5DEBDB21444
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 Nov 2023 17:50:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39DF83E480;
	Fri, 10 Nov 2023 17:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XHLE6t+M"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D3983D381
	for <linux-kselftest@vger.kernel.org>; Fri, 10 Nov 2023 17:47:08 +0000 (UTC)
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA65C3B33B;
	Fri, 10 Nov 2023 07:55:46 -0800 (PST)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-6bd73395bceso1769256b3a.0;
        Fri, 10 Nov 2023 07:55:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699631746; x=1700236546; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0hQpJxp9DF4eyRc/ch/UIeElSypMS9XnoOaUJNz1J1U=;
        b=XHLE6t+M2+D8w3TOUi9SWY2NLDxyWsPHCYNSN+roDKFy4XEHWKUHWFv0pY9tiOz+Oq
         bRAXcAfAEaOLCRp/3f4JEG/2MJn45U0BOA6nyiOJzKdaSKULbsge9oYghFwEwHOHZ9gT
         tGsDkNTHvDe4+yC1YHaLFAngxr6x3T1Iq8j+a85jH4m3Mt85lwWt0870wOlhK4rTUlzR
         /K3fEcOJCT9FbqjZMFK2Db0Jq4bu18I0DVcaamyG/P14hwCbqUH9j2vAl39/DrrKEIOh
         hEPQLRPRe9HEvuQPrJPpSG8a0CBVxrySTjGjkVK0DlNZxeKcC8FKtrnppazpts1NBkmR
         rg2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699631746; x=1700236546;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0hQpJxp9DF4eyRc/ch/UIeElSypMS9XnoOaUJNz1J1U=;
        b=FzT+uUWwIMcjQNQbCy+ejrgtB0YjSFyWlGzb3rROUeabCRwv4X4p6USZs4Gt8a9Brd
         6Q/WYnTKkvDObLbszCiCYw1KFwn1+U2m4vgqSY6D3cY1LrmVKD+2yp4ssHNhxll0SLPp
         udCf0O1qMkmaX/DfAhWVmUbCvLUOSsKZgnLlvtTlWGGzknZwSOrhJ8p3HRqRuIbdYD7C
         ZKJCsVTOnY7ERmEFjsUEzQePPoFJbFFx9SJrQLJUcXFd6iZCdRAzRY5eo7XCCdaQImAq
         E/F0ATOD12mp8W4/Og8a0ZHvCiFl1ooJUw802S63PNJTzjSCfCxg5gt51dvgmik5CEIR
         +Yfw==
X-Gm-Message-State: AOJu0Yy5+X1qBPYUPa7DNYbWr7A1EbtOo60aBuLNnl458/Kms6DV95Op
	kU6W/0dR4p6WTuP8VttWuHk=
X-Google-Smtp-Source: AGHT+IGZ25+uHRtQ7w5WCbg2qbxUcLUTPGZHlb+SPw9P4RSTT5Nu2aOh773OzarpXIKuuUZa2COi8w==
X-Received: by 2002:a05:6a00:1791:b0:68c:44ed:fb6 with SMTP id s17-20020a056a00179100b0068c44ed0fb6mr4571581pfg.16.1699631746246;
        Fri, 10 Nov 2023 07:55:46 -0800 (PST)
Received: from [192.168.54.90] (static.220.238.itcsa.net. [190.15.220.238])
        by smtp.gmail.com with ESMTPSA id c11-20020a056a00248b00b006bda45671b1sm1483951pfv.101.2023.11.10.07.55.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Nov 2023 07:55:45 -0800 (PST)
Message-ID: <275e1430-6e10-42a1-9afd-051f5584a17d@gmail.com>
Date: Fri, 10 Nov 2023 12:55:41 -0300
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Kunit to check the longest symbol length
Content-Language: en-US
To: =?UTF-8?Q?Sergio_Gonz=C3=A1lez_Collado?= <sergio.collado@gmail.com>,
 Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
 Wedson Almeida Filho <wedsonaf@gmail.com>,
 Brendan Higgins <brendan.higgins@linux.dev>, David Gow
 <davidgow@google.com>, linux-kselftest@vger.kernel.org,
 kunit-dev@googlegroups.com
Cc: Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <benno.lossin@proton.me>,
 Andreas Hindborg <a.hindborg@samsung.com>, Alice Ryhl
 <aliceryhl@google.com>, rust-for-linux@vger.kernel.org
References: <20231105184010.49194-1-sergio.collado@gmail.com>
From: Martin Rodriguez Reboredo <yakoyoku@gmail.com>
In-Reply-To: <20231105184010.49194-1-sergio.collado@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 11/5/23 15:40, Sergio González Collado wrote:
> [...]
> diff --git a/lib/Makefile b/lib/Makefile
> index 740109b6e2c8..82ac084b6bc6 100644
> --- a/lib/Makefile
> +++ b/lib/Makefile
> @@ -402,6 +402,7 @@ obj-$(CONFIG_FORTIFY_KUNIT_TEST) += fortify_kunit.o
>   obj-$(CONFIG_STRCAT_KUNIT_TEST) += strcat_kunit.o
>   obj-$(CONFIG_STRSCPY_KUNIT_TEST) += strscpy_kunit.o
>   obj-$(CONFIG_SIPHASH_KUNIT_TEST) += siphash_kunit.o
> +obj-$(CONFIG_LONGEST_SYM_KUNIT_TEST) += longest_symbol_kunit.o
>   
>   obj-$(CONFIG_GENERIC_LIB_DEVMEM_IS_ALLOWED) += devmem_is_allowed.o
>   

This test is triggering `-Wmissing-prototypes`, so you might have to
either add the prototypes or change the hunk to this.

diff --git a/lib/Makefile b/lib/Makefile
index 740109b6e2c8..b9d2577fbbe1 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -402,6 +402,8 @@ obj-$(CONFIG_FORTIFY_KUNIT_TEST) += fortify_kunit.o
  obj-$(CONFIG_STRCAT_KUNIT_TEST) += strcat_kunit.o
  obj-$(CONFIG_STRSCPY_KUNIT_TEST) += strscpy_kunit.o
  obj-$(CONFIG_SIPHASH_KUNIT_TEST) += siphash_kunit.o
+obj-$(CONFIG_LONGEST_SYM_KUNIT_TEST) += longest_symbol_kunit.o
+CFLAGS_longest_symbol_kunit.o += $(call cc-disable-warning, missing-prototypes)
  
  obj-$(CONFIG_GENERIC_LIB_DEVMEM_IS_ALLOWED) += devmem_is_allowed.o
  

> diff --git a/lib/longest_symbol_kunit.c b/lib/longest_symbol_kunit.c
> new file mode 100644
> index 000000000000..6282fbb7e991
> --- /dev/null
> +++ b/lib/longest_symbol_kunit.c
> [...]
> +
> +noinline int LONGEST_SYM_NAME(void)
> +{
> +	return RETURN_LONGEST_SYM;
> +}
> +
> +noinline int LONGEST_SYM_NAME_PLUS1(void)
> +{
> +	return RETURN_LONGEST_SYM_PLUS1;
> +}

arch/x86/tools/insn_decoder_test.c has a buffer size of 256 that might be
too short for these symbols, you might have to increase it for it to work.

> [...]

